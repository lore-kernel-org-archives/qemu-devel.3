Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F50FC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUiAi-0001Af-Ih; Tue, 30 Jan 2024 02:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rUiAg-0001AL-Kq
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:04:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rUiAf-00050S-6u
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706598276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7988OwlybzxlzZiqvL+Y3aNM19jgujNqRduBYk6ZUmU=;
 b=QxMtXZVKtuL+oON1XvnP3Em6SUrMcIT7Z36ehqYKvTtEPFDxea7ZxgGIDEFyR2QF7TGkLg
 H0E8FcG7EDps95hZdWW+W66KlRnnLhxYXHffk9L8zylSd42kPlUMoS+9Y4Z1op6XTO9vVB
 vX9B77VQIdADBmeRF9qRB1+xewt+AVo=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-4XaR47zQPFePZa4mFV-8PQ-1; Tue, 30 Jan 2024 02:04:31 -0500
X-MC-Unique: 4XaR47zQPFePZa4mFV-8PQ-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6e11741eea3so2650687a34.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706598271; x=1707203071;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7988OwlybzxlzZiqvL+Y3aNM19jgujNqRduBYk6ZUmU=;
 b=IBSt/DgHyseey74dCromwLeAGE0OPWkQa6EGm69Kj5RCNCX+xC1SEdoFK/Gr7BufKM
 XFWw3HzIyZEHK+P66YYRlOD1O6bfhslZScHyUBsynGi3Pyaz5N4h5XALttZxppvEfgaU
 ywqKJxqrI2t+4/JOa4YvC8ha9AOnmqwObIfyrCMwY8EOU+XWEm5Q6D1BsERBdQcYawBy
 xa+fuAnLKrPfMJLa2necBZHkKsd2x0nxWBxo13eWee4o62zDYnw2iOGpcgXW/2EQL3lQ
 k+YAKF6UfOAJ6UJy4IGWQl+oKgM5YVv5qGnLi7MQNUbox8+s58UuAsLsTXJ/8T5/mmvO
 /04Q==
X-Gm-Message-State: AOJu0YzfethtjWpTO6BKf8JVY4ypQIllydqbuJ5iM9T97UTTMkzNWcQJ
 VHjzrGUhs3rUuWWM4dzJx1OgwwwEhH0gDbrCX/ZMZ0U/KnQyiT8wN+QbwzoeupFDAffPLoesRJP
 vpXs6yAp8jSoYX5h/oAaAjgSAMtBjJID2OfLMaaGlL3tZRua7kHKL
X-Received: by 2002:a05:6359:4c1d:b0:176:8248:a219 with SMTP id
 kj29-20020a0563594c1d00b001768248a219mr5774588rwc.8.1706598270981; 
 Mon, 29 Jan 2024 23:04:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHI75SgfNkWF7N5MJMRb7QqSPmVNlexKB933e2SKzRo1niaBJW48UrrIFoFpfYJSH4oiZOerg==
X-Received: by 2002:a05:6359:4c1d:b0:176:8248:a219 with SMTP id
 kj29-20020a0563594c1d00b001768248a219mr5774570rwc.8.1706598270645; 
 Mon, 29 Jan 2024 23:04:30 -0800 (PST)
Received: from smtpclient.apple ([115.96.128.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a656812000000b005d0796e779bsm6286716pgt.12.2024.01.29.23.04.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jan 2024 23:04:30 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v2 2/2] hw/smbios: Fix port connector option validation
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240129-smbios-v2-2-9ee6fede0d10@daynix.com>
Date: Tue, 30 Jan 2024 12:34:15 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org
Content-Transfer-Encoding: 7bit
Message-Id: <D1D5CBD3-23E9-428E-B3D4-D78125563736@redhat.com>
References: <20240129-smbios-v2-0-9ee6fede0d10@daynix.com>
 <20240129-smbios-v2-2-9ee6fede0d10@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



> On 29-Jan-2024, at 13:33, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
> qemu_smbios_type8_opts did not have the list terminator and that
> resulted in out-of-bound memory access. It also needs to have an element
> for the type option.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: fd8caa253c56 ("hw/smbios: support for type 8 (port connector)")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> hw/smbios/smbios.c | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 522ed1ed9fe3..8a44d3f271de 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -346,6 +346,11 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
> };
> 
> static const QemuOptDesc qemu_smbios_type8_opts[] = {
> +    {
> +        .name = "type",
> +        .type = QEMU_OPT_NUMBER,
> +        .help = "SMBIOS element type",
> +    },
>     {
>         .name = "internal_reference",
>         .type = QEMU_OPT_STRING,
> @@ -366,6 +371,7 @@ static const QemuOptDesc qemu_smbios_type8_opts[] = {
>         .type = QEMU_OPT_NUMBER,
>         .help = "port type",
>     },
> +    { /* end of list */ }
> };
> 
> static const QemuOptDesc qemu_smbios_type11_opts[] = {
> 
> -- 
> 2.43.0
> 


