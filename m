Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262A2C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXbD-000748-73; Mon, 29 Jan 2024 14:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rUXb5-0006tu-Sf
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:47:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rUXb3-00079w-UN
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706557629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bv7ZPrL2DdnvWdsg1TBLPZCfANlgz6Ea2C/j7MmvWUU=;
 b=iKmB1zOjYU+PjFCpY0Vu6leOMVRWdKiuW1Py8AoT8Lpnyj1vbreG1xOugUDdRXT8HT/AIM
 LppZXxZRKm/Sp93awok2A9jZx0lnE16vvM5ud5eTY9DjMZx4Haw7dIGZ8MJZneJFsGWE/S
 B9nCrIOmXmqopynH4QmTZw4bRJ7Zj6M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-P8y-ieREPiqSx4TkuztnvA-1; Mon,
 29 Jan 2024 14:47:05 -0500
X-MC-Unique: P8y-ieREPiqSx4TkuztnvA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51CDC280D201;
 Mon, 29 Jan 2024 19:47:05 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5D02492BE2;
 Mon, 29 Jan 2024 19:47:04 +0000 (UTC)
Date: Mon, 29 Jan 2024 13:47:03 -0600
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 michael.roth@amd.com, kkostiuk@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH 2/5] qapi: Drop redundant documentation of conditional
Message-ID: <lmy7tadhdotpatdebwj5yfnl66ufi2i5ensvfsnjkqtsukqnvb@i6oenibtes7q>
References: <20240129115008.674248-1-armbru@redhat.com>
 <20240129115008.674248-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129115008.674248-3-armbru@redhat.com>
User-Agent: NeoMutt/20231221
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jan 29, 2024 at 12:50:05PM +0100, Markus Armbruster wrote:
> Documentation generated for dump-skeys contains
> 
>     This command is only supported on s390 architecture.
> 
> and
> 
>     If
>     ~~
> 
>     "TARGET_S390X"
> 
> The former became redundant in commit 901a34a400a (qapi: add 'If:'
> section to generated documentation) added the latter.  Drop the
> former.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/misc-target.json | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


