Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FDACD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI2-00057L-DO; Mon, 11 May 2026 14:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHc-0004ks-1t
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:12 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHa-0002tE-Bv
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:11 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e363c6141dso3047826a34.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523789; x=1779128589; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e2rdisLTgwrX/LMcUGAISxAga5UTvEV56qsuS3QA7Ok=;
 b=aJr5H4jcsXi23PiicYLcBcUN9wnMq/eUwWrt4HQqFvwCfxzXWYCIq00SR/QVBztLT7
 416LxhUKpNtnuq86UeD88YPI0ZKfOBC+Yh6zivfC5oEhAh91T6oSxD+Pk8RbGSht08PF
 ICIzR5Rb9O/yQY1MrSn3UnBuj8+qNYCotQJ8LcoOryY8EmzNkLtGrqGr6p9GggrXz+q0
 X0MV2SVKj+861F0pTWV22F1z/Orjr4Hrykvwrkt9n/SpgUuCxUBXqpe/ySV4PTzuGYNI
 rZvHZ8TgtZOKZ8W99oJFy0oIZsnCvVGALZwkSRuEIc6HXWQqO1/Je6fsK3j5gR2ywA8M
 8DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523789; x=1779128589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e2rdisLTgwrX/LMcUGAISxAga5UTvEV56qsuS3QA7Ok=;
 b=b79mMP42UDH/aMzrZPu6T2mbjXK8wXulXalY3fkdnRXau0Vma4ngG60cyMjIC/+2mz
 5sR0Jaw9GNaTiY1mfJLX+tEZgDH5jhXj+EBn75NvLqe7Ua2F0VBHgoCnVvDY7Md+uQ5Y
 bTwaZOAwNXsUDK0hv6a1mpKrbxQEuh96tZUv2jbWxffQlYHEuFFz8t6hxWz3IAFgBcfd
 7wL+NTjqzj7OC7Ib47ZnY+3UpIYDOigMKX1l5APAyxv5WPUT7kG9PcFDRcUJD8UauJkE
 MtuoPYt2+vu15YtIXq5wiK5kt4mWxKiXpTF6U/njiU+Fwiz+hMye+Xuw7Vv3t66fu0lL
 8UXg==
X-Gm-Message-State: AOJu0Yzf02ivq8IR1mRWfY8wLiUHixaRyhVwjdsfPhdb/JX0y4kM2vEx
 YjzKRySOSVe0cZlKRJ9qRKPqLDCnJVRe9H4909B0HAC6WRUSsMXw52l1YFk/KEhO
X-Gm-Gg: Acq92OE+vWpAPck0URZjDnE9CKZon7o9ilNJtQzx4IDOTAMlQT9Q3PeO6LTvLdomOQt
 xFnDTwGkRNmFV3w7UKxusHXVS5g5oFdATykwygmHaimbeDWRevRIvZJIsyOA0W+XrJf0nkjLLWb
 DGqF8CqB2qQVjdevd1Ukao9eXy6278U4Dzqe8jR2arx72ehACGSpOfwFtms5e8OmFfxyGc+tS8H
 rpOtwxec73MoCpNUlRsW1LWt69HE72jbjp3z+LVQHAVaqtPoNtrlQQeVt2BMZOIVAXKp5UGb3bv
 OE2K/HvxTh8B+seoqNEg8F0IVWUZz4DmK+Mou+TOoOGGIGe07vmkig40dK4mQYm5vkyo7HpqQCD
 Sf5o1cdu4RXlcahf1YlRuEgukxccyoEWrn7sBsJ1YkJDdTe5SbDbn1Xdj1lwfYD4CN67DogGrJH
 FiP2R5nUTCJntYkUqptKdtG7knSOFP0225ZZCaAzUIDezT0fxVSRNRW6d2jAtT+/9UcmfK8AoZO
 YmyeHixbbmmF7DipiWkJdQ6j/GAx69UCrLwPVluVHAm4lL3SKiwdRWnL2+r0BBN3vwh
X-Received: by 2002:a05:6830:608c:b0:7d7:fd71:f2e4 with SMTP id
 46e09a7af769-7e1df0d2a5cmr16270278a34.14.1778523789343; 
 Mon, 11 May 2026 11:23:09 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:09 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:50 -0600
Subject: [PATCH v6 19/35] target/mips: add Octeon MTM1 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-19-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

MTM1 loads the middle Octeon3 multiplier operand pair from rs/rt into
MPL[1] and MPL[4].

Like the other MTM writes, it resets partial products so the following
multiplier operation starts from the newly programmed operand state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTM1 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Describe the Octeon3 rs/rt MPL[1]/MPL[4] pair handled by the shared
    MTM translator.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 99606c80f6..c85199ae32 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -48,6 +48,7 @@ MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
 MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
+MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 55e9ca298c..c9ea72d832 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -291,6 +291,7 @@ TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
+TRANS(MTM1, trans_mtm, 1);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);

-- 
2.54.0


