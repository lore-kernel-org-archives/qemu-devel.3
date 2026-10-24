Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC9606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jx+WrSWi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ezTPxeVI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKegI-0000yt-Gr; Sat, 24 Oct 2026 12:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegH-0000yi-Su
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegG-0002OP-BT
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF01i62370704
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ymLQ3x28Md8Ymub/5oyJuMUZHO77Gqq1QbGreXiiWgo=; b=jx+WrSWiu5EzQt2v
 sy6OD4s47FEPTCyGXz2Blvn4AtIZLRobk1sDpFwpE+sAD7caMsBEmhr/dymG4wLj
 DGUwsgL2dCaJMWGCUJLXWJfhzEorfr8ubGnNtzD1fkKDvriF3tniCRY0l4A4Htjn
 NM086XHNB7FaPOswBNTWWNf+Etrqv2uLpcAfxefuHx9WFLxvK0apDdYNwMU5/Whg
 4en/ontzh9PSjzPrCxWjg3EbvRYIxYdVHElM8E/GF24ZTNYNoj4/mzASwGsnTiiX
 F9M7ke7mn7s17rGjpdhn5KduBeijrARPBVRQYYNrX/pzzolinjxpkhM6aAjxtTNE
 h/zs+w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6hfrb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ad436a9d00so1590980a91.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792859594; x=1793464394; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ymLQ3x28Md8Ymub/5oyJuMUZHO77Gqq1QbGreXiiWgo=;
 b=ezTPxeVIOLhmSWsyRFRJbp8RPIo/3k/n0skQc17TP28lJoQs/AdHzYUSph3kBjA4Qp
 LSPNeDOoXiTTpDf8z2nMfl+9hxENtz3PDRLtPUEEniYJ5ieY+EifBFeJlyAlLFANxVBZ
 BQBECWhb4DolVHOI3frKLe7WhJrE/+a8+6J+d1feedMWP+HwtspffVSDy3yc8hU5in9Y
 fxMOOa2CRK1jkXTIG76xZu4bh1+eWPCNgL29EFIJEpkTRme2Y0bfNNhUJBxi1/maw2Mp
 e8vfVDdB1VdN6a0A9tjbCiebAM7HT8WtmjBR1DZaF2xIu6whvoqlj8HKDTbyvZQrET28
 mkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859594; x=1793464394;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ymLQ3x28Md8Ymub/5oyJuMUZHO77Gqq1QbGreXiiWgo=;
 b=NphuDadDFLnxmcGIDBzY862MhOfmISsy6HIYcnUKnnih+ZBTfGkxgvzNIRF1Le7QsE
 vhwApwmUGw+zIQ+Z6IC033mGkjuBRloczrIpJNjI5jwV6JLHo127wxLgGs+9dq+B88nL
 2RTt5ZM+J4cBTi5/+qBafUS2RLUALs/k6ZYiDnYsgKD7tMMgyIuHoauF3h9AgrmtfW9H
 /Yu0DMyCcw2kAmL/y3Hy6hi7wPS6knSAxMISDco/XrGKt2Qk7tbZoxTxnENaZf5YKfZT
 tSfkjMfw98lG1iuSzp5FBHu95W5hhzMXZPvO2EPaul1AaFtR7Tbq8uiWRLrRs8DqX0R3
 laWA==
X-Gm-Message-State: AFq9FYIflkcLgT3cFkWPolgsfrymj6IJEue9hLYNkHCu6BscaETFqfPg
 1JzeVD80YH6Y2LZcafLdFLJdD+PWdvMxhlR9CGjv6skwDDj00MbJ3fgVmQSTs+syD0QkuHwiXmK
 zxQCWV4O8yRKJQcmxo1EgLuZaOsrAUBnF4QeE91QwY4OdclqfLsN5CpXyVc4p3b05YA==
X-Gm-Gg: AYBFou3tdYwc1594XPerybxe6K2cNJ6UlwEMy3Rc+lrO34wszu1LR6282BKyBBceVTx
 wIbq8gfyhJrjMJTQpZfy227gobEz5MDcFTfHr69FmfxHFzm/Akgu7fmcr1i1xD6vNhy1s3OFRni
 yEjusOW4JEB7IoFKfaK8MyjtflnEdt9vN6qA4/nqUqlxOoPwlBS1GSw2TmJh0C8uYRgxytvpzLq
 l5FgoQ4x5W7oZbKxFzbeaIrWeTd7DJfTBwCk+jrQ9YtSnbdvD2QawbHX33JXJwuR9Af8fWqpFkg
 G/Fd9V/68lRDgXnqS16dJBe//P/+d3NnasFtJoPXuEcJbXOPS3Ink+hhQmquWkCkahqrvOjriUE
 O5OlvIHrjBjls86OmHVVk4PCsprywzZDq6jIJT39Emd7MlOtjQRJUiGIAKA/Jnvw=
X-Received: by 2002:a17:90b:3c41:b0:3ac:a203:e0a1 with SMTP id
 98e67ed59e1d1-3adead03898mr2105666a91.37.1792859593610; 
 Sat, 24 Oct 2026 09:33:13 -0700 (PDT)
X-Received: by 2002:a17:90b:3c41:b0:3ac:a203:e0a1 with SMTP id
 98e67ed59e1d1-3adead03898mr2105649a91.37.1792859592771; 
 Sat, 24 Oct 2026 09:33:12 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebad93c5sm1932270a91.2.2026.10.24.09.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:33:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 05/11] target/alpha: remove explicit target specific prefix
Date: Sat, 24 Oct 2026 16:32:43 +0000
Message-ID: <20261024163249.77855-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DVL-Dv6OkkuYo3kOXdZalLr3hTNKuqIe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX3dGXzMeZdlrz
 eCOZ6MXGI0cL5yMGEeoPGMeaArskI4VTQW9yyhj9m4505ZBQxYN6bkC8CB5Euu1ylItUixEkYKe
 Lve+C2TxylPY3bwLv/cRoHWeJz1i3Ig=
X-Proofpoint-GUID: DVL-Dv6OkkuYo3kOXdZalLr3hTNKuqIe
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adcddcb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=8l8H8-3bjoOVfk95vZ4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfXz2XpDDw7niIM
 frEo9/RWSPuoi43u1QjZbqjalervXWbaKHLYDw+cdYejALIx6AaqZWNSVbVa2rS4beKT2k7J44u
 IUYhzadObMtggkU24rONQ8cOJ6Kb/Oxr+VZV3L1F+4Je+drKJwC8g5C84Ii1oIddk/L+Ukx1lA5
 r1dKz7Ur0UUD/cra77M3qzvnjdS9//vN0p0nOCA5/zN6N5GkvvbiGrLR0nvDByYTXgTEEyXIwZx
 ya+BZ0vo1tdi2Z1Yco58gbCWYd/7hM5T2JEnXbfQbyfL+2FlT/E887pZ2fu8RLOqDhuAxMLH8LZ
 s7eLaWpiKZPZ/UTWJ7G7oAZ0GfqvOF9hVqR2IomCBcxVcZKmdN2CQ5p0ZurHuhLtCeP+X06vL5F
 zyl8rLrnkg2ZfsZDo6XEiXqoTVThfkYnTAl/bVjXlx7qRdBMEE/K4cfE3yJHEbBLa+AztVrVzbc
 566l+aS7AccBMxupkLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Now that we have a generic mechanism to prefix all helpers, we can undo the
recent changes that fixed conflicts between targets in multi-target set.

This reverts commit e39401e0b4005389790bf847949c9e5950f5fa55
"target/alpha: prefix divs helper"

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/alpha/fpu_helper.c | 2 +-
 target/alpha/helper.h     | 2 +-
 target/alpha/translate.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 61166396f6e..9eb64058765 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -248,7 +248,7 @@ uint64_t HELPER(muls)(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_s(fr);
 }
 
-uint64_t HELPER(alpha_divs)(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(divs)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float32 fa, fb, fr;
 
diff --git a/target/alpha/helper.h b/target/alpha/helper.h
index e2f0b96db7c..954a5c8294c 100644
--- a/target/alpha/helper.h
+++ b/target/alpha/helper.h
@@ -47,7 +47,7 @@ DEF_HELPER_FLAGS_1(memory_to_s, TCG_CALL_NO_RWG_SE, i64, i32)
 DEF_HELPER_FLAGS_3(adds, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(subs, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(muls, TCG_CALL_NO_RWG, i64, env, i64, i64)
-DEF_HELPER_FLAGS_3(alpha_divs, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(sqrts, TCG_CALL_NO_RWG, i64, env, i64)
 
 DEF_HELPER_FLAGS_3(addt, TCG_CALL_NO_RWG, i64, env, i64, i64)
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index ac57e4d2623..c66e3f9c146 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -790,7 +790,7 @@ static inline void glue(gen_, name)(DisasContext *ctx,                  \
 IEEE_ARITH3(adds)
 IEEE_ARITH3(subs)
 IEEE_ARITH3(muls)
-IEEE_ARITH3(alpha_divs)
+IEEE_ARITH3(divs)
 IEEE_ARITH3(addt)
 IEEE_ARITH3(subt)
 IEEE_ARITH3(mult)
@@ -2086,7 +2086,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         case 0x03:
             /* DIVS */
             REQUIRE_FEN;
-            gen_alpha_divs(ctx, ra, rb, rc, fn11);
+            gen_divs(ctx, ra, rb, rc, fn11);
             break;
         case 0x20:
             /* ADDT */
-- 
2.43.0


