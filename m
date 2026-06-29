Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7218FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39C-0001Zi-Df; Sun, 28 Jun 2026 23:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we397-0001X1-K6
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we395-0006Cl-2W
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2cxvM1562318
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=; b=Od6FHCoHJXWvlsDO
 7vH8AEFe2pisKISxiqbuL56S7LfizMSWxzLg+NFLWR9oCgcPa1r2zjM3qTER8i/T
 dtKDRSdYKHjiA6hUyv4wYIig//XAb6uxPGq3WZ1zSAU7ZhEL0ec+mNAOYCOed+tI
 0Hx3K94Ugbv657oVHuLlq3/LFA+NKh4ERZTQcdsRekNNK1MmGazpIvt/X/NBwrar
 P3IODxt/3svaRtnCnI/B7WRnpwvBD1nSx20tq1fFQiMrXde5cl9J3oK9sDdrr5z0
 HzbXHPknfpfr6MrCFdh41rtbmbXi0jw6BWEHIVPyOJMvEHyjfZREa1q39Q8Pd6tf
 ePbXMw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tuvd15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:53 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-138acbc0e69so14149880c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705533; x=1783310333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=;
 b=CeiAHjS7TXVT6x8QX20B/x9H11uHvLEHESF0AE8b5JtJZ90fCXiruWb+VTaEEPqRW5
 aElOI8F/OeApnOb818Gudo1Fg48DpIjkbg4xK7VtYs6B3YcyF8q+0ZrTivkB94ckWne0
 a2yW8PmKInE5/NlflGoxvLpDPyxFPYl7pAspaBC5C9woBxz1FpZNCgSlOxqqx5VwadBr
 Z4fmvLFYj+GpNzAK6kb0lqqzijeBpJzlO/09BcI0yYEr8mmoFe2eQDrR+ulPs2+GTY6n
 w66AiLD1xJPSf7TNPYKZNZHuBupGbfcLqqdY65qPFPZKNddQt+oSjcyYNE3fRnbWbwiy
 Eq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705533; x=1783310333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=;
 b=LACKSjV5S9AQhUnc0auU62uorOAf+WVjGZ7VKdldxeImslJiOHfuRx/HZkvGLrm6Ry
 gPSzSfxmhBZnMj+znZ7I5xAH9+FqOmklGAZHEkEEPRInUa5nfgYpZHO058V+lSEuwYOW
 VBdKsQspzwEDpH7P1kINISt3grHaKAgNV1UA5PsgNuL8OyuAcIv92BvCePdqWe++uDaX
 D7QSERfukhCyWCMYWKk1/5/F+DiovWgUBqSp1OlLJZFynUbx/WKSF44oPinYc1Yrf7BK
 USwrydcU6iuwo5o6/2QReMIUHMTYkg/UPEfjETZj5wcQRxP2B68CTmH9P7I5AhjyoMy+
 Ku4g==
X-Gm-Message-State: AOJu0Yyaf7igxzz21x1OXje07hUW3V3S07owtdCDqDQ3AqLMbCUQI3w4
 FWjyR0jRnnH6EjVxIcd20e+WSG3eZIBFeBif6K0f/75JK6Kf8o0TzYLLNosvFdTTv9m1NneCpJ8
 8d6lTBLdUx7gfbHQ79enxOuN3JZfYYestZI+vZPBa7SFAYpvZ3HGOvzxVCYYpKI641A==
X-Gm-Gg: AfdE7cm0FkFUXleV0AAR1md396tEmvQOBC0UqdRiEzeqQHbVms2s04X+51rPjKAUJ5n
 tJxnried9842wNdgz+g4kFiVGUVbr2Avk9YVvZphyAc3/vmQ6EioQ5enlVMpGv6HHltH7MOduSp
 ssTf4vk3x3ieqoAoQnSpudUKRnQnnO6kcsjRjLD3Ql9TWhTxVgp4fhZl6hkOEButKUFTvmdGanZ
 EyBDBY5iIZmPqNg8HytBD5WwlXubPlT7/V0KtXmbwQ7AMhVPwgmzGwb+KWRZXwlSuwPse7LYReT
 rorFoShiRlJiLKP49A4xIKs0diB96qstLQllO4cwtX9tVs4LH1u8KLw29FQX+Jl077ZAWdRsW7t
 wUuNh4HOX3dPPuisGInNKh4H/4jxLSDH7zh5/AJWThq2ki8rdtqjPwzp+/iA=
X-Received: by 2002:a05:7022:412:b0:139:fb6c:b37c with SMTP id
 a92af1059eb24-139fb6cb3c5mr2477694c88.21.1782705532762; 
 Sun, 28 Jun 2026 20:58:52 -0700 (PDT)
X-Received: by 2002:a05:7022:412:b0:139:fb6c:b37c with SMTP id
 a92af1059eb24-139fb6cb3c5mr2477669c88.21.1782705532258; 
 Sun, 28 Jun 2026 20:58:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:58:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 08/77] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Sun, 28 Jun 2026 20:57:21 -0700
Message-Id: <20260629035830.1520296-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX8YWTgPqzUJTx
 RZIm/51J7gzANApTsfKrTHOYJv+2dIKwrwJn4Is7e39ifM7P3KB1t3XdB1isIy1bpdWFP0WdqwM
 1kq5O/O6/DWMjLV63OoDMVgWmBmvxMU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXxGlxLV4OPTCj
 +VM6wQ5WoKgIcont5hVPkF2Vls636fvNB9hgd4uhqEMPjGpDjA5UWRgsOoW8LHg+HB27gEwdTLm
 2Ho2md4PVXpw0BfVwsfhVltaopK7Znz6mxp6882n8hKt1LmAlvwcTi7Aqns5/Fip+jB+pvRGnEX
 fZooHNcXqFk61YNdx4v6JsfjP1irYgDHx17CugVFn4Jwgk6+ssPpTQOj/ZztrQ0GBjydDaVFRP4
 VmKApQMtzIiBdMaFtX6kSj4t9fV9rFOfgdC4a/fub3Ya6UxCCDZ7KUb5Gl+pwczfWyT05DQinso
 iiTbbrqxs9+0f0kI9oKzkXfYVQlQIrdoilbN9cbaddB00VZnsH/izwteM/VrfenONgmBHjMW9+/
 ZSqnQtH2M9XFWhBwPkCUaDSLTC0x/CyWvRTpsOwKihxjsZxFm7m/zoGkxpxk8MungMesbVbTleH
 YNIYM8EwGZOqW4K6vyQ==
X-Proofpoint-GUID: zI1S_2zIbDFGPsbAg8skuFvOjpbLRd0c
X-Proofpoint-ORIG-GUID: zI1S_2zIbDFGPsbAg8skuFvOjpbLRd0c
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a41ed7d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=ZLKCIdW5I75hk_SXmpcA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCBlMzdkNWE1MTRmMC4uMjgwYWVmMGRm
M2YgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMjQ3LDcgKzI0Nyw5IEBAIGRlZiBuZWVkX25leHRf
UEModGFnKToKIAogCiBkZWYgbmVlZF9wa3RfaGFzX211bHRpX2NvZih0YWcpOgotICAgIHJldHVy
biAiQV9DT0YiIGluIGF0dHJpYmRpY3RbdGFnXQorICAgIGlmIGF0dHJpYmRpY3RbdGFnXSAmIHsi
QV9KVU1QIiwgIkFfQ0FMTCJ9OgorICAgICAgICByZXR1cm4gdGFnICE9ICJKNF9oaW50anVtcHIi
CisgICAgcmV0dXJuIEZhbHNlCiAKIAogZGVmIG5lZWRfcGt0X25lZWRfY29tbWl0KHRhZyk6Ci0t
IAoyLjM0LjEKCg==

