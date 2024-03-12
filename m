Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2D9C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3vI-0000uo-70; Tue, 12 Mar 2024 11:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk3ur-0000fO-7u
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk3ue-0006YQ-TQ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710256772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RVTpY6oFEC2fEXaS5YHpTjsOtKEzldhRiPAvuynfycI=;
 b=KDhNEpo4y+Epq8qmVnE57Lv6PxuahWO+M173fbxVfYQfrH+dsTdhhdg3MxS8i3wsCZsdAK
 Uz3ChbwoSqch1Vfm/ubFuqhQysigNsnM7oxw4r3Yj+NtbQwo6HrxqX9jY7EOLc0lmF1uxh
 ZlXF9J2t6ZlhclU7V/UrJifgniB7TGQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-fEOFNXkEPaeS7zLoNjllzg-1; Tue, 12 Mar 2024 11:19:30 -0400
X-MC-Unique: fEOFNXkEPaeS7zLoNjllzg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33e8abc8aeaso2084056f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 08:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710256769; x=1710861569;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVTpY6oFEC2fEXaS5YHpTjsOtKEzldhRiPAvuynfycI=;
 b=mXXvNShwyEsL5JgFDjjI8seLGhBcE8lusQ4wtCe2JkQTKzfUiL7u9ctsjXL19ZXo4x
 VDHnhbHii/h9+mJQoz3MGqCTHk32xNgp71Md7k3fv4ejVw8GHE5SWpLbPRnILQJnaPvj
 kVvXdev+6ybkOyMyTIX+sxh8YGC1z+DC2a1VJTDkqTyEkN/kvm6Ew8pNk+ejK2mKNASM
 5Nj7SfbJd6Ko0edir4awxQTYpcNXM6x7sHPJ5e0fwMGZcBtl7vnuNWlFwy5Mz8zL3XgK
 /F2zWVgIAYc8Fj4qRddso/kXKcrFq5jkCcygJhjbh7XyFrRqKLmhQc3MNlC7OAEpHxPF
 svGA==
X-Gm-Message-State: AOJu0YyNOEuFgPpDGykX6E1PKbOM/6FxcKFqa+MG8H3UCHCKZ1UtP/1E
 LvfRoER2D11491USMk8DbHpOwed3xczxAgH2k6z3NvvYeEs+fg1v1XiAGalYN2cPMfL1iqx2IjL
 EXib9m/EE3WaD8d9bNrWmQuLjD2ivO3oeku/OU8eobwLtw8fxGaYk7rH1L5KP86U=
X-Received: by 2002:a05:6000:114f:b0:33e:7ae7:29fa with SMTP id
 d15-20020a056000114f00b0033e7ae729famr440387wrx.1.1710256768627; 
 Tue, 12 Mar 2024 08:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpIIqNyiFH6TrHPz266yFWV2hmFuPMW6vK4prgynyMU2O5YLukUPRXJXqqMchWQudlli/c5A==
X-Received: by 2002:a05:6000:114f:b0:33e:7ae7:29fa with SMTP id
 d15-20020a056000114f00b0033e7ae729famr440373wrx.1.1710256768141; 
 Tue, 12 Mar 2024 08:19:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a5d53c8000000b0033e745b8bcfsm9302956wrw.88.2024.03.12.08.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 08:19:27 -0700 (PDT)
Date: Tue, 12 Mar 2024 11:19:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lukas Stockner <lstockner@genesiscloud.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] pcie: Support PCIe Gen5/Gen6 link speeds
Message-ID: <20240312111631-mutt-send-email-mst@kernel.org>
References: <20240215012326.3272366-1-lstockner@genesiscloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215012326.3272366-1-lstockner@genesiscloud.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Feb 15, 2024 at 02:23:26AM +0100, Lukas Stockner wrote:
> diff --git a/qapi/common.json b/qapi/common.json
> index f1bb841951..867a9ad9b0 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -107,10 +107,14 @@
>  #
>  # @16: 16.0GT/s
>  #
> +# @32: 32.0GT/s
> +#
> +# @64: 64.0GT/s
> +#
>  # Since: 4.0
>  ##
>  { 'enum': 'PCIELinkSpeed',
> -  'data': [ '2_5', '5', '8', '16' ] }
> +  'data': [ '2_5', '5', '8', '16', '32', '64' ] }
>  
>  ##
>  # @PCIELinkWidth:
> -- 


I'll merge this but I really don't know how one documents
that some enum options have been added since some version
of qemu.


> 2.43.1


