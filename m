Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08973C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXY2-0004MD-3U; Mon, 29 Jan 2024 14:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rUXXz-0004LT-NW
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:43:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rUXXy-0006cD-9Y
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706557436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pEu620ssHrUBLWur1ycgM2+DF4cTYN5195txyl1fwYQ=;
 b=XyRvTT1Rha/R+oymGSACrkA9A4Xw5zhy2fDvdQZRd8AfIJ18K17BPUhalHm2JizdP+7BKI
 XTunxv47CG1FWD7gRhwSWS9877BFR3waHQUw5EkD/RWoy0DIO9twKO4IAl4HWl82YLitik
 JhQwm+QteQXjLuDR78HLHJjT883+lD8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-Zz0tWygqMNSvhmp6g5ziTA-1; Mon,
 29 Jan 2024 14:43:54 -0500
X-MC-Unique: Zz0tWygqMNSvhmp6g5ziTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56564280D200;
 Mon, 29 Jan 2024 19:43:54 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0F59C0FDEE;
 Mon, 29 Jan 2024 19:43:53 +0000 (UTC)
Date: Mon, 29 Jan 2024 13:43:52 -0600
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 michael.roth@amd.com, kkostiuk@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH 3/5] qapi: Elide "Potential additional modes" from
 generated docs
Message-ID: <ttbclnjd5a3tj2gwoh2bjh7xz7bhp6zia6r3bigjr6i3ktwrmw@lgvh46x35im6>
References: <20240129115008.674248-1-armbru@redhat.com>
 <20240129115008.674248-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129115008.674248-4-armbru@redhat.com>
User-Agent: NeoMutt/20231221
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jan 29, 2024 at 12:50:06PM +0100, Markus Armbruster wrote:
> Documentation of BlockExportRemoveMode has
> 
>     Potential additional modes to be added in the future:
> 
>     hide: Just hide export from new clients, leave existing connections
>     as is.  Remove export after all clients are disconnected.
> 
>     soft: Hide export from new clients, answer with ESHUTDOWN for all
>     further requests from existing clients.
> 
> I think this is useful only for developers.  Elide it from generated
> documentation by turning it into a TODO section.
> 
> This effectively reverts my own commit b71fd73cc45 (Revert "qapi:
> BlockExportRemoveMode: move comments to TODO").  At the time, I was
> about to elide TODO sections from the generated manual, I wasn't sure
> about this one, and decided to avoid change.  And now I've made up my
> mind.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/block-export.json | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


