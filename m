Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BE5606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fk5v2Mdf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0RK-0007h9-LL; Thu, 19 Nov 2026 06:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xU0RI-0007ga-KV
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:36:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xU0RG-0003vI-Rx
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795088185;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrayUpBQCIEW3NyL0NfnjDb5fVAh1fySJQUW37wi7mY=;
 b=Fk5v2MdfcnIetU/v+bYqhAtfzJ7ZlM5CgcH7QhSXGtMxrpLRWpfAXrVi0h3bKuhhDStw0T
 cluJ+ezEq7EjW7R+yBkAZ3rLJ4SrO6VyrKVKt2eFd/w9snhanRws9Mmban37B11Ku2n8c8
 UwU3HuSONaIlgjxQahb0k95Almixmtg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-VqsNI8anP-KDYbKW6GvSVQ-1; Thu,
 19 Nov 2026 06:36:21 -0500
X-MC-Unique: VqsNI8anP-KDYbKW6GvSVQ-1
X-Mimecast-MFC-AGG-ID: VqsNI8anP-KDYbKW6GvSVQ_1795088180
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D3B919541B6
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:36:20 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 307411800286; Thu, 19 Nov 2026 11:36:18 +0000 (UTC)
Date: Thu, 19 Nov 2026 11:36:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, crosa@redhat.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH] python/qemu: Don't choke on unknown members in QMP replies
Message-ID: <av7fMIyo2kBS9azb@redhat.com>
References: <20261118182005.1066151-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118182005.1066151-1-armbru@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 07:20:05PM +0100, Markus Armbruster wrote:
> The recent addition of @qapi-type to ObjectPropertyInfo and
> ObjectPropertyValue broke the corresponding classes in
> qemu/utils/qom_common.  Reproducer:
> 
>     $ bld/run qom-list -s qmp-socket /chardevs
>     Traceback (most recent call last):
>       File "/work/armbru/qemu/bld/pyvenv/bin/qom-list", line 8, in <module>
>         sys.exit(QOMList.entry_point())
>                  ~~~~~~~~~~~~~~~~~~~^^
>       File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 230, in entry_point
>         return cls.command_runner(args)
>                ~~~~~~~~~~~~~~~~~~^^^^^^
>       File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 215, in command_runner
>         return cmd.run()
>                ~~~~~~~^^
>       File "/work/armbru/qemu/python/qemu/utils/qom.py", line 179, in run
>         rsp = self.qom_list(self.path)
>       File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 192, in qom_list
>         return [ObjectPropertyInfo.make(x) for x in rsp]
>                 ~~~~~~~~~~~~~~~~~~~~~~~^^^
>       File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 52, in make
>         assert value.keys() <= {'name', 'type', 'description', 'default-value'}
>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     AssertionError
> 
> This asserts "no members we don't know".  There are two more like it.
> 
> Adding @qapi-type broke them.
> 
> docs/devel/qapi-code-gen.rst section "Compatibility considerations"
> stipulates that "clients are expected to ignore [members] they don't
> know."

Yes, that is critical as we want to retain the right to add new
members at any time without breaking apps.

> 
> Delete / relax these assertions.
> 
> Fixes: 0eee31cf1085 ("qapi/qom: add qapi-type to qom-list, qom-list-properties, qom-list-get")
> Fixes: c750c02891a8 ("python/qmp: Add qom script rewrites")
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  python/qemu/utils/qom_common.py | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


