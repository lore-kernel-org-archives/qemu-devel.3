Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52ACE81BD8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 15:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpSxC-0001a9-Cd; Mon, 09 Feb 2026 10:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vpSxB-0001Zz-Hz
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 10:13:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vpSx8-0003BF-SE
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 10:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770650008;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xjAOrdSvI7NVvy8VeWcpSZalO11iLLeU4gg9n4/AfQ0=;
 b=VPOok2SAXUw67YP5gbUxQYMbBy5qadHbfjv8cJUnFjeFcx0cfS3QcuLAiS4c8tTNw+H4Tf
 KjIVOSA2l7qc9VwY16lHEkY71KfdpSquhvwrWhcwRltaaVVEA4d4u9opg9DSS/Vm+hesVL
 IUJWbk36Fbf5ZR0qskO2Y0Q2Ix+GsaM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-7deANHBnOhWMdjm733MH2w-1; Mon, 09 Feb 2026 10:13:27 -0500
X-MC-Unique: 7deANHBnOhWMdjm733MH2w-1
X-Mimecast-MFC-AGG-ID: 7deANHBnOhWMdjm733MH2w_1770650006
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-482eec44485so35457655e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 07:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770650006; x=1771254806;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjAOrdSvI7NVvy8VeWcpSZalO11iLLeU4gg9n4/AfQ0=;
 b=fDM3WzAVEK9WF+JCJw0DqHgsDmP0HZhAju33mBFnCNhNCl1gr9fQ0Db2syCZwl28mN
 SR9yaAIF4xmiAoQe/JDjMUlz+NIk4qi7t/ltbvzXGZxFKzPpjRRSQ3wrLd4rJOPjzaju
 W+sVzPPlsZis/kxDxqyBglIDR1ZMbTYwDxGVZ8HVVFo/LK9x3ki0Ut89/bUkHMLIwMRz
 1O+7CATCS2lkjYo3Lc/5lKVMiZMOdiphDaWEZe97Ked6NUM+rP7i/R+btV9WSJBr3bHA
 x3Hor36uV0mbpA3BFS6xDNdOUgfa6ZMC2SVbJ0fguUG2NLlaN0qfQ5kaDazCORhakc0D
 4R5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCs9CEvuXAnLAJZ5ttsZk1zLvmHsqSu7/EiDQ9BcBG6Guu0m8jWHEeLpgBAmnlhORZ7X5GmjWBPgVS@nongnu.org
X-Gm-Message-State: AOJu0YzxoYdGXpvivoEx1V4lpOEVSuk3BYy4cgSgDXgGwc17QB/iRyyp
 oFHOLEPyhWLORj5QoSCUQjTMkFAlcUHguonbzMy3a5gr6icEoRmwFUnBjgI4ju2dgQKmHjf7rdA
 RIfw02hzouwLhZFV+IkkvCkiS4rVgk8YOsSTEV9hZjCQ3AssUFGeU7zmi
X-Gm-Gg: AZuq6aIl/KX79DjB6qO1NDN5isIJi9ddJYxK5RRyEGRIHz1VHCSe6x7InlLvMxkZKW/
 6O5SSlb4NG/unX33K1jOLibrt4vAFhDoAZ29hE/YbOAN5FWAwTFkDAUp0y8pw5MCh7w9oO3io2/
 QMFkfH3PHnphYBDRD20qMPvJ/6fM8UJcP/JrEPm8ck+2mVatoEseA5cL33pWUDm+xUkVwIuVG0c
 blWqnu+SiRhd5710xteXGX/VmCmtMWBU6ks+y4nVrbm9QmAmVLEN2q8L+orp4mAdzTjHon7fbzr
 xvHMxAtPgh1o3ygJqBf/a3izN1yIBKutg/xu/szAWme44KXnZOKr0YbOmX15iEs2zQX+YzG/nHz
 xVqWP7rGih8sRwSur4NEIMSl9PYahM5I94sf1LjDpApP011Upxjt6Ut+xAg==
X-Received: by 2002:a05:600c:3f19:b0:477:9a28:b0a4 with SMTP id
 5b1f17b1804b1-4832018048cmr173309585e9.0.1770650006083; 
 Mon, 09 Feb 2026 07:13:26 -0800 (PST)
X-Received: by 2002:a05:600c:3f19:b0:477:9a28:b0a4 with SMTP id
 5b1f17b1804b1-4832018048cmr173308975e9.0.1770650005521; 
 Mon, 09 Feb 2026 07:13:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d8341csm328092835e9.13.2026.02.09.07.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 07:13:25 -0800 (PST)
Message-ID: <74d89612-85d9-455b-975f-578b31ffa0ec@redhat.com>
Date: Mon, 9 Feb 2026 16:13:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/11] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 cohuck@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20260126165445.3033335-1-eric.auger@redhat.com>
 <CAFEAcA-gi42JObOjLuPudABX8WRdWf5SzSbkzU-bd06ecF1Vog@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA-gi42JObOjLuPudABX8WRdWf5SzSbkzU-bd06ecF1Vog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 2/6/26 3:15 PM, Peter Maydell wrote:
> On Mon, 26 Jan 2026 at 16:54, Eric Auger <eric.auger@redhat.com> wrote:
>> When migrating ARM guests accross same machines with different host
>> kernels we are likely to encounter failures such as:
>>
>> "failed to load cpu:cpreg_vmstate_array_len"
>>
>> This is due to the fact KVM exposes a different number of registers
>> to qemu on source and destination. When trying to migrate a bigger
>> register set to a smaller one, qemu cannot save the CPU state.
>>
>> For example, recently we faced such kind of situations with:
>> - unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
>>   register from v6.16 onwards. Causes backward migration failure.
>> - removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
>>   from v6.13 onwards. Causes forward migration failure.
> Hi; sorry I haven't given this series any attention before.
>
> (1) Yes, this is definitely a problem we need to solve.
>
> (2) What are the requirements we have for this?
>
> This series sets up CPU properties controlling this, and then
> sets them in the virt machine model based on the machine
> type, but this seems awkward for two reasons:
>
>  * using properties confines us to using a "text string"
>    way of describing the behaviour; if we could implement
>    the handling in code and C data structures in target/arm
>    we could potentially do it in a more flexible and
>    readable way (e.g. being able to specify the register
>    via something other than a raw hex value)
>  * different host kernel versions isn't really related to
>    the QEMU version, so tying it to a versioned machine
>    type doesn't seem to fit
Well, in distros, I think it is.
When Red Hat releases a new RHEL, a new qemu version with hopefully a
new virt machine type (not always) comes along with a new kernel.
If you want to migrate between this new kernel and an older one, this
means you will use the old machine type. The new qemu, when using the
old machine type knows it needs to handle specific migration hurdles
that originate from the diff in the host kernels. So to me the
mitigation schemes can be really attached to a machine type.
 

As we tie a qemu version with a host kernel, it looks natural to use
compat props. 
>
> Q: Do we need the user to be able to control this (e.g. adding
> extra registers to be ignored) on their command line, or
> can we say "you need a newer QEMU that understands how to
> deal with this register if you want to do migrations involving
> this newer kernel version" ?
I don't think we need users to play with that. We rather need compats
that apply to machine types. 
>
> Q: This series adds a "hide this register" option which
> stops the register appearing in the outbound migration data.
> Do we need that, or would it be enough to have "ignore this
> register in the inbound migration data" ? Assuming we're
> not trying to migrate backwards to an older QEMU version
> that's unaware of the new register, that seems to me like
> it should be equivalent.

I think this is mandated. 
Assume you have distro-n installed in all your customer premises. Your
customer wants to migrate to distro-n+1. It migrates some VMs to n+1.
n+1 features a new qemu and a new kernel which exposes new features such
as a new KVM pseudo FW reg. For some reason, the customer discovers
there are some issues with n+1. Customer wants to migrate those machines
back to distro-n machines. this won't work. It was confirmed this
scenario has been useful on x86 in the past. You don't want to update
your qemu on distro-n to handle extra incoming regs. This is already
shipped on the customer premises as part of an old release. Old qemu is
not ready to deal with extra regs in the incoming stream. That's why I
think we need both.  
>
> (3) Categories of sysreg that are causing problems:
>
> a: "controls" -- like the PSCI_VERSION pseudoreg. Here the setting
> controls what the kernel is exposing to the guest, and so we need
> to be able to have the user tell QEMU to use a specific version
> that's not the host kernel default if the default isn't one
> that's valid for all older kernels. Sometimes the new kernel
> default is the same as the old kernel's behaviour and in those
> cases we also want handling of "if you see the control reg in
> the incoming data and its value is the default then it's OK to
> ignore it".

Effectively we could have have something telling qemu that if the
migration fails due to that given reg and because of this given value,
that's OK.
However in case you want to spawn VMs with a new release while keeping
in mind we may need at some point to migrate those VMs back to an older
release in the advent of any issue, it may be safer to directly set the
pseudo FW reg to the old default version. This looks safer to me instead
of starting the VM with PSCI_VERSION set to 1.3 initially and then
reverting to 1.1 on the dest without notice. I am not sufiiciently
knowledgeable on that use case but I am not even sure this wouldn't
break in general.
>
> b: "things exposed that should not have been" -- where the old kernel
> exposed a register but the new one does not because exposing the
> register was wrong (i.e. a bug). The handling here can be
> "ignore this in migration input if present". Examples are the
> TCG2_EL1, PIRE0_EL1, PIR_EL1 regs that shouldn't exist if the
> corresponding feature was disabled for the guest.
yes that's what I called safe-missing-regs
>
> c: "things not exposed that should have been" -- where a new kernel
> exposes a new register that the old one does not, and so migration
> from a host with the new kernel to the old one fails. In most cases
> it should be possible to handle this with "ignore in migration input
> if present", or "fail migration if incoming value is not some safe
> default, but if it is that default value then ignore".
you would need to update the qemu on the old release which is not what
we want to do. Old qemu is not equipped with that ignore-if-missing
feature.
>
> Have I missed anything ?
>
> (4) Mechanisms for handling them:
>
> This series provides two mechanisms:
>
> "safe missing reg" -- these registers are ignored if they appear
> in the incoming migration data.
>
> "hidden" -- the behaviour here is that we effectively entirely
> ignore the register, so we do not read it from the kernel or write
> it back, do not send it in outbound migration data, and do
> not expect to see it in incoming migration data.

On top of what I currently do and as pointed out by Alex during the
bi-weekly call, I think we need to make sure the guest has not changed
the init value. 
>
> The "arm: add kvm-psci-version vcpu property" series handles one
> specific "control" register, with a specific user-facing cpu property.
> If new "control" type registers are rare, this seems like a good
> way to go, because it means we can give the user an interface that
> is reasonably clear about what it does, and we can provide better
> errors on the migration-destination side (e.g. pointing the user
> at the need to specify the property on the source side to get a
> VM they can migrate to this destination).
I think and hope this should be rare. This is an obsvious compatibility
breakage. At VMM level we do our utmost to avoid this situation by
introducing quite a lot of compats already. Also as mentionned earlier I
think it is much safer to start the VM with a reg value that is likely
to be compatible with its migration destination. Again only older
machine types will be started with 1.1 PSCI version while the new one is
started with 1.3.

>
> The only use of "hidden" so far is for KVM_REG_ARM_VENDOR_HYP_BMAP_2.
> However, I'm not sure this is the right way to handle this register.
> Judging from the documentation, this seems to be a "control" register:
> it would let QEMU enable certain things to be visible to the guest.
> It also is odd to treat this differently from the existing
> KVM_REG_ARM_VENDOR_HYP_BMAP register, which has exactly the same
> semantics.
Agreed but KVM_REG_ARM_VENDOR_HYP_BMAP reg does not break migration
anymore. BMAP_2 is a real life case that breaks it. At the moment we
cannot introduce this feature without breaking the compat and the
problem is we will need that feature for vcpu model at some point. So
this is a dead end. Any new KVM reg will break the migration. The
purpose of thise series is to bring an infrastructure for distros to
handle such breakages while minimizing downstream only code.
>
> I think that the right way to treat this register would be
> "if this is present in the incoming migration system and the
> host kernel doesn't know about it, a value of zero is OK, but
> any other value should fail migration".
this obliges to upgrade qemu on the destination (older installed
version) and I don't think we want that in general.
>
> In general I'm not convinced that "hidden" is a useful thing
> to provide -- it should always be fine for QEMU to read and
> write back to the same host kernel some sysreg it doesn't
> know about, so what "hidden" is mostly doing is "don't put
> this into outgoing migration data". Do we need to be able
> to do that, or can we instead always use a "ignore in
> incoming migration data" strategy?
>
> (5) My preferences
>
> I think that assuming that it meets the requirements, I would
> prefer something like a mechanism where we use some kind of
> C data structure / code in target/arm/machine.c to represent
> "this register needs some special handling", where the special
> handling might be:
>  - ignore if present in input
>  - if present in input, value must be X, otherwise fail
>    migration
>  - maybe some other things if we need them
>
> and this is not tied to specific QEMU machine versions and
> isn't something we expose via QOM properties.
So you wouldn't bother about specifying that a given migration issue can
only happen with a given machine type. Effectively it is simpler but
less precise in general.
>
> I'd rather avoid the "hidden" register idea unless we
> definitely need it in addition to "ignore in incoming data".
I think we cannot afford assuming/relying on an upgrade of the old qemu

Thank you for the technical exchange!

Eric
>
> thanks
> -- PMM
>


