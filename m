Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549DDECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snxG4-0005cR-Hh; Tue, 10 Sep 2024 05:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1snxG0-0005Kp-4t
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:33:56 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1snxFy-0006ue-BY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:33:55 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a045f08fd6so196905ab.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 02:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725960833; x=1726565633; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTqwHGeLSKdT4AQKVSwAUIjKKRKj/H92pErbzy7e+tI=;
 b=MdjsPnPJjwQ3yEgFILIJNhklpr4zGiWQhzDYB0jRKlUp5byw3xMgZk2S4Y0aiMFvEe
 s7mNWg1+K9Ubz+X/xwCz7zcg2CzS13TtQffrWiGdiL/sI5kMtoJ3pQOjGSJHwDEb/GRq
 4hxqID8eIYBk+S848l/rdp5djPZRVCqo/5ZcqBXFY67ze4ZsKnk5gwdWUJugs0hbwGwf
 /9dGpLiiwwBQb05Y6iOQeCl0AoBCWOggPS84wecPUFCRnzx1sk2c9/TRM+HzcxQAqtUn
 o3WPm838jy/nhI1n8H++neXG5UaDPQH5WDNla3gzO7qush47CqXFG11VBcPzzeMsbPRy
 7GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960833; x=1726565633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QTqwHGeLSKdT4AQKVSwAUIjKKRKj/H92pErbzy7e+tI=;
 b=HsbPHZxc+Y2MBhyyDRuW0lPwKbLLVMxKUPhDXi1Ck6leVD7aoH3eIZ+tabJALqA2yy
 J/pW6Kk1eVYe0kZj3x7wK9MkcnVzMVj3vPH5tXzd42HQri5kv9e6vG28IectXSD/Kcb/
 VxcoXuRA5lxWCwiVvPQXIUJt4YwyZzzPDxT/RBmbG3tGQSZUdrnNaexL5vQGiB2a3eU3
 Q/pRMkInqCMZItZ7WrzU4QuNKo7LHdfO7+TZBU4UozjLWRIrSksk9v/pI89OafDLZcZm
 q9wkVULYGO9YsOQvM6IRn2IMH6dtMRwP63/Z+YYwMfV8f6o71vsuvFoXzfprJpnJkiqF
 k38Q==
X-Gm-Message-State: AOJu0YytAY5CH/RGuFgK2Q4XMooITlpwfh9mllZSaAg6OTGbkRv68vAL
 uoUHlkbIz8sMN0Q3gZIQOkhcF1YZv1/U+ZgyukNr2l0sEpiHLm/HboF8JEsyk0pm1L1Tdx3E//n
 jv30F2QM7vtRHMOG5qr8vAI6y4G+nJV1XgyPp
X-Google-Smtp-Source: AGHT+IFhJHidmbYiKwfEQ+mIMPcQOEacVxi2ut9F5+p/MXsUxEH/+FWyyR7jtNUkafV6T8gN+5mro9F7m/6xJEnH6yA=
X-Received: by 2002:a05:6e02:1886:b0:375:cd0d:9342 with SMTP id
 e9e14a558f8ab-3a06ca33543mr2352925ab.3.1725960832857; Tue, 10 Sep 2024
 02:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <447984db-8c52-c911-d7bd-6616edaaefa5@hisilicon.com>
 <CAFgf54oTQqTJKxqD5U2i+jrTqHQQS=0zSkYiJjoWs5MOmaz5gg@mail.gmail.com>
 <51b1ed21-e10e-8a7c-10ce-7be2f0c3b89f@hisilicon.com>
In-Reply-To: <51b1ed21-e10e-8a7c-10ce-7be2f0c3b89f@hisilicon.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 10 Sep 2024 10:33:41 +0100
Message-ID: <CAFgf54pzDerdXdfj_Dhowqfn35oPsvUBbzL9Sq3iS7HwkyscBA@mail.gmail.com>
Subject: Re: [Bug Report] smmuv3 event 0x10 report when running virtio-blk-pci
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=smostafa@google.com; helo=mail-il1-x131.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, Sep 10, 2024 at 2:51=E2=80=AFAM Zhou Wang <wangzhou1@hisilicon.com>=
 wrote:
>
> On 2024/9/9 22:47, Mostafa Saleh wrote:
> > Hi Zhou,
> >
> > On Mon, Sep 9, 2024 at 3:22=E2=80=AFPM Zhou Wang via <qemu-devel@nongnu=
.org> wrote:
> >>
> >> Hi All,
> >>
> >> When I tested mainline qemu(commit 7b87a25f49), it reports smmuv3 even=
t 0x10
> >> during kernel booting up.
> >>
> >> qemu command which I use is as below:
> >>
> >> qemu-system-aarch64 -machine virt,kernel_irqchip=3Don,gic-version=3D3,=
iommu=3Dsmmuv3 \
> >> -kernel Image -initrd minifs.cpio.gz \
> >> -enable-kvm -net none -nographic -m 3G -smp 6 -cpu host \
> >> -append 'rdinit=3Dinit console=3DttyAMA0 ealycon=3Dpl0ll,0x90000000 ma=
xcpus=3D3' \
> >> -device pcie-root-port,port=3D0x8,chassis=3D0,id=3Dpci.0,bus=3Dpcie.0,=
multifunction=3Don,addr=3D0x2 \
> >> -device pcie-root-port,port=3D0x9,chassis=3D1,id=3Dpci.1,bus=3Dpcie.0,=
addr=3D0x2.0x1 \
> >> -device virtio-blk-pci,drive=3Ddrive0,id=3Dvirtblk0,num-queues=3D8,pac=
ked=3Don,bus=3Dpci.1 \
> >> -drive file=3D/home/boot.img,if=3Dnone,id=3Ddrive0,format=3Draw
> >>
> >> smmuv3 event 0x10 log:
> >> [...]
> >> [    1.962656] virtio-pci 0000:02:00.0: Adding to iommu group 0
> >> [    1.963150] virtio-pci 0000:02:00.0: enabling device (0000 -> 0002)
> >> [    1.964707] virtio_blk virtio0: 6/0/0 default/read/poll queues
> >> [    1.965759] virtio_blk virtio0: [vda] 2097152 512-byte logical bloc=
ks (1.07 GB/1.00 GiB)
> >> [    1.966934] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
> >> [    1.967442] input: gpio-keys as /devices/platform/gpio-keys/input/i=
nput0
> >> [    1.967478] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
> >> [    1.968381] clk: Disabling unused clocks
> >> [    1.968677] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
> >> [    1.968990] PM: genpd: Disabling unused power domains
> >> [    1.969424] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
> >> [    1.969814] ALSA device list:
> >> [    1.970240] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
> >> [    1.970471]   No soundcards found.
> >> [    1.970902] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
> >> [    1.971600] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
> >> [    1.971601] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
> >> [    1.971601] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
> >> [    1.971602] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
> >> [    1.971606] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
> >> [    1.971607] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
> >> [    1.974202] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
> >> [    1.974634] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
> >> [    1.975005] Freeing unused kernel memory: 10112K
> >> [    1.975062] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
> >> [    1.975442] Run init as init process
> >>
> >> Another information is that if "maxcpus=3D3" is removed from the kerne=
l command line,
> >> it will be OK.
> >>
> >
> > That's interesting, not sure how that would be related.
> >
> >> I am not sure if there is a bug about vsmmu. It will be very appreciat=
ed if anyone
> >> know this issue or can take a look at it.
> >>
> >
> > Can you please provide logs with adding "-d trace:smmu*" to qemu invoca=
tion.
>
> Sure. Please see the attached log(using above qemu commit and command).
>

Thanks a lot, it seems the SMMUv3 indeed receives a translation
request with addr 0x0 which causes this event.
I don't see any kind of modification (alignment) of the address in this pat=
h.
So my hunch it's not related to the SMMUv3 and the initiator is
issuing bogus addresses.

> >
> > Also if possible, can you please provide which Linux kernel version
> > you are using, I will see if I can repro.
>
> I just use the latest mainline kernel(commit b831f83e40a2) with defconfig=
.
>

I see, I can't repro in my setup which has no "--enable-kvm" and with
"-cpu max" instead of host.
I will try other options and see if I can repro.

Thanks,
Mostafa
> Thanks,
> Zhou
>
> >
> > Thanks,
> > Mostafa
> >
> >> Thanks,
> >> Zhou
> >>
> >>
> >>
> >
> > .

