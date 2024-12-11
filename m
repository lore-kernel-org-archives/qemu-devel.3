Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11527E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLP5q-0005nl-C9; Wed, 11 Dec 2024 10:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tLP5o-0005nb-TC
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:57:40 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tLP5n-0004Mb-08
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:57:40 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ef6af22ea8so4977960a91.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733932657; x=1734537457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=VPNhkpkiR/2sp1sMgdrZpBZFaAENwx6+ttAeb6bfzKM=;
 b=Dx9sHTpUOyRKgAX9runwGRkbXSr+MaYhjjR2jumZosqmx+m9xcYlh2MyN3kivU2Ldv
 rV8G1P6Kc/YplT3wRwlhyoJRyvH9bpO0Hur/8+Hfeur/M5zFEOxA0kNKmtJ3UnANQoIB
 y1Z+AjCAPwChpjLL1h6nZQn/l7QBJhBfwEcnkIclpmxgsmZF1WBdqHRdc/msaImkPS6A
 by+c414LgQZtSnTG8+wTMFWbWBfurucr50Pz2fEW4BuJQ8QQoYVWYtXd43GjkNG4Ryrb
 msBeWUloYIAARXJkNyfqr5UueKOIZ7mhJ+rJWO+Y1M93bQgZl/Is2DH3WqlvX3PPJJNE
 KjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932657; x=1734537457;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPNhkpkiR/2sp1sMgdrZpBZFaAENwx6+ttAeb6bfzKM=;
 b=m5Tn2gS6zqzXI35R9Xp7ibyltNsIZgZlObHOQrZTpGL41Bf/z+lZ3ZwzCYyhkk7Ty/
 B7AOnin9WVN3qvAxcfMV/Y+El1pM6dMgX7OmUjsUnZg/6b/4+0gfshHUG+Z48tTC8vHr
 1jL4lquSYIbiUhH6zhRAyp0Fcl5TPQKMHENblY+YAgOi7710r1eoqKfpX10C60qKOZap
 u3X+2QSLiyiaszNrLHZjniVNszGadWnpYi15HRr6G8MIaq7PGY4AF7HXtgGlSTPC8RLu
 q3S20zifr3NZhEpLYd9z5T6ZuhB3k0ZSKiz0aBHTftb5T0jfKUj2ir4ArGnI8SFzumWL
 ioKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJMyrjLI+YfS6PfwhnzgwmkOH2Wbn6zhCDhJW08CMzPwJc/Aa8RHC3fwe5xc4HCIdlSuMI9o5CS2zJ@nongnu.org
X-Gm-Message-State: AOJu0YxwV6w+SVckPE56yEOzRiXoRQQu87gWIGWt+IxAgYbx+Qr/trnV
 SiOw53tvZfXnAxXm03bSWpj8ivYPqO2Ts2F7qlay641IuMjDomRwgqSJrA==
X-Gm-Gg: ASbGncsPTdsvbZIm0RdnZXVmD/PenCIS8mZkfn9IRqHPaHcJtSl4+1EqFxQecFGPPYx
 sCuvylzq2P5WGDu9/DaxJhAevznAn1cczOyGjZmSXsB8wnZQB5QcMPK7085rjlktuPQuc3fmmWh
 WA/j0tf8KXkAILGRpqPZcPHAxTYWIjujV/059kKUHPoBd5tJ9q6v8zCtY+zjMEErGccvv7Cd62v
 nabKSPFxbQEXlglotNhs1bX
X-Google-Smtp-Source: AGHT+IF0SY5e/NdpHV0jEBEVwX01yqZckwH5oV0hvLdr/wj2p5HfpyMPJPmvsFr7oZj854NAFnxlRw==
X-Received: by 2002:a17:90a:de98:b0:2ee:b4d4:69 with SMTP id
 98e67ed59e1d1-2f128048ef7mr5173211a91.35.1733932656651; 
 Wed, 11 Dec 2024 07:57:36 -0800 (PST)
Received: from [192.168.1.18] ([223.233.86.194])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef67d6ea84sm11129071a91.47.2024.12.11.07.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 07:57:36 -0800 (PST)
Message-ID: <df9a9db8-550d-4635-9e0c-f6ff19842a5b@gmail.com>
Date: Wed, 11 Dec 2024 21:27:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <CAJaqyWerdWk5S0Sxt4oMUCc8FQJTxopyvhtyOV6ocbXmJ_p7Dw@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWerdWk5S0Sxt4oMUCc8FQJTxopyvhtyOV6ocbXmJ_p7Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=icegambit91@gmail.com; helo=mail-pj1-x1036.google.com
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

Hi,

Thank you for your reply.

On 12/10/24 2:57 PM, Eugenio Perez Martin wrote:
> On Thu, Dec 5, 2024 at 9:34 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>
>> Hi,
>>
>> There are two issues that I found while trying to test
>> my changes. I thought I would send the patch series
>> as well in case that helps in troubleshooting. I haven't
>> been able to find an issue in the implementation yet.
>> Maybe I am missing something.
>>
>> I have been following the "Hands on vDPA: what do you do
>> when you ain't got the hardware v2 (Part 2)" [1] blog to
>> test my changes. To boot the L1 VM, I ran:
>>
>> [...]
>>
>> But if I boot L2 with x-svq=true as shown below, I am unable
>> to ping the host machine.
>>
>> $ ./qemu/build/qemu-system-x86_64 \
>> -nographic \
>> -m 4G \
>> -enable-kvm \
>> -M q35 \
>> -drive file=//root/L2.qcow2,media=disk,if=virtio \
>> -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,x-svq=true,id=vhost-vdpa0 \
>> -device virtio-net-pci,netdev=vhost-vdpa0,disable-legacy=on,disable-modern=off,ctrl_vq=on,ctrl_rx=on,event_idx=off,bus=pcie.0,addr=0x7 \
>> -smp 4 \
>> -cpu host \
>> 2>&1 | tee vm.log
>>
>> In L2:
>>
>> # ip addr add 111.1.1.2/24 dev eth0
>> # ip addr show eth0
>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
>>      link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
>>      altname enp0s7
>>      inet 111.1.1.2/24 scope global eth0
>>         valid_lft forever preferred_lft forever
>>      inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixroute
>>         valid_lft forever preferred_lft forever
>>
>> # ip route
>> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
>>
>> # ping 111.1.1.1 -w10
>> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
>>  From 111.1.1.2 icmp_seq=1 Destination Host Unreachable
>> ping: sendmsg: No route to host
>>  From 111.1.1.2 icmp_seq=2 Destination Host Unreachable
>>  From 111.1.1.2 icmp_seq=3 Destination Host Unreachable
>>
>> --- 111.1.1.1 ping statistics ---
>> 3 packets transmitted, 0 received, +3 errors, 100% packet loss, time 2076ms
>> pipe 3
>>
>> The other issue is related to booting L2 with "x-svq=true"
>> and "packed=on".
>>
>> In L1:
>>
>> $ ./qemu/build/qemu-system-x86_64 \
>> -nographic \
>> -m 4G \
>> -enable-kvm \
>> -M q35 \
>> -drive file=//root/L2.qcow2,media=disk,if=virtio \
>> -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,x-svq=true \
>> -device virtio-net-pci,netdev=vhost-vdpa0,disable-legacy=on,disable-modern=off,guest_uso4=off,guest_uso6=off,host_uso=off,guest_announce=off,ctrl_vq=on,ctrl_rx=on,event_idx=off,packed=on,bus=pcie.0,addr=0x7 \
>> -smp 4 \
>> -cpu host \
>> 2>&1 | tee vm.log
>>
>> The kernel throws "virtio_net virtio1: output.0:id 0 is not
>> a head!" [4].
>>
> 
> So this series implements the descriptor forwarding from the guest to
> the device in packed vq. We also need to forward the descriptors from
> the device to the guest. The device writes them in the SVQ ring.
> 
> The functions responsible for that in QEMU are
> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_flush, which is called by
> the device when used descriptors are written to the SVQ, which calls
> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf. We need to do
> modifications similar to vhost_svq_add: Make them conditional if we're
> in split or packed vq, and "copy" the code from Linux's
> drivers/virtio/virtio_ring.c:virtqueue_get_buf.
> 
> After these modifications you should be able to ping and forward
> traffic. As always, It is totally ok if it needs more than one
> iteration, and feel free to ask any question you have :).
> 

Understood, I'll make these changes and will test it again.

Thanks,
Sahil

