Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1DCCD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsML6-0003PK-C7; Thu, 04 Apr 2024 08:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rsMKy-0003Om-9N
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rsMKw-0001H3-IY
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712234217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rj5NqBUC1iJimyzLIyV/0wK0XSb28iSIVwIZ5bLqPlI=;
 b=GmZ5vOxrenyogm8C9A2TMrmoPoyPdfWtz/ckm++CHrF+24C1XkMYjWWPFLLkFvaQdxPOed
 bz1dMbGIAhmr5ZDh15y2lLdipO9ugN1R9tt+SjTG2BUmj7CV7izrFaBfu7d8hX9jK6RQdV
 bM98XZhKPHo85QL964x6R/6EzOwzock=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-t4N5UbClPOCEVwdM43U8WA-1; Thu, 04 Apr 2024 08:36:55 -0400
X-MC-Unique: t4N5UbClPOCEVwdM43U8WA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1e27e4f7ccbso8433585ad.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712234215; x=1712839015;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rj5NqBUC1iJimyzLIyV/0wK0XSb28iSIVwIZ5bLqPlI=;
 b=XpPtOncmj6oTbWe6pxsknKAIr356DD/C0mInqNBAhYGilI6hUC3c4fFE/TbXI+oOVO
 5iwuNLSKSL2im35DxmFw4eQki+wc+ugeUcqf8+GCdB8ZsZB87gQXWl3D8E/AnRqjTFHF
 HYZbQqhqCVCfgDgWwOB0vc8HWA4RNLsK0LkcfIXG3XpdEjMmkDHjQ8l3e/DIz1NQeMbC
 w9OVQyQQ35iQPHk2EVCXHHhLbKEBS8yzxEfUJw+nLRUsoScb7CblkKrsH+zp4r7vcKxG
 pci5cq/IWKI6CgekqR5vOOAKQcQ1M6jsq6hK1XnvKA1dg7Av49kXv6j7MIEpGWK/B9Qk
 L7Gg==
X-Gm-Message-State: AOJu0YzeNfF/NecsW7X0Va0iMUU2bm+3mSz37lq1h1Hq7i9uxykPmyZZ
 gF0d1//O0ajJUpLsKeq5VsApgGSaY9eeL1iYcQ2JCWOJ1Yd0L5oEmoq6//4NukWo/Ss9nGx0uCj
 aKbsVJGd3vsdULbOKG7zH7wydXl6PGWkpcfnjrwu1F01uxJAyq6ht
X-Received: by 2002:a17:902:650d:b0:1e2:adce:9139 with SMTP id
 b13-20020a170902650d00b001e2adce9139mr1347408plk.44.1712234214848; 
 Thu, 04 Apr 2024 05:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbjLnc96anfsXsW0hKRv9LJ5PpRS2CLP1bnDCzIoY9mGzAfnO/ieYMBeaqk36wf0BY7QFP3A==
X-Received: by 2002:a17:902:650d:b0:1e2:adce:9139 with SMTP id
 b13-20020a170902650d00b001e2adce9139mr1347385plk.44.1712234214444; 
 Thu, 04 Apr 2024 05:36:54 -0700 (PDT)
Received: from smtpclient.apple ([115.110.236.142])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170902e9cc00b001e2bbc0a66fsm612879plk.234.2024.04.04.05.36.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Apr 2024 05:36:53 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v2 06/10] i386/pc_sysfw: Ensure sysfw flash configuration
 does not conflict with IGVM
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <613c3dc97a29fa9b8baa8acf45cefe4fac24ea87.1712141833.git.roy.hopkins@suse.com>
Date: Thu, 4 Apr 2024 18:06:37 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Berrange <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 =?utf-8?Q?J=C3=B6rg_Roedel?= <jroedel@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <54875E49-0710-4DD9-A6A6-79BEA4F09EFF@redhat.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
 <613c3dc97a29fa9b8baa8acf45cefe4fac24ea87.1712141833.git.roy.hopkins@suse.com>
To: Roy Hopkins <roy.hopkins@suse.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 3 Apr 2024, at 16:41, Roy Hopkins <roy.hopkins@suse.com> wrote:
>=20
> When using an IGVM file the configuration of the system firmware is
> defined by IGVM directives contained in the file. In this case the =
user
> should not configure any pflash devices.
>=20
> This commit skips initialization of the ROM mode when pflash0 is not =
set
> then checks to ensure no pflash devices have been configured when =
using
> IGVM, exiting with an error message if this is not the case.
>=20
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
> hw/i386/pc_sysfw.c | 23 +++++++++++++++++++++--
> 1 file changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 3efabbbab2..2412f26225 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -226,8 +226,13 @@ void pc_system_firmware_init(PCMachineState =
*pcms,
>     }
>=20
>     if (!pflash_blk[0]) {
> -        /* Machine property pflash0 not set, use ROM mode */
> -        x86_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory, =
false);
> +        /*
> +         * Machine property pflash0 not set, use ROM mode unless =
using IGVM,
> +         * in which case the firmware must be provided by the IGVM =
file.

What if the igvm file does not contain a firmware? Can we have a check =
for that case somewhere and assert if firmware is absent?

> +         */
> +        if (!cgs_is_igvm(MACHINE(pcms)->cgs)) {
> +            x86_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory, =
false);
> +        }
>     } else {
>         if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
>             /*
> @@ -243,6 +248,20 @@ void pc_system_firmware_init(PCMachineState =
*pcms,
>     }
>=20
>     pc_system_flash_cleanup_unused(pcms);
> +
> +    /*
> +     * The user should not have specified any pflash devices when =
using IGVM
> +     * to configure the guest.
> +     */
> +    if (cgs_is_igvm(MACHINE(pcms)->cgs)) {
> +        for (i =3D 0; i < ARRAY_SIZE(pcms->flash); i++) {
> +            if (pcms->flash[i]) {
> +                error_report("pflash devices cannot be configured =
when "
> +                             "using IGVM");
> +                exit(1);
> +            }
> +        }
> +    }

I have not tested this change but looking at pc_system_flash_create() =
creates flash[0] and flash[1] for all cases (well except for isapc =
machines). So for igvm case, would this not cause an exit all the time?

> }
>=20
> void x86_firmware_configure(void *ptr, int size)
> --=20
> 2.43.0
>=20


