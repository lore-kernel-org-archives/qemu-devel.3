Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B468DD1BDD6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t81JT-0006LK-R3; Mon, 04 Nov 2024 12:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1t81JS-0006KE-7l
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:56:26 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1t81JP-0003Ny-UV
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:56:25 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso27649205e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730742982; x=1731347782; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5Q28DmraI+jzDtv8C7tOYAauG+tremlv6mKhOGBoszU=;
 b=IyOLe2Nuo+CpiDvYCt7rdnzMCwdAxHJKgCEb49bSngKbzggpsOyC0Rh4n2w+5ySBWU
 C8UxITqTZb1trLBqA+DrNcv7x7IT0umgOhOGTgKdK3tDpBSW7eTmbOxQ8yBJ0WxnzTHJ
 QX7ORPVN/PmniGOOzPLt764jg+vr0j+4M0KFlL730n8FJUXVKXgkOgmMJsktP2zwGsbU
 S2R8XS+Wn1DpNEPPYt2Z22RdYVeo9MWzCspgEmBrAe5cpZzcCDEW5HX2M8ia9JZBB7rb
 slkV+sVZbO85GQNva5fcE8r7WjJ1JfZfPl4zpWOyoZNL94zx+DKi3rfv98OWXZY6ipp1
 kNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742982; x=1731347782;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Q28DmraI+jzDtv8C7tOYAauG+tremlv6mKhOGBoszU=;
 b=pCDdTkh4OE8wW6L4n+VJLybulOTJJsqxJsf75zXjWWW7YlzhwcSRZLA+ACM9yCKQak
 IMZ/ZJ9+rjeis4DHo/SfCWiicYivUGIfwROnQ1MgdW2VZL6D22wl6BE7g3+QZfGxNWCk
 9emg/taKI3BkNbkiJ+7H/n0PKUotSpz5Ty+PyrfRM/gA9h63CZ4kIydD7IQDJf9flV2s
 iTQt4Th1GB3VRvZsZiT2EtGYMTngj5Je6xCqURNA44+DywfcyRzwKjt+2ZmhTthiYH9k
 rwLu78irF09oQ8jV7GIGuW0zasD76E7HJ99NJDbRDIwvMrXkmFZjQCtKEpfyJ3c5PsOM
 Kttg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCV6onAsgnMYAVgN/X5AkXCZU9Rk1CNpttk1PhQXj7dfB9q+BfpB0FtoD483FtzqVdDi9ipw7hzx0S@nongnu.org
X-Gm-Message-State: AOJu0Yxi96r1jpydp8eXNX0y23tF9TnwiAsw69EtT09eGad812W0GmiK
 2BrdP4ZLT8p/vkQgSgwCqYzT5IS0nM/BW26GVEtW4o9m3pAQzdbjx7+aMfah2MM=
X-Google-Smtp-Source: AGHT+IE3TQnudhp6FHT6qUPqrYOLnyZHmLrFvf0PQTWVKCZj5+/qeH01oaa7t/1W3OvwF2+lbUuC3w==
X-Received: by 2002:a05:600c:4fc6:b0:424:a7f1:ba2 with SMTP id
 5b1f17b1804b1-432830a5bddmr98883935e9.17.1730742981966; 
 Mon, 04 Nov 2024 09:56:21 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e94cdsm160008655e9.28.2024.11.04.09.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:56:21 -0800 (PST)
Date: Mon, 4 Nov 2024 18:56:20 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 1/1] hw/riscv: virt: prevent to use AIA MSI when host
 doesn't support it
Message-ID: <20241104-8bece5abd57645d5dbb55837@orel>
References: <20241101083606.5122-1-yongxuan.wang@sifive.com>
 <8ec6e960-8305-456c-b8f9-4c0dd14e51ff@ventanamicro.com>
 <20241101-6ada91d63644e8d715b1cf35@orel>
 <CAMWQL2hwDZdB9TmHF4=krzrUa1_=P78aBYt6nJddGZxMjk702A@mail.gmail.com>
 <f2614f02-b297-4320-84ca-42b7384f8f93@ventanamicro.com>
 <CAMWQL2hm8-_+V-Jv7tcVy-KeztHk=tvp83ZTVoczjCoJG4cZUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMWQL2hm8-_+V-Jv7tcVy-KeztHk=tvp83ZTVoczjCoJG4cZUQ@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x329.google.com
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

On Mon, Nov 04, 2024 at 08:47:53PM +0800, Yong-Xuan Wang wrote:
> Hi Daniel and Andrew,
> 
> Sorry I found that I forgot a situation. Host kernel doesn't support
> in-kernel AIA is not equal to host machine doesn't support AIA extension.
> 
> If user specifies aia=aplic-imsic when using KVM acceleration, we have 3
> possibilities:
> 1. host doesn't support AIA extension -> report error since we can't handle
>    the stopei CSR.
> 2. host support AIA extension but doesn't have in-kernel AIA -> use usermode
>    IMSIC and handle the stopei CSR in QEMU

And also sireg for the imsic range.

> 3. host support AIA extension and have in-kernel AIA -> use in-kernel AIA
>    and handle the stopei CSR in KVM

Yes, these are the three cases I was expecting, where there's also a 1.5
which is "host supports AIA extension but KVM doesn't support
usermode-imsic". Case 1.5 should also result in reporting an error. I'm
not sure we have 1.5, though, since it looks like the KVM AIA support
already attempts to fallback to a potential usermode-imsic. So maybe
it'll work without any KVM changes.

> 
> We need to update the kvm_riscv_handle_csr() for situation 2. And it's better
> to determine the availability of AIA extension in riscv_imsic_realize().
> 
> Please ignore this patch, I will send another patchset to handle the
> above situations.

We could also take this fix now and then do the usermode-imsic on top
later.

Thanks,
drew

> 
> Regards,
> Yong-Xuan
> 
> On Mon, Nov 4, 2024 at 8:15 PM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
> >
> >
> >
> > On 11/4/24 8:14 AM, Yong-Xuan Wang wrote:
> > > Hi Daniel and Andrew,
> > >
> > > When handling an external interrupt via IMSIC, we need to use the stopei CSR
> > > to claim the top interrupt. Even though the QEMU can emulate the IMSIC devices
> > > without the in-kernel irqchip, we still need to trap and emulate the stopei
> > > CSR. But since the host machine doesn't support the AIA extension, the guest OS
> > > will hit the illegal instruction exception instead of the virutal instruction
> > > exception when it accesses the stopei CSR. We can't have a chance to redirect
> > > this instruction to QEMU. So I think we can directly report errors when the
> > > user wants to use KVM AIA(MSI) without in-kernel AIA irqchip support.
> >
> > Can you please add this info in the commit message? This makes it clearer
> > that there's not much we can do in QEMU aside from erroring out.
> >
> > Also, please add a:
> >
> > Fixes: 48c2c33c52 ("target/riscv: select KVM AIA in riscv virt machine")
> >
> >
> > Thanks,
> >
> > Daniel
> >
> > >
> > > Regards,
> > > Yong-Xuan
> > >
> > > On Fri, Nov 1, 2024 at 11:09 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> > >>
> > >> On Fri, Nov 01, 2024 at 08:45:13AM -0300, Daniel Henrique Barboza wrote:
> > >>>
> > >>>
> > >>> On 11/1/24 5:36 AM, Yong-Xuan Wang wrote:
> > >>>> Currently QEMU will continue to emulate the AIA MSI devices and enable the
> > >>>> AIA extension for guest OS when the host kernel doesn't support the
> > >>>> in-kernel AIA irqchip. This will cause an illegal instruction exception
> > >>>> when the guest OS uses the IMSIC devices. Add additional checks to ensure
> > >>>> the guest OS only uses the AIA MSI device when the host kernel supports
> > >>>> the in-kernel AIA chip.
> > >>>>
> > >>>> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > >>>> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> > >>>> ---
> > >>>>    hw/riscv/virt.c | 19 +++++++++++++------
> > >>>>    1 file changed, 13 insertions(+), 6 deletions(-)
> > >>>>
> > >>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > >>>> index 45a8c4f8190d..0d8e047844a6 100644
> > >>>> --- a/hw/riscv/virt.c
> > >>>> +++ b/hw/riscv/virt.c
> > >>>> @@ -1567,12 +1567,19 @@ static void virt_machine_init(MachineState *machine)
> > >>>>            }
> > >>>>        }
> > >>>> -    if (kvm_enabled() && virt_use_kvm_aia(s)) {
> > >>>> -        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> > >>>> -                             VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
> > >>>> -                             memmap[VIRT_APLIC_S].base,
> > >>>> -                             memmap[VIRT_IMSIC_S].base,
> > >>>> -                             s->aia_guests);
> > >>>> +    if (kvm_enabled() && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
> > >>>> +        if (virt_use_kvm_aia(s)) {
> > >>>> +            kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> > >>>> +                                 VIRT_IRQCHIP_NUM_SOURCES,
> > >>>> +                                 VIRT_IRQCHIP_NUM_MSIS,
> > >>>> +                                 memmap[VIRT_APLIC_S].base,
> > >>>> +                                 memmap[VIRT_IMSIC_S].base,
> > >>>> +                                 s->aia_guests);
> > >>>> +        } else {
> > >>>> +            error_report("Host machine doesn't support in-kernel APLIC MSI, "
> > >>>> +                         "please use aia=none or aia=aplic");
> > >>>> +            exit(1);
> > >>>> +        }
> > >>>
> > >>> As you said in the commit msg it looks like we have a bug in this particular path: kvm accel,
> > >>> aia=aplic-imsic, no irqchip present. Erroring out is one possible solution but I wonder why we
> > >>> couldn't just emulate the APLIC and IMSIC controllers in this case. We have code that does
> > >>> that in TCG, so it would be a matter of adding the needed plumbing to treat KVM AIA without
> > >>> irqchip == TCG AIA.
> > >>>
> > >>> Drew, care to weight in? Thanks,
> > >>>
> > >>
> > >> If I understand the motivation for this patch correctly, then we'll always
> > >> need something like it anyway. With the proposal of supporting KVM with
> > >> usermode-imsic, then KVM would ultimately have three possible states:
> > >> inkernel-irqchip, usermode-imsic, nothing. usermode-imsic will need KVM
> > >> support for forwarding imsic accesses to QEMU, but when that support isn't
> > >> present (and the inkernel-irqchip isn't selected either), then we should
> > >> still want to error out before allowing the guest to try accesses that
> > >> can't work.
> > >>
> > >> Thanks,
> > >> drew

