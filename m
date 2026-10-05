Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8655FCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfrJ-000211-J9; Mon, 05 Oct 2026 06:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xDfqo-0000ka-W3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xDfqm-0001bI-Tl
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791195795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tUvudYb3WYj+F+IFF4MZ2Fl2p3Q0g6jRJzsSL1TZMng=;
 b=LD/7kTTSDmQN3jPhAS/qBNkWcq+Xm26mE7GQYhwZ6FbWSu/TnsLbsU67iQzTJ3UrFuEU9n
 MEZEfgrq8caYyF6L2Vk/Ma2SUqAm4QDr/0fNLmnrcMoqMzwCjjv7ltfOftwjtItaXD3CXu
 p4uUsiWjHhjCng9fZI1lobIoPdL4SjA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-W4lKyMuMOhWWN2P0TCHQSw-1; Mon,
 05 Oct 2026 06:23:13 -0400
X-MC-Unique: W4lKyMuMOhWWN2P0TCHQSw-1
X-Mimecast-MFC-AGG-ID: W4lKyMuMOhWWN2P0TCHQSw_1791195792
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17BE91956064; Mon,  5 Oct 2026 10:23:12 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.155])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 090FE1956044; Mon,  5 Oct 2026 10:23:09 +0000 (UTC)
Date: Mon, 5 Oct 2026 12:23:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Tim Pambor <timpambor@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] iotests: annotate TestRunner.shared_self for mypy 2.4
Message-ID: <asN6i85AhFG2-ORq@redhat.com>
References: <20261002-mypy-2-4-v1-1-185c406d1cbd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-mypy-2-4-v1-1-185c406d1cbd@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Am 02.10.2026 um 09:04 hat Tim Pambor geschrieben:
> mypy 2.4.0 infers the unannotated class attribute "shared_self = None"
> as having type "None" and rejects the later assignment of a TestRunner
> instance in run_tests_pool():
> 
>   testrunner.py:126: error: Incompatible types in assignment
>   (expression has type "TestRunner", variable has type "None")
> 
> Earlier mypy versions treated the attribute as a partial type and
> accepted the assignment. Give the attribute an explicit
> Optional['TestRunner'] annotation so both old and new mypy agree.
> 
> Fixes tests/linters.py::TestLinters::test_mypy_iotests with mypy >= 2.4.
> 
> Signed-off-by: Tim Pambor <timpambor@gmail.com>
> ---
> CI run with mypy 2.4: https://gitlab.com/tpambor/qemu/-/pipelines/2905639361

Thanks, applied to the block branch.

Kevin


