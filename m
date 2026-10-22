Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22416606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BVi1KQdG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ISyWoMdg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK1mU-0004x3-CU; Thu, 22 Oct 2026 19:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mN-0004wL-0q
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mL-0001z9-7f
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:00:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMIgKI1495881
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aUvM8Ur0aH21rB6QnokLE/disrTmCCNhb6I88tTvE/A=; b=BVi1KQdGaKH7LRzv
 QObypmajL94kb7ZZB7vd/6IhgGlU2SF5C88o3ec+m1iO2CwNtdONPJNv8GhPRGlg
 2iRtHW2lQgZTIXReHjfD7nH6Gfdhz+Ka6qCD6inA5CFA1XysgnyXd+UM2ASjSq+s
 M81WWSCPicyVMeZ/Y2Ph8kNhLHsZ9H8wM+qgkXWe4l2CEc9SQOY8Wb70rMnB4zfX
 Tk6ckpuibgLZIhEuqkRB/Zel/nWjTqTXYlTbFY49SwsvqHvQd8TEjDTY2yxjz/u9
 JjYD7sk4z3PUnoUUgZhaEjVNfMkqHWkl3jCU/C50UdOzgwx4fgXnOo6ByNu5KCuc
 YkoMnw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmj8xts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:00:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so691385eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792710054; x=1793314854; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aUvM8Ur0aH21rB6QnokLE/disrTmCCNhb6I88tTvE/A=;
 b=ISyWoMdgidoGgKFGMNL68LGLCWLvba+sfhl2ISX+rEiXV8qlLcB5fAdmYOHTq7vUlF
 lJzbwuNdz8O6nie6WtNjPwNo0qMGGQeVb75V16lUhW7KPjLF+UFvvWUpsx1sJapnahcg
 5l5VT80CU1ZuuPORXJDJJGK7m/oT1CCF+p40sA+DGH01EbapaPK5oWKWLZ7vXqCl9vJ1
 E39LQDBwnBsGVEy9gPddn/q4JxqMilLD9RDckt7Wk6mpty8PgPQy/1l3qj+dByJk0sqr
 aMdt6c3kczhkjYg55o2/SfOWAKe1GvEMtcVb79oT+SkSL2TH5j4AFaV3wlCu5K9pqXOD
 5FCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792710054; x=1793314854;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aUvM8Ur0aH21rB6QnokLE/disrTmCCNhb6I88tTvE/A=;
 b=mus2h4Ij0bn1NbpI3Hwfrwuh5nWQkeGDJmennqJtUx0zVXWzvA3iYcAI+Uos4SCn7x
 sP+MVTS/4BYaFkEstfeYCgbUk3Lu1GI+DDJpJz0OzFMq7a6AzOylOTDlvLted2BtvpRP
 5k0ejrLCzfFFrHOl0j/WTIKAjiLXhsq8bQaSj5z8j/e1v6HoXSWKNI0oXChEWAB+Pb3L
 fjB5XTEP4ek4YeO6zielyPSQ9vBOWnam/A96mGbUboKv0P9HB3mIAXsg8cPazzGNaUEW
 4rQ0G/0TOA7mEsAwCmEBoiePfsd5rDqfLiXXiJqOVMQQnATEOHUsxJI3Xa4loFMqmWhq
 8KEQ==
X-Gm-Message-State: AFq9FYKjo90L5swoZ7T6y48I/mZOUKKC5bM87Rawikwnj9kOa1c3tQqb
 qbVQwWXIp0GlMut29mjVyUJskduv3ocPIHR+ERQJBsQfOFwXmxSUXF5YI36d4lts6tJI2c0ADG6
 Nn/X4sGbE9Fgwsrsy1nMoIlJk9s6g2ZFhBT1w4+PylEY+h3t+5f3F2J3ze4s/ORIlUw==
X-Gm-Gg: AYBFou065/KcA9b1VXe76NiG6uLxgb3+N+Zc6MM8v/ISCyADrDv3nE+Kt1ko29SG0wK
 wXv/8w0FR3ebJE7fexL0RV/2rIxQAcyqc2g52VxTZY+9jJDaglioCOVaQgo94YXuRsdhRKtBLVF
 75L501l3/rYgqxj1WUujjf1nuNtOuMRR49yhYZ1vfj4QEI4O5ekLB+JwO4iQiTny6eegqoEZsBu
 Ci9Ft1XOdwAWYxkj2jRtzqzvZm+Zes/xDLi+l2AszKZ2M/vZMKFBuUhFW7KjHdd7YHF/xQQfkoR
 dUBW8UZ13JogkqJCgeP2yqFzydyyVg/N1WaaJIZFsa+VIt3eBhgqF0s91j6C3ytzQPo4XJOYewD
 R8BkLTXwJhKxzeZ6wk0MXgJcfVmnsf8AFcMth3CVyeUZqxCNJ
X-Received: by 2002:a05:693c:87d7:10b0:366:83dd:46f7 with SMTP id
 5a478bee46e88-369d98074admr648141eec.17.1792710053711; 
 Thu, 22 Oct 2026 16:00:53 -0700 (PDT)
X-Received: by 2002:a05:693c:87d7:10b0:366:83dd:46f7 with SMTP id
 5a478bee46e88-369d98074admr648103eec.17.1792710052911; 
 Thu, 22 Oct 2026 16:00:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9c0e60dsm1088138eec.2.2026.10.22.16.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:00:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Anton Johansson <anjo@rev.ng>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 01/16] Hexagon: add v85 CPU model
Date: Thu, 22 Oct 2026 16:00:33 -0700
Message-Id: <20261022230048.2160400-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
References: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: JU4SMM2Zqfbe-vbaSpaRInziU5fqqfQv
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6ada95a7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6RDhHJMOdHl8aUYkYD8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfX9oBUW8dF4bZA
 YyiPF8C5Nb+n8vwtK0T2rtEw1FODnX6FeGCQxPjnegSq10QAkU5WoOSe0E43nzpvudEU7byFrNj
 zkLd2quktA1H3y5fgRKE0f9LSKAJe0E=
X-Proofpoint-ORIG-GUID: JU4SMM2Zqfbe-vbaSpaRInziU5fqqfQv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfXwnXZGBOJ4Ofu
 bw1rBJUKl9slCFL5CE8A5kKSCt8GvfnzqZqhVkUYFddNb3z8enZMSkQaT0+6AMtP8opEzpaYizx
 dY+midLFAATDepl8xQ05pX0iJG8bLsWXmivlNJlQpMs/hDkUSyJwz2sn3IFwUyrCgvcN3COgszz
 EmUJiBGavS2kvu8wLTI3Ud9+JTITOjpCqEuPTTYLR4XBvztLUDn/4hJw6KL68GYI4Nz+8dtOW/X
 kjZTEil8Tuor2zxDlrPAL4vFpQfOqwdIRH8jF1jKiXAmjRlvdns8IMM8QFG/fnoat+cEB9rGwm8
 5TE+2bG/qTHkDv07uPNjqwalSPXGxWt4EIDUoGCT2IwDK3efnWhDidrUHDLMeF13q/z7jJIlWqI
 /uHSh2quiTZW/DRvh41ipOwmzDs9KzXt/+sCdl8gKyb6gt2ir5lAuiU2v5nA/frdyHshp1qa0AZ
 +wR2w2OP4wF5WoRVsYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220091
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
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIGRvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdCB8IDIgKy0KIHRh
cmdldC9oZXhhZ29uL2NwdS1xb20uaCAgICAgICAgICB8IDQgKysrKwogbGludXgtdXNlci9oZXhh
Z29uL2VsZmxvYWQuYyAgICAgIHwgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAg
ICAgICAgfCAyICsrCiA0IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QgYi9k
b2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QKaW5kZXggMTIzODUzMTFhYTQuLmZiNTdj
NzdhZTkwIDEwMDY0NAotLS0gYS9kb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QKKysr
IGIvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0CkBAIC02LDcgKzYsNyBAQCBIZXhh
Z29uIENQVSBhcmNoaXRlY3R1cmUgc3VwcG9ydAogPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KIAogUUVNVSdzIFRDRyBlbXVsYXRpb24gaW5jbHVkZXMgc3VwcG9ydCBmb3IgdjY1LCB2
NjYsIHY2NywgdjY4LCB2NjksIHY3MSwgdjczLAotdjc1LCB2NzcsIHY3OSwgdjgxLgordjc1LCB2
NzcsIHY3OSwgdjgxLCB2ODMsIHY4NS4KIEl0IGFsc28gaGFzIHN1cHBvcnQgZm9yIHRoZSBmb2xs
b3dpbmcgYXJjaGl0ZWN0dXJlIGV4dGVuc2lvbnM6CiAKIC0gSFZYIChIZXhhZ29uIFZlY3RvciBl
WHRlbnNpb25zKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LXFvbS5oIGIvdGFyZ2V0
L2hleGFnb24vY3B1LXFvbS5oCmluZGV4IDJiZmE0ZDVkMGZjLi5kNGM4NDEzZGVkMyAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LXFvbS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS1x
b20uaApAQCAtMjgsNiArMjgsOCBAQCB0eXBlZGVmIGVudW0gewogICAgIEhFWF9WRVJfVjc1ID0g
MHg3NSwKICAgICBIRVhfVkVSX1Y3OSA9IDB4NzksCiAgICAgSEVYX1ZFUl9WODEgPSAweDgxLAor
ICAgIEhFWF9WRVJfVjgzID0gMHg4MywKKyAgICBIRVhfVkVSX1Y4NSA9IDB4ODUsCiAgICAgSEVY
X1ZFUl9BTlkgPSAweGZmLAogfSBIZXhhZ29uVmVyc2lvbjsKIApAQCAtNTUsNiArNTcsOCBAQCB0
eXBlZGVmIHN0cnVjdCB7CiAjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjc1IEhFWEFHT05fQ1BV
X1RZUEVfTkFNRSgidjc1IikKICNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WNzkgSEVYQUdPTl9D
UFVfVFlQRV9OQU1FKCJ2NzkiKQogI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y4MSBIRVhBR09O
X0NQVV9UWVBFX05BTUUoInY4MSIpCisjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjgzIEhFWEFH
T05fQ1BVX1RZUEVfTkFNRSgidjgzIikKKyNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WODUgSEVY
QUdPTl9DUFVfVFlQRV9OQU1FKCJ2ODUiKQogCiBPQkpFQ1RfREVDTEFSRV9DUFVfVFlQRShIZXhh
Z29uQ1BVLCBIZXhhZ29uQ1BVQ2xhc3MsIEhFWEFHT05fQ1BVKQogCmRpZmYgLS1naXQgYS9saW51
eC11c2VyL2hleGFnb24vZWxmbG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpp
bmRleCAzYTZiYTRlMTMwNC4uOWY5OGFkOGZiODYgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4
YWdvbi9lbGZsb2FkLmMKKysrIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtMTEz
LDYgKzExMywxMCBAQCBjb25zdCBjaGFyICpnZXRfZWxmX2NwdV9tb2RlbCh1aW50MzJfdCBlZmxh
Z3MpCiAgICAgICAgIHJldHVybiAidjc5IjsKICAgICBjYXNlIDB4ODE6CiAgICAgICAgIHJldHVy
biAidjgxIjsKKyAgICBjYXNlIDB4ODM6CisgICAgICAgIHJldHVybiAidjgzIjsKKyAgICBjYXNl
IDB4ODU6CisgICAgICAgIHJldHVybiAidjg1IjsKICAgICB9CiAKICAgICBlcnIgPSBzbnByaW50
ZihidWYsIHNpemVvZihidWYpLCAidW5rbm93biAoMHgleCkiLCBlZmxhZ3MpOwpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBmMjBk
NmRlNmY2My4uMWUzZGY1ZDBkMDMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisr
KyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC05MzQsNiArOTM0LDggQEAgc3RhdGljIGNvbnN0
IFR5cGVJbmZvIGhleGFnb25fY3B1X3R5cGVfaW5mb3NbXSA9IHsKICAgICBERUZJTkVfQ1BVKFRZ
UEVfSEVYQUdPTl9DUFVfVjc1LCAgICAgICAgICAgICAgSEVYX1ZFUl9WNzUpLAogICAgIERFRklO
RV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WNzksICAgICAgICAgICAgICBIRVhfVkVSX1Y3OSksCiAg
ICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y4MSwgICAgICAgICAgICAgIEhFWF9WRVJf
VjgxKSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjgzLCAgICAgICAgICAgICAg
SEVYX1ZFUl9WODMpLAorICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WODUsICAgICAg
ICAgICAgICBIRVhfVkVSX1Y4NSksCiB9OwogCiBERUZJTkVfVFlQRVMoaGV4YWdvbl9jcHVfdHlw
ZV9pbmZvcykKLS0gCjIuMzQuMQoK

