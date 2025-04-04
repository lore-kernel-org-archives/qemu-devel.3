Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363FCC3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 02:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XAa-00060x-Bu; Thu, 03 Apr 2025 22:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XAW-0005uf-Ub
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:52:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XAV-0006ma-FV
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:52:32 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341OFes016251
 for <qemu-devel@nongnu.org>; Fri, 4 Apr 2025 02:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X6WsiV3WAnDhq6R8jZFhwXEKmS+scYU94YlEcS5TmFs=; b=jRiEzVmSMevs0i/l
 oN09KE5wq2Wrjxugao+4a8DFQpXfXxWkT1NPUzF36O4V9G0ckAUtzTqp8MIDkBf3
 Snso0HhaCHIv8EqQQ9+2/wylxHJzyckO4hlnvd3PnWOoPyqMD6U/P1raQBYWPQln
 o4rSMNHubIyA4x0ugIHvzQSzwhiCEbPQ4q/tx6+4727OXR6/cXBvbDMyaS/000vn
 GSmVck3S2dahnJy9GuJvYB9j7l+A4p4uYVkZmsE/3gRgak0oVOskbfIyBAU6nT01
 BZwYszV6Dz0PNy8BW2NApwo3Waqu0pvhe2f53r22Dwju8S9uku5V4anhy3k0N1YM
 7m1xog==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2d8gg37-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 02:52:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-227ea16b03dso23241505ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 19:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743735149; x=1744339949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X6WsiV3WAnDhq6R8jZFhwXEKmS+scYU94YlEcS5TmFs=;
 b=RowznvBgEIYZp/IbDP00aMdkjdqmrFveatKGI9F6NXgiDLvNaZ+auz/IDm7oE3YVdq
 Putx+sTFoQv2OYYq5zCpXxa6dTC6SJ3GwVCS9PAMujyv5Lrb7+5Y6aHLETiTWmo+RPy9
 GgZXHKSwQNzWQUzWd3O+a6Hld7KXp/eYLq1jHjzwqt6GBv0MVE4+JaLRTiKF5nXasMin
 N1Tgx+Cu0AsuuCCjhku6IprzTbHFn6N1zsL513FJMromEiT4istlGFFOfGbDN2m2QhsZ
 X0EcXyfNgEar+Jpqd2IhEKVcKA+ZD9cTPgt41Glhgo9ALipH4fcl9t/KrlJ2qJV9dvg8
 XTow==
X-Gm-Message-State: AOJu0YwBxXooLQr923Orivj6B1b/62mH/7YTbW/VNZ6qN7JlAfjPF6/5
 PSeotB0chRaysjoMDNVB6trLPXX1uhMrNZHeUHsYdfWy0URQGOOpNgOLbsRTa0v3DYCSSNGre5n
 CbosVG5CVOB9gu2Sa8lWfcKEY4xowy1UPP9rn1jJacllKFIKi3RWIIQNKBKDJ+g==
X-Gm-Gg: ASbGnctGYzq05W7hP2qRyGBQFVaxsHN1NttZs7dY2pX+sWdveVFXKXsa80LjwM99xq7
 NqowobujcR9d6bj/Oai/na7a4M9ASpECZ3t74gWyXIM0T0IR5uNNV5H66UoJDroIYM2geVQm51M
 d8snHaeJGpzjf10r38X+jgd6KwQAl04WGIDags1A4FqIT9L0XXhfmL+sKf08cqPBsOBHfvkPuMa
 PLUD37htYucp37zyAWSXV/SqoGhXSRFZhHjac6mPsCWCNMG7toJSpDs7G2E787wFlukPbFVR3d4
 A2vMY4GjYf1IlnxkR0mV2N+00Q123nFDyTBaodQnMwaer6dwrnLBBAKJ33cwT+9Q
X-Received: by 2002:a17:903:8c3:b0:220:c143:90a0 with SMTP id
 d9443c01a7336-22a8a065780mr25065745ad.24.1743735148754; 
 Thu, 03 Apr 2025 19:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZlnc0VY63us9hxSXeeXaNYyyBx0ppr/E/Bz/V7WmU+HJkfttBxKhAKFAAJaL2jpLiRre8WA==
X-Received: by 2002:a17:903:8c3:b0:220:c143:90a0 with SMTP id
 d9443c01a7336-22a8a065780mr25065295ad.24.1743735148379; 
 Thu, 03 Apr 2025 19:52:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ea16bsm22014865ad.106.2025.04.03.19.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 19:52:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 5/6] target/hexagon: Remove unreachable
Date: Thu,  3 Apr 2025 19:52:02 -0700
Message-Id: <20250404025203.335025-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250404025203.335025-1-brian.cain@oss.qualcomm.com>
References: <20250404025203.335025-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: MAAVbo8QxjqCQKhdAsF8Kl8Kh_OR2kFN
X-Proofpoint-ORIG-GUID: MAAVbo8QxjqCQKhdAsF8Kl8Kh_OR2kFN
X-Authority-Analysis: v=2.4 cv=N+gpF39B c=1 sm=1 tr=0 ts=67ef496e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=WeWQB0ruK5ITHrmzxTQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxlogscore=707 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpXZSBzaG91bGQgcmFpc2UgYW4g
ZXhjZXB0aW9uIGluIHRoZSBldmVudCB0aGF0IHdlIGVuY291bnRlciBhIHBhY2tldAp0aGF0IGNh
bid0IGJlIGNvcnJlY3RseSBkZWNvZGVkLCBub3QgZmF1bHQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
ZGVjb2RlLmMgfCA2ICsrKysrLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0
L2hleGFnb24vZGVjb2RlLmMKaW5kZXggYjVlY2U2MDQ1MC4uMWRiN2YxOTUwZiAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMK
QEAgLTQ4OSw3ICs0ODksNiBAQCBkZWNvZGVfaW5zbnMoRGlzYXNDb250ZXh0ICpjdHgsIEluc24g
Kmluc24sIHVpbnQzMl90IGVuY29kaW5nKQogICAgICAgICAgICAgaW5zbi0+aWNsYXNzID0gaWNs
YXNzX2JpdHMoZW5jb2RpbmcpOwogICAgICAgICAgICAgcmV0dXJuIDE7CiAgICAgICAgIH0KLSAg
ICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKICAgICB9IGVsc2UgewogICAgICAgICB1aW50
MzJfdCBpY2xhc3MgPSBnZXRfZHVwbGV4X2ljbGFzcyhlbmNvZGluZyk7CiAgICAgICAgIHVuc2ln
bmVkIGludCBzbG90MF9zdWJpbnNuID0gZ2V0X3Nsb3QwX3N1Ymluc24oZW5jb2RpbmcpOwpAQCAt
NTEyLDYgKzUxMSwxMSBAQCBkZWNvZGVfaW5zbnMoRGlzYXNDb250ZXh0ICpjdHgsIEluc24gKmlu
c24sIHVpbnQzMl90IGVuY29kaW5nKQogICAgICAgICB9CiAgICAgICAgIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkKCk7CiAgICAgfQorICAgIC8qCisgICAgICogaW52YWxpZC91bnJlY29nbml6ZWQgb3Bj
b2RlOyByZXR1cm4gMSBhbmQgbGV0IGdlbl9pbnNuKCkgcmFpc2UgYW4KKyAgICAgKiBleGNlcHRp
b24gd2hlbiBpdCBzZWVzIHRoaXMgZW1wdHkgaW5zbi4KKyAgICAgKi8KKyAgICByZXR1cm4gMTsK
IH0KIAogc3RhdGljIHZvaWQgZGVjb2RlX2FkZF9lbmRsb29wX2luc24oSW5zbiAqaW5zbiwgaW50
IGxvb3BudW0pCi0tIAoyLjM0LjEKCg==

