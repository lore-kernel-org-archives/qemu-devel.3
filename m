Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6C4C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk015-0002V7-Lq; Tue, 12 Mar 2024 07:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rk013-0002Uq-BP
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:09:53 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rk00z-00068j-Qx
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:09:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-413328344acso4774625e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710241788; x=1710846588; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PqiaaurzWNdfKOWSZkIN5iavG9IXyQNAktGYPfEgC/Q=;
 b=McKLY0fU1Cnx9+Cxto1X1RTSN/ZXr4vmfSmRJzQoNE8hHkzJiSJCbl93g/FLcwMC/U
 nLwTNaKVckvlUgbeVTKGgLYST23JzYgwtr1fVQu6t8GnOscqGRSSfBIW0TBsUypEH8jx
 yFBlpaZuSlEVexeb0vNGmgu63mZioHEN//WMhgJOVIK7w/7Up1imtlHijWHaAyGmu9QG
 8PJVUrD9yO71yVcWAAcMcMxgPKt4FtwmCKhzuLUr36y+H45M5cxSM1VqjkR/oFyyXOnC
 xVtPzomffVdbmTC8HId/0EUjOPunZJmjqOWSbAyCP//ueFXVUUTkpVpdcKI1by1AF8+9
 7DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710241788; x=1710846588;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PqiaaurzWNdfKOWSZkIN5iavG9IXyQNAktGYPfEgC/Q=;
 b=S4xLvcqZOE+OMeE/kaiRoYZ0H4ST/86N32lzyGy0+8qN73HbCoDssTjDdUpToaAsgK
 rpHyK32BWAD8bUMmGMJEWiYcxBiH0UzhwdvAm4IyemUCyMLesle9ix105OZBTouNbmvx
 O3wbOoqh4XUuCuDa8s3eMVwWmNsKVQs/a1bY4vrW8V/MtH5+6/9PsyTa+4UJjwmsML70
 Wi28qjwX49bZ2EHymRpl2mNn5yjqK66YUxwfXbUpOCe3lxFakX7xKr0qs7vH7lMSo3xE
 zPItrIalCOS1Xee0A6uj/4McdWNh9Hmnh3J9qnXIakopE2YyKg94g1JJRA1YBiPjKy+P
 86Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbAp1ktB1CjRONUuKvf27oTHeqTzUM3seoUi+ZQYpE7qjj2V+jROsI2VKHueUUFrhvyMqv62n/zZf3kcJ8+tJQiW7lPIY=
X-Gm-Message-State: AOJu0YzrRIBdq7B5orJYEiWL3hQIuFNweSpiQOgdgPV7YpTzf3Rqjx0U
 w4C5GPLQOEp08A7lWR4JJbsY28j2HkXKS8ibCVRPEYbso5EHLTi6WOVQS6fZ+WM=
X-Google-Smtp-Source: AGHT+IHPr4ZLvTxDo9A3jom7PS7mM0ZFunDgHHvFvHmfxd+mUDYPq5u5fOL/PNczDIfRVoxvkK/KXA==
X-Received: by 2002:a05:600c:3149:b0:413:19ac:2a06 with SMTP id
 h9-20020a05600c314900b0041319ac2a06mr6608050wmo.28.1710241788128; 
 Tue, 12 Mar 2024 04:09:48 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 bi6-20020a05600c3d8600b004133802cf8csm1713932wmb.38.2024.03.12.04.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 04:09:47 -0700 (PDT)
Date: Tue, 12 Mar 2024 12:09:46 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Richard Bagley <rbagley@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 bmeng@tinylab.org, 
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com
Subject: Re: [PATCH] disas/riscv: Further correction to LUI disassembly
Message-ID: <20240312-ed806a55958fd3526ec0f01a@orel>
References: <20230810-c9e1f2783168b48bc07a1aa2@orel>
 <mhng-a6344a0c-8820-41b5-a015-b82b261b463d@palmer-ri-x1c9>
 <20230810-e160f9edae60ded9d2606b8b@orel>
 <20230811-bc15b48d336b79d9ec1f0936@orel>
 <20230811-52e2c90dc3b91e108eb5e4e8@orel>
 <CAARkPA-P1U7xyLpdx+XD1M3Ji2NUfTb+88+GKUk8R2aFsOCMRw@mail.gmail.com>
 <CAARkPA-dOxOWsR0VS+S8p4fDmNR5X5Jjmo5pQTaurWLYsc9vsw@mail.gmail.com>
 <20240309-ee813e971e7c5850d652b295@orel>
 <CAARkPA_8zSZK-4oOTcJO2KinWSadxZYZztwRP-UvNNkDjmyexw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAARkPA_8zSZK-4oOTcJO2KinWSadxZYZztwRP-UvNNkDjmyexw@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Mar 11, 2024 at 11:56:42AM -0700, Richard Bagley wrote:
> I have realized that *the patch is indeed a fix*, not a workaround.
> 
> In fact, the argument to LUI and AUIPC in assembly *must* be a number
> between [0x0, 0xfffff].
> RISC-V Assembly Programmer's Manual : Load Upper Immediate's Immediate
> <https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv-asm.md#load-upper-immediates-immediate>

I think that's just documenting the current behavior, but the behavior
(not accepting a signed decimal number for a signed immediate) doesn't
appear to be justified, so I think my suggestion in [1] still stands.
That said, I don't really have much of a horse in this race so if
somebody comes along and closes that BZ with a simple justification of
"we, the people that work on this stuff, agreed we prefer the range
[0x0, 0xfffff]", then I won't argue.

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=30746

Thanks,
drew

> Signed decimal numbers are programmed as their two's complement.
> 
> I checked: neither GCC nor LLVM will assemble
> 
> > lui x1, -4
> 
> The LLVM compiled models the arguments to LUI and AUIPC as UIMM (unsigned
> immediate) or UIMM20 (20 bit unsigned immediate).
> 
> I should have checked this from the start. I jumped to the conclusion that
> both formats (signed decimal, two's complement) for negative arguments
> should be supported, and that I was encountering a bug.
> I apologize to all for the unnecessary back-and-forth.
> 
> I don't yet see a reason why llvm and gcc could not support a signed number
> in decimal format, perhaps requiring a pseudo-instruction.
> This might be desirable, if only in support of assembly programming.
> On the other hand, it is easy to make the conversion to a two's-complement
> number.
> 
> Richard
> 
> On Sat, Mar 9, 2024 at 4:01 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> 
> > On Fri, Mar 08, 2024 at 08:22:01PM -0800, Richard Bagley wrote:
> > > post-nack, one further comment:
> > >
> > > One could argue that this change also aligns QEMU with supporting tools
> > (as
> > > Andrew observed), and it makes sense to merge this change into QEMU until
> > > those tools update to supporting signed decimal numbers with immediates.
> > >
> > > As it is, both GNU assembler and the LLVM integrated assembler (or
> > llvm-mc)
> > > throws an error with examples such as
> > > auipc s0, -17
> > >
> > > On the other hand, I have only seen this problem with the output of the
> > > COLLECT plug-in, not (as yet) with QEMU execution proper.
> > > If the problem is confined to COLLECT, perhaps the argument for aligning
> > > with other tools is not as strong.
> > >
> > > In the meantime, I have adjusted my change locally to include AUIPC, and
> > > written a substantive, and I hope, clear commit description.
> > > If you would like me to resubmit a patch with this updated change, please
> > > let me know.
> >
> > Since the patch is ready for posting, then it might as well be posted
> > (even if it may not get merged right away). If the issue arises again,
> > then we can refer to the latest proposed patch, which will be preserved
> > in the mail archives.
> >
> > Thanks,
> > drew
> >

