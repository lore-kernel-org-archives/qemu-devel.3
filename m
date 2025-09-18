Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9464BCAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 06:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz7or-0007M5-A3; Thu, 18 Sep 2025 02:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uz7ok-0007L5-CY
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 02:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uz7oi-0005Rg-Tq
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 02:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758175704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1vY3yl0ETmJsyvvjfqpTqFyO1Hgy8q3JWgBRSYrHtm4=;
 b=CzfM2fcPzY4RgqzFzNhBUUaHA/IfR1SCW85Rwb0jJi+IVh4mf9FueyN3h2u15bVMn8edxz
 +gJU5e31roraMSMmYJYOi86JZ/eAJPaPIA3RiE7ksenylS5iRGJgNxpI6OishluhD5r8N1
 DsriiizP6pFVO432JfBQD+rPd8GqiQw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-ERabFORJO3CNyadVoPczzA-1; Thu,
 18 Sep 2025 02:08:20 -0400
X-MC-Unique: ERabFORJO3CNyadVoPczzA-1
X-Mimecast-MFC-AGG-ID: ERabFORJO3CNyadVoPczzA_1758175699
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BA6B19560B5; Thu, 18 Sep 2025 06:08:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A37519560B8; Thu, 18 Sep 2025 06:08:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AFC1E21E6A27; Thu, 18 Sep 2025 08:08:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  qemu-trivial@nongnu.org
Subject: Re: [PATCH trivial] vhost-user-test: remove trailing newlines in
 g_test_message() calls
In-Reply-To: <20250917142919.928244-1-mjt@tls.msk.ru> (Michael Tokarev's
 message of "Wed, 17 Sep 2025 17:29:16 +0300")
References: <20250917142919.928244-1-mjt@tls.msk.ru>
Date: Thu, 18 Sep 2025 08:08:15 +0200
Message-ID: <87qzw41eeo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Michael Tokarev <mjt@tls.msk.ru> writes:

> Fixes: c9a1ea9c52 Revert "tests/qtest: use qos_printf instead of g_test_message"
>

Drop the blank line here.

> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

g_test_message()'s documentation is useless.  Use the force, read the
source: g_test_message() wraps around g_test_log(G_TEST_LOG_MESSAGE,
...), which appends a newline.  So your patch makes sense.

Thanks for cleaning up the mess I made!

Reviewed-by: Markus Armbruster <armbru@redhat.com>


