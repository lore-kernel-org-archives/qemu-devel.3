Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0D7C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 07:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u231K-00007g-CO; Tue, 08 Apr 2025 03:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u231A-0008Pa-2p
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2317-0007wv-AI
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744095903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zl8/Fb83/9Jx4eF4HEyigjp5b6wJMcLECXWiIl3j2yA=;
 b=QyBaR8AfAtFdBu47n7+CjbNgMUP1XLidxvrtpXmvSmoEyecnHenBE4vrq9mvjBwHBC/S9b
 xrdXwqI9Hd+2PsmKiix1+6djannT9FAWpKsF0UqJ6JJA+YGirN55o6lK8YLxoXUhr50+pE
 2p8hGMDCQY7soUnW8zLRj8aZ3yrVnFw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-Vp_hBBIWOjCdcVdCFULq4A-1; Tue,
 08 Apr 2025 03:04:58 -0400
X-MC-Unique: Vp_hBBIWOjCdcVdCFULq4A-1
X-Mimecast-MFC-AGG-ID: Vp_hBBIWOjCdcVdCFULq4A_1744095897
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82C1119560A1; Tue,  8 Apr 2025 07:04:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2CAA180174E; Tue,  8 Apr 2025 07:04:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 472B621E6757; Tue, 08 Apr 2025 09:04:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  kkostiuk@redhat.com,
 kwolf@redhat.com,  jsnow@redhat.com,  peter.maydell@linaro.org,
 jiri@resnulli.us,  qemu-block@nongnu.org
Subject: Re: [PATCH 02/11] qapi/rocker: Tidy up query-rocker-of-dpa-flows
 example
In-Reply-To: <kbaql55o6yefqrftuypdmeiblwl6mrxat5xih22u6i35emnaf3@5umk7xkgcfcy>
 (Eric Blake's message of "Mon, 7 Apr 2025 10:06:21 -0500")
References: <20250404121413.1743790-1-armbru@redhat.com>
 <20250404121413.1743790-3-armbru@redhat.com>
 <kbaql55o6yefqrftuypdmeiblwl6mrxat5xih22u6i35emnaf3@5umk7xkgcfcy>
Date: Tue, 08 Apr 2025 09:04:53 +0200
Message-ID: <87o6x7p20a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Eric Blake <eblake@redhat.com> writes:

> On Fri, Apr 04, 2025 at 02:14:04PM +0200, Markus Armbruster wrote:
>> The command can return any number of RockerOfDpaFlow objects.  The
>> example shows it returning exactly two, with the second objecy's
>
> object's

Fixing...  thanks!

>> members elided.  Tweak it so it elides elements after the first
>> instead.


