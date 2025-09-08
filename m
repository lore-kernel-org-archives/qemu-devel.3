Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C5DCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf6l-00057d-3k; Mon, 08 Sep 2025 12:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvf6j-000561-4b
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvf6b-0001TM-Fa
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350355;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RhZiRWyvBwFQKiJtTP8nPR1Qrr+mJJu4ljCuHdH7/H8=;
 b=henIQiVN3/rgVdJDX7w3/fruGK8UB8UAfIlJNFNhV0bCVWAoMIs2HrvEUTC7F3iO+pk064
 Idb+f5eHCNc9E1773B9EPg9+Kr//c587wVN4JLsMzP31YGVczkC0Mnx4JhKCpCcGpRPGwx
 X8H2RzPcJuYF/5UgbezjYVkrgp9HlnU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-8FXb64XNNGuJLMCdj-ZgJQ-1; Mon,
 08 Sep 2025 12:52:32 -0400
X-MC-Unique: 8FXb64XNNGuJLMCdj-ZgJQ-1
X-Mimecast-MFC-AGG-ID: 8FXb64XNNGuJLMCdj-ZgJQ_1757350351
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F7621800447; Mon,  8 Sep 2025 16:52:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E1FA19560A2; Mon,  8 Sep 2025 16:52:28 +0000 (UTC)
Date: Mon, 8 Sep 2025 17:52:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 11/18] python: backport 'Remove deprecated
 get_event_loop calls'
Message-ID: <aL8JyfCHSXJbNIGV@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
 <20250903051125.3020805-12-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903051125.3020805-12-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 03, 2025 at 01:11:17AM -0400, John Snow wrote:
> This method was deprecated in 3.12 because it ordinarily should not be
> used from coroutines; if there is not a currently running event loop,
> this automatically creates a new event loop - which is usually not what
> you want from code that would ever run in the bottom half.
> 
> In our case, we do want this behavior in two places:
> 
> (1) The synchronous shim, for convenience: this allows fully sync
> programs to use QEMUMonitorProtocol() without needing to set up an event
> loop beforehand. This is intentional to fully box in the async
> complexities into the legacy sync shim.
> 
> (2) The qmp_tui shell; instead of relying on asyncio.run to create and
> run an asyncio program, we need to be able to pass the current asyncio
> loop to urwid setup functions. For convenience, again, we create one if
> one is not present to simplify the creation of the TUI appliance.
> 
> The remaining user of get_event_loop() was in fact one of the erroneous
> users that should not have been using this function: if there's no
> running event loop inside of a coroutine, you're in big trouble :)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> cherry picked from commit aa1ff9907603a3033296027e1bd021133df86ef1
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/qmp/legacy.py  | 9 ++++++++-
>  python/qemu/qmp/qmp_tui.py | 7 ++++++-
>  python/tests/protocol.py   | 2 +-
>  3 files changed, 15 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


