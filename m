Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB9CCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5C6-0004SR-2w; Fri, 29 May 2026 17:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5C4-0004O8-LJ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5C1-0000TF-Dq
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:40 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2JbK1912271
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=lAf85VTKCRNOL8VWR6DSnLr4yR4IXWVDM6xyT5ZNd0Q=; b=jg
 Uef6vEwvkJCxodlj2KXah+KwTV0UYRBvXbgjAk6ZhCpbqHP2ee3kZNl3Fc9kwTSK
 +JrGVnF0/CZkMoP0oie7B07zLWjNY/HiuZXAkPsjVRd5np9yUT3ZoRpL8RF2p4J/
 Kqi2Nmm1c5sAOC8HhKWL0QiHtTyM90WE2yyQzIdVdfl1C3ulv0G4gfdgdxyQIwB+
 SB+6sY6rVIhybcPYZH+Abm8yW6pq6CSc8A9K/srazMn91maacqNv+Ys2Sv1vgied
 SGNnQa3U7dNktJvM3QaWLKDRE1sot/wiOqW20/W2bBmro4AnCvAB//fs37e5b/P6
 k9VZzG2GBZM8aJCvrAww==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efbu52ghq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2fe1cf409a1so4775645eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091792; x=1780696592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAf85VTKCRNOL8VWR6DSnLr4yR4IXWVDM6xyT5ZNd0Q=;
 b=eVkWNMt/b7QH+tOPIgCP5i9Y9HYLcMIrJePkZtnK64J4+Z4vohqUBvD9JnYqawhkrl
 VRgAlBEV1ZOaIpJhuFQgJsAlCNE9QqU+PhDIP2LGgZFSZzwpbdmT7ZwdEzeqN2DEX16h
 7c1kvZ3SiBat/XIYFthT+AYcZGSQyip0XNCqqf/A5uh/J3voxr1JnjS4XIcbG2NrjfND
 tP31YGpPK24/b6L9Dmpz8BADYD96njtqZLQdQyp2Tn1Ki+rof63E4bRYxLmuEv2jVhU/
 x5QiLSpnZHYaHkEUFkXJpN/Dm2k4FBEfGGP5B1ci6V0Qprj+0wlUUWQUbSHcVef8XsUb
 hduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091792; x=1780696592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lAf85VTKCRNOL8VWR6DSnLr4yR4IXWVDM6xyT5ZNd0Q=;
 b=mQLg46LXHgnWN2dbRrj7IWJhIisctBnQSPs3dvYFL751hPGnBnFwDFB7sGoaPWYN7m
 HN/onrr0elQJcKQVvK8sRVW0YxlG555ZcFrWY4+3rj4tx1VRF+FrB8rDZlTKqnGlm2Yn
 bvRpgSUwq3c282pfjTKaZK7W0urm15tq02ezzKfGUS/34nzD2pmry4djz548lEDL5z+1
 iwlpa7xb8ec3qBIhzeDhlpJksIxa+lgSssBwvrP2+6l8dH4GVHTqaKPTCgHgi7CY972o
 UFjb3BwRkyQLgQRRxe17AMR7p+XcY3rA6rkoUX5P1rAm4GvwCSXJM0cGyxxLEOIyJvLX
 KpsA==
X-Gm-Message-State: AOJu0Yw9PL9vAwO7F/gA5kgxRr3Rg61rHP5XArw8twMxxpgpBS+AH92R
 V21K1g9cjc7JmugkcLyL8PGWQZYgjEw334tFET8COrkEP1tWC2jWsGTY0OLLpKZ03BPzAEuYJvi
 OLDr6kpOT5dqvAmPIGnN/zKRvqq8Wxq0Sg8rT8txqq8hZE7CmcQk3ncc4aYmK+mssXg==
X-Gm-Gg: Acq92OEyYZCZ//bPCN2mMll21DNwHiRoeXsjtikFhybsLDt+kXsB0Cr/5mxhhgKF6z6
 9wZN4WZIXuVHbsUueb6DVpROnRNMzSBg3Z9N0bgrKwUoCzqFvx0tziMjknbRhSw4t8qDFOURW2/
 Lz0/fNCjfvahTu1QFpEpPFuoZ0SdEKzXREUaqlwhIFyGVmGfLJFLIbrfH3QRakbHg8ug1lRLwHg
 wNOZrz73W5mGyYXevjlNDX2RH37qLx8StR5hOHR7+2fuyRj9uLv16iBtCkYUJyHmxepl9dzQtLJ
 Y7xPH52spRi9AWaBhWiexJYPSOgTzIds2Xc7Q+Afod+jdUkY/MQvaa8f5Kk46rTsXgeDueFttgw
 TvnQzIhDqTFlhFvkuLc593T8o4Tho4YK7dNCnXtF9LPbxnxRj1Bw3mC7PO/UV1f4rKDeoM5rebO
 JsOY5w
X-Received: by 2002:a05:7301:2e89:b0:2be:1f58:32a3 with SMTP id
 5a478bee46e88-304fa66ca41mr893590eec.29.1780091792017; 
 Fri, 29 May 2026 14:56:32 -0700 (PDT)
X-Received: by 2002:a05:7301:2e89:b0:2be:1f58:32a3 with SMTP id
 5a478bee46e88-304fa66ca41mr893573eec.29.1780091791500; 
 Fri, 29 May 2026 14:56:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 19/38] target/hexagon: Add vmstate representation
Date: Fri, 29 May 2026 14:55:35 -0700
Message-Id: <20260529215554.606133-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=SMRykuvH c=1 sm=1 tr=0 ts=6a1a0b90 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Oj8_dRLdxnToIsBgiwgA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: BK7axw5qgzVylHkJitqo8-NMPj6JVZbI
X-Proofpoint-ORIG-GUID: BK7axw5qgzVylHkJitqo8-NMPj6JVZbI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfXyiFLm+PiR20+
 nfH8jRCn4xf2/MhgubhY5iWCLni1G3abBQTwOFaYjqgB4fu+8dR+Rnq0/VZ/HR78YewkfxjKSwe
 l05s21OZ+9qUoXOApx60YuoyTJnnVTC5g99/UBvXyks1/Oj9mbY8T0Y/cZl/HyHWsbOp7HiPCmH
 xMTYn33OJyAd0Jewg35zb+EnVrBSUDEzbUyM9loTEFNucirmgXb7WMRJHNHVG+5B2W9IXWuZdQc
 ZwFrPhot+jLUL2/56h0bPjm8yINA02DYo3BA2bFlqbHEKw3gxzz/5fVVja9yxTcsXiqhG8o6A71
 67TnQTwLmkiUkZL/q8OcNEiVQ4vuKu9LyY9AfpSTHh1s0VUiNA0y6FM6njFbbFC9Sg0bLblvysn
 Fk4Ol6Aqy3ikH2ERQS3aFpT5aUyVZEmnmAE4QEKZZiKn3lOLL7Z9mSS/IJRCQ693BA5kBoGcuOG
 cIwRbbRNHK5TnRf2QDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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
dGVybmFsLmggfCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgIHwgIDMgKysrCiB0
YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMgIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAw
NjQ0IHRhcmdldC9oZXhhZ29uL21hY2hpbmUuYwoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCmluZGV4IDVmYzgzN2FlMjI5
Li5jZDA2ZmY0MWQ0ZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0zMSw0ICszMSw4IEBAIHZvaWQgaGV4YWdv
bl9kZWJ1ZyhDUFVIZXhhZ29uU3RhdGUgKmVudik7CiAKIGV4dGVybiBjb25zdCBjaGFyICogY29u
c3QgaGV4YWdvbl9yZWduYW1lc1tUT1RBTF9QRVJfVEhSRUFEX1JFR1NdOwogCisjaWZuZGVmIENP
TkZJR19VU0VSX09OTFkKK2V4dGVybiBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9o
ZXhhZ29uX2NwdTsKKyNlbmRpZgorCiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggZDMwZTViNjRlYWMuLjMwNTkxOTZi
Y2FjIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdv
bi9jcHUuYwpAQCAtMzgyLDYgKzM4Miw5IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2NsYXNz
X2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0IHZvaWQgKmRhdGEpCiAgICAgY2MtPmdkYl9zdG9w
X2JlZm9yZV93YXRjaHBvaW50ID0gdHJ1ZTsKICAgICBjYy0+Z2RiX2NvcmVfeG1sX2ZpbGUgPSAi
aGV4YWdvbi1jb3JlLnhtbCI7CiAgICAgY2MtPmRpc2FzX3NldF9pbmZvID0gaGV4YWdvbl9jcHVf
ZGlzYXNfc2V0X2luZm87CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBkYy0+dm1zZCA9
ICZ2bXN0YXRlX2hleGFnb25fY3B1OworI2VuZGlmCiAgICAgY2MtPnRjZ19vcHMgPSAmaGV4YWdv
bl90Y2dfb3BzOwogfQogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMgYi90
YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAw
MDAwMDAuLmNlMjUzZjQyYWM3Ci0tLSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFj
aGluZS5jCkBAIC0wLDAgKzEsMzIgQEAKKy8qCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRl
Y2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqCisgKiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisKKyNpbmNsdWRlICJxZW11
L29zZGVwLmgiCisjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCIKKyNpbmNsdWRlICJjcHUu
aCIKKworY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaGV4YWdvbl9jcHUgPSB7Cisg
ICAgLm5hbWUgPSAiY3B1IiwKKyAgICAudmVyc2lvbl9pZCA9IDEsCisgICAgLm1pbmltdW1fdmVy
c2lvbl9pZCA9IDEsCisgICAgLmZpZWxkcyA9IChWTVN0YXRlRmllbGRbXSkgeworICAgICAgICBW
TVNUQVRFX1VJTlQzMl9BUlJBWShlbnYuZ3ByLCBIZXhhZ29uQ1BVLCBUT1RBTF9QRVJfVEhSRUFE
X1JFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMl9BUlJBWShlbnYucHJlZCwgSGV4YWdvbkNQ
VSwgTlVNX1BSRUdTKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzJfQVJSQVkoZW52LnRfc3JlZywg
SGV4YWdvbkNQVSwgTlVNX1NSRUdTKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzJfQVJSQVkoZW52
LmdyZWcsIEhleGFnb25DUFUsIE5VTV9HUkVHUyksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKGVu
di5uZXh0X1BDLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52LnRsYl9s
b2NrX3N0YXRlLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52LmswX2xv
Y2tfc3RhdGUsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihlbnYudGxiX2xv
Y2tfY291bnQsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihlbnYuazBfbG9j
a19jb3VudCwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKGVudi50aHJlYWRJ
ZCwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKGVudi5jYXVzZV9jb2RlLCBI
ZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52LndhaXRfbmV4dF9wYywgSGV4
YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDY0KGVudi50X2N5Y2xlX2NvdW50LCBIZXhh
Z29uQ1BVKSwKKworICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNUKCkKKyAgICB9LAorfTsKLS0g
CjIuMzQuMQoK

