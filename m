Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D895606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mkW30OkP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Eg146GC1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKoqA-0007g4-Sr; Sat, 24 Oct 2026 23:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoq6-0007eR-LX
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoq5-0001Sb-1q
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P16UMh3664777
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2cvTVzD7i/Dj3ZjXL/1YgmL/JijYtB2oiPHBNYiZkqM=; b=mkW30OkP9L5igZeP
 kUk4dvfhdsac6l5fRZM94bRPq+BCK9XtHAu1pW2Hx0bTiXR8ImrDhM6DD08guWKf
 kgIcAbzmzjSb8rnF4AbrH7FO1RDnPrfOLUbeh4zmAhQrgdD8LKk1XnbLq/i3wOSn
 yiQE5q4dIhFffMKqT3/+5mBqi5xzi6b/GyQknb38xwuyNS1r8raup/YBCdxQd8Ef
 Rolyr+X+PWvrBED6I0ULM6Yi+9K75b+j5zbkg1EhRmTERUbTq+fYjONw18IH2spD
 Jgh03XFIei/ibXhJZrKMBPd55OGsphckzboe4PYddd8h+Xdvqcq+5CYQLYNHEGbw
 ZGgqkw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xjcu3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:04 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-186c1aae818so7068334c88.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898643; x=1793503443; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2cvTVzD7i/Dj3ZjXL/1YgmL/JijYtB2oiPHBNYiZkqM=;
 b=Eg146GC1EnS2RPXhFcbNecc82NmBKBiboKRzJqHQCdLAylvQJqlfHLFRbH8+OEYhlB
 B1meWNXrN0jEVUtMGAEB3YAYHkAnBpamr35cIJG20OJtfnqdLDAOH7AP40QlkPmYh2Qe
 oOWmGvwAZ4oDdj98dj4rTYKrO90TDWcN/w6Jxswi4vtgIKJBow3fbAmYIct6kYd7hfcn
 rERyN/fVZd+QzUTNpiXVDrnM1MxZDT3+7+uEhfqSHSxvWqBAyAJ1TkZYxmMyjg70/sVd
 H9gUWZ/okD5pDqI1Xn3vVuuw0WxKUNT80NQmkW8HMXijmeIyf68czvsHtuhPIBIT2hB1
 u1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898643; x=1793503443;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2cvTVzD7i/Dj3ZjXL/1YgmL/JijYtB2oiPHBNYiZkqM=;
 b=Puwqiic/vMXZgzY/SDPRSyqL2x2WXCZ5iuVXh86cxeNU/wcFuT2ad7LfOA7AIhGELc
 x3TTt5Qrmr5pZLYt8kBnqal4So4D/9AwGw4RAdVdlSWzuHYBL6zm3TVnhHDpUNTnaXKY
 aQ3pVQMSe87Gcl3U8Pev52vwoo8In1pMcfznDZ15X8f5K93rbhFYX79cxPpAHUTQxq2s
 BWbetg+9/xa6sSyt95Q2979+V6RJlwv/dZkak+BB3a0kcjjlJ0WqvQRw0Wm2KKtCfo/x
 47MviC+Lmk1KC9C+/VCtS6Hry84Q5gpkOmjM0Bx6bXmm/bQ5f/FUmR4aG4sqG4vgmpPk
 Opgw==
X-Gm-Message-State: AFq9FYKOU5CV/q0pruHFPlS+kxuHRrTqfWfrUDIt3axKSezSeYKSoCl9
 /J/7yUMYT6W8gio/79iTrHCatpVp1Gow2bDairZDGmSCqwvFwB7tPnyagSjs6T6ABPaYPrD0QNz
 QQzUSd/R4qgFdjIwTmE3YDdQtgVuWr8LMWNNvo7k+g8/CJQDaPIHw86yqofZSN1dq8g==
X-Gm-Gg: AYBFou2zoMuKP2LIIbqkh2FjvA2jV1q8Uiu/wrqTPP6d+jiJevxlmMaF+YiR1xMeXZp
 KVdQ4Oy4BEgxts+UNCdzR7oP8WcR7Azd3NEx0ra03tzvv+EwAKekJXmObC20cU9ViTIMxGdkMWA
 GkEgDQPDi+BfUaJxI4NqbDSXHPuYBpco9aY3oFZiPdrJ5QC7LxthB6bxq2SETs2toDw9WduEqNs
 sszsypeKNNbwdX9dxU+A1M8ARYmEmSIcHuEl3Mz1YvlIwN7Yx0SV8l7cdComtuPZzA/AVCCDiZR
 7PthZCbv3Ja2KDM5R0HdbwHGa3doukWj0qsmseY6KdOYIFzRIaBvmiKEiQN1T83w4KkHQ0qEl/j
 pX62eMJ+7ZuFSUxG9a93t/akUxFUzSIJRhbqztq6foyU8qmg=
X-Received: by 2002:a05:7022:220a:b0:19b:1202:77f8 with SMTP id
 a92af1059eb24-19b1202783dmr4568305c88.32.1792898643114; 
 Sat, 24 Oct 2026 20:24:03 -0700 (PDT)
X-Received: by 2002:a05:7022:220a:b0:19b:1202:77f8 with SMTP id
 a92af1059eb24-19b1202783dmr4568262c88.32.1792898642549; 
 Sat, 24 Oct 2026 20:24:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL v2 05/40] Hexagon: add v85 CPU model
Date: Sat, 24 Oct 2026 20:23:11 -0700
Message-Id: <20261025032346.2917451-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: RCWw7LqICYb2QP3XXAMFyH3-G911vovW
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6add7654 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6RDhHJMOdHl8aUYkYD8A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX/d0u0SajozId
 16TPsA5CAVkOQ2XOQSIo7uHazH/81/NLeeIlsXgO0RaEEfBImFlKxZ9+QrusOshG9MZa3ikmlFo
 9rd7I1fGJx5CxJOgfqsdouKoLag1ayM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX/IXrlf2Kp1mK
 Dey+RCwoOjzuD7KACh0EXz/myR3Br/q7ktZmCBnhNz/HQ85tN3JyETMFbNccsZVbtnATcugMV6O
 0f+HZZvms4/yiKO9gbSk6Zl3e+naAiD9l5Y/HAZDoE79f3rIN6HauA/j8GN4naz0RQtEJhmQrh3
 7X9po1mSsSxeBYJfBeZXhVrqS3YRiHfWMCj62Gixkw0iIShhfyi/KPwL9P5U3HocYL9ojJfyFNV
 /PpE4/Jbmm/z+DUPpRGf9vgRAUHATXKV/yudHcl0chr1Ra9RtcEQsooqRnIgTchjZHEJRdfgzo8
 pOjHRUJ2uFj/4VV5/BJDKL5pEkCmrxWoE+zAV2ZQ60EuSpQAD29tyg9hUhJwvdWFXFRpuKTG7wZ
 kuxcDmLFElbt38Y3ZGpuQkYgCMTkpZfRolqzOhir/Q5xgoSjqA5fBZ3XUtp3Qz6nSMq1s5bD1ui
 YgTMs6Q9PAdLrEAUcBw==
X-Proofpoint-ORIG-GUID: RCWw7LqICYb2QP3XXAMFyH3-G911vovW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250012
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
dCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggZjM4
M2ZmZDg4ZTYuLmU3NzA5N2JlZmM4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYwor
KysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtOTc5LDYgKzk3OSw4IEBAIHN0YXRpYyBjb25z
dCBUeXBlSW5mbyBoZXhhZ29uX2NwdV90eXBlX2luZm9zW10gPSB7CiAgICAgREVGSU5FX0NQVShU
WVBFX0hFWEFHT05fQ1BVX1Y3NSwgICAgICAgICAgICAgIEhFWF9WRVJfVjc1KSwKICAgICBERUZJ
TkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjc5LCAgICAgICAgICAgICAgSEVYX1ZFUl9WNzkpLAog
ICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WODEsICAgICAgICAgICAgICBIRVhfVkVS
X1Y4MSksCisgICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y4MywgICAgICAgICAgICAg
IEhFWF9WRVJfVjgzKSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjg1LCAgICAg
ICAgICAgICAgSEVYX1ZFUl9WODUpLAogfTsKIAogREVGSU5FX1RZUEVTKGhleGFnb25fY3B1X3R5
cGVfaW5mb3MpCi0tIAoyLjM0LjEKCg==

