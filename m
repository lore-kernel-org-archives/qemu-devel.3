Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F378606A339
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SPNiEJXZ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TDaY8Vof
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTI9g-0002QR-DB; Tue, 17 Nov 2026 07:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTI9f-0002Q7-6x
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 07:19:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTI9d-0005Lb-Dp
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 07:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794917956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HBhd7zcu71EGVyZS38zXNrfMaI/qWYXB0bIOCNmPGCY=;
 b=SPNiEJXZbDo2JSQRM2oPyyP7HhbGwCHR0K7yXTYwNQWOirSy8WrnakXq6KO94tAkGx7RwB
 lwE/xR43vER/bwDAgNhPB2vwEfRXKA75s5iIt2eVmRxZF6XYvTI8cnWzsMoxabJprRNl01
 qn7jj8Z9IVFiQv1RRbcEYA768I1B830=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-gAAGPYT1PNuPy5prfH0iag-1; Tue, 17 Nov 2026 07:19:12 -0500
X-MC-Unique: gAAGPYT1PNuPy5prfH0iag-1
X-Mimecast-MFC-AGG-ID: gAAGPYT1PNuPy5prfH0iag_1794917951
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-49d8ce126f6so2901212f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 04:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794917951; x=1795522751; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HBhd7zcu71EGVyZS38zXNrfMaI/qWYXB0bIOCNmPGCY=;
 b=TDaY8VoffmbURmRVeSW2sfyVlFHlnPaP69LyJRVGRu31n3w6aJOweq0m1pXjThLIVM
 05GDEY2kmrEyFNUs/cix2/eyriNz75uXK5s0Tt8sFP2pZVoX9bAoJC3hN1b/V//cD64q
 4JjNxCekjYfsMdI30s8YKcWSs8/IrYcSTdoCSoJeXVgAF0v6UhdAvmdwhvG8hqbxPFli
 uYPFIVHog9hyKjcinqKDx1/HQYaqTvm+OYaywoOI4V0t6uQfsmdwCToOc0xJKk8SVqzm
 CeYH5XKmDLEat2U7E2M8h1CoXnV/XW97PTk8CcvlhYlIyATc/FmBvrvW9tGGgJq+LqR6
 EwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794917951; x=1795522751;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HBhd7zcu71EGVyZS38zXNrfMaI/qWYXB0bIOCNmPGCY=;
 b=IgEnupNH7YbcwI/wn9+hQ79M+Nxv/mtXapP8AAfYRWxQbzWlgl69TTkbHaZz8aUw72
 ib7G+L8DAre6pqOQjNezrNz7crkd5QGxNEcbL6Pe6yYWB0NnOstLOjE/IA1Byyp10/ES
 iEhtEi/Mo9ooLnVmi4GqKrwBbJf7oEdNBFCIXvV59CliAjyJUWxGO6L9TfNqQs7NbYRa
 d34bG/OWqsMyYrOzzREA5da1hqcr2WYC4b9aDK1qhybi+G0+6uHhuBf5ZKAd4ut1ztsL
 IrNXFwT+KLqDgWT9pLwnegAYV8aMAJ/q89jkIpBDexcA7TtezymYJ7Z3ab6nd5Znco+Z
 FIjw==
X-Gm-Message-State: APuU4Z/bYrG5ZFQQyKOvv0QCXzEReGf/nCWimdG7uVK9dTE9osRPwena
 OCp8qqP+QNdLiF0maipajqMWjfNqA/IrOVHzy55wzQCnrAJawJ+yyH5EAWmuo5czrZFhGkjSlDp
 ntmjPEUbbbmu42SjYBvzm20dNTou6MA9/2BcRzC+dk9zhqJjGCcmWrHVs
X-Gm-Gg: AZFdTZfrEEo7ua/Mo/K7Fqoibrj+1TrfIjJaDuTadZ80XLiki3fBfzDaBfK2nkxPeg9
 zS+53DzR2EFjzKBBdYkDBs1ocl0nIjlnllTiISujI/BZLi/Iykit1m5+DdXpMOx0ZFUJ9vcm8RN
 RdePBjUWBshX44pXLJXxrbICg82SYq5HKrXe+Nwqkcz6Hibl0LsT4P+4lCY7cldV5EauDkUYA2H
 zhBAQQduANtdzHMfXv+1Wc/mZ6LlP2cDmFDW6gLIpxrLRthSvvGjXQtZ4Q+o+KJUo+P79PzHfVK
 8SewOIeCp+5HPHbqmZDB5d5tYgIig78c+bVWB2OkrXCIXwb3ialyi6etgQt8I3h0+DaJ2aPMoWW
 UA26G9c/J0L3DlRzvSvyfRBbV4mR4tPSNkCvjtZOY14E=
X-Received: by 2002:adf:e190:0:b0:493:8847:841b with SMTP id
 ffacd0b85a97d-49c70b059e9mr28592857f8f.19.1794917951225; 
 Tue, 17 Nov 2026 04:19:11 -0800 (PST)
X-Received: by 2002:adf:e190:0:b0:493:8847:841b with SMTP id
 ffacd0b85a97d-49c70b059e9mr28592783f8f.19.1794917950564; 
 Tue, 17 Nov 2026 04:19:10 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5fe370f8sm24964231f8f.27.2026.11.17.04.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:19:09 -0800 (PST)
Date: Tue, 17 Nov 2026 07:19:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anton Kuchin <antonkuchin@nebius.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, NB-CoreTeam@nebius.com
Subject: Re: [PATCH 1/2] hw/acpi/aml-build: Ignore used ranges outside the
 requested window
Message-ID: <20261117071727-mutt-send-email-mst@kernel.org>
References: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-0-0cede42456c4@nebius.com>
 <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-1-0cede42456c4@nebius.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-1-0cede42456c4@nebius.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 12:59:48AM +0100, Anton Kuchin wrote:
> build_crs() collects used resources without any information about
> valid address windows. These resources can therefore lie outside
> the interval passed to crs_replace_with_free_ranges().
> 
> crs_replace_with_free_ranges() assumed all used ranges lie within
> the interval.

you mean assumes?

> Ranges outside it could therefore produce free ranges
> extending below or above its bounds.

could in what sense? does it produce them?
in what configuratoons?


> As a result, the guest kernel
> may assign a device an invalid address range.

And does it? what guest?

> 
> Skip ranges with limit below the interval start or with base above
> the interval's end.

and then what happens?

> 
> Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>
> ---
>  hw/acpi/aml-build.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 990abc64cd8b..90837b513e69 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -124,7 +124,7 @@ static gint crs_range_compare(gconstpointer a, gconstpointer b)
>  }
>  
>  /*
> - * crs_replace_with_free_ranges - given the 'used' ranges within [start - end]
> + * crs_replace_with_free_ranges - given the 'used' ranges and [start - end]
>   * interval, computes the 'free' ranges from the same interval.
>   * Example: If the input array is { [a1 - a2],[b1 - b2] }, the function
>   * will return { [base - a1], [a2 - b1], [b2 - limit] }.
> @@ -140,6 +140,16 @@ void crs_replace_with_free_ranges(GPtrArray *ranges,
>      for (i = 0; i < ranges->len; i++) {
>          CrsRangeEntry *used = g_ptr_array_index(ranges, i);
>  
> +        /* skip ranges below the window */
> +        if (used->limit < free_base) {
> +            continue;
> +        }
> +
> +        /* skip ranges above the window */
> +        if (used->base > end) {
> +            break;
> +        }
> +
>          if (free_base < used->base) {
>              crs_range_insert(free_ranges, free_base, used->base - 1);
>          }
> 
> -- 
> 2.43.0


