Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A60C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB70-0004hF-HD; Wed, 12 Aug 2026 11:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6g-0004Ot-S5
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6c-0000Ir-Sk
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:05 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbpbr3875551
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WlqwqNNmlVCwY/HMUFQGFJ6MJ0M1EsGC/8XR8w8/wHU=; b=EJCaxXAjXw2IYtRE
 Kgz0sl+tsOTCvVhMevIxaRYG7irhhqcQpHEi+ww6xv1rAUAEsSAJXWdan7mEI0TM
 LNKO2LSJwGqEpSz/NdFEWK7SUFOIKAAVJ/euPMIbKkKohztOV1XTW94wZG4R+IJW
 MB7PP7JbLqVkLm7i2aGrMcO8FRTiey6woOinp8PpVY2O2yBcxYKl61EogRlxPdTc
 7ZkWrYZXSTikZWts18tvPWvr91T4XngqCrnx79zTgF3c3SyYrGPX+Bkn2+4yv1yn
 qkHBtmJK7f+sQVPGMDMIY24LvfQwBEFwg76FDwqGi1JTSbsl92yWFiTI3QmmxYE4
 /M8odg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj1jsrr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f5ac7416eso1333259a91.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549380; x=1787154180; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WlqwqNNmlVCwY/HMUFQGFJ6MJ0M1EsGC/8XR8w8/wHU=;
 b=bkuSlaSdspinMo0lhxiLNcRVQEzEn1HoTbg1CDTZoXGOY3NiXIJfQmM1EgIXS6ta/3
 vv9WLsvIP9/hCyNcC1Tw6sb+EajOX8r13LzR11qj60UN0mugPVAw8j1OHXB3h+NkZG6w
 WjHu3eF7gY7mpXapQRT8/DIOYffCc3U0nNHNXVN8tO1Gib9Ue67UCpISzgkIndmKw+dA
 328nKGlZJCvJrFHd1uayeUE+hjeKYCfiLplgFCmJXgTIPBA+NowUZ2OPL2xg1SjBogyi
 SyQocBF0M47Si+ekkhKRifSmiAiYORY0Wa3pBtWnyct9aMFavnpvk5i6JPbCZog1LSeE
 EhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549380; x=1787154180;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WlqwqNNmlVCwY/HMUFQGFJ6MJ0M1EsGC/8XR8w8/wHU=;
 b=otFHztMEBvwwm5J3V/ztr7BKqBa0iPF1kI9dVb11djypwAADwEU3ryZyoQ4OTdNLpc
 63r8L2RpSpdUzrSDAV4ymhq7YZKGSZsTjCXwKEeVS3vEIPidM0ciGdNnFUbw3yc/Al+r
 BaSKco+l8TCvv9ooaKxwj06SO/9RNUuVVW7+T1YOV3bP7UhfdGynYUKIXqZO+LHZZn0W
 a9LS6OXqWEgVHvcr+UdnJVKeQv9yT29fMPTuHPbSku5NE+u/skQsz8yZFiVFsZzo5fmp
 oXfaKQWdPv4rq9+Nk1SddK+9+SHNJnAVPJcFvUCVxdwUOhbXbrJn9rihXnedTm93vPwO
 1shA==
X-Gm-Message-State: AOJu0YwIwTwjAMQBKpL1LByxC01p/NkOY49+z3jFvEy8KLD+fhMhNB7+
 Sr5wszHuQZ4mG8UHOKNImlKZ8z+kWu72W3hAZ+BaavZy5vj0EkRRgliHSOLMzO9/2yln/aAxkj1
 ZJGcpVcWyPE/9OBlM1mTVolEG9vxIfqGSmXrOVtemJkjfYubBZKJxC0O/2g/1I+3n0Q==
X-Gm-Gg: AR+sD12FEMSbS/W/85CGCz1Iw0esoDxQKRkz6evshWTZ8mvYIUPJyo4KvrCE9ZQA0M4
 KFOyzdMgvqlb5QQ1qD9RnM6e0H5HiangvcTvmmkRqZ8RiH6fxAiS7TOAdQJ1el/nJF9gRqoamjS
 iAwQeuhXOWqFRhAhb8sXthVUtWkfr3krS51ZLS887NcAzcsoLsB7yTDVnAVZQ/1MjRs6QtILYSp
 boy4i83bt+tB6cse94MU52os2AG+v0AWEeZrgA3jre3h4HRlZ3Jtgi5Z0/RFrwqoPRqeYTD29rw
 lh7YUxHMYBWRPN2aNtvXyHC3NO2rOGTQC3UC2O6n1D/pgDuNxusIvih2IDOjyO9ziOmFbP7iem7
 rSIeHV81nHttypGq+9s0d6udbMTcKN6VstwIdWKl27LS/uueB
X-Received: by 2002:a17:90b:4a4e:b0:38e:5ac1:9517 with SMTP id
 98e67ed59e1d1-3930123e90emr6877963a91.3.1786549379954; 
 Wed, 12 Aug 2026 08:42:59 -0700 (PDT)
X-Received: by 2002:a17:90b:4a4e:b0:38e:5ac1:9517 with SMTP id
 98e67ed59e1d1-3930123e90emr6877857a91.3.1786549379285; 
 Wed, 12 Aug 2026 08:42:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:42:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 14/41] tests/functional/hexagon: add arch_tests functional
 test
Date: Wed, 12 Aug 2026 08:41:53 -0700
Message-Id: <20260812154220.1029828-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: jJRcXrPt-vRaUlKn3wkAFi6SCZDo_dnK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX3FILCPYh2v8L
 cQ89/pnduVuJMBbvWDA/C23JMna216Csev/bKZkrZjTGu12+ug+Zq7ruNx31BXvzdS+0W+HHTxZ
 1D4Q259YSMkIdzhO/41xWWSkbdT9vR2HVmWfMGzAmWfAYNmI0xUzQXrKSEJsy0PrSeE+OzcLeOl
 OPoHSoZvdpL1WIwXMAaAzK9AEBdCmdrXWTtYSH2qZdG4mW/L9oRuS8W+S0JuN1rn9JmyakJ1fxX
 Bu/9DVscA4z/1qyFr1lBc0+zLdXjK0uwsVRXTFNueaZoO08cgtlPOZjOIhAh3Py9kEBYmUJ3lgX
 HaHFVADnyuAzZ0e21nBuGxoEsu/oXL75b9IKeLCM5Mn10xeghtYrosnLOZs5k5BaaDlUYlKbot8
 vA9OsLadRe2z4zcSjMuevPICBr53rcrOlO6uJMwCrDyffmemKJgQ0sYlosPOwWvtI3uBdUVpEGK
 WM8PB0ns4lCiBccoqqA==
X-Authority-Analysis: v=2.4 cv=K6ES2SWI c=1 sm=1 tr=0 ts=6a7c9485 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bMnCV-8aVPcHOxL5XGsA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: jJRcXrPt-vRaUlKn3wkAFi6SCZDo_dnK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX8/l4R1hCfkaO
 n2iPwTW+BrzYFa4dSJIKHWLPlU2HRbzZWsSfpFqnZRW6Qio7drJuevGhp54urETfua7gdK9mIsa
 mQb9pU9++hSp9QKHgFQc0ixz7groWOI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120128
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

QWRkIHRoZSB0ZXN0X2ludF9zdGVlcmluZyBjYXNlIGZyb20gaGV4YWdvbi1hcmNoLXRlc3RzLgoK
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDgw
NjA0MjcyMy4zNzg1MzY5LTE1LWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbQpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMv
ZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weSB8IDYgKysrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9o
ZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0
X2FyY2hfdGVzdHMucHkKaW5kZXggNTRhMTQxMmM1OTcuLjJiYjM0ZjliOGRjIDEwMDc1NQotLS0g
YS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CisrKyBiL3Rlc3Rz
L2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKQEAgLTUyLDYgKzUyLDEyIEBA
IGRlZiB0ZXN0X2d1ZXN0X21vZGUoc2VsZikgLT4gTm9uZToKICAgICAgICAgIiIiCiAgICAgICAg
IHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF9ndWVzdF9tb2RlIikKIAorICAgIGRlZiB0ZXN0X2lu
dF9zdGVlcmluZyhzZWxmKSAtPiBOb25lOgorICAgICAgICAiIiJUZXN0cyBpbnRlcnJ1cHQgc3Rl
ZXJpbmcgdmlhIHByaW9yaXR5LWJhc2VkIHJvdXRpbmcgdG8KKyAgICAgICAgc3BlY2lmaWMgdGhy
ZWFkcyB1c2luZyBTVElEIHByaW9yaXR5IGFuZCBpYXNzaWdudy4KKyAgICAgICAgIiIiCisgICAg
ICAgIHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF9pbnRfc3RlZXJpbmciKQorCiAKIGlmIF9fbmFt
ZV9fID09ICJfX21haW5fXyI6CiAgICAgUWVtdVN5c3RlbVRlc3QubWFpbigpCi0tIAoyLjM0LjEK
Cg==

