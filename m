Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2EFD5CCB9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B5C-0003d1-4O; Wed, 30 Oct 2024 11:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B55-0003au-Js
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B54-0007no-5l
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XauRfFIHmI+9xXD3oz2X/URcYPURxAnB3bljaFQ+418=;
 b=TQtHGDGT6QxVFgd+salpTg/31IdEy+EyofNRi4aV0EBml0jt5VqykzRKFfWGPnf7a7I3IT
 WB6haGXqczPT/l1jC9Y4ZcgeWB5EMNtJxDMpZaEsqSuY3SaSElxJAeUFkc/VjoOzCkrzOY
 xyhDE/UoPUZvhHpNHzN/9Q4nbt0o8lc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-LWT9xeeNOA-Tep8P1pnefg-1; Wed, 30 Oct 2024 11:57:55 -0400
X-MC-Unique: LWT9xeeNOA-Tep8P1pnefg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ce30559894so49776d6.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303874; x=1730908674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XauRfFIHmI+9xXD3oz2X/URcYPURxAnB3bljaFQ+418=;
 b=vwTh95irK7aqNnzdlpZZL5WsU/3NEsCFbeAf+S5Cafekr6V9j8Hal665fYafm1ArRM
 vkDD48vRggSRvIC1FGHOeR0l1xta6LynIOtkpySBWsXA08PpIJnJTVdPDGLbyV0q9k6L
 577vxqk1j2hdyaQ452LgVoZk8qtG3XJ1azzrn2szOsrT2VrU9J0U/rUSfDIsRlqp2aeI
 F9+1jdn1qUf25tV/cPbLIabS0USXJVHrE7yLxFVIa8miVJGbPTH6sG4Dmv0q3EWFovy7
 +UwyYzMutPnJhousvjTQ6ZZmmgjAymCZDkcI0PDH/Mt7OqXCgy5+FFvsorI+4t9ipVXD
 xAYQ==
X-Gm-Message-State: AOJu0YzCST+0wnxq/hESppppHpvNzE32LBKt2G+4+kR8cbr08lU6q1kJ
 VmULaDErQ0g8FFISeIee097GfNfTq5NUu2KP77zhOxKghy50BIxP62YXmF9WWd8eCch5Xy0mlLE
 2/ga20hNg28Pox+wj7wyprhhaalP1wYieJ3zkeqmqDExzWTIQP48iN07oEpRKb6fsvwepg6HnEr
 ElIg9orSG0bTLyDnmE036PPi78kB1sZ9anHg==
X-Received: by 2002:a05:6214:3a84:b0:6d3:447f:db4c with SMTP id
 6a1803df08f44-6d3447fe633mr52796036d6.43.1730303874488; 
 Wed, 30 Oct 2024 08:57:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnoqywHpvrLl8Pz1Pyfms3dap5PkftBtddYq6tMt2MCTXCkxDRzED3gPZ2LLhRk5HoccAnKQ==
X-Received: by 2002:a05:6214:3a84:b0:6d3:447f:db4c with SMTP id
 6a1803df08f44-6d3447fe633mr52795716d6.43.1730303874125; 
 Wed, 30 Oct 2024 08:57:54 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:57:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 10/18] migration/dirtyrate: Silence warning about strcpy() on
 OpenBSD
Date: Wed, 30 Oct 2024 11:57:26 -0400
Message-ID: <20241030155734.2141398-11-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The linker on OpenBSD complains:

 ld: warning: dirtyrate.c:447 (../src/migration/dirtyrate.c:447)(...):
 warning: strcpy() is almost always misused, please use strlcpy()

It's currently not a real problem in this case since both arrays
have the same size (256 bytes). But just in case somebody changes
the size of the source array in the future, let's better play safe
and use g_strlcpy() here instead, with an additional check that the
string has been copied as a whole.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>
Link: https://lore.kernel.org/r/20241022063402.184213-1-thuth@redhat.com
[peterx: Fix over-80 chars]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/dirtyrate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index a74a6aeb56..f7e86686fc 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -437,6 +437,7 @@ static void get_ramblock_dirty_info(RAMBlock *block,
                                     struct DirtyRateConfig *config)
 {
     uint64_t sample_pages_per_gigabytes = config->sample_pages_per_gigabytes;
+    gsize len;
 
     /* Right shift 30 bits to calc ramblock size in GB */
     info->sample_pages_count = (qemu_ram_get_used_length(block) *
@@ -445,7 +446,9 @@ static void get_ramblock_dirty_info(RAMBlock *block,
     info->ramblock_pages = qemu_ram_get_used_length(block) >>
                            qemu_target_page_bits();
     info->ramblock_addr = qemu_ram_get_host_addr(block);
-    strcpy(info->idstr, qemu_ram_get_idstr(block));
+    len = g_strlcpy(info->idstr, qemu_ram_get_idstr(block),
+                    sizeof(info->idstr));
+    g_assert(len < sizeof(info->idstr));
 }
 
 static void free_ramblock_dirty_info(struct RamblockDirtyInfo *infos, int count)
-- 
2.45.0


