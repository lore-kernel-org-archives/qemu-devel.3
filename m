Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506C7D637A9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 20:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVbxB-0007h4-Ky; Tue, 16 Dec 2025 15:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVbxA-0007gh-88
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 15:47:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVbx8-0004W0-Rp
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 15:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765918045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3n//CUYgcmIzmvtThC+mgA/3gCtIX8trouGE3a27CE0=;
 b=IACnsTepyKjXj881yzqHNQKA3YLBQGOldFXZaeFMo1HlHrZDPKVCcOpZssjsHy2OKVUKZk
 U1pwhRP0+uqumQ3TXuQ5xzA9XntWOonFhzeaJMm1hdZjxhLcQTVrf9UpD/xuyI0nT9H0gG
 WF/zMeEiomX603Z02NfQ3s+TYJXqYP0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-Xn-0wgfCMDqds-1zW5hNcw-1; Tue, 16 Dec 2025 15:47:06 -0500
X-MC-Unique: Xn-0wgfCMDqds-1zW5hNcw-1
X-Mimecast-MFC-AGG-ID: Xn-0wgfCMDqds-1zW5hNcw_1765918026
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4f1dea13d34so84629481cf.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 12:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765918026; x=1766522826; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3n//CUYgcmIzmvtThC+mgA/3gCtIX8trouGE3a27CE0=;
 b=bYElZqtCoaDtb22zQg6uvdUn5vYW2YlsjiGOPO93ImfoMPa/u0W+iMrOaEQW4adWKK
 VKTYlJKKWV/Z9a/EpQ4/ds3SCdnOGxrUdEg6ZTdALB8L8GvtVclHkn2ABk6r3/yVsEmH
 xAV4Zj52nuM9dqdpkeHZlQvW0IQ6ZpY+w1LmZHvegViwEZTOzXZyr2h9Q1kaLQERfKRR
 twgaRZhpMg2bHm5INsCLV54D5SwZYmJ3cOLqB8514KRq4ZPAISe9sfVtgTcfbsyoTsSP
 c124LfPetoicUi4gcjEif5czNureu3Bp0J2GwDwGcb/OjQ+pi/cHx9JxQHyHTUT7NU49
 h8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765918026; x=1766522826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3n//CUYgcmIzmvtThC+mgA/3gCtIX8trouGE3a27CE0=;
 b=TLx04zM2rhxhfIuUofZyYvetUjIom6FNNdyhStJsMz9Xliv/Gqy0Z53W9A2LhnaWpV
 m2JN0qIPFAlGr27ovnbxOvPS0Bjuc2BapLdKfNK3Uy132VCq7qIbpO5TPmRZ/KAUU4tH
 yZsbioERcw6TsmttqRyN7KJSV+GDD/Cb8GFvBPZPGgDB+AO+F2YiO74+K4Bzf+lNKt0v
 2uhFGpjEX4JuXGGievvXw6qqGJfGhnbWFH+zQE5DK7QRfkxkdSKtaaSeU+0JjVfy2KtH
 CLOM3JJJxDE9R0ejboNmErjt0U8w1aTxp0jP1pcI1m+syF9C4iVt0IpcvbzYK4O/Lc5t
 p2Cg==
X-Gm-Message-State: AOJu0Yz6bVqJZSZMsnnzPZXrTYLI3qt2VFQh1YukFHHTF7J1AkKPv/3k
 Ir19eFI4PFi6gAdYDQA6GdoYsK2HjtscosX5ROdAMR3tRnRudjR79baJb2QuqEFQy2nXPO8j3AB
 DFa3W+9Af0bIMnmjz192MfK2jaOwmh59y7Ren+gKhJZZO8k+VNfg3t/22
X-Gm-Gg: AY/fxX5fAmp5vRIB+ODjVqsLQalhPEkfe6DExcMSYy0lC4Xi/M2kZ6M5UApBhWdWj7a
 meU4p+EjCfUGmpOPaekiokDsYotg1lM2deuT399sqgxj6AIq3F/47qST/+cFtBZvsmyY+EadNaz
 tCubL3acuYNrlQCT7uS26ZjR26KdUwd0KzxAvBi2TLMT9YLdVfXa8jbP6QeluQTskELdtQnpIUt
 BZSGmE/bUYylKPtRQwtwf16FjTyV/XbzN6PMaWRKxkwoClqnEHFTvFBg/w2ICLX24gcEquLL2fB
 rfOuZINFbP972+ADEyW0oI9wFQrpS5uHouY36Tbvy4nlgc4H1UC3MMxIRgQcJGD18sF9Xhb5N0q
 79/E=
X-Received: by 2002:ac8:5156:0:b0:4f1:e8f1:cbda with SMTP id
 d75a77b69052e-4f1e8f1d29fmr118131111cf.54.1765918026022; 
 Tue, 16 Dec 2025 12:47:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvgH8Sc0aHpJq/WtMV0rWyope8hy55KOYWR4UuGDeAxC3VPL58aNdSy17drhKUn6uzHFCEsA==
X-Received: by 2002:ac8:5156:0:b0:4f1:e8f1:cbda with SMTP id
 d75a77b69052e-4f1e8f1d29fmr118130781cf.54.1765918025433; 
 Tue, 16 Dec 2025 12:47:05 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f345c31460sm22958061cf.17.2025.12.16.12.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 12:47:04 -0800 (PST)
Date: Tue, 16 Dec 2025 15:47:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v3 17/51] migration: Use QAPI_MERGE in
 migrate_params_test_apply
Message-ID: <aUHFR0bhNAVEIJG7@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-18-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-18-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 15, 2025 at 07:00:03PM -0300, Fabiano Rosas wrote:
> @@ -1260,124 +1261,28 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>      return true;
>  }
>  
> -static void migrate_params_test_apply(MigrationParameters *params,
> -                                      MigrationParameters *dest)
> +static void migrate_params_merge(MigrationParameters *dst,
> +                                 MigrationParameters *src)
>  {
> -    MigrationState *s = migrate_get_current();
> -
> -    QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
> -
> -    if (params->has_throttle_trigger_threshold) {
> -        dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
> -    }
> -
> -    if (params->has_cpu_throttle_initial) {
> -        dest->cpu_throttle_initial = params->cpu_throttle_initial;
> -    }
> -
> -    if (params->has_cpu_throttle_increment) {
> -        dest->cpu_throttle_increment = params->cpu_throttle_increment;
> +    /* free memory from pointers that are about to be assigned */
> +    if (src->has_block_bitmap_mapping) {
> +        g_clear_pointer(&dst->block_bitmap_mapping,
> +                        qapi_free_BitmapMigrationNodeAliasList);
>      }
>  
> -    if (params->has_cpu_throttle_tailslow) {
> -        dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
> +    if (src->tls_creds) {
> +        g_clear_pointer(&dst->tls_creds, qapi_free_StrOrNull);
>      }
>  
> -    if (params->tls_creds) {
> -        qapi_free_StrOrNull(dest->tls_creds);
> -        dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
> +    if (src->tls_hostname) {
> +        g_clear_pointer(&dst->tls_hostname, qapi_free_StrOrNull);
>      }
>  
> -    if (params->tls_hostname) {
> -        qapi_free_StrOrNull(dest->tls_hostname);
> -        dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
> +    if (src->tls_authz) {
> +        g_clear_pointer(&dst->tls_authz, qapi_free_StrOrNull);
>      }

These will still be error prone when introducing new parameters that needs
explicit frees.  It'll be nice if QAPI_MERGE() can free the elements when
present in dest and when to be replaced.

But this is good enough, let's land this series first..

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


