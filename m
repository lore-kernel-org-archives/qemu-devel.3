Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AC1C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 15:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rngTr-00055k-JA; Fri, 22 Mar 2024 11:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rngTp-00054b-E6
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rngTo-0000Jd-0N
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711120007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nBPCS4DNfF8YOy2CBdTcuSS+iLPM+X+VigtgcvoS85Y=;
 b=Wve0OegFozI/6AhKIPpyetMu1jjUAJ7j4i/hG34hKeDBxlP+ptzOlmCj0iZ/Sor1aJXuBQ
 klK+yqLzPRc7hFaBwtvJTB1LBLLFwxGCWp9Ws65EKQu1Y1O6OKk7srQ2mbFZS0uxMHbybq
 HP7RFHpQblm8FLnveOds+BT8NiXcUaM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-LNh5aAbxOH-kSidoRmaItg-1; Fri, 22 Mar 2024 11:06:45 -0400
X-MC-Unique: LNh5aAbxOH-kSidoRmaItg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-430c76df729so6234971cf.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 08:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711120005; x=1711724805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBPCS4DNfF8YOy2CBdTcuSS+iLPM+X+VigtgcvoS85Y=;
 b=j6JhnqSEjEIeHg9ygUYfn3SIjogOO24ZHQnASGxEiqK16jsaT5osU5gWpKSr/Cup69
 WmKS7E6KjMs1+eacoliRZFiUAjPlQuw6K7ix474q0ivaE01WOcx0tHxHs8jqMAv/Dt43
 ryz9SAgq/1hWx6t1kvnUAD1VPJ4NDFufg9fUtPh2yGXhtPYFnujPvjuFCXk7uhb7LKti
 XmKzkMaWbFLsTc192icsTeKql4nvVWyx7MyCtO2dhRTZwN9yroLohHnXecYB0oqGHylq
 9KLXv5IM1p5QBK7WIJcy0VTk7SSQcF8AfNytLm4/Jb6P3lwKf4ddhuhY5wR67F30p7X9
 QiEw==
X-Gm-Message-State: AOJu0YyCuGTvTV8UVHXRk5issYf/7yaMdCUFH0NBVFAmJn6JmXQYhe+Q
 O+lu5B5YRDWwVgAkdbCCYV9xavWij4Zv2x+5a2I0BL43ZhJfvcEoENSGEPAszlEoH6s2FrA7A+6
 a1IvutloSpaZMZXKG++VTeYHHvSTiANmMsj+z1xAS2TkQqUlOMCgw
X-Received: by 2002:ac8:54b:0:b0:431:155e:840a with SMTP id
 c11-20020ac8054b000000b00431155e840amr2301704qth.1.1711120004633; 
 Fri, 22 Mar 2024 08:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv8QeRnnG12mF00NzOYfkjnhlLc+K3k2yxO7dnoPSC+M022QbpfIloJynvh3nOrADFYVWbtw==
X-Received: by 2002:ac8:54b:0:b0:431:155e:840a with SMTP id
 c11-20020ac8054b000000b00431155e840amr2301658qth.1.1711120004076; 
 Fri, 22 Mar 2024 08:06:44 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 gd18-20020a05622a5c1200b00430ac082732sm933585qtb.70.2024.03.22.08.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 08:06:43 -0700 (PDT)
Date: Fri, 22 Mar 2024 11:06:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 berrange@redhat.com
Subject: Re: [PATCH 0/3] qapi/migration: Doc fixes
Message-ID: <Zf2ee6P85Dkb6nmT@x1n>
References: <20240322135117.195489-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240322135117.195489-1-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

On Fri, Mar 22, 2024 at 02:51:14PM +0100, Markus Armbruster wrote:
> I'd like to get these into the release.  Please review.
> 
> Markus Armbruster (3):
>   qapi: Improve migration TLS documentation
>   qapi: Resync MigrationParameter and MigrateSetParameters
>   qapi: Fix bogus documentation of query-migrationthreads

With Fabiano's fixup squashed:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Peter Xu


