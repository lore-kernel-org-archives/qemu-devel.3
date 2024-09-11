Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D7DEE021C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 09:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soJUK-00076d-S4; Wed, 11 Sep 2024 05:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1soJUD-00075z-Q1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1soJUB-00040n-6t
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726046281;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AVikt7nrco0lbDUD5+4EjEvG23ay5iaE/J1nZ9N0p5M=;
 b=LGvRfX+O7iaH6XtbsOqDQ6DZ4knlApA5l7ZJw2zhO9h2JyCHUR/u4GtgQRZAUdxdrLDaML
 L8MvIKTk7XPAAS+wIDJ1Yal3/s5QZ7S89eWoNIcU9TvbFycoZhzpO0HsspV1TxzFb7NFLd
 +W+gAOqPHzBj0r8B2EC1mXgGPo1I+4Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-DL4tHTD4OTKlZeoakf5B4A-1; Wed, 11 Sep 2024 05:18:00 -0400
X-MC-Unique: DL4tHTD4OTKlZeoakf5B4A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-374b981dd62so917584f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 02:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726046279; x=1726651079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AVikt7nrco0lbDUD5+4EjEvG23ay5iaE/J1nZ9N0p5M=;
 b=txyGZBuiU9qYQrHEv13VkeQWrgt1dbmq4KbK5ya1IKeBj1Wdl0/LSZT71v40Mc07hG
 lPlI8edGV/FyNhZ2i8p1ezjuMpUWVJCDAycR3lB2D+P2gdKa7SkG+bdoq/xh3X8KY2IZ
 ysAKHqz41Ay2AEu50Gs4eAcl1Xh+Q/qL00ILNafzUhx34uiT01aABXmFi+2FxXg1KJ+L
 Hjc5smo47nMLlJ6VGB27IDpYwaT2fQ31LxRpxr8BPZ3YKyCM5u4c8Ioj+3ZtKk60Knr0
 Vk23o/7ctgFeRk46z1KYngWltrAW/PLTcNFfkF6p6bjrUTnqgG60ssEUA33IHaXuWKFg
 PTdQ==
X-Gm-Message-State: AOJu0YyIU+I5Q+bSQBYBhatS+3RRmKrA+6dPg5huXvE0BWtIeHaDndNH
 kvBk99WxbsjKKVbk4zMR5XilOhCCofSlk7YFbnkne3Bh4y/YqD48YwNdMl/Q8OrCz+fFETrLeVO
 V7sieCSKi21LJ8I8TzrAA5vLHNQ5j5edz+2Pdcyqz5Rmlrp5nTXrA
X-Received: by 2002:adf:e502:0:b0:371:6fba:d555 with SMTP id
 ffacd0b85a97d-378b07a4f81mr1392027f8f.18.1726046278655; 
 Wed, 11 Sep 2024 02:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb7YbuqPEzOsAlWTWPE4VW2sG+P4asOsIGyneF8liBpbwW5lllCm+bNrHu1Et3OAzAiwSzjw==
X-Received: by 2002:adf:e502:0:b0:371:6fba:d555 with SMTP id
 ffacd0b85a97d-378b07a4f81mr1392004f8f.18.1726046278096; 
 Wed, 11 Sep 2024 02:17:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956de00fsm11008755f8f.99.2024.09.11.02.17.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 02:17:57 -0700 (PDT)
Message-ID: <4b53b635-7ed7-478b-9b53-d27833c03613@redhat.com>
Date: Wed, 11 Sep 2024 11:17:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] smmuv3 event 0x10 report when running virtio-blk-pci
Content-Language: en-US
To: Zhou Wang <wangzhou1@hisilicon.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Mostafa Saleh <smostafa@google.com>
References: <447984db-8c52-c911-d7bd-6616edaaefa5@hisilicon.com>
 <CAFEAcA-qBKn=42SYwU1X_7QrwWZYA1G1Hbf-iUP4GOFu0LwLzw@mail.gmail.com>
 <cbd29bc4-c5ab-22d7-8a3e-fd7646f16fd5@hisilicon.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <cbd29bc4-c5ab-22d7-8a3e-fd7646f16fd5@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 9/10/24 03:24, Zhou Wang via wrote:
> On 2024/9/9 22:31, Peter Maydell wrote:
>> On Mon, 9 Sept 2024 at 15:22, Zhou Wang via <qemu-devel@nongnu.org> wrote:
>>> Hi All,
>>>
>>> When I tested mainline qemu(commit 7b87a25f49), it reports smmuv3 event 0x10
>>> during kernel booting up.
>> Does it still do this if you either:
>>  (1) use the v9.1.0 release (commit fd1952d814da)
>>  (2) use "-machine virt-9.1" instead of "-machine virt"
> I tested above two cases, the problem is still there.

I have not much progressed yet but I see it comes with
qemu traces.

smmuv3-iommu-memory-region-0-0 translation failed for iova=0x0
(SMMU_EVT_F_TRANSLATION)
../..
qemu-system-aarch64: virtio-blk failed to set guest notifier (-22),
ensure -accel kvm is set.
qemu-system-aarch64: virtio_bus_start_ioeventfd: failed. Fallback to
userspace (slower).

the PCIe Host bridge seems to cause that translation failure at iova=0

Also virtio-iommu has the same issue:
qemu-system-aarch64: virtio_iommu_translate no mapping for 0x0 for sid=1024
qemu-system-aarch64: virtio-blk failed to set guest notifier (-22),
ensure -accel kvm is set.
qemu-system-aarch64: virtio_bus_start_ioeventfd: failed. Fallback to
userspace (slower).

Only happens with maxcpus=3. Note the virtio-blk-pci is not protected by
the vIOMMU in your case.

Thanks

Eric

>
>> ?
>>
>> My suspicion is that this will have started happening now that
>> we expose an SMMU with two-stage translation support to the guest
>> in the "virt" machine type (which we do not if you either
>> use virt-9.1 or in the v9.1.0 release).
>>
>> I've cc'd Eric (smmuv3 maintainer) and Mostafa (author of
>> the two-stage support).
>>
>>> qemu command which I use is as below:
>>>
>>> qemu-system-aarch64 -machine virt,kernel_irqchip=on,gic-version=3,iommu=smmuv3 \
>>> -kernel Image -initrd minifs.cpio.gz \
>>> -enable-kvm -net none -nographic -m 3G -smp 6 -cpu host \
>>> -append 'rdinit=init console=ttyAMA0 ealycon=pl0ll,0x90000000 maxcpus=3' \
>>> -device pcie-root-port,port=0x8,chassis=0,id=pci.0,bus=pcie.0,multifunction=on,addr=0x2 \
>>> -device pcie-root-port,port=0x9,chassis=1,id=pci.1,bus=pcie.0,addr=0x2.0x1 \
>>> -device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=8,packed=on,bus=pci.1 \
>>> -drive file=/home/boot.img,if=none,id=drive0,format=raw
>>>
>>> smmuv3 event 0x10 log:
>>> [...]
>>> [    1.962656] virtio-pci 0000:02:00.0: Adding to iommu group 0
>>> [    1.963150] virtio-pci 0000:02:00.0: enabling device (0000 -> 0002)
>>> [    1.964707] virtio_blk virtio0: 6/0/0 default/read/poll queues
>>> [    1.965759] virtio_blk virtio0: [vda] 2097152 512-byte logical blocks (1.07 GB/1.00 GiB)
>>> [    1.966934] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
>>> [    1.967442] input: gpio-keys as /devices/platform/gpio-keys/input/input0
>>> [    1.967478] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
>>> [    1.968381] clk: Disabling unused clocks
>>> [    1.968677] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
>>> [    1.968990] PM: genpd: Disabling unused power domains
>>> [    1.969424] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
>>> [    1.969814] ALSA device list:
>>> [    1.970240] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
>>> [    1.970471]   No soundcards found.
>>> [    1.970902] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
>>> [    1.971600] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
>>> [    1.971601] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
>>> [    1.971601] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
>>> [    1.971602] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
>>> [    1.971606] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
>>> [    1.971607] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
>>> [    1.974202] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
>>> [    1.974634] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
>>> [    1.975005] Freeing unused kernel memory: 10112K
>>> [    1.975062] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
>>> [    1.975442] Run init as init process
>>>
>>> Another information is that if "maxcpus=3" is removed from the kernel command line,
>>> it will be OK.
>>>
>>> I am not sure if there is a bug about vsmmu. It will be very appreciated if anyone
>>> know this issue or can take a look at it.
>> thanks
>> -- PMM
>> .


