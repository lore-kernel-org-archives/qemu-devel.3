Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA7FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39i-0001hz-7Y; Sun, 28 Jun 2026 23:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39d-0001g3-Va
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39c-0006LG-Cm
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:29 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2d5731504741
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=; b=A7WakLaFgOALahmj
 3a74LYR/uvXEP/G7YuVSgXh/GiP14VB9p7ABfpRF6LGgG17EICo7RtQz178F0mG9
 KGuX/iv1FNN/vZKCkN/g+FBnTJpWqQHd5XTkQHWWY4f4Q6Q5xjXsZ7q5qqSFYZxd
 nlPJu+N5sz4/WcP09deh9XUlJMa8pXspchwdTnB/BSaANXhm3gu97CM3usC2Hal4
 iCWLupSu1gKcCin5r/U421Z+2rraUxkBFnctQElCnpuPkJZscUXMtPimTqa2pH1w
 edct6b9eYaYqmZ6e8m5aD4gugFKAVMSei8I7MZ8yDiR58pJ7ZJnBEnxXaguMt/Xa
 XHlpVA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7v82q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:26 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139b70ca7e5so5903616c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705566; x=1783310366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=;
 b=IdJjtPk0Gh2g4g09187ufhzXfTTI7UzSObd58cPFyvzDQLlz7wwGQALi/9Pz1ejE6e
 MpgfyHhaPibLFiQc7EXJRGybfl7diUV0ulpcA8LZcz2S5FytwqS5SxQiSyHVbnBYZ2B7
 3ODQP30+VbWfOT7fbpETl2bqI9uzh7kDQ9kEcyDO2jelzIp63VqpUv0jW0WdL5WEQJbv
 Ch2E8zA93OW5pK2lFlVKPGF0N7pXZnKTRovrDg3Ln8ScJarS/dqO1ekAT1WlLp009Xnl
 sFDNL9yo+hjByESgtfFHcIX0p6/yJibIaRyo0RFn2HzokzUIir4Kl/DUypG7SSt6I4Py
 4FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705566; x=1783310366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=;
 b=pBw+ZRjVkxw8KvRFnwop7hWJK8Vr8fSBN125aUqyZbA6y8L3BQjAFzSzhmeKqcdkJR
 rgugoU0kQzaC/qVc9DfYkU2TJQheWOxzIWbCRe+swKpv+Ww8Fr+Yh4rWr1xLtu+CbJwY
 bSeocN5ycBLzWI4Md240Fs2UORUIFqJovJOj+zPS4GewC+O/s2WtoVozJ25szX+DRheJ
 WOb04qUmvRXDqFln2grD1EiKO/1SFHpvMzMTGGCDdoNWn72l8qkszTh33oQpVoE0at+e
 G2i965aIuN43qZe44Bdu10gKxGaQolYTbKXOyUk0hd2YEDS2O3KegbCZxIFlU8QeFo0y
 mnlA==
X-Gm-Message-State: AOJu0YzKIlg1tOE+Pq+MdcmcnuNDdmFGumLY7BsUEFWUxYYe3BzPwoqH
 Tf4SuHCeGZLCojVzvqjz7SHCc+do6XEfw6JNq5ljXvzdpD7j5yH1Jl0U1wlyPCVF6VTqkgzvU/5
 olqj9rkdl5QPNUKlBl1rR6muwUJaz9Ju9bJA/hayWFakbuaNd8GzifLx/vhkEUWFHAQ==
X-Gm-Gg: AfdE7cnL3vem3ZNlttMZ2Ms25v/1nwMJSzses9VfV7aI67Bfszx+4yEyFqUWCRof2wK
 4nrg3P6fUs8MaL3zWyzB3FEeE4DltoRCGw8fxU26LihFlr6lNtMcTXggzqc6VKVhDrBEHwqe0Yf
 Sjcga53PFt6VkaAXnjVBiVU5hjiSBg7yk803ZtT/n3R2GOle4HmlMkD/DFargKHGCp1w5dIZ8zQ
 nXFjvTaucqzJOHuNgFh5mkSgN1ZUObY9Swj5IMUSPB2vby8ScBomtNTm7Lti1HZmmUV3RyFROHL
 L4B3XPhWr9GMQJ2VztR+UhqQbEkXUNwy4eMBalYaVamHGSttEaj0P926hgM+pfGenAKlydXt/+o
 BXOWuuviJPurZm/nC8TVCllggDuy/wqGKFalx7Nrzd38IP/hImXj5YAx3JuE=
X-Received: by 2002:a05:7022:6b94:b0:139:f3cd:22b8 with SMTP id
 a92af1059eb24-139f3cd2609mr4579646c88.49.1782705566297; 
 Sun, 28 Jun 2026 20:59:26 -0700 (PDT)
X-Received: by 2002:a05:7022:6b94:b0:139:f3cd:22b8 with SMTP id
 a92af1059eb24-139f3cd2609mr4579610c88.49.1782705565801; 
 Sun, 28 Jun 2026 20:59:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 30/77] target/hexagon: Add TCG overrides for thread ctl
Date: Sun, 28 Jun 2026 20:57:43 -0700
Message-Id: <20260629035830.1520296-31-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX+3a21tCC7taj
 VLFzTBfcaeC9bM81YkzA4z3rSvFYVF+MzJz0KTBqNx5Z6nIyslVlkeUBoY11CMD3vBWp8EI59aC
 iI6nJpZD9uRuWFb/pfH9QhV9uf/hGhAdi/z/eojJRLE0SwCQ6xjvWZfLyf6M0fl4gTmtZ9AdgKE
 uF/NAdNV8QnQOIwPpMIQZaprNdH6e6MnS5AWwvvDRmRmtac+Z6H7PDCJqBJkJ4qjCIqdZzL0P9u
 rREapgjex3Zhd1UQ3Q+ME6IjOavYqBOVfF8428kRcbIfLCb6zKTR9gu7QkVmnQxHgIa99/qjBEr
 1g1gXiHNlADtbVo0LPoEbegcM4skodaWJu49z9uayH+m4q9usMGIovimaYG2nwNJlo0tEFBp6tr
 Syvf5IHE2p1d8zE/MUXldK8CCOlulklVJGIiXHSFHOSrzdyiShJNiiWRHE4GrywS9iBBeR+Uc4C
 D0FNZlPTzSXUJpepjkQ==
X-Proofpoint-GUID: yS-rh5HVW-JD-ZdhlkRSaIrrogL6d_Vs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX4cgpCq8XEhw2
 ZwWEYVideSnNLsvQ0aG4tFY7Sydc7E8HALV72iaUkoU/i879/JlvBNev+zzI8+9HQaZKBLDU05h
 MFL1sLCWF4KaEdzoz2bmDTp3i07saYk=
X-Proofpoint-ORIG-GUID: yS-rh5HVW-JD-ZdhlkRSaIrrogL6d_Vs
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a41ed9f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t9Y8JitlK4h6-XB8aEcA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

