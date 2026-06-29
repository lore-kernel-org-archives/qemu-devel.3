Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA7DC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBnj-0004fI-72; Mon, 29 Jun 2026 09:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBni-0004eq-9q
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBng-0003Cx-NU
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:26 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATKEp2656157
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=; b=SlVyx8cQZugShJxN
 cBZCMKLuSQggvAoTev/7z6zCwCfpK2OsDaQ0sAiSjSqK3PseJGU6Qv6aL4ttzYbF
 FhY44x1v7DOg9GG6w4X3Qr6rhrx/OfAjv9+jODvm5w02xdMgWQ1eH/O4Tli8AKbF
 9yAInxnAHuhnlVJbpPJ6FIlq0j9tjCprj8kT9ESpmrOxpGFslkwFbIU3kXt6PDV0
 2rTy//F/Usc7MC/g2GsLu8wo7p7s6g70JNpSkFZxcbRfu68/ZV4nMaOE7qxKz1Xx
 QgLP92RhzJlLodwkVq0XHLrFtaxcfZODAshEcE4CY3pxkkZ68h6lB6iyRxzbnFzZ
 35gleQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7gxst-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:13 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-13b0686d13eso1426872c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738793; x=1783343593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=;
 b=AMB784grxGIIHbZGh2kXHODkABBz1TfD9h0hR0An+axAdGhcW4o3RSlqfB5ZI/5mbL
 DcA0XvEn4RZ13ynXaf92OuqXHmrbtoz6CmLEvB6d2CTjGW/N6dj5vcZItSwR0kesF5Vm
 dakZU/rlvKntkQzY6XJzFpdiQsQj0KMFetSHoKkIRBDmpERkp2OCBU+a+RuEFnzmfwPr
 vZ+VYrpI8rkcWbeN6iiI6bcGrXA23zgT7jsDKclZibbmtM/lhu9sYy6YvF61erc/cEGh
 f+liSBjYYrLC/0ifkCsl89hDGKzTs7QUO6LEOeXC7SlS+Z/K/sW4Aa0kagsWt3JLMkrA
 Nj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738793; x=1783343593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=;
 b=Cn7swCTwvmTzLA8SRYtMOtITvwWLWxRYojVOtdFZTVEfhlPEftCQZ+M+E+evtVayP3
 woXfnEAmYMqCx26+I9oF2A/hRM87xCHto6X/hPCOvlJ9U9vT+lMEc9Gb/pJ+q9XDfY57
 4zrJG0fNwulhIF/5aW+2t2e1HJ0WFqe7CnKMEb+Lhgl86v5FFSIyhwS5afS/OzTDvOYg
 zY0OYL3SwyvzMCOKXW15TpY7mOjwNXm79StZaWcw8r08O5tqJo8EBpVdmLVu5dqmKGGZ
 Y8BnM8bzoFudS+d/csmXQLw41vr0agQHwu0G1hwYt4EZzahgVOhSSGNtC8HPUscBocPC
 v8xA==
X-Gm-Message-State: AOJu0YwzLJxfhFEtnAg3i0hW6dCUlGMf5siE1YnHp0GqckOB5BghsFii
 rFm++OBYcxvtV2OBJkbrPhN61EoRgaQuUsuxuy29gI0nQkbi2S6iX6rJnF7u+65WAOjQu7/W2lX
 M5RGdczMuf57c5dzUkTIRRS8uzne4PEa3shVpfBWvNczrlwFCyglMZgCEDs8tJi3ENg==
X-Gm-Gg: AfdE7ck3iM850KFOJZHheAHnw/2PnqC0RPsUjeaRQ0h/1CTYHKIdKLX4A1TuZKkx4L7
 EUrpAGFPFld3PW+mLlao1jz9tffvE6k5RKpoHz/YGU35sMQFdOpwax1/LDB4MmoBoWxIPI79eKx
 ENMX3yUU0Rl4ZxXN0e4fq+wpeMXU5fhoUCIvMosIiJ4XKGtcDHqPzTCcDaRs0/YnczEJeoBCaAW
 70pAn535cYy4Kpcz5lW0sAcVm/TrX5sN7rOzKh8dOOraWL8chBz+N7M6DrwBVkqY585NAVjd44k
 lvSF5k0+oflbUWhQlitv3JJk4/TfVqMd4EEhkfeMm/+Jlypa0JG0u6yFJ2KbYWGGpGn6WbtsXHA
 2ab7YKNpRhpktphc6YsXj5fZ2XbP/40/hwautqWhQDV7REuotRQYVbbkXHGo=
X-Received: by 2002:a05:7022:60a1:b0:13a:225:e191 with SMTP id
 a92af1059eb24-13b2271d3a7mr432311c88.41.1782738792763; 
 Mon, 29 Jun 2026 06:13:12 -0700 (PDT)
X-Received: by 2002:a05:7022:60a1:b0:13a:225:e191 with SMTP id
 a92af1059eb24-13b2271d3a7mr432287c88.41.1782738792126; 
 Mon, 29 Jun 2026 06:13:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:10 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 21/77] target/hexagon: Add placeholder greg/sreg r/w helpers
Date: Mon, 29 Jun 2026 06:11:36 -0700
Message-Id: <20260629131232.2487780-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX27zhxcUjMDY+
 ZakQx81l7QbgxLc/GbYH92n3/3XxgqOAJbAS2dPprpaLdUfJp4+L4XUGYsj9Q64wMM9hthn50Tz
 110x9BqJ7LEOrNTqXaKa/efhQd1AKz/QCI94ogUNGwJA8yO2Vw0UnywwSmQFTOIidKe5pJ/qgxV
 lzyj6J7G/1RwkPdE4h2duNhMPRaljFz230Wu0sTu1aNkwq1ZEo7MVgHUkwEo9R4cjZHFFQiEkYx
 5oXhKzSL4zjwAniE6ZI15pSpkzq9x24qbQ6KcFYy6UqJpv+aTLDJ6LuJAVYcsXwcFiLBtitFLDr
 1KXHJ8xl+Xhhds6+QbRv7nlpqfHt2nGixueixolXEIf5wrsdFAVlADiq14KKqxmZNzPGK+WCBez
 I7BZiamscOChA/8c5AQRUp0A20whkXz/8h4EY9N/VUMKwxnFmknBBGvw76MBWVrTQ8lqpKC/wl5
 DNQIPgO2ijD5elEBjTA==
X-Proofpoint-GUID: r0hl-_IUvnEJeyfADWmTm1OUzMpiZ0B1
X-Proofpoint-ORIG-GUID: r0hl-_IUvnEJeyfADWmTm1OUzMpiZ0B1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX5SjvqJeEHvuE
 rzLpj1G72opmaOQMWpev2Y1GZl9LE+eNWTglZvOpTbKApMvfDykp1fEGHET0/caThJSKAwQfOZ2
 Oy/35WFIlqqYLsbkZpKv+yMP1/9bSpw=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a426f69 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=wA0rHRt5QP8iJxr38i8A:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDggKysrKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMjgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmggYi90YXJnZXQvaGV4
YWdvbi9oZWxwZXIuaAppbmRleCA2NDQ1NjgyMmJjMS4uMjhiOWI1OWUwZjIgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCkBA
IC0xMDcsMyArMTA3LDExIEBAIERFRl9IRUxQRVJfNChwcm9iZV9ub3NodWZfbG9hZCwgdm9pZCwg
ZW52LCBpMzIsIGludCwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2FsYXJfc3RvcmVf
czAsIHZvaWQsIGVudiwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX2h2eF9zdG9yZXMsIHZvaWQs
IGVudiwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2FsYXJfaHZ4X3N0b3Jlcywgdm9p
ZCwgZW52LCBpbnQpCisKKyNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQorREVGX0hFTFBF
Ul8yKHNyZWdfcmVhZCwgaTMyLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihzcmVnX3JlYWRfcGFp
ciwgaTY0LCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihncmVnX3JlYWQsIGkzMiwgZW52LCBpMzIp
CitERUZfSEVMUEVSXzIoZ3JlZ19yZWFkX3BhaXIsIGk2NCwgZW52LCBpMzIpCitERUZfSEVMUEVS
XzMoc3JlZ193cml0ZV9tYXNrZWQsIHZvaWQsIGVudiwgaTMyLCBpMzIpCisjZW5kaWYKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVs
cGVyLmMKaW5kZXggNWI5YzI2NmQwMmYuLmNkMzI0YzE5YTlkIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAt
MTM3NCw2ICsxMzc0LDM0IEBAIHZvaWQgSEVMUEVSKHZ3aGlzdDEyOHFtKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgaW50MzJfdCB1aVYpCiAgICAgfQogfQogCisjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKK3ZvaWQgSEVMUEVSKHNyZWdfd3JpdGVfbWFza2VkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgcmVnLCB1aW50MzJfdCB2YWwpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQo
KTsKK30KKwordWludDMyX3QgSEVMUEVSKHNyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IHJlZykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50
NjRfdCBIRUxQRVIoc3JlZ19yZWFkX3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJf
dCByZWcpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordWludDMyX3QgSEVM
UEVSKGdyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKK3sKKyAg
ICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFk
X3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCit7CisgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsKK30KKyNlbmRpZgorCisKIC8qIFRoZXNlIG1hY3JvcyBjYW4gYmUg
cmVmZXJlbmNlZCBpbiB0aGUgZ2VuZXJhdGVkIGhlbHBlciBmdW5jdGlvbnMgKi8KICNkZWZpbmUg
d2FybiguLi4pIC8qIE5vdGhpbmcgKi8KICNkZWZpbmUgZmF0YWwoLi4uKSBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOwotLSAKMi4zNC4xCgo=

