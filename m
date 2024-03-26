Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA07CD11DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 10:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3hy-0006A3-Mp; Tue, 26 Mar 2024 06:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp3hu-00069t-Sm
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:07:04 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp3hs-0000c5-Ox
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:07:02 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e0fa980d55so1431865ad.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711447619; x=1712052419;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jeVS9PSo3JvEOOQjurWYIOm9Xd3Ddz7G6gk/4BbvGG0=;
 b=t+JNe3E0zDoHgxHQ2LJH2NcnaqEk6T9isTltzVRDtR5wF4P6NqCaH8I72O4xyjIG30
 B0WGDLQtdF155T93eBsuIArbYvWpcc1Z7WNKhlxXjKIthUiZI8A7qFzvb9N9AkjEivch
 wMnZBEJda37dSFs2WP8HzShzCQoBFNJ3EAZ2jHNW3aaB2h+PcAQ6irxD8RzWblCrQiqT
 f99Y566CBw3rhao6aikJb+cGZBmRdCaM2ax573E9+p9pxjxmq+15p44CuyICbjAiS5d2
 D5CjNSzM9oilNxQb5oRRTeuClyqxxKknKHMh9dsHGgz1c0c4NefCZnlhdfUJvUZjf5hC
 fzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711447619; x=1712052419;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jeVS9PSo3JvEOOQjurWYIOm9Xd3Ddz7G6gk/4BbvGG0=;
 b=FdhN3G1dfjvyFL38RK6VTZ6kz3s5Xi8hFAN3xDrI25Mk+qLx19411CvobHw2IpmM+M
 zfFVo4MehsRm3Co472GfaAvfZ2kE6T3EvEltZZYWRsPvybowF/VCLx3FrFWhNc4nTcSe
 OM4cD24nqmYShAnXlQfKGcwIMCrDburaPzaHF28r+ncg2oXDy7v1pnT2/upqlOQNYSo1
 Fcn8aL6+QogWKT2P+qUEWC+h/+MJ7WznKbI6DhyLLNabdFvQlE2qOQ6jnKftaP3nyy3N
 7VcJm62Xz0xR4O1kqfRtscvgnTIOkm3JmQfE7CiAewtKbWu63rLF90gG5fJz4Hx/6s98
 q0/g==
X-Gm-Message-State: AOJu0Yw18l8tEDzgJTpP/cbh/6UKy4kyBQZbtuLs7DepD/HzeLzN5Uoo
 ec/0ot7JWJvVRCrruaHy9g0/gJeNsiMB+ykpGBtv8jq5cq9j0HhyPv81HiuFoWM=
X-Google-Smtp-Source: AGHT+IG9bcV4IAshgQl3QUqLtRNHE0qWMOKUCwGkWTG+JFI3o5ZHYGXdROsWxluTlr+VC1Jtk9LXHA==
X-Received: by 2002:a17:902:e74b:b0:1e0:b5d4:9f60 with SMTP id
 p11-20020a170902e74b00b001e0b5d49f60mr597090plf.28.1711447619031; 
 Tue, 26 Mar 2024 03:06:59 -0700 (PDT)
Received: from localhost ([157.82.202.248])
 by smtp.gmail.com with UTF8SMTPSA id
 jc17-20020a17090325d100b001defa97c6basm6386790plb.235.2024.03.26.03.06.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 03:06:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/2] virtio-net: Fix RSS
Date: Tue, 26 Mar 2024 19:06:28 +0900
Message-Id: <20240326-vhost-v1-0-09bd85b1ba2c@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACSeAmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMT3bKM/OISXdNUI7Nki0SjlETTRCWg2oKi1LTMCrA50bG1tQDriaF
 zVwAAAA==
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.13.0
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Some recent changes made RSS unfunctional so here are fixes.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (2):
      virtio-net: Fix vhost virtqueue notifiers for RSS
      ebpf: Fix indirections table setting

 ebpf/ebpf_rss.h     | 2 +-
 ebpf/ebpf_rss.c     | 5 +++--
 hw/net/virtio-net.c | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)
---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240324-vhost-5e26c8a2da5a

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


