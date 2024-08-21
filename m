Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C38C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 20:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgrtX-0003r1-Dd; Wed, 21 Aug 2024 16:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgrtR-0003q0-AC
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 16:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgrtN-0004Sm-DY
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 16:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724271915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ErkaKzFZLwZz/ZGKl/kxd6wEsod7N6pSiTQQv8TUC6E=;
 b=cXPsH1yX4pPo6lpmQCgevP+XZ3CeyhpnXmZwQXUBGF0/X72X9X4qP0c2VYSQDXegvYlQ3f
 GWR6mcClf/iw51bsZZp1cBnNEaHH5ilOOWFeDwTVl2BD8ymX2c1shoSDgeoCC0kseox5xm
 l/ceqFc4fMhTDq8VYnPfd7id7lHU4Ho=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-B7A_3lWXN7SYgVMll8u_ug-1; Wed, 21 Aug 2024 16:25:14 -0400
X-MC-Unique: B7A_3lWXN7SYgVMll8u_ug-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6bf7ff0a1a1so379076d6.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 13:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724271914; x=1724876714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErkaKzFZLwZz/ZGKl/kxd6wEsod7N6pSiTQQv8TUC6E=;
 b=VUgwo4NtsQpQ1PpidsT/coAytFlcrPSoGG54FYrJfESqePMH72pA2p8a9KlCK9FiGt
 KjBiVS+9crc5X1iTO2pdxg4VVb/EreKrgeRR/tvSdSvMr503CIyVpKb5Lav9u0Ih33qV
 8chNabm8WaQkw7phww+zDKzpOvJWcC8h0m2xCERm5RduuUEGu9fHO3am8taLeBrxJlWI
 O9gOPQhziHTGUqBGOnKjyxFZywXPdbX2Q/j0430scib6ZPEWa3TLkZgAKiOafPNQYYEj
 3REqOL7Jgc0D3surNv4hEcTeuwAkqV/gZM9kO2teUpAKbOU2BEUAG2QBSmAFAXKRc7no
 AvFQ==
X-Gm-Message-State: AOJu0Yyom5wHSmu4uld/264BZUtbZCsuTEpLtBKT/nCwexS9co5+UHg4
 oQ7emf4/Tecc0g+CmyEttPCYHTmE5gAlh8bWX+dwtlABLUDQB4nXl/ULhy2kRriZr+yWd08/qSN
 pi1du03poJTiLE2VQFXah/2r/TmhJh3I/oq9HoBfXwwr+c3UuyqOh
X-Received: by 2002:a05:6214:2c01:b0:6bb:c0ad:8d78 with SMTP id
 6a1803df08f44-6c155dba087mr44508346d6.34.1724271913979; 
 Wed, 21 Aug 2024 13:25:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV+s3hOyhE6Nf84pqG9PK2y4+7Rve3Og3DJo0GDnwqf0k6uDrz4qDhaDdPT99qoaRq/PXsVQ==
X-Received: by 2002:a05:6214:2c01:b0:6bb:c0ad:8d78 with SMTP id
 6a1803df08f44-6c155dba087mr44508196d6.34.1724271913584; 
 Wed, 21 Aug 2024 13:25:13 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162db0964sm467666d6.79.2024.08.21.13.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 13:25:12 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:25:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 02/14] migration/multifd: Inline page_size and
 page_count
Message-ID: <ZsZNJsfRbB1BjZgy@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801123516.4498-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Aug 01, 2024 at 09:35:04AM -0300, Fabiano Rosas wrote:
> The MultiFD*Params structures are for per-channel data. Constant
> values should not be there because that needlessly wastes cycles and
> storage. The page_size and page_count fall into this category so move
> them inline in multifd.h.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


