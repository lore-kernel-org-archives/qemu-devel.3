Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28ACEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sazcv-0002Ro-Fl; Mon, 05 Aug 2024 11:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1sazct-0002RJ-SM
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 11:28:00 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1sazcs-0006Qe-09
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 11:27:59 -0400
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-7106cf5771bso2988094b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722871676; x=1723476476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yUH2/zeWtJC7SNP7K/QMSJcOd8bIWt0Lfr5toA+ucYE=;
 b=fUt3n3qlJWEUue5fabDWUSfeMAx6Hz3s2hBWA6ezCWCmc52AHWwdZWSbT8ag29BhKp
 H3s0CQk5Jyd/FTn369gqUjYHPl2KZiu3jjjYLzHYimwATBSh6MhNxcWdHm/OJrV9HWYs
 +c9ENpAz6WqY+sVs9Md8+Ml02dLG5zGcKVTzxlvsPgkuVvB+kQ0ZVFP1j3Tz/TomcAwx
 tftJhd00eGYTh+2aXiVmwBHxmf+LpG4xKMTajqHuR56X0Vqx5B74YnMTMwpVFOo/+JXR
 D6AFVBUOlwMCNhjUoM7RC1SXoRAjPRqKAdxR+03gLHuZAgy+yaQi9i9y5ApqEMVQuMxw
 E5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722871676; x=1723476476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yUH2/zeWtJC7SNP7K/QMSJcOd8bIWt0Lfr5toA+ucYE=;
 b=NvrghP+NeykZCnq2XGLLJPWUn5A3+FJcLWgRgiotU+K9c7bvcq0UmaI2JeixuD9KH7
 o8NAX7hhesC55IW3Poe4hma9cRjps+XZZ+B1ZsP17KDPgbTuo6Ew1xN1b0CMJjAVFMnU
 93GvUprSxx7CIa47yRT7T95NQFmEnZhsimoZUvrFmwu/V4zxDxHwC5O8JSoh4KXqTvlt
 gRUyogMvMpartnWMn0Za1HwQuzke4PbFhLCq4r3Q07QAF8iEAVv6dSys0Kx5lJsJE7U+
 esmSn8qGe+7noURGxhS1RR3aK+9xOw4osqb3aR5Fw7vcA8CN5GixEfGD3whN8ELm88oa
 YGDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSOKenChmausKuZFxwIAp+yd2RVP5etDAacXM/v20ohWg1RhZyto9jvGzvEX8/Ef6Ig767rDfLOOZw3fugF84Jb8I2wGQ=
X-Gm-Message-State: AOJu0YxLKTK0jlOA+8oyMU6f9iooH2oF6AEutn+K6Gp1MCR40DyrHfsk
 aaBEwMJEh8m0THiRI8Z2JfUQ8p8UY5aT9K46RSVEHuHRWM3En6o2dOLqwGiT2WyQPQ==
X-Google-Smtp-Source: AGHT+IEmJV2DX0/H8nOCsO8z8KV7WJeA3NHq8L6TppnWN36z9oJV8QV/LxWI6X0FzdO3iPxfsXcRgQ==
X-Received: by 2002:a05:6a21:e91:b0:1c2:94ad:1c66 with SMTP id
 adf61e73a8af0-1c69953c220mr9748070637.5.1722871675947; 
 Mon, 05 Aug 2024 08:27:55 -0700 (PDT)
Received: from localhost.localdomain ([39.144.190.14])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc4cf655sm10560189a91.38.2024.08.05.08.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 08:27:55 -0700 (PDT)
From: luzhixing12345 <luzhixing12345@gmail.com>
To: sgarzare@redhat.com
Cc: luzhixing12345@gmail.com,
	mst@redhat.com,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user: rewrite vu_dispatch with if-else
Date: Mon,  5 Aug 2024 23:27:27 +0800
Message-Id: <20240805152727.32364-1-luzhixing12345@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3ah6jmrx7buizqytjgzx2oe5jlyv225pa4dih3tfs4g4ovngyd@t3sdu6mhmghr>
References: <3ah6jmrx7buizqytjgzx2oe5jlyv225pa4dih3tfs4g4ovngyd@t3sdu6mhmghr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luzhixing12345@gmail.com; helo=mail-pf1-x444.google.com
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

Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>

>On Sun, Aug 04, 2024 at 10:23:53PM GMT, luzhixing12345 wrote:
>>rewrite with if-else instead of goto
>
>Why?
>
>IMHO was better before this patch with a single error path.

I think this if-else version is more clear for me, and it's good to
keep things the way they are.

>
>>
>>and I have a question, in two incorrent cases
>>
>>- need reply but no reply_requested
>>- no need reply but has reply_requested
>>
>>should we call vu_panic or print warning message?
>>
>>---
>> subprojects/libvhost-user/libvhost-user.c | 39 +++++++++++++----------
>> subprojects/libvhost-user/libvhost-user.h |  6 ++--
>> 2 files changed, 27 insertions(+), 18 deletions(-)
>>
>>diff --git a/subprojects/libvhost-user/libvhost-user.c 
>>b/subprojects/libvhost-user/libvhost-user.c
>>index 9c630c2170..187e25f9bb 100644
>>--- a/subprojects/libvhost-user/libvhost-user.c
>>+++ b/subprojects/libvhost-user/libvhost-user.c
>>@@ -2158,32 +2158,39 @@ vu_dispatch(VuDev *dev)
>> {
>>     VhostUserMsg vmsg = { 0, };
>>     int reply_requested;
>>-    bool need_reply, success = false;
>>+    bool need_reply, success = true;
>>
>>     if (!dev->read_msg(dev, dev->sock, &vmsg)) {
>>-        goto end;
>>+        success = false;
>>+        free(vmsg.data);
>>+        return success;
>>     }
>>
>>     need_reply = vmsg.flags & VHOST_USER_NEED_REPLY_MASK;
>>
>>     reply_requested = vu_process_message(dev, &vmsg);
>>-    if (!reply_requested && need_reply) {
>>-        vmsg_set_reply_u64(&vmsg, 0);
>>-        reply_requested = 1;
>>-    }
>>-
>>-    if (!reply_requested) {
>>-        success = true;
>>-        goto end;
>>-    }
>>
>>-    if (!vu_send_reply(dev, dev->sock, &vmsg)) {
>>-        goto end;
>>+    if (need_reply) {
>>+        if (reply_requested) {
>>+            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
>>+                success = false;
>>+            }
>>+        } else {
>>+            // need reply but no reply requested, return 0(u64)
>>+            vmsg_set_reply_u64(&vmsg, 0);
>>+            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
>>+                success = false;
>>+            }
>>+        }
>>+    } else {
>>+        // no need reply but reply requested, send a reply
>>+        if (reply_requested) {
>>+            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
>>+                success = false;
>>+            }
>>+        }
>>     }
>>
>>-    success = true;
>>-
>>-end:
>>     free(vmsg.data);
>>     return success;
>> }
>>diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
>>index deb40e77b3..2daf8578f6 100644
>>--- a/subprojects/libvhost-user/libvhost-user.h
>>+++ b/subprojects/libvhost-user/libvhost-user.h
>>@@ -238,6 +238,8 @@ typedef struct VuDev VuDev;
>>
>> typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
>> typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
>>+typedef uint64_t (*vu_get_protocol_features_cb) (VuDev *dev);
>>+typedef void (*vu_set_protocol_features_cb) (VuDev *dev, uint64_t features);
>
>Are these changes related?
>
>Stefano
>
>> typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
>>                                   int *do_reply);
>> typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg);
>>@@ -256,9 +258,9 @@ typedef struct VuDevIface {
>>     vu_set_features_cb set_features;
>>     /* get the protocol feature bitmask from the underlying vhost
>>      * implementation */
>>-    vu_get_features_cb get_protocol_features;
>>+    vu_get_protocol_features_cb get_protocol_features;
>>     /* enable protocol features in the underlying vhost implementation. */
>>-    vu_set_features_cb set_protocol_features;
>>+    vu_set_protocol_features_cb set_protocol_features;
>>     /* process_msg is called for each vhost-user message received */
>>     /* skip libvhost-user processing if return value != 0 */
>>     vu_process_msg_cb process_msg;
>>-- 
>>2.34.1
>>

Yes, I'm sorry that I forget to message about it.

Although get/set_protocol_features and get/set_protocol_features actually have the same type, I think the return type of function pointers should be explicit for user interface APIs. So typedef vu_get_protocol_features_cb and vu_set_protocol_features_cb

luzhixing

