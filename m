Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CE7C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 22:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXqG4-0006X4-Fq; Wed, 07 Feb 2024 17:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXqG3-0006Wg-3j
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 17:19:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXqG1-0002Zx-8U
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 17:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707344344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5FfcgAnW/Rafli5msod7hRvM06fdrwojwHabIhnfSQ=;
 b=YEplzqCtWyOEWX2S/f5lfmTfy32pPnsXTPBIgPdTAeG5UjMfYzWNeXtz6RmjREogW4f+9I
 1ZLsZqlRZBSVN+Co3O1eA8HrxIhxlbPvF+0VlWE6T9VircVGQ5xsLe1f5P+aKVeTogTOwz
 CdqE/HjNH+TuW7AGMEbxsF9DUwJ73sY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-nr2a-LjmN6Sa5NgZmdJEAQ-1; Wed,
 07 Feb 2024 17:19:02 -0500
X-MC-Unique: nr2a-LjmN6Sa5NgZmdJEAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62ADD3806712;
 Wed,  7 Feb 2024 22:19:02 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C8AA1C14B04;
 Wed,  7 Feb 2024 22:19:01 +0000 (UTC)
Date: Wed, 7 Feb 2024 23:19:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PULL 0/1] Block patches
Message-ID: <ZcQB1FH8Kqt5xn0v@redhat.com>
References: <20240206153105.81868-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206153105.81868-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 06.02.2024 um 16:31 hat Stefan Hajnoczi geschrieben:
> The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:
> 
>   Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> 
> for you to fetch changes up to 1d52cc0ac27761e296b14655c2f5b2649ee69491:
> 
>   virtio-blk: avoid using ioeventfd state in irqfd conditional (2024-02-06 10:22:18 -0500)
> 
> ----------------------------------------------------------------
> Pull request
> 
> A bug fix for in-flight I/O during ioeventfd shutdown.
> 
> ----------------------------------------------------------------
> 
> Stefan Hajnoczi (1):
>   virtio-blk: avoid using ioeventfd state in irqfd conditional

I noticed that this patch is also in the pull request I sent, so I
guess if mine goes through, you don't have to process this one
separately.

Kevin


