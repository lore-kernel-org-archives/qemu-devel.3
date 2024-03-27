Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD11C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 21:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpaiG-0000FR-SO; Wed, 27 Mar 2024 17:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rpaiF-0000El-Gr; Wed, 27 Mar 2024 17:21:35 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rpaiD-0004dU-Hp; Wed, 27 Mar 2024 17:21:35 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-513e25afabaso223155e87.2; 
 Wed, 27 Mar 2024 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711574490; x=1712179290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JuSxJn1ijkFMnBjJ6Hb54upktV5uWoGDE3+zkgCVc8Y=;
 b=gGCIaBbOyD55eGmgcc2ISUlDQnrnVfL1Ptza8Ft+KHt1sPST5fKmbuPZCuB5DZF68b
 BxTLYm1rREG8Xcd0SK8kscNxPYOvrx/yBEL//lNtBaGI7CuS3456MJl7z/lFkUOaDzAb
 AYOYBZ2NcJJ5qwqD/rcK3ZBRx+oC2O2N17Cf2Caf7/knP+Vs7jiYBt66SkGAV1XZheXD
 61TbWBHzIwpM7YC5jyNcMOO3G1g/MbCeLtFxtbWBiZZPyr6R2EtdQ595oL7xiSrcrYI7
 xaxAg4fCxEK+lhzRJDWtcT8qW1EbGG49Um0jbUl6XCCLxMN7vaO/r4/aBLivOnHuU+xD
 /4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711574490; x=1712179290;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JuSxJn1ijkFMnBjJ6Hb54upktV5uWoGDE3+zkgCVc8Y=;
 b=IQHiHS/nTD/tudrIaJt1N055dQnErmYqjZu8bw8fSpF14iHBHVrJ7yhwumk2gXfVB3
 MBWMWs5pab7v+fxzUN9NiGiOrBnFSZPbqICc0Tz0OLcX+QMwpEvzajHft1OUiLT4Ag26
 y95BpPLzZoB/s2yO93TGlQD2v0o9PJsajIp8wbtROQFAsc7/5Cv4lVBeKeoe4nLVE2Ox
 TtltT0rQW53f0DaXZdYEp+4+PoZbBR0iFjxqiGDL3S/AIseLpn1454JLKGBu9VVk7flp
 VNMRE9TrvKmJ126r30t3NODSjuPxzDx2uCTIoYonkyBYCAWCKpLZgymZmO7i9jepj/by
 XaAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi1k5ZcGKaQREuKmOafP2ahvBuqc6dGL9VPGT0hD+rgwd9lbBVV7TTkzEncYtaqspIQ+sVnwTjJt7HqoTBcQDmK3sAPDkcgqmsdhGjKSp4F6u6S1aJzXw3+sBTKCqm
X-Gm-Message-State: AOJu0YwzXbs7PCBvZpEkT98mbK0SP36RckjFvaZ5vWeEtau2uEwOn0VD
 JPkV1blsohV0+IUpV5VJ8e6RoeQzyeNbqnHfvMaBbGtmmVTL8KIU
X-Google-Smtp-Source: AGHT+IHHkxgl24ZRYdzxqqFMiOV53K1Y9jUlb/OLvkqhf0DvjtmognATW0U7iJTPSSyFVFwHmKPRMA==
X-Received: by 2002:ac2:5f8e:0:b0:515:a5b1:1dd0 with SMTP id
 r14-20020ac25f8e000000b00515a5b11dd0mr372753lfe.55.1711574490191; 
 Wed, 27 Mar 2024 14:21:30 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-040-243.77.191.pool.telefonica.de.
 [77.191.40.243]) by smtp.gmail.com with ESMTPSA id
 wr8-20020a170907700800b00a474ba09387sm5072924ejb.22.2024.03.27.14.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 14:21:29 -0700 (PDT)
Date: Wed, 27 Mar 2024 20:47:19 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
CC: pbonzini@redhat.com, devel@lists.libvirt.org, richard.henderson@linaro.org,
 mst@redhat.com, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_for-9=2E0=5D_docs/about=3A_Mark?=
 =?US-ASCII?Q?_the_iaspc_machine_type_as_deprecated?=
In-Reply-To: <8dbba6ae-5910-4a62-9a08-a56e20dfb480@linaro.org>
References: <20240326125104.90103-1-imammedo@redhat.com>
 <a4a0bb13-d6a0-4665-810d-ecd9a9fb89b1@redhat.com>
 <8dbba6ae-5910-4a62-9a08-a56e20dfb480@linaro.org>
Message-ID: <5365A87A-C33D-40CC-9D9A-B908EBCB4FCF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 26=2E M=C3=A4rz 2024 13:29:58 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@linaro=2Eorg>:
>Hi Igor,
>
>On 26/3/24 14:08, Thomas Huth wrote:
>>=20
>> s/iaspc/isapc/ in the subject
>>=20
>> On 26/03/2024 13=2E51, Igor Mammedov wrote:
>>> ISAPC machine was introduced 25 years ago and it's a lot of time since
>>> such machine was around with real ISA only PC hardware practically def=
unct=2E
>>> Also it's slowly bit-rots (for example: I was able to boot RHEL6 on RH=
EL9 host
>>> in only TCG mode, while in KVM mode it hung in the middle of boot)
>
>I'm quite opposed to this patch=2E QEMU models various very-old /
>defunct hardware=2E I'm pretty sure Bernhard and myself are OK to
>keep maintaining it, besides we are working in separating it from
>the i440fx+piix machine=2E

Yes, I'd rather keep maintaining the isapc machine and separating it from =
the i440fx machine seems like a good idea to me=2E I'm confident that we ca=
n work out a way that allows for moving forward the pc-pci machines while k=
eeping the isapc machine from getting into the way too much=2E

Best regards,
Bernhard

> Also, this machine is particularly
>interesting for my single-binary experiments=2E
>
>Where I agree is we should stop reporting "KVM on ISA/PC machine"
>as supported=2E
>
>Regards,
>
>Phil=2E
>
>>> Rather than spending time on fixing 'the oldest' no longer tested mach=
ine type,
>>> deprecate it so we can clean up QEMU code from legacy fixups and hopef=
ully
>>> make it easier to follow=2E
>>>=20
>>> Folks who have to use ancient guest that requires ISAPC can still
>>> use older QEMU to play with it=2E
>>>=20
>>> Signed-off-by: Igor Mammedov <imammedo@redhat=2Ecom>
>>> ---
>>> =C2=A0 docs/about/deprecated=2Erst | 7 +++++++
>>> =C2=A0 hw/i386/pc_piix=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 1 +
>>> =C2=A0 2 files changed, 8 insertions(+)
>>>=20
>>> diff --git a/docs/about/deprecated=2Erst b/docs/about/deprecated=2Erst
>>> index 7b548519b5=2E=2E5708296991 100644
>>> --- a/docs/about/deprecated=2Erst
>>> +++ b/docs/about/deprecated=2Erst
>>> @@ -226,6 +226,13 @@ These old machine types are quite neglected nowad=
ays and thus might have
>>> =C2=A0 various pitfalls with regards to live migration=2E Use a newer =
machine type
>>> =C2=A0 instead=2E
>>> +``isapc`` (since 9=2E0)
>>> +'''''''''''''''''''''''''''''''''''''''''''''''''''''
>>> +
>>> +These old machine type are quite neglected nowadays and thus might ha=
ve
>>=20
>> "This old machine type is =2E=2E=2E" ?
>>=20
>>> +various pitfalls with regards to live migration=2E Use a newer machin=
e type
>>> +instead=2E
>>=20
>> I doubt that isapc could ever be used reliably for live migration, sinc=
e it's an unversioned machine type, so I think it would be better to not me=
ntion live migration here=2E
>>=20
>>  =C2=A0Thomas
>>=20
>>=20
>

