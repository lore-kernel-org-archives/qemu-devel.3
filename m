Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BCEC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 03:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQf03-0008Q4-4J; Sun, 07 Jul 2024 23:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sQezz-0008Ot-8X
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 23:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sQezx-0006Co-RH
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 23:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720409103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jq3KstHEkI4aUdy/qYvuyyWx359jRQacLLdvvfJOsMo=;
 b=FBSQVYDPtPYhW9U3YUWrqtXdMY62Z6Q4Ou4TLsk01CLl5uT040/I/RnH6gQEDzELncLecQ
 qo+0rp9NOfmeStKSW11Wq8NMg4DrR+ViFDrKkTVeRmkPQki5BezjTsrZsSuYUftMYHZc/8
 rKQF23aj5e8jYNGm0crqI/ur8LECQTQ=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-ISebJjahNbaAgLCV5EKTCA-1; Sun, 07 Jul 2024 23:25:02 -0400
X-MC-Unique: ISebJjahNbaAgLCV5EKTCA-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-38260829891so36508875ab.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 20:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720409101; x=1721013901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jq3KstHEkI4aUdy/qYvuyyWx359jRQacLLdvvfJOsMo=;
 b=bf8cD7goHg856NNexoKaYfCCBo6qIgMa2xGLzJLqmnmFkWpGZZ7gkdxKMbn9vdqDrx
 WQB+0CBdYBJziXE1q302q91m+VXQNu2sabx8KFTLuGkLczzUnArdeC9SW9AioFnDvWNw
 hZsFr5QM+6GStgSdEuiQ9Q4eVF0zK+rDEOnUAn4fY+mdybaxaMQhaHIoD7nhLEX7Zt3q
 HXZpdjcgKYHCfbYk2idoDDGdUTMzRu5mAARYpgcaG+93wqHnrOPhI9S9KQroe27vBlkU
 /fmgqxMOmPoDMGKKXVW0HvUJSw5QnoBV1usVh/HZrc41liGOf2otCI5hxE1nYS0gSUjK
 DzXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt2S66v8KQWqWexfyHCrMezdtXGfxG/Iu+MR1wT7JDAA/O1AqPhXhZI6s1ZPwtU6CfexzOyb+MZo7v6wEVlooabtn3TqM=
X-Gm-Message-State: AOJu0YxVMe1pc5B0qggUUQuo+Tn8GldNGN3wJE6h93YqLewGrfMZW4V7
 bBUeJz5MDxXM1kcnIwYmmeKQ+TmKc0HpzHTsIy/pH57IBqc4IMlSJmF4nWeUnRfrBtMjxcnpysA
 uvPl4Lg1oNyKFSsxi89wuL31hpgBx6AYkkAQWtgCegPbcIFEhIF64l6K4XfjcotzsNYZvq3VUAR
 y08vjf6YChFp7mDfAlH7kpOPs+Pf0=
X-Received: by 2002:a05:6e02:152b:b0:375:a15e:d28b with SMTP id
 e9e14a558f8ab-38399874d44mr147825565ab.16.1720409101526; 
 Sun, 07 Jul 2024 20:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX7+QuL1xA2zsoHrV1FvzxRuSgAbrpJbUA509biH9ZsMEso5Un28+1uIIiyCVjJFmcn9rgxwpsG5IKQE1jyJw=
X-Received: by 2002:a05:6e02:152b:b0:375:a15e:d28b with SMTP id
 e9e14a558f8ab-38399874d44mr147825465ab.16.1720409101227; Sun, 07 Jul 2024
 20:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240708032112.796339-1-yi.l.liu@intel.com>
In-Reply-To: <20240708032112.796339-1-yi.l.liu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 11:24:48 +0800
Message-ID: <CACGkMEtZ7yDzvGQOj9txFiYzaHgTtmHeeZmLH+uoxEBwkN0NDg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a VT-d reviewer
To: Yi Liu <yi.l.liu@intel.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 8, 2024 at 11:21=E2=80=AFAM Yi Liu <yi.l.liu@intel.com> wrote:
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6725913c8b..61724b91d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3656,6 +3656,7 @@ F: tests/uefi-test-tools/
>  VT-d Emulation
>  M: Michael S. Tsirkin <mst@redhat.com>
>  R: Jason Wang <jasowang@redhat.com>
> +R: Yi Liu <yi.l.liu@intel.com>
>  S: Supported
>  F: hw/i386/intel_iommu.c
>  F: hw/i386/intel_iommu_internal.h
> --
> 2.34.1
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks!


