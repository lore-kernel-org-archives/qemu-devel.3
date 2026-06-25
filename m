Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736B0CDE00C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcktt-0007vq-HZ; Thu, 25 Jun 2026 10:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wckts-0007ir-0J
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktq-00006V-Ac
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jtKG1723007
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=; b=nXahX0y+zRd3N+O/
 9GT8fc8/l4KkCnjXHkvt1CEp5oKn6ZOBDtEHIq0WfKwAlZhf9p01ufA0s/NO6sa4
 MmhJK7XYblmqR0Aby4lqxMIhPievnGP8wxAgIB0pLC0kdGIFoCB4BTaZuU6pY6ys
 55xT9odh6t9XIclr9LQyq05VEIxfGm7Nb7teVLogBoZIEs9JnFwspy8bFmOF6Nk8
 HankzjKrwMbyavFtbNYBSEyNg2AVaqUlRsoxknDFYodrJyPWWcpZP+9Xvves9Xzd
 AzAGp8TZVjO7qS5WalNFN+FqiDbh/CLZ2MjPiHKBI7ipmU8+5xJeCxgi1HW7Kduw
 dL7JBA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7dvnt6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:39 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c84dc3574so998649eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397058; x=1783001858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=;
 b=AaNzLowhUuL0YD4VhY0p+BSYLTM6IYUDPErj4LawMC0gsIZYdlb2s0tCvya5uX30LK
 HwmIkQYxIkY2ipZBtfQk0h9Wt97wKtPUyroXHvrZRTscjnA9JibLGzCyyV/b8uw6UwVL
 krcsAeqJPWyU/bSu9AoaZ27GlBg/bfWcnQJ8Kbj9llDtItTgM37ddx4H3YvJK6ctj1OU
 MBVySMb+Eph34Rchof+pLCuhRNljt6KajVzvLjr5M1FeTMNFHXxgGwgcTLCO1fXuHvPi
 QvMov0lkB603Ze3T0rNPZt5aFtTXq69+xmergunu52y8+h1Hu/2KUUNMdrQH/MYLa5Xh
 FE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397058; x=1783001858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=;
 b=NMGxKQVboryEKz+UD102n3S1YaXx4ocYzF4kVBnYtWnPk1g9y/t91g0Autucx3tELl
 cG+B2Qnx9zE/LKTh8mYBBezaHf+b8sSnBed6ahegIt+YmoTZQRRHcha0mAUgYKAU73Eo
 5cBrGnQJga+zISqK0jrEQExIATAA+uYvnicECEVYoT3kb4KgvxGOZHS+a3XZdz/d7NTO
 Rj5eKSBrytLuNo9hr3NKJRR44SdCv9gKy32jnJodPbPndOELnAyOMzBTdRnkiu+UbbzJ
 JOSgPu8ddJ3DnQs3Atece6J8XQVGxexEs7cbe4X+gpLeoC7/uy3akFYY3po8cR9JrQT3
 RAjA==
X-Gm-Message-State: AOJu0Yy5Q16zGaFdmbzFjYAGkHC8QjZxRn+48JO7GMidD3E6dZJ1EQGb
 Qx6RS7O7TZ5lplNwqBixonzhihELByoUHx/h2CvjOPV9yPjlIh8bdBnoZljZK8ECK2TJVBit+1S
 p+vQhqypG7ofUT7NPf+xew/o2hfEX15ZdQB0jvkzfnHOeXUOz1tMecYYZAlHIHI1HQg==
X-Gm-Gg: AfdE7clwzJsVhU3Bf+Bzo6CuLT1pBCzm4X8UyME/6aY2Wh7Nf79EEeMtcX3lIFGD1RZ
 /YOkiDo6kwvsvpD3qJG9l2bIfDWdIMdHztUcu93iN3XboXUPDOaBR+p03dlv4NIwwz9TVwprl39
 qnH+CysuxCIWGqBTOjMopjoHJCjyPfjeGY77PQmlEQwcn0nBmmfYn4mgWfM4fFVSB/6Nl+XDa9T
 YJIobpp2NBMD1qFGQb6T8ODHZGqWagaUyAVc8MlykIx/WoVO/iGAndhA0Fhm9Sk87RLxAlRlI49
 qMnOZldjYqrrazvQfpDNQxEIm+bpQ2AkljIOcaCDpyT7g/wpqZsD8sNhpfdakF47zWlkVnxj4vz
 4icil7EXt1WAnoixGWqghwV6M1/WDHtELtnafX5EAxb5bx/Z2kVg68lHxWQo=
X-Received: by 2002:a05:7300:2320:b0:304:54d6:20f3 with SMTP id
 5a478bee46e88-30c84d12a65mr2938153eec.4.1782397058002; 
 Thu, 25 Jun 2026 07:17:38 -0700 (PDT)
X-Received: by 2002:a05:7300:2320:b0:304:54d6:20f3 with SMTP id
 5a478bee46e88-30c84d12a65mr2938101eec.4.1782397057174; 
 Thu, 25 Jun 2026 07:17:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 30/76] target/hexagon: Add TCG overrides for rte, nmi
Date: Thu, 25 Jun 2026 07:15:47 -0700
Message-Id: <20260625141633.449487-31-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: _3H-PrJZ9rwEIR0uUbneiAFAscXs94V8
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3d3883 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=QG2uPxDT_WX1JUO730YA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX1N+4KKsJg5uj
 8kGKYrNrj/x8dFfIIlGKi+zVzVTosBNoF4lZSRb4+CzjUiQk16wWFLZqJQjZMsSN6hRwjO6ouWm
 8wRHXUbFV5y6enQ+iWTtV5sempdbqQs=
X-Proofpoint-ORIG-GUID: _3H-PrJZ9rwEIR0uUbneiAFAscXs94V8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX+qVpGM7a+zV5
 dUylz/BtkuaWG1HOBQWjDXK7ssWKUeTvYfUwtuKl9AtkhM4feODai/BlPE/pBzj18+7M/+AzKr+
 zbSPfs9ZSRpTmlj5YMfqLr8yprVXGpLNFBciq5alD/9y3BgeVOhtkQub/WB9ZcB92+INv/PRbxL
 HWgSPJ0ood2a1C/UiwoNdMFZUo/lb8/ANDJyBLvA6LuPypmq0EfamRZEC/ZnERZFvy9C6WCT8Zw
 CfUdLJCjd0Ao48wiPiWMQqod4zVSDCrzf6483b5mKiYthMA6JWBDDVmXNiAEEfiaf4ivr/mueqh
 m2EoiNui/0lOKhzRqcsKyMzPyJDHcX/qCnCXRBEVDAr5F+W2fJ4q/zWiXZd7eSKaDZu0z4lZTgC
 KnqPZqvpMeV5+0s8Yibq0JB1EBk+bjp4Rvb1B1b6Ll9ibsncgl9BYVjcSnb6rAF4a0VrjobLY72
 PfHEcCWUVA/092o+oIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAxNiArKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9oZWxwZXIu
aCAgICAgIHwgIDMgKysrCiB0YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmggIHwgIDMgKysrCiB0
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgIHwgIDYgKysrKysrCiA0IGZpbGVzIGNoYW5nZWQs
IDI4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5
cy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAppbmRleCA4NjUwZjY0YTZkNC4uMjY0
ZWEwMjc1MmQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKKysrIGIv
dGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaApAQCAtOTUsNCArOTUsMjAgQEAKICAgICAgICAg
Z2VuX2hlbHBlcl9zdG9wKHRjZ19lbnYpOyBcCiAgICAgfSB3aGlsZSAoMCkKIAorLyoKKyAqIHJ0
ZSAocmV0dXJuIGZyb20gZXhjZXB0aW9uKQorICogICAgIENsZWFyIHRoZSBFWCBiaXQgaW4gU1NS
CisgKiAgICAgSnVtcCB0byBFTFIKKyAqLworI2RlZmluZSBmR0VOX1RDR19KMl9ydGUoU0hPUlRD
T0RFKSBcCisgICAgZG8geyBcCisgICAgICAgIFRDR3ZfaTMyIG5ld19zc3IgPSB0Y2dfdGVtcF9u
ZXdfaTMyKCk7IFwKKyAgICAgICAgdGNnX2dlbl9kZXBvc2l0X3RsKG5ld19zc3IsIGhleF90X3Ny
ZWdbSEVYX1NSRUdfU1NSXSwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgdGNnX2NvbnN0
YW50X3RsKDApLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tT
U1JfRVhdLm9mZnNldCwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2lu
Zm9bU1NSX0VYXS53aWR0aCk7IFwKKyAgICAgICAgZ2VuX2xvZ19zcmVnX3dyaXRlKGN0eCwgSEVY
X1NSRUdfU1NSLCBuZXdfc3NyKTsgXAorICAgICAgICBnZW5fanVtcHIoY3R4LCBoZXhfdF9zcmVn
W0hFWF9TUkVHX0VMUl0pOyBcCisgICAgfSB3aGlsZSAoMCkKKwogI2VuZGlmCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCmluZGV4
IDY4MmYwYzZjMjZlLi4wZWMzYTA5OWNiNiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGVs
cGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKQEAgLTEyNyw0ICsxMjcsNyBAQCBE
RUZfSEVMUEVSXzIoc3RhcnQsIHZvaWQsIGVudiwgaTMyKQogREVGX0hFTFBFUl8xKHN0b3AsIHZv
aWQsIGVudikKIERFRl9IRUxQRVJfMih3YWl0LCB2b2lkLCBlbnYsIGkzMikKIERFRl9IRUxQRVJf
MihyZXN1bWUsIHZvaWQsIGVudiwgaTMyKQorREVGX0hFTFBFUl8xKHJlc2NoZWQsIHZvaWQsIGVu
dikKK0RFRl9IRUxQRVJfMyhtb2RpZnlfc3NyLCB2b2lkLCBlbnYsIGkzMiwgaTMyKQorREVGX0hF
TFBFUl8xKHBlbmRpbmdfaW50ZXJydXB0LCB2b2lkLCBlbnYpCiAjZW5kaWYKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3Mu
aAppbmRleCA0ZGU0ZDUzODIzYS4uZThiYmVhZGZkZmIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL3N5c19tYWNyb3MuaAorKysgYi90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgKQEAgLTIz
Niw0ICsyMzYsNyBAQAogCiAjZGVmaW5lIE5VTV9UTEJfUkVHUyh4KSAoaGV4YWdvbl90bGJfZ2V0
X251bV9lbnRyaWVzKGVudl9hcmNoY3B1KGVudiktPnRsYikpCiAKKy8qIE5NSSByb3V0aW5nIG5v
dCB5ZXQgaW1wbGVtZW50ZWQ7IFk0X25taSBpcyBhIG5vLW9wIGZvciBub3cgKi8KKyNkZWZpbmUg
ZkRPX05NSShUSFJFQURfTUFTSykgZG8geyB9IHdoaWxlICgwKQorCiAjZW5kaWYKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKaW5kZXggYzYyMGE1Yjg2MzYuLjJjZDdmNDhlYTJmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTQ4
MCw2ICsxNDgwLDEyIEBAIHZvaWQgSEVMUEVSKHNldHByaW8pKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCB0aHJlYWQsIHVpbnQzMl90IHByaW8pCiAgICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKIH0KIAorCit2b2lkIEhFTFBFUihwZW5kaW5nX2ludGVycnVwdCkoQ1BVSGV4YWdvblN0
YXRlICplbnYpCit7CisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfaW50ZXJydXB0X3Vw
ZGF0ZShlbnYpOworfQogI2VuZGlmCiAKIAotLSAKMi4zNC4xCgo=

