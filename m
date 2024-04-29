Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFFDC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 18:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1VwE-0002ku-L4; Mon, 29 Apr 2024 14:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1Vw7-0002hw-Ep
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1Vw2-0007Uc-T8
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714416064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uluux/u1LKeVheqhS5aONC4PYCxbdzWnHvKnuNkU7X4=;
 b=anMXZ/GWM5AUPIM80Q6osA5vw71BEPOcEZkErFCEzbfmEchwytt6pT1MGc1+XmlUydvAoC
 YNk7mSZSXEJvJ1XjYMGsoyDn3g8mcVq/ArS2lazBy0Nmi7ySQW+UEioVq03q+0IyQ/WJ0q
 MBWR9wrcEIXJ17oo9+EvdvzIlI+mf+A=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-kmj6mBmNOsm3tmeTYW5L1Q-1; Mon, 29 Apr 2024 14:41:02 -0400
X-MC-Unique: kmj6mBmNOsm3tmeTYW5L1Q-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6f05561060aso548917b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 11:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714416062; x=1715020862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uluux/u1LKeVheqhS5aONC4PYCxbdzWnHvKnuNkU7X4=;
 b=IZwF4yiYwBLoY27VIzAfRTSHukdeaTDblY5JN+HdYSGN9niAglW4rXpx3DF+wm9dhf
 LQKUnL3UIzjRLHHWo3uC79AfqUyp7MbvYJGvYTwUDQm25vVWG46pwVQy2NIo0ojIfKfp
 B0pLxCGIOXh5houi8+ZUv0RrQzNnfQ6qlelCAZOYzYgpZFObIjt5sf69ido8AUdr+7k+
 Jo2bzzeesmwPDQFZpG9bIj/7qQ9OzVyu2tUsIfptjZfFeXWUBCIzluST6HXYiZFN0at2
 p6N0JzC6m/Wsl5VmD5jTlxba6oatLMNLVktZxkSXk6DYlIOlxRIRiD4T7G0CkDJ/sf/3
 MzpA==
X-Gm-Message-State: AOJu0YzwO4IFmsrV9NaoH/HPiXVmECHPvellftF5+AaUJspSsfyJYjSJ
 yWE55bwR0HFweVIAoft7dOQ9gGIG9COg1ekdJ67+AXitPa6uFai2m7AnvHQv9U8Z/ioulc8NqFC
 KaqkOvQfpB40zH9uv04ZCaHjdFqNRfcTgB3EYYpd1CPdJHzSWVf2z
X-Received: by 2002:a05:6a00:8e07:b0:6ed:6944:b170 with SMTP id
 io7-20020a056a008e0700b006ed6944b170mr12352082pfb.1.1714416061266; 
 Mon, 29 Apr 2024 11:41:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa264SCrDS36v2dLmGS+5buWW/mzDjYf5BzhGLxq+5sCFBuNcjM+bWZd+WxWRMMUMAYNSoVw==
X-Received: by 2002:a05:6a00:8e07:b0:6ed:6944:b170 with SMTP id
 io7-20020a056a008e0700b006ed6944b170mr12352056pfb.1.1714416060524; 
 Mon, 29 Apr 2024 11:41:00 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 r84-20020a632b57000000b00601df0a973dsm12816388pgr.48.2024.04.29.11.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 11:41:00 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:40:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 6/6] migration: Deprecate fd: for file migration
Message-ID: <Zi_puGn7Y1ArcLCL@x1n>
References: <20240426131408.25410-1-farosas@suse.de>
 <20240426131408.25410-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426131408.25410-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Fri, Apr 26, 2024 at 10:14:08AM -0300, Fabiano Rosas wrote:
> The fd: URI can currently trigger two different types of migration, a
> TCP migration using sockets and a file migration using a plain
> file. This is in conflict with the recently introduced (8.2) QMP
> migrate API that takes structured data as JSON-like format. We cannot
> keep the same backend for both types of migration because with the new
> API the code is more tightly coupled to the type of transport. This
> means a TCP migration must use the 'socket' transport and a file
> migration must use the 'file' transport.
> 
> If we keep allowing fd: when using a file, this creates an issue when
> the user converts the old-style (fd:) to the new style ("transport":
> "socket") invocation because the file descriptor in question has
> previously been allowed to be either a plain file or a socket.
> 
> To avoid creating too much confusion, we can simply deprecate the fd:
> + file usage, which is thought to be rarely used currently and instead
> establish a 1:1 correspondence between fd: URI and socket transport,
> and file: URI and file transport.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/about/deprecated.rst | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0fb5c82640..813f7996fe 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -464,3 +464,17 @@ both, older and future versions of QEMU.
>  The ``blacklist`` config file option has been renamed to ``block-rpcs``
>  (to be in sync with the renaming of the corresponding command line
>  option).
> +
> +Migration
> +---------
> +
> +``fd:`` URI when used for file migration (since 9.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``fd:`` URI can currently provide a file descriptor that
> +references either a socket or a plain file. These are two different
> +types of migration. In order to reduce ambiguity, the ``fd:`` URI
> +usage of providing a file descriptor to a plain file has been
> +deprecated in favor of explicitly using the ``file:`` URI with the
> +file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
> +command documentation for details on the ``fdset`` usage.

Wanna do some warn_report() when detected non-socket fds alongside?  Looks
like we previously do this for all deprecations.

What's the plan when it's support removed?  I'm imaginging that we sanity
check fstat() + S_ISSOCK on the fd and fail otherwise?  In that case we can
have the code there, dump warn_report(), then switch to failing qmp migrate
(and incoming side) later on?

-- 
Peter Xu


