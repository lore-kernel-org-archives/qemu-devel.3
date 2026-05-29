Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE3BCD6E51
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgo-0001ep-P1; Fri, 29 May 2026 07:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgm-0001dR-H8
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:44 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgk-0008Do-Rt
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:44 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45ed18d8a1bso2686407f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055261; x=1780660061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5epfWRhDxaC8XI13YVukA2ByRaHS+EVk7OK1nsBBQug=;
 b=YhnCOGiXBYQOlyeYpfLEcHBfYgxY6GLTLFqH+5QCRTrCcRU7Ri71L6jbSiieP6LGgy
 qM97tjzerJKxLP7SA8lT9IGYEVrbTxlGmmCEPN7y4tnkV4hM6CTg4PlilgTIwiqCQME7
 nra7rwX2bd58/+CG917qVFgLxXw3ud48dmc7DbSXcE9KOYeGyyYXZDqyXeFAxHvL9f3f
 iIVOBwT8zSJcZcl8x0wnHCuiiCIfZG2STXAmHlRRhqCUz127iTkTpJaWxhYaPRIz4ZLa
 pCkyLZg8npap8R9Bb8AUl5w6QgQlZ22C3oUZpCWG8yRMJM1pKLgGMacT1vbUqVKImc5v
 v8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055261; x=1780660061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5epfWRhDxaC8XI13YVukA2ByRaHS+EVk7OK1nsBBQug=;
 b=iJWO9NsGDQUcsksEuQ1WbB+QzuOQ3RS+obXagUn6rHDsjwWI3lR539CFdDby2uGGNk
 YK46G02iJEvN6KRCXxN/SBDwfJeHQPzrW8fFEDt8DZtJcnpcpUdNqXLmtPs7gNtGaBmD
 yTuDftZBVysq7sVjsPN6i+yssAcKkXZNzu6AGM07NjSloAe8QB113JJbQAMe/ZnvlF9X
 z7pCz3oDT5qmXGs7H0WUo9ljgWv/FsMVO68ooI8mqFOL4KU7cIKH8gxwqSnK4kCqnRKO
 73iU/1rChdwWkVVKuaEdPvOObJQ/RDd14KyYkjq+4kIFNEalQGPS3uR1/tBAIDi8MKT5
 kteQ==
X-Gm-Message-State: AOJu0Yy0io7k2fRVogwF5FMjCcXvP1ajudH+OTr4xu+B9GosltHPOmEx
 yK/j2aJWEkgF7M0JuwPjHzRB/1IFSinU+BvcPysJd3yM/10j5OwOncaF7qGjXwXb1j2sVhR0aS7
 xEnMA
X-Gm-Gg: Acq92OFUBa/KNx8eRr16gDsomwcZyJI1IIS4fh8BHQYYtXHpdzTuEUfQw6usgliPbCl
 3VSJ+NIRhQGYhueprA8dyWo0c3FCo8c5B8Q29eQswblnof/dT302KScgha8P4HM5CqedADyJA6A
 tNfm50xk3j5iPC+Pem1X0df65kXtI3JUn5bmXehrzHZEsMCCmvTiCYC6xKYlM0cxiMbjRD5Hpy3
 /dwHZjKepcua9ZNkG+xiEwX/0HMxPgFU7tH9y7fZXP4fez0/hAfuuLs65tvHoOmf1zhD+/+TVMT
 Z+GEVPEczF2wQVUZ/xFzLseIQds9tEgnvz2ElsQY9iquYzUHehJIlLWvnLg1FCJm961hLcPqEea
 9ozffRiSUZyn93c6O3RkbVawEWVLiOm7WQpE7scRE6KkZsNRZkVDMJJ8ETD8nLv6RyAzbIPa5/k
 L4LSplo22Ryvndph/XAn7AuLZ+GH8+ECAakpkrN5pR7RtmmWenHjD0u29HUYd2rjv7i88+J1mX8
 vOA11KF2D6u/VKZydCoXqIMMPEzUgX1wHlKxJUf9T4OXotzcwl7
X-Received: by 2002:a05:6000:2988:20b0:45e:8547:f21e with SMTP id
 ffacd0b85a97d-45ef147c77amr3539107f8f.36.1780055261361; 
 Fri, 29 May 2026 04:47:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/21] target/arm: Don't assert if 64-bit EL2 AT insn sees a
 Domain fault
Date: Fri, 29 May 2026 12:47:16 +0100
Message-ID: <20260529114723.42040-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The Domain fault type can only happen for 32-bit short-format
descriptors.  This means that it almost never needs to be encoded in
a long-format fault status code.  However, there is one corner case
where we do need to report it as a long-format FSC: if a 64-bit EL2
does an AT insn on an AArch32 EL1&0 translation regime that is using
short-descriptors and that translation operation hits a Domain fault,
then this is reported in the PAR_EL1 in long-format.

The PAR_EL1 register description defines that this should be reported
as 0b111101 for a level 1 Domain fault or 0b111110 for a level 2
Domain fault.

The Arm ARM pseudocode special cases this in the function
AArch64_PARFaultStatus() (because no other "fault to LFSC" code path
can be a Domain fault).  For QEMU, implement it in arm_fi_to_lfsc().

Cc: qemu-stable@nongnu.org
Fixes: 1fa498fe0de97 ("target/arm: Provide fault type enum and FSR conversion functions")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3512
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260526174155.2491217-1-peter.maydell@linaro.org
---
 target/arm/internals.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index ae5afc5362..f39a992012 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -893,6 +893,16 @@ static inline uint32_t arm_fi_to_lfsc(ARMMMUFaultInfo *fi)
         assert(fi->level >= 0 && fi->level <= 3);
         fsc = 0b001100 | fi->level;
         break;
+    case ARMFault_Domain:
+        /*
+         * This can only happen when doing an AT insn at EL2 for an AArch32
+         * stage 1 EL1&0 translation regime using short-descriptors, and
+         * the translation hits a Domain fault. This needs to be reported in
+         * the long-format PAR. Compare pseudocode AArch64_PARFaultStatus().
+         */
+        assert(fi->level == 1 || fi->level == 2);
+        fsc = 0b111100 | fi->level;
+        break;
     case ARMFault_Translation:
         assert(fi->level >= -1 && fi->level <= 3);
         if (fi->level < 0) {
-- 
2.43.0


