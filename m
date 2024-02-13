Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8416BC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpME-00053o-Mw; Tue, 13 Feb 2024 04:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZpMC-00050B-Hn
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:45:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZpMB-0001IV-73
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707817537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AIh63cKTuiqJ92GuQ+Bw3bsnREs8lDJN+5zWNucNQFk=;
 b=cUqUthB38CYOl7Xq0K5oS+bnmPeTR/qwGEKdHZsdsTN8pT+graah+UKXOHLkFBZt+MvL94
 iQW/cwJUwr69iPIxbyg8DcqkXKTq0GAFHfxrhp5jRl61yvCa919do+RjSV9aOsQUVzu6tO
 wH81/3t9oLuONX0gHds4E3ZoBpJjx/Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-3WOFeYCRMK6bdzO_QlTzkA-1; Tue, 13 Feb 2024 04:45:35 -0500
X-MC-Unique: 3WOFeYCRMK6bdzO_QlTzkA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2f1d0c3389so267819266b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817534; x=1708422334;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AIh63cKTuiqJ92GuQ+Bw3bsnREs8lDJN+5zWNucNQFk=;
 b=iBg6cWQmUefgsIoErZJVf9IMsjEuZ9GlW1f0rWw4dZq046RcJEA749MI3BLp/m679r
 eE4S9F8Z+D1p+DGtJmG0ZvPN08gVM35FOiJqf006QXOpSHbLeLmJxIHfur79XUGtrQvB
 V0tLvTiVH4gx/bqgYpJdCLwkS8Y5AQHadjPclWeofKPPj5t/MfNwM+Vyx1p49lNaDYMh
 KiaW8fSfAV2lW17k55jigao1v9J8Ou4Ofb6cNlrXbxMTXvDqJO3ZS+kcI7tPtmNqaTGc
 Wg/5aU+Lc6CrkmIuYr7E3OM9XSYv43jf4jLjfO1WmofvRFpl4LS5wyk8lldkCAEzBV/R
 PaEA==
X-Gm-Message-State: AOJu0YzryfCi9ErefXZHl1bJHTgq8ikuoGpuigTaAkWw1AUd/2rExMYn
 mT2McnBM1teMwiAwR0chDGc5ejq3ZMc4uQAX5sELTl/APacK1qMgQ9l+lpIFwlW6UQlLOL+Q2WU
 D4odxxOkbB9U1Pjv+VhTh2dLBBEp8l+LFIjupDh+BZfZbwfJi/30R
X-Received: by 2002:a17:906:2885:b0:a38:4a54:bc11 with SMTP id
 o5-20020a170906288500b00a384a54bc11mr5914233ejd.61.1707817534640; 
 Tue, 13 Feb 2024 01:45:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoPtxSPrm/tTaOsp3TNymikWnLsuXUuCrm/VMNmRG8tLKZOtMM3vkOQtWDuISpPFprcSYz0g==
X-Received: by 2002:a17:906:2885:b0:a38:4a54:bc11 with SMTP id
 o5-20020a170906288500b00a384a54bc11mr5914224ejd.61.1707817534322; 
 Tue, 13 Feb 2024 01:45:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW8S93pShmlgTo4J96YLU6ucpAqm1CPDzmCsgM60SC/uQQ2wYSu+0DPTVDXpeleMfPkbrxv7xP7Euql7zrEVunHBu91qSLYNHtF1dcQXFFu9JB/nbeCu1XzyOCguf84ZtIRzwoQ/+WQ21AHVenSJRrv5o1yFiexuOcHt1xnlcLzkmn25v1rsGpesVKU1IjIdngact3TChTncQs4fGJKm+VK8DYqkA==
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 vi10-20020a170907d40a00b00a368d0849adsm1115117ejc.0.2024.02.13.01.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:45:33 -0800 (PST)
Date: Tue, 13 Feb 2024 04:45:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 eric.auger@redhat.com, Alex Williamson <alex.williamson@redhat.com>,
 zhenzhong.duan@intel.com, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Drop myself as VT-d maintainers
Message-ID: <20240213044501-mutt-send-email-mst@kernel.org>
References: <20240118091035.48178-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118091035.48178-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jan 18, 2024 at 05:10:35PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Due to my own limitation on bandwidth, I noticed that unfortunately I won't
> have time to review VT-d patches at least in the near future.  Meanwhile I
> expect a lot of possibilities could actually happen in this area in the
> near future.
> 
> To reflect that reality, I decided to drop myself from the VT-d role.  It
> shouldn't affect much since we still have Jason around like usual, and
> Michael on top.  But I assume it'll always be good if anyone would like to
> fill this role up.
> 
> I'll still work on QEMU.  So I suppose anyone can still copy me if one
> thinks essential.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Thanks a lot for your work on VT-d!


> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b406fb20c0..1c85b4bdad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3606,7 +3606,6 @@ F: tests/uefi-test-tools/
>  
>  VT-d Emulation
>  M: Michael S. Tsirkin <mst@redhat.com>
> -M: Peter Xu <peterx@redhat.com>
>  R: Jason Wang <jasowang@redhat.com>
>  S: Supported
>  F: hw/i386/intel_iommu.c
> -- 
> 2.43.0


