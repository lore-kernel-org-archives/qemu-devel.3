Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E535BC43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBn2-0004GX-GB; Mon, 29 Jun 2026 09:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBn1-0004G9-5f
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBmz-00035A-KR
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:42 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT3BJ2604339
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DkqNfhgoLR6C1n5uw8+lxuImR0/CtUUuBPbZ2jmRaQQ=; b=S1XNNFgqPpWwXv2z
 1Y4BnJe4ES8pPBUGnAP5im4OADaEbRdRo6e3B2qOjREIL10j00uj6MSD+yXZAVo/
 rHB9lH7UC/JR/SklqLs9COTpU2CSrQukQQhnoKdyRaR6fMdUxz4wjd9AdnaqDhUZ
 4UdjGOYWZb151Nls2kMvzdRmUn0eVeFM9FxPOkd9EHM/v3bqSY/IQ3ikqbSc5h4w
 NPxq/PBJT9aRRWXf5OEXCk/SJYoOKoMR8G2zZZdoyxJuqJx9+uDPwl40DQrbKS/a
 YQ894J08rhC0j0In4SsHiCXUegUeCzOqj6iCuRO01ZDaIjtjn9SjHs7S8zZ1YG0Q
 ZxvZfg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq88xf3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30cb5001ed8so3120432eec.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738760; x=1783343560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkqNfhgoLR6C1n5uw8+lxuImR0/CtUUuBPbZ2jmRaQQ=;
 b=kV0l3GNKNnKWJ3Pbr/vVYMQ5LdqXexXoUChW312csN08Nj4gv7m6VRIY+G0J4lTZgt
 wrJ8oZZCDrVYyU+n5PrWKlEyp3/g1m+TX3dOtVQgf1h8VuItUdQiFBp55gZhbKLZLiR0
 C7tyrNcV5RNmPJeHAFs1kv1CRqz6g/FEMEqwqnXQ3Y6+YX/hysGAuHUNq8DxFYNyw/2v
 mT+u5G9mXYFoCkl2DozVSnUTEVM4HlHVOc4ZZullghF7NRqYOjmtTqGl3i7ev6ZO7Sqb
 4QLd1yjW0hKc0wh9kKhezv8EYRtK/FzGIEu9NHz3LmaIUfhyNEGTGW3Hm8t0IMJWZcif
 MXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738760; x=1783343560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DkqNfhgoLR6C1n5uw8+lxuImR0/CtUUuBPbZ2jmRaQQ=;
 b=hJbmPNO7Ix5vvHv3Da3fnH5kR3wNEISP0RSF3jlwkHIgPdJtcesLfqJAalvyQlddAD
 hCVV+btI0P5ZcGc+4LnWmVdknzOq68vWz+kI4mj8QS/yqckfN4orl4/wOIOzEwzt/Slo
 Z2xhxV6NaGxgrEqN2QrTwnUMG+dxZ/KtBdy6iNuZceNnMBpXQgCprMHxA7jDQy1XqvxK
 h/kzrC1RpQyAF7TduNwr08BILTdE1hYUUbRKVz29CCe3nH3WHbzypNPzalrC/ArJk75+
 Bjohnn9sTPMh7Jy7rAI13LRtKaOckQSmMxrLdiXd4TBP7br4T7TcnxVB2QbV3zKNLFwq
 /XYA==
X-Gm-Message-State: AOJu0Yymxfi3E72+4AW3cpeyFqUbgjxS5Y5UxLS3Xsxy/Xhpx7rz4IHP
 CVDIeGSv6yjQmLj1kMiT9+FPg4FIEgd1hu/0xhtD20fpwAykqLU7OHMm9DS66WKwbqFvrNmDPBn
 5vCptLwtzD00JuGL58t9zwPfK2rFFByJGOhIyYkIbI0kC1CdMG3YaL5Xc4kb10Nintw==
X-Gm-Gg: AfdE7ckdLD3Qg65X39I+WhJvt89L4qqwW8uyvssyuZ6kLXjlTsoKd0O7m/dvPfWKF6+
 AixlQSgK7TMvJqKBZdO1QyRC93b9TdG3mz5uIwirmTikqaelSjpyWS6HrPN7rdtFAY3fKJs9sYb
 X4j/xmVFezPUtXqG0AF13O3SKKoF4AWib0Jl1sdupywyzgz+q0kkeuT4m9Ad1ImBE+0KCmJmNgi
 phzNdYQYDDddiMI5eMjqC70nhqnlBNOHz82I9TdSwq1aOarKSxUWKk37zOsvi6IjgPpVIqqlzNw
 YjdRBAGFVmhhmQiYHrLMOCYCtE1RAAE0g8tbSMf1/PdCRBlRkMlBOrHQE3e8QYwLtF8x9chFwz7
 7nlEU+/Hy7RDklZlLBPU7ZXD+v9OKCpOMU1CnoQBD5NkptsHKWS1LlE0WZPw=
X-Received: by 2002:a05:7022:6a6:b0:138:12fa:377e with SMTP id
 a92af1059eb24-139dbb8ff32mr13747677c88.20.1782738759576; 
 Mon, 29 Jun 2026 06:12:39 -0700 (PDT)
X-Received: by 2002:a05:7022:6a6:b0:138:12fa:377e with SMTP id
 a92af1059eb24-139dbb8ff32mr13747663c88.20.1782738759010; 
 Mon, 29 Jun 2026 06:12:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:12:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PULL v5 02/77] configs/meson: disable hexagon idef-parser for
 emscripten builds
Date: Mon, 29 Jun 2026 06:11:17 -0700
Message-Id: <20260629131232.2487780-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: ssZFFzyFKXjiLKAK30Ig96bZGSxD16fn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOCBTYWx0ZWRfXzNWHcIhaS4uY
 e0f8LgxhIL41UisqmQA1Oj3iOdQ9wAWluht9j00daOkvNefU//L2X5pxHN/n+TvU5TUYHKs7uWf
 rxOIqLm1fkAbP2n6+XaFr9tFfyGGTrY=
X-Proofpoint-ORIG-GUID: ssZFFzyFKXjiLKAK30Ig96bZGSxD16fn
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a426f48 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ILBgGCNfQiSgiI5BVyUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOCBTYWx0ZWRfX31qaIZlQPqrC
 /oS+++3dk3mZyWXisXZe7mja1okNW3y86XicZpTmkaYuOuTO4bsio4/bXdN5htetXBV/w9pWSj1
 HsOK6Amzuw+IEOCOV2AZzqoquN8R0S8ml5Ux8DdzxAA5xuMW5MB2zQHosRP7So3OsmesL36B60v
 K9LG2iC8Y4yO+njo7EohSUGQ3ki7BA2a0YB1gmKf8uU3MQzYWH4gzRT5u3T3J1I+8vyPV3AsHen
 6nzACUJh3jIEEzBI/FYQSrVDfadtBJiscMiRhojZJdRcCy3aLWVzZSwQDEwZJsClP+MIhHA+XgT
 O7h2f92OTRXd6R8ePU3Is9/dPjr3Nl2aQEG52gWzy04sHZV6nZsaq8qr9t16hDQ/1BpsHSV7mZt
 6ECrE77seTJIp2jvCaGL2ml963lt2rk9MPRklv0Xm9Me8r5bQajuv8w51yiqOPGTLiMToUlou79
 uqbUcxosbRFDSU5Pzwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290108
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

VGhlIGlkZWYtcGFyc2VyIGlzIGEgbmF0aXZlIGJ1aWxkIHRvb2wgdGhhdCByZXF1aXJlcyBnbGli
LTIuMCBvbiB0aGUKYnVpbGQgbWFjaGluZS4gSW4gZW1zY3JpcHRlbiBjcm9zcyBidWlsZHMsIGVt
Y29uZmlndXJlIHNldHMKUEtHX0NPTkZJR19MSUJESVIgdG8gZW1zY3JpcHRlbidzIHN5c3Jvb3Qg
d2hpY2ggcHJldmVudHMgbmF0aXZlCnBrZy1jb25maWcgZnJvbSBmaW5kaW5nIHN5c3RlbS1pbnN0
YWxsZWQgcGFja2FnZXMuIERpc2FibGUgaWRlZi1wYXJzZXIKYnkgZGVmYXVsdCBmb3IgZW1zY3Jp
cHRlbiBzaW5jZSB0aGUgd2FzbSB0YXJnZXQgZG9lcyBub3QgbmVlZCBpdC4KClJldmlld2VkLWJ5
OiBLb2hlaSBUb2t1bmFnYSA8a3Rva3VuYWdhLm1haWxAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5
OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogY29uZmlncy9t
ZXNvbi9lbXNjcmlwdGVuLnR4dCB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9jb25maWdzL21lc29uL2Vtc2NyaXB0ZW4udHh0IGIvY29uZmln
cy9tZXNvbi9lbXNjcmlwdGVuLnR4dAppbmRleCA0MjMwZTg4MDA1Zi4uNTZjMzk3NjNiYjkgMTAw
NjQ0Ci0tLSBhL2NvbmZpZ3MvbWVzb24vZW1zY3JpcHRlbi50eHQKKysrIGIvY29uZmlncy9tZXNv
bi9lbXNjcmlwdGVuLnR4dApAQCAtNiwzICs2LDggQEAgb2JqY19hcmdzID0gWyctcHRocmVhZCdd
CiAjIGNvbmZpZ3VyYXRpb24gc28gZXhwbGljaXRseSBhZGQgdGhlIGZsYWcgaGVyZS4KIGNfbGlu
a19hcmdzID0gWyctcHRocmVhZCcsJy1zQVNZTkNJRlk9MScsJy1zUFJPWFlfVE9fUFRIUkVBRD0x
JywnLXNGT1JDRV9GSUxFU1lTVEVNJywnLXNBTExPV19UQUJMRV9HUk9XVEgnLCctc1RPVEFMX01F
TU9SWT0yR0InLCctc1dBU01fQklHSU5UJywnLXNFWFBPUlRfRVM2PTEnLCctc0FTWU5DSUZZX0lN
UE9SVFM9ZmZpX2NhbGxfanMnLCctc0VYUE9SVEVEX1JVTlRJTUVfTUVUSE9EUz1hZGRGdW5jdGlv
bixyZW1vdmVGdW5jdGlvbixUVFksRlMnXQogY3BwX2xpbmtfYXJncyA9IFsnLXB0aHJlYWQnLCct
c0FTWU5DSUZZPTEnLCctc1BST1hZX1RPX1BUSFJFQUQ9MScsJy1zRk9SQ0VfRklMRVNZU1RFTScs
Jy1zQUxMT1dfVEFCTEVfR1JPV1RIJywnLXNUT1RBTF9NRU1PUlk9MkdCJywnLXNXQVNNX0JJR0lO
VCcsJy1zRVhQT1JUX0VTNj0xJywnLXNBU1lOQ0lGWV9JTVBPUlRTPWZmaV9jYWxsX2pzJywnLXNF
WFBPUlRFRF9SVU5USU1FX01FVEhPRFM9YWRkRnVuY3Rpb24scmVtb3ZlRnVuY3Rpb24sVFRZLEZT
J10KKworW3Byb2plY3Qgb3B0aW9uc10KKyMgV29ya2Fyb3VuZCBmb3IgZmFpbHVyZSB0byBmaW5k
IGdsaWItMi4wIHdoZW4gYnVpbGRpbmcgaWRlZiBwYXJzZXIsCisjIHRoaXMgbWF5IGJlIGEgYnVn
IGluIHRoZSBjcm9zcy1idWlsZCBzZXR1cCB1c2VkIGJ5IGVtc2NyaXB0ZW46CitoZXhhZ29uX2lk
ZWZfcGFyc2VyID0gZmFsc2UKLS0gCjIuMzQuMQoK

