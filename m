Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A130606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cKt4ymdF;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZWGs4Ocd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7En-0005B7-L1; Wed, 28 Oct 2026 13:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EF-0004sx-4j
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EB-0003S1-3F
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VxQ84FnwuFcw5jzemhhwZPHJwlt2gY07XFTGheCjRu8=;
 b=cKt4ymdFtR1iWbM9/OzjqH/vUg0TJ6qOXaTrrQUG8rW6kggXV7fzDv5bKM6iDRl/jj+lSc
 0tMMrvbgOX1LwFWjA9DJSkYQlI6lgy/iePJLz5kAYZbzEq2WSLT6uHW99z8TNB4qJ+0Tvt
 F/6gQdXTcdJZIkGx5r9D9EVoqcTuKdI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-MrL_Sin-MWyhCSLQNd38MA-1; Wed, 28 Oct 2026 13:14:16 -0400
X-MC-Unique: MrL_Sin-MWyhCSLQNd38MA-1
X-Mimecast-MFC-AGG-ID: MrL_Sin-MWyhCSLQNd38MA_1793207655
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a4af69e06fso8908735e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207655; x=1793812455; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VxQ84FnwuFcw5jzemhhwZPHJwlt2gY07XFTGheCjRu8=;
 b=ZWGs4OcdfI+zshpOX0Dyg1GWQxyYzr4G2ZcQ0Mj0z+XLW6XYPzKE5v+Zw3WnpymiwO
 2v1Qu1ES+dSuW+vEk4lT7JB+ms9q20c89gI+vhL26XlzjUsa8kgQ+gSbAwu5BSBx5fB2
 SFsCjAPFonu9BscGxAWiR32j3DCFUBCIPWrYDYOC1Z3ohSJK6Pm84wV3bkqHJQh8b888
 wmOIb0QvVxpdn1YHbCmQqZ7G3QejENWU9nTs7/saQP3evTP4SGSwZkOGFigeed1wjIST
 up5dI8BWUlZdugI3lp6wGFHfb8Xq5SKnTklyRHhYz6BV4Njmlv0mH0MntIDRO78xP03m
 cRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207655; x=1793812455;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VxQ84FnwuFcw5jzemhhwZPHJwlt2gY07XFTGheCjRu8=;
 b=sSPapmu314Q2W7d5fX+o66iWJeMwOf48a/EHQiwWWb6WgUlq1LCYAdFYfOMqqLa/kM
 6hFeoEnKECQ5EDiuya+0nBOjbbhcESTthBZyOayiCBfeh4IcVY7HXqi71xXVwHbKQa3o
 Ltpog8wwDIRgwwsq5AsmhZ4beKA8CJzS42kZXfeEBUM1gs3WecljTGUm2yW8P5nh1ZVm
 oM2I96CMd0Y+f1ZKFc97Q4AeLkilnPMd0Z8zV9bI3yZvAqKxtdWZ0yWUCOPtWzPDfcMt
 x5Mo/+N2Rtx9egzyvQkKjtrDTBAmqxoADZvb3X4weOHRUiGAaQWmL8GzA4TTqhaGuIPk
 Uf3A==
X-Gm-Message-State: AFq9FYIXW50Cumggy2t1tBwdAxXTJVbjjDU1lz0hKdaENglLrA7R2sg1
 nsGwYHvk0vLLsLh1VSS040xcfnMUBSQ9X6egk4Ms5FA0+s6HQL4jBckw7WvIkc5my+h7xnvMwvY
 ud5A7EtNYFyu1qQvAnolgl9xCIvFsFg2c3WPwB1GLDoHLj1e8lZpfLMDlMnNeXs876yjQ0t+kcZ
 rS6f33IDWx/WfBwP/4vbAtFz31etwURmnoIQ==
X-Gm-Gg: AYBFou1LsZoFDEW/HehXBYVmvVDzNgPUhpE82vg3mcMQLJfJKfrahKvXMAZIWFF7qF4
 sGERlAT8PpXHOxNLfyf2dj7TAJ93hLAAWJzich3BWCYJMSbpg60+yCwItzZB1U4OgdynCmvxhBx
 Xfchr4jRfH71TI81+QbHLOqLMnJuHOHWR/s8p4ms4abmNOjkEE6JAsgxxlHNtUs3QCAIdZgKFvK
 mLrvHnKYFrEoHXJPZU+rZp7hXtb4tCAcPrezySo2Qnm0oaHwVUJryBEyMfeyeOsZJy5wOmoLsRF
 jFK3tDmbhW+5V8NkNlqs/KjybkaZlWWUNa8Gq/A0LcJFLcjhnblDnGyFjxw756UVaVRAy0f0a6N
 eYjm9kH5Nc090hKLryvey6s+DQ2JXJYD8k6RCdnm+
X-Received: by 2002:a05:600c:34d3:b0:4a1:e0db:8cf8 with SMTP id
 5b1f17b1804b1-4a9643d37f7mr68313925e9.3.1793207654760; 
 Wed, 28 Oct 2026 10:14:14 -0700 (PDT)
X-Received: by 2002:a05:600c:34d3:b0:4a1:e0db:8cf8 with SMTP id
 5b1f17b1804b1-4a9643d37f7mr68312275e9.3.1793207653828; 
 Wed, 28 Oct 2026 10:14:13 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece14a1sm30729155f8f.57.2026.10.28.10.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:12 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL 07/78] net/tap: move vmstate initialization to new_tap()
Message-ID: <13c5f0e2120290425d7b5137d061b90a58f41420.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Otherwise, incoming_fds case in net_init_tap() is not covered,
and the mechanism will not work for outgoing local migration,
if VM start life from incoming local migration.

Fixes: 98a0c2127070 ("net/tap: disable read polling for stopped VM")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260914175351.393680-5-vsementsov@yandex-team.ru>
---
 net/tap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 8039b4e388..9f829f49c1 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -623,6 +623,9 @@ static TAPState *new_tap(NetClientState *peer,
 
     s->queue_index = queue_index;
 
+    s->enable_poll_on_resume = false;
+    s->vmstate = qemu_add_vm_change_state_handler(tap_vm_state_change, s);
+
     if (has_permit_local_migration) {
         s->permit_local_migration = permit_local_migration;
     }
@@ -968,9 +971,6 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     int sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
 
-    s->enable_poll_on_resume = false;
-    s->vmstate = qemu_add_vm_change_state_handler(tap_vm_state_change, s);
-
     if (!tap_set_sndbuf(fd, sndbuf, sndbuf_required ? errp : NULL) &&
         sndbuf_required) {
         goto failed;
-- 
MST


