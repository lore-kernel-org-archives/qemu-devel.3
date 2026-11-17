Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1626606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iZu9zRm3;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jIaffHQb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTIIT-0004fr-HT; Tue, 17 Nov 2026 07:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTIIP-0004f2-78
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 07:28:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTIIM-0006Sj-FN
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 07:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794918497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u70QSfNznfxKk4w7WbqWECmEqJJ8Yr7754spFnbGzFE=;
 b=iZu9zRm3u+HdKD8Kt7um4tH+1E0CEw1K3pGZEWgPEqXu1PVVAnz/PMUnDaQqfoxZjGwoKf
 1oM8aXJToMv+r2I/Tkx/AJJOSCcLbiFEbL5QGXrINH5P4ryd8SchAiwwBSdc432sNnBk6p
 lNmw5vNSpdG+7oxjjNfBCVbajxDVoiI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-hYCo_B3wOp69d41ToFscnw-1; Tue, 17 Nov 2026 07:28:16 -0500
X-MC-Unique: hYCo_B3wOp69d41ToFscnw-1
X-Mimecast-MFC-AGG-ID: hYCo_B3wOp69d41ToFscnw_1794918495
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a359c7f47bso40395035e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 04:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794918495; x=1795523295; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u70QSfNznfxKk4w7WbqWECmEqJJ8Yr7754spFnbGzFE=;
 b=jIaffHQbqpomTnnZOx0clAnQK8SR/VQabbxioipvxOXWEc3oTArQ0Nh8v+yowhuReC
 5AcgliEdlWEYZsYuhcSXyYspwYmCxZiol05ptS7lococWH9rc/FZSMr/u39UQjtiPMYU
 FxnIT4R76lANX7bNzZqN+AW+3b6E5Xn057NpGcSkmIVzRORpYkzDkbzbe+sd14f5xI/C
 p6dL3RCIPGB5P8ITaU5GhMzbkzXijg+mVpVmcr2u9tqBDFajasUqxA66zhH3IfZZ0y3B
 TqEDmvcUl40LSKS5tE0uwjyZhe5Pn7/SKdZv31twmH3Isvu9JKdFFWflFQBMOcpDCzxo
 JbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794918495; x=1795523295;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u70QSfNznfxKk4w7WbqWECmEqJJ8Yr7754spFnbGzFE=;
 b=s3MDegjxvSM0rn5LrwzzzpBqAKPfZaYvFQZljfA8C/STBjrh8GkyxmgF7rCf14c7ci
 x6ZXQh2jeY06rkXPFlkWGTfAEZBTRUcvp6jWwae1kOG7+gOJ6c3UlKOwEv8QvUAEqmlP
 dT0rq2V3gZda+/FcC5FPeBHkECadiGY9Ku7GBvSTXqpcURuEh9YPWRhB7c4JCqci6QYc
 GfVeS536yXq6uDz+a9EOblS5fXnLrkcH8pnVDtOfK/g0pq64iD05/67TcHUCHBQ38f+s
 9n9mlN7vryOdqfOABsxGFPUqDi5hk4tyobLK+AryirYl/VBtal7YuDXP+AyxHw0BqQyz
 Ji+w==
X-Gm-Message-State: APuU4Z/eztmNicCkAYSGI+t90wezuevlFW39wighdzRm74AS8A+2INSN
 XIZ/mM6rzccH1FZGIBE0/ghZbKsm+9pYlil38DPoqd5HJC8jN9vS5wtLIXup64XVBjqBM+D70ot
 QrEH0R/sMecIqM7IkwHMCq25usuNYBDkzC6wozuIJLRs8ptCfG3pwsdTs
X-Gm-Gg: AYBFou28Jey0z3h/NIRBom1TvFHsrGIHvdq9AP1CVg8jJWvOvzq1rSmYeZjsybsc/Pm
 oDuERQRTSi+6N0khdoTZrudY3u1jhbUie6XMSq7Wlv70HlujlkAUdRo8jdtwPQI6DresdWvp9AH
 D0FKfLAcV3nuQ9pduzIi0pzlWvQbmPWerVE6VG95ubIt/oJmJJLlCpWVtNpmizLsZKYFCI3Zb7k
 tJbNk9D1NbtqeG1z/IdGVMp1ksRc97aEoZyYXMl29/DZuYAGKBU1nHDF/KmUEE9lJ6BeE4IzGTu
 HOYtNNOQheXz4oj3NYC15Yo2x6OZEQHjDeQq+HLmYDIyaZh+rCIdSJzVBYRvJWFwhUnOLQzeFtl
 UCki8JVroj3PYMTthqe/HDCmlSgbKYUmzIb8UxMGEdFQ=
X-Received: by 2002:a05:600c:501f:b0:4bb:76f6:d23a with SMTP id
 5b1f17b1804b1-4bb779f5b93mr75301335e9.21.1794918494656; 
 Tue, 17 Nov 2026 04:28:14 -0800 (PST)
X-Received: by 2002:a05:600c:501f:b0:4bb:76f6:d23a with SMTP id
 5b1f17b1804b1-4bb779f5b93mr75300615e9.21.1794918494083; 
 Tue, 17 Nov 2026 04:28:14 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f7eecsm114311835e9.3.2026.11.17.04.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:28:13 -0800 (PST)
Date: Tue, 17 Nov 2026 07:28:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anton Kuchin <antonkuchin@nebius.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, NB-CoreTeam@nebius.com
Subject: Re: [PATCH 1/2] hw/acpi/aml-build: Ignore used ranges outside the
 requested window
Message-ID: <20261117072730-mutt-send-email-mst@kernel.org>
References: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-0-0cede42456c4@nebius.com>
 <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-1-0cede42456c4@nebius.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-1-0cede42456c4@nebius.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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
> the interval. Ranges outside it could therefore produce free ranges
> extending below or above its bounds. As a result, the guest kernel
> may assign a device an invalid address range.
> 
> Skip ranges with limit below the interval start or with base above
> the interval's end.
> 
> Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>


Given it's a bugfix, pls figure out when was the bug
introduced and include a Fixes: tag.

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


