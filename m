Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9BEC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romX6-0003mG-D5; Mon, 25 Mar 2024 11:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1romX5-0003le-08
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1romX3-00036s-MN
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711381601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1WgUhxGvLKQM7pXn51HC9HNkHyqsbCYFVn7chblxagw=;
 b=QPA8xiebhKr8xKfDGfDVfwmGMy7NOKMJbBG3IpB/p9E3ixHTBwaAXD96WTweZ50dWZbdou
 Hd4WVDWuJ+ZOzXuwPtBaXQq2LP8Q0qh2ChLfr6ZyptFsvmKr/MRCEMGyFYyKrJRRSh1cV4
 NP943C0o9nWPUNSv7qyP2kN/WCOPbYc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-l_a4a4YXM-Om4HsOIQwz5A-1; Mon, 25 Mar 2024 11:46:38 -0400
X-MC-Unique: l_a4a4YXM-Om4HsOIQwz5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76278890FC2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 15:46:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56CD61121312
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 15:46:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 57CEB21E6757; Mon, 25 Mar 2024 16:46:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH] qapi: document InputMultiTouchType
In-Reply-To: <20240325095648.2835381-1-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Mon, 25 Mar 2024 13:56:48 +0400")
References: <20240325095648.2835381-1-marcandre.lureau@redhat.com>
Date: Mon, 25 Mar 2024 16:46:33 +0100
Message-ID: <8734se1fhi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Squashing in

diff --git a/qapi/pragma.json b/qapi/pragma.json
index 6929ab776e..92715d22b3 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -62,8 +62,6 @@
         'ImageInfoSpecificKind',
         'InputAxis',
         'InputButton',
-        'InputMultiTouchEvent',
-        'InputMultiTouchType',
         'IscsiHeaderDigest',
         'IscsiTransport',
         'JSONType',


