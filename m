Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6668DD6408F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 21:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9WbV-00026f-0l; Fri, 08 Nov 2024 16:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1t9WbS-00026M-K8
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 16:33:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1t9WbR-0000Lp-0i
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 16:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731101588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUB/im3NMrDA6cFper2gX5bygwCNdrqK+znFe3Pc5DQ=;
 b=fnOdZuw7L0nubpBoW7CwsGol3igOOAtEUe8oBeHs6niVUoBpTIfDBHM9IBLC1R9l0paaPW
 ESVCf/WCMcXJQNZS2N+buhDZ3lxXwa/ne54b8nhEFte42N5scgk+bKZ7lGJl0QFUFIxT1D
 wQZGBxo7v2KjSeucTDQRC2yp4E1zplk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-iSPicm5mMiq-iyPCVcLdXw-1; Fri, 08 Nov 2024 16:33:06 -0500
X-MC-Unique: iSPicm5mMiq-iyPCVcLdXw-1
X-Mimecast-MFC-AGG-ID: iSPicm5mMiq-iyPCVcLdXw
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3a3d7eb237dso3914175ab.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 13:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731101586; x=1731706386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUB/im3NMrDA6cFper2gX5bygwCNdrqK+znFe3Pc5DQ=;
 b=wQUrXiuweYFiu6TheEi8YP5MbkDBXBBR9yjAupmAB3AC72GY6EOqX+95WI9Wr1SZUO
 2PxwlLoeJtPYc17KCEaLHvtp9PmeLNn4Tj1Tlr7qP1cNJnCjMk2I1baWZb+ky58xelF7
 6U6id2T3Le533wQOYABIfaHl0yvOonstmEbA4P6Gsy4S+vy1b1cD8Tt4OFAXjoXluaoA
 fp7twZNpuB2vvNW8kbd5f0Cyz33qlYqyXMe95H0y3Jvj1eHmB6PG7Uhb3aAfT1ey4WVk
 Isi34A/JbcVEPsRZO0l2FGDlKH2DOBjrMlmlMpfZypBHBMjEE6O4NxbSNP4IUmUhAW1w
 YQdA==
X-Gm-Message-State: AOJu0YwHX2szTFJePxfOVJhWpnquLLow9fE9xbJ5up+rItDX+0i4FScL
 IppARa8r549h4OfwfOhC4s41i52BnHnIZmlE4bAjLLScOcduTsgC2Gc0krUR8rSSYQKDi+k3KRo
 sGnHI2JMyaWOryxzNkYll4jBCVU3N7iG7TD+jQQydLaz4orVc+9io
X-Received: by 2002:a05:6602:14c1:b0:83a:abd1:6af2 with SMTP id
 ca18e2360f4ac-83e033a0ed8mr133132139f.3.1731101585994; 
 Fri, 08 Nov 2024 13:33:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOB14mIBCJQdToOpYYm+t8cZi2gqey/zT/F3glW9N3WzvNdAyJqtBppr7vHfgwXKf15h3TNw==
X-Received: by 2002:a05:6602:14c1:b0:83a:abd1:6af2 with SMTP id
 ca18e2360f4ac-83e033a0ed8mr133130639f.3.1731101585587; 
 Fri, 08 Nov 2024 13:33:05 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de78740de4sm534173.49.2024.11.08.13.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 13:33:04 -0800 (PST)
Date: Fri, 8 Nov 2024 14:33:04 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Corvin =?UTF-8?B?S8O2aG5l?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?=
 <c.koehne@beckhoff.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH] vfio/igd: add pci id for Coffee Lake
Message-ID: <20241108143304.4cd8d623.alex.williamson@redhat.com>
In-Reply-To: <20241108124829.92893-2-corvin.koehne@gmail.com>
References: <20241108124829.92893-2-corvin.koehne@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri,  8 Nov 2024 13:48:30 +0100
Corvin K=C3=B6hne <corvin.koehne@gmail.com> wrote:

> From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
>=20
> I've tested and verified that Coffee Lake devices are working properly.
>=20
> Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
> ---
>  hw/vfio/igd.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index a95d441f68..c5282827ec 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -88,6 +88,9 @@ static int igd_gen(VFIOPCIDevice *vdev)
>      case 0x2200:
>      case 0x5900:
>          return 8;
> +    /* CoffeeLake */
> +    case 0x3e00:
> +        return 9;
>      /* ElkhartLake */
>      case 0x4500:
>          return 11;

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


