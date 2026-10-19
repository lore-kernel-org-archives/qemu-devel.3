Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6521606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BEzre1zT;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pE/f+/eH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIryo-0006Um-8Z; Mon, 19 Oct 2026 14:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryl-0006Sj-Qy
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryk-0005qb-8A
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792434057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbyBGO5Y3CUQEX9fhnEcMZ4uFMh7IQB6HCrs7yEWN9c=;
 b=BEzre1zTeJailtw16QcZUcmuXR0kHg1RD9CfTBV5OsewPFzZqtkNj4HSBgApvH8ptVBtMa
 i4jEjew0XjFMR/QJndtDwYuoAyppn/5n2Lfz0g5EgyILvUGgOE4wjRwxQuOnYQtKO34WpX
 7iNVqeSSyhsFtOolpG6DvnLrGghp0ys=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-t-0HMltcMR-G_1C0penjNA-1; Mon, 19 Oct 2026 14:20:56 -0400
X-MC-Unique: t-0HMltcMR-G_1C0penjNA-1
X-Mimecast-MFC-AGG-ID: t-0HMltcMR-G_1C0penjNA_1792434055
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48c46582442so1544997f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792434055; x=1793038855; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PbyBGO5Y3CUQEX9fhnEcMZ4uFMh7IQB6HCrs7yEWN9c=;
 b=pE/f+/eHg7PoXhzKd5AyZ8PB+TjUmNoxOmpXSXTSsAZTQJHJGVVAWQ4TqJbXd4SkhC
 lEVf07F+iQb1UOmokSZbhHItz3YLb125xVd1YF0CwGNHpQknoyFbGlBideOCFQwyLI7L
 JCHjG5SXf6V3w+QvhlD6G7+N1ZOch730Hm78wUFnY3vE02CW4gYzta6YkAJVGKiVyFPb
 5qF/hYdXln6UfGFAE2d9VngJJ3aMrSkzgqhdxQRj6NFsdtFztvk16jjCgq7ulsKmTIgP
 LLjTpqy/khx/JLUJPKw/gnVmnZDFItNqFrxLEMpBHOQfiFUTIDFnNXOH8DPrFSGv37Qv
 +Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434055; x=1793038855;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PbyBGO5Y3CUQEX9fhnEcMZ4uFMh7IQB6HCrs7yEWN9c=;
 b=XkoiFyJtAtfXQr/phfhAWSmq6jT4bUFT7FeeyliXCgcV7a9ScjmJHcx8mCsaP9sn6q
 SpCWOjHT4z/rWKEFIX/RIq8vbg0qFAByjIIrSWBrVHOr4IDEa1PA27lKktfe4N/CSmth
 18I1PLPLgX0cuFTOUmaoftac4Nw/Nl7pZBrhMuWTqmUDm9PHueoeEbSQNszsKE+bsb0g
 xOseWyb48/4GwoEho/OYm7xsKXfdZ9OFPZD+u0SvNC3gKitf0zYBZa2h6nPSucPLhbLS
 bufnf3lmsfDZgDImpa2vpV8cEo6HHGPq643oiOeYklR/C83mKyZqamBHtO/1OsQHlPt+
 b66A==
X-Gm-Message-State: AFq9FYLpk1xv/xj9I+pESvpndTCKjOnJnJuuynr3/H3Fkwk0QF/NVwY0
 lijRJ9Axk62PAOl0iy8R+U6K0iEDTphpaiwyqlV5lDDZMwLmbaxOu6uZnL9abshvU+rxDGgTDvW
 G81IbHRY2Keu/lQNYRH2bknzF+D0UuAhGN0siBE0JsWKj9BH9j16xNQAa
X-Gm-Gg: AYBFou01h3yzNUZJ8JxZUIW5o1BgCOjnQeIWN4GZdxTqMMzNO20pXAlBSw+kIJ8Og66
 nsBRWNp1ZlSd1vHYqm0hEI9tqGo0cLjsAahJ1mTsoCb/yU8Wb81dkfj6jEqNktLM1IjnFxgz36P
 ex6u7vbVWHkdmO4YHg6rjg7GN3tuAQqk2bvxldXeaCRnc2su7lEHKLi1jUdUmeWhHe5po+ZAz8T
 yRlrLs4aXGcv0cs06bKWzLm7gfg2t39nIE6XxfcE/bZ+tYiOGhhA90JuriuwOdyr7s02FLgK7Bw
 W1b9u/f8dypPPfOSPN93fI+0f5lwTCwzcmCF60YSei2W2n2Mafp/9Tts3y4S/+LYYkxL2AvZftw
 Arnqg8AX0G9MZ9h1l5VIPLsioz+wI/mViT0LTLCofZrDXq2+9IQZo+yVU6g==
X-Received: by 2002:a05:600c:548c:b0:49f:dc71:e609 with SMTP id
 5b1f17b1804b1-4a1d7610f2dmr184106005e9.20.1792434054738; 
 Mon, 19 Oct 2026 11:20:54 -0700 (PDT)
X-Received: by 2002:a05:600c:548c:b0:49f:dc71:e609 with SMTP id
 5b1f17b1804b1-4a1d7610f2dmr184104655e9.20.1792434053419; 
 Mon, 19 Oct 2026 11:20:53 -0700 (PDT)
Received: from localhost
 (p200300cfd705ccf50633a9a8543b8b67.dip0.t-ipconnect.de.
 [2003:cf:d705:ccf5:633:a9a8:543b:8b67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d85a9bsm9638645e9.15.2026.10.19.11.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:20:52 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 08/12] block-backend: Public blk_get_attached_dev_path()
Date: Mon, 19 Oct 2026 20:20:24 +0200
Message-ID: <20261019182028.45305-9-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019182028.45305-1-hreitz@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make blk_get_attached_dev_path() public so we can use it in the I/O
operation delay QMP event to identify the affected guest block device.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/system/block-backend-io.h | 9 +++++++++
 block/block-backend.c             | 6 +-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
index fd84723d9d0..63b2dd2e24f 100644
--- a/include/system/block-backend-io.h
+++ b/include/system/block-backend-io.h
@@ -41,6 +41,15 @@ bool blk_iostatus_is_enabled(const BlockBackend *blk);
  */
 char *blk_get_attached_dev_id(BlockBackend *blk);
 
+/*
+ * Return the QOM path of the block device attached to the
+ * BlockBackend.
+ *
+ * The caller is responsible for releasing the value returned
+ * with g_free() after use.
+ */
+char *blk_get_attached_dev_path(BlockBackend *blk);
+
 BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
                                   int64_t bytes, BdrvRequestFlags flags,
                                   BlockCompletionFunc *cb, void *opaque);
diff --git a/block/block-backend.c b/block/block-backend.c
index ab837fac921..78678986466 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1054,11 +1054,7 @@ char *blk_get_attached_dev_id(BlockBackend *blk)
     return blk_get_attached_dev_id_or_path(blk, true);
 }
 
-/*
- * The caller is responsible for releasing the value returned
- * with g_free() after use.
- */
-static char *blk_get_attached_dev_path(BlockBackend *blk)
+char *blk_get_attached_dev_path(BlockBackend *blk)
 {
     return blk_get_attached_dev_id_or_path(blk, false);
 }
-- 
2.55.0


