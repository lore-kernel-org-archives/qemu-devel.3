Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC79CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wckuD-0001Bh-EI; Thu, 25 Jun 2026 10:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wckuB-000166-Rb
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:18:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wckuA-00009g-AR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:18:11 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9kBKY1948063
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=; b=WSormFRvrb8rt5u3
 UJtPKtu81Q389jY/W1Fvy/X6LgC3LVZigfqTe6bvno6v5ryPbI4THifV1iX1v0rZ
 c17eLNuYMnH+VQAdNWEZCGU7wq503Y1WFAmNXbbGs1sY/p9HPxo8lAEH1+7UfCoR
 vFrJhHDlZ1Mx5tSapF3i66r/mcu5ezzsiR0eUPvL/1goWoN9dZS3MG5gSnmpfq9y
 ve+kMCT4HEfFy010JO0+8WwS0HwQ/b3hrilH9hXofUyD4tnVhEqwYJTxQPgh61OI
 KX4QKOHC2tn1fsvQEfkRHRB6vEZvutQjVhTzTweyis++8zkucBvNdL8gpw0tRwMa
 LhIoxA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ya8sppe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c17bc96afso4981612eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397078; x=1783001878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=;
 b=bSSJi4t8F4MJn/968zsJ8eejVxumb7RfDYbgcMeY0O64N19wk6B1iMceS89Dk1Qi5D
 rO/4vD6EoevbtRofO21Ty8P6oqb09MI2piiPCeG+JQbpNr6yM3trDhKpUyNHYle/pKxy
 wnXkATJyqCPJUc7CHDAPlj9UUHTG4G5dk4nUC1VWBoIDBD3f2npCOXtehvgOv3/EoH4z
 PUeZgt+UNDqmE52BmztBU4Tk3limsMJMXONC9Ho+/MpwPmkfw5FDMiJu6i8cbGKw0AvH
 FQmjtP1affsgdei8LxmKaUBSo5kpnnE8boI+DXa1qkPwpp/qe0OvJrrpFMYumzOXq5eA
 6kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397078; x=1783001878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=;
 b=p6tjwtOYV0NbeVewiWUPIN8Mewp7zYF3I8yWdeJyqJD8yqdRdLK2wX+pc2iI7BUUdR
 4M7H88MuPYQWg/WUVKXyHsthsa4pYHclScmhcqaIJz96grYHVlvTwosj5/cFGhbEaWkX
 0N7ZPZZNp24xurRYX+0eRWGg6NfH3n5gdN+APhLpZbwV9CsNr4lla2Up/qgIqehZRKw1
 oGLiKFGq0If3EuSbaXIQU75jtfDKiggSbtFJs3FOvI6YzeWnKAMj4scvT+/QTFWbfDly
 fMg2egbo4tTsk4t6oK1oBZU1S7W4NgFab/vug4Q+OuGu3SD9GUHzePDHT0TPwJsptK8F
 qM8g==
X-Gm-Message-State: AOJu0Yy3NqbNwEqHtmdSGoKWi9jWAE7uivbDHPBrsnmIns+yjEzm5czK
 85VLZ17YrWbgztPFAPqg/apqzysT0F8NaKv8azP8pY81q9/mlxjpYF8Jb+qfNnpp2RqnjVnCy77
 QYxGxD6hLD7MPI6O8q+OoBppALCsW6a/joaTlxC6EyYxdxGSzDhrvEW7scHYhhrnreQ==
X-Gm-Gg: AfdE7cmoeKRUpsC+NXB+PPaU8WB0kZ3xacTyNNJxHZuX6gL0VRrUS/M42kmyr39zdD0
 Izj+t42+JPMBATwxyn70fOtHuGmSErWmxlt28at1zwFmpPUH+jERAgqQuscOOZ/Q2Ff4PPVr6vk
 MCvY5hOINbymmH5oTpnreEM4i8v+4w8ihxqUKuznAym6T7pV4lW6YRNTzymERl1N3OVOcLSp3gM
 4j6ZNIC2GT+qW8gxl9y2Lwh6S/J0cWEe/HJgpVFrnxch9apwJ4VXZc1HxgEWYgdsLYAVXsePgVx
 NImEouljrpjPZHrHhYOq5qxlJOzfIhSjAwh7hx2b7QcXTKlLYnCFn0Kk6Z/ho3xu07V4FQIwxRG
 XQFgyODJ2Nfbbj95L3Gu+vqWDy1gXC+3s1fPjlnEoAb+NVkNs+4cR2W8NPaE=
X-Received: by 2002:a05:693c:2297:b0:30c:4832:1ac4 with SMTP id
 5a478bee46e88-30c84d0f0c7mr3357490eec.22.1782397078082; 
 Thu, 25 Jun 2026 07:17:58 -0700 (PDT)
X-Received: by 2002:a05:693c:2297:b0:30c:4832:1ac4 with SMTP id
 5a478bee46e88-30c84d0f0c7mr3357455eec.22.1782397077442; 
 Thu, 25 Jun 2026 07:17:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 36/76] hw/hexagon: Declare hexagon TLB device interface
Date: Thu, 25 Jun 2026 07:15:53 -0700
Message-Id: <20260625141633.449487-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX1Vp5yduwhG2P
 sqGEeaFnlvwFzErTWEscjC8NTuMobXh9AJW6hxBwk7CS2pt0Q6THD6NE3yu66qEsRe7v6fyuXll
 +7ZryuKS3MpjoMJuJl6hRT3PGpfl95E=
X-Proofpoint-GUID: 8zyIQed5KGaE9Se8atR13Z74gV7Y-ymn
X-Proofpoint-ORIG-GUID: 8zyIQed5KGaE9Se8atR13Z74gV7Y-ymn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX9xKKpgQC80aD
 4bMQK+Ve/ELQsenYi8BS83HptIUZUEaSPV9zqP3EJiCcHQW0odGfdSH3uZoIT+g/e3DqkOptrXY
 QADwv1ttZpl21BWodlPrbYftEu+CEZM4gtoe8vw/0aqD7jqVBsm6NEkol8OfELcp+o7a1t7B/lC
 HgkMO3atT0anZq3r11FQCLpd13UPH61S7VHMxww7TdhhyFQuJKjlqGRXUkNjNRvYsr9pnuYfGE/
 984fIp4hpit1bV5ArLKlnRxJT6d3RZFH6FAFT+fyhCAdufttSP28IXfMVuSB3T6Sev7BSDit84I
 +2wddLiruiE+5fyn/aAMV6uW2D3rkryH8JmtatBbCJSNrg60QclQe6FfiWMQ9550sKC+LceuqkN
 1u2jEjAQRLOS4lnNXrjeg32O3As0oHicDrEYuSFA6LdPAtMoGi3i6Gmi1fViPsRuzd2TK1WbhqM
 Td7FFs3w+Kjy4YV1qUw==
X-Authority-Analysis: v=2.4 cv=Z+Xc2nRA c=1 sm=1 tr=0 ts=6a3d3897 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=p_7iY2stt2bzV07uMJkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250122
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

QWRkIHRoZSBoZXhhZ29uIFRMQiBkZXZpY2UgaW50ZXJmYWNlIGhlYWRlci4KClJldmlld2VkLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl90bGIuaCB8IDQ2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oCgpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25fdGxiLmggYi9pbmNsdWRlL2h3L2hleGFnb24v
aGV4YWdvbl90bGIuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uOTBk
OWVkODQwNDMKLS0tIC9kZXYvbnVsbAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl90
bGIuaApAQCAtMCwwICsxLDQ2IEBACisvKgorICogSGV4YWdvbiBUTEIgUU9NIERldmljZQorICoK
KyAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMg
c3Vic2lkaWFyaWVzLgorICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXIKKyAqLworCisjaWZuZGVmIEhXX0hFWEFHT05fVExCX0gKKyNkZWZpbmUgSFdfSEVYQUdPTl9U
TEJfSAorCisjaW5jbHVkZSAiaHcvY29yZS9zeXNidXMuaCIKKyNpbmNsdWRlICJxb20vb2JqZWN0
LmgiCisjaW5jbHVkZSAiZXhlYy9od2FkZHIuaCIKKyNpbmNsdWRlICJleGVjL21tdS1hY2Nlc3Mt
dHlwZS5oIgorI2luY2x1ZGUgIm1vbml0b3IvbW9uaXRvci5oIgorI2RlZmluZSBUWVBFX0hFWEFH
T05fVExCICJoZXhhZ29uLXRsYiIKK09CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEhleGFnb25U
TEJTdGF0ZSwgSEVYQUdPTl9UTEIpCisKK3N0cnVjdCBIZXhhZ29uVExCU3RhdGUgeworICAgIFN5
c0J1c0RldmljZSBwYXJlbnRfb2JqOworCisgICAgdWludDMyX3QgbnVtX2VudHJpZXM7CisgICAg
dWludDY0X3QgKmVudHJpZXM7Cit9OworCit1aW50NjRfdCBoZXhhZ29uX3RsYl9yZWFkKEhleGFn
b25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBpbmRleCk7Cit2b2lkIGhleGFnb25fdGxiX3dyaXRl
KEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBpbmRleCwgdWludDY0X3QgdmFsdWUpOwor
Citib29sIGhleGFnb25fdGxiX2ZpbmRfbWF0Y2goSGV4YWdvblRMQlN0YXRlICp0bGIsIHVpbnQz
Ml90IGFzaWQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgVkEsIE1NVUFj
Y2Vzc1R5cGUgYWNjZXNzX3R5cGUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRy
ICpQQSwgaW50ICpwcm90LCB1aW50NjRfdCAqc2l6ZSwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQzMl90ICpleGNwLCBpbnQgKmNhdXNlX2NvZGUsIGludCBtbXVfaWR4KTsKKwordWlu
dDMyX3QgaGV4YWdvbl90bGJfbG9va3VwKEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBh
c2lkLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IFZBLCBpbnQgKmNhdXNl
X2NvZGUpOworCitpbnQgaGV4YWdvbl90bGJfY2hlY2tfb3ZlcmxhcChIZXhhZ29uVExCU3RhdGUg
KnRsYiwgdWludDY0X3QgZW50cnksCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
NjRfdCBpbmRleCk7CisKK3ZvaWQgaGV4YWdvbl90bGJfZHVtcChNb25pdG9yICptb24sIEhleGFn
b25UTEJTdGF0ZSAqdGxiKTsKKworYm9vbCBoZXhhZ29uX3RsYl9kdW1wX2VudHJ5KE1vbml0b3Ig
Km1vbiwgdWludDY0X3QgZW50cnkpOworCit1aW50MzJfdCBoZXhhZ29uX3RsYl9nZXRfbnVtX2Vu
dHJpZXMoSGV4YWdvblRMQlN0YXRlICp0bGIpOworCisjZW5kaWYgLyogSFdfSEVYQUdPTl9UTEJf
SCAqLwotLSAKMi4zNC4xCgo=

