Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC1CC4829E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 23:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZg9C-0002ww-U7; Mon, 12 Feb 2024 18:55:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dionnaglaze@google.com>)
 id 1rZg9B-0002wj-Gf
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 18:55:37 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dionnaglaze@google.com>)
 id 1rZg99-0001LS-Ap
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 18:55:37 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56101dee221so2080a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 15:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1707782133; x=1708386933; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6itQQaR2Z/L3i+JBfSfEyke1YwBxirzhzf8c6oLKsE=;
 b=1VR10UPNATU+zsTJKFvOuk74GEih+c/cNeTEW6NMMqBk38Zm9jr+rMOQ7vybLbNU6L
 GUHuP/P/wZrUDbszgcmjZdD4U6JWZbfXmUCH5Jz32QytXSsl7iNWApR1fejryKONGodp
 29c15MgWCerOzrlOUuWUjFq/Icu6Zc5Kx8xf/hz/DFh4v3/a5px7GsXOhBmOya9AgsTc
 sUBK8rTmB3KGsNx+7qWaQ/df25VSR8n/clpR6somauK2UuMVo59bOu3mDC2dUnNyIzSv
 Gq5PyF2jjX7LMTg5hczipYLQqsVuwbPFbAlGG8yu9l+39BzM9rLLCe3l0+tX8LG+reGN
 Ua3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707782133; x=1708386933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d6itQQaR2Z/L3i+JBfSfEyke1YwBxirzhzf8c6oLKsE=;
 b=WWNLcn+rp2ZzNnCN2vqWdVCv0BwbTqBZ7zkcP6F+hxsCqveLVc/9KE3NHuqIf1G72K
 lKr2gF2wBvs/jVK2I5ZPpA7nfktRPFJpKPw7p1NUN2y4omNdXHam7BopIVFQTe/RRfN5
 ayCafZ24qCdj8bNNwHTgGTC3yTcnPN74/DOabiXINsl+TC1ni3kqnDStb/TtWQs1SX1i
 CqcB4QVfIhCbqkTe+nw+e+LbwXrFwTa01EHYqBPlng5NW6sE/aQil8cY6wqyDTzLy92p
 ZuZxhgnCgrD6N1LHNXPGFLFi+tYERKVozseNOIkS/k73qIhPWYYcUfRJvMTGiu64kpWu
 K24Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmSVjER3VlG9Y34xe99RmdYF0QyV8cXGOCrIp+0ffxIbHandhLjv7Niyfv4drB6Y0Cv9wMnWCWUoXSkNOhi8zivROqQpY=
X-Gm-Message-State: AOJu0YwLLIbzuWEZbn5ezgOc5Q87USrZuj1UqR13s19Ecx/Ewqk3ALfB
 zVTxOlgUGOXiTk/1qVnpxOu8LvKzJ8n6r3ftDmea1rvYIjMoZqEwh/4+q/ObgSVWJb/JA7HBcPD
 tywjXjH7nq7kEAVk9a0oQuHcRe0jksZl3uPNn
X-Google-Smtp-Source: AGHT+IElqLLLW1Sy0FbZolFbhKcmTG5wWxvmA/bwKStHdf/ve72fN7Llqv+kMypZ7iUfUTtyvM1C9tHY7rL7tkrIxi4=
X-Received: by 2002:a50:c05c:0:b0:561:e7d8:50a8 with SMTP id
 u28-20020a50c05c000000b00561e7d850a8mr44841edd.0.1707782133332; Mon, 12 Feb
 2024 15:55:33 -0800 (PST)
MIME-Version: 1.0
References: <CAAH4kHY+JHSznw_t52rwBckfcZpzvX28b9Cu3eyXLMShnj3NBg@mail.gmail.com>
 <f845a5689475d4698cbb16efa942a53636cd4385.camel@linux.ibm.com>
In-Reply-To: <f845a5689475d4698cbb16efa942a53636cd4385.camel@linux.ibm.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Mon, 12 Feb 2024 15:55:20 -0800
Message-ID: <CAAH4kHYMnmt=LaLx36KED_S1M+3q=PMQ639i5cLZzybBS=Kqxg@mail.gmail.com>
Subject: Re: RFC i386/sev: kernel-hashes, reference measurements and event logs
To: jejb@linux.ibm.com
Cc: "Li, Xiaoyao" <xiaoyao.li@intel.com>, npiggin@gmail.com, 
 Gerd Hoffmann <kraxel@redhat.com>, "Draper, Andrew" <andrew.draper@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Chong Cai <chongc@google.com>, 
 qemu-devel@nongnu.org, clg@kaod.org, danielhb413@gmail.com, 
 harshpb@linux.ibm.com, david@gibson.dropbear.id.au, borntraeger@linux.ibm.com, 
 farman@linux.ibm.com, Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, iii@linux.ibm.com, thuth@redhat.com, 
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=dionnaglaze@google.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
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

On Mon, Feb 12, 2024 at 12:57=E2=80=AFPM James Bottomley <jejb@linux.ibm.co=
m> wrote:
>
> On Mon, 2024-02-12 at 12:16 -0800, Dionna Amalie Glaze wrote:
> > This is not a patch but it felt inappropriate to derail a recent
> > patch that's just refactoring the kernel-hashes object_class_property
> > definition. Apologies if this has been discussed before, as I'm not
> > particularly active here.
>
> I haven't seen that patch, but I presume it's not relevant?
>
> > Regarding kernel-hashes, how is that load-time information passed
> > along to the guest beyond, say, OVMF? Can we require that these
> > hashes
> > are also present in fw_cfg so they can be read from the kernel? In
> > Linux it'd be nice to have /sys/firmware/qemu_fw_cfg/sev_kernel_hash,
> > /sys/firmware/qemu_fw_cfg/sev_cmdline_hash,
> > /sys/firmware/qemu_fw_cfg/sev_initrd_hash
>
> Are you referring to measured direct boot?  In that case, there's no
> point having hashes in the fw_cfg, because OVMF in the guest needs to
> hash the kernel itself and then compare to a trusted source (which the
> fw_cfg file wouldn't be because it's under the control of the

I'm not suggesting that OVMF uses the fw_cfg files to check, just to
use an interface that is readable by the guest OS. If the values are
wrong, then you can't reconstruct the measurement in the attestation
report and the host just DoSes the guest, which is already possible
without this change.

> hypervisor).  For SEV, the trusted source is a table in the launch
> measured ROM, but I'm sure TDX does something similar.

TDX measures information after launch into RTMRs, which SEV-SNP doesn't hav=
e.

>
> > I'm working on how to use standard document formats for providing
> > reference measurements of the Google Compute Engine virtual firmware
> > for remote attestation, and these hashes have an impact not just on
> > the measurement but on the entire model that the IETF RATS working
> > group is considering for authorizing attestation measurements.
> >
> > If you're assembling a VM launch configuration with firmware provided
> > by a trusted vendor (say Google), and your hashes are passed in from
> > an API, there's no easy rendezvous to state that the combination
> > produces the expected hardware measurement. This makes adding
> > kernel-hashes support unappetizing, since it makes the hardware
> > attestation report's measurement have no meaning, or at least, it
> > makes life difficult for people trying to assign it meaning.
>
> Well, no, since firmware tends to update on a longer timeframe than the
> kernel and the cmdline and initrd tend to have quicker update cycles

This is not true of our environment, where every release of the
hypervisor includes a fresh build of the firmware, which may have
codegen differences for multiple reasons. We don't have a way to
announce ahead of time which firmware an instance will get for them to
sign an initial measurement derived from it.

> than the kernel.  Thus there's no one golden reference.  Instead you
> give a tool (say the virtee sev_snp_measure tool
>
> https://github.com/virtee/sev-snp-measure
>
> ) the hashes of the firmware, kernel, command line and initrd and it
> caclulates the expected launch measure

Yes indeed, I've written one myself. Publishing it has been a bit
Kafkaesque as opposed to the go-sev-guest and go-configfs-tsm
libraries.
The problem is still preauthorization when it'd be much more
preferable to authorize components of a measurement and derive the
SEV-SNP attestation from the components.

>
> > The measurement is the product of two different entities as assembled
> > by the VMM given a trusted firmware and the kernel hashes. It's a bit
> > of a sandwich of (GCE) core firmware, (User) SEV hashes, (GCE) BSP
> > VMSA, AP VMSA*.
> >
> > When you collect "evidence" to verify locally or pass along to a
> > verification service, you need more than just the hardware
> > attestation report to make sense of the combined bits. You have a PCR
> > situation like with TPM, so you need an event log for these different
> > aspects of the ultimate measurement. There is no event log for this
> > -kernel-hashes construction.
>
> That's because it's a pre-launch measure.  The TCG log is only for post
> launch.  The idea being those values are needed for you to approve
> something in pre-launch, like key release, before the TPM starts
> running.
>
> That's not to say we shouldn't have log entries for pre-launch, but
> that's a generic problem and not specific to measured direct boot.
>

Okay, do you know which direction the solution is moving? I know
there's a measured TPM firmware change proposed to the TCG, but that's
a bit too specific.

> > We can use the TCG TPM event log to post EV_NO_ACTION events about
> > the PlatformRIM, specifically, to point at a UEFI variable that we
> > populate to store our signed document about the expected measurements
> > with the Qemu-SEV-SNP-boot-protocol, but I don't see how we might
> > collect the kernel-hashes values as extra evidence to combine and
> > derive the attestation report's MEASUREMENT field to accept
> > "evidence" objects for the core firmware component and the kernel
> > hashes component.
>
> This sounds like a first measurement thing.  In many ways, the pre-
> launch measurement is equivalent to the SRTM of a physical system which
> is collected in the EV_S_CRTM_* events.  But for that to happen, I
> think the TCG would have to bless it in some form.
>

Is that the pathway you'd recommend? I'm not sure a new EV_S_CRTM_*
event for each SEV hash table entry for Qemu (say) is going to be
ratified.

> James
>
> > So my question is if this feature is to be a long term feature, how
> > do you expect to collect the SEV hashes as a separate evidence object
> > to play nicely with IETF RATS?
> >
> > Is this a long term feature, or are we expecting it to be deprecated
> > by SVSM?
> >
> > I've tagged in people in CC that I could imagine would have something
> > to say about this.
> >
> > Thanks y'all
> >
> > --
> > -Dionna Glaze, PhD (she/her)
>


--=20
-Dionna Glaze, PhD (she/her)

