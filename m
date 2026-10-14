Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0806CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3OS-0000Ip-Mi; Wed, 14 Oct 2026 14:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xH3OQ-0000Hp-6a
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xH3ON-0000IA-AC
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792001273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0YuK37UrC6xLhWeUe2TPTpAqk0OLcnMYuF5CMKYrGTA=;
 b=BQ3vUuYKWnbxi9jVjeu0+LNyi7Gyepa93btE3jNIZOrmTo4V78J2yVIoD+TI6TFzzD028M
 YK+8JUpvQqoYIM5pSBaEK3MTSRBfjvr5erO26HP/TKsJly2QRgWcQU5MvwK3sNSicn18x8
 VjMPgB38N/v8pwhloohCvEdqx5OznCk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-KlxmKeaJOhKzNl45W3Qlgg-1; Wed,
 14 Oct 2026 18:07:50 +0000
X-MC-Unique: KlxmKeaJOhKzNl45W3Qlgg-1
X-Mimecast-MFC-AGG-ID: KlxmKeaJOhKzNl45W3Qlgg_1792001269
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A1F51955F75; Wed, 14 Oct 2026 18:07:48 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D9081800480; Wed, 14 Oct 2026 18:07:47 +0000 (UTC)
Date: Wed, 14 Oct 2026 13:07:44 -0500
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/15] NBD patches through 2026-10-08
Message-ID: <as_CCTg5aJaWkm70@redhat.com>
References: <20261012212945.84275-17-eblake@redhat.com>
 <f34e4a10-6673-4d18-8e51-ce4c8f17c398@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f34e4a10-6673-4d18-8e51-ce4c8f17c398@linaro.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 14, 2026 at 10:02:46AM +0200, Richard Henderson wrote:
> On 10/12/26 23:29, Eric Blake wrote:
> > The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:
> > 
> >    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)
> > 
> > are available in the Git repository at:
> > 
> >    https://gitlab.com/ebblake/qemu.git tags/pull-nbd-2026-10-08-v2
> > 
> > for you to fetch changes up to 3d794bcd554c3dc196685faf382fdffe7243e674:
> > 
> >    iotests/iothreads-nbd-export: Skip on s390 (2026-10-12 16:23:50 -0500)
> > 
> > [v2: sending only the updated cover letter and patch 2/15]
> > 
> > ----------------------------------------------------------------
> > NBD patches through 2026-10-08
> > 
> > Several fixes, including:
> > - Eric Blake: Update MAINTAINERS, support qemu-nbd -s -l
> > - Fiona Ebner: Report flush error on qemu-img convert
> > - Guillaume Vinke: Fix NBD client on dead connection
> > - Denis V. Lunev: Fix postcopy dirty bitmap migration
> > - Eric Farman: Several iotest improvements
> 
> This still has 13 job failures, including check-python-minreqs.
> 
> https://gitlab.com/qemu-project/qemu/-/pipelines/2945631627

Looks like most of the failures were due to the later runners being
canceled after the early failure of the check-python-minreqs syntax
check failure. At any rate, I figured out how to patch that one and
will be posting v3 shortly.

-------------------
************* Module tests.migrate-bitmaps-postcopy-test
tests/migrate-bitmaps-postcopy-test:146:8: W0201: Attribute 'drive1_sha256' defined outside __init__ (attribute-defined-outside-init)

Fixed by:
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
index bada325e017..53f7dafc79a 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
@@ -115,6 +115,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
                                                           'discard=unmap')
         self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b,
                                                           'discard=unmap')
+        self.drive1_sha256 = ""
         # A bitmap on a second node makes postcopy switch nodes after setup
         self.vm_a.add_drive(disk_a1)
         self.vm_b.add_drive(disk_b1)


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


