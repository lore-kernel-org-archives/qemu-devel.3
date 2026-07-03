Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A1BC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wff0g-0003v2-P8; Fri, 03 Jul 2026 10:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wff0e-0003uX-Mf; Fri, 03 Jul 2026 10:36:52 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wff0d-0001QY-3Y; Fri, 03 Jul 2026 10:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=USaqb2zz1G9s89Q1UihQu0tw9CIIrd/nq6NgdT2jCkw=; b=dFhuETlqxkZFPIwKJ/1+a3n/LQ
 sDHon3yDn/bZul7eyfd2TX7045ZmXBn5yqgmxW597VKn8MrZpNUzYP4rwUqBcSkwSRMZRhHQ8Hyjv
 IvT7fvuz+iA7fG6WF7SG7wvodjQOGAXKmW/SQHB5+x1tcE72mNFnGuoYlB2kPSJWr6MwNu5w2Nw1z
 kqemnFGzuVW2QtSSOfvBI86oNJuMKm5kUlTTzK32K/2N9IF++B3z6SJulLGfgudOMBVKgwR7/RKVM
 89TTn8wV2if6zj0sfhIYS+wlqO5RqloJjV9NVPlob5kOZ//JAGpEd9hhvPOhTX9QEIfvebQdoJhf1
 y3hoBMqOSgD2bGJoI56B240GJWUNRdVa44PbOo7d6RKtpT0RggBIpWTWx5c9OqMwk3Eq8ArE7wn9Q
 4uocECzFJ/TMSTQCaKdWb4xheGN8aaLA2KJOLmSPDnB6A/90ljm0cQIuvEzyoSOQ7r1/3Nlfmjcn1
 cywC7z0HWRFF55f9IePH5Y55A0AFbPximw60F7RBhQcj9wOuyKjUZOMvYygv2aPhOpl4m3hsUIzJ7
 K2gTw2P3ubRmk2UxXUsszf9j/4ElMamI7uAAUrkRyeiJob5FmBYwKeaBMpVpTbsJR95Z6bCLGXOdh
 4VIrKA5aD7Z31SBepOU4Gj2lPRFrVfv+36RL4+u/8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PULL 00/23] 9p queue 2026-06-29
Date: Fri, 03 Jul 2026 16:36:47 +0200
Message-ID: <2300937.NgBsaNRSFp@weasel>
In-Reply-To: <08184eb6-9acd-4afd-9e3b-65dc89fcbb76@oss.qualcomm.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
 <8700308.T7Z3S40VBb@weasel>
 <08184eb6-9acd-4afd-9e3b-65dc89fcbb76@oss.qualcomm.com>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thursday, 2 July 2026 20:21:54 CEST Pierrick Bouvier wrote:
> Hi Christian,
> 
> On 7/1/2026 9:20 AM, Christian Schoenebeck wrote:
> > On Tuesday, 30 June 2026 09:28:48 CEST Pierrick Bouvier wrote:
> >> Hi Christian,
> > 
> > Hi Pierrick,
> > 
> >> This series brought a test regression:
> >> $ ./build/pyvenv/bin/meson test -C build \
> >> --setup thorough --print-errorlogs \
> >> qemu:qtest-aarch64/qos-test
> >> ...
> >> ERROR:../tests/qtest/libqos/virtio-9p-client.c:280:v9fs_req_recv:
> >> assertion failed (hdr.id == id): (7 == 121)
> >> 
> >> It seems to come test added in patch 19
> >> "tests/9p: add 3 xattr FID limit test cases (synth fs driver)"
> >> This test runs only with slow setup, so I suspect it never worked and
> >> was never ran.
> > 
> > Of course I ran these slow tests.
> 
> I should have added "in our CI" sorry. I'm sure you developed, tested
> and ran those yourself.
> 
> > I intentionally registered these tests as "slow" tests as they take a long
> > time to complete and QEMU tests being notorious on exceeding the overall
> > CI
> > timeout limit. So these tests are exempted from running in the official CI
> > pipeline, but not from mine.
> > 
> > I just reran them with latest master head. However I am unable to
> > reproduce
> > your reported test error so far.
> > 
> > You cropped the output too aggressively. I need to know:
> > 
> > - Which test exactly failed? (especially whether it's really a synth
> > backend> 
> >   or a local backend test that failed)
>
> That's the complete log from the command given above.
> Note: disk is not full, but the error "no space left on device" is very
> weird.

OK, I was able to reproduce the test error. Root cause is that ext4 without 
ea_inode enabled is limited to ~4KB per xattr block. I'll prepare a patch.

For the next time: please note that the most important information is always 
the name of the test case that failed! There are several ways to run the 
tests. In the way you ran them, the name of the failed test is printed 
*before* the stderr block:

...
# slow test /aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p-
pci/virtio-9p/virtio-9p-tests/local/deep_absolute_path executed in 1.63 secs
# Start of xattr_limit tests
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-22413.sock 
-qtest-log /dev/null -chardev socket,path=/tmp/qtest-22413.qmp,id=char0 -mo
n chardev=char0,mode=control -display none -audio none -run-with exit-with-
parent=on -M virt, -cpu max -fsdev local,id=fsdev0,path='/src/bee/qemu/build/q
test-9p-local-KKOMR3',security_model=mapped-xattr -device virtio-9p-
pci,fsdev=fsdev0,addr=04.0,mount_tag=qtest  -accel qtest
not ok /aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p-pci/
virtio-9p/virtio-9p-tests/local/xattr_limit/default - ERROR:../tests/qtest/lib
qos/virtio-9p-client.c:280:v9fs_req_recv: assertion failed (hdr.id == id): (7 
== 121)
Bail out!
----------------------------------- stderr -----------------------------------
...

So here the failing test name was /aarch64/virt/generic-pcihost/pci-bus-
generic/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/xattr_limit/
default

Independent of this particular issue here, I wonder whether there is some way 
to register a test such that it won't break other people's test pipeline. 
Because these "local" backend xattr tests are sensible on underlying host 
capabilities. They are useful for me, but that should not mean to stop the 
world just because an unrelated test environment is missing a capability.

/Christian





