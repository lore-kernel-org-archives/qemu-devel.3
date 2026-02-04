Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489C4EA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniCE-00041g-8A; Wed, 04 Feb 2026 14:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniB6-0002xP-2z
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniB4-0008BA-J7
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L23IMh10X5sj0b6aRSM+e7tHXvaNfxEorymlt8NTJG8=;
 b=f/l697eQ959wvDUXrQZ7CbQ381NKXJb2iTtaKIBhSywbjHNeN3covasmBI0gx58MiMUEnk
 2Ny1A+iQjwukuYtqbmsrgBzoGBdKTIND/cacT5G9PVlsTsmqnrUqa/PAZEBmR+3w4YqIyk
 nhxUsH6shfnpQPG2bjGIjrtIC6zRRrs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-Evp2hlTDPBmIX_hWYu74Ow-1; Wed, 04 Feb 2026 14:04:36 -0500
X-MC-Unique: Evp2hlTDPBmIX_hWYu74Ow-1
X-Mimecast-MFC-AGG-ID: Evp2hlTDPBmIX_hWYu74Ow_1770231875
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-432a9ef3d86so121139f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231874; x=1770836674; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L23IMh10X5sj0b6aRSM+e7tHXvaNfxEorymlt8NTJG8=;
 b=TK/ReU/9lXtYAWXGmaw3wD4s1SMoSU54Zd8d8jRwHLViMe92MU4mHbKl50YqWcUHo9
 zh9uUX3y8Z/MkdZZRGAwbhzapVpcSU4dCZ7zYS2yl5pCaLlze/Q0x1Ee5tK4iNkgtwRk
 VIJHrJtvOtbI6QFeG2nAgyJw+lz30HAavpB/5VWIGzy+RFCnqdYVwZFgZ+wdxd7qa4aX
 6bUKcttx8VHP+gcVW399pjGanHHTBHDTtMRVBMX1snq7tTK2c0mAG+/6rHLdpertbb4D
 7zfIv6bAd6yzt6RgyfNsBXa9g+HRAsXRZSu80bhM8/lOjXYd3dt7cvfTZpRix6Uyn0j6
 6Icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231874; x=1770836674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L23IMh10X5sj0b6aRSM+e7tHXvaNfxEorymlt8NTJG8=;
 b=s5KVhhX38xeDzoOJWVGwsm2fHFVIUTd1IzJkg5BPEz9uJ80e3dy/RcjGqjAFf54lid
 SbXadCR1QLupPuUWMKZgc/q7sJr/jBiK+k8/sv8/yTyNrJcd6zlcYaLyle2sEwF0yXrM
 4ItqAoQwm2v3E9I9zFkOpC7MIIgeEYojnXTvJiFWDfo5sfQTLBQ4xpalI/uFLDbBSKDv
 KUsXLEMGlYoVqfz0W0XXsfrPHj3v0KaZRSummuZcVk0RYLPyCvr6xktvC4arNQ83mtWX
 /8MB8phhfpnxCSlxDcOvYIUJQ9nHUNRFYodjiI8sKEE4vY856aWp0gmrKFgmEbIYzfeD
 4fLw==
X-Gm-Message-State: AOJu0YxsUEjFlSo7zWP5phLl7iqS9XLX0wO1J6RcwmKmzerVkaz7Rtf/
 7u/FgtJxtXU9WzaoBEMQzR6GmAG8yudrhIIvjAbnTMMMrIsxy1PFwKQ/rDJxkyszCSy4b0WAgfI
 5wa9TnEQCgcYlUtLvxbcMBKwmTr3OfiH0CA0uALTS8wOPcq239xK9GtpybHyQGtB3+fH5ezLqbr
 1gLV/OGo4FFJbYWDm6dBRIgD9WcHRQ45QX9A==
X-Gm-Gg: AZuq6aJgPBVCw/lEy4h13Xyr85JlP5BZRy0xZ5lf4XG+SUHZCFAjPHaYTIKDbkhFJbx
 T8qd+UtOnbBgqfCVDEGCsoIZ0gTHB+ZApyjV4x3QCR/ZU3TmaiOD2vnlg738PDwNBV1iL9tHqbV
 ypvR+fqEVwUuXaGcFd8CRmEOrKy/EocRf7eryH7e0jpdJYvdMLSGMme6iQncNhuqzqvZBqblNbV
 a8Ll39RTyy0qJoiLjKus9Tp+nCkGUs5vgAsO9V0/AH5PfWf6qaKyPfOL0ap0LMrNXACU5JwAGAF
 yIPovRw/DIuZ4kqvYiQ9fXcHWbp4P29NTkXTUFGA5MujaJnb6LswgYrFbFCeqT4VUAj01sNunBD
 cDssRsfHF3taOMgA5pzsyh0L9GU3i/dvszA==
X-Received: by 2002:a05:6000:2310:b0:436:14fa:a3f3 with SMTP id
 ffacd0b85a97d-43617e42fbcmr5883032f8f.21.1770231874557; 
 Wed, 04 Feb 2026 11:04:34 -0800 (PST)
X-Received: by 2002:a05:6000:2310:b0:436:14fa:a3f3 with SMTP id
 ffacd0b85a97d-43617e42fbcmr5882987f8f.21.1770231874072; 
 Wed, 04 Feb 2026 11:04:34 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e3a3bbsm8253704f8f.15.2026.02.04.11.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:33 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 45/51] vhost-user.rst: specify vhost-user back-end action on
 GET_VRING_BASE
Message-ID: <6382068b45db410891665ad2d3fad95bd4213e64.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

By default, we assume that server need to wait all inflight IO on
GET_VRING_BASE. However, this fact is not recorded anywhere in the
documentation.
So, add this info in rst.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260115081103.655749-2-dtalexundeer@yandex-team.ru>
---
 docs/interop/vhost-user.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 93f756d3f4..505f8d3a33 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1250,7 +1250,8 @@ Front-end message types
 
   When and as long as all of a device's vrings are stopped, it is
   *suspended*, see :ref:`Suspended device state
-  <suspended_device_state>`.
+  <suspended_device_state>`. The back-end must complete all inflight I/O
+  requests for the specified vring before stopping it.
 
   The request payload's *num* field is currently reserved and must be
   set to 0.
-- 
MST


