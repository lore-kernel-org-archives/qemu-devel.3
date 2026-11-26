Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA41606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bKhsh6tH;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=R3jIj1Bs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWWSP-0000mE-0X; Thu, 26 Nov 2026 05:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1xWWSM-0000lK-OY
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:11:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1xWWSI-0005s1-JZ
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795687913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BSBLK/59u8t5ZRvmnGBbZeldFsRuhfP/8ytEO6Pigfg=;
 b=bKhsh6tHhf6zo/hkgDgRnLQJMoyUcvi1eE8i6wVVilgh1g5uY07DZGqCFxf8mc21jiBnmr
 KdHnzUWSDLZKTtP+aockhIhueTL8HBSrtXgJQ+0iOfhVjTUXy9G7dOJbPZ52zX3EKbbbxP
 aNIKvVe8Jdd2Hwt0egsd0fe4UrR7iWg=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-OHBiQJyEMoedqM1cHukGOQ-1; Thu, 26 Nov 2026 10:11:51 +0000
X-MC-Unique: OHBiQJyEMoedqM1cHukGOQ-1
X-Mimecast-MFC-AGG-ID: OHBiQJyEMoedqM1cHukGOQ_1795687910
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-386a65fca25so5951030eec.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 02:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795687910; x=1796292710; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BSBLK/59u8t5ZRvmnGBbZeldFsRuhfP/8ytEO6Pigfg=;
 b=R3jIj1Bs9gWRvO+WcgKJr01nf6Dwzme+gDvT3D97iFnoSV5+YYBK5fK+vYbpULc5zu
 wZZeR93q7FFFgUGO7nU33mHGrmwQlXM+XCyMK7L3G1lhgaGKYyKN4ce3J4iwTChVY/qS
 NDNa6aD8n95njI4F82WsP0T4uweGH0OqSqUopOFwL1/MSfNbr/64sUBp0CAv2uxMH9Fr
 AuxKGK4CabZB552iUWKW36S7CkVtc1oKvn3dB/ZaA5NSr5GzfNNoxabu0LhsAXr2ZsHT
 gLq2Tr1JC0fgv8/wcXoLUYQbcYeFWC2898NNBUQQMwRa0RWug9b/JcsQKNecwvongprm
 PnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795687910; x=1796292710;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BSBLK/59u8t5ZRvmnGBbZeldFsRuhfP/8ytEO6Pigfg=;
 b=EU7z/Wbj9MO2mYio7v3Q3akg8+CLGahONhKp1LbvLsXUVV18jysUEwTyoSt0gu5N0w
 DaZ58NOXjUwTA9IUFdzCRbJWA2hUNI4FMK6hcZtKXge2e06V6fGJMdkln/1OtBZQaK3B
 UPJ21OPhApwNyBZfwj4x6dzhoVQr7Fp6XKiKD+5q61D6GEaQtw8k2pJVM77WZSGazGa1
 0g5+i+MJYAZrhFlDwmerNNiVMoWqwi4SFDos8iVf92Fscn1jSbXzL46N5rpDDee9OzWX
 UTH7W8A6jfphJKc1uYlZWHO5SYiS2nwa/6KXfaV1uV1XsVPI01KXol0CU26CNl30Nojl
 MkGg==
X-Forwarded-Encrypted: i=1;
 AL+hErGtVvYgVOw/BNthOqSfGyGPdzaFXl2B+Cxpj3J656hpZGGEHG5i13+vyc4anI9nD5aLV4CPTIDnO/vj@nongnu.org
X-Gm-Message-State: APuU4Z9NWYkZOF6PZkN3dGLoLQPyXcs6jGCsat1zzSadxhhmcUO9m3nr
 4NXEvVInAhJ8Cy/YZLh8JYMBV8oDCrdc6zKNh6tlH07oh96h4fUG0soaZqMyA2eTMKkIuRdxeH9
 ndsz4iJMgAX6E/YJ25/Oc6MBaYvBBrj5MFpioknxau8Kq0e5cIIxkPPltwyreYDxu
X-Gm-Gg: AZFdTZdNvH0OP7GnpSAbHe7Xd0ORR0ujEGjHOefdiLuTT2Pp9RoeAtM28SPq9qWgNGf
 gSOmn5b1/6S93mkz3ZcKbUFq41iyq0/fs9xQ6LsUYdi2KAKWVXkcsihcJLju7trhJcr0rVoJMeg
 ToD8ZzMX2a7vCQRjmujleNd1IKPE2P6bFvlcW7bQtTRQChll+dICf4oEHuxrUMDaPSVv0wTbgXI
 UNzPIFxKC1jlwbE3sOmE7WJAkd9wszlkx/yMMshkRtU2HG3mz1m8zzo/T4rwMB7Asy2LiC72yTv
 pRkMaTGICOG6BAlCPzD1lEDtjmzxGjzuzwGkzGAqx8Ad6MxIRc3aDTgUwip4Zekl+iwS+gXEB+w
 d8BkmIzJEscfX+iitTKWDpWiWOGceh8jlaAvZezfHGSZl5WE6JIrqf9EwIh5VN67RT/ZdCL+QDf
 nt7pC9poGcooA69dpX6RW+28gp5uo=
X-Received: by 2002:a05:7300:1909:b0:383:f646:9feb with SMTP id
 5a478bee46e88-3856c4b8304mr30848308eec.2.1795687910155; 
 Thu, 26 Nov 2026 02:11:50 -0800 (PST)
X-Received: by 2002:a05:7300:1909:b0:383:f646:9feb with SMTP id
 5a478bee46e88-3856c4b8304mr30848243eec.2.1795687908991; 
 Thu, 26 Nov 2026 02:11:48 -0800 (PST)
Received: from smtpclient.apple ([106.219.133.110])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567cafec4sm69809979eec.26.2026.11.26.02.11.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Nov 2026 02:11:48 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.4\))
Subject: Re: [PATCH 1/1] qom: Really add 'confidential-guest-reset' feature
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <awf3FjPHmzBe4saL@redhat.com>
Date: Thu, 26 Nov 2026 15:41:34 +0530
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EEFC1078-69A0-4D4A-A0B7-6CADCFF19ECB@redhat.com>
References: <20261124154310.2569390-1-armbru@redhat.com>
 <20261124154310.2569390-2-armbru@redhat.com> <awf3FjPHmzBe4saL@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 26 Nov 2026, at 2:38=E2=80=AFPM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Tue, Nov 24, 2026 at 04:43:10PM +0100, Markus Armbruster wrote:
>> Commit a9b328611143 added feature 'confidential-guest-reset' to
>> SevCommonProperties and to TdxGuestProperties.  The commit message
>> states the intent as "control plane should be able to detect if the
>> hypervisor supports x86 confidential guest resets."
>>=20
>> Management applications ("control plane") would check whether the
>> relevant argument type of QMP command object-add has the feature.  =
The
>> relevant types are SevGuestProperties, SevSnpGuestProperties, and
>> TdxGuestProperties.
>>=20
>> Only TdxGuestProperties has the feature.  The other two have base =
type
>> SevCommonProperties, but a type only inherits its base's members, and
>> not its features or conditions.
>>=20
>> Fix by moving the feature from SevCommonProperties to
>> SevGuestProperties and SevSnpGuestProperties.
>>=20
>> Fixes: a9b328611143 ("qom: add 'confidential-guest-reset' property =
for x86 confidential vms")
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> qapi/qom.json | 24 +++++++++++++++---------
>> 1 file changed, 15 insertions(+), 9 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Acked-by: Ani Sinha <anisinha@redhat.com>

>=20
>=20
> I presume that we ultimately either want to fix the generator,
> or at least have it emit a warning if a feature is set on
> something that is used as a base struct, but obviously not
> for 11.2 freeze.
>=20
>>=20
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 32a59269361..b8237a94be0 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -1004,11 +1004,6 @@
>> #     only supported on SEV-ES and SEV-SNP guests
>> #     (default: false) (since 11.1)
>> #
>> -# Features:
>> -#
>> -# @confidential-guest-reset: If present, the hypervisor supports
>> -#     confidential guest resets (since 11.0).
>> -#
>> # Since: 9.1
>> ##
>> { 'struct': 'SevCommonProperties',
>> @@ -1016,8 +1011,7 @@
>>             '*cbitpos': 'uint32',
>>             'reduced-phys-bits': 'uint32',
>>             '*kernel-hashes': 'bool',
>> -            '*debug-swap': 'bool' },
>> -  'features': ['confidential-guest-reset']}
>> +            '*debug-swap': 'bool' } }
>>=20
>> ##
>> # @SevGuestProperties:
>> @@ -1042,6 +1036,11 @@
>> #    that require it.  If set to 'off', QEMU will require
>> #    KVM_SEV_INIT2 unconditionally.  (default: off) (since 9.1)
>> #
>> +# Features:
>> +#
>> +# @confidential-guest-reset: If present, the hypervisor supports
>> +#     confidential guest resets (since 11.0).
>> +#
>> # Since: 2.12
>> ##
>> { 'struct': 'SevGuestProperties',
>> @@ -1050,7 +1049,8 @@
>>             '*session-file': 'str',
>>             '*policy': 'uint32',
>>             '*handle': 'uint32',
>> -            '*legacy-vm-type': 'OnOffAuto' } }
>> +            '*legacy-vm-type': 'OnOffAuto' },
>> +  'features': [ 'confidential-guest-reset' ] }
>>=20
>> ##
>> # @SevSnpGuestProperties:
>> @@ -1101,6 +1101,11 @@
>> # @tsc-frequency: set secure TSC frequency.  Only valid if Secure TSC
>> #     is enabled (default: zero) (since 11.1)
>> #
>> +# Features:
>> +#
>> +# @confidential-guest-reset: If present, the hypervisor supports
>> +#     confidential guest resets (since 11.0).
>> +#
>> # Since: 9.1
>> ##
>> { 'struct': 'SevSnpGuestProperties',
>> @@ -1114,7 +1119,8 @@
>>             '*host-data': 'str',
>>             '*vcek-disabled': 'bool',
>>             '*secure-tsc': 'bool',
>> -            '*tsc-frequency': 'uint32' } }
>> +            '*tsc-frequency': 'uint32' },
>> +  'features': [ 'confidential-guest-reset' ] }
>>=20
>> ##
>> # @TdxGuestProperties:
>> --=20
>> 2.55.0
>>=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange =
:|
> |: https://libvirt.org          ~~          https://entangle-photo.org =
:|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com =
:|



