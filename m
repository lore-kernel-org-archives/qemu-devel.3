Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36177EDE998
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 07:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soHZV-0000AY-V2; Wed, 11 Sep 2024 03:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1soHZU-0000A1-NE
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 03:15:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1soHZT-0007X0-4P
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 03:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726038919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EO365hKNrGDkELgXmHIYwsiQJGrisqKd/M6ELd+jpE4=;
 b=AVAihIvJjXQ74N+R0He6No9aqfjGVD8LO4fDHT2/fa+058i2oVLEuRHnkHoLKposRdoEDF
 STxiJ5Xr9rXgjXSnPVoDy6yXeIzdiYNIhANhClpnXP8Jt7RCIsnynX9q4YBWW7YsztRijO
 qIut9o6hTzbu7uuCb3BExUrGqZLMIVA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-alvCZuwzOyeiADSMeuDmdw-1; Wed, 11 Sep 2024 03:15:18 -0400
X-MC-Unique: alvCZuwzOyeiADSMeuDmdw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb2c5d634so26971215e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 00:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726038917; x=1726643717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EO365hKNrGDkELgXmHIYwsiQJGrisqKd/M6ELd+jpE4=;
 b=J0rWz5P3Z51knZiWPxbTDGA/KzdWsTtKUHTU3OZKi89gExR952T3YMc0G5egqzvXWF
 GCMWvqXEy9yJxl91EUV3+GH9VzsZt5AozTz/KNoq+7nb6pTzM6YFXqosZ/Za7cQX5Qxm
 66C8/mamBh1Vk/dVrk2+Xlla9OxPruLjoTBKZJmAYHicQhIEiTdAtYiktLrayPNd61eT
 DL8Q4mfDR1RKdujQlg8SAM2UODeL/6KIu4Llfpk6BzazC8+MiS57cYI31SrNq3vg0+kk
 HHxO6dnB2Ret8l2+Je0pst86ml6satQtGrUi8OtBcVr63wB0HrLvdUbuAlUPhUXpubq5
 WYuA==
X-Gm-Message-State: AOJu0YwxUxPasQKTDmKrNdk5yn4ou2XatUqA1QDv/4PdROfDZCRFYljE
 3biyZp32Rfz8ixPAqWGxiqMd24xXcGa4qNW3aHDDPi7qqy61QMnOJ4jryNCbIUBNE1x+iKJvrhL
 dHcZTSWQrDaYansAt0dgRayVZkNTaGuko9xmuCZ/zzs8SX1RTrj5OISm3d+KaAoumBGdiZyfDO0
 x/SIzO969+r4g224Perhu1om9JShA=
X-Received: by 2002:a05:600c:4712:b0:426:62c6:4341 with SMTP id
 5b1f17b1804b1-42c9f987bf3mr117164515e9.20.1726038917008; 
 Wed, 11 Sep 2024 00:15:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAiprqCcileJYRIi5WDqQESplT+engHoAuf2kTecIScYsVnHY9BcJzUc02YKwgPZQHUh3X6p7r5+vTQhq4+uk=
X-Received: by 2002:a05:600c:4712:b0:426:62c6:4341 with SMTP id
 5b1f17b1804b1-42c9f987bf3mr117164325e9.20.1726038916517; Wed, 11 Sep 2024
 00:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240828100914.105728-1-ppandit@redhat.com>
 <20240910131008-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240910131008-mutt-send-email-mst@kernel.org>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 11 Sep 2024 12:44:59 +0530
Message-ID: <CAE8KmOypfY1695Z5EgWeU2gCc=aF6qQESeiosgfkzZ7E6EEzqA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Postcopy migration and vhost-user errors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, jasowang@redhat.com, 
 mcoqueli@redhat.com, peterx@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Michael,

On Tue, 10 Sept 2024 at 22:40, Michael S. Tsirkin <mst@redhat.com> wrote:
> So are we going to see a version with BQL?

===
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index cdf9af4a4b..96ac0ed93b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2079,6 +2079,7 @@ static int vhost_user_postcopy_end(struct
vhost_dev *dev, Error **errp)

     trace_vhost_user_postcopy_end_entry();

+    BQL_LOCK_GUARD();
     ret = vhost_user_write(dev, &msg, NULL, 0);
     if (ret < 0) {
         error_setg(errp, "Failed to send postcopy_end to vhost");
-- 
2.43.5
===

* We ran the test with the above BQL patch, but it did not help to fix
race errors. I'm continuing to debug it, will update here soon.

Thank you.
---
  - Prasad


