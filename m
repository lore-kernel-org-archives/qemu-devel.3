Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB94C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 11:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZqME-0006sm-Ko; Fri, 02 Aug 2024 07:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sZqMC-0006rh-Oz
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 07:22:00 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sZqMB-00075Q-0H
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 07:22:00 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fd640a6454so63907075ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 04:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722597717; x=1723202517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/W4HOWdp9M8JPFz1nZKMqd6j4+8CcehdV+OKEGXBKH0=;
 b=B9RgPWvBeZKRvAThtSBJOVA2xQDy0yzkCpLE72cKy7p5MG8nL6SbgqQs0OIT1dQpJP
 TxVf7CIKU4B7J/L+GcjVv3zuB59dUOZqitGjZDcWUdYgHaBh8xODH/veWDE2W5F7n5OH
 Y06GWgxlRtEezMjxblrA3n769B0nYxCpGB/YT/neDmyNb0glSEUh5NHKVD0Rq3i2h6tv
 t0bDHAp+wna2IzKoRppsydLlbdfOnPQcX+iTY99gcTUg0OzxM2OVGpCXPA4KH8T9NkE0
 /Os2H2IaFrkH0Y2kuReJDKKmfDN8YgPq7bGIwBcjwnamvBIWgaS5OPe7aWZ7cXU8uiQT
 Vucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722597717; x=1723202517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/W4HOWdp9M8JPFz1nZKMqd6j4+8CcehdV+OKEGXBKH0=;
 b=XKgL+VnIsJwY9VPnr1F1oFFKM/8Q5HPI/pSnRliTBdCqveyEd2TBGcyIpeNHcwOjv5
 aZ5DSdlSh+E+WYBm0h7ApBKwBD2vy8BX8Ase98dfhYbzJ1GrtSkTLbXqJSClgV2FTTqG
 UrR23rgL5uaORKPz0M7wEgVop+TQsLWHPmdb8lVhxoYtLQSG/+7HHoy070A4rzsRW6iz
 6ORHIfImSQVxQk0LjTURW2EVSusOYnD6qxYeFrNI+0ytYUjOa8OansG1vBeU0y/U4T09
 cjuHqjmn3J74mdbporFkBoJ2VmuRhNV5dmSv+Not+/yu4iSXq7FsfAXYlcW3lGqB12j+
 TgsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyMGO2pVqZv5w1qx7cV/VGrFAYwWuoxYhfg4MYpxzab0YU9Z45egq4OSB8U5f/RSVkmTwVSFEW3wF3@nongnu.org
X-Gm-Message-State: AOJu0YxbzP/Me+XdlRt0VkS3z9C90CmCXNIqTt7LYF2z2Z9KS+J3eH5+
 cykg0xUcIgiIgn/tl+dX0KP3cRnHAOKIZmorDk+nT0f04TBOp/2ZAM/XNQ==
X-Google-Smtp-Source: AGHT+IGAC/0+0YFA+SGBzDBwi/3wdqrm1uWgWQiLnsKBAdZmD1/W4Mu4je23XNJAur0X68p6ERyOVw==
X-Received: by 2002:a17:903:2443:b0:1fd:6655:e732 with SMTP id
 d9443c01a7336-1ff574caa46mr30660465ad.54.1722597716586; 
 Fri, 02 Aug 2024 04:21:56 -0700 (PDT)
Received: from valdaarhun.. ([223.233.85.12]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5929ae4esm14801335ad.269.2024.08.02.04.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 04:21:56 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, icegambit91@gmail.com,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC v3 0/3] Add packed virtqueue to shadow virtqueue
Date: Fri,  2 Aug 2024 16:51:35 +0530
Message-ID: <20240802112138.46831-1-sahilcdq@proton.me>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

Here's a new patch series that incorporates all
the suggested changes from v2.

I have tried my best to deduplicate the implementation.
Please let me know if I have missed something.

I'll also test these changes out by following the
suggestions given in response to v1. I'll have more
confidence once I know these changes work.

Thanks,
Sahil

v1: https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg03417.html
v2: https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg06196.html

Changes v2 -> v3:
* vhost-shadow-virtqueue.c
  - Move parts common to "vhost_svq_add_split" and
    "vhost_svq_add_packed" to "vhost_svq_add".
  (vhost_svq_add_packed):
  - Refactor to minimize duplicate code between
    this and "vhost_svq_add_split"
  - Fix code style issues.
  (vhost_svq_add_split):
  - Merge with "vhost_svq_vring_write_descs()"
  - Refactor to minimize duplicate code between
    this and "vhost_svq_add_packed"
  (vhost_svq_add):
  - Refactor to minimize duplicate code between
    split and packed version of "vhost_svq_add"
  (vhost_svq_memory_packed): New function
  (vhost_svq_start):
  - Remove common variables out of if-else branch.
  (vhost_svq_stop):
  - Add support for packed vq.
  (vhost_svq_get_vring_addr): Revert changes
  (vhost_svq_get_vring_addr_packed): Likwise.
* vhost-shadow-virtqueue.h
  - Revert changes made to "vhost_svq_get_vring_addr*"
    functions.
* vhost-vdpa.c: Revert changes.

Sahil Siddiq (3):
  vhost: Introduce packed vq and add buffer elements
  vhost: Data structure changes to support packed vqs
  vhost: Allocate memory for packed vring

 hw/virtio/vhost-shadow-virtqueue.c | 230 ++++++++++++++++++++---------
 hw/virtio/vhost-shadow-virtqueue.h |  70 ++++++---
 2 files changed, 206 insertions(+), 94 deletions(-)

-- 
2.45.2


