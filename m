Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFC4FB44BD
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 06:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGA5Z-0000Z2-Sl; Fri, 24 Apr 2026 02:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGA55-0000Vf-4P
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 02:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGA4t-0007L0-Cg
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 02:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777012308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TeSvvVM9dnxmX2dL1cg2fSvnnzy31L4R719aAiUhsvU=;
 b=XegumxkUx756AOr8PcZAn3xgmaJLRWqFqWXMCvig9upK42zhZKMattQGjmVUdtbEz7vMtE
 coi0UgIJAsRz3RmN/d8wyTpW2/vRXMldI+s+uZGZLcMMNKc3j4IimfZLZQo4RkJv3syFW+
 n9dKhbOQJOQnpzDPBISIPpzfmGnmjI4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-NWiWdZ43Pa2vcymSo9ZWnA-1; Fri,
 24 Apr 2026 02:31:44 -0400
X-MC-Unique: NWiWdZ43Pa2vcymSo9ZWnA-1
X-Mimecast-MFC-AGG-ID: NWiWdZ43Pa2vcymSo9ZWnA_1777012304
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C55E9195609D; Fri, 24 Apr 2026 06:31:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB92219560AB; Fri, 24 Apr 2026 06:31:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5BD2E21E6A28; Fri, 24 Apr 2026 08:31:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com,  sgarzare@redhat.com,  qemu-devel@nongnu.org,
 d-tatianin@yandex-team.ru,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 06/10] qapi: remove user addresses from
 x-query-virtio-vhost-queue-status
In-Reply-To: <20260420202032.714884-7-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 20 Apr 2026 23:20:27 +0300")
References: <20260420202032.714884-1-vsementsov@yandex-team.ru>
 <20260420202032.714884-7-vsementsov@yandex-team.ru>
Date: Fri, 24 Apr 2026 08:31:40 +0200
Message-ID: <87ldecx41f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

> Semantics of these (actually, internal) fields is not simple, they may
> contain either virtual or physical addresses. We are going to change
> this to simplify the logic. Keeping this logic only for unstable
> info command seems too much. Changing semantics of info fields doesn't
> seem to make real sense too. So, let's just drop them. We can dot it,

s/dot/do/

> as command is experimental.

Nitpick: the schema has

    # @unstable: This command is meant for debugging.

Suggest "as the command is unstable".

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


