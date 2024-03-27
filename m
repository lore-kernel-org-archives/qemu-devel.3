Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D634C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 14:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpUi5-0002bF-Vz; Wed, 27 Mar 2024 10:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rpUi4-0002at-Hm
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:57:00 -0400
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rpUi2-0001M0-8b
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:57:00 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.139.223])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4V4VBF50pgz11BF;
 Wed, 27 Mar 2024 14:56:53 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 27 Mar
 2024 15:56:53 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001e2e26a6c-8c59-4f38-9591-55968b28b20f,
 E5A1EC0EFFE5CD3CAD84611DE318B77B5DFBC549) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Wed, 27 Mar 2024 15:56:44 +0100
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
CC: <qemu-devel@nongnu.org>, <thuth@redhat.com>, <alistair.francis@wdc.com>,
 <peter.maydell@linaro.org>, <qemu_oss@crudebyte.com>
Subject: Re: [PATCH for-9.0 v3 0/2] qtest/virtio-9p-test.c: fix slow tests
Message-ID: <20240327155644.06050cbe@bahia>
In-Reply-To: <20240327142011.805728-1-dbarboza@ventanamicro.com>
References: <20240327142011.805728-1-dbarboza@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: a26f3547-2883-400c-a3c4-7c13c63c18ad
X-Ovh-Tracer-Id: 3725884268188113190
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedggeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepledvhfetteejheetjedvkeefveekgfejleekueeuueeiueeuffdvudeiudegfffgnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpghhnuhdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleeipdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepuggsrghrsghoiigrsehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepthhhuhhthhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghlihhsthgrihhrrdhfrhgrnhgtihhsseifuggtrdgtohhmpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpth
 htohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdfovfetjfhoshhtpehmohehgeekpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=46.105.45.231; envelope-from=groug@kaod.org;
 helo=8.mo548.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 27 Mar 2024 11:20:09 -0300
Daniel Henrique Barboza <dbarboza@ventanamicro.com> wrote:

> Hi,
> 
> In this new version we took a different approach after the discussions
> we had in [1]. The tests are now untouched, and we're addressing the root
> cause directly: the fact that we have a single temp dir for all the test
> execution in qos-test.
> 
> We're now creating and cleaning temp dirs for each individual test by
> calling virtio_9p_create_local_test_dir() in the .before callback for
> the local 9p tests (assign_9p_local_driver()). In this same callback we
> queue the cleanup function that will erase the created temp dir. The
> cleanup will run after the test ran successfully.
> 
> This approach is similar to what other qtests do (in fact this design was
> taken from vhost-user-test.c) so it's not like we're doing something
> novel.
> 
> I kept the revert of the slow test gate because Gitlab seems to approve
> it:
> 
> https://gitlab.com/danielhb/qemu/-/pipelines/1229836634
> 
> Feel free to take just patch 1 if we're not sure about re-enabling these
> tests in Gitlab.
> 
> 
> Changes from v3:
> - patches 1 to 6: dropped
> - patch 1 (new):
>   - create and remove temporary dirs on each test
> - v2 link: https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg06335.html
> 
> [1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg06400.html
> 
> Daniel Henrique Barboza (2):
>   qtest/virtio-9p-test.c: create/remove temp dirs after each test
>   qtest/virtio-9p-test.c: remove g_test_slow() gate
> 
>  tests/qtest/virtio-9p-test.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 

Definitely better !

Full series,

Reviewed-by:Greg Kurz <groug@kaod.org>

Cheers,

-- 
Greg

