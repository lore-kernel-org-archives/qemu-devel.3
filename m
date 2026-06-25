Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B277DCDE011
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcktr-0007gZ-TA; Thu, 25 Jun 2026 10:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wckto-0007L9-44
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktl-00005p-QC
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:47 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9kBHP2011058
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=; b=OZcRbVuA7nfnQ9wv
 VkjQbgw0iMbSJGFd++uxiAcEw1lE5MJi8uBwcoQjOKAZlyPJMGKClsb6nGI0NcdQ
 24kZhGTCRiDLMXkGFwsuvwS3YYSDywgmr61Zh2vYLzGnk7EYPbXzol0U3tiSiB7E
 /iRo48vm7iJzjo+ypISp/qXnbsfuoHmuWo3C+l8wG5G1WwRqtzGDTTWnhfgGjeW/
 6PKSL0WTpTKcObR7gAcopyV3taq5oiGWIFADiitPMJvrJW6YHfMkuSTceK7xSfMY
 XG61RjyAGeC4w1W8Vc3FwuFeaxtjLmWt/16H1/RLxdFYFNH9GwQHxGVf4RwJgRvO
 Yb4oVg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uhmjjxu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:34 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so6502551eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397054; x=1783001854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=;
 b=MGc7w0pGH3ctHDSUImy5cXYAyKnwgRC19SarqAeqMJhlmmNZWM+Mv83VWpgFQtLSCI
 +IuBA5iTDlfNvP86jG4kvUq+UoWciZ/zrNU2i6U2L4SfC3yodiP27go1WJEA2QCpGGSk
 /hSsSCooEFpVsMUkF0Pbu5ixiA/8gbDk5UeAu9mfZagJn0j5tMbRTw5lc+6rXsVPvXez
 VjX0henNqQ118/pf/fAz/Ysg/1KUXQg4eJ47ylOFubn0eQgZPwEVRLkGmMvmwjUFdO8g
 3w/4ArcgyyQoE2Q3PNPK0qjKe5tDX5tG7Sr3QemdivBoOvml6V1sDMLs8CO3An8Qh0Kc
 nZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397054; x=1783001854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=;
 b=d5FtE9i0okrmOGWnMzdb6xbqo1bYUu+ZP9/goWxGoUwP2s4BDKGrUzEzL8nNEKBxvp
 QcOB+KhYC6YaMwNvXnoueEnbcR27jJBKifVId40/Bqrj66q+vO8EG9cjrgRtlAGXqxak
 1BYlY837RdbsL8CjyhiloT2CEY+yT3iUoZRhj0nbSJLBe3t8rQwhotywKVCGBbMQKc7G
 KOjJuBy/401OEVshRrTu/z0khsW5Aq6ne4if9pU2Ayo/B1bIXdscRVBqj9L9cp1jlRrI
 oxyCo/ne4o2/N1pX+WMok969AQtflMzb7qgj2cZXJvHTgYoRPllHrprHQfw9OpBNhmbC
 FKgw==
X-Gm-Message-State: AOJu0YxA8NoiTz0GY2W5I+KIerCksPoZIkIxwu1Xqf1dHyLUOdkXpE7p
 Y+O9ChjpLOtoCv/wBXpMxbEDgTLrKg5kfwegPV0Gf+8H89SAt22HGGr12w33lG+wYcKF93aqXCk
 zUvGaCCLZ+66LRFNXHNSlK9KR2fu8J0kdbRRnZC8kQk4q4DY70RPKhXyEpiItjizqRQ==
X-Gm-Gg: AfdE7ckA+PhGp3yV/jhHIws0eOpfWIyGd/f4YHKqXY8J6rxi1gEdThofVjRXESY3J4R
 mcgm9znr5raY0NBJDhugRsPTxx43XcN2DDXZW2BJ+3eI2yAblM+cRhFoiHBKQHOVXmgIdrTizql
 JSStMhJhWWwGdTQmkjMRuVtRAPHVUDJyBMLX4Zr6XDHA4AP/oRwYqoGr/5oIk7jP6WPXkz65FC6
 grYgSXO8UtOQXLUZPDRXW7nlMCKaBuozS+H1mX1GFb/hG8v3/S9K3U4aPBK2obJ1LRctcit1ACi
 zTaVjmGuby7JWPrfotMx9HLrv3EhsBJWcvzNNNdjHhdPGKi0nTqWTn7xxQWDpfOmg5++sMjPxfM
 Cp4K7j2uYnBdhBjXgG29QefzZFosKD02veXv/yPMuAGzd7pk/cuM6JN5WKSQ=
X-Received: by 2002:a05:7300:e6c4:b0:30c:6d2c:2aa7 with SMTP id
 5a478bee46e88-30c84fa683fmr3149191eec.20.1782397053623; 
 Thu, 25 Jun 2026 07:17:33 -0700 (PDT)
X-Received: by 2002:a05:7300:e6c4:b0:30c:6d2c:2aa7 with SMTP id
 5a478bee46e88-30c84fa683fmr3149137eec.20.1782397053027; 
 Thu, 25 Jun 2026 07:17:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 29/76] target/hexagon: Add TCG overrides for thread ctl
Date: Thu, 25 Jun 2026 07:15:46 -0700
Message-Id: <20260625141633.449487-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=cqerVV4i c=1 sm=1 tr=0 ts=6a3d387e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t9Y8JitlK4h6-XB8aEcA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfXwz2b5V9XOBEA
 UENQmkrSc+VlkhwLu81uzc5z1m1UP93KSP3vM0K4Pw+rCpdWNgw1cNa0kSj4UEKkUcQ8QJL7qMt
 2Xo4ZxmlY17Rbmc5Q329zY5kSvQkNGPhWyZKTNxihuVO9jVE2LngqPcJ2kIz+JjXQdc/IL71vEs
 aEjVfBrh2qxXq/56fAAZ17zkPFvjmYq12+MVjIld0v/dLi0uvXMk9I+SoixqqSfoG8PCV5Iirlf
 xJWiJaAgyFGeT9BR19BCkQOMhaelF3fVQUzeyX3ID/m8UEYY/iLl66Bt5Q3uErVG1c24ehdTuy2
 gLFFwFzYY3Yb8KYa+cw9WdORkZLj88QYmekk91kHCTN3xCc+EWPZB1aUSxJONA8O5btB2/uKDXq
 e9hdrNoDuds8vxoJDeoAYHcjMOqKWlqqDGrhWCsZzIMzfuTiuUs1p7xR3OoHNZT7umFfzIu8J2k
 F0Gqjde9iN6GPYhBIxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX61rsqav5HC1g
 8pgCU0doH+jWzFHuvlTlVY5ZBIUVC9MsdDSUkgvGT4zPMdfwhxEaWWA3bgIF0eNS+GGHL0EADCp
 AZ++PKiLI7CjbBxmxagdsbKNxNdItns=
X-Proofpoint-GUID: pwBXpoNueg9EEtYoWxC8_BEtW3mXo6Ki
X-Proofpoint-ORIG-GUID: pwBXpoNueg9EEtYoWxC8_BEtW3mXo6Ki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
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

