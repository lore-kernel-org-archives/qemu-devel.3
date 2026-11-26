Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43248606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HlVXky1E;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=l58rZXkp;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OaPligK/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Eoi32GJP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWhJZ-0000ik-1w; Thu, 26 Nov 2026 16:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWhJD-0000h8-GW
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:47:15 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWhJB-00005u-Kh
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:47:14 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E61681FE7C;
 Thu, 26 Nov 2026 21:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795729630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CCSNqoQZ+gKr5HKfpXcWBtv8W05h0oGi7K0t04rXA/U=;
 b=HlVXky1EaG1xTmKVoUPZciOzrbkiv1sCnoitG977PgL3eEuPKqiVpWizOKINk2+Q8AddtA
 t+hJuMb0arNDNjSqCl/sJy+3vRjNo6hMETpC7Kz1aUgIptDv0/vBk9O/RZbAcQ47PsTz1B
 GcuA1qXSoSYgd1xw+RiZPyTzT+AsDgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795729630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CCSNqoQZ+gKr5HKfpXcWBtv8W05h0oGi7K0t04rXA/U=;
 b=l58rZXkpRY1JMlvqVkzMqSW7yLVdSntYcahQ+eedMiBqcVjnUjykc1iuTd0gNPkpOsEkgQ
 NssmmhTygK5qmRAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795729629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CCSNqoQZ+gKr5HKfpXcWBtv8W05h0oGi7K0t04rXA/U=;
 b=OaPligK/96pg5OxzobNl5ptxDpmBCP/B0sGmFp1msdnP82Wk63BUgw1XrGtY/mjf5gonof
 R0Gm07p0tvmu5axxSzCsQn46bWeDkNeRe2vzJu8LbR34fZBwO+Qub3uzOB8OTFNFF/Rrr0
 PzOFXmQ4X0QJv/DTB51YgRKaV6Z+4n8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795729629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CCSNqoQZ+gKr5HKfpXcWBtv8W05h0oGi7K0t04rXA/U=;
 b=Eoi32GJPEDHu3Fq5UCSxqiQ4myn/u/MKaUKV83YTbEyWptNNKu1L2OEabDhAvyDvmAwg8G
 bZ8WUUrIpR1wYvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC688134CA;
 Thu, 26 Nov 2026 21:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3qzICtuoCGtRZgAAD6G6ig:T2
 (envelope-from <farosas@suse.de>); Thu, 26 Nov 2026 21:47:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 1/5] tests/migration-stress: Fix stress.c loop
Date: Thu, 26 Nov 2026 18:47:00 -0300
Message-ID: <20261126214704.3108327-2-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126214704.3108327-1-farosas@suse.de>
References: <20261126214704.3108327-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The stress.c loop is touching memory out of bounds. The inner loop
variable 'k' is lagging 8 bytes behind the pointers doing the actual
XOR operation:

  for (j = 0; j < pagesPerMB; j++) {
      dataptr = data;
      for (k = 0; k < RAM_PAGE_SIZE; k += sizeof(long long)) {
          ramptr += sizeof(long long);
          dataptr += sizeof(long long);
          *(unsigned long long *)ramptr ^= *(unsigned long long *)dataptr;
      }
  }

I ran into this while tweaking the amount of memory necessary for
running the VM with the stress initrd.

Rewrite the loop without manual pointer arithmetic, use more easily
identifiable patterns and isolate it in an inlined function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/migration-stress/stress.c | 39 ++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/tests/migration-stress/stress.c b/tests/migration-stress/stress.c
index 88acf8dc257..44db4bef8f0 100644
--- a/tests/migration-stress/stress.c
+++ b/tests/migration-stress/stress.c
@@ -156,14 +156,31 @@ static unsigned long long now(void)
     return (tv.tv_sec * 1000ull) + (tv.tv_usec / 1000ull);
 }
 
+static inline void xor_1M(void *ram_start, void *data_page)
+{
+    unsigned long long *addr, *data;
+    int i, j, pages_per_mb = RAM_PAGE_SIZE >> 4;
+    int n = RAM_PAGE_SIZE / sizeof(unsigned long long);
+
+    addr = ram_start;
+
+    for (i = 0; i < pages_per_mb; i++) {
+        data = data_page;
+        j = n;
+
+        while (j--) {
+            *addr ^= *data;
+            addr++;
+            data++;
+        }
+    }
+}
+
 static void stressone(unsigned long long ramsizeMB)
 {
-    size_t pagesPerMB = 1024 * 1024 / RAM_PAGE_SIZE;
     g_autofree char *ram = g_malloc(ramsizeMB * 1024 * 1024);
-    char *ramptr;
-    size_t i, j, k;
+    size_t i;
     g_autofree char *data = g_malloc(RAM_PAGE_SIZE);
-    char *dataptr;
     size_t nMB = 0;
     unsigned long long before, after;
 
@@ -181,17 +198,9 @@ static void stressone(unsigned long long ramsizeMB)
     before = now();
 
     while (1) {
-
-        ramptr = ram;
-        for (i = 0; i < ramsizeMB; i++, nMB++) {
-            for (j = 0; j < pagesPerMB; j++) {
-                dataptr = data;
-                for (k = 0; k < RAM_PAGE_SIZE; k += sizeof(long long)) {
-                    ramptr += sizeof(long long);
-                    dataptr += sizeof(long long);
-                    *(unsigned long long *)ramptr ^= *(unsigned long long *)dataptr;
-                }
-            }
+        for (i = 0; i < ramsizeMB; i++) {
+            xor_1M(ram, data);
+            nMB++;
 
             if (nMB == 1024) {
                 after = now();
-- 
2.53.0


