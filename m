Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23A2C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39b-0001fC-PJ; Sun, 28 Jun 2026 23:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39W-0001eO-Vp
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39V-0006Hz-EY
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:22 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2cfEx1503809
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=; b=mv
 4FmcivuRIyG+VowobKoR+whguNR8i6LDkIi5p0nH3RuSPCiW6Mb9ZP1ITOe8LN7i
 rsvgrlWgZ1DhFiZwatFhkuqCKa6hXvya0kKFpk6e0DmVJPd2VHijXBlE3VyRLFiQ
 lkjgPhiCVwlS1FXNCBMnBkQC6/evlSSwzjl790cbnY0xuXKt8qy/o8LJS0hwTVYK
 sAHDDLfduCqQXAP0rpruTvXl10ddrIXaYEmnbpUFzVLZDpXP++y7vTeZYCy1X0qA
 30OLWsRBX731WO4vIn30XwzFltx5KLcrBR85xwoPXAgY2J2DQx/kJvpfmlBoJ+XY
 zM5dBxrCFg+PtpJpWoIw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7v82e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:19 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383723dfddso4473609c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705559; x=1783310359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=;
 b=SbNLOvCvqhydCvq+KGhwApI2imnigtVnwO3sITPxIfaGd1mUtDTIYEbFcz603VDPUc
 i0rJV6cHtgueEQlVpLvqnN0ZXte0CI66Ab2SjcaxeTBUIf3sGIG+paIXdQAdlQ/fu7wt
 6/8Skck8GC0P3KPMlosMgxfmA6kEgr5DAVO1tV0nIQiLdT/OGqwA4BRIVv/uHl/yPgOq
 7SvRneDewP1SjtcHoDisfcu7cl5V4kIArXWTFVtuJj0BlMQiuzYGm0KloXXcfniZAqOY
 bzvL+O7LOiXEL405mIso05d+rAn/nrIPeGM0H835IPXbUIXptT/VE4LJcP9GH1ZU02u6
 A9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705559; x=1783310359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=;
 b=CyZT+33KKGET9dluxdL1F/bTTkoNOWyoMnEl00ALXNwKQXbFuUNai/rgpejHlsTijA
 21PfPO6q9N4d5IxUbw/RHDmF7TE2KSv1djpmmhcBhRmQzSmP3SiZRjk/6qVJl0JRsksU
 NALtU/i77Tf/lmzCX1XjKZBhZPHKeX5BgiuCE0aBc/LUH6P+Nhycf4K27IJzl+0Fd1eN
 HhgPLUa2uABvAkw8vhW2pnc7hD+DoTA4fKrWyFVHkavzb4L/7oVZ6dEW/KGoSLm2sppd
 AY4+ZnYm0bHv0qoi+lGgY1b8S7BQp4KX5Y/JYeFha+s5pKPqYu7oihxfkv3NuxPwS/as
 7WOg==
X-Gm-Message-State: AOJu0YzRc/dr/JJ+mePXCKPm/P2AuC1ZkePwxE/CE/zN5ZXk3EJ3bl/r
 GJLAsGRiGeCjBD508SmL+/s41gBfa5Ddm+fbOnRRzqDJw9zQ1yyIWnF5IPBpePFIkuAZQJixJ0f
 ZM/D8Aj+B4v3jHilPfi0F6XJdt8cqsJw44m0dDFhNE6Zt4tZN5BJQE936GpWQ/fqytA==
X-Gm-Gg: AfdE7cnt7/qRMXY+vCHU31J43wkNRvg8rTeagTvgdVkQMdjVxbznSNNLOLixTLfwIaV
 vj1n0VvNl3qXPQOjEcupb9880M26EogeI6FuYSAa+sawSN1KvnfbHHQENleT5xM7b/MHDfwc8/9
 qigBt8wlNeVUQBQze+8hv/v4eP6N/gY68y6s8VuczTs6+PVqHGoy2iJdXSYMT96RvizAZWDl8qI
 AWOC6iB0vWQ/qsC5QyCK1qlacD1Fsb5ykJakv+FgVKxMrnaE3Pb49uLORiEbAy0i8mMQkpzRAdT
 3TOAHB3ZIL4eLoRsXEXXAVD5VaBrR8ha8aB/zMXPTVV+JgOGcGq5dQy+nIPiTmuyEZlTNa3Ycya
 Zr4JY0ViKMZ0k6t2OyPNTAuvIn0x8UA+xarNiAVu7wWZLU+6hhaiC9h/vgZE=
X-Received: by 2002:a05:7022:117:b0:137:f958:c072 with SMTP id
 a92af1059eb24-139dbac82b2mr12326264c88.20.1782705559293; 
 Sun, 28 Jun 2026 20:59:19 -0700 (PDT)
X-Received: by 2002:a05:7022:117:b0:137:f958:c072 with SMTP id
 a92af1059eb24-139dbac82b2mr12326256c88.20.1782705558833; 
 Sun, 28 Jun 2026 20:59:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 25/77] target/hexagon: Implement do_raise_exception()
Date: Sun, 28 Jun 2026 20:57:38 -0700
Message-Id: <20260629035830.1520296-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX/t0TcMolypb0
 KIkrP6AfrioAt82XlLyRtw5wB8nGSZLpAgA0oEykTvFBBw9aYywhlIZdI/Sj+EBcLdnGd4cEV3W
 tTtI/wqUcTAkSoBrW2UnHN9iuEDQgHIbNXi2paZv003YQBLRgmYgo2dECegxDpHZ8DEYelT6b1a
 NQvwUFpAKJjgKuXBaWGIrqsslkKVW7148LWxrRF5BbfYi8wt45c4QD6K3iPKuvhtdr659bNyDHL
 CgQBT0L+YIQnCs0nR1G29avzH4zrW+bjfSZnJoJtxhZuSSVw/E38EEgsplUP/CzyChn5fbfoK2C
 lwTY6ZfmKpzPRmkUq2FzTE30+N6t3YkCDeYlcttaUgnVN2U59CKNnbaYaf2WryxyMpbdYxM8LDe
 IjlZzjrClkmhkvcaXlzxmJ8d8QBM2TLacILur05Bx2/l1dmD5WtGjMJPg0YiqrWw7Ga3mqjPkBx
 qGn0mMFA0eUghy1pAOA==
X-Proofpoint-GUID: dO9nIB1SkLpZmOCq4w8MvvSZF7Mrh8rZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX9cPxZ35L8Zcg
 fR+mjt94ZXxG6rApOMrLr1dBjbo/zQC8tbjPWZEERpWwYyojjNz42TKuiZOoNTaO6qkvqwYAzQ9
 WVMJ6xe/Cso9xZaZX0u2z5lkpt85HMY=
X-Proofpoint-ORIG-GUID: dO9nIB1SkLpZmOCq4w8MvvSZF7Mrh8rZ
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a41ed97 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=hK29HtBGQMdOITfcgGsA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmggIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTQgKysr
KysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CmluZGV4IGNkMDZmZjQxZDRmLi4zM2Q3M2VkMThkMSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaW50ZXJuYWwuaAorKysgYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0zMSw2ICsz
MSwxMSBAQCB2b2lkIGhleGFnb25fZGVidWcoQ1BVSGV4YWdvblN0YXRlICplbnYpOwogCiBleHRl
cm4gY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RIUkVBRF9S
RUdTXTsKIAordm9pZCBHX05PUkVUVVJOIGRvX3JhaXNlX2V4Y2VwdGlvbihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwKKyAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLAorICAgICAgICB1aW50MzJfdCBQ
QywKKyAgICAgICAgdWludHB0cl90IHJldGFkZHIpOworCiAjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKIGV4dGVybiBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdTsK
ICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCBjZDMyNGMxOWE5ZC4uMGY0M2E2NjYzNDEgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC00MSw2ICs0MSwyMCBAQAogI2RlZmluZSBTRl9NQU5UQklUUyAgICAyMwog
CiAvKiBFeGNlcHRpb25zIHByb2Nlc3NpbmcgaGVscGVycyAqLworR19OT1JFVFVSTgordm9pZCBk
b19yYWlzZV9leGNlcHRpb24oQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGV4Y2VwdGlv
biwKKyAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IFBDLCB1aW50cHRyX3QgcmV0YWRk
cikKK3sKKyAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7CisgICAgcWVtdV9sb2dfbWFz
ayhDUFVfTE9HX0lOVCwgIiVzOiAweCUwOCIgUFJJeDMyICIsIEAgJTA4IiBQUkl4MzIgIlxuIiwK
KyAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBleGNlcHRpb24sIFBDKTsKKyAgICBBU1NFUlRf
RElSRUNUX1RPX0dVRVNUX1VOU0VUKGVudiwgZXhjZXB0aW9uKTsKKworICAgIGVudi0+Z3ByW0hF
WF9SRUdfUENdID0gUEM7CisgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IGV4Y2VwdGlvbjsKKyAg
ICBjcHVfbG9vcF9leGl0X3Jlc3RvcmUoY3MsIHJldGFkZHIpOworfQorCiBHX05PUkVUVVJOIHZv
aWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBleGNlcHRp
b24sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJf
dCBwYykKLS0gCjIuMzQuMQoK

