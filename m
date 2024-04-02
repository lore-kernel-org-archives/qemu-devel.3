Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE79FCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rres9-0004z4-Af; Tue, 02 Apr 2024 10:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rres7-0004yo-SK
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:12:19 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rres5-0006bQ-MT
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:12:19 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d6a1af9c07so60080651fa.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067135; x=1712671935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ehdesixLJLpzYmLBmiTK36Y5FPxYPD58KAGAbKLVsE=;
 b=Xk5s68HtVCoCyf/V5DJX11V3HcL+fU64Ldqi19KYC79/Pj8VXwD6d4eSD/u4/4w7ya
 bn2Y8u7bW4YS4nTZ13zNtGwHObi/leW+87TDvukI3yziRQ63VAF2VKwE2grv9JLAPxCh
 uJeOwQHNeE7bHo875i7eZ8GdM92M1MHqoGoy35mrjAFW8xp5NbMg0V/3FxBJw1yLma98
 8PApa9KOOc99yXSaC2jEKL58tsQZyMiFVgW9gbxD7k0GMihmbZiwlivlvFbFx7I6S11B
 l7P8IddhGnewEQdNauy5253qQGCKZRy8utFedtZJCkgt0oJhdN9PDHgXG31IKjsRlenb
 FLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067135; x=1712671935;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ehdesixLJLpzYmLBmiTK36Y5FPxYPD58KAGAbKLVsE=;
 b=UY4qfLxf3chlO82MalzfoZsM/IrMrlDuthUH+J27CKmV6+H4l6zHBzW/h4USWv5ocS
 rNW4Cl+mr69aHTDw5n/PXVimQaBTFukf97y+gL9VqRIpCz3OwJYQK4m/Tr4jpp+lG1OK
 BQiQAQoAjByerywF3+1dampEKldYgY+cceRvahAE2hbZYQGXiqQgAGcQah1CQtcgT5fK
 hp5XhQA4d2p9T60f4uu34atKsYkRJIC55ylD6T2jhiJ+RHntLCcvRtHV8QseT0r6oAM4
 qghQCYn81fZb1Yf/3DyZvwvv1IMov5uZ5r4NwCdKQuSDtyfPBFKIAFSMXTErlKUsKEps
 Lq6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZEI1y7UqKean5rOJ/xFY9neCAH1DStfoDIX6S8fpVChPr35LOpK+hMz5cjja7k6xzIqRK5sAhJq4c8QCz921keiOGRGE=
X-Gm-Message-State: AOJu0YweyeINQwCFH/4HxvYKhnqk/GJvNL9p00WH2OjHTdNGEUG9rsDT
 82ZUA9B8wssfIFPD4iW/GorKDK61n2mBrOkhhGklwwnHDLighJw2qs4BLZiS8Y8=
X-Google-Smtp-Source: AGHT+IG+4McjeDEc7r+qex3xZkcORlT4FNGcJeC5CwpH3z9ICqruf/L/zwobIlRJIc4McPx/7SgQ5g==
X-Received: by 2002:a2e:9098:0:b0:2d6:c189:5dbd with SMTP id
 l24-20020a2e9098000000b002d6c1895dbdmr8173938ljg.31.1712067135159; 
 Tue, 02 Apr 2024 07:12:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a05600c444d00b0041569a819dbsm5389923wmn.1.2024.04.02.07.12.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 07:12:14 -0700 (PDT)
Message-ID: <8093d4b6-3563-47ad-a5a6-91646ed08372@linaro.org>
Date: Tue, 2 Apr 2024 16:12:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: fix qemu set used ring flag even vhost started
To: Yajun Wu <yajunw@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>
Cc: Jiri Pirko <jiri@nvidia.com>
References: <20240402045109.97729-1-yajunw@nvidia.com>
 <059cb96a-ac0b-4266-bd6e-8911c387baeb@linaro.org>
 <7014db95-617b-4f7e-8c2a-cc639c089969@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7014db95-617b-4f7e-8c2a-cc639c089969@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2/4/24 14:41, Yajun Wu wrote:
> 
> On 4/2/2024 8:11 PM, Philippe Mathieu-Daudé wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Yajun,
>>
>> On 2/4/24 06:51, Yajun Wu wrote:
>>> When vhost-user or vhost-kernel is handling virtio net datapath, qemu
>> "QEMU"
> Ack.
>>> should not touch used ring.
>>>
>>> But with vhost-user socket reconnect scenario, in a very rare case (has
>>> pending kick event). VRING_USED_F_NO_NOTIFY is set by qemu in
>> "QEMU"
> Ack.
>>> following code path:
>>>
>>>        #0  virtio_queue_split_set_notification (vq=0x7ff5f4c920a8, 
>>> enable=0) at ../hw/virtio/virtio.c:511
>>>        #1  0x0000559d6dbf033b in virtio_queue_set_notification 
>>> (vq=0x7ff5f4c920a8, enable=0) at ../hw/virtio/virtio.c:576
>>>        #2  0x0000559d6dbbbdbc in virtio_net_handle_tx_bh 
>>> (vdev=0x559d703a6aa0, vq=0x7ff5f4c920a8) at ../hw/net/virtio-net.c:2801
>>>        #3  0x0000559d6dbf4791 in virtio_queue_notify_vq 
>>> (vq=0x7ff5f4c920a8) at ../hw/virtio/virtio.c:2248
>>>        #4  0x0000559d6dbf79da in virtio_queue_host_notifier_read 
>>> (n=0x7ff5f4c9211c) at ../hw/virtio/virtio.c:3525
>>>        #5  0x0000559d6d9a5814 in virtio_bus_cleanup_host_notifier 
>>> (bus=0x559d703a6a20, n=1) at ../hw/virtio/virtio-bus.c:321
>>>        #6  0x0000559d6dbf83c9 in virtio_device_stop_ioeventfd_impl 
>>> (vdev=0x559d703a6aa0) at ../hw/virtio/virtio.c:3774
>>>        #7  0x0000559d6d9a55c8 in virtio_bus_stop_ioeventfd 
>>> (bus=0x559d703a6a20) at ../hw/virtio/virtio-bus.c:259
>>>        #8  0x0000559d6d9a53e8 in virtio_bus_grab_ioeventfd 
>>> (bus=0x559d703a6a20) at ../hw/virtio/virtio-bus.c:199
>>>        #9  0x0000559d6dbf841c in virtio_device_grab_ioeventfd 
>>> (vdev=0x559d703a6aa0) at ../hw/virtio/virtio.c:3783
>>>        #10 0x0000559d6d9bde18 in vhost_dev_enable_notifiers 
>>> (hdev=0x559d707edd70, vdev=0x559d703a6aa0) at ../hw/virtio/vhost.c:1592
>>>        #11 0x0000559d6d89a0b8 in vhost_net_start_one 
>>> (net=0x559d707edd70, dev=0x559d703a6aa0) at ../hw/net/vhost_net.c:266
>>>        #12 0x0000559d6d89a6df in vhost_net_start (dev=0x559d703a6aa0, 
>>> ncs=0x559d7048d890, data_queue_pairs=31, cvq=0) at 
>>> ../hw/net/vhost_net.c:412
>>>        #13 0x0000559d6dbb5b89 in virtio_net_vhost_status 
>>> (n=0x559d703a6aa0, status=15 '\017') at ../hw/net/virtio-net.c:311
>>>        #14 0x0000559d6dbb5e34 in virtio_net_set_status 
>>> (vdev=0x559d703a6aa0, status=15 '\017') at ../hw/net/virtio-net.c:392
>>>        #15 0x0000559d6dbb60d8 in virtio_net_set_link_status 
>>> (nc=0x559d7048d890) at ../hw/net/virtio-net.c:455
>>>        #16 0x0000559d6da64863 in qmp_set_link (name=0x559d6f0b83d0 
>>> "hostnet1", up=true, errp=0x7ffdd76569f0) at ../net/net.c:1459
>>>        #17 0x0000559d6da7226e in net_vhost_user_event 
>>> (opaque=0x559d6f0b83d0, event=CHR_EVENT_OPENED) at 
>>> ../net/vhost-user.c:301
>>>        #18 0x0000559d6ddc7f63 in chr_be_event (s=0x559d6f2ffea0, 
>>> event=CHR_EVENT_OPENED) at ../chardev/char.c:62
>>>        #19 0x0000559d6ddc7fdc in qemu_chr_be_event (s=0x559d6f2ffea0, 
>>> event=CHR_EVENT_OPENED) at ../chardev/char.c:82
>>>
>>> This issue causes guest kernel stop kicking device and traffic stop.
>>>
>>> Add vhost_started check in virtio_net_handle_tx_bh to fix this wrong
>>> VRING_USED_F_NO_NOTIFY set.
>>>
>>> Signed-off-by: Yajun Wu <yajunw@nvidia.com>
>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>> ---
>>>    hw/net/virtio-net.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>> index a6ff000cd9..8035e01fdf 100644
>>> --- a/hw/net/virtio-net.c
>>> +++ b/hw/net/virtio-net.c
>>> @@ -2865,6 +2865,10 @@ static void 
>>> virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
>>>        VirtIONet *n = VIRTIO_NET(vdev);
>>>        VirtIONetQueue *q = &n->vqs[vq2q(virtio_get_queue_index(vq))];
>>>
>>> +    if (n->vhost_started) {
>> Since you mentioned "in a very rare case", maybe use unlikely()?
> Ack.

Thanks, queued squashing:

-    if (n->vhost_started) {
+    if (unlikely(n->vhost_started)) {
          return;
      }

>>
>>> +        return;
>>> +    }
>>> +
>>>        if (unlikely((n->status & VIRTIO_NET_S_LINK_UP) == 0)) {
>>>            virtio_net_drop_tx_queue_data(vdev, vq);
>>>            return;


