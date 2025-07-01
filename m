Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DE0C8303A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 09:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWX5i-0003BX-G7; Tue, 01 Jul 2025 05:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWX0P-0000tX-Vf
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWX0K-0001m4-UO
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751361014;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3iQznOCdr7qO+VRwDCPMHYPcxo2wi4ZHvS2UR/WIVR4=;
 b=d9kuzwNQ3WJfB/ULuZifjg0+WmBBUTL0DlyAMPY7ftjqBB1Gxp+ElpzYyNcgSDarEeikUm
 999Ec41DSiZ6gxwvZrM5nnlgXqHT10rFIMK+S7mLKep2UsfaNJNH30x9hD6LoBOfsConbh
 WbnDYe9dcXBepDyxXJhMX7ZJdOP5guI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-AkoSrq4MNE-TpoGUc3yhoQ-1; Tue,
 01 Jul 2025 05:10:11 -0400
X-MC-Unique: AkoSrq4MNE-TpoGUc3yhoQ-1
X-Mimecast-MFC-AGG-ID: AkoSrq4MNE-TpoGUc3yhoQ_1751361010
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED5CD180120C; Tue,  1 Jul 2025 09:10:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.157])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFC1E19560B2; Tue,  1 Jul 2025 09:10:04 +0000 (UTC)
Date: Tue, 1 Jul 2025 10:10:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jiri Denemark <jdenemar@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 devel@lists.libvirt.org, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 18/24] qapi/migration: Deprecate capabilities commands
Message-ID: <aGOl6EMbpeCD0rHW@redhat.com>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-19-farosas@suse.de>
 <aGOelCDCARRgIy2I@orkuz.int.mamuti.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGOelCDCARRgIy2I@orkuz.int.mamuti.net>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 01, 2025 at 10:38:44AM +0200, Jiri Denemark wrote:
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

Query the 'migrate' command schema which gains a new 'config' parameter
in patch 20 in this series.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


