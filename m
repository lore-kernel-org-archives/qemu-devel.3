Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94441E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 11:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNVST-0006NL-DR; Tue, 17 Dec 2024 06:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tNVSR-0006N6-9g
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 06:09:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tNVSK-000449-Hd
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 06:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734433772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1USVNpCmV9VR9T7nvvlQqE6iRBC1YdGvqLr7JJ+NjQ=;
 b=fJlfmODoky8L+W8aNY7jNV9SQuzfuOAOG2ft9wyDWwoOEShh4Tj5BT1Fy+mws3MAvKzQoO
 g9OyxfhHmX6FviIDuoY2nCB0skYGdjgRiwAqf4t0PlGmfO3/JRe5nKnUM95Pp3gWdLkXA+
 yv8KGXcYqD3FwiMsuCPmqmt9Pe7RlLI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-UhXGZC_9OWeIFF2p2n-qTQ-1; Tue, 17 Dec 2024 06:09:30 -0500
X-MC-Unique: UhXGZC_9OWeIFF2p2n-qTQ-1
X-Mimecast-MFC-AGG-ID: UhXGZC_9OWeIFF2p2n-qTQ
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-216717543b7so80493865ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 03:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734433769; x=1735038569;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v1USVNpCmV9VR9T7nvvlQqE6iRBC1YdGvqLr7JJ+NjQ=;
 b=ghxIWZ+M5Km3BGgf0Zcvl18K4CSsI+F9wbpNHuDK812Jp9zVWCO4UuZHSOyH7+l/C1
 Fi5prqMIbl10Tn0bITDYYyAOXIKZH9RwnPI2lHHPnTFfgN44CXfmpoqIRV2adauzVzWS
 POfSZYFHgypBa0gaoVz6xGKsge27irCYIZUY6KYF3Fi1a2lzoNgxfD7qLl6+QCAxDI5G
 6DgazT5apuJZZOLcM+5Q3saLeKyPM+3PfKsgAfEjfo5J7cyMlEB/g6hk38Q3b1G3scuC
 RgIw0ltu0kg2kNjh/R4G6jcOqPncP//bmrIZm7GQNt8FOEYOVtT1jTvOUN4FB7MoHrPn
 vCNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy3mMKUTcX+HjwDbLboUEuD02igE4CbhUYNrKItmIZdXnZHSbmgQ+I8b5N7SkZ9nMLLabqHNHKSMZK@nongnu.org
X-Gm-Message-State: AOJu0Yx6mfW9zshqnWmJGOTNwhG9IJQaeOpd5MNO86PZVL0jetUe998O
 tJSnoTymdcVif1FAaArhV17vdO7EztOiBZmlAIr+87AXzwru21MPZ2eN3dx3p3dO5vUihuBkVmE
 9ZbzqYr4UTa/AYgY2f1unlimkvOk2uJ7Bdz3yui1Q91C/c/TbgvTL
X-Gm-Gg: ASbGnctOMi3x70nAMlywLjxoUWaB5TkSVHyWQNN0MUHWV9Jf8D4A8RhT9R4r6wDFl0B
 nfdO9REVcxsov+4HsEHKD1ggDO8ujM15MHtKqIU3eA+yKOG6+y9FUP8dug3CAJTzItIE6qrMVR4
 GYWfyEOHkoJf78fclPc+HCoLRzNDWOX6LsuLYyLsE87j0xdyvMf/y8hUEtm+lzTkJLEgpnaUF31
 5X/GkpPndmRfNPvn+iKVdqiG83MN0aHakxRvQMJObzxWzm8IxRfb51QpTNdlXkzfZwfV5oz
X-Received: by 2002:a17:902:db03:b0:216:3c36:69a7 with SMTP id
 d9443c01a7336-21892a417d3mr216418075ad.45.1734433769212; 
 Tue, 17 Dec 2024 03:09:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWd8Zl3XqPjc7MVbVH6NwR5CAGnFfFXd+QcI9KIDBbpKwAd5f0+eyCRxJbcrd6fjbBf70Rmg==
X-Received: by 2002:a17:902:db03:b0:216:3c36:69a7 with SMTP id
 d9443c01a7336-21892a417d3mr216417785ad.45.1734433768869; 
 Tue, 17 Dec 2024 03:09:28 -0800 (PST)
Received: from smtpclient.apple ([115.96.128.70])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1db7dcdsm57097005ad.3.2024.12.17.03.09.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Dec 2024 03:09:28 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <0d6d208a-00ee-47c9-8d47-bb5758133ecb@linaro.org>
Date: Tue, 17 Dec 2024 16:39:12 +0530
Cc: Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE6D8668-84D4-457E-994A-8066D52AD9B5@redhat.com>
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <26c97140-6ec5-49f5-b0d4-d4f7f82a12f0@linaro.org>
 <E18F7A48-BA4D-46B3-BD73-38322BF33CEC@redhat.com>
 <0d6d208a-00ee-47c9-8d47-bb5758133ecb@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



> On 17 Dec 2024, at 4:11=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 17/12/24 11:06, Ani Sinha wrote:
>>> On 16 Dec 2024, at 8:35=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>>>=20
>>> Hi Ani,
>>>=20
>>> On 16/12/24 12:48, Ani Sinha wrote:
>>>> VM firmware update is a mechanism where the virtual machines can =
use their
>>>> preferred and trusted firmware image in their execution environment =
without
>>>> having to depend on a untrusted party to provide the firmware =
bundle. This is
>>>> particularly useful for confidential virtual machines that are =
deployed in the
>>>> cloud where the tenant and the cloud provider are two different =
entities. In
>>>> this scenario, virtual machines can bring their own trusted =
firmware image
>>>> bundled as a part of their filesystem (using UKIs for example[1]) =
and then use
>>>> this hypervisor interface to update to their trusted firmware =
image. This also
>>>> allows the guests to have a consistent measurements on the firmware =
image.
>>>> This change introduces basic support for the fw-cfg based =
hypervisor interface
>>>> and the corresponding device. The change also includes the
>>>> specification document for this interface. The interface is made =
generic
>>>> enough so that guests are free to use their own ABI to pass =
required
>>>> information between initial and trusted execution contexts (where =
they are
>>>> running their own trusted firmware image) without the hypervisor =
getting
>>>> involved in between. In subsequent patches, we will introduce other =
minimal
>>>> changes on the hypervisor that are required to make the mechanism =
work.
>>>> [1] See systemd pull requests =
https://github.com/systemd/systemd/pull/35091
>>>> and https://github.com/systemd/systemd/pull/35281 for some =
discussions on
>>>> how we can bundle firmware image within an UKI.
>>>> CC: Alex Graf <graf@amazon.com>
>>>> CC: Paolo Bonzini <pbonzini@redhat.com>
>>>> CC: Gerd Hoffman <kraxel@redhat.com>
>>>> CC: Igor Mammedov <imammedo@redhat.com>
>>>> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>> ---
>>>>  MAINTAINERS                  |   9 ++
>>>>  docs/specs/index.rst         |   1 +
>>>>  docs/specs/vmfwupdate.rst    | 109 ++++++++++++++++++++++++
>>>>  hw/misc/meson.build          |   2 +
>>>>  hw/misc/vmfwupdate.c         | 157 =
+++++++++++++++++++++++++++++++++++
>>>>  include/hw/misc/vmfwupdate.h | 103 +++++++++++++++++++++++
>>>>  6 files changed, 381 insertions(+)
>>>>  create mode 100644 docs/specs/vmfwupdate.rst
>>>>  create mode 100644 hw/misc/vmfwupdate.c
>>>>  create mode 100644 include/hw/misc/vmfwupdate.h
>=20
>=20
>>>> +static void vmfwupdate_realize(DeviceState *dev, Error **errp)
>>>> +{
>>>> +    VMFwUpdateState *s =3D VMFWUPDATE(dev);
>>>> +    FWCfgState *fw_cfg =3D fw_cfg_find();
>>>> +
>>>> +    /* multiple devices are not supported */
>>>> +    if (!vmfwupdate_find()) {
>>>> +        error_setg(errp, "at most one %s device is permitted",
>>>> +                   TYPE_VMFWUPDATE);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /* fw_cfg with DMA support is necessary to support this device =
*/
>>>> +    if (!fw_cfg || !fw_cfg_dma_enabled(fw_cfg)) {
>>>> +        error_setg(errp, "%s device requires fw_cfg",
>>>> +                   TYPE_VMFWUPDATE);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    memset(&s->fw_blob, 0, sizeof(s->fw_blob));
>>>> +    memset(&s->opaque_blobs, 0, sizeof(s->opaque_blobs));
>>>> +
>>>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_OBLOB,
>>>> +                             NULL, NULL, s,
>>>> +                             &s->opaque_blobs,
>>>> +                             sizeof(s->opaque_blobs),
>>>> +                             false);
>>>> +
>>>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_FWBLOB,
>>>> +                             NULL, fw_blob_write, s,
>>>> +                             &s->fw_blob,
>>>> +                             sizeof(s->fw_blob),
>>>> +                             false);
>>>> +
>>>> +    /*
>>>> +     * Add global capability fw_cfg file. This will be used by the =
guest to
>>>> +     * check capability of the hypervisor.
>>>> +     */
>>>> +    s->capability =3D cpu_to_le16(CAP_VMFWUPD_MASK | =
VMFWUPDATE_CAP_EDKROM);
>>>> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_CAP,
>>>> +                    &s->capability, sizeof(s->capability));
>>>> +
>>>> +    s->plat_bios_size =3D get_max_fw_size(); /* for non-pc, this =
is 0 */
>>>> +    /* size of bios region for the platform - read only by the =
guest */
>>>> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_BIOS_SIZE,
>>>> +                    &s->plat_bios_size, =
sizeof(s->plat_bios_size));
>>>> +    /*
>>>> +     * add fw cfg control file to disable the hypervisor =
interface.
>>>> +     */
>>>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_CONTROL,
>>>> +                             NULL, NULL, s,
>>>> +                             &s->disable,
>>>> +                             sizeof(s->disable),
>>>> +                             false);
>>>> +    /*
>>>> +     * This device requires to register a global reset because it =
is
>>>> +     * not plugged to a bus (which, as its QOM parent, would reset =
it).
>>>> +     */
>>>> +    qemu_register_reset(fw_update_reset, dev);
>>>> +}
>>>> +
>>>> +static Property vmfwupdate_properties[] =3D {
>>>> +    DEFINE_PROP_UINT8("disable", VMFwUpdateState, disable, 0),
>>>> +    DEFINE_PROP_END_OF_LIST(),
>>>> +};
>>>> +
>>>> +static void vmfwupdate_device_class_init(ObjectClass *klass, void =
*data)
>>>> +{
>>>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>>>> +
>>>> +    /* we are not interested in migration - so no need to populate =
dc->vmsd */
>>>> +    dc->desc =3D "VM firmware blob update device";
>>>> +    dc->realize =3D vmfwupdate_realize;
>>>> +    dc->hotpluggable =3D false;
>>>> +    device_class_set_props(dc, vmfwupdate_properties);
>>>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>>=20
>>> How is this device instantiated?
>> Something like this:
>> $ ./qemu-system-x86_64 -device vmfwupdate
>> VNC server running on ::1:5900
>=20
> But this device is not marked as allowed to be created on the
> command line with:
>=20
>    dc->user_creatable =3D true;
>=20
> Am I missing something?

Isnt=E2=80=99 it true by default? See device_class_init(). Only when =
it=E2=80=99s a private device we need to set it explicitly to false.

Let me know if its me who is missing something :-)

>=20
>> And we can maybe add a basic test for this scenario:
>> $ ./qemu-system-x86_64 -device vmfwupdate -device vmfwupdate
>> qemu-system-x86_64: -device vmfwupdate: at most one vmfwupdate device =
is permitted
>> To exercise the fwcfg files, guest support is needed as I said above.



