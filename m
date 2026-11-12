Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B7606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NmQVld5K;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ro/1s+Pt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUcW-0000yS-8k; Thu, 12 Nov 2026 08:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRUcJ-0000wF-QT
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:13:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRUcI-0005Yy-86
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794489204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzpTxk/MR8sJNDgtR7+JPFJ21BX8dyAh+S6x0ich39E=;
 b=NmQVld5KRCHgfiwHWPd0I8l4/AV8noaDAL5gOXZm3+q8uo63u38B6w+efPyj1sG4cWyPoU
 VMJrinf40gfXEi6Nme9Rk1BSFy0gwAeW4C15iBMuvbv7+0F26FVBN8DiUzZJRUQexJtYbo
 12VKpQ+cAbnFga4cjzOG9jIwQKTqlNE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-Q2FdyWQGNVyNuoQRIJjDWg-1; Thu, 12 Nov 2026 08:13:22 -0500
X-MC-Unique: Q2FdyWQGNVyNuoQRIJjDWg-1
X-Mimecast-MFC-AGG-ID: Q2FdyWQGNVyNuoQRIJjDWg_1794489202
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-49337a224a8so3542468f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794489201; x=1795094001; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TzpTxk/MR8sJNDgtR7+JPFJ21BX8dyAh+S6x0ich39E=;
 b=Ro/1s+PtEXRxJw396bcxvcrucSy3PurKHpmJsZ9ZYmXznBUUFDOumNjQxrbl8gRgic
 ggv5wOpy3E5VErpv5qwfAztYeYv3F8KaVxkjW7hBYjKgFGqQu8GqcE1ALp9vzh6ASuT0
 HfSCSa4rOBWlSYdN1pdDRf/Whq3DL+KNCwgPhm/e9ExfucF4+l9iS2JmQOMM3u1OM0JA
 W1LYBZ7qpaB0DSx5fiLQwvekTHsOttTrd2wrs9mQGKCjX7uGDbC7JJ2MOFOV3z74u+6x
 NOskGPGgpvbJ2R0mIYyOuUxrdHGPdbMJILG5vbkbB8fKIHMtthv0dJe1V8oxvSh+G3AA
 F8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794489202; x=1795094002;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TzpTxk/MR8sJNDgtR7+JPFJ21BX8dyAh+S6x0ich39E=;
 b=LICUE8jQ6SrjNqQBRZwFkJkc7rxWU3ucMbTqDGThTDwM56fkC63Y+v3LBLQwNqlbfE
 cKzK52xM31BnasHqzvCt3GA9FU8gqPHOOyKQ+H0RQHa7erxMmJwav/kxT/RQAUtZxWSV
 yjoCuMXDJIufkpda8fiEN/hR+YkcTEi7S1iKD6mlBuTJW4prU4NeE+c3s9y+v4Teb0KB
 /u864qAYWl7Cfbw16DbTm87EDDTIIRU3bHf7fQSg95ZmTz1wv+NIOEELaFBAjQdJynj6
 CXSJ//iOgxeef3eHMYQnDE2onFYgWHatrdzEaBCp2ybdCV6XwVocHwgRY73t06zU0MQn
 2uvg==
X-Forwarded-Encrypted: i=1;
 AL+hErGl+AGK7ZpxjMEHEdSAzqyvKKqeQZ9+xxm4qBW0rsfUs1h1xIgP8iNOuZbrQGwrfUapwXwEb1xkTqHM@nongnu.org
X-Gm-Message-State: APuU4Z8fFR0PDRR7INi/tiEuYp3ne+Y6/KoOoYLu6N9AKI1hpsfh/qYb
 up7q3ec+f+3cII/ke6Kn7eIpF5hT7yvE1ip1u1L2fbLO+p9syI/l7cgiGLqqeYgR21W1M0J+Bd/
 qrA9FBg7ZVyivQgaahBIfdLlDuX9rd4ipJejwfCX9AH971QzdBra8rhk+
X-Gm-Gg: AYBFou3Vc21Axq7WbDpcU1+ZQbcdvOw7SdY6QIyFJIM/LpW+NbOxZ7xiBDPd6rMPHVv
 9Et97WHgG4nc7+2c18NjSJ+4VlNGvBNSPirFZQqz9/7hjrrWLUXJ6QF7GffceHrX9bi7hTNsZZb
 1MDNh5qScpISwoYAFNbOgPP02N3VWSC/NYJr2wWawRqSm4EyYkxi5mUiVwNKA0G6sjtOUBuRQk7
 4NwfGTDRGNLn0Y35gyY74pgVDZUVhBRjVuDUo6x92WE6SLIP+0ICXjZz00QLSpuOSbKcfLoRcsy
 xpJNN2b3hopvvjwa2WDZCLBPNuzLpyDCSJSOuukgEdk8P9OsYQi35cg1wykL+giyp7X/+o8LSwM
 sREA53UK9dSr2inFo8Dfhbaelx8vimO9euSg=
X-Received: by 2002:a05:600c:3f0e:b0:4a1:d97e:cd60 with SMTP id
 5b1f17b1804b1-4ba09364012mr96106395e9.16.1794489201689; 
 Thu, 12 Nov 2026 05:13:21 -0800 (PST)
X-Received: by 2002:a05:600c:3f0e:b0:4a1:d97e:cd60 with SMTP id
 5b1f17b1804b1-4ba09364012mr96105905e9.16.1794489201180; 
 Thu, 12 Nov 2026 05:13:21 -0800 (PST)
Received: from localhost ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365ccbccsm17010003f8f.44.2026.11.12.05.13.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 05:13:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 14:13:19 +0100
Message-Id: <DMT9BXQ9TPPI.2JEJKF00POB19@redhat.com>
Cc: "Klaus Jensen" <k.jensen@samsung.com>,
 <qemu-devel-bounces+tcalifano=redhat.com@nongnu.org>
Subject: Re: [PATCH 1/3] hw/nvme: reject fdp.runs smaller than the lba data
 size
From: "Tommaso Califano" <tcalifano@redhat.com>
To: "Klaus Jensen" <its@irrelevant.dk>, <qemu-devel@nongnu.org>, "Keith
 Busch" <kbusch@kernel.org>, "Jesper Devantier" <foss@defmacro.it>,
 <qemu-block@nongnu.org>
X-Mailer: aerc 0.22.0
References: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
 <20261112-nvme-for-rc-v1-1-69b3e5dcd5c8@samsung.com>
In-Reply-To: <20261112-nvme-for-rc-v1-1-69b3e5dcd5c8@samsung.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 10:53 AM CET, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> The reclaim unit accounting in nvme_do_write_fdp spins forever if RUNS
> is configured to be smaller than LBADS.
>
> Reject such an invalid configuration upfront.
>
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520

/s/Link/Resolves

> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Maybe Fixes tag and QEMU stable in cc?

> ---
>  hw/nvme/ns.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index 2ae26a9acbd0..37d45bb4d533 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -485,6 +485,12 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Erro=
r **errp)
>      char *r, *p;
>      uint16_t *ph;
> =20
> +    if (endgrp->fdp.runs < nvme_l2b(ns, 1)) {
> +        error_setg(errp, "fdp.runs must be greater than or equal to the =
"
> +                   "lba data size of the namespace");
> +        return false;
> +    }
> +
>      if (!ns->params.fdp.ruhs) {
>          ns->fdp.nphs =3D 1;
>          ph =3D ns->fdp.phs =3D g_new(uint16_t, 1);

Thanks,
Tommaso


