Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A9DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjBAV-0005TJ-Sj; Mon, 13 Jul 2026 03:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjBAU-0005Sy-6T
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjBAR-0001tS-FO
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783928009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=98PwMd80RI/q0Nc6OK8qiGMcTTBsLTZK6j0d2vSLEoI=;
 b=B1cKWBou52Wd9KU7z7eNX6h2hQamalPNOMC+b7tFSv3yFDIyHbJwoGTPUyoc8o5YP+EOIJ
 Hc1BEQ2mOEPZgBZzAoiIIQk69wLWdqMyMxEmjJ5eL5gWCHNHbocvVM9AuuDAD4MUBEs7lT
 ibfGh4/TEX6RNkA9jXj3HLmEX6q557I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-B-SZscBGPvGhoALyqFwPwQ-1; Mon,
 13 Jul 2026 03:33:25 -0400
X-MC-Unique: B-SZscBGPvGhoALyqFwPwQ-1
X-Mimecast-MFC-AGG-ID: B-SZscBGPvGhoALyqFwPwQ_1783928004
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A1BB1955F0F; Mon, 13 Jul 2026 07:33:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 236FB195394B; Mon, 13 Jul 2026 07:33:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B28C321E6920; Mon, 13 Jul 2026 09:33:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  raphael.s.norwitz@gmail.com,  bchaney@akamai.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,  pbonzini@redhat.com,
 yc-core@yandex-team.ru,  mark.caveayland@nutanix.com,  Jason Wang
 <jasowangio@gmail.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v18 02/14] net/tap: improve script/downscript options
 documentation
In-Reply-To: <20260710191809.721154-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 10 Jul 2026 22:17:51 +0300")
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-3-vsementsov@yandex-team.ru>
Date: Mon, 13 Jul 2026 09:33:19 +0200
Message-ID: <87ik6juyww.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

> Properly document defaults and special values of "" and "no".
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


