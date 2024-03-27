Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E406CD11DD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpTKy-0001y2-Hp; Wed, 27 Mar 2024 09:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rpTKu-0001ob-HS
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rpTKs-0005s7-FR
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711546137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZi2BJv2kFGrXoGFjhlUGLg6ksRxJHtlYsrxZAdDmx8=;
 b=A1atbNOlt4il7wr2WkfCm8nJGFwvbu9M+tyO4O0r0U9QtmYBsGYFhWHOMcGLFs/NTWlPeC
 HfrYGV2b9DJ/JQs2XKwx7W2StGdvoYXbzXAf+csFgKJyZ3yqcdMYCh3t8mSfjQACmDu2AF
 aRF6ojmiRLOHba2VZr9Q9EI0DfloV2s=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-j-PJ3WI_N06PbFrPoMYlTw-1; Wed, 27 Mar 2024 09:28:55 -0400
X-MC-Unique: j-PJ3WI_N06PbFrPoMYlTw-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5a569d0f7a2so2939540eaf.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 06:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711546134; x=1712150934;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZi2BJv2kFGrXoGFjhlUGLg6ksRxJHtlYsrxZAdDmx8=;
 b=ARR0Fnf2KganWsBhANFfIo6E2Rft3wXqAM2faN3YW/LixblAsjWcXyFW+d0fuKLUwH
 hTX1IsCCaOIoEYdX3SHiRAZLJDVFvnuMqNzbQqvmvFE/EhAjtTaCQapHWCvY2DrqQANG
 VoJPr1CEjrPuoya2BPyFewrwlQFJgIj3cHtMOuWkPPy3TBKG3mR/+GkRC5dpgGwF7gEi
 QeiitfJU7/TlVXJxc9DyT+dLSO/meOwXHn55OIA+QaKn7JWybGy1Erb00PQf8Cm95JQz
 oIeAJS/s0n1cUVHG1v3nequI5LNSr3IFIyOfT81qQKXqvKoVJLjaydAx/pC1b2iUu9Q2
 KrDw==
X-Gm-Message-State: AOJu0YwH0RwqoZfaRErjU4+2ecNfETmDR3U7KOJ7Pnn71iv51yQmUKM3
 JMpxw6H9z1fEwU8vP79DPCEUmSmepYgir4lQr1rXJ4brDfXijxpBVpqaPWFpJGVt8SJZgNzhW4+
 42a2zPf8OQ5F2C0re1VAWGnBr5kKRg6d5GSQc1ai+SiXK7ABTveFP
X-Received: by 2002:a05:6358:99a7:b0:17f:4964:3e04 with SMTP id
 j39-20020a05635899a700b0017f49643e04mr4771890rwb.10.1711546134561; 
 Wed, 27 Mar 2024 06:28:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsHcTU/t3QRl+D6abp/6qkZqmWfqMpzEu3wYHOfGHgUiSMh6CLkk51BuNuPOW8MRUGUy72xw==
X-Received: by 2002:a05:6358:99a7:b0:17f:4964:3e04 with SMTP id
 j39-20020a05635899a700b0017f49643e04mr4771864rwb.10.1711546134197; 
 Wed, 27 Mar 2024 06:28:54 -0700 (PDT)
Received: from smtpclient.apple ([203.163.235.72])
 by smtp.gmail.com with ESMTPSA id
 c28-20020a630d1c000000b005ceeeea1816sm7718401pgl.77.2024.03.27.06.28.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Mar 2024 06:28:53 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 6/9] i386/pc: Skip initialization of system FW when using
 IGVM
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <63a4febd571701bb9f2f7511d71fc968ed9205ab.1709044754.git.roy.hopkins@suse.com>
Date: Wed, 27 Mar 2024 18:58:36 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 =?utf-8?Q?J=C3=B6rg_Roedel?= <jroedel@suse.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11A81A35-2513-4433-8965-FE3AC5E0BF75@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <63a4febd571701bb9f2f7511d71fc968ed9205ab.1709044754.git.roy.hopkins@suse.com>
To: Roy Hopkins <roy.hopkins@suse.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 27 Feb 2024, at 20:20, Roy Hopkins <roy.hopkins@suse.com> wrote:
>=20
> When using an IGVM file the configuration of the system firmware is
> defined by IGVM directives contained in the file. Therefore the =
default
> system firmware should not be initialized when an IGVM file has been
> provided.
>=20
> This commit checks to see if an IGVM file has been provided and, if it
> has then the standard system firmware initialization is skipped and =
any
> prepared flash devices are cleaned up.
>=20
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
> hw/i386/pc.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f8eb684a49..17bb211708 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -63,6 +63,7 @@
> #include "e820_memory_layout.h"
> #include "trace.h"
> #include CONFIG_DEVICES
> +#include "exec/confidential-guest-support.h"
>=20
> #ifdef CONFIG_XEN_EMU
> #include "hw/xen/xen-legacy-backend.h"
> @@ -1023,8 +1024,15 @@ void pc_memory_init(PCMachineState *pcms,
>         }
>     }
>=20
> -    /* Initialize PC system firmware */
> -    pc_system_firmware_init(pcms, rom_memory);
> +    /*
> +     * If this is a confidential guest configured using IGVM then the =
IGVM
> +     * configuration will include the system firmware. In this case =
do not
> +     * initialise PC system firmware.
> +     */
> +    if (!cgs_is_igvm(machine->cgs)) {
> +        /* Initialize PC system firmware */
> +        pc_system_firmware_init(pcms, rom_memory);
> +    }

Ok so this makes QEMU mot load the default fw as provided in the QEMU =
command line. It does not specify how the packaged fw specified within =
IGVM would be processed and loaded. Am I understanding this right?
=20


