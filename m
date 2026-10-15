Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FA6CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHLtG-0003AI-4x; Thu, 15 Oct 2026 09:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHLtC-00039d-A8
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:52:58 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHLtA-0000t3-2V
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:52:57 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67489c8202cso1610752d50.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792072374; cv=none;
 d=google.com; s=arc-20260327;
 b=ra98ibWFpFgiRcYzsO0o3rEomHoHrRaH3rkbQxy0V9G4J916qhKnaeMdYTKm+MSD6U
 uPsSrRLXvmf//skOIRxUr1oKK8zl6e/8lwqlqER31wOEol6hzLElHpS052cVfzH8e3+F
 GyuMgXkVkSlp2TG04UXpwLY27cDXdtxLVLOyXSiga/swXoUTdVnBJwSlK8IRvxc2nOnV
 19V80gP5qUhfyEFVaS8Ce+Ox7TUowh3OD98u85NCtVGiJE8xJPz3GPVDL9ugJvc6PGPZ
 9NkhmtX3jnVIeUWmsrqeILX/juATO9BN2vH3hYkPll8p+cydHbZqszeCDxrgqt2ba68C
 d2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O7JkgtDkYtCpH/IHPCFXlR9XOjdOiZKLbNmL2c7SnNc=;
 fh=ltWIwVsWDzxKvEG7jBnlBXPrQvIjQc+HOgvPossf/dc=;
 b=WQSMZGLRv9eq3I8WKJOcq8NmW2dmLiskg3752+0hk1v5IxvHPEwLo6gRNiNkyME/Om
 hCRRll/Yrq2Nw7AeGm7ZDsHK4v36DZycnAyLPKuKPxf5tseUCdrA7NWcEqlgKpbIrdYa
 b4VgO4GhU1/QXGiiCv5D7VtuxYl+ILZkNq9lIkqKg/4L4P2k0gOGpUQTWEZpbj3gWR4w
 tT5lEq5bWzRQin5gZeWX2Www6y7fASpLn1HDAWN73R/W1DvTiTAPanXGzYhNMnMkxK/F
 QPjVMot8PxS3TFQO4fNj69hc/24MkiBWJCjvdhUpBEKYfbTMVsa+/CgTxO9PL7YSqSjN
 /YRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792072374; x=1792677174; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=O7JkgtDkYtCpH/IHPCFXlR9XOjdOiZKLbNmL2c7SnNc=;
 b=DsJavWRgw01d8Z3MYfkmClwkPe6c480IKbuPvqFfWwZ6tL02HNWi/pPa3K785jjXy2
 ezVgnX+3e5UnnvHLjshnqYpjZ8Ck399Brs2sNfQ7F2s2af0ZcayhJz+VsgAyNYLsx5Aj
 w/M/38e5FhWmqrUa2TjVrQrg+1T+vWqOlZUMd5Q4jNWB3iiEfaLsD47PkhfivZY9Y288
 v50V5feqrWGUVbxuAR3mFzQBgDLcd4ZHw593okVWq35EytgTO0hvrXDDu6mGiSm67zp9
 h2l7ZUctaN8//iFv9aES3Pdp1NFH0SHWd2VtZPAUw3SlgSUs46z7qw+LbKEH3JZoDNqy
 QnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792072374; x=1792677174;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=O7JkgtDkYtCpH/IHPCFXlR9XOjdOiZKLbNmL2c7SnNc=;
 b=Vy1X1WhKc8z17lnw4iPpc8jf+AqpOhDKd7d7eSh83fnfJOdDNq/mdthY2wpupja3O7
 2oDU0+roBOyhdEqWEsdVC7QSQkgDvObFZvY/Bsgyeih6Y1Nf43vP34Gl0OOXPKGkoeXT
 BFYOFggpi70IorEUPn8Xda6qLSpDAEekPAPr7dqmmJE8d/rXsvbgcxPCNgkfJpH0I+Iw
 MSR6p6J/Xr5vAbmqbpjdX6YpqDTuMyTOznM+dEDwSuiGRKC2z3HqFuZR2kzXLxIqWGXU
 FpuVbfKv8yZ5HE5P9xS5e/kgVEvwZYn5nl+Ne18WhdQ17lT1U4geJlYbDfhPIwpeD/4L
 FsyA==
X-Gm-Message-State: AFq9FYJMqI6Sm5kj3PEVZE9UynszbF1IRHVGXlL5rgfsj2Ai0Bk5Yjp1
 Zaik8i0DIwh50NIZj5hYP+1AvozYKtlGMTwBlL/TOYjvgck/k+HtFOTXtmnp2/V9bQxoqPK1H0J
 +OXU0gZorW0snn03SjZHn2+V52hKDK0fZhhigBOAdiA==
X-Gm-Gg: AYBFou3hxX6DjGr4gfN75Z/rsa2sgrDEmg9JepVzZ95Ib1jJjAqVY8XzHOKsYdHp+z9
 J5+Pl00LrLb1lZIZGPagmP0hVeC52gjT0DQ9lN09Q/MZVsH8O+jZGkvAdNUD1FcochsrvbDwFUe
 yQ9OG+V4wFtz95SXVrLWG09esNchQRRytrDIFtB1V518bQz/94PE3MZDUohS87JTAsvll1NneY1
 /7debReSAyyobd0nFae7sesNItiGq0wbP8zwmXJKjXxdayP7aALY/Tg6vAYC6ZLjrseAj2n4r22
 G5MbBoUfiGYgz7kaQg2z2DF77WYt2i/qgN/II2oWZHLFEDokxVM+tjm5NPPYQwzrEY7jRPN3PU3
 zjjBCNUJYeRlH4Lew/TcYr3SRPDw5f4fvjze/uVbqwjytVo0qnQ==
X-Received: by 2002:a05:690e:4148:b0:676:99af:e646 with SMTP id
 956f58d0204a3-679362b7d42mr7584407d50.54.1792072374157; Thu, 15 Oct 2026
 06:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260811143557.7862-1-marcelomanzo@gmail.com>
In-Reply-To: <20260811143557.7862-1-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 14:52:39 +0100
X-Gm-Features: AclHuK-9lECR760g3eKsTDuIlURgRpl9uyOddwPszydf1CfBzNbGOxOrHNymY48
Message-ID: <CAFEAcA9i+MgsmSMR-mn1rLPQdhOxKGSgEnsDc5=En8yrtnia_g@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] hw/arm/raspi4b: working PCIe and GENET (real
 networking)
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 11 Aug 2026 at 15:35, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> This series gets raspi4b's PCIe root complex and GENET Ethernet
> controller working end to end: the PCIe link comes up and devices on
> it actually enumerate, and GENET passes real network traffic (DHCP,
> SSH) under both older and newer guest kernels.
>

If you run "make check-functional" on a build that's been built
with the clang sanitizers, i.e.

'../../configure' '--cc=clang' '--cxx=clang++' '--enable-ubsan'
'--target-list=arm-softmmu,arm-linux-user,aarch64-softmmu,aarch64-linux-user'

then it fails because it hits a UB case due to a misaligned address:

../../hw/net/bcm2838_genet.c:878:22: runtime error: member access
within misaligned address 0x73754ab7d70f for type
'BCM2838GenetXmitStatus' (aka 'struct BCM2838GenetXmitStatus'), which
requires 4 byte alignment
0x73754ab7d70f: note: pointer points here
 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00
00 00 00 00 00 00 00  00 00 00
             ^
    #0 0x5b07158bf9d7 in bcm2838_genet_rdma
/home/pm215/qemu/build/arm-clang/../../hw/net/bcm2838_genet.c:878:22
    #1 0x5b07158bf9d7 in bcm2838_genet_receive
/home/pm215/qemu/build/arm-clang/../../hw/net/bcm2838_genet.c:949:30
    #2 0x5b07151ee119 in nc_sendv_compat
/home/pm215/qemu/build/arm-clang/../../net/net.c:823:11
    #3 0x5b07151ee119 in qemu_deliver_packet_iov
/home/pm215/qemu/build/arm-clang/../../net/net.c:870:15
    #4 0x5b07151fdf91 in qemu_net_queue_deliver_iov
/home/pm215/qemu/build/arm-clang/../../net/queue.c:179:11
    #5 0x5b07151fdf91 in qemu_net_queue_send_iov
/home/pm215/qemu/build/arm-clang/../../net/queue.c:235:11
    #6 0x5b07151ebfa3 in net_hub_receive_iov
/home/pm215/qemu/build/arm-clang/../../net/hub.c:75:9
    #7 0x5b07151ebfa3 in net_hub_port_receive_iov
/home/pm215/qemu/build/arm-clang/../../net/hub.c:126:12
    #8 0x5b07151edfe0 in qemu_deliver_packet_iov
/home/pm215/qemu/build/arm-clang/../../net/net.c:868:15
    #9 0x5b07151fc820 in qemu_net_queue_deliver
/home/pm215/qemu/build/arm-clang/../../net/queue.c:164:11
    #10 0x5b07151fc956 in qemu_net_queue_send
/home/pm215/qemu/build/arm-clang/../../net/queue.c:210:11
    #11 0x5b07151f3129 in qemu_send_packet_async_with_flags
/home/pm215/qemu/build/arm-clang/../../net/net.c:761:12
    #12 0x5b0715226901 in net_slirp_send_packet
/home/pm215/qemu/build/arm-clang/../../net/slirp.c:133:12
    #13 0x737552c98f9d  (/lib/x86_64-linux-gnu/libslirp.so.0+0x19f9d)
(BuildId: 025218e04d3a070185822fbfa2a72d2054796c61)
    #14 0x737552c86dd0  (/lib/x86_64-linux-gnu/libslirp.so.0+0x7dd0)
(BuildId: 025218e04d3a070185822fbfa2a72d2054796c61)
    #15 0x737552c8757a  (/lib/x86_64-linux-gnu/libslirp.so.0+0x857a)
(BuildId: 025218e04d3a070185822fbfa2a72d2054796c61)
    #16 0x737552c87d56  (/lib/x86_64-linux-gnu/libslirp.so.0+0x8d56)
(BuildId: 025218e04d3a070185822fbfa2a72d2054796c61)
    #17 0x737552c972ed  (/lib/x86_64-linux-gnu/libslirp.so.0+0x182ed)
(BuildId: 025218e04d3a070185822fbfa2a72d2054796c61)
    #18 0x737552c8b2ef  (/lib/x86_64-linux-gnu/libslirp.so.0+0xc2ef)
(BuildId: 025218e04d3a070185822fbfa2a72d2054796c61)
    #19 0x737552c9055e in slirp_input
(/lib/x86_64-linux-gnu/libslirp.so.0+0x1155e) (BuildId:
025218e04d3a070185822fbfa2a72d2054796c61)
    #20 0x5b0715225f3a in net_slirp_receive
/home/pm215/qemu/build/arm-clang/../../net/slirp.c:140:5
    #21 0x5b07151ee119 in nc_sendv_compat
/home/pm215/qemu/build/arm-clang/../../net/net.c:823:11
    #22 0x5b07151ee119 in qemu_deliver_packet_iov
/home/pm215/qemu/build/arm-clang/../../net/net.c:870:15
    #23 0x5b07151fdf91 in qemu_net_queue_deliver_iov
/home/pm215/qemu/build/arm-clang/../../net/queue.c:179:11
    #24 0x5b07151fdf91 in qemu_net_queue_send_iov
/home/pm215/qemu/build/arm-clang/../../net/queue.c:235:11
    #25 0x5b07151ebfa3 in net_hub_receive_iov
/home/pm215/qemu/build/arm-clang/../../net/hub.c:75:9
    #26 0x5b07151ebfa3 in net_hub_port_receive_iov
/home/pm215/qemu/build/arm-clang/../../net/hub.c:126:12
    #27 0x5b07151edfe0 in qemu_deliver_packet_iov
/home/pm215/qemu/build/arm-clang/../../net/net.c:868:15
    #28 0x5b07151fc820 in qemu_net_queue_deliver
/home/pm215/qemu/build/arm-clang/../../net/queue.c:164:11
    #29 0x5b07151fc956 in qemu_net_queue_send
/home/pm215/qemu/build/arm-clang/../../net/queue.c:210:11
    #30 0x5b07151f3129 in qemu_send_packet_async_with_flags
/home/pm215/qemu/build/arm-clang/../../net/net.c:761:12
    #31 0x5b07158bc247 in bcm2838_genet_xmit_packet
/home/pm215/qemu/build/arm-clang/../../hw/net/bcm2838_genet.c:431:5
    #32 0x5b07158bc247 in bcm2838_genet_tx
/home/pm215/qemu/build/arm-clang/../../hw/net/bcm2838_genet.c:492:13
    #33 0x5b07158bc247 in bcm2838_genet_tdma
/home/pm215/qemu/build/arm-clang/../../hw/net/bcm2838_genet.c:593:36
    #34 0x5b07158ba981 in bcm2838_genet_write
/home/pm215/qemu/build/arm-clang/../../hw/net/bcm2838_genet.c:735:13
    #35 0x5b0715dec5d6 in memory_region_write_accessor
/home/pm215/qemu/build/arm-clang/../../system/memory.c:492:5
    #36 0x5b0715debb5d in access_with_adjusted_size
/home/pm215/qemu/build/arm-clang/../../system/memory.c:568:18
    #37 0x5b0715deb622 in memory_region_dispatch_write
/home/pm215/qemu/build/arm-clang/../../system/memory.c
    #38 0x5b07151074b0 in int_st_mmio_leN
/home/pm215/qemu/build/arm-clang/../../accel/tcg/cputlb.c:2462:13
    #39 0x5b07151073ad in do_st_mmio_leN
/home/pm215/qemu/build/arm-clang/../../accel/tcg/cputlb.c:2495:12
    #40 0x5b07150f4dd6 in do_st_4
/home/pm215/qemu/build/arm-clang/../../accel/tcg/cputlb.c:2657:9
    #41 0x5b07150f4dd6 in do_st4_mmu
/home/pm215/qemu/build/arm-clang/../../accel/tcg/cputlb.c:2733:9

In bcm2838_genet_rdma(), doing this:
        BCM2838GenetXmitStatus *xmit_status = (BCM2838GenetXmitStatus *)dma_buf;

is casting an arbitrary byte pointer into the received
packet data to a struct that's a set of uint32_t fields.
This is UB for misaligned pointers, and also will do the
wrong thing on big-endian hosts.

Generally trying to operate on in-guest-memory or
in-packet-data structures with host C structs is awkward;
I usually find it's better to do explicit "load a 4 byte
little-endian word from this address" accesses with
ldl_le_p() or similar, so there's a clear distinction
between the in-memory representation and the C struct.

thanks
-- PMM

