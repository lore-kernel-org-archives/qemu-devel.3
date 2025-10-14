Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952E5CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kZ0-00061l-7s; Tue, 14 Oct 2025 15:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8kYw-0005zp-VE
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8kYr-0007Yp-V9
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760469592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6i0nVanfDujpYn//cEXKWgfyzyv69/ASXLJkx8rKto=;
 b=iXnLYAACMpE/jKhLXftYzN46oXOmmsJohZheX4QCjZRs4yRJxNxUzi1+wMZx27PiDVrBO/
 6KA3isSSAtb8S1WbIERRap+1TweVchLtSY6mP//BQ8AbIgceHHD+0xmtJW5PGFWDBUQqJC
 LymOwoW8SllOpFnRqXSX0LRkprVHQKs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-ZQbf-LLYOCKFmFpYg18YRw-1; Tue, 14 Oct 2025 15:19:50 -0400
X-MC-Unique: ZQbf-LLYOCKFmFpYg18YRw-1
X-Mimecast-MFC-AGG-ID: ZQbf-LLYOCKFmFpYg18YRw_1760469590
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-856c1aa079bso86834485a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760469589; x=1761074389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V6i0nVanfDujpYn//cEXKWgfyzyv69/ASXLJkx8rKto=;
 b=u2WBaBhIHJCSojqhPq/7nHsVW8Q2pVYbXLe5A17REFnAuEnX3kk3jq1+uMwQoqG3wP
 B1a6tjobxki3JRoYJXyYMtF3nRI1tkL7Ae8SxtvyGeywgU+tUTLGJPqcuYbNAJXbFM63
 pBlxJ+NE/8CSvTijgYHqbHb3/RspkPcdv+fqq+GOMS8ARPL4ej4m4pEV5GM1N1ZI4fIL
 lcTq3VKk4zHllpCxBTsNkj54vPprsutIvEUl7JEPKnTBGMEn+lvJgxt1z8zqnuWMhe2B
 WR4dqjdhyhdUPA40yvil9yIiPspWm73SkVj3UVPTdk0qzG7GYATf7Ne0n89ZxvdvVYdC
 JbpA==
X-Gm-Message-State: AOJu0YwBtK6fzz+eGSyfafZ9S/755Pr2xokcOWg38xYAfb6oUnwnOWgQ
 eeaMfD4Q+VOq0+/gQCnqUfQ4ZT+3IeUN4wjqD8KgVuD7diFXqjiAjVooFDs8HVIv247Ic7XnXAq
 tpkfUBgb8BgrjLoIAWkSPfo+jJ/0P7tofc99rRm/E9aTn31drndv/5zfDbYLJRtPfnL4nfQtlEi
 JfyguY2O8LIHK4WpYYONPGLeTXXdACQ5CmWZswHg==
X-Gm-Gg: ASbGncs1L3YG2d8Echzv0Sqm2DS6cEVnopQXeXA2ihHclM1X0w/QG2RHx8zIiXkEvem
 1objj9kp55Ed9Y0L1SRwPdDvrqCk9adgcHmLKTvbMgkHAyspS9870rxWxjEJ8msDgObN9XBf+24
 CQWa5Q7kEfPnNjDpwa9pz92WpyUPZyJ8h+2h964z/PCW70IcEn8RU5VcFV0xHjHZdCf4SWGna0s
 mfm5x/iA5vkxuodY2Iknm6Sxsc31Joe0qW4i82/rNvANCtzKua5PEhyxu1Ld0skP3uTg5xU32rP
 2N4xR6YziGG2QNV0tZI0/7gJCUW1vg==
X-Received: by 2002:a05:620a:1a06:b0:836:974d:978e with SMTP id
 af79cd13be357-8820d666600mr3452113085a.41.1760469589400; 
 Tue, 14 Oct 2025 12:19:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF1YMSO5fjIviqhqlyWlgg7NrWaBHjGPprZFtXYgRhdhQRs6TkX0J25lpM04xubNqmQAIDWA==
X-Received: by 2002:a05:620a:1a06:b0:836:974d:978e with SMTP id
 af79cd13be357-8820d666600mr3452108785a.41.1760469588862; 
 Tue, 14 Oct 2025 12:19:48 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-884a22744f2sm1256602585a.44.2025.10.14.12.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 12:19:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Richard Henderson <rth@twiddle.net>,
 "Emilio G . Cota" <cota@braap.org>
Subject: [PATCH v2 1/3] qht: Zero-initialize qht_map
Date: Tue, 14 Oct 2025 15:19:42 -0400
Message-ID: <20251014191944.2225735-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014191944.2225735-1-peterx@redhat.com>
References: <20251014191944.2225735-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU almost always do this across the tree except QHT.  This prepares for
rcu to track double free.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 util/qht.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qht.c b/util/qht.c
index 208c2f4b32..872d9f9cec 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -441,7 +441,7 @@ static struct qht_map *qht_map_create(size_t n_buckets)
     struct qht_map *map;
     size_t i;
 
-    map = g_malloc(sizeof(*map));
+    map = g_malloc0(sizeof(*map));
     map->n_buckets = n_buckets;
 
     map->n_added_buckets = 0;
-- 
2.50.1


