Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97534C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcS0H-0004oV-9X; Tue, 20 Feb 2024 10:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcS0D-0004le-I9
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:25:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcS0C-0007Dk-0Y
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708442747;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gI7ZKLNNQeK0mPjkkPY21k6GsO8VNr8GNrp4jxtMbGs=;
 b=DTbTvwO/w3PFxqfi4qj4cZ7DMWyrc6eUa+WaL2pNq2lHzYJHWltKuhF7gwhRuc/hmGAgAw
 ekQPRAjcZxJ1LgDF/vs6oZm4ti8x2il5/KkJ0mhh9NSXpPOmknWgmSqk9ihrQZKzGNEctt
 m1KOhWoUrScPVvWl2q29RsNiuH2Hx+o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-cCr-AVy9Pf2uiw3Tqj_N2w-1; Tue,
 20 Feb 2024 10:25:42 -0500
X-MC-Unique: cCr-AVy9Pf2uiw3Tqj_N2w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0731629AC03D;
 Tue, 20 Feb 2024 15:25:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A6702201154D;
 Tue, 20 Feb 2024 15:25:40 +0000 (UTC)
Date: Tue, 20 Feb 2024 15:25:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com,
 eblake@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH 16/16] qapi: Divorce QAPIDoc from QAPIParseError
Message-ID: <ZdTEciiUzzPcndDf@redhat.com>
References: <20240216145841.2099240-1-armbru@redhat.com>
 <20240216145841.2099240-17-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216145841.2099240-17-armbru@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 16, 2024 at 03:58:40PM +0100, Markus Armbruster wrote:
> QAPIDoc stores a reference to QAPIParser just to pass it to
> QAPIParseError.  The resulting error position depends on the state of
> the parser.  It happens to be the current comment line.  Servicable,
> but action at a distance.
> 
> The commit before previous moved most uses of QAPIParseError from
> QAPIDoc to QAPIParser.  There are just three left.  Convert them to
> QAPISemError.  This involves passing info to a few methods.  Then drop
> the reference to QAPIParser.
> 
> The three errors lose the column number.  Not really interesting here:
> it's the comment line's indentation.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/parser.py                      | 66 +++++++++------------
>  tests/qapi-schema/doc-duplicated-arg.err    |  2 +-
>  tests/qapi-schema/doc-duplicated-return.err |  2 +-
>  tests/qapi-schema/doc-duplicated-since.err  |  2 +-
>  tests/qapi-schema/doc-empty-arg.err         |  2 +-
>  5 files changed, 32 insertions(+), 42 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


