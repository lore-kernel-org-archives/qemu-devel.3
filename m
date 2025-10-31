Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A6ACCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnWF-0002E4-9J; Fri, 31 Oct 2025 07:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEnWC-0002Db-Jn
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEnW4-00044w-MS
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761910915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9r4dHtuRIy+ufWP05WoCP+EMOLFmHoYYj2W9IDJiLmA=;
 b=VjvsiTdkZFohS/nYsnV+eVgjb3r67IPecVHuKP7zgaX+c/y7CFqfAxMEREY0zbfGR2b8NI
 QwpAB5GNuSD9wsNCyS7Lz2E/DPq4dbB6LVnhspwZl95GveCyPsAHZ7v/Zk1/AiPAfE1gOQ
 r7EEbRInZzX5EbKxz8kn+KSs7tqkxw4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-5NLGSxsJO9WTGt9ytd3PZA-1; Fri,
 31 Oct 2025 07:41:52 -0400
X-MC-Unique: 5NLGSxsJO9WTGt9ytd3PZA-1
X-Mimecast-MFC-AGG-ID: 5NLGSxsJO9WTGt9ytd3PZA_1761910911
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3A42195605F; Fri, 31 Oct 2025 11:41:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37EC71800452; Fri, 31 Oct 2025 11:41:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C1BF21E6A27; Fri, 31 Oct 2025 12:41:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  jsnow@redhat.com,  eblake@redhat.com,
 thuth@redhat.com,  berrange@redhat.com,  philmd@linaro.org,
 kchamart@redhat.com,  mst@redhat.com,  sgarzare@redhat.com
Subject: Re: [PATCH 6/8] docs/interop: Refill QAPI doc comments to conform
 to conventions
In-Reply-To: <8638526b-a5e0-4d90-9977-e97602cac498@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 31 Oct 2025 13:32:33 +0300")
References: <20251031094751.2817932-1-armbru@redhat.com>
 <20251031094751.2817932-7-armbru@redhat.com>
 <8638526b-a5e0-4d90-9977-e97602cac498@yandex-team.ru>
Date: Fri, 31 Oct 2025 12:41:47 +0100
Message-ID: <87346z9u2s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 31.10.25 12:47, Markus Armbruster wrote:
>> For legibility, wrap text paragraphs so every line is at most 70
>> characters long.  Consistently separate sentences with two spaces.
>> Consistently separate member descriptions with a blank line.
>> Signed-off-by: Markus Armbruster<armbru@redhat.com>
>
>
> git show --color-words='[^#[:space:]]+'
>
> shows no difference, except for small fix "Example:" -> ".. qmp-example:"

I had forgotten about that fix.  I'll split it off.

> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks!


