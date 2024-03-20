Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8103C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmx7j-0001UK-VF; Wed, 20 Mar 2024 10:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rmx7j-0001U7-1i
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:40:59 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rmx7g-0002a0-Sw
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:40:58 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a46a7208eedso597905366b.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710945654; x=1711550454; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BA87UHMpJCU3it6xmqB2aRBLt+569eM2KabPuAjgpZY=;
 b=dV83W60HxEGdxS5xvaIoRZa5o1gBE8Pu5xt9ouR5sRz4LDLq/XMTT2/0OOVuATFXIG
 VWH3HcDhc8qXQHepn12PFx8epIpFcZZ6kkFQ2T02VSCDMcPoOLqU7hlRjjboS8IhtBXz
 b3SzHp222zcOybVhtp/efwtt+qyu1/c3Xk4Z7MIH9kH4KdW6W3hpnZF89EUq+JqDGWzO
 TH52kLKq4PApooJfmVkHTm4jcRP+DNyTYixcVwCoDy17wNfTds/7NHquBlIIi/WIsjkz
 7VWFPweWnAAAR1wIsfSb6D4ebN4WPgDErmjySBbhDAc2VbSqCqjVYhJy4YNHNHgi1BME
 tuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710945654; x=1711550454;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BA87UHMpJCU3it6xmqB2aRBLt+569eM2KabPuAjgpZY=;
 b=jcB4op9vEz66LEXjZPqypwc0WsIfaOpm5RhkU0Ljqa2/Lr18TmLPUyMXImHKcSqYy+
 35Ts988pxo66FNc7/YfpUT27qqO+4CArfLwO/laR2gjOFoehmg+7+dQxPJNoAYYPVjzI
 mJSzr/h/ROCeG7LcotYoOlkNJzANx7eaCOdlPNjaP0eU/3Z+yRrbT7iEwuXyUJNPkG5/
 HufKdSp4JvIT4C8Ilkvs2emowiKrG+5XJC1LRewwf4pOfeDb4LxT/N9X0Z67hNfto3BD
 M3L14x9IJHTmbVrI12RK+6IzpGHfAub4ZjuO+pfjQzTVEPQtydEFajQHnRuOo+6qp6Mn
 zVqQ==
X-Gm-Message-State: AOJu0YxxVfhwrurNsqOJs4EUyB3TbLobL0nAxKGEeQ8w0fqlWWoWokR8
 BFFRKP7yhQNqZZt3X6BvnJBgk2Ynqo2jL5IgND8OI3cA212k+YkLyJSNvq/R1sU=
X-Google-Smtp-Source: AGHT+IEklrjTZ4FWb1/pLhSQdoxdo6QGbbovdd/gs3anL/LOlCtmAaw0FrvrHCB6Lw/Cu51D9KGCow==
X-Received: by 2002:a17:906:cb98:b0:a46:9a59:d97c with SMTP id
 mf24-20020a170906cb9800b00a469a59d97cmr9024900ejb.60.1710945653745; 
 Wed, 20 Mar 2024 07:40:53 -0700 (PDT)
Received: from [192.168.7.120]
 (cpc81487-lanc8-2-0-cust139.3-3.cable.virginm.net. [81.110.179.140])
 by smtp.gmail.com with ESMTPSA id
 sd9-20020a170906ce2900b00a4628cacad4sm7354990ejb.195.2024.03.20.07.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:40:53 -0700 (PDT)
Message-ID: <7f9e20cf2aae8a7e86fbd252a319404799e91542.camel@suse.com>
Subject: Re: [PATCH 0/9] Introduce support for IGVM files
From: Roy Hopkins <roy.hopkins@suse.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,  =?ISO-8859-1?Q?J=F6rg?= Roedel
 <jroedel@suse.com>
Date: Wed, 20 Mar 2024 14:40:52 +0000
In-Reply-To: <uknv3zep6t775h6fyr2m6l76exklpncqpu7rkga4hd6vsa2ccn@45ueizerlprr>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <uknv3zep6t775h6fyr2m6l76exklpncqpu7rkga4hd6vsa2ccn@45ueizerlprr>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::62e;
 envelope-from=roy.hopkins@suse.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 2024-03-19 at 16:07 +0100, Stefano Garzarella wrote:
> Hi Roy,
> thanks for this series!
>=20
> On Tue, Feb 27, 2024 at 02:50:06PM +0000, Roy Hopkins wrote:
> > Hi everyone,
> >=20
> > This initial patch series submission adds the capability to configure
> > confidential guests using files that conform to the Independent Guest
> > Virtual
> > Machine (IGVM) file format. The series is based on the master branch co=
mmit
> > 1b330da. Alternatively, the series is available here:
> > https://github.com/roy-hopkins/qemu/tree/igvm_master_v1
> >=20
> > I look forward to welcoming your comments!
>=20
> I saw that the series has been a posted for a while and maybe you're=20
> going to send v2, so I'll bring back some little things that I saw, but=
=20
> I didn't do yet a deep review:
>=20
> - We use "Isolated Guest Virtual Machine" or "Independent Guest Virtual
> =C2=A0=C2=A0 Machine", are they interchangeable for IGVM?
>=20
> - `./scripts/checkpatch.pl --codespell` reported some warnings:
>=20
> 5/9 Checking commit 81f60e5cdd01 (i386/pc: Process IGVM file during PC
> initialization if present)
> WARNING: 'initalization' may be misspelled - perhaps 'initialization'?
> #15:
> =C2=A0=C2=A0=C2=A0=C2=A0 initalization of the target.
> =C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^
>=20
> 9/9 Checking commit 66745c0bb940 (docs/system: Add documentation on suppo=
rt
> for IGVM)
>=20
> WARNING: 'encaspulate' may be misspelled - perhaps 'encapsulate'?
> #27: FILE: docs/system/igvm.rst:4:
> +IGVM files are designed to encaspulate all the information required to l=
aunch
> a
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^
>=20
> Thanks,
> Stefano
>=20

Thanks for the initial review Stefano. I'll be posting a v2 shortly and wil=
l
address your comments.

Regards,
Roy

[snip]
>=20


