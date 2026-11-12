Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009C606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nt69Zk5w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRX4y-00078n-7i; Thu, 12 Nov 2026 10:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xRWow-0007aC-7S
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 10:34:44 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xRWou-0004ZN-GN
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 10:34:37 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-677af43eed4so4991537d50.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 07:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794497675; x=1795102475; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YX0uzXaxGzHtcUKWfAH0tVvgPKthjDaKe+Cz0H0QFLg=;
 b=nt69Zk5waaD4+CiEqTuKo5maniY9NB1sKc+tNM8XL4AA+gm7PWJrIk2qq3or+/3IfN
 4TYJtlc870C/8N+YjVQpyHD8jMGeINIqYrxMD21TOds1Dd43b7j+gRUGvuslFgtN75dy
 YnVneE+ImaQNiHpTnqRqHAIdmcl5Z0mfFnJRP2KVQknDOQDFiei+vqm3y5u4KsSGReIk
 uUYL7gH0YKSBOK4RevHSogJghfZ3+e7o7lxuiLE63FneeYxWjatES/QA/VoJfS4vPqV8
 FGKb9CV8HiRXMnnY6wqduMDafXSTJsnc7srLM+iTU93idkLxizDdsKEaJP9xR/FGnNQO
 9VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794497675; x=1795102475;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YX0uzXaxGzHtcUKWfAH0tVvgPKthjDaKe+Cz0H0QFLg=;
 b=ssUcBlYkPPwCJyglEx1K7XPXgJxKnKN0iOgB7uqhuYgZIxq28fHpAyG5VnYaFiR1Pg
 1ZpV5FJbxu6pm+r9X9hViBakRZthBOUXl/3ar8jGWBIexQocTRy1f/Rg3klZ0tsUSiru
 M2KGeHTXgY5HpQcV/kQJ6pC11BP7Ka7XaxlgMJ9Ypu3kp4VOeiLdVvBaCav/3W7vPxlB
 rXKYd/cQ7XqR+LtBUQRFokEqcbRVDzgbAhuFTJyqaeDC8dpKkuMyEwXjCFWRzEdVPKZI
 FgCyCaCCDSxkpQ7JS+/mTFR/46OOoeHFW23kZ68C3RYWJE7aTZzyFzaaOvpz9kx2dZVJ
 OVPQ==
X-Gm-Message-State: APuU4Z+RRuEhlyFNYU5YY7TH5iyclg2QFJ3qaZWn6wWbJ5pY2QKNMqFx
 EU/Y0k49kQfbv1A/pDMEOOR0CQxA+4xfVA2GZclIKxZVJVdE3L2ksP5irMBHxA==
X-Gm-Gg: AYBFou2YrIEu/VX4cSlNiMdyp9svBBneOQwtHknmfcqr/HXN/HNmsWAYvD9kzUh1I4t
 tITNf4GQBa92gTt0pN9snUPK0FZK8S9GqdAYiixeolP9i5lrs8y4Xb3vs+VW74xi+CTCczbsCvm
 niuFNejB6w+umPKMw1lg560h/18lOixRprVV/obwugw6D2bEYpYvper1gvFQl87PTtxTYVP/dNC
 jA6oQS3LYDEFdmgnMiMxnEb77GPzqk2K68fkJiFhVE/TyyeUlGADGGOi6BvHD4M+u/Z7h6lucp4
 UTjjh3YAYSrVIW8CELkrNx84N1vhiwbU4eVEQEYHEq0GiHJ9ICVQwvM1SU2aHToB/FgQpGFNUgt
 GtQfeXaVZTye3QgkHakREaYZGHAM5zlJvRN3KEDCQv8e5GsYjnmynA9LcJd0XRKc/8Tj/QsbQdt
 K7oJ/C4v0nyIZntOqAD+yr6VfTo3zxdRi54WCydrLwJCzSSn+NAb1kQYloTLDAAH6JnsNTgrpE5
 pgauWEVoUVUq+uzJhdPK0kLD5sAONqRP/SfshwSfJjb2GsP7hHN1B71n9e2eNudOIscUhJ+0qJJ
 38aXh9gOsZMn/2JHmQ==
X-Received: by 2002:a05:690e:43c5:b0:67c:1dca:80d with SMTP id
 956f58d0204a3-67c67fabc89mr2926391d50.69.1794497675264; 
 Thu, 12 Nov 2026 07:34:35 -0800 (PST)
Received: from [192.168.0.195] ([2804:14c:3b83:954b::221c])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c58a09074sm7656618d50.18.2026.11.12.07.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:34:34 -0800 (PST)
From: Julio Faracco <jcfaracco@gmail.com>
Date: Thu, 12 Nov 2026 12:33:56 -0300
Subject: [PATCH 1/2] block/dmg-lzfse: reject short LZFSE decodes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-dmg-short-decode-v1-1-f7f342097b60@gmail.com>
References: <20261112-dmg-short-decode-v1-0-f7f342097b60@gmail.com>
In-Reply-To: <20261112-dmg-short-decode-v1-0-f7f342097b60@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, 
 Julio Faracco <jcfaracco@gmail.com>, oxsignal <awo@kakao.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794497667; l=3737;
 i=jcfaracco@gmail.com; s=20261112; h=from:subject:message-id;
 bh=XZ5vwBF3GlRwZHRdlVeL5lr2xHF+6hHh4EotpXGq8i8=;
 b=7D10GTMc81miZmeIegAg6J3HQrh6b1L0lMzpQy5IKGqa6bZ6o04UwjQc5raTIGWGUBCdWJPWV
 tLWaYPWabeMBtCcVtz5fllQ7cJKwDuHgMukEn7GAv3LgEClT1xPgEWh
X-Developer-Key: i=jcfaracco@gmail.com; a=ed25519;
 pk=hAqVCeSg6RtgTRedcz7HIqiICyRcEDanumwIF9bNBHg=
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=jcfaracco@gmail.com; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Nov 2026 10:51:10 -0500
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dmg_uncompress_lzfse_do() treated any non-zero lzfse_decode_buffer()
return as success. A crafted DMG can declare a larger chunk output size
than its LZFSE stream decodes to, leaking the unzeroed tail of
uncompressed_chunk to the guest as sector data -- a heap disclosure.

lzfse_decode_buffer() returns the destination capacity both for an
exact-size and a too-small destination, so decode with one extra byte of
capacity (allocated in dmg_open()): an exact stream returns avail_out, a
short or oversized one does not. Require out_size == avail_out. Decoding
in place also avoids a per-chunk g_malloc()/memcpy() of up to 64 MiB in
the read path.

zlib and bzip2 chunk paths already enforce this; LZFSE did not.

Fixes: CVE-2026-116483
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4662
Reported-by: oxsignal <awo@kakao.com>
Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 block/dmg-lzfse.c | 27 +++++++++++++++++++--------
 block/dmg.c       |  8 +++++++-
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/block/dmg-lzfse.c b/block/dmg-lzfse.c
index 4ea0b9b20d..b1acd87135 100644
--- a/block/dmg-lzfse.c
+++ b/block/dmg-lzfse.c
@@ -33,16 +33,27 @@
 static int dmg_uncompress_lzfse_do(char *next_in, unsigned int avail_in,
                                    char *next_out, unsigned int avail_out)
 {
-    size_t out_size = lzfse_decode_buffer((uint8_t *) next_out, avail_out,
-                                          (uint8_t *) next_in, avail_in,
-                                          NULL);
+    size_t out_size;
 
-    /* We need to decode the single chunk only. */
-    /* So, out_size == avail_out is not an error here. */
-    if (out_size > 0) {
-        return out_size;
+    /*
+     * lzfse_decode_buffer() returns the destination capacity both on an
+     * exact decode and when the destination is too small, so on its own it
+     * cannot tell a full chunk from a short one. The caller allocates
+     * next_out one byte larger than avail_out (see dmg_open() in dmg.c);
+     * decoding with that extra byte of capacity lets an exact decode
+     * (out_size == avail_out) be distinguished from a short or oversized
+     * stream, without a per-chunk scratch allocation or memcpy.
+     *
+     * next_out MUST have room for avail_out + 1 bytes.
+     */
+    out_size = lzfse_decode_buffer((uint8_t *) next_out, avail_out + 1,
+                                   (uint8_t *) next_in, avail_in,
+                                   NULL);
+
+    if (out_size != avail_out) {
+        return -1;
     }
-    return -1;
+    return out_size;
 }
 
 __attribute__((constructor))
diff --git a/block/dmg.c b/block/dmg.c
index 412d4bfc35..aa0a0a2fe5 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -587,8 +587,14 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
     /* initialize zlib engine */
     s->compressed_chunk = qemu_try_blockalign(bs->file->bs,
                                               ds.max_compressed_size + 1);
+    /*
+     * One extra byte so dmg-lzfse.c can decode a chunk in place with a
+     * capacity of avail_out + 1 and still tell an exact decode from a
+     * short or oversized LZFSE stream. See dmg_uncompress_lzfse_do().
+     */
     s->uncompressed_chunk = qemu_try_blockalign(bs->file->bs,
-                                                512 * ds.max_sectors_per_chunk);
+                                                512 * ds.max_sectors_per_chunk
+                                                + 1);
     if (s->compressed_chunk == NULL || s->uncompressed_chunk == NULL) {
         ret = -ENOMEM;
         goto fail;

-- 
2.56.0


