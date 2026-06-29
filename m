Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44871C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBng-0004eN-Rh; Mon, 29 Jun 2026 09:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBne-0004dI-Qq
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnc-0003EN-Ot
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:22 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATSL62579625
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=; b=T5
 1VIIVv6jKW55w0i8eNodrEcBpDDaFCBlhB1vr5CikZQx7uVsDssOVurgtHTMMgda
 AOrhap67sfuAdc+XdhZ9fYstavobYRW5hgpP/cdtcm1HanCeDkRtejKSpL8JNs2e
 Civy9XLzoEGKVRUN+quA6XOpf+SQype6JwGK3Qq5bLjA3QClsUels/IXpQgTFChV
 bVGvFpn/Evcjr8ARqelhouYHM3JqcYv41C0ThxcWCsruo5kGkGNuSFvFycYBshG7
 ea2csnM3y8u41m6B2+5hA41MYTKPeuo5pBr5ZMEkJpEU60UQGULT8fnD9dZfRIUQ
 HJ9VC1hBiPoQJp5K/NNg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hfrj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:19 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139c6673856so5196847c88.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738799; x=1783343599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=;
 b=ULWNXk7gQ2BsxNQR3vvwgub/T9FySHYKgfuFvL8f7Wum7t5PAthwNZSjuH9KOCUcHP
 2aajVFHZrImBedZbD/sAjYx4XOE7xyMaUvHB/djP8pBWpzBgzpkOoCZh6OWnRZRG6xxG
 1H4SYDDyiZErHs2o52ElCKeiQ7hu6CG0ihTsMaTU27yv3cKkgj8acegXSzpFmNONZjkM
 HPmQBH+FEOVsmYip5JnW+PRcayXyHq1b3uHKxfKNotipmGf19a4QsTBMrayKU/2ToFmA
 LK0qhpvpqD96FIz2bd+b8tghSAvUtni9qnRipmATR4ThA9qiKoEp4Mqz2rwH1oL752wK
 S3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738799; x=1783343599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=;
 b=n2+8OEBLmCF/Ud1fRo1oxaBcbEGgbJiehmDqDvVI2cGgKEe92FuQ0U4+VYRJaz4tNT
 oyuYIQvk3TN/WOBFdo/Hbvn7SkYa3mB1UWQrlB3nj7RYTHvqxdDHOzVpR/oN3HkMUfQF
 n550vbF7eBrAiDjJ3MgGo1mmCCT/Kn16B2L5Gr7dMQu7WJa9saG+VdrugncnVKeoJwml
 rYa34Pd9ZeyyAU+uKYAiUn5hZS0eMUCe9YhXn9J3FA9zBDSjSiriXw11ISvlxff+IDhS
 QvV3t4pjsHVAOa5qJPFnHac54rIOFKKGiexpP5h/EyGBYLLo+Vdqtac01plnz+Gcq8tc
 SMJw==
X-Gm-Message-State: AOJu0YxidaErvmb+UAnhtdFmQDpqHQ8nMDH/yTv6drEPffexUYU89mFH
 Jnap8tw3xFyYhAY6slTEPnl5izjJkip4Ju5Oi5JhW/02XRUrkIH39inwu4SvsAjJ5I6eB5lk617
 n7Lze3r+y9vGjL7JWrAjJOzPrQcmt4bRDlosg2F0M/CcfT4aoJ0W5ntyqVw2CPppqzw==
X-Gm-Gg: AfdE7ckWIsNJjs8r6XLFwSZ1hj7sQmKc+eKstsXxb61+mgcmkTngo3TQ8ulEksQE9jA
 gwM65yJoH+26FysGCQAe6vHYdrnh7bJxLNS23jRKr8O8grTNcjZkhXOExS5xozaeNd+TM4XvriD
 dW16EAV4idb8Bf1+KnMQoTMGqMOZdYWCovL4fx8n0I5dIgtEB+HrGvHKUuIwqWWTw0rkJJ86hI8
 vkjn0uW/0oOT3rN9JuVSyZhoSXif/vuK8fIVytgi02csmXV6sw6oZaq7IVwUqN8FLQ+ZCIziqrp
 WlODlro9KmT69e9luCQ7r4Z6jwObD7rAn+vMQMUheb4ojjVL4289gPyu9RksWOaxeWtRq4BYz0j
 zGW7ZnXkRQmK9p1fZTGp82BsWrZxrflHJbhfQvsS8u0WMDLTzEIlCeOVqRdY=
X-Received: by 2002:a05:7022:1b02:b0:137:567:14c4 with SMTP id
 a92af1059eb24-139dbab9cf2mr12354362c88.29.1782738798665; 
 Mon, 29 Jun 2026 06:13:18 -0700 (PDT)
X-Received: by 2002:a05:7022:1b02:b0:137:567:14c4 with SMTP id
 a92af1059eb24-139dbab9cf2mr12354326c88.29.1782738798129; 
 Mon, 29 Jun 2026 06:13:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 25/77] target/hexagon: Implement do_raise_exception()
Date: Mon, 29 Jun 2026 06:11:40 -0700
Message-Id: <20260629131232.2487780-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX8vbm6A+b7t4/
 MsmN+Gxu2sAozKVU4dFeo0N0aNyn0s/aprNy920Vcka1lUvjzDTgCcIvZf7JpRrJHfRJp0H49D0
 TVrJJzN250U4pQVCR50jd9kBxEHHrv8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX+r4MpYvGxsHj
 Yd6AMwt7GpRv33PJBLH/rXPBf5G75FInMo+cCi7MSjavEbg6yvR6pfcMY//sBoAFdxWzQaWovlb
 CAeywqRIHONdBuCwCrOF+f0vm9LjU9vPitGFrqQ7o5xikZ+UE5+MwgA5DARtb8I5CPzdgTryQhu
 9k77+ZzPmTr2r3Jl8oDqtMsUoTg4s4x4YFTsZnR5aV5Y9jWfNMyn+Q8EinGjIkG0FnBk0NtIul9
 N0INNCzIUtSwDQ/V6FfYZeGHVqduGRCYCWQa5Ly7PdZmpaJD4cdU3SeNdoRSSec8ugR5tt7i0ub
 ghVSUTranf1ycA25SSQvOkBkdIaIP4zMw907eBcrd/aLHX132/nT/8l1PI2vqzfoj/IJoruyrzG
 gdf4cjtxXqVKLNA8YJzIIHRPCXYpPaKquxHrYdoda0NpQjqRh5uDhisTzVGiaw6OzwdKbr1k621
 LAbyk7qw4yYiocgFvGw==
X-Proofpoint-ORIG-GUID: _G18k6H0jyBI3Z0EtNglGkKUh9WJZj9P
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a426f6f cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=hK29HtBGQMdOITfcgGsA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _G18k6H0jyBI3Z0EtNglGkKUh9WJZj9P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

