Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48021C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4HwC-0007Qg-6J; Wed, 09 Sep 2026 09:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4Hw6-0007Q9-0r
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 09:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4Hw4-0000v2-At
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 09:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788958915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FLU976XtxMmtdQprxvUsabce6scBP2ndW/rNnXnhyZo=;
 b=AENrAkmS7Xzbzy3Jn9aaOPPVBH2MCPoy+dywRR1TTT4QQm49nI5MgEGfsae0kMfBt28+kT
 EjiV+nyowOKLtfDl9qt3YGmq1je263o/e32ZnkU+kb7gFsBuY/UGgy0z9mLOXq1wwRD9DE
 /HFeLg8C25oR6tMg0Bj2x5vT78cRqM4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-kHJ5kGixPsGNmgg1EhopEw-1; Wed, 09 Sep 2026 09:01:51 -0400
X-MC-Unique: kHJ5kGixPsGNmgg1EhopEw-1
X-Mimecast-MFC-AGG-ID: kHJ5kGixPsGNmgg1EhopEw_1788958910
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c2580a59d0dso509576066b.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 06:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788958910; x=1789563710; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FLU976XtxMmtdQprxvUsabce6scBP2ndW/rNnXnhyZo=;
 b=oMiBw3LsgTwNBv/n3XK/EMrLS3rr0xWXN42tprmm3HyZvGjXr2cOs4L5eCyFW8t6NR
 UnYSqmJxK2gRoUYHSPzbqYPB5xum3mknKQWRVllq55iSLtJHts7eSRk6LMKeqBayekQM
 bLw/04xBDaASti9ADzJyf9FQYZaOXFLyotdvyBAG+ePkiFOl4Z7AHWOskB6IAx0Bv/Bv
 aWwwr8brFnS85Roa822EPcBQbRH4Rd4BVTZGA7hYsS5GPDTyISdarLBoG2I3XFYZefuS
 KvdatyWtkcDL6Q3BpDuzYk/x/ddALRIXGdByeT3RkTxznKL3LuuQ/PakrCZt18o81dVB
 VWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788958910; x=1789563710;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FLU976XtxMmtdQprxvUsabce6scBP2ndW/rNnXnhyZo=;
 b=Pv0GMVawY6dGF/DGGrobzr6dL3ZhnMZb+ixRhfD9jlU/+rCoSvhyWiUGkma6qXzu+4
 EEAdhU8xhrRJiQfMvju1tJAyhY/AN78b6Duz0pxR8wTkHvrvIc+AUFMmVThPoPzUHf8n
 YlTxiqG7t+RvGJQ8bMfY2whuNeTUanHryd/dcgcu10sUaN+I8WhniWvaarxTyzqLhS1b
 iW/80UZT3Hhd5xLQxmHk9E1llsksftisoi1B15Zp9atV2i07Q60W6puQ08gbR+M4czke
 eg2KhqkF5h8RddrffaIjMWjf2QJj1gkkr+ipCBmmxlQSr1d1n/fWH6d6tpbdkAg/PG85
 L/qQ==
X-Gm-Message-State: AFuF++m+MfQ5Ah2aj7SBUtHFQ165X3wYAym/Ko0oBRs8B+4pjbS4/69H
 d9HFnCyTWP84eCk+Q4DLMIVGhEUpZuopypnPN4lfgO8kyyOVJjv5GyeZSUvu3HJ57fmdH05nUEC
 522J0H5FvcUfAE34nkUN5pps4oIA/BJXoIbmWpR9Stl6kAlx9qIVYE2HK
X-Gm-Gg: AYBFou350qQA680MOYosxVwPiEj47AHdk8WgG784mzk0uCTj/1lGoU/58JCIAgqS6fc
 nsXkWFSMAIpLvHjNTABblPzPnjylGgILEPwvlpUg+YfFb/M89odjFGGqIMZ3wgYd6hcHmgNJ/fA
 4u47pZWd9l+PA8rPf2Fn5zBMoJKNxjKQlmJXVD3FgxTOrW6VpDdDGyKn3fNzfkd7QcdAqDWTICZ
 y1xVA5g+rte7pa9BxsRLe2Ba7tdjeQRlNrojw/e5eZd49QoUMI9DW6pWsRV+N4ND48JUvSr6/Xq
 2tu5Z623ENwwL8HkobtlDL9GKRnA4QKtje97kQLm9HmlX/4FH5zwNctd4ISI/uBK7N1xtktQ/Ez
 MOroC+sYmx9Y5U+cVc9OHeVk=
X-Received: by 2002:a17:906:628b:b0:c29:349e:7c1d with SMTP id
 a640c23a62f3a-c29349e8809mr143101266b.49.1788958910225; 
 Wed, 09 Sep 2026 06:01:50 -0700 (PDT)
X-Received: by 2002:a17:906:628b:b0:c29:349e:7c1d with SMTP id
 a640c23a62f3a-c29349e8809mr143094066b.49.1788958909507; 
 Wed, 09 Sep 2026 06:01:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5768c2sm750298166b.39.2026.09.09.06.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 06:01:46 -0700 (PDT)
Date: Wed, 9 Sep 2026 09:01:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Fishman <afishman@redhat.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v1 0/2] vhost: Handle vrings crossing virtio-mem slots
Message-ID: <20260909090119-mutt-send-email-mst@kernel.org>
References: <20260909125923.75340-1-afishman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909125923.75340-1-afishman@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 09, 2026 at 03:59:21PM +0300, Alex Fishman wrote:
> Virtio-mem dynamic memslots are intentionally exposed as separate memory
> regions. If a guest places a vring part across two adjacent slots, a later
> memory update fails vhost ring verification because the complete ring part
> is not contained in one vhost memory region.

when does this happen?

> Coalesce coherent adjacent sections only when a descriptor table,
> available ring, or used ring crosses their boundary. Unrelated
> unmergeable sections remain separate so they can still be updated
> independently.
> 
> Patch 2 adds an end-to-end qtest reproducer using a fake vhost-user
> backend and virtio-mem dynamic memslots. It also verifies that a newly
> activated slot is not folded into the merge required by the crossing
> vring.
> 
> Tested with the vhost-user/mem-slots/boundary qtest.
> 
> Buglink: https://redhat.atlassian.net/browse/RHEL-146583
> 
> Alex Fishman (2):
>   vhost: coalesce unmergeable sections across vring boundaries
>   tests/qtest: Add vhost-user memslot boundary test
> 
>  hw/virtio/vhost.c             |  72 ++++++-
>  tests/qtest/vhost-user-test.c | 395 +++++++++++++++++++++++++++++++++-
>  2 files changed, 452 insertions(+), 15 deletions(-)
> 
> 
> base-commit: ff1d2d19d7e24893e2012d879f8e73077e17b9bd
> -- 
> 2.52.0


