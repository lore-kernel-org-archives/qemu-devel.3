Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3526606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GfbdDiTz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hojEVEgm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJf3A-00011C-GR; Wed, 21 Oct 2026 18:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJf2z-0000zK-4C
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:44:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJf2v-0002Y1-6o
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:44:36 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeCUo2748409
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 22:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HH0OoexitI9I4wIBBsFHRBvPau94eWbdbLKDtFWOYtQ=; b=GfbdDiTzcpJLj+U8
 IhylYMRC1pFojnGw5k4tsla/ll26Mo7AA2KzODiNEHkXEUzhWHjYPwkfo4KDmAqW
 qC9+28cRQ3NMGVS/hiS+hGgt4qniQv9x9QOWxFGWYe+2QzTHZulMTC0ok3RsLlkF
 WdwROyPkAdmorRGnq+kGLvjxQuYTMA8xJgHk3G4TNwe4jKxGFuPsN3UL6StN1FnX
 bEt4Y0VQcj3xVAK5IxNlGhblytvwcSkK3zB/6DjRF8T7z9tB5mS+Ugtitow0ckjV
 eOtUgw7XasvSaJscw7ewcOWokE3KXoJI59oY0tS2JvHZZRp4iRMuWQ8EwOxMSetQ
 sgyRjQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke1eau-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 22:44:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35cbea41088so2206903eec.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792622668; x=1793227468; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HH0OoexitI9I4wIBBsFHRBvPau94eWbdbLKDtFWOYtQ=;
 b=hojEVEgmWD0t23C4Aiv03aIcf8w/trvBclksA1HIbTrpDjIhuqTJHgpx4BAYbTOtZ+
 ho4OfJyPu4dcpuVeGS+nVkqLYGRzWRol7830KfvNsYu851aPQn0+5noM8sDN3kPvWRc2
 ZFlNHoSI3Ewan1AGFn4kKUh9DTvICV/+8GMTssZl1FiPkhI5Svm0UpF8yZbq4ACbVFHq
 AyrpIAGRf2JpVG9QPF/znBgkcUnqqdxECVx+4AUE5wdzEQo6S7qoNd2xevcfL6w9C6Pg
 6futuvWhAyA0ofhjXx1uKkZ3F7/2s35+CPlQu1clra+b2QPAWWgMxML5E11eIYaIw7IK
 IT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792622668; x=1793227468;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HH0OoexitI9I4wIBBsFHRBvPau94eWbdbLKDtFWOYtQ=;
 b=bQOWWNQvUIsInJdr90Sb4Iz7aac8EDnnTnIgPA683DGl4vzdjnh973Cb1lIkxCDTEN
 krshpRT1nZu3R29hA0ilTkzHdV5DNv44DQJgLxquGsi0gVDefNxu2e28at0sLex7E52P
 DibjxOg4e/z0yte/UC+FHvh2t6OKfzsRHGzDykypCj9S8Msg9XRnuPvFbAOAgyIXWoXE
 IUl6mU5sAQqTLZt60iHlorOW+aPs9wKNHdLx+PWsCwkH+q7tBAH+8gu/s1hpqqGV1c/O
 gt6PiWjhbXaGcUiVu/mbtZ/XiPEsjQgcRQGJiILw0GtspnSmBnBZxtRO7zCIZCrHXf/+
 3TAQ==
X-Gm-Message-State: AFq9FYJoOfWlACtsFzOIPpoG5dpSYpLs1Kkjh+3Qyy/wudhDezU7JKlm
 8Lw6wc1sszg3qQ2ToJZWyKzSnpAvKnKL9UH9CPCcn+5To6JSdmbXfqp7xDaaDmR9vICBbJ0coF1
 /CTq+NIB6Zy/nCUgNGmvk/T5baSgmsYHVghg3BDVZzNe4qx/h/MpbXxfgH0HSTRqufA==
X-Gm-Gg: AYBFou3qkqZ28Z2SGL5F3oC1YTMmY1sA5k8pMrbxbefH5XICYf4tQj2Gj3VGC1xO/FX
 7R91cFwyE2czTTJrbUxU0aFz8+F76R4Wn1l/3QwEhyfpsO4eTY44NHp7g68YzD/G8uDSrdNapiK
 Vlrx9qXXUJb3nmUcQQFVUnLLGQQk4A3awTEF0e8oasPOXyBAyEDQPrk4BIHEBKZtOEb8kugQkOQ
 iYMpf+8BXojpA/U/MrLGY3ohrPlD4OMeSlsE12MFHJtdeqlVLmeAMweW8P5KQo8VPNzRlzPYI1K
 O9KGDZDU0iMRnsOiZnn3NooTqzm8BEqORp0j7IoD0M+Gd/Etsedt/LOLv7Zp/JiX5eila7+uG/f
 T4FmhO3ngcInAENBqP33j96IlLxKj37zZxV0gERlz4he3ideS
X-Received: by 2002:a05:693c:65cc:b0:367:23b6:94e1 with SMTP id
 5a478bee46e88-3674e25bf5cmr5302041eec.41.1792622667705; 
 Wed, 21 Oct 2026 15:44:27 -0700 (PDT)
X-Received: by 2002:a05:693c:65cc:b0:367:23b6:94e1 with SMTP id
 5a478bee46e88-3674e25bf5cmr5302012eec.41.1792622667034; 
 Wed, 21 Oct 2026 15:44:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5eesm9462858eec.8.2026.10.21.15.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 15:44:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alessandro Di Federico <ale@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v3 02/11] Hexagon: add v85 CPU model
Date: Wed, 21 Oct 2026 15:44:12 -0700
Message-Id: <20261021224421.3786109-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021224421.3786109-1-brian.cain@oss.qualcomm.com>
References: <20261021224421.3786109-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 3tSWh_Uwj0b-cYcDVcuTuBlDK3ZrXHvC
X-Proofpoint-ORIG-GUID: 3tSWh_Uwj0b-cYcDVcuTuBlDK3ZrXHvC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MCBTYWx0ZWRfX7o1xO8h2ft3U
 DizXRjE4P4LwD0NSlbpKXEZXd7VopgcK3bFaLyTJ5X3uS4xVnbxZdYQUQsrjO9jk1J793lnmmcZ
 MmPB8M2WO2Gu8LPc+O4dZteSOPhqLRI=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad9404c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=6RDhHJMOdHl8aUYkYD8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MCBTYWx0ZWRfX/ZQ7gRJkqOAI
 pJ/nSjrupB8LaAjGxLtN+b98JK1ogq9djZtmsd4bQRxVmrZY4t2wgEQpsRysa52USiQX6P4SVoJ
 6fSqzwp+vwO5oYHTXSDNM9It+ZSGRuiljeX+Z2w5U1PnF1O4OzOlcOdWhznaytukPblTrohNVpJ
 nO3eNgyZi8sXEIXgqGrwYlGjjRiRjAR2cUvx0IqoU36g0iyaCemjfBT4S4lh3LHIcJSRtucdqka
 +4wTqUJ0Oeeiq3X7r6b8JSrzH/vqt7Z3gBqYu5EctWdTmq+lHXTfseii6vOjAAZVRLsyS9f+4j5
 BRbLDf0BCM/2YJHPZCJWGbZu8NN/3qUr3AMwe7PLGlNmGKiI6Bi4OGuE0smMk4G3bElu2yNQm9B
 lvDWSJ9PCwSye/zGw+PHg4/SfNUgunCQWHIvChvmdnqhI1N7wP7gPIq+oPMTKIJZ2RF7zvjAkKj
 v+rskHDu2DWiV+Ow6Rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210090
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBkb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QgfCAyICstCiB0
YXJnZXQvaGV4YWdvbi9jcHUtcW9tLmggICAgICAgICAgfCA0ICsrKysKIGxpbnV4LXVzZXIvaGV4
YWdvbi9lbGZsb2FkLmMgICAgICB8IDQgKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAg
ICAgICAgIHwgMiArKwogNCBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0IGIv
ZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0CmluZGV4IDEyMzg1MzExYWE0Li5mYjU3
Yzc3YWU5MCAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0Cisr
KyBiL2RvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdApAQCAtNiw3ICs2LDcgQEAgSGV4
YWdvbiBDUFUgYXJjaGl0ZWN0dXJlIHN1cHBvcnQKID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09CiAKIFFFTVUncyBUQ0cgZW11bGF0aW9uIGluY2x1ZGVzIHN1cHBvcnQgZm9yIHY2NSwg
djY2LCB2NjcsIHY2OCwgdjY5LCB2NzEsIHY3MywKLXY3NSwgdjc3LCB2NzksIHY4MS4KK3Y3NSwg
djc3LCB2NzksIHY4MSwgdjgzLCB2ODUuCiBJdCBhbHNvIGhhcyBzdXBwb3J0IGZvciB0aGUgZm9s
bG93aW5nIGFyY2hpdGVjdHVyZSBleHRlbnNpb25zOgogCiAtIEhWWCAoSGV4YWdvbiBWZWN0b3Ig
ZVh0ZW5zaW9ucykKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaCBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS1xb20uaAppbmRleCAyYmZhNGQ1ZDBmYy4uZDRjODQxM2RlZDMgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUt
cW9tLmgKQEAgLTI4LDYgKzI4LDggQEAgdHlwZWRlZiBlbnVtIHsKICAgICBIRVhfVkVSX1Y3NSA9
IDB4NzUsCiAgICAgSEVYX1ZFUl9WNzkgPSAweDc5LAogICAgIEhFWF9WRVJfVjgxID0gMHg4MSwK
KyAgICBIRVhfVkVSX1Y4MyA9IDB4ODMsCisgICAgSEVYX1ZFUl9WODUgPSAweDg1LAogICAgIEhF
WF9WRVJfQU5ZID0gMHhmZiwKIH0gSGV4YWdvblZlcnNpb247CiAKQEAgLTU1LDYgKzU3LDggQEAg
dHlwZWRlZiBzdHJ1Y3QgewogI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y3NSBIRVhBR09OX0NQ
VV9UWVBFX05BTUUoInY3NSIpCiAjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjc5IEhFWEFHT05f
Q1BVX1RZUEVfTkFNRSgidjc5IikKICNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WODEgSEVYQUdP
Tl9DUFVfVFlQRV9OQU1FKCJ2ODEiKQorI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y4MyBIRVhB
R09OX0NQVV9UWVBFX05BTUUoInY4MyIpCisjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjg1IEhF
WEFHT05fQ1BVX1RZUEVfTkFNRSgidjg1IikKIAogT0JKRUNUX0RFQ0xBUkVfQ1BVX1RZUEUoSGV4
YWdvbkNQVSwgSGV4YWdvbkNQVUNsYXNzLCBIRVhBR09OX0NQVSkKIApkaWZmIC0tZ2l0IGEvbGlu
dXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyBiL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMK
aW5kZXggM2E2YmE0ZTEzMDQuLjlmOThhZDhmYjg2IDEwMDY0NAotLS0gYS9saW51eC11c2VyL2hl
eGFnb24vZWxmbG9hZC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMKQEAgLTEx
Myw2ICsxMTMsMTAgQEAgY29uc3QgY2hhciAqZ2V0X2VsZl9jcHVfbW9kZWwodWludDMyX3QgZWZs
YWdzKQogICAgICAgICByZXR1cm4gInY3OSI7CiAgICAgY2FzZSAweDgxOgogICAgICAgICByZXR1
cm4gInY4MSI7CisgICAgY2FzZSAweDgzOgorICAgICAgICByZXR1cm4gInY4MyI7CisgICAgY2Fz
ZSAweDg1OgorICAgICAgICByZXR1cm4gInY4NSI7CiAgICAgfQogCiAgICAgZXJyID0gc25wcmlu
dGYoYnVmLCBzaXplb2YoYnVmKSwgInVua25vd24gKDB4JXgpIiwgZWZsYWdzKTsKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggZjIw
ZDZkZTZmNjMuLjFlM2RmNWQwZDAzIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYwor
KysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtOTM0LDYgKzkzNCw4IEBAIHN0YXRpYyBjb25z
dCBUeXBlSW5mbyBoZXhhZ29uX2NwdV90eXBlX2luZm9zW10gPSB7CiAgICAgREVGSU5FX0NQVShU
WVBFX0hFWEFHT05fQ1BVX1Y3NSwgICAgICAgICAgICAgIEhFWF9WRVJfVjc1KSwKICAgICBERUZJ
TkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjc5LCAgICAgICAgICAgICAgSEVYX1ZFUl9WNzkpLAog
ICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WODEsICAgICAgICAgICAgICBIRVhfVkVS
X1Y4MSksCisgICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y4MywgICAgICAgICAgICAg
IEhFWF9WRVJfVjgzKSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjg1LCAgICAg
ICAgICAgICAgSEVYX1ZFUl9WODUpLAogfTsKIAogREVGSU5FX1RZUEVTKGhleGFnb25fY3B1X3R5
cGVfaW5mb3MpCi0tIAoyLjM0LjEKCg==

