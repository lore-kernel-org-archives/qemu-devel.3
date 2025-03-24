Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3463C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twiMb-0007Lv-99; Mon, 24 Mar 2025 10:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLj-0006wC-0O
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:00:21 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLh-0004JX-AS
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:00:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224341bbc1dso80794815ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742824816; x=1743429616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlz5insXNGirWw1fpepNAXpu+8KjfbCSVztWowcaXXE=;
 b=BnhRVrli92sWdz9xLJI1L1ZUk4kbxZGwERMtpbqC6s8jlHkMGtZSpHtJycqBygfYme
 wvsQIhU9SRcThTzN0MSk25nSQyQge9ZpSzeaqVG4TCsWLPVYkuvYC6J194RhIpASAHvP
 K8iBmyPZI5MLuCFTY1Z3riMT0UeE/nm1sfjlb7ebCU4I2kujNtz2U0LX0tv7BkdImPwO
 b9/zQyctX3OQyoOZZe3EEnpZCOEDQFFy5u4TZnd1zqNRaRJdwTIecgbS4kWJsODv57aU
 9+heYRWyY5qISRWvqKLLh54Wp0rdyMpkki7//UY+RjBBxqET6+6x2hp8ph5FGPAyRvla
 gg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742824816; x=1743429616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlz5insXNGirWw1fpepNAXpu+8KjfbCSVztWowcaXXE=;
 b=vv0spP1IGzLtpwBlzPiu3U/ooeJckMljLJFY9m0MlAUQBWNsifOpYw3nexJbZZMx/c
 akomMRs8sxwGq0SDT1VSlG+25dShZKK/azzdPgxcc2ydWOXSAD1iOfYF5g0DTWBTzK5f
 sc13pGUoOJir8VPd3B9lwp82LjB4WEwi1kUl9azF6mWOSQSAQxDysJt03/s1pU/bX6Hn
 zJEp8uEM36PGFSmdQfMr46nvmjQkQK4SR5D2gx8pzEfQNzwlEr9JEc3+su+ZVchzUG4f
 e7ODEX3+OlGCYP3rl3H/44HIaURg+KwohAPXd+68cCoGTb073BWlxoHRi9YG5aL3/y1W
 QSCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP0kD2BAecLi9ihL2YSWwX8xkKkPQm7GNYS/lqS1jGyUVjoxhSCUtk5tkjQ1zJjbr22W01IiCtjfR7@nongnu.org
X-Gm-Message-State: AOJu0YxxxouD9GjTTGxLRw/5PTmml6Vdoyd/3XEhtBNj5LPDLlQK0aXu
 DttTXFuJQaBr+Mpi/f3CEhd1HDf9p97oafrxxE0KhbbMZyF+rwHc
X-Gm-Gg: ASbGncuQlJ0Gk4yTT/PVgq9x2/LsoBGGSZtb1iLfnXHQGx04I2VlhElN7VyeSKoaly0
 Suq5AGqoZTwgHdWuinEapEsQzSTRERDOgdDes5652Ut3T2SXO/2ncqS7Sd5cElet5BTS9lBTBmo
 ErZJ0RR3QbPxOwixDholtr1WVmMsodplPm3bdtaW6wb7tunKOfb+HYYozvTrJvKAZVCYxM/Yuk0
 tzdFkVmFtWSB1ChBPvbePxcXe7IcZfftRt/35zERsyLztk63vls21bVNjuaY81YQWOtZOELIRl2
 wQqEx4TF+SwvIkkPu6RL3fdqv3jE1u8rmOit2iM=
X-Google-Smtp-Source: AGHT+IEzN5yFVvLyACZVA0LUitVNvTEQfdv/pZLapcGPcAk+r/GtlDhHfwsZyJ5o+Dt1PBPEvtiU0g==
X-Received: by 2002:a17:903:2286:b0:224:249f:9723 with SMTP id
 d9443c01a7336-22780e38317mr185819985ad.51.1742824815565; 
 Mon, 24 Mar 2025 07:00:15 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390614afb5sm7870544b3a.121.2025.03.24.07.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 07:00:15 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com,
	qemu-devel@nongnu.org,
	sahilcdq@proton.me
Subject: [RFC v5 6/7] vhost: Validate transport device features for packed vqs
Date: Mon, 24 Mar 2025 19:29:20 +0530
Message-ID: <20250324135929.74945-7-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324135929.74945-1-sahilcdq@proton.me>
References: <20250324135929.74945-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Validate transport device features required for utilizing packed SVQ
that both guests can use with the SVQ and SVQs can use with vdpa.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes from v4 -> v5:
- Split from commit #2 in v4.

 hw/virtio/vhost-shadow-virtqueue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 8430b3c94a..035ab1e66f 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -33,6 +33,9 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
          ++b) {
         switch (b) {
         case VIRTIO_F_ANY_LAYOUT:
+        case VIRTIO_F_RING_PACKED:
+        case VIRTIO_F_RING_RESET:
+        case VIRTIO_RING_F_INDIRECT_DESC:
         case VIRTIO_RING_F_EVENT_IDX:
             continue;
 
-- 
2.48.1


