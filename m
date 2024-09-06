Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B24CE7AA6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 01:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smO7X-00019Y-Lr; Thu, 05 Sep 2024 21:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1smO7U-00018O-D6
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 21:50:40 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1smO7S-0004UQ-M2
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 21:50:40 -0400
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-710c2dcdfc8so910597a34.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725587436; x=1726192236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekO+TXU11f47zYLvkFUHveU90jVjQGsBAp8Y0J30cvk=;
 b=kRrXBR0tq7uHInuOuzpJBV6eVxdbrAaFL/q3aK0KCNmVR/eFPk5PDzRZSYdfjyhn6Z
 TTx+KT/YymoziA/yGF0IcttpA5opAumVdlpJlV2n0zBAGcyyKJW7gXPWbSmOK2BGTn29
 Kov3JSsmEe1ZOoRiB4EGKU1HEChaxz/wN25tpryCIXWFSt2z8vLVtNGozLN/MYOO0ve8
 sF7QBG+porrGUknQoJ+kAk4OI7DBdqen4kx2hAXr1ZlUHA9IZ/OdB1olukI8T7ZQu2fj
 iZS7pRqrFZedaLhRO05pNVBJNEJJlgtYOIN9UlXOkcshtcz6JoY32apRVVpcipTO/zCl
 ja5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725587436; x=1726192236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ekO+TXU11f47zYLvkFUHveU90jVjQGsBAp8Y0J30cvk=;
 b=jr5/aQN6RzcdmlKFnnGtW1DQz5CXtgVToZkJuqEind12+9UWgQjvKKofS2T+F/l9eb
 WDFifZY4GK5VOF4TJ4VcGUkE8lpUPLGUi+/zaeHQaZsHqm8Mt6M6Mz3JxnmP+cTmTQ5c
 yqdjf20lTAGRusJ4z24MAra4nvffSbnXqFG8IpHYajvltsi3VB5flUYW0yTLNcNelsUJ
 O8Dj4n9cvqztQN4DBbr6IKmYmS0csbuHihaene2lxG3nXMx6c0zuwRtNFzomBvi34wni
 abCshuQyGFv0iBs1Us64Lz+RC+dVdp/3xXKb+16yC9G8MLQO+nMvv2Rj1aSMOuU8ZcdO
 IrbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnomYIYYYvBLYXLDE8+o8ECDs1f0lsDpTw2YxAiGOtnU9fliX8aY3hHd9NxDS2dq2SNHywPhaKa+cK@nongnu.org
X-Gm-Message-State: AOJu0YwY3UIPA5o/AFnX7qylUGN+chFdJr6wUQEKDl9ehDe19uecdyt7
 p6KF3YBZgtUsBG2GfvzmwTvMfGOOhbayQ7sssMcTvuezyw/NgxK+
X-Google-Smtp-Source: AGHT+IH4Ahp6JgE+cyt45Wk8AxAtJ+04bPzh2f10Cv6nV2v3XRsqG7/wOdtJowji7Hzl522iTVYbkg==
X-Received: by 2002:a05:6358:724f:b0:1b8:3635:f1c2 with SMTP id
 e5c5f4694b2df-1b83635f7ebmr154767155d.7.1725587435658; 
 Thu, 05 Sep 2024 18:50:35 -0700 (PDT)
Received: from localhost.localdomain ([39.144.190.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d4fbd8da85sm3999940a12.37.2024.09.05.18.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 18:50:35 -0700 (PDT)
From: luzhixing12345 <luzhixing12345@gmail.com>
To: sgarzare@redhat.com
Cc: luzhixing12345@gmail.com,
	mst@redhat.com,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user: add NEED_REPLY flag
Date: Fri,  6 Sep 2024 09:50:26 +0800
Message-Id: <20240906015026.17138-1-luzhixing12345@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <gtpj4yn3kkvawrjlcdq7zrg7bsfe2wlt2x5eh3pfmiygzkoxtc@pyak5vt5ap3a>
References: <gtpj4yn3kkvawrjlcdq7zrg7bsfe2wlt2x5eh3pfmiygzkoxtc@pyak5vt5ap3a>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=luzhixing12345@gmail.com; helo=mail-ot1-x342.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

>On Mon, Aug 12, 2024 at 12:53:19PM GMT, 陆知行 wrote:
>>Hi, can someone review this patch?
>>I find requests which call  vhost_user_get_u64 does not set NEED_REPLY flag
>
>Can you provide an example to trigger this issue?
>
>Also, with this change all calls to vhost_user_get_u64() will set that 
>flag, is that following the vhost-user user specification?

It will not trigger a bug.

For each function that calls vhost_user_get_u64() like vhost_user_get_features/vhost_user_get_status, if you set a breakpoint in gdb at subprojects/libvhost-user/libvhost-user.c/vu_dispatch and you will find that

```
bool
vu_dispatch(VuDev *dev)
{
    // ...
    need_reply = vmsg.flags & VHOST_USER_NEED_REPLY_MASK; // 0

    reply_requested = vu_process_message(dev, &vmsg);     // 1
    // ...
}

vhost-user protocol doc list some requests that need reply like VHOST_USER_GET_FEATURES/VHOST_USER_GET_PROTOCOL_FEATURES, the flag should be set with NEED_REPLY_MASK.

The current code does not raise an error because in libvhost-user(vu_process_message) it will not check this flag and always choose whether or not reply based on the request type.   

So this patch fills the flag and make sure need_reply to 1 for the requests that need reply.

>Please use `scripts/checkpatch.pl` before sending patches, this one for 
>example is missing SoB.
>
>Thanks,
>Stefano
>
>>
>>luzhixing12345 <luzhixing12345@gmail.com> 于2024年8月4日周日 23:50写道:
>>
>>> Front-end message requests which need reply should set NEED_REPLY_MASK
>>> in flag, and response from slave need clear NEED_REPLY_MASK flag.
>>>
>>> ---
>>>  hw/virtio/vhost-user.c                    | 2 +-
>>>  subprojects/libvhost-user/libvhost-user.c | 1 +
>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>>> index 00561daa06..edf2271e0a 100644
>>> --- a/hw/virtio/vhost-user.c
>>> +++ b/hw/virtio/vhost-user.c
>>> @@ -1082,7 +1082,7 @@ static int vhost_user_get_u64(struct vhost_dev *dev,
>>> int request, uint64_t *u64)
>>>      int ret;
>>>      VhostUserMsg msg = {
>>>          .hdr.request = request,
>>> -        .hdr.flags = VHOST_USER_VERSION,
>>> +        .hdr.flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
>>>      };
>>>
>>>      if (vhost_user_per_device_request(request) && dev->vq_index != 0) {
>>> diff --git a/subprojects/libvhost-user/libvhost-user.c
>>> b/subprojects/libvhost-user/libvhost-user.c
>>> index 9c630c2170..40f665bd7f 100644
>>> --- a/subprojects/libvhost-user/libvhost-user.c
>>> +++ b/subprojects/libvhost-user/libvhost-user.c
>>> @@ -667,6 +667,7 @@ vu_send_reply(VuDev *dev, int conn_fd, VhostUserMsg
>>> *vmsg)
>>>  {
>>>      /* Set the version in the flags when sending the reply */
>>>      vmsg->flags &= ~VHOST_USER_VERSION_MASK;
>>> +    vmsg->flags &= ~VHOST_USER_NEED_REPLY_MASK;
>>>      vmsg->flags |= VHOST_USER_VERSION;
>>>      vmsg->flags |= VHOST_USER_REPLY_MASK;
>>>
>>> --
>>> 2.34.1
>>>
>>>

