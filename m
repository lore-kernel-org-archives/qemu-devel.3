Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394EDD21269
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 09:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1MyO-0005Ua-Gl; Thu, 17 Oct 2024 05:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t1MyM-0005UN-HU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t1MyA-0006kq-0f
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729157935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/i2tE+BymqkChQAvzNuP5V0DVRMsr+yVJBMxfyAZD8k=;
 b=A0JJCRVuikZU4Ffv/QQftAr8iIm40PFkMnU5u8aQ7WhHk6CZ5DdJZOR2h+F7nhqCJXXzmT
 tymBKbWj/dzK06n5ggMByhJoZrz9QW6pfYu/KnnnnOTW1WjkUv9cF5RGwmVX9x2eWvf8bH
 FwnrfuuwdoMgmW4ya5MOUPdxgSNhEGQ=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-1_LypRqmPfeMT24CxAR6-Q-1; Thu, 17 Oct 2024 05:38:53 -0400
X-MC-Unique: 1_LypRqmPfeMT24CxAR6-Q-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-4a46f0510beso315453137.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 02:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729157933; x=1729762733;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/i2tE+BymqkChQAvzNuP5V0DVRMsr+yVJBMxfyAZD8k=;
 b=ajK7sp7p9DkuqfKD77D9bZbRqJrZrZbWgyRIlxiYPPylNkkLAteDWYDQ8C2BHjXQtJ
 L0i/EspfV0aH+E5YYpKZrlwL5lpxeOiTtrzwwlbi/ccZ+s1dEGn0gfMXp1R11aIwWxmh
 25OP011XRRMNDA7imn8SZd7ueCf1trYOwCeKW24uExmRqmCxM0i35uSVsDqX2JcZZAsZ
 w+w1izL9587oYGclCSW0ka+6lXDNpbwEcwlcTcMKkNV89eITGvUSycoUGgYSqAK5vdmA
 75sxzNPIxNDwbDjxz3J6DmtqVchVketv30nvDcutoAuN7JyT1o3aWR73JFrWLyUJtifg
 ZR6w==
X-Gm-Message-State: AOJu0YylL5tVrj0L0ZPNAgLG2kITFJ09tkgMyDRyhpruoXPJV9nF85DM
 52YcEyjUf7xVYfMUnnS7HgGnJWSTyDpXQTQUOWvLP75W6ByzB3tIInTSlne043iGoNk8RyQNpN3
 iRq09otW2L+CUXdyumaj/DMbEZ74njiVRS5bs7tf1VnjS2RLEXOtt
X-Received: by 2002:a05:6102:134f:b0:4a4:7e16:6176 with SMTP id
 ada2fe7eead31-4a47e16746fmr12004134137.6.1729157932769; 
 Thu, 17 Oct 2024 02:38:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0YM6p5W4k2dNxRa2bdLEgfW5dplitxeAcefe+DTltq6BbpCOQUPMVek0QkbsMbOZov7wPSw==
X-Received: by 2002:a05:6102:134f:b0:4a4:7e16:6176 with SMTP id
 ada2fe7eead31-4a47e16746fmr12004124137.6.1729157932374; 
 Thu, 17 Oct 2024 02:38:52 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it.
 [79.46.200.231]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc2295ac65sm26674906d6.81.2024.10.17.02.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 02:38:51 -0700 (PDT)
Date: Thu, 17 Oct 2024 11:38:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-user: fix shared object return values
Message-ID: <cyf4qzsx56lwi6zbwlclzbhgg3xqhi3btrfwinfx7h6gn4equh@3vigo2wevqug>
References: <20241016090606.2358056-1-aesteve@redhat.com>
 <vmtm4zz6pkfcxr64wixa2wdjb7ujn2vaiapmziaqciiytcwe5v@7fh6zlfyf67l>
 <CADSE00+UFCHOLQHndGThOmXt3eXo4RsJZKC+FyXOuaiPwJbBmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00+UFCHOLQHndGThOmXt3eXo4RsJZKC+FyXOuaiPwJbBmQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Oct 17, 2024 at 10:27:30AM +0200, Albert Esteve wrote:
>Albert Esteve
>
>Senior Software Engineer
>
>Red Hat
>
>aesteve@redhat.com
>
>
>
>On Thu, Oct 17, 2024 at 9:38 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Wed, Oct 16, 2024 at 11:06:06AM +0200, Albert Esteve wrote:
>> >VHOST_USER_BACKEND_SHARED_OBJECT_ADD and
>> >VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE state
>> >in the spec that they return 0 for successful
>> >operations, non-zero otherwise. However,
>> >implementation relies on the return types
>> >of the virtio-dmabuf library, with opposite
>> >semantics (true if everything is correct,
>> >false otherwise). Therefore, current implementaion
>>
>> s/implementaion/implementation
>>
>> I hadn't seen it ;-P found with:
>> ./scripts/checkpatch.pl --strict --branch master..HEAD --codespell
>
>Never used the checkpatch script for spelling. Thanks!
>
>>
>> >violates the specification.
>> >
>> >Revert the logic so that the implementation
>> >of the vhost-user handling methods matches
>> >the specification.
>> >
>> >Fixes: 043e127a126bb3ceb5fc753deee27d261fd0c5ce
>>
>> This is in from 9.0 ...
>>
>> >Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
>>
>> ... and this from 8.2, so should we consider stable branches?
>
>You mean in addition to the commits already reflected here?

Nope, I just mean if we need to cc qemu-stable@nongnu.org in order to 
backport this patch on stable branches.
See docs/devel/stable-process.rst

>
>>
>> I think it depends if the backends are checking that return value.
>
>The return value is optional (requires VHOST_USER_NEED_REPLY),
>and I am not aware of any backend using this feature so far,
>in general. So iiuc, that'd mean no need to include stable, right?

Yep, if no one uses it, we can avoid it for now. On the other hand if 
the patch is simple, perhaps it might make sense to avoid future issues.

Michael WDYT?

Thanks
Stefano

>
>Best,
>Albert.
>
>>
>> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
>> >---
>> > hw/virtio/vhost-user.c | 8 ++++----
>> > 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> Thanks for the fix!
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> >
>> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> >index 00561daa06..90917352a4 100644
>> >--- a/hw/virtio/vhost-user.c
>> >+++ b/hw/virtio/vhost-user.c
>> >@@ -1607,7 +1607,7 @@ vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
>> >     QemuUUID uuid;
>> >
>> >     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
>> >-    return virtio_add_vhost_device(&uuid, dev);
>> >+    return !virtio_add_vhost_device(&uuid, dev);
>> > }
>> >
>> > static int
>> >@@ -1623,16 +1623,16 @@ vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
>> >         struct vhost_dev *owner = virtio_lookup_vhost_device(&uuid);
>> >         if (dev != owner) {
>> >             /* Not allowed to remove non-owned entries */
>> >-            return 0;
>> >+            return -EPERM;
>> >         }
>> >         break;
>> >     }
>> >     default:
>> >         /* Not allowed to remove non-owned entries */
>> >-        return 0;
>> >+        return -EPERM;
>> >     }
>> >
>> >-    return virtio_remove_resource(&uuid);
>> >+    return !virtio_remove_resource(&uuid);
>> > }
>> >
>> > static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
>> >--
>> >2.46.1
>> >
>>
>


