Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F11C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 12:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmud9-0006t3-WE; Wed, 20 Mar 2024 08:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmucl-0006jA-EW
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:00:54 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmucg-0004Rz-So
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:00:51 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56b857bac38so1480799a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710936045; x=1711540845; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNkE6da5nY4diyvWdw63cxViSL9T6elg3MrQsGhQBKw=;
 b=k6r88GjbyTSF4I9V1IqttExss7eYP6o357+8QqOVEU0utqEoBFXkh8pF5F/35xRHlk
 kH4OiwBpIyzV65EAqglGUnKdFETDYetl/kZbtRIKHLe2YPVC2cOATAiRQ2JrV+W5djie
 IgC7LFFQ7+NsWYZ1MQRDhPB1J3rxb+bCfrdWCipo9XDezXHAqPlBrT17BOJAYyfOORW+
 CK8epubXtT5cHxlV1FWEsoZfFXJE9UQD0pZhJiiJ/A0i5RSiXPVVCf8l4POvSneoWcqk
 NXFMbUF3kAUFzM6Cy2lySM/XuJfIvKg0GucfEHCxj5OSneezsmeBkZljLjESWIesH2iw
 N9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710936045; x=1711540845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TNkE6da5nY4diyvWdw63cxViSL9T6elg3MrQsGhQBKw=;
 b=vCL3MD/OzZ2mnD04i2ERj2P8lktT3Pch2uXEZVk8WCwZmb6WxMbVt7EPR3N3JCWy7A
 TfzcYMX3kZMkTKQ5r/msq/Gq1JKQ6RvEIf8twNNgb90kram5YfSphnkjkhr1sr9/6i0a
 vEJcSwqqc2wfGZGgGdma2RapA6r7FKvAWI1C2qcRG2iPRfYFfU94iPIpcSOu+5r4Atw1
 uRZiP2uoT3/+8nEZBfEEVdrt5+LTb/tMZlDCIkgFi6xAg1773PGyVpjgpXWIOd6Ft5+r
 AFKEjxNeFsDLM4vmnz5oyPtnEoG61Ffs5j70jVN/weE/00GRcoT7vO2wiGg0QfcD18g/
 FQ3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLHe5Bm9NxjKgRCkWvMLzVMOW35V+5+ZLh/20FZxRZyu6n5IA2Qk95JVJMoW0q94wU1kcvgU7sH3j3fK4VaPxDMbtoOqs=
X-Gm-Message-State: AOJu0YyE9ZgzNPY5aF/IQc6oyx4aCkpsr1SCaoTYQL71gmQXrsv+B0/M
 M5kTPRGZve5tudphFABAUC/3SIZYho9j8TtYnFg9yD7VTauB1jCStpEvGHi7sMtQC3vSdoifZCB
 qG1PrC/YqFhIImijxPCpp2yw774OSf0n3MyEVZQ==
X-Google-Smtp-Source: AGHT+IFhzbQI4NpAf3jn8y8dnCR6wyPH05Es8O/QPBBqibNRzLn5uplr02zwGnM2Yl5Xlix1B1y1doH8aNk5a9GQENg=
X-Received: by 2002:a05:6402:3983:b0:565:7ce5:abdb with SMTP id
 fk3-20020a056402398300b005657ce5abdbmr12932866edb.10.1710936044648; Wed, 20
 Mar 2024 05:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240220150833.13674-1-philmd@linaro.org>
 <f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com>
 <cc132404-dcd5-4aed-a481-b46d6e3115b0@linaro.org>
In-Reply-To: <cc132404-dcd5-4aed-a481-b46d6e3115b0@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 12:00:32 +0000
Message-ID: <CAFEAcA_0qUFW0MewHC+v+pSOisE-kQDt9Wv4F3RafEkyQ0DGJA@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Burton <mburton@qti.qualcomm.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 20 Mar 2024 at 11:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 20/2/24 16:19, Thomas Huth wrote:
> > On 20/02/2024 16.08, Philippe Mathieu-Daud=C3=A9 wrote:
> >> Have s390x always deliver NMI to the first CPU,
> >> remove the @cpu_index argument from handler,
> >> rename API as nmi_trigger() (not monitor specific).
> >
> > Could you please add some rationale here why this is needed / desired?
>
> I'm not sure it is desired... I'm trying to get the NMI delivery
> working in heterogeneous machine, but now I'm wondering whether
> hw/core/nmi.c was designed with that in mind or likely not.
>
> I suppose in a complex machine you explicitly wire IRQ lines such
> NMI, so they are delivered to a particular INTC or CPU core, and
> there is no "broadcast this signal to all listeners registered
> for NMI events".

I think in a complex heterogenous machine you do want the
monitor NMI command to do something sensible, but the
definition of "sensible" is going to be machine-specific:
probably it will be "raise NMI in some way on some core in
the main application processor cluster", and it's the machine
model that's going to know what "sensible" is for that machine.

The current hw/core/nmi.c code is a bit odd because it's partly
working with a cpu_index and partly not: the code passes cpu_index
around, but in practice for the QMP command the user can't set
which CPU to operate on, and for everything except s390 the
implementation doesn't care anyway. My impression from the IRC
discussion is that it's not really necessary for the S390 that
the monitor user be able to specify which CPU to NMI (and in any
case you can only do that from the HMP command, not the QMP
command, AIUI), so getting rid of that weird inconsistency makes
sense to me: and that's what this patchset is doing.

What NMI probably ought to be is board-specific: so it's like
having some notional front panel switch labeled "NMI", and the
board gets to decide what that means (which is usually going to be
"send some NMI like interrupt to the first CPU in the main cluster",
but could be something else). It doesn't need to be like a
front panel switch with a rotary-selector for 'pick a CPU'
plus a button for "send NMI to that CPU". In fact we're quite
close to "it's a board thing" already, because almost every
implementation of the TYPE_NMI interface is actually a machine
model. (The exceptions are hw/intc/m68k_irqc.c,
hw/m68k/q800-glue.c and hw/misc/macio/gpio.c.)

So I think that:
 * we should indeed drop the cpu_index stuff, per this patch:
   it's unnecessary cruft we don't really use
 * we should look at whether the three classes listed above
   which implement TYPE_NMI on a non-machine-model are really
   the right way to do that, i.e. whether it would be a lot of
   effort to effectively switch to having nmi_monitor_handler
   be a simple method on MachineClass. Not walking the QOM
   tree would make the NMI infrastructure rather simpler.
   (But I just looked at the macio case, and it's inside a
   PCI device, so at best that's a bunch of clunky plumbing.)
 * failing that, we should look at whether we should really
   continue to walk the whole QOM tree calling methods on every
   TYPE_NMI object, or whether we can say "once we've found one
   implementation we're done". This also depends on those three
   non-MachineClass implementations, because obviously there's
   only ever one MachineClass object in the system. This is
   kind of useful for heterogenous boards which use the m68k
   or ppc devices listed above (seems highly unlikely), but it
   would mean you can override the default "those objects handle
   NMI" by having your heterogenous board implement TYPE_NMI,
   and then since it's earlier in the QOM tree that will be
   the method called, not the ones on specific devices.
   (This one I think we can easily do -- my quick check suggests
   that TYPE_M68K_IRQ is only used in the m68k virt board,
   TYPE_GLUE is only used in the m68k q800 board, and
   TYPE_MACIO_GPIO is only used in the ppc mac99 board. So in
   fact in all cases there's only ever one TYPE_NMI interface
   present in the system.)

The last two aren't blockers for heterogenous-system work,
though: they just seem to me like nice cleanup of this interface.

thanks
-- PMM

