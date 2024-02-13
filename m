Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030EAC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxs5-0001Fe-Hi; Tue, 13 Feb 2024 13:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rZxs4-0001FP-75
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:51:08 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rZxry-0005q7-FO
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:51:07 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a3122b70439so603436766b.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707850260; x=1708455060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FML2IM2Sn1X5GCHSPLzhYXVJzD26nUk2aLUCCKYr1/c=;
 b=LtJRpZokUy1bJbCly9ZAc1wtc4HLp63uQZpKK8PcmeUY+pjdLgyJyruw1Zv+OOATb8
 tX2vDuyX9cRmC9ThLJw3DU0K68ZYwS3uluoxSVWvm4RvoMoldOq9wdniUtluJK35oJgf
 yXF9sSbe64pbqwa6OxBN8K5EViQ8Ph5UMmYEMAz0F0YJy0U004mTNNjAIJDm6SoRTwFd
 ay4lfBRCDGSDxwjivVNAlKhJ1AffVSsqNs1BhQwSEzUyxuHObpHGBnon7JdHTcs250jY
 D+CBbMisG5yl3ick7jg7t7SppaeA6x/iEROakBcUCNudmLLd1PVXh2zWgil2QggAedEX
 VCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707850260; x=1708455060;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FML2IM2Sn1X5GCHSPLzhYXVJzD26nUk2aLUCCKYr1/c=;
 b=xCinISnPkge4jnTOnU3hURR+35bVM5Q5Rsop0HX1+vY60akKbsRcZSdgYdMRo/NS3J
 ezlDmILk7IwCWyabpGSFfQI5EK8G9BMwgqNDwFi8BA5wBhgFweFW5cv1GkhPXO8Votfw
 i5L8wyWlpy4K/sXt3xuPgqgFY4/p7AX1H3uuUWu7T6BVYW3Z+8txrLylBa5PhraDl4q/
 5Og2wIfmUMlsyNHQlSWNTsxMdCbMCflE9SE+2KL47ZUciZtJR0Tpr5uCeWXSJJw4l7L6
 SSgJhGHHeF5QxKFT93pmL+GIqyLAsnpbSZpSHaL0OCHQEMLu3orbyObrBhG4ZigwsMVm
 ChWA==
X-Gm-Message-State: AOJu0YyMLEhw4aILFpt93Dbq76gPqGnF0Fz/YoQQx3Dl3Iyo9GC/4m/v
 GBtD1Oklz+O0t1nW+Fqn+ZnSEFELj3QVpkPTuyY8X2zdiY0LbqN5zxu/xoEe
X-Google-Smtp-Source: AGHT+IGYl+VQUkASXZ6jjWnu3en2RCCwHR6dJYcKqRxPLFFaDjh5nxxkh5ezgRdD9E4bqta6gtLtlA==
X-Received: by 2002:a17:906:b28a:b0:a3c:a5d7:3689 with SMTP id
 q10-20020a170906b28a00b00a3ca5d73689mr166728ejz.1.1707850259686; 
 Tue, 13 Feb 2024 10:50:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUq+Mu8Pb0itnJNPgOSOhwJTYGYkBTCjBmG1FBDf0eyCmOsGrjW6o2McjuJDBrG2WI/FDV8B/Y6GK4L5nko/m6kEimy6AaEsJNYhN0QIt52DW9/6o8Hijrn7hsQ79C81k+IO6+lLicihp4thO2mviFD+TlnVumvk1PxKwmJKhyJyAaJFCJhfNXsH6cqDmLHGV50OvdQ/SSI0f3ErGrBmkI/ebQ=
Received: from [127.0.0.1] (dynamic-089-012-064-238.89.12.pool.telefonica.de.
 [89.12.64.238]) by smtp.gmail.com with ESMTPSA id
 vx1-20020a170907a78100b00a3d00afd63csm899190ejc.109.2024.02.13.10.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 10:50:59 -0800 (PST)
Date: Tue, 13 Feb 2024 18:50:59 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 0/9] Simplify initialization of PC machines
In-Reply-To: <20240208220349.4948-1-shentey@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
Message-ID: <CE777267-65A8-479C-ACB6-89F1BE92679F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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



Am 8=2E Februar 2024 22:03:40 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>The series aims to simplify the initialization process of all PC-based ma=
chines=2E
>
>
>
>It consists of streamlining redundant code, as well as consolidating the =
setup
>
>of system flash and generation of smbios data which are currently fairly
=
>
>distributed=2E
>
>
>
>These changes are expected to make the code easier to understand and main=
tain=2E
>
>
>
>Best regards,
>
>Bernhard
>
>
>
>Bernhard Beschow (9):
>
>  hw/i386/x86: Let ioapic_init_gsi() take parent as pointer
>
>  hw/i386/pc_piix: Share pc_cmos_init() invocation between pc and isapc
>
>    machines
>
>  hw/i386/x86: Turn apic_xrupt_override into class attribute
>
>  hw/i386/pc: Merge pc_guest_info_init() into pc_machine_initfn()
>
>  hw/i386/pc: Defer smbios_set_defaults() to machine_done
>
>  hw/i386/pc: Confine system flash handling to pc_sysfw
>
>  hw/i386/pc_sysfw: Inline pc_system_flash_create() and remove it
>
>  hw/i386/pc: Populate RTC attribute directly
>
>  hw/i386/pc_{piix,q35}: Eliminate local pci_bus/pci_host variables
>

Ping=2E Only patch 4 reviewed so far=2E

>
>
> hw/i386/fw_cfg=2Eh      |  3 ++-
>
> include/hw/i386/pc=2Eh  |  5 ----
>
> include/hw/i386/x86=2Eh |  5 ++--
>
> hw/i386/acpi-common=2Ec |  3 ++-
>
> hw/i386/fw_cfg=2Ec      | 12 +++++++++-
>
> hw/i386/microvm=2Ec     |  2 +-
>
> hw/i386/pc=2Ec          | 25 +++++---------------
>
> hw/i386/pc_piix=2Ec     | 55 ++++++++++++++-----------------------------=

>
> hw/i386/pc_q35=2Ec      | 38 ++++++++++--------------------
>
> hw/i386/pc_sysfw=2Ec    | 17 ++++---------
>
> hw/i386/x86=2Ec         |  7 +++---
>
> 11 files changed, 62 insertions(+), 110 deletions(-)
>
>
>
>-- >
>2=2E43=2E0
>
>
>

