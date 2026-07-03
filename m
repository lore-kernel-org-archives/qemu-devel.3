Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88281C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wffgE-0000eW-Dn; Fri, 03 Jul 2026 11:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wffgC-0000e2-I5
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 11:19:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wffgA-0003nQ-9P
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 11:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783091983;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type: content-transfer-encoding:content-transfer-encoding;
 bh=+U3VXKyBuBsCzlOnDOPIdLPRogiVIvevv+7qZJeEef8=;
 b=c6kGX3gd5D8G5ZdsV55eI1IC/wYK3WMI0iUlvlcfshzUZz5Z1NIrMWux9xTTeF3bx0jqkt
 AhI+sd1zFei4U5KJTIvSeVdQz+HZpnUc8Hm2DTxpB4kwh5gxB3drt8dNJPXrsiI0WmTtas
 MBlYskdfTCo17MnmBQeDDG3jBjd95ok=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-p8ILkXBOP_ixeF0HbTE6cw-1; Fri,
 03 Jul 2026 11:19:41 -0400
X-MC-Unique: p8ILkXBOP_ixeF0HbTE6cw-1
X-Mimecast-MFC-AGG-ID: p8ILkXBOP_ixeF0HbTE6cw_1783091981
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E37F91977012
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2026 15:19:40 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.149])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06D64196665E
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2026 15:19:39 +0000 (UTC)
Date: Fri, 3 Jul 2026 16:19:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: Security disclosure bulk import to GitLab issues
Message-ID: <akfTCB3V9311I-w-@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We recently changed to use the GitLab issue tracker for security
disclosures:

  https://www.qemu.org/contribute/security-process/

We have a fairly large number of issues reported to the old
qemu-security mailing list that were either excluded from security
handling due to being under the non-virtualization use case, or
were still awaiting triage in a large backlog.

  https://www.qemu.org/docs/master/system/security.html#non-virtualization-use-case

We made the decision to bulk import every security disclosure
received since March 1st 2026, to GitLab to minimize the chance
that we loose a record of anything.

Everything imported is tagged with the "Imported ➤ Security List"
label.

There are the following rough groupings of imported issues

 * Security flaws. These are tagged with the Kind::Security label.
   If they have a CVE they will have CVE::Assigned label too.
   If they have a fix merged it is recorded in a comment and
   the bug has "confidentiality" flag removed
   If the fix is still outstanding the issue remains
   confidential to project maintainers only.

 * Non-security flaws. These are tagged with the Kind::Bug label
   which reflects that we have classified them as a non-virt use
   case. They have the "confidentiality" flag removed

 * Non-triaged disclosures. These will have the 'confidentiality'
   flag stil present, restricting visibility to QEMU project
   maintainers registered on GitLab. Processing should follow
   the security process documented in the first link above.

For any open bugs I will be assigning maintainers if they have a
known gitlab acount which is a member of the QEMU project.

Many of the non-security flaws have previously been forwarded on
to maintainers, and while some may have been fixed since then,
many remain unresolved. Unfortunately we have no record of the
status for non-security flaws, so had to leave the bugs open even
though this is incorrect in some cases.

If a flaw is known to be resolved any maintainer may close the
obsolete bug report. If easily identified, mention any relevant
git commit hash with the fix.

Similarly if an imported disclosure is a duplicate of an existing
issue feel free to close either one of them.


To those whom have notifications enabled for "all issue changes"
on the QEMU project, my apologies for the fact that you just received
about 400 email notifications from GitLab.  They all came from a bot
account

  security-import (@group_3038080_bot_b37c3b86468ce5250e34f461b13b595a)

Since the import is complete this bot is now disabled and will not send
any further spam.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


