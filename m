Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A354606A334
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M/rpv6tQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUM6z-0004Fk-DD; Fri, 20 Nov 2026 05:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xUM6o-0004Eu-Um
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:44:47 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xUM6n-0007ji-EG
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:44:46 -0500
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-3ae1b34e0d2so1151890a91.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 02:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795171484; x=1795776284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HkHhYkPvRYzpmxeD5z1O5pwdDg/dr3/spBsYEEDgr38=;
 b=M/rpv6tQBPF49rNTu1NtrC2n3EThN1Q95D+yuuVcEHp4GYdrIxE+MAzlTuCmFCfNfU
 GvU4NYAd1uroUT+n8bkAtGGWOcnnCmV+xrPNZ9DSpqH1XMqZQH3bWXcLDZyD84Ghi503
 IQFIt3pgWYiDlHYMai5uAfK9MLlqBLHlnAJAQGvFIzawR9CDtAWaZ8FyBebwuZG4635t
 6Z/l10fUg4HCE0vkq8YN1Uf+komhoflSDL3bsHv1XGNxGxdSn+tfoml0sgYvBZ+8RuNx
 MsBF4KQ/aUORToCC4ePMxdbfHC3gvhvjNLmPPlyITJDoP9ZfaWGEb2UqlzB9Ps7uqJ2e
 DpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171484; x=1795776284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HkHhYkPvRYzpmxeD5z1O5pwdDg/dr3/spBsYEEDgr38=;
 b=K3uOdYgN087RAJK0CoLhYf4Qci543ZHLkhId7o9QylAdiffBZhnhhSC4qGPTtqUc+g
 qk4K8jGjJvqUYByQg9KAPU+WL1TT4a/RmtOua7bDkTjdq5Z/aR9EqPqxpgfKSPX1R35c
 MST6CuqZn0Tb1kOq2KZFIK1PsrLQ2GnR9IWUDCaurOqQWZJwqBhFphAsHtaGtVeykr7q
 21Pg4h7V7cS3GjJ+mV2pQh3tgsBL+uofl6RqUoJBc26CdFDgUN4/hCI1YB5Z4O/cBsM7
 c2MfSijecLL6EOFZEoSpSXJnc4xBRuZSYCQAQuyHYJSgeCqURhLPR6U6gHoqjIkZIhVg
 1e6Q==
X-Gm-Message-State: APuU4Z95d8Kvvi3q/sIolTa51m18k5O1uVp84CKK3kqf3y6uAk9nSRFe
 9BIZB+XqIJNO96ZjQ3dnQaUtGFEbHbBx4HeYMxXRTtIS1eQoI02DV/dAS46DcU4qqXQ=
X-Gm-Gg: AZFdTZfy5S6jJYTZxbqZixk8h80iODM+JEbDArHdUpF4is42rqliBsOvwzaINhcvSVg
 u5vGFQhXmmbia9pnl0xWLq2PSirqfsFeEL9I7hGSeXMI3n2tSrn5ib1nILyTjp+Z1ZzPoqyC50J
 ygfxKFJ0W1Agj8VzETkKUCgXt+t0E2+bOXVdquWxgN2LnNH69PNM+c1PSnjChIJZce1/6rB+ZD2
 ormXfiFb6ufqFl76n3+AYNxr87biTJauR5zEo3lANwb2xY7Ry4kpnlXLhqMLQ28zw61gyeTu/YA
 FQB0S3p+tFGNVt7mWAt8ltqyU1ooEsKdsmtdXPyLZ2biXN4QXDijqx2yS6znKat8SE6AgFjARE1
 SCD2ImpK2MWs6iVFBQn8p8Uj88iBsRHtS3p/Kyuf/KbncaAf0osMoMRS5t1uetB7UFZ4sefFfcl
 TyrPFX+IXlfrwIwtVEotKVmMcgP3qVlhr6HRpDALJEJWQMlJJPdvmBHifmbj5kM2iG3JNlBXlA0
 nxMOH4OCEFo7T4Q8ZvKtE/58J0chbeRUTAU9pNJeI/O8PpvdJxVyJkUsnsUX7ZWshmdKz5pbH1M
 /KE96NsePQXGl8CzKEd06giSraD75Bg=
X-Received: by 2002:a17:90b:4a51:b0:3b3:b8dc:5dfa with SMTP id
 98e67ed59e1d1-3b40a5a46bdmr3327838a91.10.1795171483551; 
 Fri, 20 Nov 2026 02:44:43 -0800 (PST)
Received: from computer ([2604:3d09:98d:800:cd94:7b9e:bb89:3491])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6cfc80d4sm1151506a12.6.2026.11.20.02.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:44:43 -0800 (PST)
From: Tim <mdspan.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com,
 Tim <mdspan.github@gmail.com>
Subject: [PATCH v2 2/5] accel/tcg: compare large pages under the flush mask
Date: Fri, 20 Nov 2026 10:44:28 +0000
Message-ID: <20261120104431.733136-3-mdspan.github@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120104431.733136-1-mdspan.github@gmail.com>
References: <20261120104431.733136-1-mdspan.github@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=mdspan.github@gmail.com; helo=mail-pj1-x1044.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tlb_flush_range_locked() flushes entries whose address matches the
range under @mask, the low @bits of the address.  Its large page
check, however, compares the range end with the recorded large page
in all bits.  If the large page was entered under an address that
differs from the flushed range above @bits, the check fails, and the
large page is not flushed.

Compare under @mask as well.  This matters for the x86 LAM emulation
in a later patch, which installs TLB entries under tagged addresses
and flushes every tagged alias on INVLPG of the untagged address with
tlb_flush_page_bits_by_mmuidx().

Signed-off-by: Tim <mdspan.github@gmail.com>
---
 accel/tcg/cputlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index dc83f3ba..ad2a5aa1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -691,8 +691,10 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
      * Check if we need to flush due to large pages.
      * Because large_page_mask contains all 1's from the msb,
      * we only need to test the end of the range.
+     * Compare under @mask, ignoring bits above @bits.
      */
-    if (((addr + len - 1) & d->large_page_mask) == d->large_page_addr) {
+    if (((addr + len - 1) & d->large_page_mask & mask) ==
+        (d->large_page_addr & mask)) {
         tlb_debug("forcing full flush midx %d ("
                   "%016" VADDR_PRIx "/%016" VADDR_PRIx ")\n",
                   midx, d->large_page_addr, d->large_page_mask);
-- 
2.47.3


