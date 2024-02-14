Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFACC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDEV-000416-OC; Wed, 14 Feb 2024 06:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEJ-0003u8-OA
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEH-00070A-MX
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDW4Dr83WauGt3rYUkraVtb8t0sfCwscB4horrSQHwE=;
 b=aAjL9OEtGD96ys8rxt8W+qAYxLOk50BxgNKKWSXrt0sOd5qUqC84fHJu/9ALgUxEzDHJ3b
 kP/SfJJF8f9vwQmMKOzOaLkIpIceyZCWo9TQZcZ8LF66uNyiDxgZ0xUvwA5AMiHpmLOq1F
 o95+bhvzu5qA4QZVqZCImi6tdY7ciKU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-Yj6JoeTpOya9_LNkJPZdQw-1; Wed, 14 Feb 2024 06:15:03 -0500
X-MC-Unique: Yj6JoeTpOya9_LNkJPZdQw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a2bc664528fso403728366b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909301; x=1708514101;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDW4Dr83WauGt3rYUkraVtb8t0sfCwscB4horrSQHwE=;
 b=PC+0LoCnsBe/2Kvwi9XUWFAq2GBJlBQa9CPfuxcNOG9LK55vxxf1P55cNzvj7TPVzb
 1z99jewMvmoQ+SvKeb12vI0GsCjtbvnk20bXjkswiQ7c+RbhkIUYBm/mlz95f3UfDAWq
 CHcpaQ2WFEywFlmtSNgWgbjz1HK/vBAdBdXNeAhl8eI/zbDyRVpSv71pZn/1LGueFOlA
 Vm6lkPdyZH7oWpvUJODVWqUc86ICGpcNoD/lE3ilrpNbcRqIMp2y1s3ZDua5OYGIEZJ3
 qqNTOSr5U/rAD5MCBG9vwA0oU+1fHEw3ZpyvzCY8YCVt4sWRvX667l7LC3ECy2ZFjXMO
 MXeA==
X-Gm-Message-State: AOJu0YxM7x2SpSC1pgtiWyZL5do6j3+sQvP08bGickds+i1ROc3r7Dg7
 4n6c8+ekvuainQgCFOn8o5/ubtvrC5dsbKXd0Y5iTr9Gh5b9N8wZ/jpdmxf2cw9VfURspPPkZkU
 PXLVCT+zSAVyEG5WM/Y4Svu6cwZ6EcgfqZ6fp3wBHaA/KTPwrdOw2xlRw/tinYU75Q8qPHJyWZw
 oHFTVRg4ciUGPvKpnAI2Z1oTVfkC1Yfg==
X-Received: by 2002:a17:906:68ce:b0:a3d:6637:9d6a with SMTP id
 y14-20020a17090668ce00b00a3d66379d6amr184459ejr.61.1707909300911; 
 Wed, 14 Feb 2024 03:15:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm7LO85kM6cZMNR0zVI4MLPyYpafFGqBA+FRtvUnFacf/wJCVrDF2nJsXd66rP2JhnRjL/ew==
X-Received: by 2002:a17:906:68ce:b0:a3d:6637:9d6a with SMTP id
 y14-20020a17090668ce00b00a3d66379d6amr184435ejr.61.1707909300595; 
 Wed, 14 Feb 2024 03:15:00 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUxEk+/+EfvzJRi35A6MXS4f7MMkBpe0dSCdtFOZyAxO1CP03ndlPI/ju4yBpoU4XVGqKdSujiN7v91C2A6Dg==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 ci18-20020a170906c35200b00a3d32341280sm730301ejb.181.2024.02.14.03.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:00 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrey Ignatov <rdna@apple.com>
Subject: [PULL 33/60] vhost-user.rst: Fix vring address description
Message-ID: <aa05bd9ef4073ccb72d04ad78de32916af31c7c3.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Andrey Ignatov <rdna@apple.com>

There is no "size" field in vring address structure. Remove it.

Fixes: 5fc0e00291 ("Add vhost-user protocol documentation")
Signed-off-by: Andrey Ignatov <rdna@apple.com>
Message-Id: <20240112004555.64900-1-rdna@apple.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/interop/vhost-user.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 9f1103f85a..ad6e142f23 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -148,9 +148,9 @@ Vring descriptor indices for packed virtqueues
 A vring address description
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-+-------+-------+------+------------+------+-----------+-----+
-| index | flags | size | descriptor | used | available | log |
-+-------+-------+------+------------+------+-----------+-----+
++-------+-------+------------+------+-----------+-----+
+| index | flags | descriptor | used | available | log |
++-------+-------+------------+------+-----------+-----+
 
 :index: a 32-bit vring index
 
-- 
MST


