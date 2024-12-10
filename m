Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AA1E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 14:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL1T1-0001qR-FQ; Tue, 10 Dec 2024 09:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tL1T0-0001qI-Kb
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 09:44:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tL1Sy-0003lo-Vx
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 09:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733841839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/zzOTSfqUTmfALM/YBRcPueD1DnD5tW7Uz5MKR6Juc=;
 b=a6j8hsFydJq0CX9364R7zok0Z9MN2gVZitV1n5EcOcfJgCiAIF0F8cinNhEFRTLh5dk3HH
 ooxuYSuRhMwhASRraGxQjX/yjqEXdtzSdifnQ7nKh5ExBw5czEfnhdqckubG7qQfwNF90b
 8zhwA6fq2x6h+VGW//9HXLFjhC8KCYI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-IqO88-vWMKunTktU3oT8_w-1; Tue, 10 Dec 2024 09:43:56 -0500
X-MC-Unique: IqO88-vWMKunTktU3oT8_w-1
X-Mimecast-MFC-AGG-ID: IqO88-vWMKunTktU3oT8_w
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-72522df68a9so4795227b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 06:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733841835; x=1734446635;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J/zzOTSfqUTmfALM/YBRcPueD1DnD5tW7Uz5MKR6Juc=;
 b=CbEz4uCCgZUx6QA1fUsjM1tgl//TaCl5NO6CeZAPLMlBD0Wi30oJ+PknPAtLHWn5n7
 QVATkpNOHcWA6XQmJxi2tg3gmxSsBYCyG+yK8jPEfP6ld+pdDQB4DCFZCb5Kj5Fu1ahb
 LZbHMYYDzN+qJSSGUhXKXlSzkNjUUV/FC395J09DTKOQb+B8XATZON+zWeXAnYO9ucjy
 qBAlRkWsjpaX2rbPvbgKAHlCTyDDeYsYYfc7YWvoXGZYiNjVtJCdQNBxPMvhPvvTzzFd
 uJPt/WhCJExm0pDrSTMcwvSIgBOviigZ8e7HI958gsOrLUc5uQq27HpRDlqcSbJ3D+PR
 OkpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsXeiIzr+0/uuvlnJl7zjDk+kO4JD6/PfB19BztAVqVkrckpISRp5IhktoycEy+dNvD/7EenMFIuDs@nongnu.org
X-Gm-Message-State: AOJu0Ywbxu2cek6nREPIipMXyl19P7qiW7NRuVDm8t0Z8meFEjgM6v7D
 dHRwfUf5fBqa/XNtFBEuZ32D90vpxPOz5NtSq/Nh1LNDQNNSTfdC0BwoLdKpnVGkpTtMXX1E4nH
 q2VnLTIlv1ir91TPwsZr6cIKXlxsNpWXt0tt9ukmpq4Gs9nUWuRLm
X-Gm-Gg: ASbGnctFmdS9T1tAPJjt7yt4azEGFQeKIZ1ewwhwUJuACO1DPtnSjd31dhP4vOOZd3E
 9mSu4km4p2qP+OzoqEUpX28I++gEI4s1WJoREj1gr/OHaQuurOOyLWJdCIJRXzezMMske795x97
 SeZBLgHYadZ7L5QD2+qqfbSvCIEIVeq+TtH3eg2y/mCGQYIYoyAjjAtlHWJXSvmPV6WzcqMl/YD
 Bagt+H30SwTnXvAnN9+zzOi0AM1oDWHE3CGFzFWYIDHOlLPLvyYPKT5BiwUqzy+ZsTQ
X-Received: by 2002:a05:6a20:3d88:b0:1d9:6c9c:75ea with SMTP id
 adf61e73a8af0-1e1b1a74592mr7812627637.5.1733841835080; 
 Tue, 10 Dec 2024 06:43:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVbmrI5OQ4RakbT7Kge3/vgEOV2ZpZ1ioXuvby4qdefimaSrt8zY4nmmP31h6opZnVkoBYjA==
X-Received: by 2002:a05:6a20:3d88:b0:1d9:6c9c:75ea with SMTP id
 adf61e73a8af0-1e1b1a74592mr7812575637.5.1733841834707; 
 Tue, 10 Dec 2024 06:43:54 -0800 (PST)
Received: from smtpclient.apple ([115.96.26.49])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725cf9f681esm6077045b3a.98.2024.12.10.06.43.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Dec 2024 06:43:54 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] hw/i386/cpu: remove default_cpu_version and simplify
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <8FE9B724-4233-4D94-AC17-5D6B90F55D7C@redhat.com>
Date: Tue, 10 Dec 2024 20:13:38 +0530
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Tsirkin <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <891266A0-3863-48FA-9440-64EB9364E665@redhat.com>
References: <20241208064810.893451-1-anisinha@redhat.com>
 <Z1cIY357gcsE1IgJ@intel.com>
 <8FE9B724-4233-4D94-AC17-5D6B90F55D7C@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> On 9 Dec 2024, at 9:08=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 9 Dec 2024, at 8:40=E2=80=AFPM, Zhao Liu <zhao1.liu@intel.com> =
wrote:
>>=20
>> +Daniel,
>>=20
>> On Sun, Dec 08, 2024 at 12:18:10PM +0530, Ani Sinha wrote:
>>> Date: Sun,  8 Dec 2024 12:18:10 +0530
>>> From: Ani Sinha <anisinha@redhat.com>
>>> Subject: [PATCH] hw/i386/cpu: remove default_cpu_version and =
simplify
>>> X-Mailer: git-send-email 2.45.2
>>>=20
>>> commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be =
aliases")
>>> introduced 'default_cpu_version' for PCMachineClass. This created =
three
>>> categories of CPU models:
>>> - Most unversioned CPU models would use version 1 by default.
>>> - For machines 4.0.1 and older that do not support cpu model =
aliases, a
>>>  special default_cpu_version value of CPU_VERSION_LEGACY is used.
>>> - It was thought that future machines would use the latest value of =
cpu
>>>  versions corresponding to default_cpu_version value of
>>>  CPU_VERSION_LATEST [1].
>>>=20
>>> Unfortunately, all pc machines still use the default cpu version of =
1 for
>>> unversioned cpu models. Only microvms use CPU_VERSION_LATEST.
>>=20
>> Hi Ani,
>>=20
>> So could we use CPU_VERSION_LATEST for other machines now?
>>=20
>> Mapping unversioned cpu models to the latest version sounds like more
>> user friendly.
>=20
> Note that even though that was the intention when default_cpu_version =
was introduced, it was never done that way. We have been using cpu =
version 1 for a long time.

Had a conversation with Igor offline. CPU_VERSION_LATEST does not work =
since it=E2=80=99s a moving target. Therefore for a specific machine, =
what version of cpu model will be chosen will depend on what is latest =
and this will change with time. It can break guests that stick to a =
single cpu model.

One way to fix this would be to keep a fixed mapping between cpu model =
and machine versions. However, it will be a nightmare to maintain such =
mappings.

>=20
>>=20
>> Regards,
>> Zhao
>>=20
>>> This change cleans up the complicated logic around =
default_cpu_version
>>> including getting rid of default_cpu_version property itself. A =
couple of new
>>> flags are introduced, one for the legacy model for machines 4.0.1 =
and older
>>> and other for microvms. For older machines, a new pc machine =
property is
>>> introduced that separates pc machine versions 4.0.1 and older from =
the newer
>>> machines. 4.0.1 and older machines are scheduled to be deleted =
towards
>>> end of 2025 since they would be 6 years old by then. At that time, =
we can
>>> remove all logic around legacy cpus. Microvms are the only machines =
that
>>> continue to use the latest cpu version. If this changes later, we =
can
>>> remove all logic around x86_cpu_model_last_version(). Default cpu =
version
>>> for unversioned cpu models is hardcoded to the value 1 and applies
>>> unconditionally for all pc machine types of version 4.1 and above.
>>>=20
>>> This change also removes all complications around CPU_VERSION_AUTO
>>> including removal of the value itself.
>>>=20
>>> 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
>>>=20
>>> CC: imammedo@redhat.com
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>



