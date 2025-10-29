Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11079CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4p4-0000NJ-0W; Wed, 29 Oct 2025 07:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vE4oz-0000N0-NX
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 07:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vE4ov-0003lk-PN
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 07:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739102;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bsvD2LLJAv1A5Zej9seOLOvoObvpvPa7M3W9fa4q4jw=;
 b=eH9KJgDCdowceh4Qb96AiiGS+i5WujLLTUkvlJR47EuyAPRTMldF6qjn7bExG9KWnDj8nw
 eMgrk2CMHlEJUWKXyw4EjC5pKbvIAksC8aVo2N8/1iAw/QFDbpuwgr5NpVEqEStTolcFns
 5rGdATRVyi2tKgsAKe4iXTgYnp5ya2Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-Y7uXZZxWNzezVBPoonBByg-1; Wed,
 29 Oct 2025 07:58:18 -0400
X-MC-Unique: Y7uXZZxWNzezVBPoonBByg-1
X-Mimecast-MFC-AGG-ID: Y7uXZZxWNzezVBPoonBByg_1761739097
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B83FB19560A2; Wed, 29 Oct 2025 11:58:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.72])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EF7A180044F; Wed, 29 Oct 2025 11:58:16 +0000 (UTC)
Date: Wed, 29 Oct 2025 11:58:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 04/12] tests/functional: Test whether the
 vmstate-static-checker script works fine
Message-ID: <aQIBVcKRMDUjeeqK@redhat.com>
References: <20250924063956.519792-1-thuth@redhat.com>
 <20250924063956.519792-5-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924063956.519792-5-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 24, 2025 at 08:39:48AM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We've got two vmstate dump files in the repository which are meant
> for verifying whether the vmstate-static-checker.py works as expected.
> Since running this manually is a cumbersome job, let's add an automated
> test for this instead that runs the script with the two dump files
> and checks for the expected output.

This job always fails on Fedora 43, because the vmstate script
output includes python deprecation warnings:

  2025-10-29 11:53:55,097 - INFO: vmstate-static-checker output:
  /var/home/berrange/src/virt/qemu/tests/functional/../../scripts/vmstate-static-checker.py:385: PendingDeprecationWarning: FileType is deprecated. Simply open files after parsing arguments.
    parser.add_argument('-s', '--src', type=argparse.FileType('r'),
  /var/home/berrange/src/virt/qemu/tests/functional/../../scripts/vmstate-static-checker.py:388: PendingDeprecationWarning: FileType is deprecated. Simply open files after parsing arguments.
    parser.add_argument('-d', '--dest', type=argparse.FileType('r'),


> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-ID: <20250912100755.316518-3-thuth@redhat.com>
> ---
>  MAINTAINERS                                 |  1 +
>  tests/functional/x86_64/meson.build         |  1 +
>  tests/functional/x86_64/test_bad_vmstate.py | 58 +++++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100755 tests/functional/x86_64/test_bad_vmstate.py

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


