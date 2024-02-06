Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32097C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXCMC-0006eP-KP; Mon, 05 Feb 2024 22:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXCMB-0006aE-EO
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:42:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXCMA-0002lB-0W
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707190965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Z8m+RsAGYiuiaohzp3qbwBlZD8EVzQkiuEzeGLPYhk=;
 b=FCHDHSGj+DjO9gtVvuS6ouc2mDmmcWQu6lNgK4LpF1ZQhi2gzQkhGkscMi5URuUm9soo5P
 V2aJkhVhX3gZYVQzLfqc2jqkpkFBuhD1gWa6VJYLNnBLwGOI5n/shGQwTAUVl3kmcmi9y9
 ipcIZZvgbjJ/rDyCh+Toaq9oAKCkYaA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-K0RrOEs0ORK4wbMtDuvdSg-1; Mon, 05 Feb 2024 22:42:43 -0500
X-MC-Unique: K0RrOEs0ORK4wbMtDuvdSg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2969feb0dbaso350240a91.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 19:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707190962; x=1707795762;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Z8m+RsAGYiuiaohzp3qbwBlZD8EVzQkiuEzeGLPYhk=;
 b=mJCEVowmdeUxZ1xkeuEFH0a3p1tstl5RlztOfOEwaTjLig+qhZw/dgdvXi/R0L2Fwj
 WsfGM5ah5OMpMBqaKCOuVpRneqxRFEnWjAVbfg47pFPIzmxWEdtoDtxeTY8eFkfXNU2g
 IvR6wHKvj4ijbNGjd26dTLRJ/HMkHTGXvjm/4QTGtjkRmWBTKpJGg7SYpoZloJMCoHLc
 fZdUKFqazYbhuwicMpRXivuZx4QQJy1BJp/ojJNbMwu24H13TxiIxLsB0iKciSjGlb0f
 D6d9iVltTsEaoyAHuBQcYClfu62qy5oy5fiVhNkGQc2gSdP9VlwA/WmZeRWdBhufy+97
 2dtg==
X-Gm-Message-State: AOJu0Yw2S0Eq0u2oEzD/CDa/xdDLWsBlqHkQn2N+hqe5Ex4mH9Z+ILm7
 S+dWd0pcAolGCFIuzHB5a+s0iUtkqquLRJIejUX0gBEwOAKJEMbmYfDvacRzKhK5tF3STTediFo
 lsd6qshSZDFMOh9QAwFQswT/Lt39oNs+n4fovIXIiVqbxaMHDgYWA1zbd/CuZIHw=
X-Received: by 2002:a17:902:ec8a:b0:1d5:efd6:20f with SMTP id
 x10-20020a170902ec8a00b001d5efd6020fmr1660466plg.1.1707190962316; 
 Mon, 05 Feb 2024 19:42:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqJWBNfo87wNh6Qkyv9D+Z7qzADMkc3exbFpZgb4y1UhLcm8G//usAA75E7KcZ5NkbI65JDw==
X-Received: by 2002:a17:902:ec8a:b0:1d5:efd6:20f with SMTP id
 x10-20020a170902ec8a00b001d5efd6020fmr1660454plg.1.1707190962010; 
 Mon, 05 Feb 2024 19:42:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUjK/LtcCtcaAcaz1vao3rSzvjSoWS52mMTx2Wv/vJcx8Tgv+V9MycM3WdumoLlFCx09qGHAvUcmsOUSQjWLYmZnz6xAp2QIHohSvjHeeip1CEbVfrnvJ0=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 p15-20020a170902e74f00b001d90a67e10bsm675926plf.109.2024.02.05.19.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 19:42:41 -0800 (PST)
Date: Tue, 6 Feb 2024 11:42:35 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/6] migration/multifd: Fix channel creation vs.
 cleanup races
Message-ID: <ZcGqq5kTiLGU0z_r@x1n>
References: <20240205194929.28963-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240205194929.28963-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Feb 05, 2024 at 04:49:23PM -0300, Fabiano Rosas wrote:
> Based-on: 20240202102857.110210-1-peterx@redhat.com
> [PATCH v2 00/23] migration/multifd: Refactor ->send_prepare() and cleanups
> https://lore.kernel.org/r/20240202102857.110210-1-peterx@redhat.com
> 
> Hi,
> 
> In this v2 I made sure NO channel is created after the semaphores are
> posted. Feel free to call me out if that's not the case.

Queued into -staging.  Plan to send a pull only before I'll be out (Feb
9-19), so comments are still welcomed.  Thanks.

-- 
Peter Xu


