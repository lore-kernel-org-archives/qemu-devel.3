Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDAAE68954
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 05:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6NSX-0004ca-1e; Thu, 31 Oct 2024 01:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1t6NSW-0004cR-0k
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 01:11:00 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1t6NSU-0002lj-BF
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 01:10:59 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ee386ce3dfso806373a12.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 22:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730351456; x=1730956256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=x4HG1x8r4h0e5971hMn4C+eMuxXCwPoNmCQPqLA1DmI=;
 b=Dho9Eu5uaE0Wfc0gsldwVOakjUYdpU7px9KqmdcFX79b3YrsMsuUj5QrbXyLky55En
 h/ildeBkXH1lLXgT80kh6xE3lvuNnLSW6TtEy0FtaZyy+W9G/lKFdv7aNjMptFGagOQ3
 1EWHMi8D6CSDh/vYIGsCYUMRINyt1sWzUNPO4wwBleDqbXgZWYuOCS+Yr6LiOE5io687
 W+LJNMYWtOAbUnjHkAjVjhlwup+rGYpoJduGrrzTFuZQrNAcZeeyvEXIAGXQOQJH4r2P
 6TNVerTPJKES3ywuWCvPEe3SaHwNSWFNqc4QLUZqhgmZf6u0Kyk2gMo7zAxgjsshp0NC
 N6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730351456; x=1730956256;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4HG1x8r4h0e5971hMn4C+eMuxXCwPoNmCQPqLA1DmI=;
 b=jPjW2N5gsENiBkN7Okiu2G1DddV0FdvuN/vxBGTkcqd3z4bKBR6XHiMl/owtVlRYkX
 I+IN4/FRCIppXy13Mb3fqz8gJIg5SfINigbGIiyW7O8lMu6mYEO4jHNDWVcq7xKarcvb
 f3ewMpvWiWqf7YQ25XAwbcaUsVdBv7/7Z0U8TUPlXI1Re1Lk0GfzyQ5DUArWEdtHuHgp
 Xl3DL++9b8rdRSUBBx/L9FLveyrdz6HWWwHAfTnBNn3h5teqLE8gEpKbMni+fF4o1FDQ
 4iqZVQt2M73MBuS7Dd4O1lcB+jvOyPoz9X4aLPSXcLXcgunEm1V0lab4Ap4tLkF4O1nD
 Il6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZTq/SCay9sAllXpvbqyLjHCt4ouzhLYnJx353Rw0dgcX/bqq0ESI/ADfxMNLBA5ZCcItpXH31WUwI@nongnu.org
X-Gm-Message-State: AOJu0YxvWY1XCpuqNzv/V+UtZdS8zHYc+k9nyIE2qIBgT0R8nqBWfzHh
 Xq5WnRTw0gBc1BmD8NNdVAfYSWjOMOdkPRCsoIu6U9IY1zTpNBFi
X-Google-Smtp-Source: AGHT+IEI/SVDJ8bozFKyFKj+WjxLE4bq/4BpiDybfdu9YURYIHRoYdmokMcCErskOEh/ac9W9bmrzA==
X-Received: by 2002:a05:6a20:729e:b0:1cf:2a19:b1b with SMTP id
 adf61e73a8af0-1db94f59cb1mr1427859637.7.1730351456184; 
 Wed, 30 Oct 2024 22:10:56 -0700 (PDT)
Received: from [192.168.1.8] ([223.233.80.179])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee459f927dsm420419a12.75.2024.10.30.22.10.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 22:10:55 -0700 (PDT)
Message-ID: <1c0afdb8-dd82-4caf-b0de-2953786825e0@gmail.com>
Date: Thu, 31 Oct 2024 10:40:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <3311761.aeNJFYEL58@valdaarhun>
 <CAJaqyWeus1zqEqE4ZzoGOzrY=w=_vEMdPGoHrv+Gxvc6zhiNmw@mail.gmail.com>
 <1904291.tdWV9SEqCh@valdaarhun>
 <CAFcRUGb-Nh0E0tKJkKiw7X2E+wOcA6yavRBe7Ly9WKeTK46ENA@mail.gmail.com>
 <CAJaqyWePYh43fTmVSFxUS8VYijZUAg1U5mM3WhXi9fQPDG6GWw@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWePYh43fTmVSFxUS8VYijZUAg1U5mM3WhXi9fQPDG6GWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=icegambit91@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/28/24 1:40 PM, Eugenio Perez Martin wrote:
> On Mon, Oct 28, 2024 at 6:38 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>> [...]
>> I spent some time tinkering with the L0-L1-L2 test environment setup,
>> and understanding QEMU's hw/virtio/vhost-vdpa.c [1] as well as Linux's
>> drivers/vhost/vdpa.c [2] and /drivers/vhost/vhost.c [3]. I don't think there
>> is an issue with the environment itself.
>>
>> When I boot L2 with the following combinations of "x-svq" and
>> "packed", this is what I observe:
>>
>> 1. x-svq=on and packed=off
>>
>> The virtio device in L2 has the packed feature bit turned off. Vhost
>> shadow virtqueues are used as expected.
>>
>> 2. x-svq=off and packed=on
>>
>> The virtio device in L2 has the packed feature bit turned on. Vhost
>> shadow virtqueues are not used.
>>
>> I don't see any issues in either of the above environment
>> configurations.
>>
>> 3. x-svq=on and packed=on
>>
>> This is the configuration that I need for testing. The virtio device in
>> L2 has the packed feature bit turned on. However, vhost shadow
>> virtqueues are not being used. This is due to the
>> VHOST_SET_VRING_BASE ioctl call returning a EOPNOTSUPP in
>> hw/virtio/vhost-vdpa.c:vhost_vdpa_set_dev_vring_base() [4].
>>
>> I spent some time going through the ioctl's implementation in Linux.
>> I used ftrace to trace the functions that were being called in the kernel.
>> With x-svq=on (regardless of whether split virtqueues are used or packed
>> virtqueues), I got the following trace:
>>
>> [...]
>>   qemu-system-x86-1737    [001] ...1.  3613.371358:
>> vhost_vdpa_unlocked_ioctl <-__x64_sys_ioctl
>>   qemu-system-x86-1737    [001] ...1.  3613.371358: vhost_vring_ioctl
>> <-vhost_vdpa_unlocked_ioctl
>>   qemu-system-x86-1737    [001] ...1.  3613.371362:
>> vp_vdpa_set_vq_state <-vhost_vdpa_unlocked_ioctl
>> [...]
>>
>> There are 3 virtqueues that the vdpa device offers in L1. There were no
>> issues when using split virtqueues and the trace shown above appears
>> 3 times. With packed virtqueues, the first call to VHOST_SET_VRING_BASE
>> fails because drivers/vdpa/virtio_pci/vp_vdpa.c:vp_vdpa_set_vq_state_packed
>> [5] returns EOPNOTSUPP.
>>
>> The payload that VHOST_SET_VRING_BASE accepts depends on whether
>> split virtqueues or packed virtqueues are used [6].  In hw/virtio/vhost-
>> vdpa.c:vhost_vdpa_svq_setup() [7], the following payload is used which is
>> not suitable for packed virtqueues:
>>
>> struct vhost_vring_state s = {
>>          .index = vq_index,
>> };
>>
>> Based on the implementation in the linux kernel, the payload needs to
>> be as shown below for the ioctl to succeed for packed virtqueues:
>>
>> struct vhost_vring_state s = {
>>          .index = vq_index,
>>          .num = 0x80008000,
>> };
>>
> 
> Wow, that's a great analysis, very good catch!
> 
> [...]
>> I'll send an update once I resolve this issue. I'll also send a patch that
>> crafts the payload correctly based on the format of the virtqueue in
>> vhost_vdpa_svq_setup().
>>
> 
> The QEMU's vhost_vdpa_svq_setup is a valid patch so if you have the
> bandwith please send it ASAP and we move it forward :).
> 

Sure thing. I'll do that while debugging the kernel in parallel.

Thanks,
Sahil


