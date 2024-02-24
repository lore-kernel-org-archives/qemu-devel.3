Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED9FC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdscR-0008Ku-TR; Sat, 24 Feb 2024 09:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdscJ-0007z1-41
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 09:03:05 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdscH-0003di-4T
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 09:03:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412a071e7b3so19625e9.0
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 06:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708783377; x=1709388177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXIBmyws/qTI8KznVVclL9rm21o38u00OCMwMNsceNk=;
 b=iqlTkIucssXS9nBHc/15psxsR1+RFIeRczP/Z5isIeBVF6rw2jTox/MGTHue7hW8cy
 ywC38BknC1VfSfSoj3hKbR5aHkCiMeUcv0hOkBHYMWGWRYcM1HH9eKFXSE/AFKBwBlZY
 A7wPfkNOYbJDlNzTvU/ehnjAhXVpmt2lGHtlNAIAp7Y8L+GXsaSB3+PiVPIdfQ7P5pBk
 LwvQM9Znc2CgiYxCSC0Anb4oZtwap9t4FijjSqU/j3VBWvAD+ZymmYxAKIGNFlFcRIFg
 4XKJGJm+7y4LxspUZ7z9M6XEgx2qdosNOQmhS+M0D7e8dnIaqsUFbuv6vaihjnmgo5CO
 KUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708783377; x=1709388177;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXIBmyws/qTI8KznVVclL9rm21o38u00OCMwMNsceNk=;
 b=dBADRCqu2Wm87ujIGrvHbSuaEqvoCQqlyjtzG3jbAHtWTP/nBIGVWZvahYhK3CI6P5
 fypONUtlQEVov9KwvT51i25LmECU2+KOEECNWmSmLmCTKuTNNWBSANe37TilyqDxN59E
 xMAdVOALefRKZXjV9rXoZzmV2BpFcF81yqK9zl7jK+OwqT8lNqH3tQhhRvQI9okUWyqB
 IyjNeBy9kJpA9Zn/WJN2jyyUhJHGJwOXzz/XL51a8ppE3EfVfeo+zVrGrYhqpH3pJJoa
 BI3SRHF2Wgcn6mNa4X/R9J0jazQlycNZky5LoxcrFbZbEpSrYlQFZmREUIAHccWrbiZh
 QeOA==
X-Gm-Message-State: AOJu0Yz2eNwkV7JaZm9xpN8UVeJh4Wt+3MRLfKsbEUbGPW3oN3N/wwR3
 bupXq4JdYMEjf04aPpOTq857fJD79xjLawk0BMLO+v9X0KbSKHNx
X-Google-Smtp-Source: AGHT+IFilZNh4d59kht7c909wdCT4O3eFu30l7LOHcsljKLpjOAkN0wrc8Ru5pZsKaF7JQsl6zhx7A==
X-Received: by 2002:a5d:6187:0:b0:33d:26af:db44 with SMTP id
 j7-20020a5d6187000000b0033d26afdb44mr1584255wru.7.1708783377025; 
 Sat, 24 Feb 2024 06:02:57 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-012-138-060.89.12.pool.telefonica.de.
 [89.12.138.60]) by smtp.gmail.com with ESMTPSA id
 bv20-20020a0560001f1400b0033d73e1505bsm2268815wrb.18.2024.02.24.06.02.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 06:02:56 -0800 (PST)
Date: Sat, 24 Feb 2024 14:02:55 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 0/9] Simplify initialization of PC machines
In-Reply-To: <20240222102414-mutt-send-email-mst@kernel.org>
References: <20240208220349.4948-1-shentey@gmail.com>
 <20240222102414-mutt-send-email-mst@kernel.org>
Message-ID: <ABC6BC9E-8140-4165-AE96-BDA5B2CD0C7E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
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



Am 22=2E Februar 2024 15:25:01 UTC schrieb "Michael S=2E Tsirkin" <mst@red=
hat=2Ecom>:
>On Thu, Feb 08, 2024 at 11:03:40PM +0100, Bernhard Beschow wrote:
>> The series aims to simplify the initialization process of all PC-based =
machines=2E
>>=20
>> It consists of streamlining redundant code, as well as consolidating th=
e setup
>> of system flash and generation of smbios data which are currently fairl=
y
>> distributed=2E
>>=20
>> These changes are expected to make the code easier to understand and ma=
intain=2E
>>=20
>> Best regards,
>> Bernhard
>
>
>This looks good to me overall=2E
>
>Reviewed-by: Michael S=2E Tsirkin <mst@redhat=2Ecom>
>
>I see Philippe started queueing these, fine by me=2E

Thanks so far to all involved! I've just sent v2: https://lore=2Ekernel=2E=
org/qemu-devel/20240224135851=2E100361-1-shentey@gmail=2Ecom/

Best regars,
Bernhard

>
>> Bernhard Beschow (9):
>>   hw/i386/x86: Let ioapic_init_gsi() take parent as pointer
>>   hw/i386/pc_piix: Share pc_cmos_init() invocation between pc and isapc
>>     machines
>>   hw/i386/x86: Turn apic_xrupt_override into class attribute
>>   hw/i386/pc: Merge pc_guest_info_init() into pc_machine_initfn()
>>   hw/i386/pc: Defer smbios_set_defaults() to machine_done
>>   hw/i386/pc: Confine system flash handling to pc_sysfw
>>   hw/i386/pc_sysfw: Inline pc_system_flash_create() and remove it
>>   hw/i386/pc: Populate RTC attribute directly
>>   hw/i386/pc_{piix,q35}: Eliminate local pci_bus/pci_host variables
>>=20
>>  hw/i386/fw_cfg=2Eh      |  3 ++-
>>  include/hw/i386/pc=2Eh  |  5 ----
>>  include/hw/i386/x86=2Eh |  5 ++--
>>  hw/i386/acpi-common=2Ec |  3 ++-
>>  hw/i386/fw_cfg=2Ec      | 12 +++++++++-
>>  hw/i386/microvm=2Ec     |  2 +-
>>  hw/i386/pc=2Ec          | 25 +++++---------------
>>  hw/i386/pc_piix=2Ec     | 55 ++++++++++++++---------------------------=
--
>>  hw/i386/pc_q35=2Ec      | 38 ++++++++++--------------------
>>  hw/i386/pc_sysfw=2Ec    | 17 ++++---------
>>  hw/i386/x86=2Ec         |  7 +++---
>>  11 files changed, 62 insertions(+), 110 deletions(-)
>>=20
>> --=20
>> 2=2E43=2E0
>>=20
>

