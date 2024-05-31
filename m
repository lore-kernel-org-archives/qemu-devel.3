Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2417C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 16:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4wM-00009E-GT; Fri, 31 May 2024 12:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sD4wK-000096-QC
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sD4wI-0000T5-UB
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717172226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZopWyojEVEz7Lmz5gbDTo7SQiAvkj73WKdFAtM8m1I8=;
 b=DvIqfVy25CVzqjAgBjoMVoKmaeebyV805TWjazfyruyRTXd5480UTMENenreVsOTLLLGT1
 307/DBMZI6Z68QtwgDPmfNQ8GB6sS64yP3E+lwcdtGOWC7ZA3JTtnlWzUld9Ge2cXHr2SY
 LegKJc8WhydqGom6BcvFYk/O8AgLSqY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-z-7yd6JXNimNs7lo9jfL9Q-1; Fri, 31 May 2024 12:17:03 -0400
X-MC-Unique: z-7yd6JXNimNs7lo9jfL9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69501800CA2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 16:17:03 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94F502026D68
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 16:17:02 +0000 (UTC)
Date: Fri, 31 May 2024 11:17:01 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 0/2] NBD patches for 2024-05-30
Message-ID: <4ximmjurd5qkiryq76wsiff6ece7q7fkbodmcpuaq5cilxij4w@fhzecidxiyd4>
References: <20240530122300.724226-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530122300.724226-4-eblake@redhat.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_FUZZY_SPRM=0.01,
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

On Thu, May 30, 2024 at 07:22:16AM GMT, Eric Blake wrote:
> The following changes since commit 3b2fe44bb7f605f179e5e7feb2c13c2eb3abbb80:
> 
>   Merge tag 'pull-request-2024-05-29' of https://gitlab.com/thuth/qemu into staging (2024-05-29 08:38:20 -0700)
> 
> are available in the Git repository at:
> 
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2024-05-30
> 
> for you to fetch changes up to 109c59fa3a1cf6be88c2a39b4699a0041c64821f:
> 
>   iotests: test NBD+TLS+iothread (2024-05-30 07:18:42 -0500)
> 
> ----------------------------------------------------------------
> NBD patches for 2024-05-30
> 
> - Fix AioContext assertion with NBD+TLS
> 
> ----------------------------------------------------------------
> Eric Blake (2):
>       qio: Inherit follow_coroutine_ctx across TLS
>       iotests: test NBD+TLS+iothread

Patch 2/2 only works on machines with /home/eblake; I will fix that in
a v2 pull request.

(And this should spur me to write a local commit hook that makes sure
I don't leak stuff like that in future commits...)

> 
>  io/channel-tls.c                              |  26 ++--
>  io/channel-websock.c                          |   1 +
>  tests/qemu-iotests/tests/nbd-tls-iothread     | 168 ++++++++++++++++++++++++++
>  tests/qemu-iotests/tests/nbd-tls-iothread.out |  54 +++++++++
>  4 files changed, 238 insertions(+), 11 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/nbd-tls-iothread
>  create mode 100644 tests/qemu-iotests/tests/nbd-tls-iothread.out
> 
> -- 
> 2.45.1
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


