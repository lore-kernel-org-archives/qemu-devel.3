Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EB4C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp99q-0001C8-TJ; Tue, 26 Mar 2024 11:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rp99j-00018b-CI
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:56:08 -0400
Received: from 9.mo548.mail-out.ovh.net ([46.105.48.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rp99f-0003PD-4c
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:56:06 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.176.7])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4V3vXm6pRTz11DQ;
 Tue, 26 Mar 2024 15:55:52 +0000 (UTC)
Received: from kaod.org (37.59.142.107) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 26 Mar
 2024 16:55:52 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S001f5d0257d-998f-4217-82e1-ef7673711081,
 3336A23CADED603188EFB840896199A906C9B3FB) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Tue, 26 Mar 2024 16:55:50 +0100
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
CC: <qemu-devel@nongnu.org>, <thuth@redhat.com>, <alistair.francis@wdc.com>,
 <peter.maydell@linaro.org>, <qemu_oss@crudebyte.com>
Subject: Re: [PATCH for-9.0 0/3] qtest/virtio-9p-test.c: fix slow tests
Message-ID: <20240326165550.05d083da@bahia>
In-Reply-To: <20240326132606.686025-1-dbarboza@ventanamicro.com>
References: <20240326132606.686025-1-dbarboza@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.107]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 5b74d11f-f287-4b4e-9774-c72c6686c87f
X-Ovh-Tracer-Id: 17296074370409601318
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepffektdeftefghfefgfeukeelieehgfduvdejheehveevvdfgjeeufeelledtuefhnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpghhnuhdrohhrghdpnhhonhhgnhhurdhorhhgnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdejpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepuggsrghrsghoiigrsehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepthhhuhhthhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghlihhsthgrihhrrdhfrhgrnhgtihhsseifuggtrdgtohhmpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinh
 grrhhordhorhhgpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdfovfetjfhoshhtpehmohehgeekpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=46.105.48.137; envelope-from=groug@kaod.org;
 helo=9.mo548.mail-out.ovh.net
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

Bom dia Daniel !

On Tue, 26 Mar 2024 10:26:03 -0300
Daniel Henrique Barboza <dbarboza@ventanamicro.com> wrote:

> Hi,
> 
> Thomas reported in [1] a problem that happened with the RISC-V machine
> where some tests from virtio-9p-test.c were failing with '-m slow', i.e.
> enabling slow tests.
> 
> In the end it wasn't a RISC-V specific problem. It just so happens that
> the recently added riscv machine nodes runs the tests from
> virtio-9p-test two times for each qos-test run: one with the
> virtio-9p-device device and another with the virtio-9p-pci. The temp dir
> for these tests is being created at the start of qos-test and removed
> only at the end of qos-test, and the tests are leaving dirs and files
> behind. virtio-9-device tests run first, creates stuff in the temp dir,
> then when virtio-9p-pci tests runs again it'll fail because the previous
> run left created dirs and files in the same temp dir. Here's a run that
> exemplifies the problem:
> 
> $ MALLOC_PERTURB_=21 V=2 QTEST_QEMU_BINARY=./qemu-system-riscv64 ./tests/qtest/qos-test -m slow
> (...)
> # starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-621710.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-621710.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M virt,aclint=on,aia=aplic-imsic -fsdev local,id=fsdev0,path='/home/danielhb/work/qemu/build/qtest-9p-local-7E16K2',security_model=mapped-xattr -device virtio-9p-device,fsdev=fsdev0,mount_tag=qtest -accel qtest
> ( goes ok ...)
> # starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-621710.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-621710.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M virt,aclint=on,aia=aplic-imsic -fsdev local,id=fsdev0,path='/home/danielhb/work/qemu/build/qtest-9p-local-7E16K2',security_model=mapped-xattr -device virtio-9p-pci,fsdev=fsdev0,addr=04.0,mount_tag=qtest -accel qtest
> ok 168 /riscv64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/config
> Received response 7 (RLERROR) instead of 73 (RMKDIR)
> Rlerror has errno 17 (File exists)
> **
> ERROR:../tests/qtest/libqos/virtio-9p-client.c:275:v9fs_req_recv: assertion failed (hdr.id == id): (7 == 73)
> 
> As we can see we're running both 'virtio-9p-device' tests and 'virtio-9p-pci'
> tests using the same '/home/danielhb/work/qemu/build/qtest-9p-local-7E16K2'
> temp dir. 
> 


Good catch ! I'll try to find some time to review.

> The quick fix I came up with was to make each test clean themselves up
> after each run. The tests were also consolidated, i.e. fewer tests with the
> same coverage, because the 'unlikat' tests were doing the same thing the
> 'create' tests were doing but removing stuff after. Might as well keep just
> the 'unlikat' tests.
> 

As long as coverage is preserved, I'm fine with consolidation of the
checks. In any case, last call goes to Christian.

> I also went ahead and reverted 558f5c42efd ("tests/9pfs: Mark "local"
> tests as "slow"") after realizing that the problem I was fixing is also
> the same problem that this patch was trying to working around with the
> skip [2]. I validated this change in this Gitlab pipeline:
> 

Are you sure with that ? Issues look very similar indeed but not
exactly the same.

Cheers,

--
Greg

> https://gitlab.com/danielhb/qemu/-/pipelines/1227953967
> 
> [1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2020-11/msg05510.html
> 
> Daniel Henrique Barboza (3):
>   qtest/virtio-9p-test.c: consolidate create dir, file and symlink tests
>   qtest/virtio-9p-test.c: consolidate hardlink tests
>   qtest/virtio-9p-test.c: remove g_test_slow() gate
> 
>  tests/qtest/virtio-9p-test.c | 155 +++++++++++------------------------
>  1 file changed, 48 insertions(+), 107 deletions(-)
> 

