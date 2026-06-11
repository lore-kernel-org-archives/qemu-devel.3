Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A88CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY3W-0002jH-Ea; Thu, 11 Jun 2026 01:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2s-0001gc-Ji
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2q-0002hS-Ib
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:38 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5Gd6J3725274
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +GWjqhJXFoAvjJ8KFsTvzZ1rxcqE0ZYR4UvQgHjmEt8=; b=oZnVpdPG35jegMCu
 Q9HG79Zm3ypqfT5Dnjb+Aw4SED2lzcYnLPOK/4cxTEhfuEQuC2eL0KUR3pzKugDz
 tMAtv+d0uJ1MUH2Q5TXA1FXxta/mWfs4KyAF9Fya2HvqZ2Da0CThdyjQjqT1x6kd
 Tsb6Yq9mIJiky/ASiQ812Dpq5yOBIKtoFfbepFtYw8uLea/EYi7B6COTpzUDNWZh
 CxkH1WMip93aWGb6qFVsbEhUIVAJoyiIRur8r14cQo0P4KJd4Fom4Nc3TzBqVUdg
 r0sO/KwemJ3ia1AhLi0UGp9Zf+fmf2w9Trs+l8bR1WvkX5dXPAAPj2aOCSqs8kHb
 zrWrUg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6v9qu2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:24 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304d8613efbso8106767eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156004; x=1781760804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GWjqhJXFoAvjJ8KFsTvzZ1rxcqE0ZYR4UvQgHjmEt8=;
 b=RjrG58OCdz2NgI5sGSXZ6VaWoO8zUdCxZNEy843jM/0ttR9KHZNOTxefPQZm7vBZks
 4KA//WCkMaAeWRIMTmxfGZ8DjQsjERSQ6cria87dqeGfvAQC8StUnkPHmhN0ny+6UWMv
 PW4o1ORsMr8oVrIVrUM4A+XFxZtIhOkKzPZpN8be9Lg0rohB3IQ8Jf/EmzOPt94pBk8A
 sqdR4CYbwiKj8zonlKKWqt/0h0iXxAx1X50kHkATgOqG2tPtHUiL415HRzZygfBdhWr1
 DmSVVnlCASRVvCDweFNc4AuLJHhIGrYL6Zah58kRn78gVHhUlEFXwH5Y+nkBod9o7tpp
 BY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156004; x=1781760804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+GWjqhJXFoAvjJ8KFsTvzZ1rxcqE0ZYR4UvQgHjmEt8=;
 b=AMybJDinSPex0IkQInlp7LTIzXPZuvwyFnnJ42Nk8lUEGSLgIlVvkvn8e6x9mkrcxH
 1TUcJVn/bBQXfu1zsYPJbRPXdVI06X5/fxOuUP+0GaQCCfV0BjcCPB1DIaOgJyTRKbE8
 Z316MW2tPISqGyCbatlhiunJjPyl8MxuKd1YW0WqPLL1hXSC1oeEN6bJ4ZXJmdxW/YSw
 3I7pyPr9gSXvcgMwBf1dG0QwmUeb5s5MOuK7Jve6J8x4kzSa+jiv+/ewiBVSeO19PAtc
 q+mQOkjI9I8rFY5ubQxWqbfw/2S5fQDMszvxVk7oGcKDmDAfWmLO7l5KIghBTqtKcZLK
 6VDg==
X-Gm-Message-State: AOJu0Yxk+weYLvBUL8DveNxvVnJYDpBme0WjxCJkh13VT8XiZzUYja66
 v6RjOhu55QU432KAFQw31lsXROuq+aObOG9+BvUh9AQZAHoDKcuM0/HyqRHmVG/6bZ+iLFaB91j
 oz8JX5c91DN5LfTTRt1emxcpRbCrzv6iSaIr1KAvOD5eFes6JKjsS/mYSkTbqA7Mo1g==
X-Gm-Gg: Acq92OHQD2xHdzoqFaqnwj1h78lUKSo4+PyscZCS05xnL9BzkXf9cwUAOq7MyjBTi+o
 y61Q64hSMFqEiTM3SciVtuwvc/CDUvva1lIpQ8Ubvnhhzcmymp0Wb/O/hVm3w7CZyNr70DIplcG
 piRMgnmXU9etv0IbHHgZgeQ+KbOUYttNOTlwkuNbpwRlJmpeS8RntIYEowl10m7Qups8PK+d8y1
 YvRpCAVd2ISnHACEWY8BpDcURaZ9LKexRbC0su3w91sd5kifZCqrMiPwKxwIzFcL0HHfJ6FAtNp
 e1W/T34j9d/LMYuh6XLV6tyogVviwDn4SGA1sYgNJFhqDW5ckiJWSzzUkcKBfgs4oxpE+IhxKLu
 JGj18eEDGF42G8H+mC4LcS22022ZA6TPt7m4EKMf4HnzQqyYlGBQc7ohOqewiVxuKe0GExsqY3s
 Xpj8v/
X-Received: by 2002:a05:7301:4b01:b0:307:91f5:8eee with SMTP id
 5a478bee46e88-308047878e5mr1122341eec.12.1781156004299; 
 Wed, 10 Jun 2026 22:33:24 -0700 (PDT)
X-Received: by 2002:a05:7301:4b01:b0:307:91f5:8eee with SMTP id
 5a478bee46e88-308047878e5mr1122320eec.12.1781156003791; 
 Wed, 10 Jun 2026 22:33:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Implement modify_ssr, resched,
 pending_interrupt
Date: Wed, 10 Jun 2026 22:32:40 -0700
Message-Id: <20260611053249.3918491-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 7EyMjwAJF-rYOW5vGORm3rjxA9DWdDTX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX41ERDy0OxpBX
 +E4KrMJ/edVDVHH5/5aBcI3foNnAMKVTjr+HLr7aslHU7uARhvdRxQyu8Ujqn1XxZTIWEMkCjqG
 gqcZNuBVdhUV5muSb1cN1LsAvH8gc3I=
X-Proofpoint-GUID: 7EyMjwAJF-rYOW5vGORm3rjxA9DWdDTX
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a2a48a4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=c5yFZwH1WPb9xS9x6awA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX9XbDeQELuhDx
 nL+JDHRnkr8b2QXOO+OuzUlIo50YatIod4/vEvSi5W7JzaAX1A73Y53S4slNIg3pLV69Ntwyr++
 0788P50mfKC7pvdsMWeo/pdEq8zWivWIqJp6HVOiSiNxS0Myyoi1HS2ceVlC7N3JO6vnH6fsarm
 6uYN57NwJuAR/f/eAj/VC/HwrJQPiECqDJuhqfInNx8eNaO9WaGkiUUuPX+T3qnc66yzLL7t45N
 yCKaM74Td67efOL5Da3UAlzYlaa1j9B+plDu8ncGSkTi9JA0cFp0LI5DcOoGUB5kZ6DMnHN3zG6
 MhsC8nL9DdrIh0tYzjU/kHuagu+Nvj8+5FIcBNY4l2N+fEFPxzNqNdmJiZgbNPYzfPrwTubqX4n
 EOAzuvxBxMhzBFABQJKhfvFkIFlqwKg8SYbjT9gCeSfj1Bj3iz0gYt5GJgFfNziwInM3IIWc5Zk
 hydr3CVyzalIWizikPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jIHwgMTQgKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCBjYmM1YTYwNGMyZS4uMjIwNDc1YTI5N2MgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC0xMjI2LDYgKzEyMjYsMTUgQEAgZmxvYXQ2NCBIRUxQRVIoZGZtcHloaCko
Q1BVSGV4YWdvblN0YXRlICplbnYsIGZsb2F0NjQgUnh4ViwKICAgICByZXR1cm4gUnh4VjsKIH0K
IAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCit2b2lkIEhFTFBFUihtb2RpZnlfc3NyKShDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpCit7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhhZ29uX21vZGlmeV9zc3IoZW52LCBuZXcsIG9sZCk7Cit9
CisjZW5kaWYKKworCiAvKiBIaXN0b2dyYW0gaW5zdHJ1Y3Rpb25zICovCiAKIHZvaWQgSEVMUEVS
KHZoaXN0KShDUFVIZXhhZ29uU3RhdGUgKmVudikKQEAgLTE2NDcsNiArMTY1NiwxMSBAQCBzdGF0
aWMgaW5saW5lIFFFTVVfQUxXQVlTX0lOTElORSB2b2lkIHJlc2NoZWQoQ1BVSGV4YWdvblN0YXRl
ICplbnYpCiAgICAgfQogfQogCit2b2lkIEhFTFBFUihyZXNjaGVkKShDUFVIZXhhZ29uU3RhdGUg
KmVudikKK3sKKyAgICByZXNjaGVkKGVudik7Cit9CisKIHZvaWQgSEVMUEVSKHdhaXQpKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIHsKICAgICBCUUxfTE9DS19HVUFSRCgpOwot
LSAKMi4zNC4xCgo=

