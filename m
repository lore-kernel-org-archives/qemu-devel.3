Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6488AD6408D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 21:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Wbw-0002AC-3M; Fri, 08 Nov 2024 16:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1t9Wbs-00029h-76
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 16:33:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1t9Wbq-0000Ns-Ns
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 16:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731101617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHTssLKPbLEDpldhE9KkCTfCRF2dNObfz7HU7nMwU+Y=;
 b=iutdT/EDMxMDdy55RnS15XNhaR31eP0Jy8H9skuZ5LHFZMvrGgxA6Q04QcBGrGWMkJFJUw
 /yj54Ajxm0N+npxsHZavMpgXOkQzQzyE02Hx9G1dpqO6bPOVd2Juy8yRLAUKe3iiTLiTZq
 iMlII/RVxSTi7KjTi0X4pbejKDr9c6Y=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-pPRhovtRMuOL8qRw1P6U4g-1; Fri, 08 Nov 2024 16:33:36 -0500
X-MC-Unique: pPRhovtRMuOL8qRw1P6U4g-1
X-Mimecast-MFC-AGG-ID: pPRhovtRMuOL8qRw1P6U4g
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3a6cabd39e9so4083865ab.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 13:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731101615; x=1731706415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VHTssLKPbLEDpldhE9KkCTfCRF2dNObfz7HU7nMwU+Y=;
 b=uRmqABDkcfCkUPa2U/N+RTiD0aSPh6SMpq8HxoPH+0tJ2XnlO9pAlSTGF11Ib2B0sl
 5+P6EoZXuwVFeS+pm7Ttk3GQyxslRB7mhSpsyPJWv2j4w+ckr0l0yADMaXiSk+te4vnu
 YDOEjLIDPgFF7THWZTNub8QLfczmh7tVrj4YBozcQeJTD+ym5mmBcm3eehFB8/OgmKoR
 Yhn/rvr+0SXL5FBUiYf5/VkE2mAptyjPgaY895qgAuIoyE/HbCHfRzo6Q/q+O1T2s8uH
 SsLrqoaJBSk+I2qtII86629uF8FjF/YikPvLpWC79Au9qqqlPyY1cn6Il/igC7ZbIHjz
 XkWw==
X-Gm-Message-State: AOJu0Yz3vt9xiL79ZRCrOWEyvrKo5mnHuy4W4kVtYY6QQtV3rIiiIOlw
 tSrXze8QgswWgL9fW7XMwo3/r6gRJ8+SOFoATAGgIUjW0e0O+vwjYvlR1kbQnEo4EieRx6kGz9W
 KV7YzCZ9Kbl36gmJ88GvtxVjndlxxlOC43bG4MNRg1pwbkyAXDDO7
X-Received: by 2002:a05:6602:14c1:b0:83a:abd1:6af2 with SMTP id
 ca18e2360f4ac-83e033a0ed8mr133189939f.3.1731101615592; 
 Fri, 08 Nov 2024 13:33:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoDfRykBZNzflDCODJmx8eTyPRKOiyOJaf3BFxZoYufLvXc2K24cSdO+iIkOGrkfjyshlMTQ==
X-Received: by 2002:a05:6602:14c1:b0:83a:abd1:6af2 with SMTP id
 ca18e2360f4ac-83e033a0ed8mr133188539f.3.1731101615190; 
 Fri, 08 Nov 2024 13:33:35 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83df50dfcb3sm103444139f.32.2024.11.08.13.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 13:33:34 -0800 (PST)
Date: Fri, 8 Nov 2024 14:33:33 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Corvin =?UTF-8?B?S8O2aG5l?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?=
 <c.koehne@beckhoff.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH] hw/igd: fix calculation of graphics stolen memory
Message-ID: <20241108143333.451359ce.alex.williamson@redhat.com>
In-Reply-To: <20241108124904.93201-1-corvin.koehne@gmail.com>
References: <20241108124904.93201-1-corvin.koehne@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri,  8 Nov 2024 13:49:04 +0100
Corvin K=C3=B6hne <corvin.koehne@gmail.com> wrote:

> From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
>=20
> When copying the calculation of the stolen memory size for Intels integra=
ted

* Intel's

> graphics device of gen 9 and later from the Linux kernel [1], we missed
> subtracting 0xf0 from the graphics mode select value for values above 0xf=
0.
> This leads to QEMU reporting a very large size of the graphics stolen mem=
ory
> area. That's just a waste of memory. Additionally the guest firmware migh=
t be
> unable to allocate such a large buffer.
>=20
> [1] https://github.com/torvalds/linux/blob/7c626ce4bae1ac14f60076d00eafe7=
1af30450ba/arch/x86/kernel/early-quirks.c#L455-L460
>=20
> Fixes: 8719224166832ff8230d7dd8599f42bd60e2eb96

Fixes: 871922416683 ("vfio/igd: correctly calculate stolen memory size for =
gen 9 and later")

> Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
> ---
>  hw/vfio/igd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index a95d441f68..732f9c37a6 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -498,7 +498,7 @@ static int igd_get_stolen_mb(int gen, uint32_t gmch)
>          if (gms < 0xf0)
>              return gms * 32;
>          else
> -            return gms * 4 + 4;
> +            return (gms - 0xf0) * 4 + 4;
>      }
>  }
> =20

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


