Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB44C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 13:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siwGC-0000d8-0Q; Tue, 27 Aug 2024 09:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1siwGB-0000cc-5N
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 09:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1siwG9-0006LD-CZ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 09:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724765359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z4/jH/gxr9Ya+hjplG+gIBh26lq6GNFYWERIT17JaaI=;
 b=PggjjQK4Peiknb3LqN3WxObxRv5a75+KS1rxSFmUVSSx7MT6Jg+1i4zmSZCdcUg69FYRjH
 p5k1AhoVP47SzELWcMzrSgdPGQnUYuY1hx86GWW0mO+SCEreZut9pzeN/Xv5AEe4kQUvl4
 3QF4F/6hBjktq8ZjIYI7bh8Hlod+Vek=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-YV7p-4V9PWqbYnlJfW-2Ug-1; Tue, 27 Aug 2024 09:29:17 -0400
X-MC-Unique: YV7p-4V9PWqbYnlJfW-2Ug-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7094641d4c7so6312385a34.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 06:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724765356; x=1725370156;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z4/jH/gxr9Ya+hjplG+gIBh26lq6GNFYWERIT17JaaI=;
 b=NGp88F1v/QUo0zadwOkEVnJPDZLq1A4p6X+dS0ZUpVg+Dk02DJgozCEXyaETz1HwGX
 I8KJItjMIBUE2/WA0Iv0THm33kzVPlYaNrmt0XjxB/PnyLGeCUzQKkvIyG0Nhahmq8uI
 1xJ3kYn5FadldwdNVcbDnSY4JBZ2Th9t4Zr/MIgIK06h4QIDRQcOTZMTDQ/F2mO3rm3v
 RLSsDhKEUR2FW7/BgpTtHECVLy+T5/d30SFBxM1YwF81bLmgNM7YXiZd3jOhzeB5XX8p
 pcigg98TXJlUytdVpw4C98zslRGuKND7+589chagaaE9ewMczVpAMqcFXScm4WigXtuJ
 f8gg==
X-Gm-Message-State: AOJu0YxR8w0kaQSRSzAy9ca7z/oSXKt4o5TAayuVRi4/bCHAWvuG4fk2
 1IbuBUPe+z0UGzAlgNf1Qoas7DiO6CBvzr/zhWsBy0D4a+DSTJhqPD3Ga14dYal1BOhHA3M7trS
 cK2CK/0vq5aUiaCsHxhnRWL88GsNtw8dq+Leg9+mvs+2IE0q5m0u7J6hzBjL1
X-Received: by 2002:a05:6830:3c86:b0:703:68d0:a266 with SMTP id
 46e09a7af769-70f47a7098dmr1152454a34.4.1724765356041; 
 Tue, 27 Aug 2024 06:29:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXxs9eRvVOzwjdc8GZTo+NNELYopmdtGM2o+Qs0Dgm3Rbz1jMkii58stngV6mnluN9mGXoXw==
X-Received: by 2002:a05:6830:3c86:b0:703:68d0:a266 with SMTP id
 46e09a7af769-70f47a7098dmr1152448a34.4.1724765355594; 
 Tue, 27 Aug 2024 06:29:15 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.170.38])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70e03b6024esm2334632a34.63.2024.08.27.06.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 06:29:15 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:29:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: =?utf-8?B?6ZmG55+l6KGM?= <luzhixing12345@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-user: add NEED_REPLY flag
Message-ID: <gtpj4yn3kkvawrjlcdq7zrg7bsfe2wlt2x5eh3pfmiygzkoxtc@pyak5vt5ap3a>
References: <20240804154859.28342-1-luzhixing12345@gmail.com>
 <CAKQy51AyXGb+8Qi6J-6r4gj-USWeAm1qwzurqq0vkFFB8EuLhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKQy51AyXGb+8Qi6J-6r4gj-USWeAm1qwzurqq0vkFFB8EuLhA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Aug 12, 2024 at 12:53:19PM GMT, 陆知行 wrote:
>Hi, can someone review this patch?
>I find requests which call  vhost_user_get_u64 does not set NEED_REPLY flag

Can you provide an example to trigger this issue?

Also, with this change all calls to vhost_user_get_u64() will set that 
flag, is that following the vhost-user user specification?

Please use `scripts/checkpatch.pl` before sending patches, this one for 
example is missing SoB.

Thanks,
Stefano

>
>luzhixing12345 <luzhixing12345@gmail.com> 于2024年8月4日周日 23:50写道：
>
>> Front-end message requests which need reply should set NEED_REPLY_MASK
>> in flag, and response from slave need clear NEED_REPLY_MASK flag.
>>
>> ---
>>  hw/virtio/vhost-user.c                    | 2 +-
>>  subprojects/libvhost-user/libvhost-user.c | 1 +
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index 00561daa06..edf2271e0a 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -1082,7 +1082,7 @@ static int vhost_user_get_u64(struct vhost_dev *dev,
>> int request, uint64_t *u64)
>>      int ret;
>>      VhostUserMsg msg = {
>>          .hdr.request = request,
>> -        .hdr.flags = VHOST_USER_VERSION,
>> +        .hdr.flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
>>      };
>>
>>      if (vhost_user_per_device_request(request) && dev->vq_index != 0) {
>> diff --git a/subprojects/libvhost-user/libvhost-user.c
>> b/subprojects/libvhost-user/libvhost-user.c
>> index 9c630c2170..40f665bd7f 100644
>> --- a/subprojects/libvhost-user/libvhost-user.c
>> +++ b/subprojects/libvhost-user/libvhost-user.c
>> @@ -667,6 +667,7 @@ vu_send_reply(VuDev *dev, int conn_fd, VhostUserMsg
>> *vmsg)
>>  {
>>      /* Set the version in the flags when sending the reply */
>>      vmsg->flags &= ~VHOST_USER_VERSION_MASK;
>> +    vmsg->flags &= ~VHOST_USER_NEED_REPLY_MASK;
>>      vmsg->flags |= VHOST_USER_VERSION;
>>      vmsg->flags |= VHOST_USER_REPLY_MASK;
>>
>> --
>> 2.34.1
>>
>>


