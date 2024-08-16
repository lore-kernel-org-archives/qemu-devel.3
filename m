Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF1CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 13:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewn5-0003cL-KS; Fri, 16 Aug 2024 09:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sewn2-0003bC-8K; Fri, 16 Aug 2024 09:14:48 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sewn0-0006Ev-CE; Fri, 16 Aug 2024 09:14:47 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5b9d48d1456so3253708a12.1; 
 Fri, 16 Aug 2024 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723814083; x=1724418883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NO0yNECN+xfmp1Ew6nPth1TBvVMJWXurUgl6b+qxEiY=;
 b=ZUCT/PYFlI36DbSvWUdmdxkso/FDH7TeZIkxO3qoYgkLruXg6eDcchwuYLSXz/jyEk
 Ftz3YxX0+WITfydAwvnHW+1iIkl2MFvEq16X2YTmN9lvD9cebiT5Vd7tl/9dDnqDf0Bj
 e2oKfP5i3OHOlKj0F4PCC8eUXRAQSOPjEw6nJ/sQVhTS2aOOipF0QgT989con4dE4Ava
 O3iaODaQsROUkvOWOKt8vb8XqlY5j1lYspePW6J4VeixSGtpKsABsf7KSEOlmnqm7Y0T
 q9oGZ0ygOhcILIgB7ouVQ5uIZm6PA22ZgsltReCcCpfgg2p3TGxrD6xONOsW10s4Iv3K
 Pn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723814083; x=1724418883;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NO0yNECN+xfmp1Ew6nPth1TBvVMJWXurUgl6b+qxEiY=;
 b=BrpihK9fGhLmRBzuL9qC1ObOU+nGMZOodmJfZIKmeWQR46rtv7hHRDgrJn1PYlBWwq
 ydJNb7vMUcMdLF3ZBxWDnLS1XYhSVB26U0Nqwxd3I4noeCXKkMucFkRtQvTIq8y80gBr
 DdSI5cv9fkRdMyJtmHP8F9E6bBF6yoDt6is4iHmUNUMqzr3WLTCJJpg/RGfdI353RpjM
 AWxt2vLVoHiyfa1Gh47qquGl/D302/Ml4cgDyWBjZ+1Ez9LDTRhlc9bcgpaQxqa9qN0z
 adhF+aL4h39V8HOeOaKn/HmAUnw5cl8kV1yN3VdLGfE3kgie1DsZUXa2BHA/e6dfwrNL
 OkjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWajg9qvfdyrVONxpCwGykUSv1TQYQ6Hng8IilxdxmDepFrlhF/ygzK4/TMZDKgXNyruBnyrZuBLJTSPIUD7+jjLw0gRW0=
X-Gm-Message-State: AOJu0Yx7ze/lkdLlUX6l786gGJHuTpKs/as9zlCQpQFuQiHERlyeLbB7
 sKHsmbs0IQpdZeyWFsCNLv3s6Bn1QUWhRBN+mZZsxmZmKdmIEcT7B+ivzA==
X-Google-Smtp-Source: AGHT+IF0qtJ+9CX6ULHCp08LHeW1yCgYYgvjrvRADJ1pT8O7bGynF5Ry1KFEHB2b+Cgw6SFYe/jUPQ==
X-Received: by 2002:a05:6402:5108:b0:5bb:8ffd:24b9 with SMTP id
 4fb4d7f45d1cf-5beb38ba20fmr5249697a12.0.1723814082980; 
 Fri, 16 Aug 2024 06:14:42 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-145-177.77.13.pool.telefonica.de.
 [77.13.145.177]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbdfa240sm2252070a12.42.2024.08.16.06.14.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 06:14:42 -0700 (PDT)
Date: Fri, 16 Aug 2024 13:14:41 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, =?UTF-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: Re: [PATCH] hw/i386/pc: Warn about unsatisfied vmport deps
In-Reply-To: <vsm1ly2eX009LRKgURcMp6qTYHWw1bZd3zg2GUbd4M90T91QvJRdKxiRS3rPl8PR96y2r890Am3Ajf4kQrwihn7-7hKBU9VicRPPtIRv_GI=@szczek.dev>
References: <vsm1ly2eX009LRKgURcMp6qTYHWw1bZd3zg2GUbd4M90T91QvJRdKxiRS3rPl8PR96y2r890Am3Ajf4kQrwihn7-7hKBU9VicRPPtIRv_GI=@szczek.dev>
Message-ID: <0D723368-3251-4D5E-A625-73169CBE3395@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 14=2E August 2024 11:10:16 UTC schrieb "Kamil Szcz=C4=99k" <kamil@szcze=
k=2Edev>:
>Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add option
>to disable PS/2 mouse/keyboard'), the vmport will not be created unless
>the i8042 PS/2 controller is enabled=2E To not confuse users, let's add a
>warning if vmport was explicitly requested, but the i8042 controller is
>disabled=2E This also changes the behavior of vmport=3Dauto to take i8042
>controller availability into account=2E
>
>Signed-off-by: Kamil Szcz=C4=99k <kamil@szczek=2Edev>
>---
> hw/i386/pc=2Ec      | 4 ++++
> hw/i386/pc_piix=2Ec | 3 ++-
> hw/i386/pc_q35=2Ec  | 2 +-
> qemu-options=2Ehx   | 4 ++--
> 4 files changed, 9 insertions(+), 4 deletions(-)
>
>diff --git a/hw/i386/pc=2Ec b/hw/i386/pc=2Ec
>index c74931d577=2E=2E5bd8dd0350 100644
>--- a/hw/i386/pc=2Ec
>+++ b/hw/i386/pc=2Ec
>@@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bus, bool =
create_fdctrl,
>     }
>=20
>     if (!create_i8042) {
>+        if (!no_vmport) {
>+            warn_report("vmport requires the i8042 controller to be enab=
led");
>+        }
>+
>         return;
>     }
>=20
>diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>index d9e69243b4=2E=2Ecf2e2e3e30 100644
>--- a/hw/i386/pc_piix=2Ec
>+++ b/hw/i386/pc_piix=2Ec
>@@ -312,7 +312,8 @@ static void pc_init1(MachineState *machine, const cha=
r *pci_type)
>=20
>     assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
>     if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
>-        pcms->vmport =3D xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_O=
N;
>+        pcms->vmport =3D (xen_enabled() || !pcms->i8042_enabled)
>+            ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
>     }

I think it makes sense to consolidate this handling into pc_basic_devices_=
init() before doing this change=2E Maybe just in front of the call to pc_su=
perio_init()? The additional handling of xen_enabled() shouldn't hurt there=
 for q35: Even though q35 doesn't (yet) support Xen there are already code =
paths where this check is done=2E

>=20
>     /* init basic PC hardware */
>diff --git a/hw/i386/pc_q35=2Ec b/hw/i386/pc_q35=2Ec
>index 9d108b194e=2E=2E6c112d804d 100644
>--- a/hw/i386/pc_q35=2Ec
>+++ b/hw/i386/pc_q35=2Ec
>@@ -278,7 +278,7 @@ static void pc_q35_init(MachineState *machine)
>=20
>     assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
>     if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
>-        pcms->vmport =3D ON_OFF_AUTO_ON;
>+        pcms->vmport =3D pcms->i8042_enabled ? ON_OFF_AUTO_ON : ON_OFF_A=
UTO_OFF;
>     }
>=20
>     /* init basic PC hardware */
>diff --git a/qemu-options=2Ehx b/qemu-options=2Ehx
>index cee0da2014=2E=2E0bc780a669 100644
>--- a/qemu-options=2Ehx
>+++ b/qemu-options=2Ehx
>@@ -68,8 +68,8 @@ SRST
>=20
>     ``vmport=3Don|off|auto``
>         Enables emulation of VMWare IO port, for vmmouse etc=2E auto say=
s
>-        to select the value based on accel=2E For accel=3Dxen the defaul=
t is
>-        off otherwise the default is on=2E
>+        to select the value based on accel and i8042=2E For accel=3Dxen
>+        and/or i8042=3Doff the default is off otherwise the default is o=
n=2E

I'd do s#and/or#or# for readability=2E

Best regards,
Bernhard

>=20
>     ``dump-guest-core=3Don|off``
>         Include guest memory in a core dump=2E The default is on=2E

