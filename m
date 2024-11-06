Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58F5D3E798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 09:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8cnG-00061d-FW; Wed, 06 Nov 2024 04:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t8cn9-0005zx-3T
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:57:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t8cn7-0008Mm-Mo
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730887052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nKQxESljdwH6a3Blz2n8LtQLdvO0QdYBh7jzlJAdIFM=;
 b=JrAhLplStKogFVfogjyckYk42L/uGhJWcgMnOBOgUhnBkdUIf6UB7eCcPoRyw9GBGD2+dt
 Asx7bdsUmQUZN/IF+PhoMX6Hi9HwG567oSEXDhU/Nsr4bJItIeVSjLy4Iizdth0MXqxix8
 e3k/rtlnaQqF2wDtAPDiZ9xR9WjHUlY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-oCtMCOCXPaeGhHV95pSZAg-1; Wed,
 06 Nov 2024 04:57:29 -0500
X-MC-Unique: oCtMCOCXPaeGhHV95pSZAg-1
X-Mimecast-MFC-AGG-ID: oCtMCOCXPaeGhHV95pSZAg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 179CB1955EEA; Wed,  6 Nov 2024 09:57:28 +0000 (UTC)
Received: from redhat.com (dhcp-192-228.str.redhat.com [10.33.192.228])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4F1419541A5; Wed,  6 Nov 2024 09:57:25 +0000 (UTC)
Date: Wed, 6 Nov 2024 10:57:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 0/4] python: update linting for new mypy/pylint releases
Message-ID: <Zys9g8akOqlpuMQx@redhat.com>
References: <20241101173700.965776-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101173700.965776-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 01.11.2024 um 18:36 hat John Snow geschrieben:
> Various python tests in the "check-python-tox" test case on GitLab have
> begun failing due to newer package versions. This patch set corrects
> those issues and also improves the reliability of local developer tests
> which may be using these tooling versions outside of GitLab pinned
> version tests.
> 
> There are remaining issues with the "check-dev" test I have yet to
> rectify, but appear unrelated to linter versions specifically and will
> be handled separately.
> 
> As a result of this patch, the optionally-run and may-fail
> "check-python-tox" test case on GitLab will become green again, and
> local invocations of "make check-tox" in the python subdirectory will
> also pass again. "check-python-minreqs" on GitLab and "make
> check-minreqs" in the local developer environment were/are
> unaffected. local iotest invocations for test case #297 ought to now
> begin passing on developer workstations with bleeding-edge python
> packages.
> 
> John Snow (4):
>   iotests: reflow ReproducibleTestRunner arguments
>   iotests: correct resultclass type in ReproducibleTestRunner
>   python: disable too-many-positional-arguments warning
>   python: silence pylint raising-non-exception error

Thanks, applied to the block branch.

(Yes, of course I had to wait until I ran into the problem patch 2 fixes
myself, and after figuring out the fix from the incomprehensible error
message, I found that this series already contains it.)

Kevin


