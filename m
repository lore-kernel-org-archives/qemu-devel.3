Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75DEC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 12:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV9nm-0002c2-Kz; Wed, 31 Jan 2024 07:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rV9nk-0002bt-VD
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 07:34:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rV9nZ-0003YE-L5
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 07:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706704475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6ENG7S6kqI2E9TR7r4kveFp9X7Mr0GJ5jFNVb5Z5dY=;
 b=PZqzHcWjZyTTJZPACqNvwz60C0aPD4CS9DYxdPVTOs2gy5JPpJleUaJkZSkah9jcJnph1a
 dgYBvMMFx9Cq25TpZCKJa1nzUDubgMcwUPRDPQcSf2BCfGXzs6hob+bCoE4nyj7LugR8x8
 IzzMiRjMucENgCi+syBEtEubuQseYSo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-WshthTV-NGKbggtKIt-51g-1; Wed, 31 Jan 2024 07:34:34 -0500
X-MC-Unique: WshthTV-NGKbggtKIt-51g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40fb3b64751so3317085e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 04:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706704473; x=1707309273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6ENG7S6kqI2E9TR7r4kveFp9X7Mr0GJ5jFNVb5Z5dY=;
 b=vajR6a3nkCEgxB8+m/IQiTld2pXQ1gqQiRkvEyzD2/fQmD5DGEQfNknig053DEQNB7
 9wyNMF3N62XFl25jcSZW1F/GHFYp+B8oGBIEezzJlatBGFYfjDiEc95r3g0Q9zd6tYmw
 OTRH0t+6a5rdtWOf92Fi9Bt0aqem+Lp/HCbtGrCuP/iPx9WtUFqjG85Fj5t7aC2WNngQ
 9CWjaFLNUxG3mA2VLqFPzgVE2a1cCSUXQboOBY1hP3gGS/7uH6Za7SFhIaeOD2U+VnhY
 CXvI/suEgo2OVI4JcExwai8tDgMkrVPbc/oCEMqt8Fjs7iBDg3GHvJwELUEysG7ByVh0
 UBfQ==
X-Gm-Message-State: AOJu0YwpatW+Lf5WrDD1qyJZ3+vaT/N0EvYWlgaEtjiCSWHInNhfVanW
 En3SajlBuaUIyr/+ZtI5qItvE10hu9WnhYBUx5LMb3n85KS8ZUqOINvyqpE78ASD1qWqCUY0Epy
 nf7c7AM1IFuWEWDJjdaN4Xa9xef6+MxXMMdj3pX1XrJP9WWua0nJh
X-Received: by 2002:a05:600c:1ca9:b0:40f:afc8:ac6b with SMTP id
 k41-20020a05600c1ca900b0040fafc8ac6bmr1145389wms.6.1706704472977; 
 Wed, 31 Jan 2024 04:34:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgcG0/AlPOHyFc7k2XSi7Zco3KZSBvvBMME7cYXOBmFUou+GNNwaVzwnHlUPV3c9VYe6gjhQ==
X-Received: by 2002:a05:600c:1ca9:b0:40f:afc8:ac6b with SMTP id
 k41-20020a05600c1ca900b0040fafc8ac6bmr1145377wms.6.1706704472629; 
 Wed, 31 Jan 2024 04:34:32 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 r5-20020a05600c35c500b0040fb0bf6abesm1496242wmq.29.2024.01.31.04.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 04:34:32 -0800 (PST)
Date: Wed, 31 Jan 2024 13:34:31 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH v2 6/6] target/i386: Add new CPU model GraniteRapids
Message-ID: <20240131133431.11e3c3f8@imammedo.users.ipa.redhat.com>
In-Reply-To: <Zbj67L0dbtJSF3xm@linux.bj.intel.com>
References: <20230706054949.66556-1-tao1.su@linux.intel.com>
 <20230706054949.66556-7-tao1.su@linux.intel.com>
 <20240130111459.5718f484@imammedo.users.ipa.redhat.com>
 <Zbj67L0dbtJSF3xm@linux.bj.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 30 Jan 2024 21:34:36 +0800
Tao Su <tao1.su@linux.intel.com> wrote:

> On Tue, Jan 30, 2024 at 11:14:59AM +0100, Igor Mammedov wrote:
> > On Thu,  6 Jul 2023 13:49:49 +0800
> > Tao Su <tao1.su@linux.intel.com> wrote:
> >  =20
> > > The GraniteRapids CPU model mainly adds the following new features
> > > based on SapphireRapids:
> > > - PREFETCHITI CPUID.(EAX=3D7,ECX=3D1):EDX[bit 14]
> > > - AMX-FP16 CPUID.(EAX=3D7,ECX=3D1):EAX[bit 21] =20
> >=20
> > it seems the list/definition is not complete, see
> > https://lore.kernel.org/kvm/20221125125845.1182922-1-jiaxi.chen@linux.i=
ntel.com/
> > and those feature bits were merged into QEMU earlier (a9ce107fd0f..d1a1=
1115143)
> >=20
> > were they omited intentionaly?
> >  =20
>=20
> No, Jiaxi=E2=80=99s patch series includes new feature bits of both Granit=
e Rapids(GNR)
> and Sierra Forest(SRF).
>=20
> GNR contains:
> 	PREFETCHITI CPUID.(EAX=3D7,ECX=3D1):EDX[bit 14]
> 	AMX-FP16 CPUID.(EAX=3D7,ECX=3D1):EAX[bit 21]
>=20
> SRF contains:
> 	CMPccXADD CPUID.(EAX=3D7,ECX=3D1):EAX[bit 7]
> 	AVX-IFMA CPUID.(EAX=3D7,ECX=3D1):EAX[bit 23]
> 	AVX-VNNI-INT8 CPUID.(EAX=3D7,ECX=3D1):EDX[bit 4]
> 	AVX-NE-CONVERT CPUID.(EAX=3D7,ECX=3D1):EDX[bit 5]

> What new platforms support the new features can be found in Table 1-2 of =
ISE[1].
> And the SRF CPU model we submitted[2] contains the four feature bits supp=
orted above.
Thanks,

for future patches:=20
this kind of info should be part of commit message incl.
spec/doc title/revision it's coming from with a specific
chapter/table also mentioned. This way whoever reads it
later won't have to ask or spend time for searching where
it comes from.

And maybe also have a comment close to new code,
aka like we do for ACPI patches.
=20
> [1] https://cdrdv2.intel.com/v1/dl/getContent/671368
> [2] https://lore.kernel.org/all/20231206131923.1192066-1-tao1.su@linux.in=
tel.com/
>=20
> Thanks,
> Tao
>=20


