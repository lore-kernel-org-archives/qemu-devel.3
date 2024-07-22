Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5E4C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 19:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVzAm-0004is-T7; Mon, 22 Jul 2024 15:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVzAl-0004hj-Ak
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 15:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVzAj-0000GJ-D6
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 15:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721678291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zmz9mr5ZNDWMARlN+kvSujkElo6vpqn2K198ywPca4w=;
 b=LNd4mfII9qNbVoLtgl9d+mxZdcUegUR8aDltq4jzoZHQ6gsrlott1l0q1PPLZJxfLmJsy4
 +41cC2Wgc/f23zMspT5WqfmrIB59GS+ME5//EpzSwpV0CVOlthyABeZxN8VyTC0L328WZG
 rjWiYBU64Ij63JPGFTnGKeLtcfdy8C4=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-2X-oj1pvMI-wBiSx2GMuVQ-1; Mon, 22 Jul 2024 15:58:10 -0400
X-MC-Unique: 2X-oj1pvMI-wBiSx2GMuVQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-70360c6dd2eso75644a34.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 12:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721678289; x=1722283089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmz9mr5ZNDWMARlN+kvSujkElo6vpqn2K198ywPca4w=;
 b=oth7cHm7pDRg/x0z4IFeXcfIwTjlDO1Xt3VKUfSXSzidxs001LdKCSBpVyrdIERwDO
 vMlZnaUg7F6Gri52CVRSbgBaXx678xbjRmYspB3rFBtGrYApQK58DcNLHs1G0N8wdni+
 IhGpyx3GpzFsfzVnmoaVfV9ChGL/YhlUpjZgkWLLtqQo+qh7RBZ3+AIogfu1GUr03GGX
 pyKODW9KVFop57b2Yq8plwGeXil8dRPtG0PlN+xvNcsBkdUuxAWQh8Z8R9iEwV5XIAbr
 BYvwtJhmoGvyyQp4PCXsoCXWuio8CfW6O49sT9OD3FRYj/45nKBvqvl0jND8VXad3CMd
 mwAg==
X-Gm-Message-State: AOJu0YxwbYF8bXBvLspQ2yW9ib2nVDmo+FiEhcAll1g8eoOgT+r+3s0o
 S5mZl3NN1C3Eo8STxkgJiQ2NqxJPVQ8SkuEEaDp9j6eJXsG2radKXmRaHmewIm9KieGtXwSYdF0
 hAv/ti/7/5z4d0Ayxx4QVQyjnX0W0NpDvmDPCOv/AEZInWKRhQIkq
X-Received: by 2002:a05:6808:1408:b0:3da:4c28:66ae with SMTP id
 5614622812f47-3dae60a6293mr4991187b6e.5.1721678289229; 
 Mon, 22 Jul 2024 12:58:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERFp8Y3eLOO3tt1hvAlvkgtT0u6dcE4p6U1hHuTR71/lul5B9h3/2O9OXES1Tqyof1diJUbw==
X-Received: by 2002:a05:6808:1408:b0:3da:4c28:66ae with SMTP id
 5614622812f47-3dae60a6293mr4991172b6e.5.1721678288771; 
 Mon, 22 Jul 2024 12:58:08 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cdbdfb9sm35799801cf.85.2024.07.22.12.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 12:58:08 -0700 (PDT)
Date: Mon, 22 Jul 2024 15:58:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 0/9] migration/multifd: Remove
 multifd_send_state->pages
Message-ID: <Zp65zvb9oy9my-qY@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240722175914.24022-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On Mon, Jul 22, 2024 at 02:59:05PM -0300, Fabiano Rosas wrote:
> Hi,
> 
> In this v2 I took Peter's suggestion of keeping the channels' pointers
> and moving only the extra slot. The major changes are in patches 5 and
> 9. Patch 3 introduces the structure:
> 
> typedef enum {
>     MULTIFD_PAYLOAD_NONE,
>     MULTIFD_PAYLOAD_RAM,
> } MultiFDPayloadType;
> 
> struct MultiFDSendData {
>     MultiFDPayloadType type;
>     union {
>         MultiFDPages_t ram;
>     } u;
> };
> 
> I added a NONE type so we can use it to tell when the channel has
> finished sending a packet, since we'll need to switch types between
> clients anyway. This avoids having to introduce a 'size', or 'free'
> variable.

This at least looks better to me, thanks.

> 
> WHAT'S MISSING:
> 
> - The support for calling multifd_send() concurrently. Maciej has this
>   in his series so I didn't touch it.
> 
> - A way of adding methods for the new payload type. Currently, the
>   compression methods are somewhat coupled with ram migration, so I'm
>   not sure how to proceed.

What is this one?  Why compression methods need new payload?  Aren't they
ram-typed?

> 
> - Moving all the multifd ram code into multifd-ram.c after this^ is
>   sorted out.
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1381005020
> 
> v1:
> https://lore.kernel.org/r/20240620212111.29319-1-farosas@suse.de
> 
> First of all, apologies for the roughness of the series. I'm off for
> the next couple of weeks and wanted to put something together early
> for your consideration.

PS: I assume this is old content, or I'll envy you on how frequent you can
take days off!..

> 
> This series is a refactoring (based on an earlier, off-list
> attempt[0]), aimed to remove the usage of the MultiFDPages_t type in
> the multifd core. If we're going to add support for more data types to
> multifd, we first need to clean that up.
> 
> This time around this work was prompted by Maciej's series[1]. I see
> you're having to add a bunch of is_device_state checks to work around
> the rigidity of the code.
> 
> Aside from the VFIO work, there is also the intent (coming back from
> Juan's ideas) to make multifd the default code path for migration,
> which will have to include the vmstate migration and anything else we
> put on the stream via QEMUFile.
> 
> I have long since been bothered by having 'pages' sprinkled all over
> the code, so I might be coming at this with a bit of a narrow focus,
> but I believe in order to support more types of payloads in multifd,
> we need to first allow the scheduling at multifd_send_pages() to be
> independent of MultiFDPages_t. So here it is. Let me know what you
> think.
> 
> (as I said, I'll be off for a couple of weeks, so feel free to
> incorporate any of this code if it's useful. Or to ignore it
> completely).
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1340992028
> 
> 0- https://github.com/farosas/qemu/commits/multifd-packet-cleanups/
> 1- https://lore.kernel.org/r/cover.1718717584.git.maciej.szmigiero@oracle.com
> 
> Fabiano Rosas (9):
>   migration/multifd: Reduce access to p->pages
>   migration/multifd: Pass in MultiFDPages_t to file_write_ramblock_iov
>   migration/multifd: Introduce MultiFDSendData
>   migration/multifd: Make MultiFDPages_t:offset a flexible array member
>   migration/multifd: Replace p->pages with an union pointer
>   migration/multifd: Move pages accounting into
>     multifd_send_zero_page_detect()
>   migration/multifd: Isolate ram pages packet data
>   migration/multifd: Don't send ram data during SYNC
>   migration/multifd: Replace multifd_send_state->pages with client data
> 
>  migration/file.c              |   3 +-
>  migration/file.h              |   2 +-
>  migration/multifd-qpl.c       |  10 +-
>  migration/multifd-uadk.c      |   9 +-
>  migration/multifd-zero-page.c |   9 +-
>  migration/multifd-zlib.c      |   4 +-
>  migration/multifd-zstd.c      |   4 +-
>  migration/multifd.c           | 239 +++++++++++++++++++++-------------
>  migration/multifd.h           |  37 ++++--
>  migration/ram.c               |   1 +
>  10 files changed, 201 insertions(+), 117 deletions(-)
> 
> 
> base-commit: a7ddb48bd1363c8bcdf42776d320289c42191f01
> -- 
> 2.35.3
> 

-- 
Peter Xu


