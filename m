Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2C9D5AE75
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 09:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ywH-0002ER-VR; Thu, 07 Nov 2024 04:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1t8ywG-0002EC-7m
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:36:28 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1t8ywE-0001X2-JV
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:36:28 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a16b310f5so111890866b.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 01:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730972185; x=1731576985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZvG6aBkbWZ+bnVNroE61Td4iPH6vg6y6QxprlX6zVc=;
 b=doouQ9Szm75kO7jn2lzu/njy6VsDYy231AivLYpGWn0pBiD6wguQd2mcXNR4XgxF+G
 MSRKxl3ZEuc9Htuuqp7oc4YDAYrTxVpJz1fwdGd7jmRr2rIcJqN/tHzAWLDGqwjobgq8
 O+zEn/fxSH7o+xVmebhku0fNEZkWS2bWYApZTBIYrMuACOA35oL/Ju9KQrnQ8w/zoCkE
 rjfoLMAu4AALBIuzVbHsuolU/54tDzOBKH96E+sABN3NsGcCLxD4FUOj9CwSGLcT+L+v
 NX+xum7fVdsb6ES31TUdhHaqE7IyJjd3BPW+tVw7plgRe25ao04ckFiOS08OSkvaAVdv
 11Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730972185; x=1731576985;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZvG6aBkbWZ+bnVNroE61Td4iPH6vg6y6QxprlX6zVc=;
 b=YknXOco4QHOyvbZmX1AKktK2mfHdjLBRj3j2we6DJ67ckK12p86HesvZzgT02r9kLB
 ha+HexhI2dOQNpNMPx3JaF9PdUWHHX4OuFMavxgD0jkGkUxVmhMbQiSNixs1+Xxb13r+
 rX2iZxdPFiSbP7bjUJs8gBArUGk6Dxpik9N5sIHMs6meA/bvHTlELHkmTe98FIMJjhpQ
 S2cjEl6i4fVyVRUbRc3/26xMjAJWQcjOAvbMITb/4G0vAGGGpUjQg98HCcmXn/O9ygUJ
 sXZi9siqK+0c5rZXG5Np/+5fgsNcFaenZKJamRSwePiEK3uQdbOhP6/EvGblPAH0umnj
 Vwtg==
X-Gm-Message-State: AOJu0YxTpoaT+BaXA7lGsh0IDEoxye7QjBWFQ15Stss87cLtfu/4iDow
 B2heOOQHYbWoaMit1GLf/+xGVUUvhWpkWGXdjfTQXknHa6M6TQx2BHYY4w==
X-Google-Smtp-Source: AGHT+IHg40u48Ji4R1SfrhQGkG1ebsdKyq7wG86C+iBMI257dg04GkxwJJLzuihZ+2/+rDKbRjvdRw==
X-Received: by 2002:a17:907:1c11:b0:a9a:c57f:9666 with SMTP id
 a640c23a62f3a-a9ee7479893mr29225566b.2.1730972184375; 
 Thu, 07 Nov 2024 01:36:24 -0800 (PST)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0dedc3dsm66756066b.133.2024.11.07.01.36.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 01:36:23 -0800 (PST)
Date: Thu, 07 Nov 2024 09:19:05 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Dmitry Frolov <frolov@swemel.ru>,
 pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>
CC: sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] hw/i386: fix NULL-dereference
In-Reply-To: <20241107070415.694662-2-frolov@swemel.ru>
References: <20241107070415.694662-2-frolov@swemel.ru>
Message-ID: <384458DB-F470-44E9-8C16-7D35DDDE4CBF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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



Am 7=2E November 2024 07:04:10 UTC schrieb Dmitry Frolov <frolov@swemel=2E=
ru>:
>If pcmc->pci_enabled is false, pcms->pcibus is NULL and is passed
>to pc_nic_init() where it is being dereferenced=2E
>
>Found making check with enabled sanitizers=2E
>
>Signed-off-by: Dmitry Frolov <frolov@swemel=2Eru>
>---
> hw/i386/pc_piix=2Ec | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>index 2bf6865d40=2E=2E2a92d2dbb7 100644
>--- a/hw/i386/pc_piix=2Ec
>+++ b/hw/i386/pc_piix=2Ec
>@@ -313,9 +313,9 @@ static void pc_init1(MachineState *machine, const cha=
r *pci_type)
>     /* init basic PC hardware */
>     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
>                          !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
>-
>-    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
>-
>+    if (pcmc->pci_enabled) {
>+        pc_nic_init(pcmc, isa_bus, pcms->pcibus);
>+    }

Since pc_nic_init() is passed both an ISA and a PCI bus I think the NULL d=
ereference should be fixed there=2E Moreover, if pc_nic_init() is only invo=
ked when there is a PCI bus, the "isapc" machine won't have a nic at all=2E

How is this patch related to https://patchew=2Eorg/QEMU/20241105171813=2E3=
031969-1-peter=2Emaydell@linaro=2Eorg ? That is, do we need both patches to=
 really fix the issue?

Best regards,
Bernhard

> #ifdef CONFIG_IDE_ISA
>     if (!pcmc->pci_enabled) {
>         DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];

