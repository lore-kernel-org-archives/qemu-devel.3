Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81A6C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tadnA-0007zP-Uy; Wed, 22 Jan 2025 11:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tadn9-0007up-Lu
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:41:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tadn7-0003u8-LX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737564079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JkWyNTIkap4TrPbaXOEeu1OUYYpcllGw8Q1rkM+h0w0=;
 b=GZja03vc2/5cHkVbG+vvqBjx7ejLzinW+KUII+3ifO1NZ0pUqyNlQOfzsuomQtOGiCCmSI
 QKmrFSAnORSyn76V7+wFioaxNRI1sFEu66GYdO6dtgWcDeA387ylUmJ1MA/lqMk7d+//JT
 42ByKWwbzSuRGNuuBN7SbniFuNeL+kI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-kBvWsNfxN7aiQJhGsh7fLw-1; Wed, 22 Jan 2025 11:41:18 -0500
X-MC-Unique: kBvWsNfxN7aiQJhGsh7fLw-1
X-Mimecast-MFC-AGG-ID: kBvWsNfxN7aiQJhGsh7fLw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361d4e8359so54174615e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 08:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737564077; x=1738168877;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JkWyNTIkap4TrPbaXOEeu1OUYYpcllGw8Q1rkM+h0w0=;
 b=X+Juf4edEC+XQheXNYewM9RfHA9RMvtbWuGBsBHZd91jph1p0z7aV8E/8mKEQqN6sO
 RpVXc9sCRgBG37R+lhbMhtWuLgAY02T2HNtJLuwADfCMfO3D3uoDGKIVBJW+kD88WFWD
 abQX2tCC2QC5UmaVQIceZT+CdVti9ba93cRm33DFHoH5BJIgGOwYnPkRFWzw6bkRrNV+
 4+rbTICfpqQkTCE9HPpJN0Id7N38PM8UyzEYkmKDXE7h1XwW6KiOabQo1uG37Xi6bCKj
 lvSk5ZrNgFfD/vk1oxhCS1jZfpIy+NXZLnQh6xTyh4Bk5YoItqQaQd1DLRPv5CIzfqV0
 kXqQ==
X-Gm-Message-State: AOJu0Yx6jMrWuMTc1cQfmdW5E29ZcHw4R9yPZtYLcMnqXr1LR0ji/Dtd
 DIrwj/E7dS/BRF1znkgMxDDE+EIAzNFHJC8Vn29IXBaNO4RQaz8tM8LpZHvliiluv04yZ7Vq9sN
 OCftgtpCx81oXbTNrDRC8YiO6EbylM1sCIobkG+kSql7ZKAYSvGA0
X-Gm-Gg: ASbGncvvBRAZKqqk2CBDfNaqWeUZswIBdfiLGbWYhxauka/R50/cifeHmtsHMiAlwG+
 LHJX5uwXkr5asvfCci1Pt3a9bCU9VUD1K0MV7zhob9kmniuwqDvKp1gm/vki8vHWu2HrmiBuhaR
 mvix1AX12Uc820ms/fQyHgpU3CHkdStPMz54UrcBI7GWO9lE3e/V31ahktkeGrIopg7L17DuF/Q
 ztFWueTXXc47rSEUoLd7XM/DmMm93wTzWDjWgxgCUQcGSOY0IZoit1vi5HtPN33DMdpqCx6VrML
 wjoIGcZL5UyRgifejSBmRyYHSn03uv5t
X-Received: by 2002:a05:600c:4f84:b0:434:a90b:94fe with SMTP id
 5b1f17b1804b1-438913ca9bamr222956265e9.10.1737564076674; 
 Wed, 22 Jan 2025 08:41:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7zLZ/N/tRbcjLiIR2P6ouU4SXCWmlOYKvwtQH/pIAwhh3Zobc1ZFe/vVzVSPrY6kN1Ae6fw==
X-Received: by 2002:a05:600c:4f84:b0:434:a90b:94fe with SMTP id
 5b1f17b1804b1-438913ca9bamr222955975e9.10.1737564076250; 
 Wed, 22 Jan 2025 08:41:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31c8ac5sm31668205e9.39.2025.01.22.08.41.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 08:41:15 -0800 (PST)
Message-ID: <044af96f-791b-471f-ae90-c17597445fd3@redhat.com>
Date: Wed, 22 Jan 2025 17:41:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user: Silence unsupported
 VHOST_USER_PROTOCOL_F_RARP error
To: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
References: <20250121100029.1106973-1-lvivier@redhat.com>
 <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
 <20250122085828-mutt-send-email-mst@kernel.org>
 <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=0.756, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 22/01/2025 17:20, Stefano Garzarella wrote:
> On Wed, Jan 22, 2025 at 08:59:22AM -0500, Michael S. Tsirkin wrote:
>> On Wed, Jan 22, 2025 at 02:42:14PM +0100, Stefano Garzarella wrote:
>>> On Tue, Jan 21, 2025 at 11:00:29AM +0100, Laurent Vivier wrote:
>>> > In vhost_user_receive() if vhost_net_notify_migration_done() reports
>>> > an error we display on the console:
>>> >
>>> >  Vhost user backend fails to broadcast fake RARP
>>> >
>>> > This message can be useful if there is a problem to execute
>>> > VHOST_USER_SEND_RARP but it is useless if the backend doesn't
>>> > support VHOST_USER_PROTOCOL_F_RARP.
>>> >
>>> > Don't report the error if vhost_net_notify_migration_done()
>>> > returns -ENOTSUP (from vhost_user_migration_done())
>>> >
>>> > Update vhost_net-stub.c to return -ENOTSUP too.
>>> >
>>> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>> > ---
>>> > hw/net/vhost_net-stub.c | 2 +-
>>> > net/vhost-user.c        | 2 +-
>>> > 2 files changed, 2 insertions(+), 2 deletions(-)
>>> >
>>> > diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
>>> > index 72df6d757e4d..875cd6c2b9c8 100644
>>> > --- a/hw/net/vhost_net-stub.c
>>> > +++ b/hw/net/vhost_net-stub.c
>>> > @@ -93,7 +93,7 @@ void vhost_net_config_mask(VHostNetState *net, VirtIODevice *dev, 
>>> bool mask)
>>> >
>>> > int vhost_net_notify_migration_done(struct vhost_net *net, char* mac_addr)
>>> > {
>>> > -    return -1;
>>> > +    return -ENOTSUP;
>>> > }
>>> >
>>> > VHostNetState *get_vhost_net(NetClientState *nc)
>>> > diff --git a/net/vhost-user.c b/net/vhost-user.c
>>> > index 12555518e838..636fff8a84a2 100644
>>> > --- a/net/vhost-user.c
>>> > +++ b/net/vhost-user.c
>>> > @@ -146,7 +146,7 @@ static ssize_t vhost_user_receive(NetClientState *nc, const 
>>> uint8_t *buf,
>>> >
>>> >         r = vhost_net_notify_migration_done(s->vhost_net, mac_addr);
>>> >
>>> > -        if ((r != 0) && (display_rarp_failure)) {
>>> > +        if ((r != 0) && (r != -ENOTSUP) && (display_rarp_failure)) {
>>> >             fprintf(stderr,
>>> >                     "Vhost user backend fails to broadcast fake RARP\n");
>>> >             fflush(stderr);
>>> > --
>>> > 2.47.1
>>> >
>>>
>>> IIUC the message was there since the introduction about 10 years ago
>>> from commit 3e866365e1 ("vhost user: add rarp sending after live
>>> migration for legacy guest"). IIUC -ENOTSUP is returned when both F_RARP
>>> and F_GUEST_ANNOUNCE are not negotiated.
>>>
>>> That said, I honestly don't know what F_RARP or F_GUEST_ANNOUNCE is for,
>>
>> rarp is to have destination host broadcast a message with VM address
>> to update the network. Guest announce is when it will instead
>> ask the guest to do this.
> 
> Okay, thanks for explaining to me.
> So if both features are not negotiated, no one is going to broadcast
> the message, right?
> 
> Could that be a valid reason to print an error message in QEMU?
> 
> To me it might be reasonable because the user might experience some
> network problems, but I'm not a network guy :-)

I'm working on adding vhost-user to passt[1], and in this case we don't need to broadcast 
any message.

So I don't implement VHOST_USER_SEND_RARP and I don't want the error message to spoil my 
console.

-ENOTSUP is an error message for developer not for user.

Thanks,
Laurent
[1] https://passt.top/passt/


