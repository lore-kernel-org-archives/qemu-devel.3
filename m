Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD43E909BA
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 15:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsMyv-00044L-Iy; Tue, 17 Feb 2026 10:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsMyr-00042w-4H
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:27:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsMyo-0005tx-Qa
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771342033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aSw1nSSq9tRqgZQuZ2g0N2Zy4ddnpqSpB2RJuB6fSQ0=;
 b=Sf06Xv4N8VyzL3aVDEau0j6aKJXotEOxvR1dzlTLIZjn1l+oJxNX1ybp6AyJYPB/yDfjcc
 egDqlL4XM3u5gGqgCs65q2Tr1JHpp56Mi2IlCQveOgvJjwfPFMKuuxo8it7kTxObP5O1Jk
 vPuEInu8d/cUyX4pXSMAzgO15QbnPXY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-eS-gOrDFO_W-CBrrrBcM8g-1; Tue,
 17 Feb 2026 10:27:09 -0500
X-MC-Unique: eS-gOrDFO_W-CBrrrBcM8g-1
X-Mimecast-MFC-AGG-ID: eS-gOrDFO_W-CBrrrBcM8g_1771342027
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46BDA18CDB10; Tue, 17 Feb 2026 15:27:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F9A7180066E; Tue, 17 Feb 2026 15:27:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C4FB221E692D; Tue, 17 Feb 2026 16:27:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com,  sgarzare@redhat.com,  qemu-devel@nongnu.org,
 d-tatianin@yandex-team.ru,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 06/10] qapi: remove user addresses from
 x-query-virtio-vhost-queue-status
In-Reply-To: <86722929-9a4b-49d1-8e69-53f158b20e45@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 17 Feb 2026 15:08:47 +0300")
References: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
 <20260209073908.2125178-7-vsementsov@yandex-team.ru>
 <87zf57n3m7.fsf@pond.sub.org>
 <86722929-9a4b-49d1-8e69-53f158b20e45@yandex-team.ru>
Date: Tue, 17 Feb 2026 16:27:03 +0100
Message-ID: <87342zie60.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 17.02.26 12:03, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> Remove desc, avail, and used fields as they expose process address space
>>> information and violate ASLR.
>> 
>> Isn't the user of the monitor trusted?
>
> I don't know exactly the policy here. If keep these fields, their semantics
> will change anyway with these series. So I decided, it's simpler to drop
> them (if no objections), keeping in mind experimental status of the command
> and ASLR.

The monitor lets you read arbitrary virtual and physical guest memory.
Feels trusted to me :)

"Violate ASLR" suggests security is at stake somehow.  I doubt it is.

"will change anyway" and "it's simpler to drop them" makes me suspect
they're not useful enough to be worth their keep.  If this is the actual
reason for dropping them, please rewrite your commit message to say so.

>> 
>>>                                Since this is an experimental command, we
>>> can safely remove these potentially sensitive fields.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> 
>> Patch looks good.


