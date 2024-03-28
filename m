Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A218C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpn6B-00004u-39; Thu, 28 Mar 2024 06:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rpn69-0008WI-12
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rpn67-0001c7-7e
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711622101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hphImIsA0s4buG5l01MW7G/SPKZQfWCu9YX2nN85oUM=;
 b=UrNwkDZVGPIDx4R1z7Wfon7LYvv12lMI3tYozWdCIgI2F1FdpWpJAGjiV5s8DD2sUXqQ8g
 BXaAORoagUzlZB1vvSMDBGZCjvzXgQG9jDOmKIGgPDsNlqkttE7/xBbUXxI6gi6k0KPd82
 mEw0IBnRMKS20K+mUgC9QIoNTf0p200=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-FADodefCNleb1tOnoa2ZEQ-1; Thu, 28 Mar 2024 06:35:00 -0400
X-MC-Unique: FADodefCNleb1tOnoa2ZEQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6e6bab4b84dso861571b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 03:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711622099; x=1712226899;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hphImIsA0s4buG5l01MW7G/SPKZQfWCu9YX2nN85oUM=;
 b=RWVbZgdD2Sr+e5IRAXXWE7RD+0K9GOoJlUmFdOb3omVR2gOnJ/MT+LTKUUeixHBEKM
 +YI4Vrd+32Y/6SNzQObMyQytjFtabnqV9Vb/HYpO92NaMLvGmEKs8f9ODlUvh9zKSNMI
 fS5Pc85Ron/kAIKg3SdOJj5lUhLawqv1d0wWn1M5fRad3pz4AE2ha7Ju2YsRxHzRarOM
 BWc+yUO+3NuJffU63oDlsFuenFNTFnREC33zqqG75YzeiqEdNBjA5feQnNeRW8j8Nnwc
 wVNCj6YaFyFbwFvpScWRqr7mAjPVEqAlCiXafus/dCTs9YL8+4TVZs+DarLxLej/OPYm
 a4NQ==
X-Gm-Message-State: AOJu0YzOj8b8FlUFBuoWfBgedrdTOF2F3RP5TIQFOiOJh2XFH5o41DRJ
 y5A1z/qo6sfIDkLF1rHrrj0tmA6HanmPIPUQqsJgURAliSuMq9kO8q9lq9M48lrQiX6zMJj7xct
 BjIzcplIj+9yaRAvAx45pVVHy6UbqtA8oZOt78MfAXoViwKLN3W7o
X-Received: by 2002:a05:6a20:438a:b0:1a5:6fde:8303 with SMTP id
 i10-20020a056a20438a00b001a56fde8303mr1086987pzl.38.1711622099063; 
 Thu, 28 Mar 2024 03:34:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy9YvqroMRMTtOWkaA7Mkw4dWFiMQVtR7EJe/Axh84nKHOqb6l/sfBreZ+rbUSltGWWA26cA==
X-Received: by 2002:a05:6a20:438a:b0:1a5:6fde:8303 with SMTP id
 i10-20020a056a20438a00b001a56fde8303mr1086968pzl.38.1711622098691; 
 Thu, 28 Mar 2024 03:34:58 -0700 (PDT)
Received: from smtpclient.apple ([203.212.246.97])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a17090301c200b001dcfbbb1ddesm1215999plh.7.2024.03.28.03.34.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Mar 2024 03:34:58 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 6/9] i386/pc: Skip initialization of system FW when using
 IGVM
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <da59863286f014444350d7ecc5523f32fd12138a.camel@suse.com>
Date: Thu, 28 Mar 2024 16:04:40 +0530
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
Message-Id: <61261DA6-1EDE-4DF8-88EC-C502BCD93332@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <63a4febd571701bb9f2f7511d71fc968ed9205ab.1709044754.git.roy.hopkins@suse.com>
 <11A81A35-2513-4433-8965-FE3AC5E0BF75@redhat.com>
 <da59863286f014444350d7ecc5523f32fd12138a.camel@suse.com>
To: Roy Hopkins <roy.hopkins@suse.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 27 Mar 2024, at 19:43, Roy Hopkins <roy.hopkins@suse.com> wrote:
>=20
> On Wed, 2024-03-27 at 18:58 +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 27 Feb 2024, at 20:20, Roy Hopkins <roy.hopkins@suse.com> wrote:
>>>=20
>>> When using an IGVM file the configuration of the system firmware is
>>> defined by IGVM directives contained in the file. Therefore the =
default
>>> system firmware should not be initialized when an IGVM file has been
>>> provided.
>>>=20
>>> This commit checks to see if an IGVM file has been provided and, if =
it
>>> has then the standard system firmware initialization is skipped and =
any
>>> prepared flash devices are cleaned up.
>>>=20
>>> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>>> ---
>>> hw/i386/pc.c | 12 ++++++++++--
>>> 1 file changed, 10 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index f8eb684a49..17bb211708 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -63,6 +63,7 @@
>>> #include "e820_memory_layout.h"
>>> #include "trace.h"
>>> #include CONFIG_DEVICES
>>> +#include "exec/confidential-guest-support.h"
>>>=20
>>> #ifdef CONFIG_XEN_EMU
>>> #include "hw/xen/xen-legacy-backend.h"
>>> @@ -1023,8 +1024,15 @@ void pc_memory_init(PCMachineState *pcms,
>>>         }
>>>     }
>>>=20
>>> -    /* Initialize PC system firmware */
>>> -    pc_system_firmware_init(pcms, rom_memory);
>>> +    /*
>>> +     * If this is a confidential guest configured using IGVM then =
the IGVM
>>> +     * configuration will include the system firmware. In this case =
do not
>>> +     * initialise PC system firmware.
>>> +     */
>>> +    if (!cgs_is_igvm(machine->cgs)) {
>>> +        /* Initialize PC system firmware */
>>> +        pc_system_firmware_init(pcms, rom_memory);
>>> +    }
>>=20
>> Ok so this makes QEMU mot load the default fw as provided in the QEMU =
command
>> line. It does not specify how the packaged fw specified within IGVM =
would be
>> processed and loaded. Am I understanding this right?
>> =20
> Yes. Although as suggested by Daniel, I've now changed this so if =
firmware is
> specified on the command line in conflict with the IGVM file then an =
error is
> displayed.

Does IGVM _must_ mandatorily contain a firmware? If not, then before =
error is displayed, we should check if the file does have a firmware.

> The IGVM file itself describes how the firmware binary is populated
> into guest memory and launched.

Ok so I looked at the doc here: =
https://docs.rs/igvm_defs/0.1.7/igvm_defs/
I do not see anything related to firmware in the spec.
Secondly, how the firmware is to be loaded is hypervisor specific. So =
there must be QEMU specific implementation to load the firmware from =
IGVM. Secondly, should a new directive (and associated definitions) be =
introduced that instructs hypervisors to load the firmware present in =
IGVM?
Something is missing here it seems and I am willing to dive into filling =
the missing parts.
=20

>=20


