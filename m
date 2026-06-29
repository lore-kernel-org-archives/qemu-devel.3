Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05448C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBnz-0005Wk-JG; Mon, 29 Jun 2026 09:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBny-0005Md-5W
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnw-0003Fw-Fv
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATpUW2656706
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=; b=Is2SCTgbQq+pORGb
 X46hwvNsGut/Y9BdiXk/jJtWjRMW/sqnt2kcCh8YZGRXP3MQodr1jH9G5Px2oLvy
 Cxos57mWyqX3hu+tFOqKeLXZNyV1XGBBlLiGlETLO9+eEDsghCVwCwN/jgsyW1mo
 XZ53jE5Jww9CXj4idZZPDmxGcO9Nd5cOxnEXoC1q04/aKziPylaRm7WZ5K3xDajU
 mSE2sCyI3NCaQljTWqybnQ/v/rxiIweQm2SoWqCS2FeA/jDfEoGquEa9+R+oTFvG
 +J0xDSwAUKrh2d7+1TeV3VuDkzOkCPrfBEXj92H/M8sJ9h2NX3UeUeHOfnHX3OI3
 29t6Mw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7gxuc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:29 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13b0686d13eso1427600c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738809; x=1783343609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=;
 b=U9bCykQ+MYOWZ925u5u0f+JglfBfXC3+2sXLhomxe+RpYwPvtDlCQeynudCvP3R4F6
 nbC7M9ehTmCNwaHY3zrX3YXYbd8xB7agtGT4b2PGyA0eUI5kJ3kDFOB5yA+ns+KQLGd4
 g98FZT7Q+KZOjY/DFFoI43Rxe2Rx5OiA5fc3tWAXQ+FmHMSGEUSQY0lchfPDPZJCkYWw
 +ykKEhtGC+uN1xAK2fnwVo0WP3iecHoDfrp7Q+kH4DVrqb5rN7AeLyec/P7RVRGWpr5L
 F1bdNTChgitpF71WA3T9tebdABfnmsNFUql/65oE97aqouqm8Ul3UkHMGV9fuQpgxSpj
 B3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738809; x=1783343609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=;
 b=XcAhELQ1Mxoo6g+6496MaaHpQPQ4CdmXtjwbCgjaoRrEB2tQXSLLruhkPOjfatOKSz
 iE1EoHNNEq7THlGJhvbFM4l/JsfqiuXwO5Jb93KTCiXY2Z2QZQWM/vpnsKtryJSgGaHs
 PpOGxonpVWYHt2OI260oaj9arY7i6sNkVvG4rHyj0mfeN74hSY/snx+c80mSuVnfb4ZI
 YuugM39ZDVerk3AnAjNxyPx/3rvMz6FWh+AxqpBAtEI+lqi2nwzAb7iyDM1/Ly5XOpb0
 TcYIpbxWbP93bx9hPoCDuFP7iWU9DBIC9gZ89G8P+vzNiACKXUYoUYAQZA6qhKt3BKo6
 OUXw==
X-Gm-Message-State: AOJu0YyAP62d3KzRuK6LcmDh1PWqWysrjOR6OUKWFobWr1a+Su41V1Ce
 BuYaC+S0TtW2jqsaE35fGJo1fw/pQpCKSO+6dYHFlFkfASSr4jyojL36lrMl2gjPKEtk/AYmIII
 Gko3qkCG7tY5S8R+NV5lrws5K8FaEneIDfe8ihpR2FG14BlLA3fDUw+NFhaKViA6+cg==
X-Gm-Gg: AfdE7clr/dQlT01pPTjr83J1aDkUbiUzgllH2d9bPejiU9Zhk+7Tlam9QUsu1yaiGvE
 1ip0ajzOE42k5ITzNDkwt5ZYntwRc9b+Cm97Hfn6cXfDQc2R0RfgbEnMMaQV1MLupphZtljKgM/
 Tz6vbzggZArNhNR1qIBkFq7WbTX78g0g/tmRhUImk6HZzqxpYPCG7fh4fL3RTZ7T9UHLfuG+SVt
 1DMQgna1cdzesmbaEp4fWaFYHmlkosIcF/OspOeyDl7ms08HSFndMxpZuOBHGI3s3gjIlkADiiw
 CdfkzuVXrkkk9Gt0sWIDVnsVExxcz9UfrahnR9/wYxJxOfEFF7BUE8H/1HTF+i1eXdKdr8bB5pL
 DNW6Q24acmEXcO1iZmWXcbNIWvpJUG7ZtEIYlhMrFnJfnATGdy+8QOdqnQI8=
X-Received: by 2002:a05:7022:60a1:b0:13a:225:e191 with SMTP id
 a92af1059eb24-13b2271d3a7mr432816c88.41.1782738808572; 
 Mon, 29 Jun 2026 06:13:28 -0700 (PDT)
X-Received: by 2002:a05:7022:60a1:b0:13a:225:e191 with SMTP id
 a92af1059eb24-13b2271d3a7mr432796c88.41.1782738807961; 
 Mon, 29 Jun 2026 06:13:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 30/77] target/hexagon: Add TCG overrides for thread ctl
Date: Mon, 29 Jun 2026 06:11:45 -0700
Message-Id: <20260629131232.2487780-31-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX5B4DYfwKnqpk
 ALp7AyLHYUAAiLjBuP96kbunpYeIXo9kUC/5Xcqb8rKYX6yj6yGPZps87aqVGgnW2MnGl9sQFCt
 bbe5Z56ar3EcdzEA+njeYHO1MlDbEF478Qg5npaIIUsVIb09UJi2D9prclZR6JPPbczU9SLNSF5
 VWKZ1crN/Tnn7TjZb1XDGcMjRhcbhuoVyjEbNn8fafOWtnkkWyZ+mR2Y7DcvvYRlytBy/5qC8UY
 ZKS/WQf/RA3rcQoAWmDDK9VbCfSM/rlnF2LkKANl1wJHKlOY1I7XcXfjjwn+YGebLJ6ZpI2yXfz
 P1oqh44rnbY+TkgGiu1oFwcLASj3sJeF00w/ULsAoXxx9l7zjhSM1nrFlOoyEWbP2H3TWZsHaQb
 Fik0/gbHQXLqmwJvYGgBFoJfZWb/7W3oDS3GuTt35vm2QLf/jN/FI9UC3wihW+wvXgIU7nkCdLS
 Nh3YlHxy2boCosGMNPw==
X-Proofpoint-GUID: lJGCC-RUnGXuRZyYG4RqHXXcXma6mILr
X-Proofpoint-ORIG-GUID: lJGCC-RUnGXuRZyYG4RqHXXcXma6mILr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXxXAET7ksu402
 SLrtiP5LfrxK9Rd7P90XyawcvcdIcUlush86UOSg8f90R/8qvXvvSEULrO5nortXU5ascq+mJtt
 ZPXiEm71yeofFP/rJ3c/jpEzfgn+xyk=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a426f79 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t9Y8JitlK4h6-XB8aEcA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Igc3RhcnQsIHN0b3AsIHdhaXQsIHJlc3VtZSBpbnN0cnVjdGlvbnMuCgpSZXZpZXdlZC1i
eTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1i
eTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9o
ZXhhZ29uL2dlbl90Y2dfc3lzLmggfCAxOCArKysrKysrKysrKysrKysrKysKIHRhcmdldC9oZXhh
Z29uL2hlbHBlci5oICAgICAgfCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAg
IHwgMjAgKysrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmggYi90YXJnZXQv
aGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDRjYmJkZDFmNzBiLi44NjUwZjY0YTZkNCAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAorKysgYi90YXJnZXQvaGV4YWdv
bi9nZW5fdGNnX3N5cy5oCkBAIC03Nyw0ICs3NywyMiBAQAogICAgICAgICB9IFwKICAgICB9IHdo
aWxlICgwKQogCisjZGVmaW5lIGZHRU5fVENHX1kyX3dhaXQoU0hPUlRDT0RFKSBcCisgICAgZG8g
eyBcCisgICAgICAgIFJzViA9IFJzVjsgXAorICAgICAgICBnZW5faGVscGVyX3dhaXQodGNnX2Vu
diwgdGNnX2NvbnN0YW50X3RsKGN0eC0+cGt0LT5wYykpOyBcCisgICAgfSB3aGlsZSAoMCkKKwor
I2RlZmluZSBmR0VOX1RDR19ZMl9yZXN1bWUoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9y
ZXN1bWUodGNnX2VudiwgUnNWKQorCisjZGVmaW5lIGZHRU5fVENHX1kyX3N0YXJ0KFNIT1JUQ09E
RSkgXAorICAgIGdlbl9oZWxwZXJfc3RhcnQodGNnX2VudiwgUnNWKQorCisjZGVmaW5lIGZHRU5f
VENHX1kyX3N0b3AoU0hPUlRDT0RFKSBcCisgICAgZG8geyBcCisgICAgICAgIFJzViA9IFJzVjsg
XAorICAgICAgICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKKyAgICB9IHdoaWxlICgwKQor
CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFyZ2V0L2hl
eGFnb24vaGVscGVyLmgKaW5kZXggOTU1Mjg3MTMzZTQuLjY4MmYwYzZjMjZlIDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaApA
QCAtMTIzLDQgKzEyMyw4IEBAIERFRl9IRUxQRVJfMihncmVnX3JlYWQsIGkzMiwgZW52LCBpMzIp
CiBERUZfSEVMUEVSXzIoZ3JlZ19yZWFkX3BhaXIsIGk2NCwgZW52LCBpMzIpCiBERUZfSEVMUEVS
XzMoc3JlZ193cml0ZV9tYXNrZWQsIHZvaWQsIGVudiwgaTMyLCBpMzIpCiBERUZfSEVMUEVSXzMo
c2V0cHJpbywgdm9pZCwgZW52LCBpMzIsIGkzMikKK0RFRl9IRUxQRVJfMihzdGFydCwgdm9pZCwg
ZW52LCBpMzIpCitERUZfSEVMUEVSXzEoc3RvcCwgdm9pZCwgZW52KQorREVGX0hFTFBFUl8yKHdh
aXQsIHZvaWQsIGVudiwgaTMyKQorREVGX0hFTFBFUl8yKHJlc3VtZSwgdm9pZCwgZW52LCBpMzIp
CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggYzkwYjc1NzI0MTkuLmM2MjBhNWI4NjM2IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYwpAQCAtMTQyMCw2ICsxNDIwLDI2IEBAIHVpbnQzMl90IEhFTFBFUihpYXNzaWdu
cikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykKICAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOwogfQogCit2b2lkIEhFTFBFUihzdGFydCkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IGltYXNrKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKK3Zv
aWQgSEVMUEVSKHN0b3ApKENQVUhleGFnb25TdGF0ZSAqZW52KQoreworICAgIGdfYXNzZXJ0X25v
dF9yZWFjaGVkKCk7Cit9CisKK3ZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB0YXJnZXRfdWxvbmcgUEMpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwor
dm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykK
K3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCiB1aW50MzJfdCBIRUxQRVIoZ2V0
aW1hc2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aWQpCiB7CiAgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsKLS0gCjIuMzQuMQoK

