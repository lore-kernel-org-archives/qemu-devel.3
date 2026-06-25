Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88113CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wckta-0006tr-9B; Thu, 25 Jun 2026 10:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktY-0006tF-Jw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktW-0008Um-NQ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:32 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9k0Xe2010812
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=; b=Zm/m8Ix0d0S6cF4D
 g0Ib/05PGpO3jwPPg6dYA8t2ZEgQBYKZMVDdiuZOraUJ4/8+ITwCjpotSFDqKoTf
 n1WXsCBv/1DizeKZfM8F0YAB+9/OuporBfNRurrYlHNdpbB24MV0iUt9MtY/PaGb
 Q1DW+7UegnEflzZPEos3w/fX8V29gsrztK//etaiYNW9lTL7aALwDyayFbSJpx7m
 qdODGu1t9w6jJk9mLRlgrFxiqeU0batA9b0JPtj0AnPWPY6zKvbAnvqmjzAInHV6
 FkvnnzxuWGyrMrd5DqWdRYQgdcbYgrCxnYXmhGDceyFeBH0cP/ACTbPGa1JH//6p
 GUDsbw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uhmjjwt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c50cd6cbcso2571320eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397039; x=1783001839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=;
 b=RSlhYtkPw5R4zB+H64Ng5iOasX7l6W74J0AGOeHbXirPVeM2hIIvnQ/N7oFU92CZk3
 eietRfhq5LLyoDNHHczSI1gNNkTTYY5IbpuApHBN2CdIafrSfmvMxhI0XjZE3dQdeRgW
 /HuhKqZo3rmgeW8fIutE1diku2EhIY8A/F00CZgCS9KCLAvD1hVL05iZXrfMITQghBHb
 aG8LlH4190Zox0xSufqpqNr9wRaXGJ1abEGpdp7t42zNkvFoIYk9U7W71jSXenpoZFdJ
 dzoaVw3ckqtEwvGgdJDRnl+w282ZyUzbhMiKNcufFZ1/h/ZOnt9E5ggwt1TLNLJKIZWb
 gPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397039; x=1783001839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=;
 b=FszEdaXTDHJOcaOCvT6ghYDH+Qe3V9FsvaShNqZ6UgB2t1MrmOSNh4SKYZfXgQTgeY
 yz3ZIQ9ZGVI2LBA5JNuZxEfB9JGK6e5j+nLtMS/TPoDGlZlNJMDKKfblBvNtRMHGhyiC
 PCvWUGNdESfL8ZERZFg0JjoHqc1nf+Iw7rSeo4wpkzKKNaebboi0Km++LVrSxLiToJjm
 PYBbeKXPgKAcX3Gq/nXOSX0LWEwlrE1/JUTuuPSW3ChvsjhBwOVGlYhplsgSsAsdxCpY
 NchiW0F7jN+zTkmBKQ6cU2L056GF7fnIzBPDYOsNpAq86ZvHnsAsIUkamkaX2vepVaNI
 VGSg==
X-Gm-Message-State: AOJu0Yz+e79USasDh+vRnatAhf0ZMeeIVg/WrsvPSvIOhP7CntDaRBET
 h5mwPZd2keH1aC8gQ/tqVi9rFXba8qmHLOTnhr4EQKKn1EVGv/24kqJnkckf9CFsda5I6153pqo
 Q3N+DTHy0bvwsbVno/3mV66fWCU7zkBTlUTyl8ixvPE1I/SYHwX2l05AgihhAuu5lzQ==
X-Gm-Gg: AfdE7ckedsWgXQQYR5VJhD27x1Yb5baLjvwVCNQcryZstQyBrJy4/cNniKIy/NUV3Wx
 itjsGUcBmoE5BiMK1sAML7VESmitrjYEpslsIhWOM34isd7Fa48ivRdzYcdV5cue/MR/QoF+g6F
 onfPWD0svfLjrMIifFYxT482OJK1lHJSq4yD0rVlm2rxKkarb8ECFmAPmZja1aCfG4eR8zVHwi1
 df1bGcFkVYFLAzQsWygw/Eju+XXCfynYdwvgsthK35/nCXWmbvrM1l3wQJ6SEHi+uGT89yGVjNu
 KuFKImpK6jUakF+ShTwu2J7rWkl4fKJS9gRGpKMk8qk1PFb3XZM8zM2BqP9bhUYmlooDTdNuRgM
 Owj3XVL24+aMOrQd6qafzs67+ixFs63/vkZi57sPLah0DR0U7p6wUsVHdYVA=
X-Received: by 2002:a05:7301:1930:b0:2fc:9aa8:83da with SMTP id
 5a478bee46e88-30c84d4ac97mr3182337eec.29.1782397038680; 
 Thu, 25 Jun 2026 07:17:18 -0700 (PDT)
X-Received: by 2002:a05:7301:1930:b0:2fc:9aa8:83da with SMTP id
 5a478bee46e88-30c84d4ac97mr3182279eec.29.1782397038120; 
 Thu, 25 Jun 2026 07:17:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 20/76] target/hexagon: Add placeholder greg/sreg r/w helpers
Date: Thu, 25 Jun 2026 07:15:37 -0700
Message-Id: <20260625141633.449487-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=cqerVV4i c=1 sm=1 tr=0 ts=6a3d386f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=wA0rHRt5QP8iJxr38i8A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX9QL1atp85hmy
 n6zwU5MRdefYJPs/uUzg4frssoh7W0ez9p6Nk1HQ2QJyLQj54mvmEQTBnolDy0aaafY9a4GoQZf
 BObqYQXWQPkw4LHQUIvTdLW0gOXTQNaIkhQfuFsAKEHOl46cJsdIJOsejYG9lJ/cS2cJbqeSKBQ
 SeeIb3Y1q1Z4FuUkb08LFKk1JTWQ2qykwF0qyrEKVP1S78FpGwc1hGVxSSqWGn74Q8w4UmbmxpD
 +d2/tg1Gp+3VMyF1C0pWkXCLhN9HQYUDGSJUVXjjZD0eQZKMPoFLYVPx1PfsnBK30p+hXO9kwDy
 FXLdOWRE0gMKs/KXFNNTQAngBcMH9b2SF5tB0TFk6uuVfwLT0I0+GsjrWf2ny0mCjDSjNG7mL03
 +XRFk5r4rTK0B2dYiDY0UpZKBqIE7XoQqaVh7yZVF3gFXGiZtBxXgO+/G4F84Whu5yfEbHmy7PQ
 FgjRk2K9QcU/NCrRzFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfXwEizxwAxww8F
 ZZT2ZbCsDDArTnkvebyEghMXai/jyEBWTDXUiPlSdpRhNnA70WZmRrfbP49GuQzAXoPDy2YJThe
 hErf5p63iyOgY6wW7I+XcGavV53Jjzs=
X-Proofpoint-GUID: OEgirOysIOmxUbzK1dA8--ExOKUrYW1I
X-Proofpoint-ORIG-GUID: OEgirOysIOmxUbzK1dA8--ExOKUrYW1I
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

