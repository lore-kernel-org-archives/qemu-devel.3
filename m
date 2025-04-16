Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5030FC369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 11:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u518f-0005f6-RV; Wed, 16 Apr 2025 07:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1u518Y-0005eH-2b
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 07:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1u518U-0004VV-0m
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 07:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744803654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DXJ2pt7eitHbqmc0kh3gKx0j0XhdqtHFJwd0xzBdTo=;
 b=H/0DEHFQN+1FYsMs0vh37mDPW5F4NygJo1uZtMcPfz0A+ESPuunPW/REKXAl3S9B6R+vYK
 ql2ZgO6fIYSy8zFK7mlljSsNMfqSWJDk4hU+tHtiamBPTWWWAIPn3B1W9OE59KyFETYbCe
 tOtg+94i3GzU0DxDEkEkhlaIUO4vsGc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-smp6hEZfOqawp673YTq1iQ-1; Wed, 16 Apr 2025 07:40:51 -0400
X-MC-Unique: smp6hEZfOqawp673YTq1iQ-1
X-Mimecast-MFC-AGG-ID: smp6hEZfOqawp673YTq1iQ_1744803650
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2254e500a73so48269275ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 04:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744803650; x=1745408450;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5DXJ2pt7eitHbqmc0kh3gKx0j0XhdqtHFJwd0xzBdTo=;
 b=RQI0GBcm4ZIeianasdwcEqTIVXvhlHNX1syLJGB9R1ym23UvUheymlENPy0M0Us0gk
 6/qfiSEkUMHYDfkSnIs+sYFw9LRmuTvOwHndYgy24MyLsPanyhcwvHoJCIzj470Fg42V
 CyiiSWDvaHonPfk11fHK6fCxLxeii1sRfZEwjPf+3/nw6ITqLYjY1ALR5R7XvpY4/kbs
 LSWbOLj8DIe9KaGG5XMwlHk8mUEkEcCDHJHx4o1ZFnag/hq3fUgLjjbDG0joa2nFv3E3
 IaHqpmX/fGPJyrlbZYKZmlLsaND9jeQ9NRL1huDJcp4rm7/vmJm0BocjDOrEFHsH2Hza
 f1yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRfrVh4extNkBaY9mm5WQQapUtYVn+BRcc1V2kIeZtpH/QOg7+TbInBCL9Yt91nXLOJgP2sHUhUft9@nongnu.org
X-Gm-Message-State: AOJu0Yw2AnPeTniMZ8Y46lh/P3OCofl6FG0WBp9OyCWhlZeBRav+EgMb
 s5hZV421P/HKh/3kgQgiGb3HIPo8VB5JSRR+ZSFFZ7oTLdmZnC/3r1xDjfCcS5ihgEh+4bY/Y6z
 hr97RB5w711DW6vjLvllclMebniJIq/wXwABotVRisBfGxgxi3h2V
X-Gm-Gg: ASbGncvhy0DJzVYQwEm1pxITfGl/In4f+RI28Gw1g4511XpHJ9pWhsS7Zkz2gf2Ya72
 52xUF/hktarZBJnN/Tog/RNKGJYgsSS5Bd87Yz6sqMVtSonUdSBeTjzkbPPD8G+donKIyYVTNmh
 3ofXV+jxeL8b6nO2oD46r3N9m2ceISwqK+rwCnpwsOqJ9YzgMe89r9MJ79pbdi4wNbRfK1/5F7g
 UXEPBTlN6xFhbO8DZvl0ZMc7XOcvLUB2c47E3+1WLzyNkBtcmGw1MukR1MbgQeQPQY/fv/7z4lN
 PnC5s1P1kl7HmPpXL/8SrjILY30Y
X-Received: by 2002:a17:902:e74f:b0:224:1074:63af with SMTP id
 d9443c01a7336-22c3597f325mr25061685ad.34.1744803650462; 
 Wed, 16 Apr 2025 04:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNdOMozd8lc1b/0mkcikptC9gVKS3XVUxtkG0p1ZmhLJ8hrMu6Dk9RRs/D5iJK8Oy5kYCi7Q==
X-Received: by 2002:a17:902:e74f:b0:224:1074:63af with SMTP id
 d9443c01a7336-22c3597f325mr25061325ad.34.1744803650137; 
 Wed, 16 Apr 2025 04:40:50 -0700 (PDT)
Received: from smtpclient.apple ([116.72.131.168])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fa5e9esm11651035ad.132.2025.04.16.04.40.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Apr 2025 04:40:49 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ttp3fs5hpxj52lnp32khyskt56tokgt6msqwqn3xkw7z4k5yhk@cw7zgrogplqy>
Date: Wed, 16 Apr 2025 17:10:31 +0530
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>,
 Alexander Graf <graf@amazon.com>,
 =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tsirkin <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <762278F7-ED1C-48F8-B4D9-B7B5B8693D55@redhat.com>
References: <kmqzqeaatk3iyrpl4tvfxtfv6gefyusxpyxtz5bollw7jlp3wk@5c4zawrzehwq>
 <d79cff63-324f-4624-aef3-b6570cdb23e2@amazon.com>
 <rtbmlitus6unzibiatblquot2bthx4dmozbxgcbovisial6qar@konful7gzrsz>
 <6d815066-9977-4683-a2d5-871dda3e5369@amazon.com>
 <fwdk2pc4rfa5o22gdfqq4cfsqged4v6hmlrtqdwltgqj2bkpl4@bicazjx5d22l>
 <CAAH4kHZhEX0kaE3r5PVOOWh1PhzZNOfyWMixDm0PbCnjfmZceA@mail.gmail.com>
 <xjdm7m65w6hmnq3ik2psbfhizypk76c3hdriujh27kcm7ex5tv@7lq3x3k7y52h>
 <CAAH4kHbFBekcmxBQcOA9K1Y+sFc2Jf56YEa4iv0M88ib7pCjgg@mail.gmail.com>
 <aex5mpxcyybat5joqgvx4ssall53ksrfz3kkkpveso3jjosi4v@bofv3pqsgim4>
 <2A385A2F-EB29-4573-8458-C5762792DC96@redhat.com>
 <ttp3fs5hpxj52lnp32khyskt56tokgt6msqwqn3xkw7z4k5yhk@cw7zgrogplqy>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.2)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 10 Apr 2025, at 4:14=E2=80=AFPM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>=20
> On Thu, Apr 10, 2025 at 12:01:18PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 9 Apr 2025, at 11:51=E2=80=AFAM, Gerd Hoffman <kraxel@redhat.com> =
wrote:
>>>=20
>>> Hi,
>>>=20
>>>>> The chicken-and-egg problem arises if you go for hashing and want =
embed
>>>>> the igvm file in the UKI.
>>>>=20
>>>> I don't really see how signing the IGVM file for secure boot helps =
anything.
>>>=20
>>> It doesn't help indeed.  This comes from the original idea by Alex =
to
>>> simply add a firmware image to the UKI.  In that case the firmware =
is
>>> covered by the signature / hash, even though it is not needed.  =
Quite
>>> the contrary, it complicates things when we want ship db/dbx in the
>>> firmware image.
>>>=20
>>> So most likely the firmware will not be part of the main UKI.  =
Options
>>> for alternatives are using UKI add-ons,
>>=20
>> But add-ons are also subjected to signature verification. How does =
not using the main UKI help?
>=20
> For the first boot using secure boot doesn't help much, the trust
> in the firmware being loaded for the second boot is established via
> launch measurement not secure boot signature.
>=20
> For the second boot (with new firmware) you don't need the add-on any
> more.
>=20
> The main advantage of wrapping the igvm into a uki add-on is that we
> can easily use the hwid matching support of systemd-stub when =
packaging
> multiple firmware variants (aws, azure, gcp, qemu, ...).  Not sure =
this
> will actually matter in practice though.

This makes sense.


