Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E04C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8dK-0002lY-Ph; Thu, 20 Feb 2025 10:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whendrik@google.com>)
 id 1tl8dF-0002lE-61
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:38:33 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <whendrik@google.com>)
 id 1tl8dD-0002kX-6e
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:38:32 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-543e4d1cf43so8266e87.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740065908; x=1740670708; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPrlxOGx68Kh4ZqBXIF+mL51egvnHlOctDO0LuiCtYo=;
 b=LS+uQpFS9SZZlwtYFjBKkpI3u+b6AzfyjTJrLcCNLt1k8RWZfxRGMncPZnPRtnNvJS
 Z+QUf8jFjhP4NpHIACUKvc5bEC7AWHMivQXyD3cbQS9X216f/ObUEPBP7Sw7188I4QKa
 QUytqDeTOmVnoyChoisQrl/TGQF6t8l5yLeredZZ4bSvT72DWUMDAYdjpwb2HqxZ+Xb2
 x34FwsPla0rKxU50OxgrKyl/PdQLpn3xhZUOiDnhkAis1UEEtOMnPYOltbkKiJLpZhmL
 5gIDTnJeXIJpy6e22VqWxCnwp12YZz9m2gJ1uYpTyx3aTQbpPCsDBn6lvV8M1ylu44pF
 YCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740065908; x=1740670708;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rPrlxOGx68Kh4ZqBXIF+mL51egvnHlOctDO0LuiCtYo=;
 b=Y+8v2zAbddPDVCj/wAuIzVtwSkBNXJ+US/QgYradJNgxWPNQ/2c/gNUBrNPbf4FbUU
 0VvFoCZwwXGooEPD2gqD11T4wFBA3KsjPN6BqJXcEIdmUnkEzCveDXD8cI/j7LG8srOl
 V1pCQQvjeF+9rrEiUDdLZlu6L728oBu0easDDz1nx8F/XiH/5Bd+jDq9Of0fqjJe7nTW
 Kuc9LMLLqKJ25VgjsKXxhyJHdvAZ2sCUAPkWjsyMk7yF23weQm74mtbeLeFGGhdgFS4N
 1eZJ/vzW0v3pvBpfX+9c0yyI8kI1z/th0QJAj8mSOd9PL4xZwP76K5nu+VASrv/7V++q
 kEtg==
X-Gm-Message-State: AOJu0YzvPqUDS/iT9BrWu01G+WB4kIXw05TC4aozJtoJferb0l0IZIDn
 lBulIeK+DzkKezgTEOL75f/XnZPvWoi0tNnoOEa60JQPXnZIK++19fLellKMFqeXHOlOnzkjUI5
 //zzmnXrIVvSMhh9WxPVTOIIv1J/zYnRuzyYO
X-Gm-Gg: ASbGncvqcydpk+p0tFBKxhEyYN6jaUyOYRJxYB8e36MUqSimajlUMnJ8kiTgQw7wJs4
 tUZXoKVdQFlNC+hWQXZc+9ecU268e3aklw+qUHWjb/tY6eSrx4wIAJ4Dm/2VkuOYxWxQhqAbZ6V
 VgmaerJMmW4Nk+7yewtTGWl3u3MYE=
X-Google-Smtp-Source: AGHT+IFoXuP+z/ITg1sdenSYkUC1C0oN/7l1RAA4JsIUP0a43AymrziH+XmUt9gbJ/7CJ7PxCRXpwomwey5oRnhDquE=
X-Received: by 2002:a05:6512:3f25:b0:545:1cbb:74e5 with SMTP id
 2adb3069b0e04-5471cc9e11dmr191814e87.3.1740065907492; Thu, 20 Feb 2025
 07:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20241213172645.2751696-1-whendrik@google.com>
 <20250220094956-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250220094956-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Hendrik_W=C3=BCthrich?= <whendrik@google.com>
Date: Thu, 20 Feb 2025 16:38:15 +0100
X-Gm-Features: AWEUYZmbskDqso1V8KbHEh0Pob2G7Sa01fsyUO4UX8kNQOmZhtBlPWr5JJEyzXI
Message-ID: <CAEX-0Wtdcv5BPv4S8h8YfN2qLMg2U0b6D-7-eFXut9ZL15xcaQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] mulate Intel RDT features needed to mount ResCtrl
 in Linux
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com, zhao1.liu@intel.com, 
 xiaoyao.li@intel.com, peternewman@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=whendrik@google.com; helo=mail-lf1-x132.google.com
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

On Thu, Feb 20, 2025 at 3:50=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Dec 13, 2024 at 05:26:37PM +0000, Hendrik Wuethrich wrote:
> > From: Hendrik W=C3=BCthrich <whendrik@google.com>
> >
> > The aim of this patch series is to emulate Intel RDT features in order
> > to make testing of the linux Resctrl subsystem possible with Qemu.
> >
> > A branch with the patches applied can be found at:
> > https://github.com/Gray-Colors/Intel_RDT_patches_applied/tree/rdt_v5
> >
> > The changes made introduce the following features:
>
>
>
> There was just my minor comment, are you going to post v6?

I found out about some larger issues, mostly in the mapping of RDT
state to cores, and am rewriting some parts (mostly of the rdt.c file).
I hope to be able to send something out in the coming week.

>
> > * Feature enumeration for Intel RDT allocation.
> > * Feature enumeration for Intel RDT monitoring.
> > * Intel RDT monitoring system interface.
> > * Intel RDT allocation system interface.
> >
> > By adding these features, a barebones implementation most of the RDT
> > state and MSRs is introduced, which can be enabled through qemu
> > command line flags.
> > The features missing for a faithful recreation of RDT are CDP and
> > non-linear MBA throttle, as well as the possibility to configure
> > various values through the command line, as some properties can be
> > different across different machines. For increased ease of use, the
> > correct features should be automatically enabled on machines that
> > support RDT functionality.
> > The missing features mentioned above will be implemented in the
> > following order:
> >
> > * Expand feature set for RDT allocation to include CDP and non-linear
> >  MBA throttle
> > * Allow for command line configuration of some values, such as the L3
> >  CBM length
> > * Automatically enable RDT on machines that officially support it.
> >
> > Will NOT be implemented
> > * Tests to simulate interaction with the host by the guest
> >
> > Command line examples assuming entire patch series is applied (This
> > requires a kernel with Resctrl enabled):
> >
> > To emulate Intel RDT features:
> >
> > Currently, it is necessary to force the RDT options on in qemu, as it i=
s
> > not automatically enabled for any machines. An example would be the
> > following:
> > -cpu Skylake-Server,+l3-cmt,+rdt-m,+rdt-a,+mba,+l3-cat,+l2-cat
> > and
> > -device rdt
> >
> > Just enabling RDT in qemu won't really help, though. The following
> > option allows resctrl in the kernel:
> > - Kernel options: rdt=3Dmbmlocal,mbmtotal,cmt,mba,l2cat,l3cat
> >
> > To use Resctrl in the Qemu, please refer to:
> > https://docs.kernel.org/arch/x86/resctrl.html
> >
> > V4 -> V5
> > - rebase
> > - fix feature bit names to all be in hex
> >
> > =E2=80=AAHendrik W=C3=BCthrich (8):
> >   i386: Add Intel RDT device and State to config.
> >   i386: Add init and realize functionality for RDT device.
> >   i386: Add RDT functionality
> >   i386: Add RDT device interface through MSRs
> >   i386: Add CPUID enumeration for RDT
> >   i386: Add RDT feature flags.
> >   i386/cpu: Adjust CPUID level for RDT features
> >   i386/cpu: Adjust level for RDT on full_cpuid_auto_level
> >
> >  hw/i386/Kconfig                      |   4 +
> >  hw/i386/meson.build                  |   1 +
> >  hw/i386/rdt.c                        | 286 +++++++++++++++++++++++++++
> >  include/hw/i386/rdt.h                |  76 +++++++
> >  target/i386/cpu.c                    | 114 ++++++++++-
> >  target/i386/cpu.h                    |  24 +++
> >  target/i386/tcg/sysemu/misc_helper.c |  81 ++++++++
> >  7 files changed, 584 insertions(+), 2 deletions(-)
> >  create mode 100644 hw/i386/rdt.c
> >  create mode 100644 include/hw/i386/rdt.h
> >
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
>

