Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9781CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbncn-0002nO-9Z; Mon, 22 Jun 2026 19:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbncm-0002nG-7U
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbnck-0002EY-Mo
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:15 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJcx5m1939456
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=; b=SN0R/kDWb2aDIjAq
 tupBMnSaNnHnJTn096PksUsrxEqAFBquQZZBlrMRLN1JsaQLBoRzEp1/HF+AsGhO
 cwW+E+iDrA8nkFUotS+0I+1+7K0fOb9RUVRaESZybqQSFSX60lQsjr31kQZcHZTI
 i2zqr7vO5XzpHuWmUA3V8ipmuwIQArMY9y3Z66ZdZqDEcf6A1QTa/1/snWaF6XMw
 r/uniKPsnfJByBuJifq1uv53Y/dbnZ2j0JoM0fiAmjH1IaVDEm4bnVTSCGPV8y0w
 FNUO5jFBa1OiiuYONttMQhnEAe8/A4xk6A9fv5GPvCCSw/DykK0mVqblX5F/KHJt
 8vqMYQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5yea028-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:13 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1394c3ee7f2so24363184c88.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169213; x=1782774013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=VV6G5nAuDGa4LniUthjiDXW9VqG//NjbPcTuajcKrFh52mo7ebQ7HGuqyhqAPyhpVW
 o1hkLzpYhfEEt32hx+l3NicShWbcsCPU1nBMzzRwG8UQkaSGniRmqrtzTcyIXFePtmrf
 3gxrGACLdbge2tRYNZPar+IIsBifV5AarGywvgYCrxZg/vqmnYrzrdQ7jAhj/LAjrN+U
 d9JWmFEI4a4yr3R3NATthYpBJ/8gJn5cpj4udZammv4xc2HAqevY1BBphWSWK9G58v/b
 w+IuObFhtd/dplahLtSph1FDJW5DFvTrBwHSUx2Xy0QlTcsCcDmTk1VJZMoyWhHj455a
 KX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169213; x=1782774013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=n+ZNlCRUJPmLlW9WBG0qULXWHphMRL1Hjt3XhZ039TxVBf1LF9fPWUMYuEjID4p+g5
 RsFvjSD/HjRlFLxXYInhlVfjQkqwDwDaf7vOMvFR3WnC+NX/OkLzAidT+LDfKGu/H/ky
 iBXvbWt+X433O/dyeENpMPIDvgTGlfkPlANbvrgK/clR5g8j0ftAjcNkH2YUbOnAK1ka
 RHiNTIa+HVKWvh6RosqipGDq3kS30ljaPwIKIqO/4VgNyXBetNtWbZolXvJWrCKK1mYo
 1XjJbP2NWZT3A2t3lJ0QesoDZo4HX3yculHCAoc+Y8rzz05ylXUNGF9zr532GsVTT2t7
 V6rg==
X-Gm-Message-State: AOJu0YwXfoEuql5LhXEmFJbx11DujGA1JR8SQZdbPNevq0/ZUnjV7C+4
 Qn0OEV0qLhkjy0athIFaFpEE6UAFQca+GmlhzHwc234kVhkM3DLCxpvWSzWic6vLm0Kt6jE1NtW
 BsJUCzUXghaatcuOmfmcM7/Jx1EkTPCrsVMzW2b4Zt+cLB7DnYO91vqXWgFy4YlW7AQ==
X-Gm-Gg: AfdE7cmLcwMixL402Ein4s+/SCFfoePIgWbJaj4tXtJgmsI1CAb5khE1sxL9Wo6uLgu
 NChjK+BR3T12Wlbc+cTyhtr7wBc7S2l+dz8ux+iD44j2INyqdVonlXpTry1JwF/pmClzgF02frm
 o7BX8XtIRYLRbXki5HLO24wGPQAQ6vMYkdG9PenBdWkR583WB1HJWdxQ58D9FELYDW3NKX5tXdr
 HdqkVH7UF44nHxXW/EOJjNX0hmNNPPcPWnWDXSXs8RFSRMNx2/tlWjdsp1otYhV8bg5iFp5G8EN
 sHw4uDFlrIUhhva8yQn20q/dFIAmhbPmARG5a0Lf0f4+FT1WZR9otGB8Djqpn0iqxpbe3C7VN8V
 ZqqjCaU7PWmmzZ2oIzh8KHbVxQkIY7DsfOizdMEORFeG60B1pEKySlwB1+QY=
X-Received: by 2002:a05:7022:2215:b0:138:36f:4288 with SMTP id
 a92af1059eb24-139a2061d1cmr10604525c88.15.1782169212713; 
 Mon, 22 Jun 2026 16:00:12 -0700 (PDT)
X-Received: by 2002:a05:7022:2215:b0:138:36f:4288 with SMTP id
 a92af1059eb24-139a2061d1cmr10604482c88.15.1782169212171; 
 Mon, 22 Jun 2026 16:00:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 43/75] target/hexagon: Implement get_exe_mode()
Date: Mon, 22 Jun 2026 15:28:32 -0700
Message-Id: <20260622222904.607771-44-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: axJFhpIEjlhCLHn3vVy5_cycJudmgNh2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXyIxx6LVc9RHj
 93p4N/1f/+rjg4SwOeFel4ERRwOHjS6IZmBX+YMYCc/OoKYdRCHrtlqiIZjiP9Bke2XJWu13TfM
 MNJfMOTrffXLoxO8qCTK2FxhljSxDv8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX1rRfOnZYDYM9
 oqA+UtIJCRr6Ntty9Y25rlNUatDq7CN5a4d7VWtbLKnM4h+tFn3c5Er1jODvwcDAkvyWWq2ZhKQ
 vBvpXcClgKWRGkWHtoZ1kOg+3jY9fDqspp1dnHSI8ULjTJFiNjynwfY4j/bVoDR5rItiphoYpi8
 s25Qpd09tjrOyAOw3MVWMy5GZjOeW/6cuWbw24X38dWloKtErzL/NQ13nSM1qQhciBbhhJBxVG8
 sq3qCp+hL1VTj+5qBJpZiBLIEp64j3SkRgfXH/egGakY8VtC6cZyMwG4Heb4EhfOeVvuT7wQpz5
 KZUWMr4zvtmKTO1InLM2Xv2bvhrut6lKwjXsQhh6V3ixXWmqzz0NNDV7plJcooOOMLlBb1gUMmI
 Na2ohJZek2nMQXddj8Ziv8iRPjaNg+E6QB9OrL66DpCDjX5jymx2VZkdY2Ovs61a+1QA1WOZkmj
 WZz0Xr3sp7OlQMKNFrw==
X-Proofpoint-GUID: axJFhpIEjlhCLHn3vVy5_cycJudmgNh2
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a39be7d cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4_WtjC8beq4VSFaiBQMA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220221
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Jl
Z19maWVsZHNfZGVmLmguaW5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYu
aC5pbmMgYi90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYwppbmRleCA5YjExMmNj
ZWM2NC4uZDJjNzA2ZDU2YjUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNf
ZGVmLmguaW5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCkBAIC0x
MzUsMyArMTM1LDE0IEBAIERFRl9SRUdfRklFTEQoQ0NSX0dSRSwgMjcsIDEpCiBERUZfUkVHX0ZJ
RUxEKENDUl9WVjEsIDI5LCAxKQogREVGX1JFR19GSUVMRChDQ1JfVlYyLCAzMCwgMSkKIERFRl9S
RUdfRklFTEQoQ0NSX1ZWMywgMzEsIDEpCisKKy8qIElTREIgU1QgZmllbGRzICovCitERUZfUkVH
X0ZJRUxEKElTREJTVF9XQUlUUlVOLCAyNCwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX09OT0ZG
LCAxNiwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX0RFQlVHTU9ERSwgOCwgOCkKK0RFRl9SRUdf
RklFTEQoSVNEQlNUX1NUVUZGU1RBVFVTLCA1LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfQ01E
U1RBVFVTLCA0LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfUFJPQ01PREUsIDMsIDEpCitERUZf
UkVHX0ZJRUxEKElTREJTVF9NQlhJTlNUQVRVUywgMiwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNU
X01CWE9VVFNUQVRVUywgMSwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX1JFQURZLCAwLCAxKQot
LSAKMi4zNC4xCgo=

