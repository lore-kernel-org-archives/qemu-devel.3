Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE4BD5D683
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 19:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t983S-00043R-Eb; Thu, 07 Nov 2024 14:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1t983Q-000426-UF
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:20:28 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1t983O-0006zN-SV
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:20:28 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cefc36c5d4so1753092a12.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 11:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731007225; x=1731612025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7qB6cTr1EQKh/19ie9g+7eI+JmDWu3AdbjcYuZlOfI=;
 b=WwgjRaHhm/6VrN6t0DJRSO03UxhMxkANeiggijaEhlDw/HJaw8la6W5Nttvx+P5JN5
 ihFhbx4M01oggjNP4xM87S4L9OcjKsHbP92XXbEi8ONJffisHS8gJqn4pstT/oLEwFR0
 59lT3ziduQ8MQvAZWJXr1xZ837Zp2LTKnb7tTgCK+TGRdNxRUU6Lsvl35I4ceJrOiR9Y
 yyJwTkyvbH4EaLtBsnbb7wTl2/OkaHVoYpjDjvPp+6Oav/V0fUN7sS+w8kJSOMFGsTIo
 Rtm0HNdDUV3IqAHuuR5eRzJn59bthQqiKOCJ4gqTPXrM2+tRvoQZdHI9H6n4CrstvCT+
 Grgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731007225; x=1731612025;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7qB6cTr1EQKh/19ie9g+7eI+JmDWu3AdbjcYuZlOfI=;
 b=A/le7n9EksvMddbf0yiQiTDPcI1s5CzIkWwjlq17SRzxrK+4r4BGCl5A44xFJqnub0
 ED9k9OGnAJF/iEooOLj2B71MI8eIY5e6hbENHvywYopkBcRTCXKwLgCy1f8SF8aF4Byu
 xCIyUkwkHnlqqcsAgmg+ue8ShzdVVenrcwCFXcqS4JDr9csLnfbEw0DrWECTuSejj1rC
 b7uJWWqlwT7QWimLrD21KVgpXhbNGqERSanG2OGIZAcY8by4tvAcjCFaB66P0jaLoJTe
 sKWdTfULTIkiUiJgi6wRwasmOhFZ03WMpGyjkdR+oHapJtl9uov+B/QAe9aofHdjYphc
 geAQ==
X-Gm-Message-State: AOJu0Yy/+L/HUx9q8/+CW8Z7QXz//45lCXpu3qGzbf/5uWmaGdTZH+pQ
 p6srOe6nlmuEuhcE55GVbDgVOrD9/jLUr3aGn9rr7MhoRfIQE/8gMOlK4Q==
X-Google-Smtp-Source: AGHT+IF0lBYQnbixiDcdL+5rljH5UJJlSxU9QzRLBZvg+epJtuJlWLT7whjgxM2ErliGMo46iup/Rg==
X-Received: by 2002:a17:906:8415:b0:a9e:c940:d154 with SMTP id
 a640c23a62f3a-a9ec940d1ebmr541637366b.17.1731007224388; 
 Thu, 07 Nov 2024 11:20:24 -0800 (PST)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0abea92sm133616366b.85.2024.11.07.11.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 11:20:23 -0800 (PST)
Date: Thu, 07 Nov 2024 19:09:20 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Dmitry Frolov <frolov@swemel.ru>,
 pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>
CC: sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] hw/i386: fix NULL-dereference
In-Reply-To: <384458DB-F470-44E9-8C16-7D35DDDE4CBF@gmail.com>
References: <20241107070415.694662-2-frolov@swemel.ru>
 <384458DB-F470-44E9-8C16-7D35DDDE4CBF@gmail.com>
Message-ID: <5CFC2282-CD55-470A-AA65-C5299F26F1A4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 7=2E November 2024 09:19:05 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 7=2E November 2024 07:04:10 UTC schrieb Dmitry Frolov <frolov@swemel=
=2Eru>:
>>If pcmc->pci_enabled is false, pcms->pcibus is NULL and is passed
>>to pc_nic_init() where it is being dereferenced=2E
>>
>>Found making check with enabled sanitizers=2E
>>
>>Signed-off-by: Dmitry Frolov <frolov@swemel=2Eru>
>>---
>> hw/i386/pc_piix=2Ec | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>>diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>>index 2bf6865d40=2E=2E2a92d2dbb7 100644
>>--- a/hw/i386/pc_piix=2Ec
>>+++ b/hw/i386/pc_piix=2Ec
>>@@ -313,9 +313,9 @@ static void pc_init1(MachineState *machine, const ch=
ar *pci_type)
>>     /* init basic PC hardware */
>>     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
>>                          !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
>>-
>>-    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
>>-
>>+    if (pcmc->pci_enabled) {
>>+        pc_nic_init(pcmc, isa_bus, pcms->pcibus);
>>+    }
>
>Since pc_nic_init() is passed both an ISA and a PCI bus I think the NULL =
dereference should be fixed there=2E Moreover, if pc_nic_init() is only inv=
oked when there is a PCI bus, the "isapc" machine won't have a nic at all=
=2E
>
>How is this patch related to https://patchew=2Eorg/QEMU/20241105171813=2E=
3031969-1-peter=2Emaydell@linaro=2Eorg ? That is, do we need both patches t=
o really fix the issue?

I've had a closer look at the code and Peter's patch nails the problem=2E

Best regards,
Bernhard

>
>Best regards,
>Bernhard
>
>> #ifdef CONFIG_IDE_ISA
>>     if (!pcmc->pci_enabled) {
>>         DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];

