Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B83C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W4H-00060m-NH; Tue, 15 Sep 2026 12:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3k-0005v6-V7
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3i-0003no-Qg
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAXDM3419329
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d+11tnix2V/bt8ArMEcPhg4E6n1O2gIEaiQ5iZ3BXXI=; b=eWsVaOiHVzwYM52T
 tTY0BuWPYPa1IpgWfamJ4UUdy84AFRipYgWPn7+yLNsxHhC3K5nEWhDuAHsqlbbF
 UrM60U8ma9i+S2tzeefyFD5jKEDpXv790jl2H1GgP7zYDiPCN8IC9d4CnD6pyUtL
 RT1aBNP4YT7nM+6c3+XhqZQ2ryMXZJKQ+/7TccC3hM7mMpGKFgUJJnlk4PfhptP7
 Zml/+uE/CwiodvLCfBzQNxLAZy0lqYEXn59TmN7T2Gk4Qg/y5uGjfDHm4h+JWlvC
 rl9yUMbSccMg53utUG+4+q+SdK2rbvwG8lFl5M9YSihqwp2MHtDzW4ZZYz9fnIJo
 cw/Oqg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpye7317x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39deda201bcso3200503a91.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489860; x=1790094660; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d+11tnix2V/bt8ArMEcPhg4E6n1O2gIEaiQ5iZ3BXXI=;
 b=Epfa3sM9LfCmSgagoGZDlhG6JZ13aPANrHviPPJDmSK63gnf0aBH4IZ1GVkMG/gLxy
 CplesyuR8X5h8NaToYHXTVDW3WiM3wiw8P7o8XhDk56gbFk/uCmaoLWlNRLH4XXx9s4m
 +7h+yWo08z5cCJvJrHl2JZynCDwq9fX+9dzaMtUdoUqS+wlFRKGOTsU9SLUy3aJjvLiG
 ZBFsy/qSld/nVNs1yzH1GOW2pHnbeJ4d2usuvcDUSg+eEeT3LU6u7nuUe7viH5h0nma8
 GZgzhfjtJbQGeuBCCbGEKpihwMdNxrV7gvBPi/wPZPWLClrDXnJVV8391mfFaPdFsYrz
 CQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489860; x=1790094660;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d+11tnix2V/bt8ArMEcPhg4E6n1O2gIEaiQ5iZ3BXXI=;
 b=0zzR0+edUbK0RoCddUhvZFdUyrXVBn+97ulfj1sFqDW7OnZE6/UbuIXJznwULMKz5m
 Au2QFgYFdyr7V6397fluV3loScAHWf+JXVLAyB7PDLjQwZePJJjFPkC2XF97lLdFdbZz
 7SC54Ig2p87BE0+3jZg1+w2k3Q7YHxqGGZm16UtMcrkcllDrZa42hOU45g+FCxsHunwQ
 Vv+I0o7ovg++pVoNE6X0uvVGih0sZTiIuVvvfM8dCo07awKK/xmSVDCZjmoHa5nF6V+V
 ALlRR1olPGGYoVEQP1JXqSCHR5WTiFD1+9QVitRBq6E7WiW/9p2IJageu1h+KlOyYOyl
 Wnxg==
X-Gm-Message-State: AFuF++lVuXEDEcIas2lrwRy4ofA9gVpYiScw9SytS/xEOjUM2ETuVC0U
 e93BDoxkNksVPlvur2kohalkn/pc2FsS8+z+MYAIS0YIjMCRF95Mdk0ZV+/FPXm9/X3sR+jQ6R7
 oWN7FsCPxYprdxO7easYYPyYpcDetcE85VUs8xrd6EFT5S1wY+KCBwwfa05Qi3e+9bw==
X-Gm-Gg: AYBFou3WG5ixbgvihPYjimizUniEhfgJd2M4ig3MlERYwA4Irx5ycc9C1kt14MFzhDM
 0g6CFrddmtzo6CBs3rc6dcNbrqHlTU5yQEgkJBADjJf+lb9ieNycr7OTp8lQ9P0G3K2dQhqRvFw
 60MkLROvFAZ00u2cchYSbYMxQDN4/iIMBciGzs0OmBPpmXvkhDYTB3JfZC81iZMVu6oyJLRTrin
 nDT3ds5kKnTqm9RJku4/mzTQaKAypKu1orosJRgdeZ3Gh2WKpPTT9LYH95bTCrpfwZsv2sF1/A6
 MVSQvM0yBAJ3VtCHR1FcS/qT3QZDPN04ubw/jeAG3KJrvtbXjsjbjfUjLWZ2wXaf+dE339TKJJo
 4aXit4Z4t9YuQiH4Di3nXYpmCknNDRa1hROgAVJU+doqpm3D4
X-Received: by 2002:a17:90b:5806:b0:39d:f024:c7e2 with SMTP id
 98e67ed59e1d1-39df024c8d5mr14127990a91.4.1789489860445; 
 Tue, 15 Sep 2026 09:31:00 -0700 (PDT)
X-Received: by 2002:a17:90b:5806:b0:39d:f024:c7e2 with SMTP id
 98e67ed59e1d1-39df024c8d5mr14127939a91.4.1789489859979; 
 Tue, 15 Sep 2026 09:30:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:30:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 06/17] tests/tcg/hexagon: add FP classification, conversion,
 and fixup tests
Date: Tue, 15 Sep 2026 09:30:36 -0700
Message-Id: <20260915163047.4180600-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX/ZEGjtxlsDLa
 XyLJALB7j/1ckfrtvSSludDPC0izHYrwxRHFMbd+7xZevKtS4HzzWc6FEao1DVZPoOWY/bMifMH
 MOh7ZJMp897MwOU9wTzjbtuA1DPGdFOKXo44AB5ob5/M2GL39lq5smP3dw/8v0B7z2iE2xI/oBu
 ygDBaWJ8Ygf13O/7mvMJCZRwTHTw9W1a1D/rAz6w81Pfyh/JdVB7UppGW1J57REEnaWIscXlsxr
 2ChxcEkmXLHtDsku6SJy8RDHaNqcvMphEEudV1hw70nj2h0VjbN7dmdyvvFueIYsWURc2yAxqey
 iXqSAiE0BHmT5UpvJqwxtJdm8Qv79a9vQBh74fs4CG8d/cRWaK2cLBSinAH0WS6W/NqupbaRHfY
 GmFlNTcm/J9AmeWyaoOcTcpglPKKoKIfw9BhQv6nGA47i7sGFs+WhtAkfz9fS9wz15TmWePObMY
 w4Qp4ebQIj+Q33LVuyw==
X-Proofpoint-GUID: zpzA7PcQl86c_PrqphebvwNLeEl-LfgB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX1byGvrn4BzN/
 iIK0nD5xINll2axxKyiozYimAwoVrKuWVzROysCfWVcNhm8B8MHsNfNin+D749ESMZVJZ96ndOv
 qseYVvzmh0Gic+5Wm5WWdzlZh3Lx3Zk=
X-Authority-Analysis: v=2.4 cv=fck4WEQF c=1 sm=1 tr=0 ts=6aa972c5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=anSrM8_wVXE1bCkXRQoA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: zpzA7PcQl86c_PrqphebvwNLeEl-LfgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150239
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

QWRkIHNmY2xhc3MvZGZjbGFzcyBGUCBjbGFzc2lmaWNhdGlvbiB0ZXN0cywgdW5zaWduZWQtdG8t
ZG91YmxlCmNvbnZlcnNpb25zLCBhbmQgZGZtcHlmaXggZGVub3JtYWwgZml4dXAgdGVzdHMuCgpS
ZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNv
bW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jIHwgMTc1ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE3NSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jIGIvdGVzdHMvdGNn
L2hleGFnb24vZnBzdHVmZi5jCmluZGV4IDZhYWRhY2NhYmRmLi43NTYxZjMxY2RjMyAxMDA2NDQK
LS0tIGEvdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29u
L2Zwc3R1ZmYuYwpAQCAtNzExLDYgKzcxMSwxNzYgQEAgc3RhdGljIHZvaWQgY2hlY2tfZGZtcHl4
eCh2b2lkKQogICAgIGNoZWNrNjQocmVzNjQsIDB4N2ZlZmZmZmZmZmZmZmZmZlVMTCk7CiB9CiAK
Ky8qCisgKiBzZmNsYXNzIG1hc2sgYml0czoKKyAqICAgYml0IDA6IHBvc2l0aXZlL25lZ2F0aXZl
IHplcm8KKyAqICAgYml0IDE6IHBvc2l0aXZlL25lZ2F0aXZlIG5vcm1hbAorICogICBiaXQgMjog
cG9zaXRpdmUvbmVnYXRpdmUgZGVub3JtYWwKKyAqICAgYml0IDM6IHBvc2l0aXZlL25lZ2F0aXZl
IGluZmluaXR5CisgKiAgIGJpdCA0OiBwb3NpdGl2ZS9uZWdhdGl2ZSBOYU4KKyAqLworI2RlZmlu
ZSBURVNUX1NGQ0xBU1MoVkFMLCBNQVNLLCBFWFBFQ1QpIFwKKyAgICBkbyB7IFwKKyAgICAgICAg
dWludDMyX3QgcmVzOyBcCisgICAgICAgIGFzbSgiJVtyZXNdID0gIzBcblx0IiBcCisgICAgICAg
ICAgICAicDAgPSBzZmNsYXNzKCVbdmFsXSwgIyIgI01BU0sgIilcblx0IiBcCisgICAgICAgICAg
ICAiaWYgKHAwKSAlW3Jlc10gPSAjMVxuXHQiIFwKKyAgICAgICAgICAgIDogW3Jlc10gIj0mciIo
cmVzKSBcCisgICAgICAgICAgICA6IFt2YWxdICJyIihWQUwpIFwKKyAgICAgICAgICAgIDogInAw
Iik7IFwKKyAgICAgICAgY2hlY2szMihyZXMsIEVYUEVDVCk7IFwKKyAgICB9IHdoaWxlICgwKQor
CitzdGF0aWMgdm9pZCBjaGVja19zZmNsYXNzKHZvaWQpCit7CisgICAgLyogWmVybzogbWFzayBi
aXQgMCAqLworICAgIFRFU1RfU0ZDTEFTUyhTRl96ZXJvLCAweDAxLCAxKTsKKyAgICBURVNUX1NG
Q0xBU1MoU0ZfemVyb19uZWcsIDB4MDEsIDEpOworICAgIFRFU1RfU0ZDTEFTUyhTRl96ZXJvLCAw
eDAyLCAwKTsKKworICAgIC8qIE5vcm1hbDogbWFzayBiaXQgMSAqLworICAgIFRFU1RfU0ZDTEFT
UyhTRl9vbmUsIDB4MDIsIDEpOworICAgIFRFU1RfU0ZDTEFTUyhTRl9vbmUsIDB4MDEsIDApOwor
CisgICAgLyogRGVub3JtYWw6IG1hc2sgYml0IDIgKi8KKyAgICBURVNUX1NGQ0xBU1MoU0ZfZGVu
b3JtLCAweDA0LCAxKTsKKyAgICBURVNUX1NGQ0xBU1MoU0ZfZGVub3JtLCAweDAxLCAwKTsKKwor
ICAgIC8qIEluZmluaXR5OiBtYXNrIGJpdCAzICovCisgICAgVEVTVF9TRkNMQVNTKFNGX0lORiwg
MHgwOCwgMSk7CisgICAgVEVTVF9TRkNMQVNTKFNGX0lORiwgMHgwMSwgMCk7CisKKyAgICAvKiBO
YU46IG1hc2sgYml0IDQgKi8KKyAgICBURVNUX1NGQ0xBU1MoU0ZfUU5hTiwgMHgxMCwgMSk7Cisg
ICAgVEVTVF9TRkNMQVNTKFNGX1NOYU4sIDB4MTAsIDEpOworICAgIFRFU1RfU0ZDTEFTUyhTRl9R
TmFOLCAweDAxLCAwKTsKKworICAgIC8qIENvbWJpbmVkOiBhbnkgY2xhc3MgKGFsbCBiaXRzIHNl
dCkgKi8KKyAgICBURVNUX1NGQ0xBU1MoU0Zfb25lLCAweDFmLCAxKTsKK30KKworLyoKKyAqIGRm
Y2xhc3MgbWFzayBiaXRzIGFyZSB0aGUgc2FtZSBhcyBzZmNsYXNzLgorICovCitzdGF0aWMgY29u
c3QgdWludDY0X3QgREZfSU5GID0gMHg3ZmYwMDAwMDAwMDAwMDAwVUxMOworc3RhdGljIGNvbnN0
IHVpbnQ2NF90IERGX2Rlbm9ybSA9IDB4MDAwMDAwMDAwMDAwMDAwMVVMTDsKK3N0YXRpYyBjb25z
dCB1aW50NjRfdCBERl9uZWdfb25lID0gMHhiZmYwMDAwMDAwMDAwMDAwVUxMOworCisjZGVmaW5l
IFRFU1RfREZDTEFTUyhWQUwsIE1BU0ssIEVYUEVDVCkgXAorICAgIGRvIHsgXAorICAgICAgICB1
aW50MzJfdCByZXM7IFwKKyAgICAgICAgYXNtKCIlW3Jlc10gPSAjMFxuXHQiIFwKKyAgICAgICAg
ICAgICJwMCA9IGRmY2xhc3MoJVt2YWxdLCAjIiAjTUFTSyAiKVxuXHQiIFwKKyAgICAgICAgICAg
ICJpZiAocDApICVbcmVzXSA9ICMxXG5cdCIgXAorICAgICAgICAgICAgOiBbcmVzXSAiPSZyIihy
ZXMpIFwKKyAgICAgICAgICAgIDogW3ZhbF0gInIiKFZBTCkgXAorICAgICAgICAgICAgOiAicDAi
KTsgXAorICAgICAgICBjaGVjazMyKHJlcywgRVhQRUNUKTsgXAorICAgIH0gd2hpbGUgKDApCisK
K3N0YXRpYyB2b2lkIGNoZWNrX2RmY2xhc3Modm9pZCkKK3sKKyAgICAvKiBaZXJvOiBtYXNrIGJp
dCAwICovCisgICAgVEVTVF9ERkNMQVNTKERGX3plcm8sIDB4MDEsIDEpOworICAgIFRFU1RfREZD
TEFTUyhERl96ZXJvX25lZywgMHgwMSwgMSk7CisgICAgVEVTVF9ERkNMQVNTKERGX3plcm8sIDB4
MDIsIDApOworCisgICAgLyogTm9ybWFsOiBtYXNrIGJpdCAxICovCisgICAgVEVTVF9ERkNMQVNT
KERGX29uZSwgMHgwMiwgMSk7CisgICAgVEVTVF9ERkNMQVNTKERGX25lZ19vbmUsIDB4MDIsIDEp
OworICAgIFRFU1RfREZDTEFTUyhERl9vbmUsIDB4MDEsIDApOworCisgICAgLyogRGVub3JtYWw6
IG1hc2sgYml0IDIgKi8KKyAgICBURVNUX0RGQ0xBU1MoREZfZGVub3JtLCAweDA0LCAxKTsKKyAg
ICBURVNUX0RGQ0xBU1MoREZfZGVub3JtLCAweDAxLCAwKTsKKworICAgIC8qIEluZmluaXR5OiBt
YXNrIGJpdCAzICovCisgICAgVEVTVF9ERkNMQVNTKERGX0lORiwgMHgwOCwgMSk7CisgICAgVEVT
VF9ERkNMQVNTKERGX0lORiwgMHgwMSwgMCk7CisKKyAgICAvKiBOYU46IG1hc2sgYml0IDQgKi8K
KyAgICBURVNUX0RGQ0xBU1MoREZfUU5hTiwgMHgxMCwgMSk7CisgICAgVEVTVF9ERkNMQVNTKERG
X1NOYU4sIDB4MTAsIDEpOworICAgIFRFU1RfREZDTEFTUyhERl9RTmFOLCAweDAxLCAwKTsKK30K
KworLyogUmRkID0gY29udmVydF91dzJkZihScykgKi8KK3N0YXRpYyB1aW50NjRfdCBjb252X3V3
MmRmKHVpbnQzMl90IHZhbCkKK3sKKyAgICB1aW50NjRfdCByZXN1bHQ7CisKKyAgICBhc20oIiVb
cmVzXSA9IGNvbnZlcnRfdXcyZGYoJVt2YWxdKVxuXHQiCisgICAgICAgIDogW3Jlc10gIj1yIihy
ZXN1bHQpCisgICAgICAgIDogW3ZhbF0gInIiKHZhbCkpOworICAgIHJldHVybiByZXN1bHQ7Cit9
CisKK3N0YXRpYyB2b2lkIGNoZWNrX2NvbnZfdXcyZGYodm9pZCkKK3sKKyAgICBjaGVjazY0KGNv
bnZfdXcyZGYoMCksIERGX3plcm8pOworICAgIGNoZWNrNjQoY29udl91dzJkZigxKSwgREZfb25l
KTsKKyAgICAvKiAxMDAgLT4gMHg0MDU5MDAwMDAwMDAwMDAwICovCisgICAgY2hlY2s2NChjb252
X3V3MmRmKDEwMCksIDB4NDA1OTAwMDAwMDAwMDAwMFVMTCk7CisgICAgLyogMHhGRkZGRkZGRiAt
PiA0Mjk0OTY3Mjk1LjAgPSAweDQxRUZGRkZGRkZFMDAwMDAgKi8KKyAgICBjaGVjazY0KGNvbnZf
dXcyZGYoMHhGRkZGRkZGRiksIDB4NDFFRkZGRkZGRkUwMDAwMFVMTCk7Cit9CisKKy8qIFJkZCA9
IGNvbnZlcnRfdWQyZGYoUnNzKSAqLworc3RhdGljIHVpbnQ2NF90IGNvbnZfdWQyZGYodWludDY0
X3QgdmFsKQoreworICAgIHVpbnQ2NF90IHJlc3VsdDsKKworICAgIGFzbSgiJVtyZXNdID0gY29u
dmVydF91ZDJkZiglW3ZhbF0pXG5cdCIKKyAgICAgICAgOiBbcmVzXSAiPXIiKHJlc3VsdCkKKyAg
ICAgICAgOiBbdmFsXSAiciIodmFsKSk7CisgICAgcmV0dXJuIHJlc3VsdDsKK30KKworc3RhdGlj
IHZvaWQgY2hlY2tfY29udl91ZDJkZih2b2lkKQoreworICAgIGNoZWNrNjQoY29udl91ZDJkZigw
VUxMKSwgREZfemVybyk7CisgICAgY2hlY2s2NChjb252X3VkMmRmKDFVTEwpLCBERl9vbmUpOwor
ICAgIC8qIDEwMDAwMDAgLT4gMHg0MTJFODQ4MDAwMDAwMDAwICovCisgICAgY2hlY2s2NChjb252
X3VkMmRmKDEwMDAwMDBVTEwpLCAweDQxMkU4NDgwMDAwMDAwMDBVTEwpOworfQorCisvKiBSZGQg
PSBkZm1weWZpeChSc3MsUnR0KSAtLSBERiBtdWx0aXBseSBkZW5vcm1hbCBmaXh1cCAqLworc3Rh
dGljIHVpbnQ2NF90IGRvX2RmbXB5Zml4KHVpbnQ2NF90IGEsIHVpbnQ2NF90IGIpCit7CisgICAg
dWludDY0X3QgcmVzdWx0OworCisgICAgYXNtKCIlW3Jlc10gPSBkZm1weWZpeCglW2FdLCAlW2Jd
KVxuXHQiCisgICAgICAgIDogW3Jlc10gIj1yIihyZXN1bHQpCisgICAgICAgIDogW2FdICJyIihh
KSwgW2JdICJyIihiKSk7CisgICAgcmV0dXJuIHJlc3VsdDsKK30KKworc3RhdGljIHZvaWQgY2hl
Y2tfZGZtcHlmaXgodm9pZCkKK3sKKyAgICAvKgorICAgICAqIFdpdGggdHdvIG5vcm1hbCB2YWx1
ZXMgKG5laXRoZXIgZGVub3JtYWwsIGV4cHMgPCA1MTIpLAorICAgICAqIHRoZSByZXN1bHQgc2hv
dWxkIGJlIHRoZSBmaXJzdCBvcGVyYW5kIHVuY2hhbmdlZC4KKyAgICAgKi8KKyAgICBjaGVjazY0
KGRvX2RmbXB5Zml4KERGX29uZSwgREZfb25lKSwgREZfb25lKTsKKworICAgIC8qCisgICAgICog
Q2FzZTogYiBpcyBkZW5vcm1hbCBBTkQgYSBpcyBub3JtYWwgd2l0aCBleHAgPj0gNTEyLgorICAg
ICAqIGEgZ2V0cyBtdWx0aXBsaWVkIGJ5IDJeLTUyICgweDNjYjAwMDAwMDAwMDAwMDApLgorICAg
ICAqIGEgPSAxLjAsIHJlc3VsdCA9IDEuMCAqIDJeLTUyID0gMHgzY2IwMDAwMDAwMDAwMDAwCisg
ICAgICovCisgICAgY2hlY2s2NChkb19kZm1weWZpeChERl9vbmUsIERGX2Rlbm9ybSksIDB4M0NC
MDAwMDAwMDAwMDAwMFVMTCk7CisKKyAgICAvKgorICAgICAqIENhc2U6IGEgaXMgZGVub3JtYWwg
QU5EIGIgaXMgbm9ybWFsIHdpdGggZXhwID49IDUxMi4KKyAgICAgKiBhIGdldHMgbXVsdGlwbGll
ZCBieSAyXjUyICgweDQzMzAwMDAwMDAwMDAwMDApLgorICAgICAqIGEgPSBzbWFsbGVzdCBkZW5v
cm0gPSAyXi0xMDc0LCBiID0gMl41MTIgKGJpYXNlZCBleHAgMHg1ZmYpLgorICAgICAqIFJlc3Vs
dCA9IDJeLTEwNzQgKiAyXjUyID0gMl4tMTAyMiA9IHNtYWxsZXN0IG5vcm1hbAorICAgICAqICAg
ICAgICA9IDB4MDAxMDAwMDAwMDAwMDAwMAorICAgICAqLworICAgIGNoZWNrNjQoZG9fZGZtcHlm
aXgoREZfZGVub3JtLCAweDVGRjAwMDAwMDAwMDAwMDBVTEwpLAorICAgICAgICAgICAgMHgwMDEw
MDAwMDAwMDAwMDAwVUxMKTsKK30KKwogaW50IG1haW4oKQogewogICAgIGNoZWNrX2NvbXBhcmVf
ZXhjZXB0aW9uKCk7CkBAIC03MjUsNiArODk1LDExIEBAIGludCBtYWluKCkKICAgICBjaGVja19m
bG9hdDJpbnRfY29udnMoKTsKICAgICBjaGVja19mbG9hdF9jb25zdHMoKTsKICAgICBjaGVja19k
Zm1weXh4KCk7CisgICAgY2hlY2tfc2ZjbGFzcygpOworICAgIGNoZWNrX2RmY2xhc3MoKTsKKyAg
ICBjaGVja19jb252X3V3MmRmKCk7CisgICAgY2hlY2tfY29udl91ZDJkZigpOworICAgIGNoZWNr
X2RmbXB5Zml4KCk7CiAKICAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNTIik7CiAgICAgcmV0
dXJuIGVyciA/IDEgOiAwOwotLSAKMi4zNC4xCgo=

