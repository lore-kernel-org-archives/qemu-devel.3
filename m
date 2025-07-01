Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28494C83033
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 08:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWWW2-0000HX-Jf; Tue, 01 Jul 2025 04:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1uWWVz-0000HC-HD
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1uWWVw-0007Hj-Lj
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751359130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1sfspdpnUFDRQGkyjJZ0B63hOl7kLHzIMQh44rJJc4s=;
 b=OuApL8qRDXlrciCAxGYzkMOqVdpOq0Ee/0OCVrH7ov2mLQULuCO8z4DuNipOJvbnkeqizm
 kla7bF/RdTbc/3TPE4wScT/9OKKyNH9z90Im/ou8jDnTkfsgFR8IfAQOH/bTjBw8YKn0zb
 2ih8MGLZmhmB7Q3+5JwLg8DlHakGxNQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-Wz4Yp996NXqR_EFw8Xk7zQ-1; Tue,
 01 Jul 2025 04:38:47 -0400
X-MC-Unique: Wz4Yp996NXqR_EFw8Xk7zQ-1
X-Mimecast-MFC-AGG-ID: Wz4Yp996NXqR_EFw8Xk7zQ_1751359126
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4596E18011CD; Tue,  1 Jul 2025 08:38:46 +0000 (UTC)
Received: from orkuz (unknown [10.43.3.115])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7435319560AB; Tue,  1 Jul 2025 08:38:45 +0000 (UTC)
Date: Tue, 1 Jul 2025 10:38:44 +0200
From: Jiri Denemark <jdenemar@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Peter Xu <peterx@redhat.com>, devel@lists.libvirt.org,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 18/24] qapi/migration: Deprecate capabilities commands
Message-ID: <aGOelCDCARRgIy2I@orkuz.int.mamuti.net>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-19-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-19-farosas@suse.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jdenemar@redhat.com;
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

On Mon, Jun 30, 2025 at 16:59:07 -0300, Fabiano Rosas wrote:
> The concept of capabilities is being merged into the concept of
> parameters. From now on, the commands that handle capabilities are
> deprecated in favor of the commands that handle parameters.
> 
> Affected commands:
> 
> - migrate-set-capabilities
> - query-migrate-capabilities
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/about/deprecated.rst      | 12 ++++++++++++
>  migration/migration-hmp-cmds.c |  6 ++++++
>  qapi/migration.json            | 16 ++++++++++++++--
>  3 files changed, 32 insertions(+), 2 deletions(-)

We'll need to adapt libvirt as both commands are actively used now. Is
there a way of detecting where the relevant commands for
setting/querying parameters support capabilities? I guess QAPI schema
should work, right?

Jirka


