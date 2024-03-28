Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD0CC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 11:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpnY6-00063S-RV; Thu, 28 Mar 2024 07:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rpnY0-00062u-Ua
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 07:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rpnXx-0001C2-Pg
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 07:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711623826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gIgCGJ6D12D3aSd4GXTH1Bu+GUG5KR6nGa3qW22TQag=;
 b=c+YSy74cewPUnvrk6R4tbXiXrQX7XhWzw4Bkb8gA+FRFZ2msa/pbki9ZbYJjfFS8TBvOI3
 dIH452dLMA6A3Y+QPzx5Yk8QJFePjfaN05E63oIrrsmSV0bU0dxymCeAyQVSxhqw+PS1zo
 S0eR/ONwi9dK6E1rjkXTYOfHqKsiwWs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-UJq1qUj3NaWC4HN5c5J-TA-1; Thu, 28 Mar 2024 07:03:45 -0400
X-MC-Unique: UJq1qUj3NaWC4HN5c5J-TA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5d8dbe37d56so737320a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 04:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711623824; x=1712228624;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIgCGJ6D12D3aSd4GXTH1Bu+GUG5KR6nGa3qW22TQag=;
 b=qW9whoOBgdM5Khxi4zqs0YfrlNUgIkVlART/DVWMMtnYtVQwlxAqCOD0xcRTdmsykB
 6ySFRnwwbCljd1aQy3RjlVl7PaBTxqu8M8VnAlHcrH8T2sKf0+lBOKwwAbaMRWdMzicv
 19ugu7BNdwkihGhBJ1U+DWiWTq3SBiIKSRF6hAtOGx51rBTDlfT3awIWVWS30eDIeUc5
 /VCbS6tNumF5NHc/Qs0DhlddM3oOmSsDISYvVgO1yq6MVMhxHHqgrUWuTrmgBIzc7lbL
 4LPXZb2+r0ARTgWk54QfaHhNs6SID/rXOMT0X2gDIV1T+55Tqhgjw6adZ3x8P4obsYTl
 yzrQ==
X-Gm-Message-State: AOJu0YxHRylDFxcFmccGacLgB1y3sXd+8jBibUGR8fjoZVar5WgFi6xe
 W9lii8b4s/LbhKXXCUJDwrxfb14Vik+KQ1XyvEiL8OZq2pgchynhkzki6mgC0U9yW1daQTGs/JE
 gMfs6wvAYjIPDWqc8etpOpY29zrqnR0DHfu4Wzz8QJI5oRTDKpe3G
X-Received: by 2002:a17:902:b70e:b0:1e0:b709:139b with SMTP id
 d14-20020a170902b70e00b001e0b709139bmr1953176pls.56.1711623823239; 
 Thu, 28 Mar 2024 04:03:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENkCcBob2XDc0RdO72mMReUs+qkueUBuKn+K+B11RL/ZRUx4aDZcg8Qqrlg3S+Ka0t4fxx+A==
X-Received: by 2002:a17:902:b70e:b0:1e0:b709:139b with SMTP id
 d14-20020a170902b70e00b001e0b709139bmr1953152pls.56.1711623822799; 
 Thu, 28 Mar 2024 04:03:42 -0700 (PDT)
Received: from smtpclient.apple ([203.212.246.97])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a1709026b8900b001ddc0bc5934sm1265240plk.249.2024.03.28.04.03.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Mar 2024 04:03:42 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 6/9] i386/pc: Skip initialization of system FW when using
 IGVM
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <61261DA6-1EDE-4DF8-88EC-C502BCD93332@redhat.com>
Date: Thu, 28 Mar 2024 16:33:18 +0530
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
Message-Id: <BADA1987-4E50-407B-968A-4AE7A780F9CB@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <63a4febd571701bb9f2f7511d71fc968ed9205ab.1709044754.git.roy.hopkins@suse.com>
 <11A81A35-2513-4433-8965-FE3AC5E0BF75@redhat.com>
 <da59863286f014444350d7ecc5523f32fd12138a.camel@suse.com>
 <61261DA6-1EDE-4DF8-88EC-C502BCD93332@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
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



> On 28 Mar 2024, at 16:04, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 27 Mar 2024, at 19:43, Roy Hopkins <roy.hopkins@suse.com> wrote:
>>=20
>> On Wed, 2024-03-27 at 18:58 +0530, Ani Sinha wrote:
>>>=20
>>>=20
>>>> On 27 Feb 2024, at 20:20, Roy Hopkins <roy.hopkins@suse.com> wrote:
>>>>=20
>>>> When using an IGVM file the configuration of the system firmware is
>>>> defined by IGVM directives contained in the file. Therefore the =
default
>>>> system firmware should not be initialized when an IGVM file has =
been
>>>> provided.
>>>>=20
>>>> This commit checks to see if an IGVM file has been provided and, if =
it
>>>> has then the standard system firmware initialization is skipped and =
any
>>>> prepared flash devices are cleaned up.
>>>>=20
>>>> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>>>> ---
>>>> hw/i386/pc.c | 12 ++++++++++--
>>>> 1 file changed, 10 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>> index f8eb684a49..17bb211708 100644
>>>> --- a/hw/i386/pc.c
>>>> +++ b/hw/i386/pc.c
>>>> @@ -63,6 +63,7 @@
>>>> #include "e820_memory_layout.h"
>>>> #include "trace.h"
>>>> #include CONFIG_DEVICES
>>>> +#include "exec/confidential-guest-support.h"
>>>>=20
>>>> #ifdef CONFIG_XEN_EMU
>>>> #include "hw/xen/xen-legacy-backend.h"
>>>> @@ -1023,8 +1024,15 @@ void pc_memory_init(PCMachineState *pcms,
>>>>        }
>>>>    }
>>>>=20
>>>> -    /* Initialize PC system firmware */
>>>> -    pc_system_firmware_init(pcms, rom_memory);
>>>> +    /*
>>>> +     * If this is a confidential guest configured using IGVM then =
the IGVM
>>>> +     * configuration will include the system firmware. In this =
case do not
>>>> +     * initialise PC system firmware.
>>>> +     */
>>>> +    if (!cgs_is_igvm(machine->cgs)) {
>>>> +        /* Initialize PC system firmware */
>>>> +        pc_system_firmware_init(pcms, rom_memory);
>>>> +    }
>>>=20
>>> Ok so this makes QEMU mot load the default fw as provided in the =
QEMU command
>>> line. It does not specify how the packaged fw specified within IGVM =
would be
>>> processed and loaded. Am I understanding this right?
>>>=20
>> Yes. Although as suggested by Daniel, I've now changed this so if =
firmware is
>> specified on the command line in conflict with the IGVM file then an =
error is
>> displayed.
>=20
> Does IGVM _must_ mandatorily contain a firmware? If not, then before =
error is displayed, we should check if the file does have a firmware.
>=20
>> The IGVM file itself describes how the firmware binary is populated
>> into guest memory and launched.
>=20
> Ok so I looked at the doc here: =
https://docs.rs/igvm_defs/0.1.7/igvm_defs/
> I do not see anything related to firmware in the spec.
> Secondly, how the firmware is to be loaded is hypervisor specific. So =
there must be QEMU specific implementation to load the firmware from =
IGVM. Secondly, should a new directive (and associated definitions) be =
introduced that instructs hypervisors to load the firmware present in =
IGVM?
> Something is missing here it seems and I am willing to dive into =
filling the missing parts.

I guess what I was missing was =
https://github.com/roy-hopkins/buildigvm/blob/main/src/ovmf_firmware.rs =
.=20
Seems something like this is supposed to load ovmf image into memory.




