Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEA7C83039
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 08:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWVzT-0006xF-IG; Tue, 01 Jul 2025 04:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWVzQ-0006vm-8Y
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWVzK-00076V-1w
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751357106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ojrTHoejnB75rDlg2G0qEAtTu5b5yEO+lCvNb0pdTMc=;
 b=i9N8p6u+8XV+hjQ7hRMp0mjoZkDG1LcCsVXSDiIT9xp2z8zpNRxc7NVgg5g7HrYLnflU/i
 Oe7oMQN9GypG3NL6vp5Ifb6OQwFhqUSdMIc3cYrKaKcW92TDovhEEpg3roEZ2Q4R56P/53
 q4iXByuhpWaoSbzFmkpUu0+fxbXl2b0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-B2RfRQ4yPCyA7bzctR0spw-1; Tue,
 01 Jul 2025 04:05:03 -0400
X-MC-Unique: B2RfRQ4yPCyA7bzctR0spw-1
X-Mimecast-MFC-AGG-ID: B2RfRQ4yPCyA7bzctR0spw_1751357102
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32EFD190FBC2; Tue,  1 Jul 2025 08:05:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCD03195E74A; Tue,  1 Jul 2025 08:05:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 08CE521E6A27; Tue, 01 Jul 2025 10:04:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Peter Xu
 <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 05/24] qapi/migration: Don't document MigrationParameter
In-Reply-To: <20250630195913.28033-6-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 30 Jun 2025 16:58:54 -0300")
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-6-farosas@suse.de>
Date: Tue, 01 Jul 2025 10:04:59 +0200
Message-ID: <87ecv01glw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> The MigrationParameter (singular) enumeration is not part of the
> migration QMP API, it's only used for nicely converting HMP strings
> into MigrationParameters (plural) members and for providing readline
> completion.
>
> Documenting this enum only serves to duplicate documentation between
> MigrationParameter and MigrationParameters.
>
> Add an exception to QAPIs pragma.json and stop documenting it.

Please add something like

  The generated "QEMU QMP Reference Manual" now lists the enum members
  as "Not documented."  Tolerable.

> Signed-off-by: Fabiano Rosas <farosas@suse.de>

With that
Acked-by: Markus Armbruster <armbru@redhat.com>


