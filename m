Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05DB606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fY1WhgD2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU7hN-0002R8-8S; Thu, 19 Nov 2026 14:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xU7hL-0002QJ-CV
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 14:21:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xU7hJ-0005Su-Ld
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 14:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795116088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kD83TOMu8H2/Gs2TsvBfoPQAf8xXgLUVn+Snf5hwuzg=;
 b=fY1WhgD2oo69rbrVlbsQl4rMx7ub6mDSv1SSUYj30fSK0jbOXe16h/SCsN/1sK8yX2mCBI
 sL+u4MbT7MZwl68new+Ab4Fb1jHQyCCEphKRc2k2m0WSaEeJ1ZMDKjKZl0V6BHv59XiO7i
 KS6bIqyj/NaVOWapb3kfN1+eWtfBFj4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-sWq-JHymPH6PrL35Jr5qUg-1; Thu,
 19 Nov 2026 14:21:25 -0500
X-MC-Unique: sWq-JHymPH6PrL35Jr5qUg-1
X-Mimecast-MFC-AGG-ID: sWq-JHymPH6PrL35Jr5qUg_1795116084
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD5FF1955DC2; Thu, 19 Nov 2026 19:21:23 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62A3234C; Thu, 19 Nov 2026 19:21:21 +0000 (UTC)
Date: Thu, 19 Nov 2026 13:21:18 -0600
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, bea1e@proton.me, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 4/4] nbd: Add iotest exposing previous CVE fix
Message-ID: <av9Kv9TtV-J1FYz_@redhat.com>
References: <20261113223742.2546619-6-eblake@redhat.com>
 <20261113223742.2546619-10-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113223742.2546619-10-eblake@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 04:34:52PM -0600, Eric Blake wrote:
> Feifan Qian posted a sample script generated with the help of AI that
> created a known-broken NBD server that intentionally replies to a
> structured read with only a subset of bytes, to expose the leak of
> heap data from qemu as an NBD client into an emulated IDE drive. Take
> the idea of that test, but simplify it into a qemu-io test (much
> lighter-weight NBD client, and easier access to see what bytes the NBD
> client code is passing on) that more closely resembles paradigms in my
> recent nbd-robustness iotest.  Also, expand the test to cover multiple
> scenarios: in addition to the original test demonstrating a prefix of
> 20 bytes with unwritten tail, I expanded it to cover out-of-order
> replies, a hole-only reply, and a completely empty reply.
> 
> Reported-by: Feifan Qian <bea1e@proton.me>
> Based-on: https://gitlab.com/qemu-project/qemu/-/work_items/3815
> AI-used-for: tests
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

> +
> +    def test_incomplete_and_out_of_order_reads(self):
> +        # Force heap perturbation so uninitialized bytes show up (if not
> +        # already set in caller, this favors values of 0x5A in unused heap)
> +        os.environ.setdefault("MALLOC_PERTURB_", "165")
> +        nbd_uri = f"nbd+unix:///?socket={self.sock_path}"
> +        out = iotests.qemu_io(

It turns out MALLOC_PERTURB_ does not help or hurt in this case;
that's because qemu-io's read command is hardcoded to (re-)wipe memory
buffers to 0xab before it calls blk_pread(). So setting
MALLOC_PERTURB_=165 with the hopes of seeing 0x5a on fresh buffers and
0xa5 after free didn't change anything (the wipe to 0xab happens
unconditionally in qemu-io), I'll drop it from this patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


