Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F88CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXzA-0007mU-Bi; Thu, 11 Jun 2026 01:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXz8-0007m1-ML
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXz6-0000qt-Qi
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GPvx3817100
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=; b=FI
 NGwTgHsMPwFXixcGZb9RccepJJOcmADjmHtGrM62kqyuqTxz5dcteyrumjB7O2EL
 AwpV68p9q/SpxH1HA7pxcvrb/sckUjnfEPLU/l7mj5G+jrJWNrbAuvMVlBPTIWLz
 MsxEMsr3knF83DwV1UhW3NXlqBjNS8a3nb0hx22mYlBLIB3thzTIOuz8WMd00AEH
 nYm5NCG/yDhKqfEuQLzZkblxK4rASD8kj05FEdN0aXzYY1daVxRm+ouObI6/LhOl
 dPZyzJf8c0F0w900PhJ8j32GfG8XGUVCaHr9h5soXKIrA6VPbbBiTgUF9LK3e8QX
 12xS/BJvWqaOA3wQGpyg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6usrqt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304df51ff3eso8597514eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155773; x=1781760573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=;
 b=Wa2QHBjkxLnQu7FKqWbm6+HjFF7BvW12eyZdDKyd4mI6Nu8zN3rNM5hHetb1COzTdl
 JiQc1lLwNPNiwGeWuOcLF2oJvcfux3LE3ZYT0A2Z1j/vEaGvmjP5xyszy0ivWhkL+nn+
 8lKQPJAtphv8XwTB3haCigmnQs6x8NP39ZcI/NvcadAtkq57UcJGrvzWGRDLih2vnA2a
 g7kBNnBRTKBPAZIUhICzZDNkPC+WWDfyp0FRYGgk4TwiRbeA3Z2ZYIULwEKkPKlTrJ0b
 odNjOQdzoBFwhctUcWTaSVP+yyL5dnQdWelTmGvDYX7+YaWuADC+sljrCdcERkQRgjjV
 fYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155773; x=1781760573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=;
 b=U9dxD7leYLmmlnjZthyIok7bB6/JK/iPhGo0rgFMA/4E93/BSwM7BbR8iCUSlfM+tA
 6encktWcF0O15THO8nnUCP75nyZ3M9YuzE8un6+kxrCBHFZFQ4DgEyRGogCMmsMHjL+d
 bQyntLKhYUt+VP5SQ5EJU3yjXpmIUO/z5J9QqwcNmIBerQLRnri6bHKZ1KHSbH9ENblR
 nqKbYlHI32KOlGfH2S0ghdjL7dpVLQ7Vqbpcdv16q/j9IkVfCRn85YrdDVPv3gVtCqOO
 IRPqhS6uJM5u7mXGRnfvQL9OTY9n02fxkQVohknmDp9diET19EzQDroS6NYzYdD3ym14
 20mA==
X-Gm-Message-State: AOJu0YwH1IbyfoP4+X/OKggC4rmRhE8RIZX/Zope/RtRXeYWwWrRcFc9
 MzMiz7dXFtAxJWoH74EnHjvvoXQApdvlSVnfXoSqTb4flc2zkX8rtvgdP6HvPfgi3PLLsL7Tt6g
 pxvrI5lunniXSq8Ngofc3J2qIgJXUoaDTj6bIdG8SaY/M1aFUC0/aX9t6mUbM3yAfXw==
X-Gm-Gg: Acq92OHXw1oIgv5rpalVHvliRr0TeYghj4AuXoSxWzZKXg2k9w8s7T8i89DV6WpHAfn
 bO4wjZmEYeJK+eYfHtWZhzcZ+ndKM3AP6xejC0c+vg3UFL32UJ1Kq69Odpx2WiCFvMRycICSDsw
 glrErouvqPHQIIysQMCy/72m6r2Y+5lIVgFVZPUxNtANFukjy5PdIynf9YsdiKCbyLhnMr9bN0H
 nbdsSd85jJl9SVNaE9Ry2xuxqcUms8LBzoKMrHHbxG0cgOuO9lxjvwZY9QSJkeCShH71XAXx3SV
 XhGWykxQ9EYQbD/e91CWPkbMyan2eTIvFSFqy3xDm93AlrRzHvdP1uxKgvv9TNlp4gJmSlcVNYM
 tURPIjQzWIiKqsjVIogjeL5S0JZVtiaSS2ADXlTVLGbtIBw0PnbkdJ7OJ44Jv7wUA3DiCpBDlJ4
 zeIOMQ
X-Received: by 2002:a05:693c:83d4:20b0:304:e6f8:7cc6 with SMTP id
 5a478bee46e88-30804a0efeamr588743eec.19.1781155772786; 
 Wed, 10 Jun 2026 22:29:32 -0700 (PDT)
X-Received: by 2002:a05:693c:83d4:20b0:304:e6f8:7cc6 with SMTP id
 5a478bee46e88-30804a0efeamr588729eec.19.1781155772249; 
 Wed, 10 Jun 2026 22:29:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v8] target/hexagon: Add vmstate representation
Date: Wed, 10 Jun 2026 22:28:39 -0700
Message-Id: <20260611052857.3911981-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a47bd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pDBHowQsxXgegazyqkAA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX08KfL+HhB71m
 +ayBE9gWB1lDXmJRGnYLGGV1UnuRbXIM4PTSAVYgLUHyKX4FfGUaiyaDsY8L2EYPfxezbzmqJUo
 EMGAbSEjcCCqO/ZJC7hBxuqcoYAcGS8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX3f5TEMd9ehCF
 ojOeygCpU1B0UxhA8e/Mk/+p76QJIa2KdErB7AF5qx998GcQlylU9XKcRBNY8SJLdLCjpn5wGuw
 HkC0a7mBKyVeGUd0Hzg2Zq4u5ZtFYDzx63xsGJhHDDotj/oPDTng2EbIffkiCNFmKXe435wMbcr
 jefktEBbVde8Zmg4IJ/vdWPdhe59r6nKzzYziKCAljOZ/k0QnPyXaUMN4kGDaM6BQqfkVnMyqgI
 YWRoMpBLgBICo1SwjzAjc5AF+HcL8vLeLiirFCBdTCiG0+EeKkjlQt8T2WaJP2R/2OK7xI2rQsv
 0Q/XnBXAItOfKQtIXXDm6osAifCCyiL/L+np/m+9ZbCkBnIS5cmk+B71gmVV9asmyWDlC2GLOx2
 52q4n5bcxSyV/QazBPUeZBB7xpeNeR1+KeBdJnAFIEtXxoCbQMD128/BXRxsPTjf+rufATPXGKw
 82a6FiNSnRwi65nmynw==
X-Proofpoint-GUID: 9A6sZ-z_dPpuTJO5YgvfR6i7oo2z2N4K
X-Proofpoint-ORIG-GUID: 9A6sZ-z_dPpuTJO5YgvfR6i7oo2z2N4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFJpY2hhcmQg
SGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFn
b24vaW50ZXJuYWwuaCB8ICA0ICsrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgfCAgMyAr
KysKIHRhcmdldC9oZXhhZ29uL21hY2hpbmUuYyAgfCAzMiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vaW50ZXJuYWwuaCBiL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmgKaW5kZXggNWZjODM3
YWUyMjkuLmNkMDZmZjQxZDRmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CisrKyBiL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmgKQEAgLTMxLDQgKzMxLDggQEAgdm9pZCBo
ZXhhZ29uX2RlYnVnKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIAogZXh0ZXJuIGNvbnN0IGNoYXIg
KiBjb25zdCBoZXhhZ29uX3JlZ25hbWVzW1RPVEFMX1BFUl9USFJFQURfUkVHU107CiAKKyNpZm5k
ZWYgQ09ORklHX1VTRVJfT05MWQorZXh0ZXJuIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0
YXRlX2hleGFnb25fY3B1OworI2VuZGlmCisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBkMzBlNWI2NGVhYy4uMzA1
OTE5NmJjYWMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCkBAIC0zODIsNiArMzgyLDkgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVf
Y2xhc3NfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0YSkKICAgICBjYy0+Z2Ri
X3N0b3BfYmVmb3JlX3dhdGNocG9pbnQgPSB0cnVlOwogICAgIGNjLT5nZGJfY29yZV94bWxfZmls
ZSA9ICJoZXhhZ29uLWNvcmUueG1sIjsKICAgICBjYy0+ZGlzYXNfc2V0X2luZm8gPSBoZXhhZ29u
X2NwdV9kaXNhc19zZXRfaW5mbzsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIGRjLT52
bXNkID0gJnZtc3RhdGVfaGV4YWdvbl9jcHU7CisjZW5kaWYKICAgICBjYy0+dGNnX29wcyA9ICZo
ZXhhZ29uX3RjZ19vcHM7CiB9CiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21hY2hpbmUu
YyBiL3RhcmdldC9oZXhhZ29uL21hY2hpbmUuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAw
MDAwMDAwMDAwMC4uMmRkOTU0NjZlN2QKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdv
bi9tYWNoaW5lLmMKQEAgLTAsMCArMSwzMiBAQAorLyoKKyAqIENvcHlyaWdodCAoYykgUXVhbGNv
bW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vic2lkaWFyaWVzLgorICoKKyAqIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUg
InFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIgorI2luY2x1ZGUg
ImNwdS5oIgorCitjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdSA9
IHsKKyAgICAubmFtZSA9ICJjcHUiLAorICAgIC52ZXJzaW9uX2lkID0gMSwKKyAgICAubWluaW11
bV92ZXJzaW9uX2lkID0gMSwKKyAgICAuZmllbGRzID0gKGNvbnN0IFZNU3RhdGVGaWVsZFtdKSB7
CisgICAgICAgIFZNU1RBVEVfVUlOVDMyX0FSUkFZKGVudi5ncHIsIEhleGFnb25DUFUsIFRPVEFM
X1BFUl9USFJFQURfUkVHUyksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyX0FSUkFZKGVudi5wcmVk
LCBIZXhhZ29uQ1BVLCBOVU1fUFJFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMl9BUlJBWShl
bnYudF9zcmVnLCBIZXhhZ29uQ1BVLCBOVU1fU1JFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
Ml9BUlJBWShlbnYuZ3JlZywgSGV4YWdvbkNQVSwgTlVNX0dSRUdTKSwKKyAgICAgICAgVk1TVEFU
RV9VSU5UMzIoZW52Lm5leHRfUEMsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
MihlbnYudGxiX2xvY2tfc3RhdGUsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
MihlbnYuazBfbG9ja19zdGF0ZSwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMy
KGVudi50bGJfbG9ja19jb3VudCwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMy
KGVudi5rMF9sb2NrX2NvdW50LCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIo
ZW52LnRocmVhZElkLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52LmNh
dXNlX2NvZGUsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihlbnYud2FpdF9u
ZXh0X3BjLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UNjQoZW52LnRfY3ljbGVf
Y291bnQsIEhleGFnb25DUFUpLAorCisgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQorICAg
IH0sCit9OwotLSAKMi4zNC4xCgo=

