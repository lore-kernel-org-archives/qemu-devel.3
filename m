Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E822C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 09:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWWrM-0004rM-Fe; Tue, 01 Jul 2025 05:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1uWWr6-0004nQ-Eu
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1uWWr3-0008DT-LC
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751360437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GrCdSCN38LZMasr8Gy/kcK7FoAXjA+KcKz43ecc02sQ=;
 b=FdYWSfHdgk2TckHvFaW0l5+jfpLydM33D76f1HKWH7iZuuYo1LNcJc6IT59lSt/+kmQRUD
 kWIIVh19trq5om2WZ0A/3uzZDbHgmySXIFmjOhkADKQVryEoSSnPjmy3b7Y09kDUNq7rii
 3j/uLPefJQ7P9I3jgNwYBpOGCepHpsU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-yHzZwMEEMJCsDHuSyRJfAQ-1; Tue,
 01 Jul 2025 05:00:34 -0400
X-MC-Unique: yHzZwMEEMJCsDHuSyRJfAQ-1
X-Mimecast-MFC-AGG-ID: yHzZwMEEMJCsDHuSyRJfAQ_1751360433
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AD721801213; Tue,  1 Jul 2025 09:00:33 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.226.87])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 043F019560A7; Tue,  1 Jul 2025 09:00:29 +0000 (UTC)
Date: Tue, 1 Jul 2025 11:00:26 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Jiri Denemark <jdenemar@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 devel@lists.libvirt.org, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 18/24] qapi/migration: Deprecate capabilities commands
Message-ID: <aGOjqg9BEOU1aUR0@angien.pipo.sk>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-19-farosas@suse.de>
 <aGOelCDCARRgIy2I@orkuz.int.mamuti.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGOelCDCARRgIy2I@orkuz.int.mamuti.net>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
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

On Tue, Jul 01, 2025 at 10:38:44 +0200, Jiri Denemark via Devel wrote:
> On Mon, Jun 30, 2025 at 16:59:07 -0300, Fabiano Rosas wrote:
> > The concept of capabilities is being merged into the concept of
> > parameters. From now on, the commands that handle capabilities are
> > deprecated in favor of the commands that handle parameters.
> > 
> > Affected commands:
> > 
> > - migrate-set-capabilities
> > - query-migrate-capabilities
> > 
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  docs/about/deprecated.rst      | 12 ++++++++++++
> >  migration/migration-hmp-cmds.c |  6 ++++++
> >  qapi/migration.json            | 16 ++++++++++++++--
> >  3 files changed, 32 insertions(+), 2 deletions(-)
> 
> We'll need to adapt libvirt as both commands are actively used now. Is
> there a way of detecting where the relevant commands for
> setting/querying parameters support capabilities? I guess QAPI schema
> should work, right?

The parameters command gains the fields from "migrate-set-capabilities"
which is easy to query. Alternatively we can query the "deprecated"
feature as well.


