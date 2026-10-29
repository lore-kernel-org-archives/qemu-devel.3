Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93630606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Df/0oLRe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SwF6O6qc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVOP-0000J3-BD; Thu, 29 Oct 2026 15:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMVOE-0000Ho-0I
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:02:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMVOB-0003yw-Ia
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:02:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THl9Wj1323765
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9vdoJB+bOfJYZR2hWKyfN8SSZt25JALX8XPowdWlNvo=; b=Df/0oLRe1YFjNn9M
 eVfJt7oG+GaWzUqL3gNVug6BB9VHOlmcYa9RIfZPpMo7nOUKRto7edC7wMYQGMAY
 RtzVKEWOvHWC0vrlsPaIS/CZroihPysg53We19SiL77EBMdSonyerE2eCnApjXUb
 +sbBygREGx13/T0hYrfVOO4s//aS/yiBUy/qE0SsZIsTgIbCRasm84XA6wTEVE4x
 zPRWosLogDwz152689BD/K6WzwOaD9+/1k5ngCKW48YiKoap9SSfOodElAod/uMc
 8M++iBke5KZR7tNk9AVZi8qHfNMJpRfYRS+8RpVp6bJR0c0RsNroQBISLN+X+dzu
 yvWb+w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmaunh4t6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:02:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso8096eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793300533; x=1793905333; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9vdoJB+bOfJYZR2hWKyfN8SSZt25JALX8XPowdWlNvo=;
 b=SwF6O6qchf9g8Q6cIQdSAL/BW2iziaRBv0MGdwRHh1lAuNPbjc/BZI+YTMCm6HFKcd
 0EQSitNtWeqkMhqiIZ3QW3iVBSh7CHt+u3rf1Sk4u9piGoWr/nI93bQW0Q4itrCynCIL
 wnhwCjsrvSZWT04mzrmADIswMXc6TDuaLq+iG4+l1J5Zwq25VQwKOVw8DBCiyjnK4hqf
 /KrA3N1h2khK8piOTjJqk83PdccXrXp48LFJE/I8uNpEAtLK8mcyg1js7xnpFdeoDePh
 AoKxPVSfl2bpXfO4bAJPeozYI6UXOemAbXhkp5ND79iVutYOhQkjDkhWadRYWgROxQZq
 6e4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793300533; x=1793905333;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9vdoJB+bOfJYZR2hWKyfN8SSZt25JALX8XPowdWlNvo=;
 b=1u5nq+/hZK+6+zPNAPCYafwK2q3sNW2hJGLWnxYrO4AVjunk5+cWRKw/YR6QUGHmwH
 XJD97nv0/Gc/u6txvgcu3CvVcrZmNuhjDg8hN0jAJl3Zr5jmF52UJfRgHwp5vMC0E+4p
 uuw3BmTomW+7idOnF1GWtGxvSpQ2avw3oJVPxpMqJJH8KitMmDiJT+WoeQTIDBOKB0/t
 oCYV805HTsmHqRGQZXm/PPYvz/Rj3nW10hfGoZ7k2RowCkyf9EIBDgWCLw2Ks8msbAuE
 S0s4AAVCsx0xa9r6xANv47UEnx5k83Rh/UpSM+2TyKSQvcBsSxpIAeC63gJwYEYta17T
 sD5A==
X-Gm-Message-State: AFq9FYK2vlc3fX2OxFNzVvYrlQ4mqCS0LdIXLnrhngj+x4kbRGZe/etr
 mMe0bEiX6a9/sARqCIlhDeOyPCHpYE5SQfhGB2SiDhUqAiMy3kwDGlPVqUKZSofgWkFpLbgX56Q
 MCLJ3t3T/TNGmZqJAS4PV9N2UHqjNYZVX+iOhta+dv+pnPg0XRpmuSCdl5z57cgr9vQ==
X-Gm-Gg: AYBFou1/HayFdajjsmvNn2NoWfqrVUH+ABsN9d2RWRqnpBZmB8O2fTjFD/xx3fj+3nu
 /l2Un37Lh+s9xJ2QIqjPQyUxmH0pt1QqDeGNKU33K1yseBg2abgzNAtDcBqP5lamfcQ+GxDnf/d
 uKCu0YEBzG7y1PXDq/7yWmdt8CDr+BUdxaZpBnIt6ghJOh9IFVaSg4g3KK13gV4WKwuUY+Ln+Ql
 W4l5eCzvYfqwjUhPfr3mxhykd4IGsoom6HumhVKZHFkQWT08ng6CLSEHocQ52plO0hxT2Oq1/nO
 rjqIu63/8AkzGDrF6ScLFKDOdF9bW2EHnVBLlnjDwsr/vheSFL+VcU5QLSOjDuZF1RNPiAl4dka
 mg3JCOUiX3XZ9hVxsG7K+RU827YGmUDmd8dP3nd4uKwzYpd8ftid8YXzM8BNMbJv1RX8tAelmii
 euL8yibr5hNxuYfISyQ5V3qw==
X-Received: by 2002:a05:693c:41d5:20b0:368:d0b6:b231 with SMTP id
 5a478bee46e88-36a4239256emr334810eec.10.1793300533253; 
 Thu, 29 Oct 2026 12:02:13 -0700 (PDT)
X-Received: by 2002:a05:693c:41d5:20b0:368:d0b6:b231 with SMTP id
 5a478bee46e88-36a4239256emr334775eec.10.1793300532407; 
 Thu, 29 Oct 2026 12:02:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a98f65sm480598eec.28.2026.10.29.12.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:02:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/6] target/hexagon: enable MTTCG for system emulation
Date: Thu, 29 Oct 2026 12:02:04 -0700
Message-Id: <20261029190208.1169519-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
References: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NCBTYWx0ZWRfX7lwdFmBUjTi3
 vKY9n4B65EenfOYAufBBJecEnQYyGE39+0UDAxlx7/EdzqkdvUM58p5Cp2nKyorDgJOr6HizAdC
 s8XGnuhP3V9g3UKcI0bbECqrwT0ZCvs=
X-Authority-Analysis: v=2.4 cv=It2L47/g c=1 sm=1 tr=0 ts=6ae39836 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=5Nd4ZycxpyYUJ_pc5aQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: lxwkRaRTaf83NZnlBoOcFeiZF1dc4rXR
X-Proofpoint-GUID: lxwkRaRTaf83NZnlBoOcFeiZF1dc4rXR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NCBTYWx0ZWRfX1EQzvqcfN9Ue
 FiWv4yUPz1yVAM9VeZnpH0oeXPGVBKGEL7QTXI/KSC5fq4qGFuQ+uR/IildW1XU4BWNfUoiWALR
 LOYhCtDSC0P2T02yRzN5lRF0b1Td8xHRRUYhAeCa8gIvkdx8AOyMGjXEKhUG8aVqyYF+D/N+bDa
 3AMlC+4Ne9EBxU8vTavuO/f837PIi9Rabo9aWYBG+eqPkONtm24ocYcQioxHY3I5FSWGcADBG/d
 GxEtPDbeMTmt2U4zPe6mR8ft9yHfYwXUwXXPUFd+2nELjTJy8KJGq1kvQKhnKRlF80UHdM3U18v
 uYg3N2XjYq8WdZLV9NNfDUvxmNL/Gwv1J4EAzDOoekXpXSOHh+D2HToeWcQCyM62/ZvJdN89uk8
 uqQwj/bH8bRmkbr5/abnxG/Z5kqY5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

TGV0IGVhY2ggaGFyZHdhcmUgdGhyZWFkIHJ1biBpbiBpdHMgb3duIFRDRyB0aHJlYWQuICBUaGUg
c3RhdGUgdGhhdCB0aGUKdGhyZWFkcyBzaGFyZSAodGhlIGdsb2JhbCByZWdpc3RlcnMsIHRoZSBr
MCBhbmQgVExCIGxvY2tzLCBpbnRlcnJ1cHQKZGVsaXZlcnkpIGlzIGFscmVhZHkgc2VyaWFsaXpl
ZCBieSB0aGUgQlFMLCBhbmQKZ3Vlc3RfZGVmYXVsdF9tZW1vcnlfb3JkZXIgc3RheXMgVENHX01P
X0FMTCwgc28gZ3Vlc3QgbWVtb3J5IG9yZGVyaW5nIGlzCnVuY2hhbmdlZC4gIC1hY2NlbCB0Y2cs
dGhyZWFkPXNpbmdsZSBzdGlsbCBzZWxlY3RzIHRoZSBzaW5nbGUgcm91bmQtcm9iaW4KdGhyZWFk
LgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1
YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgMyArLS0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQv
aGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDYwN2RkZGY3ZTdjLi5i
MDk5NTVlNDdhNyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0
L2hleGFnb24vY3B1LmMKQEAgLTg2Myw5ICs4NjMsOCBAQCB2b2lkIGhleGFnb25fY3B1X2RvX3Vu
YWxpZ25lZF9hY2Nlc3MoQ1BVU3RhdGUgKmNzLCB2YWRkciBhZGRyLAogI2VuZGlmCiAKIHN0YXRp
YyBjb25zdCBUQ0dDUFVPcHMgaGV4YWdvbl90Y2dfb3BzID0gewotICAgIC8qIE1UVENHIG5vdCB5
ZXQgc3VwcG9ydGVkOiByZXF1aXJlIHN0cmljdCBvcmRlcmluZyAqLwogICAgIC5ndWVzdF9kZWZh
dWx0X21lbW9yeV9vcmRlciA9IFRDR19NT19BTEwsCi0gICAgLm10dGNnX3N1cHBvcnRlZCA9IGZh
bHNlLAorICAgIC5tdHRjZ19zdXBwb3J0ZWQgPSB0cnVlLAogICAgIC5pbml0aWFsaXplID0gaGV4
YWdvbl90cmFuc2xhdGVfaW5pdCwKICAgICAudHJhbnNsYXRlX2NvZGUgPSBoZXhhZ29uX3RyYW5z
bGF0ZV9jb2RlLAogICAgIC5nZXRfdGJfY3B1X3N0YXRlID0gaGV4YWdvbl9nZXRfdGJfY3B1X3N0
YXRlLAotLSAKMi4zNC4xCgo=

