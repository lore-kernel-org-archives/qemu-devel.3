Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF1D606A32C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=Gbil3cvx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWkn-00029y-2U; Mon, 23 Nov 2026 11:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1xVWkk-00026q-KW
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 11:18:50 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1xVWki-00030Y-ST
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 11:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=PM5UcvTGbAPKiXmxEMuBghNN82OUaiBxOJBpTja6QRo=; b=Gbil3cvx4qgdbvMWapoe6jOhMU
 4RhfOREzyyjW7sA6tiuNtsP6+1C32TBZA+3F+ZUsF6X5B6CUg7BAM99LajgznH+PhZXgX/CtoJNMq
 JW7RrtckgbR2Ec54vYL9RCE//rAoB3rtBhT2H86AT6qAkj6JNKsBTENDPdrK2RdJLJnt/ZrNuqyhs
 C1X+E9qHLxJlT9a7N0A4QplgmHtPnKXaofveCgK7C/rL+NXy8knAoPM2MXkzfFVqFTz4bsfAG7S9o
 ar6xOp27KsIhzH20eooyIxXM9N95n9soUUyGnuZnrf4PLPEIxhDF+vcH8F9yfvYvHJg8nnevJyG7w
 PFH1WZIzF7wX0YqlOSTj5dZa8uEc9MCA7+csg2oMDs6PX2K13+hADu4IyicldN9YZfEAP4n46r8JF
 HI1EljDv0i6IaHszd6NaSsccsU1zN6EtEB8cgahgK4KEnzAaspJbpMAbEHISnIXcJjp7r1oFD2UI2
 Mdix9nDTtUvpxGghgM9LCoW3o4SSjVErdVWOO61nZGKUENWcaZKscSDdfnsRmqR7pkv7uM1DOOtSK
 ma43C2AbTJQ/mvbCsM5Rga6pUtTvr7Tyw6c+W29jZ7kfCZWR45x1ymr4GTwMrWEnwfGxn/jYwrhjc
 JbXGLs/rRUjYW0uLQfvTWJXPWdq3FEWK8QucT7U/E=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
 Niklas Gollenstede <gollenstede@ibr.cs.tu-bs.de>
Subject: Re: [PATCH 2/2] tests/qtest/virtio-9p: test non-readable but
 traversable directories
Date: Mon, 23 Nov 2026 17:18:42 +0100
Message-ID: <4778264.LvFx2qVVIh@weasel>
In-Reply-To: <20261109155503.2530430-3-gollenstede@ibr.cs.tu-bs.de>
References: <20261109155503.2530430-1-gollenstede@ibr.cs.tu-bs.de>
 <20261109155503.2530430-3-gollenstede@ibr.cs.tu-bs.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Monday, 9 November 2026 16:55:03 CET Niklas Gollenstede wrote:
> From: Claude <noreply@anthropic.com>
>=20
> Add two 'local' driver tests for directories that the user running QEMU
> may traverse (x) but not read (r), e.g. a host's /nix/store with mode
> 1771 that is shared with a VM:
>=20
> - local/walk/unreadable_dir: such a directory inside the export
> - local/attach/unreadable_root: the export root itself is such a directory
>=20
> In both cases, walking to, stat'ing and reading a known file inside the
> directory must work, while listing the directory must fail with EACCES.
> The tests are skipped if directory permissions are not enforced (e.g.
> when running as root).
>=20
> Without the previous commit, both tests fail: the walk through the
> non-readable directory stops at it, and with a non-readable export root
> QEMU does not even start.
>=20
> Also make the test dir cleanup restore permissions before 'rm -fr', so
> that it can remove such directories.
>=20
> AI-used-for: code (Claude Opus 5.5)
> Signed-off-by: Niklas Gollenstede <gollenstede@ibr.cs.tu-bs.de>

I still had no time to look at this series more closely, but upfront: I can=
=20
definitely not pick a patch with an AI identity as the author. So for the b=
are=20
minimum, you must drop the From: line and report this series as v2 (topleve=
l=20
post).

https://www.qemu.org/docs/master/devel/submitting-a-patch.html

=46urthermore I am not sure what the current policy of QEMU regarding AI=20
generated code now is. Originally they denied any AI generated content, but=
=20
realistically that's now everywhere.

As for the issue itself, d=C3=A9ja vu:
https://gitlab.com/qemu-project/qemu/-/work_items/1066

/Christian



