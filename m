Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51343C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngq-0000ps-Tr; Mon, 11 Mar 2024 18:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngZ-0000XA-Nr
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngW-00041v-BR
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQpFxxwXLTkQcHkAxj0keU82dn5pcaDLyf+EyopbQPc=;
 b=OUbW80B0gXFYfF8ymxGxQ40+mQugA9Y+bc61EgpkHIvehvUV3t5D87ED7jkxpgQ6MVbsiE
 kATW/iYYMmjf0L/l9ydELDJHrwurCEUgUL1jk88zqtZPLCx/ZqXwxZZNsArmx+lPL8bNLI
 bahm7MDhHzzzPcA4b5pCzcs1dc2I9AE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-LcsL9Nz0MxOMfVgJGQpS-A-1; Mon, 11 Mar 2024 17:59:50 -0400
X-MC-Unique: LcsL9Nz0MxOMfVgJGQpS-A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-690ab2b0de1so15044036d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194389; x=1710799189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jQpFxxwXLTkQcHkAxj0keU82dn5pcaDLyf+EyopbQPc=;
 b=tcmHKcPrfTRfVmC2Q/yyUpW/ZJj+OYxc6/QUT41uXZh6ON7jcfYSu25HL26DpGgoUM
 eG7QmKDYeNVP8Z/b1vqZJ21Pl/QO2GQbSMUyf4GHDyzjGI1u3/dJYYf7E0pBSvFoe9/l
 PFPrmLv3VJ7ZrxDpgDS6oZDrf+OtzrfZa7Au2fFqVsMOHiT9ko4InCRX73lrsaECcPgl
 3nyeN9GolRyYqNdQbOnRlmHnr2ZcnchPid06OFmAfxoLuCihwJDZ6FagBYn78ufZAgRD
 Pi2SOF2jqFGWpSFpdk9NwhoMI34O8P6ZC/m55p8I6hEC0BcROYepxDbhw13aGihCh/WA
 PBrg==
X-Gm-Message-State: AOJu0YxbJcyyyTnSRzwkSOSeXiIAPd/GO0+HZtgcEgyds22Shx/cN/7t
 OKo7mbQtLlsBB5BXNm9mj82wH5VeEk5Xy4ybleFZScH3Rkz3h/s/9RDVJQHK/7iOMtBMdFXIQZJ
 JyHq5CbQ0RF72GQwC9/8bynrgie664MXMn/jddDdTjhpbmqn5UBHml/2YQRORpjkVIcLTNz7Tp8
 ZiNbyqcC9d+XTZIPlmccCoH0ebx1socYUoog==
X-Received: by 2002:ad4:44af:0:b0:690:cdd5:ea47 with SMTP id
 n15-20020ad444af000000b00690cdd5ea47mr130943qvt.4.1710194389469; 
 Mon, 11 Mar 2024 14:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh9+VY42YGZ+FJEdnCNH+diWVLZIuv5WxcOKLZw+FA191OPB63jMazUrHr6f7b5poNrlwGPg==
X-Received: by 2002:ad4:44af:0:b0:690:cdd5:ea47 with SMTP id
 n15-20020ad444af000000b00690cdd5ea47mr130924qvt.4.1710194389011; 
 Mon, 11 Mar 2024 14:59:49 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:48 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Anthony PERARD <anthony.perard@citrix.com>
Subject: [PULL 15/34] migration: Fix format in error message
Date: Mon, 11 Mar 2024 17:59:06 -0400
Message-ID: <20240311215925.40618-16-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anthony PERARD <anthony.perard@citrix.com>

In file_write_ramblock_iov(), "offset" is "uintptr_t" and not
"ram_addr_t". While usually they are both equivalent, this is not the
case with CONFIG_XEN_BACKEND.

Use the right format. This will fix build on 32-bit.

Fixes: f427d90b9898 ("migration/multifd: Support outgoing mapped-ram stream format")
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Link: https://lore.kernel.org/r/20240311123439.16844-1-anthony.perard@citrix.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/file.c b/migration/file.c
index 164b079966..5054a60851 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -191,7 +191,7 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
          */
         offset = (uintptr_t) iov[slice_idx].iov_base - (uintptr_t) block->host;
         if (offset >= block->used_length) {
-            error_setg(errp, "offset " RAM_ADDR_FMT
+            error_setg(errp, "offset %" PRIxPTR
                        "outside of ramblock %s range", offset, block->idstr);
             ret = -1;
             break;
-- 
2.44.0


