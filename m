Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FBA606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lncNufe1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A3UWaJBG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQrrx-0002Wx-47; Tue, 10 Nov 2026 14:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQrrW-0002Px-7L
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 14:50:34 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQrrU-0003RI-BK
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 14:50:33 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAIofx53699336
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 19:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=XpLFaKL7kIxdAeTH4jeyEndvwUGhGIW5B+N
 pFZg3FOU=; b=lncNufe1yIr+bvPMi5o0qItAdh1eYboLrH42G8GnK1DR+iRvR0P
 X7ZQYLtxgAgz3ljofs/JtYRwYtyz4dPea2+KDXlGg95wkl3klQ9pto3WjrNfuKf2
 X3NZzXU3mPaQh51hhztC1yLIuh1M5aXD5AX7X33xZXnaRys/iDWWVp+4waLFtMA/
 PmRad9O2/Gck3t0teP1RwuFsm+g/slZKvG0adCxsZLG0dhyY7dvq0P6hUNPQIkpe
 4fC2ieATCKMqksz73g69lyKDnRmjJaW/f6BoI2iJLfl4jAYIy+snOjDCkw2BXpf0
 sYMfHinPG1zrQ34bH1i17Jsjt1GiYnX0IPA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huucp3r2e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 19:50:30 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91ea71789d8so64610016d6.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 11:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794340229; x=1794945029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XpLFaKL7kIxdAeTH4jeyEndvwUGhGIW5B+NpFZg3FOU=;
 b=A3UWaJBGul6UezaniTcslhjNH7qdjJrQ3Eaf59hpBP3cLGsvp7C6A2c+mBr69qHVDf
 2GM0RIUUwT2ZI8CDjqbXn3A5fVK4ptjPSyMg26lo1RuK+W9nQqg3wKlKQ3DKnEr3wcvK
 cn6iORd6EBw6EVJbBXzQ5R4NMd9h/o2eP5/N9dC0VyrTye81CM2TikuqsHDK29bf3Izy
 Fi8iOP0UXhvvVUNQS0D1NsclahBeyx5U9s16fSkpjenL49fWW/pwfoJJ3iVkY5f+3w07
 fYeVjl5xlUQQHaKQtZVzHSMf+L/sobfOFk36niFIs7yJ6FKhBVu4VHz7LTXlhLo5fduR
 ptbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794340229; x=1794945029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XpLFaKL7kIxdAeTH4jeyEndvwUGhGIW5B+NpFZg3FOU=;
 b=RRU/UoF6MVdftS1oj4hfoTPWE709EqDl7zhHqohnfhaV8C0KnOjfaquGrFwmxYPKd8
 W1RPIHPpAAHnOT/g+hYYRl+mxWuroz/5BOejTPSvZGGqWgAMUlFq4BwY3ILPzokhCLjQ
 d+jc2zmuOk0qaQikEj80BmjeiU0YcSrD+I1nXddEKjuQvfPEVtROQNJ5xS6gYy58Bp14
 0yJ5JYuehDjarrgJBrThsdhIUmmYUmHuJSZ7UverphCD0qBtWzxr36lHHmDwvD0F25ml
 Btwcf95Pzy3AsA2Zb/6mOCg8M9tUDO1bh8hOWVKcDoBJmY0ot4fNTC7mVsHibfzEKYFT
 N2Lg==
X-Gm-Message-State: APuU4Z8qE9vGkbm0hxMYgjUyTmiPmn3NB8akS0t1EQkng5wp/BgZwxSP
 aq9PRPDGXXESIs7crrTkKIYFiHw8csEC75RA2FL7OJnrwpUGdGLQBytQYlGhUmi4a7T0Js6WTlB
 9RpRnL6cqfjIvTvCCYo1ZqQMtzMxT3w1k/xBDA2sC+yyBOIemSTQ1rCjxq2urBXzvrg==
X-Gm-Gg: AYBFou1Ul2yUewJrAFffZHv3J7nCYqrNwvKdHEAp9HRTbFUTohZG1MkrRrToV93feRB
 2UFaFzv7g94CaCL9foZ8gpjF4z5SOM+lkVkvZIoddt6ccou/m5uYq/BpRQvnF1EFMZaseHjzb1O
 4UBbnSCl3FhKxUc3pLtRS19piVhAUgkVN1kyD7Gy474mTu+8cVrYhap4zdwsGZvttGqZgvmuX3x
 +JQP7E9Awayr/xzSf9caGgI756XE5JAf3IpiN59wwzAobqrt0gQKfsq/p75fv94yx7pq1PEFWEy
 OSM7dYgiM/30j58lvbAlHXGcmHfpyswrvp8wO2nyHG7ky1CH+D0GB7TGnMBt34cI+5O33Udw7GT
 kMt+stunqSg1Z9/HkH1S5O7YalMxUHmKfjnU+5k/6Ny3o3ti18BoRZu6YDZnaiznD40bvqQMo6X
 7uf3pisqvk5as=
X-Received: by 2002:a05:6214:20e7:b0:91c:9086:ee13 with SMTP id
 6a1803df08f44-91f042339femr5018756d6.58.1794340229042; 
 Tue, 10 Nov 2026 11:50:29 -0800 (PST)
X-Received: by 2002:a05:6214:20e7:b0:91c:9086:ee13 with SMTP id
 6a1803df08f44-91f042339femr5018126d6.58.1794340228365; 
 Tue, 10 Nov 2026 11:50:28 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef04d9b17sm28949006d6.20.2026.11.10.11.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 11:50:27 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] target/riscv/tcg: clear itrigger_enabled during
 trigger_reset_hold()
Date: Tue, 10 Nov 2026 16:50:23 -0300
Message-ID: <20261110195023.20927-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KUuDzqG06GltvxvIRanQXGJgz4p_eKBt
X-Authority-Analysis: v=2.4 cv=U4oHnuru c=1 sm=1 tr=0 ts=6af37586 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=zcreZ36wYqc89bCkXXAA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA3OSBTYWx0ZWRfXyGQ2OwScI8gu
 1kZiUjMP872MaT8cd6uimtcLBg598GbviO/z7WYXKtOOt94TrZP/EZeVydOaNPyZYKvnVi9K0pi
 nbVigh/7U4uQ8fiok/TRBUsuqtRZZUK13JddD250ruVh4W+jmEhMmpLfcMH9f+LUJhMbxVUczUV
 i5svFiEjcxH5xXRxMJ+MgkhQYZknluRBa7m+5w2u53Ko3SJ9i9iGZ+U2SvqZMFcbN7KhH1sbfuM
 I961ww2If/yGVbUb/9S6uATo7rQHOkjPL/kOvMapfWF021zmI4CdT9lNb89+dLploUQOx7cBOoR
 qOGt1DsTSnXkd8k8oUPZHb4UKV1JmOA2wY+IpPZT9xy0zrWGX+m80HDLEnHKRR/QKFn4/RysanS
 Pjg0MrtSM0vmRn1KXH0TKpKVVDv53w56Rsh9NBwOedWuurWWWNXmcCMYzIQJ6/d3cyCnCZbPfrL
 0r/nEs3v6b6E+BLQQBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA3OSBTYWx0ZWRfXwu3T34A7c6DQ
 fnjBV2ZutU0KQa0bM4e05Nmw0qGWFUlHp3DUBMjk2obNRHavEKHofXp8UjUgdCUaqY3ntza/Qn3
 3s7N1gW3yKwwlfHARVZ1+2UvyqHtJTA=
X-Proofpoint-GUID: KUuDzqG06GltvxvIRanQXGJgz4p_eKBt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100079
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We're leaving env->itrigger_enabled untouched during reset() while at
the same time resetting triggers to AD_MATCH (type 2).

So, in case we reset the CPU during an itrigger session, translation
code will enter itrigger_match helper every time (via ctx->itrigger),
and the helper will do nothing since there's no type 3 triggers set.
And we'll keep doing that until something else clears
env->itrigger_enabled.  This is a niche case that it's a bit hard to hit
but it will cost a bit of performance for no good reason.

Found while reviewing an itrigger related patch.

Fixes: 5a4ae64cac49 ("target/riscv: Add itrigger support when icount is enabled")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 8b58cbd07a..988bc815d7 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -1213,4 +1213,5 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
     }
 
     env->mcontext = 0;
+    env->itrigger_enabled = false;
 }
-- 
2.43.0


