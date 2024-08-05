Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E643EC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sazkh-0001rE-0j; Mon, 05 Aug 2024 11:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sazke-0001qd-SY
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 11:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sazkd-0008Oq-7s
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 11:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722872155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hInkbm9/R28QX1RT4xD4HapwJKGPCUeSNTkNj1cwUNU=;
 b=S3nnjt4Z0Vj3ccBdxQw79n2bTLe5nTbWIvKoIK3kw4sV4Jr1fzfAGw0w8WTl9PhoZmzBrq
 Ef9kpmORhk1nBehluDuno3sR2DnqMrFoATfMMsg3s2/XAOkmYvWO4wgt8P/O7MMJVTqnVG
 zWvCNl+5G8XaQDMu/kHNS0EUh8gPPak=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-Hr4ecw6xM8arUSP33oAbzQ-1; Mon, 05 Aug 2024 11:35:53 -0400
X-MC-Unique: Hr4ecw6xM8arUSP33oAbzQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-427b7a2052bso105260955e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 08:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722872149; x=1723476949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hInkbm9/R28QX1RT4xD4HapwJKGPCUeSNTkNj1cwUNU=;
 b=UQtpl8VULKxRVBTNZ5qyF7uWYHwKjGMOead79ZU+slu+6lzdBopQmzAQm6ciafDw6/
 VmiXv5LV5tDEMQOTJ7D5szvbvWIB/VKbhkpLFpN2QzrI4wHMf//FAUA91ZgWuzug8+k0
 hRaKX9C20bdF5+UwKLE6XsBoJwMwLfng+V+apEeKLN3Df7yJ/gc7kX6LgtX5QSKWgsj8
 IyjkPM3sUE0SMZZG32e82wym+sol4vuJ131emE3y2tGP58yPnWEhnB0XWPEWUKuk0rSx
 zrUl4tisXouEhIZt6wVPk4ZvFxollT3opIwCLutIEuQuPd6gBQMsQJCp4DZfOQ712VOq
 fkmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDaFh8uyNm0WV7YuxXiUodnZTRr/yV9VWGZl+02cY+ipP8zb7ujaQhEYJACo4A32okM2yGvV9ZOkE6yzGRFuuhjZmPoMo=
X-Gm-Message-State: AOJu0YyRAe4LEsXGAiMcg+eXUnQEq824BNZKV/Ud+D72ewvP/qwUd+ZI
 0COElm+OVYQUhjXLrcWZrBwgJaRXiGNw5JA323H0vKXVmR56phBVrR5GBMOxp3nmRw7334rMhwI
 8xItOFMLLLoGLI2qCqx7QJmJHj18xq1WH3+KlL+vMiqJR+7iX3jle
X-Received: by 2002:a05:600c:4ec6:b0:426:5c81:2538 with SMTP id
 5b1f17b1804b1-428e6b03d8cmr97039055e9.14.1722872149515; 
 Mon, 05 Aug 2024 08:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH8QggXp6tIlEf2WAWoA4Rkb2VXzBkyfa1/XMcYOFZIw6MI2GaZtrSkpWRWoqKaPQt0c4vLQ==
X-Received: by 2002:a05:600c:4ec6:b0:426:5c81:2538 with SMTP id
 5b1f17b1804b1-428e6b03d8cmr97038745e9.14.1722872148731; 
 Mon, 05 Aug 2024 08:35:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:c3eb:758b:cbeb:6cf8:adc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e7d615sm142724415e9.29.2024.08.05.08.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 08:35:48 -0700 (PDT)
Date: Mon, 5 Aug 2024 11:35:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: luzhixing12345 <luzhixing12345@gmail.com>
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user: rewrite vu_dispatch with if-else
Message-ID: <20240805113456-mutt-send-email-mst@kernel.org>
References: <3ah6jmrx7buizqytjgzx2oe5jlyv225pa4dih3tfs4g4ovngyd@t3sdu6mhmghr>
 <20240805152727.32364-1-luzhixing12345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805152727.32364-1-luzhixing12345@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 05, 2024 at 11:27:27PM +0800, luzhixing12345 wrote:
> Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>
> 
> >On Sun, Aug 04, 2024 at 10:23:53PM GMT, luzhixing12345 wrote:
> >>rewrite with if-else instead of goto
> >
> >Why?
> >
> >IMHO was better before this patch with a single error path.
> 
> I think this if-else version is more clear for me, and it's good to
> keep things the way they are.

Whoever writes code always thinks his version is the clearest.
Code should be written with reader in mind.
Stefano happens to be the reviewer, so pls make things clear for him,
not for you.

> >
> >>
> >>and I have a question, in two incorrent cases
> >>
> >>- need reply but no reply_requested
> >>- no need reply but has reply_requested
> >>
> >>should we call vu_panic or print warning message?
> >>
> >>---
> >> subprojects/libvhost-user/libvhost-user.c | 39 +++++++++++++----------
> >> subprojects/libvhost-user/libvhost-user.h |  6 ++--
> >> 2 files changed, 27 insertions(+), 18 deletions(-)
> >>
> >>diff --git a/subprojects/libvhost-user/libvhost-user.c 
> >>b/subprojects/libvhost-user/libvhost-user.c
> >>index 9c630c2170..187e25f9bb 100644
> >>--- a/subprojects/libvhost-user/libvhost-user.c
> >>+++ b/subprojects/libvhost-user/libvhost-user.c
> >>@@ -2158,32 +2158,39 @@ vu_dispatch(VuDev *dev)
> >> {
> >>     VhostUserMsg vmsg = { 0, };
> >>     int reply_requested;
> >>-    bool need_reply, success = false;
> >>+    bool need_reply, success = true;
> >>
> >>     if (!dev->read_msg(dev, dev->sock, &vmsg)) {
> >>-        goto end;
> >>+        success = false;
> >>+        free(vmsg.data);
> >>+        return success;
> >>     }
> >>
> >>     need_reply = vmsg.flags & VHOST_USER_NEED_REPLY_MASK;
> >>
> >>     reply_requested = vu_process_message(dev, &vmsg);
> >>-    if (!reply_requested && need_reply) {
> >>-        vmsg_set_reply_u64(&vmsg, 0);
> >>-        reply_requested = 1;
> >>-    }
> >>-
> >>-    if (!reply_requested) {
> >>-        success = true;
> >>-        goto end;
> >>-    }
> >>
> >>-    if (!vu_send_reply(dev, dev->sock, &vmsg)) {
> >>-        goto end;
> >>+    if (need_reply) {
> >>+        if (reply_requested) {
> >>+            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
> >>+                success = false;
> >>+            }
> >>+        } else {
> >>+            // need reply but no reply requested, return 0(u64)
> >>+            vmsg_set_reply_u64(&vmsg, 0);
> >>+            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
> >>+                success = false;
> >>+            }
> >>+        }
> >>+    } else {
> >>+        // no need reply but reply requested, send a reply
> >>+        if (reply_requested) {
> >>+            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
> >>+                success = false;
> >>+            }
> >>+        }
> >>     }
> >>
> >>-    success = true;
> >>-
> >>-end:
> >>     free(vmsg.data);
> >>     return success;
> >> }
> >>diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
> >>index deb40e77b3..2daf8578f6 100644
> >>--- a/subprojects/libvhost-user/libvhost-user.h
> >>+++ b/subprojects/libvhost-user/libvhost-user.h
> >>@@ -238,6 +238,8 @@ typedef struct VuDev VuDev;
> >>
> >> typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
> >> typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
> >>+typedef uint64_t (*vu_get_protocol_features_cb) (VuDev *dev);
> >>+typedef void (*vu_set_protocol_features_cb) (VuDev *dev, uint64_t features);
> >
> >Are these changes related?
> >
> >Stefano
> >
> >> typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
> >>                                   int *do_reply);
> >> typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg);
> >>@@ -256,9 +258,9 @@ typedef struct VuDevIface {
> >>     vu_set_features_cb set_features;
> >>     /* get the protocol feature bitmask from the underlying vhost
> >>      * implementation */
> >>-    vu_get_features_cb get_protocol_features;
> >>+    vu_get_protocol_features_cb get_protocol_features;
> >>     /* enable protocol features in the underlying vhost implementation. */
> >>-    vu_set_features_cb set_protocol_features;
> >>+    vu_set_protocol_features_cb set_protocol_features;
> >>     /* process_msg is called for each vhost-user message received */
> >>     /* skip libvhost-user processing if return value != 0 */
> >>     vu_process_msg_cb process_msg;
> >>-- 
> >>2.34.1
> >>
> 
> Yes, I'm sorry that I forget to message about it.
> 
> Although get/set_protocol_features and get/set_protocol_features actually have the same type, I think the return type of function pointers should be explicit for user interface APIs. So typedef vu_get_protocol_features_cb and vu_set_protocol_features_cb
> 
> luzhixing


