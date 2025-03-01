Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7ECC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFQ2-0002gV-1z; Sat, 01 Mar 2025 00:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPw-0002Aw-PX
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:40 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPu-0008Uz-GQ
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:40 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213KHTr007066
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l2T1zL6OhJjTcDmbWt72puUBYUvtOanT7vJYSzjv2ms=; b=BzfXbsQteQp0n2sr
 oDs8I+kn00O1uW07NtjQdRGpzisFPv/zg9vRs7WtA1hSO1m1o14htOPLLgiBrn/e
 dM9Ho7UaUh2r/olayQhQZ97EqZWAwS7QH2s0rH7JrGcVRCkoHTSbiivgA3pLT3g4
 dqOUCOx/cWqONePHs/X0KgVE+ezGlh3Gtvos+jkysHRmrhnHSRFMIHOX43I3a69p
 o3kLmDEkF6viskvZbcmQ5MkhZVugFs27xqVTr6/ULbeV21NLnMK6aBc/q7KRrGFx
 nMcmkXdFVtj8JnEAvFR4eqbN8L/uuNGAP+5qIjndVz9CuL5Zkyv/d3HKV1HmM5lM
 5bG4FA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t88r6dg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2feb8d29740so3587509a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806976; x=1741411776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2T1zL6OhJjTcDmbWt72puUBYUvtOanT7vJYSzjv2ms=;
 b=bom28AD3jk7TRAdGgQnHiIel8CBjndjOLZW4UY6jdmgHwwbLKZI45sZsfEoBRIGmGN
 aiYctdQvE9xO4XcMu7Pq95RTqycv4ctXPDPp5V++6yoFRUqRlRWWEOHLZL7XZONSjipw
 FcqKyAPaIvoI4R9hYq21ZVBPp5mkVxgXaa3YBKl00wBh6e4o77XccUvbjKdGEfPqG4sI
 lYMosLN1O6Y1Oi/CIpu2WZK1d9Xh+pOmQ3sYlq8y8elNajgzrMDP4DCw6Ds4yRYgXZNN
 qxDz8VdJGXUnMtqtVjkOAK75RW56mOn65J4qKXvfa1+bhNRCnMVF67rT2DrJFOam45sj
 NMGA==
X-Gm-Message-State: AOJu0YybaMNFhfVeqqBDQ1oh34ORjX5TVMtTeSFjRogZeVuAVwSU+I3N
 +HEtsp4AshoYgelui9kcTy/mOe5jZe+5YHL9Z9S0s7l+oS0E7dyASZvm1FR5gAjTcVR2eZnAVWb
 AQ0h/+43Hm73WOrv2aXchXzWZfc3RX/apeaMz70qQf1g8RzLcSckTzzB06pk3Jw==
X-Gm-Gg: ASbGncslgP2YUXjZrmpDtnf1WNmmmcNdvHFr+6L/2PWBMLmzVeyHCNr8C9BxBsJkGkw
 5ZygDLEsUSfMva1yui0x0tKYE6UzVDWi+5py6EUACNe3kYQe/Z6ft5dAS8bD0nTKuxQ+NIZT56v
 EU9KMAbyyKJ3d4grPKQnY+vQ/ZmLt6Wi5ClSTfCm2wGbBDPhDGf/fZYW58DdNFMsQ+wxJr68FmK
 rWuyDAGa1W21jnq1Z5y0qFvMHyJcbsYzDyb/9wnFndimWvcczN7JXqM6zyMI8smRbEoG7syUD7q
 tBVho2WyQ3mEFINbhCHEahtKuts+FZaCimcyznAtKk7Ct2gGjwi406jRH9X0xFpl
X-Received: by 2002:a17:90b:1d81:b0:2ee:d7d3:3019 with SMTP id
 98e67ed59e1d1-2febab5ba82mr11536995a91.12.1740806975863; 
 Fri, 28 Feb 2025 21:29:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzEtVv8c65AGTZbCmN/Cov6WRgCcOjGwzbki2igKQlAVNFtNdobooT2qu1Yyw1T0nvIYisXw==
X-Received: by 2002:a17:90b:1d81:b0:2ee:d7d3:3019 with SMTP id
 98e67ed59e1d1-2febab5ba82mr11536973a91.12.1740806975440; 
 Fri, 28 Feb 2025 21:29:35 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:35 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 35/39] target/hexagon: Define gen_precise_exception()
Date: Fri, 28 Feb 2025 21:28:41 -0800
Message-Id: <20250301052845.1012069-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: DrR967Uemd7DBHf9CFzPIn1aMZHsKGRz
X-Proofpoint-GUID: DrR967Uemd7DBHf9CFzPIn1aMZHsKGRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBZGQgUEMgdG8gcmFpc2VfZXhj
ZXB0aW9uIGhlbHBlcgoKUmVwbGFjZSB0aGUgZkdFTl9UQ0dfSjJfdHJhcDAgbWFjcm8gb3ZlcnJp
ZGUgd2l0aCB0aGUgZlRSQVAoKS1nZW5lcmF0ZWQKc3lzdGVtIGhlbHBlciBpbnN0ZWFkLgoKU2ln
bmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0K
IHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAgIHwgIDcgLS0tLS0tLQogdGFyZ2V0L2hleGFnb24v
aGVscGVyLmggICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCAxMCArKysr
LS0tLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8IDEzICsrKysrKysrLS0tLS0KIDQg
ZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5o
CmluZGV4IDcxZjhhMGUyZDAuLjE0NmFhZGM3MzcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L2dlbl90Y2cuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmgKQEAgLTEzNzAsMTMgKzEz
NzAsNiBAQAogI2RlZmluZSBmR0VOX1RDR19TMl9zdG9yZXdfcmxfc3RfdmkoU0hPUlRDT0RFKSAg
ICAgICAgICBTSE9SVENPREUKICNkZWZpbmUgZkdFTl9UQ0dfUzRfc3RvcmVkX3JsX3N0X3ZpKFNI
T1JUQ09ERSkgICAgICAgICAgU0hPUlRDT0RFCiAKLSNkZWZpbmUgZkdFTl9UQ0dfSjJfdHJhcDAo
U0hPUlRDT0RFKSBcCi0gICAgZG8geyBcCi0gICAgICAgIHVpViA9IHVpVjsgXAotICAgICAgICB0
Y2dfZ2VuX21vdmlfdGwoaGV4X2dwcltIRVhfUkVHX1BDXSwgY3R4LT5wa3QtPnBjKTsgXAotICAg
ICAgICBUQ0d2IGV4Y3AgPSB0Y2dfY29uc3RhbnRfdGwoSEVYX0VWRU5UX1RSQVAwKTsgXAotICAg
ICAgICBnZW5faGVscGVyX3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCBleGNwKTsgXAotICAgIH0g
d2hpbGUgKDApCiAjZW5kaWYKIAogI2RlZmluZSBmR0VOX1RDR19BMl9ub3AoU0hPUlRDT0RFKSBk
byB7IH0gd2hpbGUgKDApCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCBiL3Rh
cmdldC9oZXhhZ29uL2hlbHBlci5oCmluZGV4IDNkZjY2M2JhZWIuLjViY2IyZjQ4MDkgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hlbHBl
ci5oCkBAIC0xOCw3ICsxOCw3IEBACiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKICNpbmNsdWRlICJo
ZWxwZXJfcHJvdG9zX2dlbmVyYXRlZC5oLmluYyIKIAotREVGX0hFTFBFUl9GTEFHU18yKHJhaXNl
X2V4Y2VwdGlvbiwgVENHX0NBTExfTk9fUkVUVVJOLCBub3JldHVybiwgZW52LCBpMzIpCitERUZf
SEVMUEVSX0ZMQUdTXzMocmFpc2VfZXhjZXB0aW9uLCBUQ0dfQ0FMTF9OT19SRVRVUk4sIG5vcmV0
dXJuLCBlbnYsIGkzMiwgaTMyKQogREVGX0hFTFBFUl8yKGNvbW1pdF9zdG9yZSwgdm9pZCwgZW52
LCBpbnQpCiBERUZfSEVMUEVSXzMoZ2F0aGVyX3N0b3JlLCB2b2lkLCBlbnYsIGkzMiwgaW50KQog
REVGX0hFTFBFUl8xKGNvbW1pdF9odnhfc3RvcmVzLCB2b2lkLCBlbnYpCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmlu
ZGV4IGYzYjE0ZmJmNTguLjNiZDRlMmE4NzIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC02OSwxNSArNjks
MTMgQEAgR19OT1JFVFVSTiB2b2lkIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihDUFVIZXhh
Z29uU3RhdGUgKmVudiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDMyX3QgZXhjZXB0aW9uLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1aW50cHRyX3QgcGMpCiB7Ci0gICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShl
bnYpOwotICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsICIlczogJWRcbiIsIF9fZnVuY19f
LCBleGNlcHRpb24pOwotICAgIGNzLT5leGNlcHRpb25faW5kZXggPSBleGNlcHRpb247Ci0gICAg
Y3B1X2xvb3BfZXhpdF9yZXN0b3JlKGNzLCBwYyk7CisgICAgZG9fcmFpc2VfZXhjZXB0aW9uKGVu
diwgZXhjZXB0aW9uLCBwYywgMCk7CiB9CiAKLUdfTk9SRVRVUk4gdm9pZCBIRUxQRVIocmFpc2Vf
ZXhjZXB0aW9uKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgZXhjcCkKK0dfTk9SRVRV
Uk4gdm9pZCBIRUxQRVIocmFpc2VfZXhjZXB0aW9uKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgZXhjcCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0YXJn
ZXRfdWxvbmcgUEMpCiB7Ci0gICAgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKGVudiwgZXhj
cCwgMCk7CisgICAgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKGVudiwgZXhjcCwgUEMpOwog
fQogCiB2b2lkIGxvZ19zdG9yZTMyKENQVUhleGFnb25TdGF0ZSAqZW52LCB0YXJnZXRfdWxvbmcg
YWRkciwKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMKaW5kZXggMjQ4ZWQ2MGYyOS4uZjQxMzNhMTA0OSAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNs
YXRlLmMKQEAgLTEyNCw5ICsxMjQsMTAgQEAgaW50cHRyX3QgY3R4X3RtcF92cmVnX29mZihEaXNh
c0NvbnRleHQgKmN0eCwgaW50IHJlZ251bSwKICAgICByZXR1cm4gb2Zmc2V0OwogfQogCi1zdGF0
aWMgdm9pZCBnZW5fZXhjZXB0aW9uX3JhdyhpbnQgZXhjcCkKK3N0YXRpYyB2b2lkIGdlbl9leGNl
cHRpb24oaW50IGV4Y3AsIHRhcmdldF91bG9uZyBQQykKIHsKLSAgICBnZW5faGVscGVyX3JhaXNl
X2V4Y2VwdGlvbih0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKGV4Y3ApKTsKKyAgICBnZW5faGVs
cGVyX3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKGV4Y3ApLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF90bChQQykpOwogfQogCiAj
aWZuZGVmIENPTkZJR19VU0VSX09OTFkKQEAgLTIyMSw5ICsyMjIsMTEgQEAgc3RhdGljIHZvaWQg
Z2VuX2VuZF90YihEaXNhc0NvbnRleHQgKmN0eCkKIAogdm9pZCBoZXhfZ2VuX2V4Y2VwdGlvbl9l
bmRfdGIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBleGNwKQogewotICAgIGdlbl9leGVjX2NvdW50
ZXJzKGN0eCk7Ci0gICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9ncHJbSEVYX1JFR19QQ10sIGN0eC0+
bmV4dF9QQyk7Ci0gICAgZ2VuX2V4Y2VwdGlvbl9yYXcoZXhjcCk7CisjaWZkZWYgQ09ORklHX1VT
RVJfT05MWQorICAgIGdlbl9leGNlcHRpb24oZXhjcCwgY3R4LT5wa3QtPnBjKTsKKyNlbHNlCisg
ICAgZ2VuX3ByZWNpc2VfZXhjZXB0aW9uKGV4Y3AsIGN0eC0+cGt0LT5wYyk7CisjZW5kaWYKICAg
ICBjdHgtPmJhc2UuaXNfam1wID0gRElTQVNfTk9SRVRVUk47CiB9CiAKLS0gCjIuMzQuMQoK

