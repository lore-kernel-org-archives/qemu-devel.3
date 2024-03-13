Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D062C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 06:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkHmV-0008An-1y; Wed, 13 Mar 2024 02:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rkHmQ-00088m-Ut
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rkHmI-00085b-Tc
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710310067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lvUXW0uE7MgDRroLrCKTwIlpczc9KZnPpiDSgdPbn/k=;
 b=Yc/BzZTNVoLy9PhOyDYgiRO+8lyCVk4f6jGu3SM3/ku0TPXy02OXohAXDFOuJXCy4uqf6P
 QAs0kpp+sP/HJP2Xzc2gwdsTHByNkRubQJpbKAh3jrBSNK9PwzNBn6cNORs/Uh0urxzdGa
 VYKxcrQs5YkYCB/6TtDK329bhgH96iM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-2LSmMX9dPtKszSb2p1UaqA-1; Wed, 13 Mar 2024 02:07:45 -0400
X-MC-Unique: 2LSmMX9dPtKszSb2p1UaqA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29ba8f333easo5135436a91.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 23:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710310064; x=1710914864;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvUXW0uE7MgDRroLrCKTwIlpczc9KZnPpiDSgdPbn/k=;
 b=j82LNnOwtXBDdz7s2vIifN76rEAA9PDhsBe4KOIhTmOPNL7XwFJqoueK1yva0k2OxU
 toEskJ+gm5zR5HK2yhxAEMdLcJYKwJNY0DGfhqalQPmZpVS3WmyZAQBV1D628FltlC33
 d6KKz6ev+QEoK+rAyLuBncn+W5ESTi79TzsSMA1KlZAUxyNKZuk8WdVC22KMa0RW0SMx
 AWP/h/r7thcu7hkW4o/n+v1dBcxLWsm4+16uFfNncqk4+rmJQ1WKAHNEk1k2Qw6S/zll
 KD55d+7Lq1JlSohQZRUKTWBsfI93aIcQsxsjXJeTp9scOhQhmY4kxyDZGg8nKBQa8oKM
 nAgg==
X-Gm-Message-State: AOJu0Yx8a7ZaHmY9hCCfsS187BwCSi2JWT4PcMC+4YttRwR7XghQYikV
 1hiYcBikZMae+5Ug3HoqX3C3tIiejWSoedcD8rhSbUN9POllovytB+qthCGYfu2kLF8zT3u8WiA
 j7fAk7cCW9vUzGNp7llUBbx/HUw/INb03E9FKGRQt2g8fIEDA9EyO
X-Received: by 2002:a17:90b:2204:b0:29b:a149:2ff6 with SMTP id
 kw4-20020a17090b220400b0029ba1492ff6mr10901308pjb.38.1710310064511; 
 Tue, 12 Mar 2024 23:07:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPVP9DDJc/iaFhEKZYcgbFp+NTMCoEeL5VXzHkATf17Eio8UJPT/bhZ3MzD3Os0tbgQfwujQ==
X-Received: by 2002:a17:90b:2204:b0:29b:a149:2ff6 with SMTP id
 kw4-20020a17090b220400b0029ba1492ff6mr10901298pjb.38.1710310064140; 
 Tue, 12 Mar 2024 23:07:44 -0700 (PDT)
Received: from smtpclient.apple ([115.96.155.110])
 by smtp.gmail.com with ESMTPSA id
 mz9-20020a17090b378900b0029c09574b43sm599270pjb.20.2024.03.12.23.07.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Mar 2024 23:07:43 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] SMBIOS: fix long lines
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <9bce53c4f7ffda8e4a49353902626702fa01e5a6.1710282571.git.mst@redhat.com>
Date: Wed, 13 Mar 2024 11:37:30 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <85FF2C3B-CC90-45C9-AF6F-9E02E5EB4114@redhat.com>
References: <9bce53c4f7ffda8e4a49353902626702fa01e5a6.1710282571.git.mst@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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



> On 13-Mar-2024, at 03:59, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> Break up long lines to fit under 80/90 char limit.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> hw/smbios/smbios.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index e3d5d8f2e2..949c2d74a1 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -1592,12 +1592,15 @@ void smbios_entry_add(QemuOpts *opts, Error =
**errp)
>             t =3D g_new0(struct type9_instance, 1);
>             save_opt(&t->slot_designation, opts, "slot_designation");
>             t->slot_type =3D qemu_opt_get_number(opts, "slot_type", =
0);
> -            t->slot_data_bus_width =3D qemu_opt_get_number(opts, =
"slot_data_bus_width", 0);
> +            t->slot_data_bus_width =3D
> +                qemu_opt_get_number(opts, "slot_data_bus_width", 0);
>             t->current_usage =3D qemu_opt_get_number(opts, =
"current_usage", 0);
>             t->slot_length =3D qemu_opt_get_number(opts, =
"slot_length", 0);
>             t->slot_id =3D qemu_opt_get_number(opts, "slot_id", 0);
> -            t->slot_characteristics1 =3D qemu_opt_get_number(opts, =
"slot_characteristics1", 0);
> -            t->slot_characteristics2 =3D qemu_opt_get_number(opts, =
"slot_characteristics2", 0);
> +            t->slot_characteristics1 =3D
> +                qemu_opt_get_number(opts, "slot_characteristics1", =
0);
> +            t->slot_characteristics2 =3D
> +                qemu_opt_get_number(opts, "slot_characteristics2", =
0);
>             save_opt(&t->pcidev, opts, "pcidev");
>             QTAILQ_INSERT_TAIL(&type9, t, next);
>             return;
> --=20
> MST
>=20


