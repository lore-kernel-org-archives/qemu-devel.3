Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4406CC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIa-0004hU-CA; Mon, 29 Jun 2026 09:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHq-0003r6-2n
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHo-0006Ld-BS
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASwLP2641470
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k98P3mzy875bIQ72dfi4cpupNsJGfuDp4DlfWaLieyw=; b=SIrMvL9aL/tTQK8g
 Zy/pPMlhmw4/WVnUvTXuZZzI91WJzURPHC5fpC/4EjTlHdmbmHx5FGB+yLc6h9Rf
 QeuqG6wuLDHfqtccZ9dK9Hiw2hblA/G19NMj3qnFYV3P/UIsRI3bxILqbCjj432I
 lmhgWB6cFCn4fE9zW/pGg9UzYgeyUvz/fP+wnRQY0ywXFdlODwQC4Xklg34Nt7WT
 AB9k2t88ujTQH+GjJN+fk9+DMuWE3g6ifoikvvaBeX1PGwRwROHXCoz6k6d0Elti
 nkyJWoViGi5ejNUbc+K7NVBMIFF3mD+VeJQL8Gdh5frXSL41x0mYXQw4Au1shf3N
 Xn6ifg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3npes2v7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c9d85160caso10729745ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740660; x=1783345460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k98P3mzy875bIQ72dfi4cpupNsJGfuDp4DlfWaLieyw=;
 b=kLT3uln05+wBHRRHvRlVMF35gSuAMn5TwLdjgZMa3JlliFdEYuVeJ7ar9PU3/9MJ2U
 mcm9fNi+hLaoDMxwbQcYSpM7x3ReImrUgWx6vjyz0tLoh8S52zwmnJYuXsldWRXun0Ea
 VKT/kWqYGFaJr/AYYAvX8BrQBnFWtnC7EZUTlAaaUoY+0R7MLXm88FejKIeFp0Lqzytz
 Ki0QXjXqhVg7Ksama1ue3XkdpBsxoU+1P4zCbUqinzJ01HPXWxpof6GpwvNc6gcg0sFd
 Yy0EPmC9PBkIqd2PSPgLiMqw2jp/dgcxR20pQh930/We35pnqO6xxWTQTZce9tsBewoN
 Rrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740660; x=1783345460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k98P3mzy875bIQ72dfi4cpupNsJGfuDp4DlfWaLieyw=;
 b=bEBg4glV/UhCr38uRmicmvxzPW1x3H6xuJ+O/FsXYTByKmyfsVI9RzvgN4iSFrp0Ux
 o6s5rfpiCP0kZW/EDOuRNzefzHrc/WjITZSg7TPWtU/gpmfMGFGpfC28e8ILtrNpNGWp
 xHez6tOASSQnc0lTOmxLUT3w9ZIRMg4usp9zU69VevCtRsR6bNHIqfC8Gi+AmhZrH+bH
 o/9ZJvr6UYrwqf77D68RWPejwJXqp2uZ9EZhNyRBOionfcFlNqdVdwsbf6SjgqT4tIP/
 zVvjd1kydrK8zHzUGKKUybXvYXGAJHJBb4JbI80Cr9sVK+AVavxGQjXB9ryPXcEhQhjV
 44IA==
X-Gm-Message-State: AOJu0YwkVvRb9xl0YA3gsrMmxdVq5s3YF/nVRst3bPInPkaqdolbnuCA
 iKuhwHadYJG+km3JKXNfGcohwtEFMAfe5/iGfFgsO71bJoRa1GjJmsU78IW28ihiduybcCmoRyC
 I695c8gsMy0f+ckkssEb26P78wPT5HqxRtE/ObhuwH9NGUa40PsnQUeaqTxQemr0YYQ==
X-Gm-Gg: AfdE7cmMAJgM4wQNr+OkiTgv06pyWzvEH0cyOsKkD/3Ei+2W7ITiUsVjEmZWA16DwOy
 DACa2KPalYWfdyqj0sgTF7pKSNNM5h1m2wYBiu6IJnAl3xYpGe43KG5NVTabf8bOs2gv3mx3L1W
 0S836y39TDeCt6tH+oJcMSncECmIpcoKK0eeH8Rnt6NtTo+JOEoep3g5MN6tRBq603qLwWV4gq4
 fE7ySLsaAgyZ322gUEchVcccP4dgqR41FbSy4t7HQbkcnpX7NWAZgcA7N3UjbVX6T2JwC/AU4rk
 S8c6Yf97RFU5DHDWmER3mjX0XebUiVz/yq2sZQO5kqi0QQBIqo6CEKQUqu1j17PFt/+xT5maNgx
 1Bsc/ySv04rcJq8n4rVzhya2DDOBaehm9Jf1dKgncAl4R0L09uhtK6Rzv9yI=
X-Received: by 2002:a17:902:cf12:b0:2ca:12aa:a390 with SMTP id
 d9443c01a7336-2ca12aaab7dmr13131815ad.0.1782740659880; 
 Mon, 29 Jun 2026 06:44:19 -0700 (PDT)
X-Received: by 2002:a17:902:cf12:b0:2ca:12aa:a390 with SMTP id
 d9443c01a7336-2ca12aaab7dmr13131605ad.0.1782740659368; 
 Mon, 29 Jun 2026 06:44:19 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 65/77] target/hexagon: Add PC to raise_exception,
 use fTRAP() helper
Date: Mon, 29 Jun 2026 06:12:20 -0700
Message-Id: <20260629131232.2487780-66-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXx94Ky8k2euU5
 demD4jr3Sinw/5otbsqllQ6g36N3YLR8xavRxGerpDYzkXmv7jnNiRqz/oJKzAMWLQXZHYk8b9f
 lnmXkfpJh1/awH4aE4lhboGgJ2mXbaWFdnbzv+oSTCx4QYWbFSs3hMXvD1KLALWCtTlwFzpZSTz
 v/Qd0IGNm3gY4+123ozrdQYz+SyIHWUFfJI6VEr97UkhACKF+y0a0D7xlAU9yUr6R9aMAg/FQo/
 HabgwevDwLQYCx2l06hIg9y+z9I/Pq5/ljfYNyIZB7uKYjlEOCHMoFVc9RMCfoT1trQeti+VRl1
 umpa4ccr0JtjuW2qKYRvSgUMt7HGXHa30mAL50IhF8Vg4fSUYRg3OKlZAcZUc3owGuST8MynoFM
 wFcK9RxJiusCzwVYwcQZizgQdjNnJiU8PQPbgNjIkLubCgJ3PEuRyM2oSjUefNmH74zZVsHoAD/
 IvZPsg42jOxwoFLXSqA==
X-Proofpoint-ORIG-GUID: CCU4k5GArym-ViIqxOlU-Gr64vNuGe1n
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a4276b4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4FQt9sIIQT5CW9ciUtIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX+jY2xIYXUkPP
 0nC8QWvxiOVMvgunkcKHbEuKUV5FgPHWWN/dfaNbr85PT74q+1qDPUt+r9SqyFlyTjUaNKN7OTS
 qlFVEc3X0BvkMqYcWRqN80Iaol/TTDU=
X-Proofpoint-GUID: CCU4k5GArym-ViIqxOlU-Gr64vNuGe1n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBZGQgUEMgdG8gcmFpc2VfZXhj
ZXB0aW9uIGhlbHBlcgoKUmVwbGFjZSB0aGUgZkdFTl9UQ0dfSjJfdHJhcDAgbWFjcm8gb3ZlcnJp
ZGUgd2l0aCB0aGUgZlRSQVAoKS1nZW5lcmF0ZWQKc3lzdGVtIGhlbHBlciBpbnN0ZWFkLgoKUmV2
aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmggICB8ICA3IC0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTAgKysrKy0t
LS0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCAyMSArKysrKysrKysrKysrKysrLS0t
LS0KIDQgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oIGIvdGFyZ2V0L2hleGFnb24vZ2Vu
X3RjZy5oCmluZGV4IDRhNThlYWQ4NzdiLi5hMjhhZjBjMjQ1YiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaApAQCAtMTM0
OSwxMyArMTM0OSw2IEBACiAjZGVmaW5lIGZHRU5fVENHX1MyX3N0b3Jld19ybF9zdF92aShTSE9S
VENPREUpICAgICAgICAgIFNIT1JUQ09ERQogI2RlZmluZSBmR0VOX1RDR19TNF9zdG9yZWRfcmxf
c3RfdmkoU0hPUlRDT0RFKSAgICAgICAgICBTSE9SVENPREUKIAotI2RlZmluZSBmR0VOX1RDR19K
Ml90cmFwMChTSE9SVENPREUpIFwKLSAgICBkbyB7IFwKLSAgICAgICAgdWlWID0gdWlWOyBcCi0g
ICAgICAgIHRjZ19nZW5fbW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBjdHgtPnBrdC5wYyk7
IFwKLSAgICAgICAgVENHdiBleGNwID0gdGNnX2NvbnN0YW50X3RsKEhFWF9FVkVOVF9UUkFQMCk7
IFwKLSAgICAgICAgZ2VuX2hlbHBlcl9yYWlzZV9leGNlcHRpb24odGNnX2VudiwgZXhjcCk7IFwK
LSAgICB9IHdoaWxlICgwKQogI2VuZGlmCiAKICNkZWZpbmUgZkdFTl9UQ0dfQTJfbm9wKFNIT1JU
Q09ERSkgZG8geyB9IHdoaWxlICgwKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVy
LmggYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAppbmRleCBhYTM2MDRkYmRjNS4uMDMzZTU2MTlk
NmIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhh
Z29uL2hlbHBlci5oCkBAIC0xOCw3ICsxOCw3IEBACiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKICNp
bmNsdWRlICJoZWxwZXJfcHJvdG9zX2dlbmVyYXRlZC5oLmluYyIKIAotREVGX0hFTFBFUl9GTEFH
U18yKHJhaXNlX2V4Y2VwdGlvbiwgVENHX0NBTExfTk9fUkVUVVJOLCBub3JldHVybiwgZW52LCBp
MzIpCitERUZfSEVMUEVSX0ZMQUdTXzMocmFpc2VfZXhjZXB0aW9uLCBUQ0dfQ0FMTF9OT19SRVRV
Uk4sIG5vcmV0dXJuLCBlbnYsIGkzMiwgaTMyKQogREVGX0hFTFBFUl8yKGNvbW1pdF9zdG9yZSwg
dm9pZCwgZW52LCBpbnQpCiBERUZfSEVMUEVSXzMoZ2F0aGVyX3N0b3JlLCB2b2lkLCBlbnYsIGkz
MiwgaW50KQogREVGX0hFTFBFUl8xKGNvbW1pdF9odnhfc3RvcmVzLCB2b2lkLCBlbnYpCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jCmluZGV4IGI4MjcxM2JkMWMwLi44YTM3MjNjYmFmYSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAg
LTY2LDE1ICs2NiwxMyBAQCBHX05PUkVUVVJOIHZvaWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25f
ZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MzJfdCBleGNlcHRpb24sCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJfdCBwYykKIHsKLSAgICBDUFVTdGF0ZSAqY3Mg
PSBlbnZfY3B1KGVudik7Ci0gICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiAlZFxu
IiwgX19mdW5jX18sIGV4Y2VwdGlvbik7Ci0gICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IGV4Y2Vw
dGlvbjsKLSAgICBjcHVfbG9vcF9leGl0X3Jlc3RvcmUoY3MsIHBjKTsKKyAgICBkb19yYWlzZV9l
eGNlcHRpb24oZW52LCBleGNlcHRpb24sIHBjLCAwKTsKIH0KIAotR19OT1JFVFVSTiB2b2lkIEhF
TFBFUihyYWlzZV9leGNlcHRpb24pKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBleGNw
KQorR19OT1JFVFVSTiB2b2lkIEhFTFBFUihyYWlzZV9leGNlcHRpb24pKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBleGNwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IFBDKQogewotICAgIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2Vycihl
bnYsIGV4Y3AsIDApOworICAgIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihlbnYsIGV4Y3As
IFBDKTsKIH0KIAogdm9pZCBsb2dfc3RvcmUzMihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0
X3Vsb25nIGFkZHIsCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rh
cmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGY1NDUwY2VkN2RlLi5lMDQxOGVlOTkwZCAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmMKQEAgLTEyNiwxMiArMTI2LDE5IEBAIGludHB0cl90IGN0eF90bXBfdnJl
Z19vZmYoRGlzYXNDb250ZXh0ICpjdHgsIGludCByZWdudW0sCiAgICAgcmV0dXJuIG9mZnNldDsK
IH0KIAotc3RhdGljIHZvaWQgZ2VuX2V4Y2VwdGlvbl9yYXcoaW50IGV4Y3ApCitzdGF0aWMgdm9p
ZCBnZW5fZXhjZXB0aW9uKGludCBleGNwLCB1aW50MzJfdCBQQykKIHsKLSAgICBnZW5faGVscGVy
X3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKGV4Y3ApKTsKKyAgICBn
ZW5faGVscGVyX3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKGV4Y3Ap
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF9pMzIoUEMpKTsK
IH0KIAogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX3By
ZWNpc2VfZXhjZXB0aW9uKGludCBleGNwLCB1aW50MzJfdCBQQykKK3sKKyAgICB0Y2dfZ2VuX21v
dmlfaTMyKGhleF9jYXVzZV9jb2RlLCBleGNwKTsKKyAgICBnZW5fZXhjZXB0aW9uKEhFWF9FVkVO
VF9QUkVDSVNFLCBQQyk7Cit9CisKIHN0YXRpYyB2b2lkIGdlbl9wY3ljbGVfY291bnRlcnMoRGlz
YXNDb250ZXh0ICpjdHgpCiB7CiAgICAgaWYgKGN0eC0+cGN5Y2xlX2VuYWJsZWQpIHsKQEAgLTE0
MCw2ICsxNDcsNyBAQCBzdGF0aWMgdm9pZCBnZW5fcGN5Y2xlX2NvdW50ZXJzKERpc2FzQ29udGV4
dCAqY3R4KQogfQogI2VuZGlmCiAKKwogc3RhdGljIHZvaWQgZ2VuX2V4ZWNfY291bnRlcnMoRGlz
YXNDb250ZXh0ICpjdHgpCiB7CiAgICAgdGNnX2dlbl9hZGRpX3RsKGhleF9ncHJbSEVYX1JFR19R
RU1VX1BLVF9DTlRdLApAQCAtMjExLDggKzIxOSwxMSBAQCBzdGF0aWMgdm9pZCBnZW5fZW5kX3Ri
KERpc2FzQ29udGV4dCAqY3R4KQogdm9pZCBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoRGlzYXND
b250ZXh0ICpjdHgsIGludCBleGNwKQogewogICAgIGdlbl9leGVjX2NvdW50ZXJzKGN0eCk7Ci0g
ICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9ncHJbSEVYX1JFR19QQ10sIGN0eC0+bmV4dF9QQyk7Ci0g
ICAgZ2VuX2V4Y2VwdGlvbl9yYXcoZXhjcCk7CisjaWZkZWYgQ09ORklHX1VTRVJfT05MWQorICAg
IGdlbl9leGNlcHRpb24oZXhjcCwgY3R4LT5wa3QucGMpOworI2Vsc2UKKyAgICBnZW5fcHJlY2lz
ZV9leGNlcHRpb24oZXhjcCwgY3R4LT5wa3QucGMpOworI2VuZGlmCiAgICAgY3R4LT5iYXNlLmlz
X2ptcCA9IERJU0FTX05PUkVUVVJOOwogfQogCkBAIC0yMjYsNyArMjM3LDcgQEAgc3RhdGljIHZv
aWQgZ2VuX2V4Y2VwdGlvbl9kZWNvZGVfZmFpbChEaXNhc0NvbnRleHQgKmN0eCwgaW50IG53b3Jk
cywgaW50IGV4Y3ApCiAKICAgICBnZW5fZXhlY19jb3VudGVycyhjdHgpOwogICAgIHRjZ19nZW5f
bW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBmYWlsX3BjKTsKLSAgICBnZW5fZXhjZXB0aW9u
X3JhdyhleGNwKTsKKyAgICBnZW5fZXhjZXB0aW9uKGV4Y3AsIGZhaWxfcGMpOwogICAgIGN0eC0+
YmFzZS5pc19qbXAgPSBESVNBU19OT1JFVFVSTjsKICAgICBjdHgtPmJhc2UucGNfbmV4dCA9IGZh
aWxfcGM7CiB9Ci0tIAoyLjM0LjEKCg==

