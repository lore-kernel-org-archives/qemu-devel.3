Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC855C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 12:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJtmg-0000YK-3u; Tue, 27 May 2025 08:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uJtmW-0000Wb-VL
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:51:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uJtmR-00036g-IO
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748350300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8lcif6WZvEFkMrgD5xoV0+05IE5e3awoXcEdkoMLJ4M=;
 b=J5Jouhq/kdiMCc62y3aU+XsImMiaLbVK1qUlNr0q9+jXYouQ82rZ4PwfHVM4cl4/QwCrzT
 Iib2Rk0zNWLVYZ63UOgSkgNYajdZOuV7QNNv8dvFyaN0mgZgPBI09ma1uizxLyJAN/SJnG
 RfSyO0k+WFRrcXF8DROgI4WP8mAoiKY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-G_Y5MPp5O3O7g9GkwD2i4Q-1; Tue,
 27 May 2025 08:51:38 -0400
X-MC-Unique: G_Y5MPp5O3O7g9GkwD2i4Q-1
X-Mimecast-MFC-AGG-ID: G_Y5MPp5O3O7g9GkwD2i4Q_1748350297
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C08A1955DAD; Tue, 27 May 2025 12:51:36 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34EEC19560AB; Tue, 27 May 2025 12:51:34 +0000 (UTC)
Date: Tue, 27 May 2025 07:51:31 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, 
 vsementsov@yandex-team.ru, qemu-block@nongnu.org
Subject: Re: [PATCH 00/13] qapi: Doc fixes and improvements
Message-ID: <6east6k4agivwvq7o2pe6c3ogd4xxhvwyp5nhuslulz6ee4xbj@sdip4iyidwca>
References: <20250527073916.1243024-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527073916.1243024-1-armbru@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, May 27, 2025 at 09:39:03AM +0200, Markus Armbruster wrote:
> Markus Armbruster (13):
>   qapi: Tidy up run-together sentences in doc comments
>   qapi: Tidy up whitespace in doc comments
>   qapi: Move (since X.Y) to end of description
>   qapi: Avoid breaking lines within (since X.Y)
>   qapi: Drop a problematic (Since: 2.11) from query-hotpluggable-cpus
>   qapi: Correct spelling of QEMU in doc comments
>   qapi: Fix capitalization in doc comments
>   qapi: Use proper markup instead of CAPS for emphasis in doc comments
>   qapi: Spell JSON null correctly in blockdev-reopen documentation
>   qapi: Refer to job-FOO instead of deprecated block-job-FOO in docs
>   qapi: Mention both job-cancel and block-job-cancel in doc comments
>   qapi: Tidy up references to job state CONCLUDED
>   qapi: Improve documentation around job state @concluded

For the series:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


