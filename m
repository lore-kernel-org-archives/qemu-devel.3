Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35754C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tupF7-0005a1-35; Wed, 19 Mar 2025 04:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tupEu-0005XW-KN
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tupEs-0008Ou-0r
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742374640;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bSJ6mUerpzg5sHI6tTt75o2C2Wi2H3D1RR+ZzOOAXes=;
 b=FWdKefOLOd12071PcmnPyqVVkGxg38tFMfksN+Qw0+3CnZr89RufCLhQphSJ0VxFlgP2QW
 9j2103WfFgH+P6r1Tctg4nuV1tFyHFp987wGTKRO+PwTzHu2hLeoDT94lGpTph+WCW7InL
 +YUqOgy7fBTpVLvWD3uqY0ARJRNrmDo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-zm4zHRluOzeW5zh207wKIw-1; Wed,
 19 Mar 2025 04:57:16 -0400
X-MC-Unique: zm4zHRluOzeW5zh207wKIw-1
X-Mimecast-MFC-AGG-ID: zm4zHRluOzeW5zh207wKIw_1742374635
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 992291800258; Wed, 19 Mar 2025 08:57:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6DFF1955BC2; Wed, 19 Mar 2025 08:57:12 +0000 (UTC)
Date: Wed, 19 Mar 2025 08:57:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 qemu-devel@nongnu.org, farosas@suse.de, philmd@redhat.com,
 bcain@quicinc.com, quic_mliebel@quicinc.com
Subject: Re: test_migration.py not working with netcat-traditional
Message-ID: <Z9qGwgEvRHJQt1rJ@redhat.com>
References: <85909195b99964081ae01d9999384cc3b7a3fada.1742331648.git.quic_mathbern@quicinc.com>
 <8b749710-a5bf-4da9-a6af-160ccb0bbcc5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b749710-a5bf-4da9-a6af-160ccb0bbcc5@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 19, 2025 at 08:49:53AM +0100, Thomas Huth wrote:
> On 18/03/2025 22.13, Matheus Tavares Bernardino wrote:
> > Hi,
> > 
> > tests/functional/test_migration.py says "The test works for both
> > netcat-traditional and netcat-openbsd packages." But when I run it for
> > qemu-system-aarch64 on an Ubuntu 22.04 container with netcat-traditional
> > installed, I get the following error:
> > 
> > TAP version 13
> > Traceback (most recent call last):
> >    File "/pwd/tests/functional/test_migration.py", line 97, in test_migration_with_exec
> >      self.do_migrate(dest_uri, src_uri)
> >    File "/pwd/tests/functional/test_migration.py", line 72, in do_migrate
> >      self.assert_migration(source_vm, dest_vm)
> >    File "/pwd/tests/functional/test_migration.py", line 40, in assert_migration
> >      self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
> > AssertionError: 'failed' != 'completed'
> > - failed
> > + completed
> > 
> > not ok 1 test_migration.MigrationTest.test_migration_with_exec
> > ok 2 test_migration.MigrationTest.test_migration_with_tcp_localhost
> > ok 3 test_migration.MigrationTest.test_migration_with_unix
> > 1..3
> > 
> > With netcat-openbsd (the default), it runs fine. Perhaps the test is no
> > longer compatible with netcat-traditional?
> > 
> > QEMU was configured and built with:
> > ../configure --without-default-features --target-list=aarch64-softmmu
> 
> For me it works with both flavors of "nc", the ncat and the netcat one...
> but I'm also running on Fedora.

There are three flavour os 'nc' - the traditional netcat, openbsd netcat
and nmap netcat.

IMHO rather than debug differences in these, we'd be better off just
rewriting the test to use socat so we have 1 single impl to think about
instead of 3.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


