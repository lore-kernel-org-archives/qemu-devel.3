Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1552C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6TH-0008It-WC; Tue, 26 Mar 2024 09:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rp6T7-0008EC-Ra
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:03:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rp6Sv-00069l-Sy
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711458223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtPpFL5icBpEgA04izrcHDf2hvVGMn5FegeO1sDid1Q=;
 b=aaqPFOZNeFMu6Y+ljCSLHg84OgZS0tfue+hlnJs0MsTe/jRp+fMFMXF9VNXfqWo2qH84bX
 QUW137w48R8qJFZ1VeoYHK5Os4ybEpIVeNtuFM2mdICDEkRGm6AgLN7gJGewJ3fjC0k7b/
 XCWuUkW9rSlLv9uV2nCuPBBmyAiN3lI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-j4mZvJFxOpaV1PisLdwl_A-1; Tue, 26 Mar 2024 09:03:42 -0400
X-MC-Unique: j4mZvJFxOpaV1PisLdwl_A-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5dcbb769a71so5044596a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711458219; x=1712063019;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtPpFL5icBpEgA04izrcHDf2hvVGMn5FegeO1sDid1Q=;
 b=agAyUFDloP2RfCMF2PCgEt+rxSQZvb2FZZrUuguETsPw4sA2MYTI2VWHVmdQrj71vg
 B5AQg2ChWQgauTiARr7S8WG5tDo3zIk8tneWTMgZNEwDn1OyaYfMlNtCrTWwaokgD8Kx
 AQlAIv549dtAh4YEuvvUur8Enf8ZM6Xk4+MqBGui6U3iAFNn+QjzPN9qHvjGc7Gk5gps
 j8CsUznC//9ivtniXu/FObLcShsaRcDgQHlync0yDKtFwxKxbKwFkSaoTwrImfDKffow
 vEx7dXbgMlPZN6c4mM9RfsuZfH7BlHDp+UbOuTNPLcX6KqhTWCw4Oc9MImdQfyIxnuj2
 IurQ==
X-Gm-Message-State: AOJu0YwV8/KVfKnkQmvX83tWhfDBOS/qVgerAlpcWMwXb+OfX1uB+CG9
 UZdqDlstuHCVAcHK/cRMrebMZYflnn/R+qNJ9sPrnXJpTNmilKcQtrudhhEd3vLULpWC2F94V+t
 hQ69MAQcTEI2+WWMvt64zHolbZmgwquc4RGmrghpm8nUtZ7/y6rHI
X-Received: by 2002:a17:902:e88a:b0:1e0:b1af:9b with SMTP id
 w10-20020a170902e88a00b001e0b1af009bmr10608432plg.43.1711458218921; 
 Tue, 26 Mar 2024 06:03:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMuPiZd1oToW5wB8Xo7umdg+NKZNMZcYhz+ZRBHZE1jldIrgV/4LG11bqz/lALhTf7RidsBA==
X-Received: by 2002:a17:902:e88a:b0:1e0:b1af:9b with SMTP id
 w10-20020a170902e88a00b001e0b1af009bmr10608395plg.43.1711458218515; 
 Tue, 26 Mar 2024 06:03:38 -0700 (PDT)
Received: from smtpclient.apple ([203.163.237.163])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a170902ce8400b001e0da190a07sm2283298plg.167.2024.03.26.06.03.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Mar 2024 06:03:37 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240326125104.90103-1-imammedo@redhat.com>
Date: Tue, 26 Mar 2024 18:33:23 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tsirkin <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C2BC09E-E687-42E8-A7D4-D05F491AE432@redhat.com>
References: <20240326125104.90103-1-imammedo@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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



> On 26 Mar 2024, at 18:21, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> ISAPC machine was introduced 25 years ago and it's a lot of time since
> such machine was around with real ISA only PC hardware practically =
defunct.
> Also it's slowly bit-rots (for example: I was able to boot RHEL6 on =
RHEL9 host
> in only TCG mode, while in KVM mode it hung in the middle of boot)
>=20
> Rather than spending time on fixing 'the oldest' no longer tested =
machine type,
> deprecate it so we can clean up QEMU code from legacy fixups and =
hopefully
> make it easier to follow.
>=20
> Folks who have to use ancient guest that requires ISAPC can still
> use older QEMU to play with it.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> docs/about/deprecated.rst | 7 +++++++
> hw/i386/pc_piix.c         | 1 +
> 2 files changed, 8 insertions(+)
>=20
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7b548519b5..5708296991 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -226,6 +226,13 @@ These old machine types are quite neglected =
nowadays and thus might have
> various pitfalls with regards to live migration. Use a newer machine =
type
> instead.
>=20
> +``isapc`` (since 9.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +These old machine type are quite neglected nowadays and thus might =
have
> +various pitfalls with regards to live migration. Use a newer machine =
type
> +instead.
> +
> Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since =
8.2)
> =
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 18ba076609..96f72384dd 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -921,6 +921,7 @@ static void isapc_machine_options(MachineClass *m)
>     m->default_nic =3D "ne2k_isa";
>     m->default_cpu_type =3D X86_CPU_TYPE_NAME("486");
>     m->no_parallel =3D =
!module_object_class_by_name(TYPE_ISA_PARALLEL);
> +    m->deprecation_reason =3D "old and unattended - use a newer =
version instead";
> }
>=20
> DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
> --=20
> 2.43.0
> _______________________________________________
> Devel mailing list -- devel@lists.libvirt.org
> To unsubscribe send an email to devel-leave@lists.libvirt.org


