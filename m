Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDE6F53D9A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 20:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Eoo-0008Kt-UD; Mon, 16 Mar 2026 16:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2Eom-0008KX-DI
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 16:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2Eoi-00068B-H6
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 16:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773693934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xGQk+HC2OgrIr7p9GyqgMZZ+97qt7Pi9DmBMDBI/ryA=;
 b=KYBaRVuFCoBV3qOh1ah5U1+k+SDnd42a5Jt/D3MElzql2DX8H+QIVKcmIdaX7WECpwli0j
 5TAkXoMrmMSPE+61sQfL/UWVsaheucfIVqvbj0SFnR11iQ9s3CUUSi9ZAu5MaG/ybAipdZ
 xYLONOqvtUgnpVF9VOO8lg+7teERfMU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-KrcLM474NnuHK9MoVFIvgw-1; Mon, 16 Mar 2026 16:45:33 -0400
X-MC-Unique: KrcLM474NnuHK9MoVFIvgw-1
X-Mimecast-MFC-AGG-ID: KrcLM474NnuHK9MoVFIvgw_1773693933
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50917afa521so6506661cf.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 13:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773693932; x=1774298732; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xGQk+HC2OgrIr7p9GyqgMZZ+97qt7Pi9DmBMDBI/ryA=;
 b=TtAuiQmWhqVL4ZgAyY96u4Z/23kX5EJ7x20pKgx0fGYW4gvMBWRHeIzgPv/e/i7Svb
 Ajln/u4iwLMM03fGlkihkV7oeu1GOgTxKvHuLAWH71FYYgeIeIavdTjU4AGWTSufoJRg
 hlgvOFL7U1C3ch6uJgzZxePimYK8jlN0BJoniPEodSGl17C7ynG2HUmIaFCaY26vMUii
 XBVeCOvRY6MCDkG2VtDaWysg8wi5NulLiRBp+hjG3uiKGBd6YCY2z+59kX0TBXz8F9zx
 0bFHB0n4g+HcEK8h1bvxWTcepBGiN+eLAR/qrS85Yc6QiragCa22VhRCSEZ8ivnKh0KY
 /O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773693932; x=1774298732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xGQk+HC2OgrIr7p9GyqgMZZ+97qt7Pi9DmBMDBI/ryA=;
 b=Rswxnh5SOMjBwDUu2j3nayWLfgR/FgqRiKnYN8vGc0GS7EgDX8Ut+1kKWi4D+/M0iQ
 vySzFwbLlNLWTaerc3La5KY0A2yN/0DQXKK8r27Vy8Hf6vVg4Wuhyd9n+LFCNmUyVjGB
 tDn2bfTcPXtbPHJhxMzK2qnnGS33r3mVyCF1ltswoNq2RercA3SZNclFGud7NysCJYT2
 BwlMANW1BfOh6ac24xlpsiRL7WgEHwJ9itm+xx3rINxlq9ox2bRGK9f9GcZcxumngiOE
 9U+dPbctufjNNCTY2MSE7rbGozxlI4OMVp6/h5l91OHC9xOcPjCA0GgXTkcsXqmA/hmP
 Of2Q==
X-Gm-Message-State: AOJu0Yx/Z6axvxYzTdHZkbImADOM/UblgBi2Mgp0lwZUt88/B12Y3EI7
 tnpLt+pNmiYsAmli4ff7aS/aZzmmkcAAUqGDq2guWiPRvMN706b9qte0qMzpFCDuH+5iZenIT1E
 XNeHQdZTGs8M1y3F0eQVFoStKbhk7Zwi5zGmeOpLsFEZoIn0iNYw9vRk/
X-Gm-Gg: ATEYQzyaY9hD/d3SXgB8PTMcWTn5+/Pq4zcH+eeN8+ksW4ZFhxtzeQHRDifbYgGihUI
 ElC+wU+jUdKjEQtCoGMWBPVMru6xekdyA86wgAkXKlTUMDh5C3cjC4WKHr8swUcj9ed39N0/K24
 kHQttPRcWzMO5sSdi3qJtNgNvYSYxEG5H/FXdts7uwpbq+OVD98+3pC8gH6hHZPb59G7WwF4era
 YEpD4HgVrqOfOxAOED4YPEdoK/TNeopWdEg1R6pK3196J13G2cgbimeS4lHpIGmTkXDiq5ZrLt7
 K+HVSDma9bDPWcW/CcyHac8LLZsvqER/Bj3HMuseiaIP0AM9SN0Gr73oQsrlTaX75aKt3iGoiv4
 FewigWO8Dl9PEbA==
X-Received: by 2002:a05:622a:248:b0:509:1dc8:e9e4 with SMTP id
 d75a77b69052e-509980cfc1bmr13557861cf.22.1773693932275; 
 Mon, 16 Mar 2026 13:45:32 -0700 (PDT)
X-Received: by 2002:a05:622a:248:b0:509:1dc8:e9e4 with SMTP id
 d75a77b69052e-509980cfc1bmr13557221cf.22.1773693931464; 
 Mon, 16 Mar 2026 13:45:31 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50939e8e0ecsm127608271cf.5.2026.03.16.13.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 13:45:31 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:45:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] migration: fix implicit integer division in
 migration_update_counters
Message-ID: <abhr6oISW2oAcq2q@x1.local>
References: <20260316134509.157964-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316134509.157964-1-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 16, 2026 at 07:15:09PM +0530, Aadeshveer Singh wrote:
> switchover_bw is a uint64_t, so switchover_bw / 1000 results in an
> integer division. This value is then assigned to expected_bw_per_ms
> which is of type double. This results in losing precision and is type
> unsafe. Adding explicit cast ensures floating-point division.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index f949708629..7094080285 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3134,7 +3134,7 @@ static void migration_update_counters(MigrationState *s,
>           * If the user specified a switchover bandwidth, let's trust the
>           * user so that can be more accurate than what we estimated.
>           */
> -        expected_bw_per_ms = switchover_bw / 1000;
> +        expected_bw_per_ms = (double)switchover_bw / 1000;
>      } else {
>          /* If the user doesn't specify bandwidth, we use the estimated */
>          expected_bw_per_ms = bandwidth;
> -- 
> 2.53.0
> 

-- 
Peter Xu


