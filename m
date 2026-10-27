Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C9A606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=EdzEbZlr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLgmO-0006Ye-69; Tue, 27 Oct 2026 08:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1xLgmL-0006YL-VE; Tue, 27 Oct 2026 08:59:50 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1xLgmK-0004ad-7M; Tue, 27 Oct 2026 08:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=9ApMuoI7fWhmIFjcZW6e2sc2Uzrjlix7jurk8RT+b98=; b=EdzEbZlrVxLQb8dgxbnnM4LzGK
 9Td0TZj+7f2QPdb0T15Nqmx1JygLo1J5zPCX/SgnSxScQ6HVpvrsnf43+ida5ZzDmlmQdHIETTYem
 f0WThPhM2nXQoLVY/GG5+EkFPQb3KhBcTVDO2M7ngpXhkyGbh05P/8IEgBxWiczGiaWqw3KX806pj
 o18IKmrPeHFXIycrAwHsbKzqD2JloyfqVbxLDW859Wc6bW+boTy0K52kdo7+2w62nZSMRwawwiW1z
 qEfb+/s8/avWSqvx7cCVqTFcEXhvwcNHxEV3jQ4f1yWnzl5eo9hMcLIdlKhnWnYQIekK1M82k2c6+
 icVkltFt2p9gly/i24ktLkwi7l0jGRpKeFpbcFDDrExNzHb16o1sN3KJ/obLP34Exq+fIoaNRlQ5n
 gbv5C8UoRL1/1u+APJlU5fv3hC5L3cXHmymEDHDxEQKpFbVK2wqH4xxNo2gMJZXrX00gRsm0WlhoL
 yvEp4vgF0sclNKgFkq/34MxcNeoc5PS6cQ2XSDXltsPy9m29YbZ5O1r5bxq6BMOPfW8nZcl/YmIgU
 7YjrDqPTVsOktz7xSFEYjBIDDDjpHmX6whN8pjk90rF8xXEt+UnUyBOdQSBLVkOOzxO7Wa/45tNKQ
 sts7Qc7a4t8iEjJllErFPgflohZBFdNPdStYLdnXA=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Subject: Re: [PULL 2/9] tests/9p-race: add 9p race test suite (race FID-path
 mutations)
Date: Tue, 27 Oct 2026 13:59:44 +0100
Message-ID: <119543614.nniJfEyVGO@weasel>
In-Reply-To: <c0cf4c97-6d1e-4550-a567-a84ce3ff7b43@redhat.com>
References: <cover.1792420035.git.qemu_oss@crudebyte.com>
 <24565308.6Emhk5qWAg@weasel>
 <c0cf4c97-6d1e-4550-a567-a84ce3ff7b43@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tuesday, 27 October 2026 08:27:07 CET Thomas Huth wrote:
> On 26/10/2026 17.38, Christian Schoenebeck wrote:
> > On Monday, 26 October 2026 10:35:12 CET Thomas Huth wrote:
> >> On 26/10/2026 09.44, Thomas Huth wrote:
> >>> On 19/10/2026 16.27, Christian Schoenebeck wrote:
> >>>> Add a qtest-based stress test suite racing 9pfs server-side state.
[...]
> > This is more of a project management question; should these extremely slow
> > 9p race tests either:
> > 
> > a) be skipped entirely on `make check-qtest SPEED=thorough` or
> > b) run shorter (i.e. less rounds, very low probability to hit) or
> > c) increase the meson timeout for qos-test binary?
> > 
> > Personally I don't care too much. These 9p race tests are useful for me,
> > but I also understand if other unrelated developers don't want to spend
> > like 10+ mins on each test run for this. I still run them directly via
> > `tests/qtest/ qos-test -m slow` ; last line of defense, etc.
> > 
> > Technically it is easy to address:
> > 
> > a) -> set envvar V9FS_RACE=0
> > b) -> set envvar V9FS_RACE_ROUNDS=n
> > c) -> s/'qos-test': 120/'qos-test': n/
> > 
> > all in tests/qtest/meson.build. Your call.
> 
> I think it's maybe best to go with option b), i.e. to (radically) reduce the
> amount of rounds that is run by default. That way the code still gets at
> least a little bit exercised when running all tests in thorough mode,
> without extending the test time too much for everybody.
> Could you send a patch, or want me to do it?

Patches are always appreciated of course; otherwise this would have to wait a 
bit, as I am currently busy with other high prio tasks. I am fine either way.

Thanks!

/Christian



