Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805D606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 02:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U1CzRq8h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVgPn-0002Js-99; Mon, 23 Nov 2026 21:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xVgPg-0002It-7A
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 21:37:45 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xVgPe-0001vD-40
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 21:37:43 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-7cc53938a8fso2767640137.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795487860; x=1796092660; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IJnyGOgfkyqTMWhHxesi5FuTy32nEvtXsxsSQ+Ilc6w=;
 b=U1CzRq8hv/+kfak7+8J8oeZok0aOiNDs4GCKw2oFaxqK4ePpxkClEErUV+EqmjfKNk
 Qx5YeILSwdLqET/cyBA3g9dHg/IODxI2YQ/p9j55Z256Gn9HmHb5JTAUcyORRyCQ3jC1
 QE6yYCQAd7wgEUGrZGURCaW4WDkZEHRm6mFO7QXWrEw/nhZF+xr2TdZ0H3MH3wdhb/iV
 VAAhxvCke7h1svkF7k1bq0rF/Yj1m0B0lQvYCHnwYZ9nOfQrKKoTK7+yV5ewy8zW4aph
 rWMMl63At5/gPOxEdZ6rFPD7vGzIuNijodj2bwoC26+eriHQuEoyDyIsrMmAJF1hvzjo
 t7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795487860; x=1796092660;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IJnyGOgfkyqTMWhHxesi5FuTy32nEvtXsxsSQ+Ilc6w=;
 b=bVZYMjfmHI+P0yPRra2sXO8qYOk3wJalOcOzgWOnLEhkYCyHn+nxRXdgmZ/QqAmc59
 LCCYUdB2j4JbtW7V4qfQPX0J9e33FtcOTmjp1OdxzHndnR4tDs8K5NsfDxTST/cGxy85
 dECHpsaAHzpio5qSXPsp5v+y4rJ1m0W+3HZIP8yM3xpiOO96SedDwcpdC2iKfNqRFLtW
 8G5cHd6ifQSKietVOMVB39CV5a4LRjxxT3aZlfEcVoDWOm5XsEOhC7m7GnUCJMeJn5L9
 FUApml4aTecD+JC0dcS26UMXjTm0tf2mYKJHKYNCOAEcDCqXWTMIY41N2wPb5uCs9maD
 gRkA==
X-Gm-Message-State: APuU4Z8ynBJyhwhvdLJK4GotUOPTJ/Yu4F7fHhXuzuouso39UL8CyuHB
 Rbq6zc8guNu7QDRcNWzvoX4gSoLNyhS1FVjA79D4JJNxt6T1TlF2yLri
X-Gm-Gg: AZFdTZcyhine9QqEbCavwWHomR6zx01sTr5rhEBmjtL7RMRzL/ZaRcV7jFWUGtxnD69
 hc5oAZgqIfLjkxbDqa1uSiuHe0ERWieh+UZfYl0iqZEqg+YlDQuaSjbZBjLw0CizBDZ3AsYxyJw
 CUuldScl1ayfkcBuqkPjK+s6nO8isZwia9rDOvSXX9UpX8v1V5Otss4u8mzIYqosSMNoq+6LCSs
 m6K0eGajjfHI8YC0lUi1T5QafIzfoJ5BUc0nyAgniOO6q8AS7Q1/BGnivxDpJvoM7KnU3f2vrZv
 CC41ejeevGy71VQhpRRcxIjUWuf0sGc5Gc5STUktDKH9vuEYTgl5vnTaK+zmfQ31lZTGPLUjX6Q
 6vH8yOuDpurJLFwZ46F8YJpUQ+oKRHdApXUxR2Hw+goZ0OQvoVgOiKhDEIikGAaFI9npy9pv8N8
 QXVFyte+EQcSVuRL45L1/OLIlOC1NTwLalk3aZLz/1P1+ckhsJRzemFlLqeTETWi7f7ZkfmagB9
 xuvMVKSkjDQCMPLHqktJ+nhxE3qWqk4D1qFn/9c5X2fhG0C9eW3EQj/F5Fc5b23et2H/POp4SBX
 3mRMNDMLQNkBBkFerI+nEyaP02osvnPjfnRSKIk=
X-Received: by 2002:a05:6102:f84:b0:7c3:c0b9:8d50 with SMTP id
 ada2fe7eead31-7d7395981edmr6435799137.21.1795487860026; 
 Mon, 23 Nov 2026 18:37:40 -0800 (PST)
Received: from [192.168.0.131] ([2804:14c:3b83:954b::e84d])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99e6e05ac5asm13618504241.9.2026.11.23.18.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 18:37:38 -0800 (PST)
From: Julio Faracco <jcfaracco@gmail.com>
Date: Mon, 23 Nov 2026 23:37:08 -0300
Subject: [PATCH v2 1/2] block/dmg-lzfse: reject truncated LZFSE decodes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-dmg-short-decode-v2-v2-1-e1dee5893891@gmail.com>
References: <20261123-dmg-short-decode-v2-v2-0-e1dee5893891@gmail.com>
In-Reply-To: <20261123-dmg-short-decode-v2-v2-0-e1dee5893891@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Julio Faracco <jcfaracco@gmail.com>, 
 oxsignal <awo@kakao.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795487852; l=2050;
 i=jcfaracco@gmail.com; s=20261112; h=from:subject:message-id;
 bh=F9DJEHglknm8KXCueQWm85USkkPrUmv8U5rOO9fvFtk=;
 b=dvJ5cd9vvXHIjJXJrItFSOHE0WX1Lha7EerZDrSU58zYGllNd8N/cFy8edzHGDoN1SlqdWGlQ
 JQxSLoiY+q0AsqoVvfAAZSwSorHA0wM5OLsuAy3PnD61ZrooqFpU2t6
X-Developer-Key: i=jcfaracco@gmail.com; a=ed25519;
 pk=hAqVCeSg6RtgTRedcz7HIqiICyRcEDanumwIF9bNBHg=
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=jcfaracco@gmail.com; helo=mail-vs1-xe35.google.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dmg_uncompress_lzfse_do() treated any non-zero lzfse_decode_buffer()
return as success.  A crafted DMG can declare a larger chunk output
size than its LZFSE stream decodes to, so the uninitialized tail of
uncompressed_chunk is handed to the guest as sector data -- a heap
disclosure.

Fix this by requiring out_size == avail_out: if lzfse_decode_buffer()
returns less than avail_out the decode was truncated and the chunk is
rejected with an error.  When the return value equals avail_out the
stream may also have been oversized (destination too small), but that
ambiguity is harmless -- the guest never sees stale data either way.

zlib and bzip2 chunk paths already enforce exact output size; LZFSE
did not.

Fixes: CVE-2026-116483
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4662
Reported-by: oxsignal <awo@kakao.com>
Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 block/dmg-lzfse.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/dmg-lzfse.c b/block/dmg-lzfse.c
index 4ea0b9b20d..61b6d567c1 100644
--- a/block/dmg-lzfse.c
+++ b/block/dmg-lzfse.c
@@ -37,12 +37,17 @@ static int dmg_uncompress_lzfse_do(char *next_in, unsigned int avail_in,
                                           (uint8_t *) next_in, avail_in,
                                           NULL);
 
-    /* We need to decode the single chunk only. */
-    /* So, out_size == avail_out is not an error here. */
-    if (out_size > 0) {
-        return out_size;
+    /*
+     * lzfse_decode_buffer() returns the number of bytes written to the
+     * destination buffer, or the destination capacity if the buffer is
+     * too small.  Reject any decode that did not fill the full chunk:
+     * a truncated decode would expose the uninitialized tail of the
+     * uncompressed_chunk buffer to the guest.
+     */
+    if (out_size < avail_out) {
+        return -1;
     }
-    return -1;
+    return out_size;
 }
 
 __attribute__((constructor))

-- 
2.56.1


