Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22561C98332
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 19:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAY03-0001LY-P4; Sat, 26 Sep 2026 15:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAXzy-0001Jx-Fr
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 15:23:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAXzw-0005rw-NG
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 15:23:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxQRf1449975
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xRIrBXzKSdyJOLjDczWGLXALDm6y6xvkXDeJw1yIwww=; b=k/VwUAoyv1n8hsYV
 czx8PTp83Y580X/UQ4t1jjRZzhaJk1hOInNDe/PH5Qu8JjVngEfXQ/Lv7eQBaZnp
 XVQBcq75zGjjFeBRTZBKgkzqIVNtu9O2gJ2bf5BChX/nXI2Fde/wGDJPaP7z77tN
 2YFlGhSkF5oLTdKEGGxKl0TZFtBKSPRlMJCuYijw7ptAX/detmG1EtExAGw3fNox
 /Ryqi5874wcMyT7FUGP2Lqq/AX6yeJPjx8owzFxWrOdkR6Lqd+fhLtXixcl4f/k3
 YCAIAaZlqlMc7flTKgwhf5Ejtjwkkgyi6SPxTLR2AVKbm/lEApVD6z3riNbx4Uum
 ERTA4w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3rfswsf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:23:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34344599f01so941903eec.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790450627; x=1791055427; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xRIrBXzKSdyJOLjDczWGLXALDm6y6xvkXDeJw1yIwww=;
 b=VRscakfgX2cdHkDUBjIcQcJuqT81fIDQ3KWnIefyUT3QNF2DZlaw+nAoApmhuGRAkO
 KByJ2AKtPfgxDUGuZZ5E0HoJqyZ8TaAAohNA33l7XBv5O2rSu1CQruoqHa66xqUXywXN
 74u+rXVV+lrgs5HAEVqB/2n9Jr/dNs//mq9wY7sScl2YsRKAAqcWpVIkheCy36x4eNN6
 Dgts+6/snBUnA2sh5FTUkSn8h/b9qedCyarR1E9LjAzoF5Q5ATEok0uQkfmLNudnv1vB
 9g4OyZvpAn1WNl8G7Q73zknM65GIramZ2/XpnPKNsQcbpueWpMdjJsYWfE2d2Q9aPRvZ
 fLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790450627; x=1791055427;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xRIrBXzKSdyJOLjDczWGLXALDm6y6xvkXDeJw1yIwww=;
 b=KwfqS4A2KgqusxZRBfXaeDJwoE0fRPI/iVw1LAfrxL/momr0z68LWXFo09FH/m/IE1
 /ICt8Dt3/gC9F48CKXrBsCd4Ikq1pVhOnXIs+jyANrKrH63gwgcWvjlQYJ/y05YUqrKU
 vErE/Auf16kLsZPbT6iohZoy67PysjQje8/l4RaDXsJEcCyB3oGQJQ81Ei2kgf4G+Vlq
 kf7rRkfSdq+K9rp7i6eFYIxRTsVkOSl6dNzMO8YlNSi+Q9kc3K6Sypz/0ckaGSDeX/TK
 z4ml+CaA7Dt7IN8QcvHh4+fHTyWXMIj6Etqeysi/3sbPdhDc9S6x31+7p2OKRb36aFOz
 zZJQ==
X-Gm-Message-State: AFuF++mgWniTHdRGhwKamxDFSuSN0pAIv7aCQjOs9ZxD4B0G5Pz4fU7C
 4ju1U5KxfkHK9Rx4kByIEwVevHtGf/PuFn5pw/Z/guk+BmZAbeZyuJYeTYJwpnU1gJ6+oxI3R/w
 rtjmoVj9tJ+PGD67eR05u+CJuQke3uYrRDjcvGHnTxL9BzDEESYe26dZfqLIIxz3VeA==
X-Gm-Gg: AYBFou2fXSIcprKAVK3b7R/nJevvhEh2isWzusAah60X/I0YE1eTjwod7w97EkwecZE
 amlNW8PHO3qfR+EU61kGkkf/S7XtRRTVr4ROSQUR9UKiwkL3v4iNE3bEzyiY6UErTDu40KO9UTC
 2I6RiCfMranqOuMP20r6iIB+NepPrkdect5HC5RKWDCwsB8KQDX+LDzS6lneXHJQ/n2kDkx2HH5
 UKd5pG3+BQsM772pSwBwLRDRINfNGDd6OSEesMswbCv4Rtfe7uJieTo+NZtW69FZhTy9Z+gUa2K
 tPZu1zDJTZQsut7v/eR3yDMLmrbs8KGNF1k1cxmHYBxbd3sAQSAPe84w1pvB4pm8IrPfYssGM4E
 eBIvw34xCW7R+FBFPu8TCh0CuxUTzulrGLqHM5/CzjdGT+dE=
X-Received: by 2002:a05:7022:4199:b0:144:fdf0:9d91 with SMTP id
 a92af1059eb24-146cfdd2b0dmr5296828c88.24.1790450626514; 
 Sat, 26 Sep 2026 12:23:46 -0700 (PDT)
X-Received: by 2002:a05:7022:4199:b0:144:fdf0:9d91 with SMTP id
 a92af1059eb24-146cfdd2b0dmr5296755c88.24.1790450625438; 
 Sat, 26 Sep 2026 12:23:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145aa0cb6b9sm13526271c88.1.2026.09.26.12.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 12:23:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org, marco.liebel@oss.qualcomm.com
Subject: [PATCH 04/10] target/hexagon: fix V6_vcmov reserved-bit encoding
Date: Sat, 26 Sep 2026 12:23:32 -0700
Message-Id: <20260926192338.2702952-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3NyBTYWx0ZWRfXzQwRNWwV9o0/
 opY3j5qRHNW39357jpijRGrmeKVRee/E9F9QcJMihVHCF6PtqnpBMADg7b94Fv75tHnxzdGHS6k
 Erp4zbDYOb9XiJO43r9t8FS9F7Qd7Aw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3NyBTYWx0ZWRfX0SPaCxcZwIDu
 vm7ug5nhuu8gOI8nJixq1OCVhk+V/+ufzVZSM3hCPZrSnTGJvLK6mfyx/SGg/B6ea5cZRhTWyBa
 8YD80Bn/11mWJ73l6PmwzrWz/7K4k+vjF6fLmYyOnkPE3GveV2u3T4rcSpL0UD9tYvVmAzhP46/
 +0KuGF+NBpz0iCkfAz/rAPUltkWNjc2cnoQvQddjYk2wsDbJrIUGP9KBUFAyySsCvn7ciLFJrWR
 m+AyN4rryN3piMBtVYFcuikZskmTchEcHocWMIv9dPt3Lm5R9PdeobWWe3i1rFbwPNEPSGBEWPf
 OEjOQAww6Uf6+v57i4fo1Ke5lAI17AwP4um3LoI3roSlOcg6N1yX1XPUxToYVHyNW/10Q+BVlYX
 k3vuEGf/yPGN3woIx+8JdraYVvpNF1+Y3ulclPvSRuLATr4XNe1wgrGxHhOvZOG97NbLGRnBIQa
 7mrs0m32vHSzTlAGwTA==
X-Proofpoint-GUID: m3PH_bINl3ghY2UIHwqL4NRtIcyVq17_
X-Proofpoint-ORIG-GUID: m3PH_bINl3ghY2UIHwqL4NRtIcyVq17_
X-Authority-Analysis: v=2.4 cv=K6G3jCWI c=1 sm=1 tr=0 ts=6ab81bc3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ptefoZwEObSeWYFtGJoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260077
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

VGhlIGFyY2hpdGVjdHVyZSBkZWZpbmVzIHRoaXMgZW5jb2RpbmcgYml0IGFzIHplcm8uICBMZWF2
aW5nIGl0CnVuY29uc3RyYWluZWQgYWNjZXB0cyByZXNlcnZlZCBlbmNvZGluZ3MgYXMgVjZfdmNt
b3YuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMvZW5jb2RlX2V4dC5kZWYgfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9lbmNvZGVfZXh0LmRlZiBiL3Rh
cmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2VuY29kZV9leHQuZGVmCmluZGV4IDA4NGFlM2Q4
NTQyLi5iNDZmNTE0OTJkOSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbW12
ZWMvZW5jb2RlX2V4dC5kZWYKKysrIGIvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMvZW5j
b2RlX2V4dC5kZWYKQEAgLTM5NCw3ICszOTQsNyBAQCBERUZfRU5DKFY2X3ZzaHVmZiwgICAgICAg
ICAgICAgSUNMQVNTX0NKIiAxIDAwMSAxMTEgdHR0dHQgUFAgMSB5eXl5eSAwMDEgeHh4eHgiKQog
REVGX0VOQyhWNl92ZGVhbCwgICAgICAgICAgICAgSUNMQVNTX0NKIiAxIDAwMSAxMTEgdHR0dHQg
UFAgMSB5eXl5eSAwMTAgeHh4eHgiKSAvLwogCiBERUZfRklFTERST1dfREVTQzMyKCAgICBJQ0xB
U1NfQ0oiIDEgMDEwIC0tLSAtLS0tLSBQUCAtIC0tLS0tIC0tLS0tIC0tLSIsIlsjMl0gaWYgKFBz
KSBWZD1WdSIpCi1ERUZfRU5DKFY2X3ZjbW92LCAgICAgICAgIElDTEFTU19DSiIgMSAwMTAgMDAw
IC0tLS0tIFBQIC0gdXV1dXUgLXNzIGRkZGRkIikKK0RFRl9FTkMoVjZfdmNtb3YsICAgICAgICAg
SUNMQVNTX0NKIiAxIDAxMCAwMDAgLS0tLS0gUFAgMCB1dXV1dSAtc3MgZGRkZGQiKQogREVGX0VO
QyhWNl92bmNtb3YsICAgICAgICAgSUNMQVNTX0NKIiAxIDAxMCAwMDEgLS0tLS0gUFAgLSB1dXV1
dSAtc3MgZGRkZGQiKQogREVGX0VOQyhWNl92bmNjb21iaW5lLCAgICAgSUNMQVNTX0NKIiAxIDAx
MCAwMTAgdnZ2dnYgUFAgLSB1dXV1dSAtc3MgZGRkZGQiKQogREVGX0VOQyhWNl92Y2NvbWJpbmUs
ICAgICBJQ0xBU1NfQ0oiIDEgMDEwIDAxMSB2dnZ2diBQUCAtIHV1dXV1IC1zcyBkZGRkZCIpCi0t
IAoyLjM0LjEKCg==

