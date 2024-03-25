Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4010C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokK8-0008Ck-J9; Mon, 25 Mar 2024 09:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rokK7-0008Ca-9a
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:25:11 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rokK4-0005s9-Ac
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=9YgHf0qKT/atY8TBObrr6MCtsDUhx+yoFKjGrki32R4=; b=g9Mv6WjxdBmSV3n16TJW9llk9i
 GE1poe+F2LDw+1TEiMiO7Y917kprvRerGZyeeYGJyPH2iRDxzpkICLTYrmBngIEjVqAUfwb+/hAWx
 tZ0MqTR5x6O9hxnmp5qXbP8MtwPsLQ1bVOWNZWfnAqs4rBsw5PEHrMSHnwFDS6r+iv3PquDOV7UbH
 txUx1/WIY9LJ2pFQ3d6dstDgrqBqJug09XrOx9pbB7iQdAkP+V12SIWfrYnvrnnK6VpZVN4kmp5Yn
 wcmKp1ZtvChD5h5r8xPKqWBHpe/U7xy8xyEqyMmIAe8a/Yr2naFZs5hTHEb+rLHLfk80pl7wLsYMx
 5+3nKQIilJfYb4fsjGjkzq6/FIuZ6FX8DY08s84b5AXrzPAhQxDuOW/NnrcKkJYVVdNpP9Tn/ghhA
 BHJt4JYlU9fh/uJzP8zcchmNHbIk31O/VKvkCvZ+6YpJPOR++ctEw4GFTZpsYTVUM8XII9mfpYqBs
 xNt9KOZNNREx9lAfueKh89HexlaQ7GZOE9xwjaNyFtc3LEVB/q9C+kp6BggL3IxlIyxIVtXF6f5Ro
 lTowxHGjkIYl7u8oh03h5gg2nZy6Cxt3bOhuoL5vV7v2Puwv7DUJYkg0q1otU1qmeM4vuNorROt7N
 5esgywPzYDs1tUJUhaOPJbhhpJfMBMeuEJe1LQxoc=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair23@gmail.com>,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PULL 20/34] tests/libqos: add riscv/virt machine nodes
Date: Mon, 25 Mar 2024 14:25:01 +0100
Message-ID: <2671306.ea0pUnVCe6@silver>
In-Reply-To: <cef9c499-b258-4618-bff8-eeca8da3d184@ventanamicro.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
 <b85c8451-57e0-49aa-a7c4-28ae8bf08bf9@redhat.com>
 <cef9c499-b258-4618-bff8-eeca8da3d184@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Monday, March 25, 2024 1:35:52 PM CET Daniel Henrique Barboza wrote:
> On 3/25/24 06:20, Thomas Huth wrote:
> > On 08/03/2024 12.11, Alistair Francis wrote:
> >> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >>
> >> Add a RISC-V 'virt' machine to the graph. This implementation is a
> >> modified copy of the existing arm machine in arm-virt-machine.c
> >>
> >> It contains a virtio-mmio and a generic-pcihost controller. The
> >> generic-pcihost controller hardcodes assumptions from the ARM 'virt'
> >> machine, like ecam and pio_base addresses, so we'll add an extra step to
> >> set its parameters after creating it.
> >>
> >> Our command line is incremented with 'aclint' parameters to allow the
> >> machine to run MSI tests.
> >>
> >> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> >> Acked-by: Thomas Huth <thuth@redhat.com>
> >> Message-ID: <20240217192607.32565-7-dbarboza@ventanamicro.com>
> >> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> ---
> > 
> >   Hi!
> > 
> > I noticed that "make check SPEED=slow" is now failing on the qos-test with both, qemu-system-riscv32 and qemu-system-riscv64. Seems like it fails with the virtio-9p test, when I run the qos-test manually, I get:
> > 
> > $ MALLOC_PERTURB_=21 V=2 QTEST_QEMU_BINARY=./qemu-system-riscv64 \
> >     tests/qtest/qos-test -m slow
> > ...
> > # Start of local tests
> > # starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-211303.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-211303.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M virt,aclint=on,aia=aplic-imsic -fsdev local,id=fsdev0,path='/home/thuth/tmp/qemu-build/qtest-9p-local-MBCML2',security_model=mapped-xattr -device virtio-9p-pci,fsdev=fsdev0,addr=04.0,mount_tag=qtest -accel qtest
> > ok 168 /riscv64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/config
> > Received response 7 (RLERROR) instead of 73 (RMKDIR)
> > Rlerror has errno 17 (File exists)
> > **
> > ERROR:../../devel/qemu/tests/qtest/libqos/virtio-9p-client.c:275:v9fs_req_recv: assertion failed (hdr.id == id): (7 == 73)
> > not ok /riscv64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/create_dir - ERROR:../../devel/qemu/tests/qtest/libqos/virtio-9p-client.c:275:v9fs_req_recv: assertion failed (hdr.id == id): (7 == 73)
> > Bail out!
> > Aborted (core dumped)
> > 
> > Could you please have a look? ... or if it is too cumbersome to fix, could we please always skip the virtio-9p local tests on riscv ?
> 
> I'll take a look.
> 
> Do we run these slow tests in the Gitlab pipeline? I don't recall this
> particular test failing when I first introduced the riscv machine nodes.

No, the 'local' 9p tests were taken out by moving them to 'slow', because
these particular tests did not pass in the cloud and gitlab doesn't run
'slow':

commit 558f5c42efded3e0d0b20a90bce2a9a14580d824
Author: Greg Kurz <groug@kaod.org>
Date:   Tue Nov 24 08:43:43 2020 +0100

    tests/9pfs: Mark "local" tests as "slow"
    
    The "local" tests can fail on some automated build systems as
    reported here:
    
    https://lists.nongnu.org/archive/html/qemu-devel/2020-11/msg05510.html
    
    This will need to be investigated and addressed later. Let's go for a
    workaround in the meantime : mark the "local" tests as "slow" so that
    they aren't executed with a simple "make check" like in the case above.
    
    Reported-by: Cole Robinson <crobinso@redhat.com>
    Signed-off-by: Greg Kurz <groug@kaod.org>
    Reviewed-by: Thomas Huth <thuth@redhat.com>
    Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
    Message-Id: <160620382310.1423262.7364287092069513483.stgit@bahia.lan>
    Signed-off-by: Greg Kurz <groug@kaod.org>

Could be because the 'local' 9p backend needs xattr support which might not be
available with gitlab container's filesystem. But I haven't investigated.

The test that fails seems to be the same, just the errno is different in your
case.

Best regards,
Christian Schoenebeck



