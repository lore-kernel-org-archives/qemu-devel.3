Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D194C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 08:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTzk3-0007fj-8H; Wed, 17 Jul 2024 04:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTzk2-0007c2-4J; Wed, 17 Jul 2024 04:10:26 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTzju-00058B-2f; Wed, 17 Jul 2024 04:10:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5185C7B21B;
 Wed, 17 Jul 2024 11:10:02 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8C97310B136;
 Wed, 17 Jul 2024 11:10:06 +0300 (MSK)
Received: (nullmailer pid 831465 invoked by uid 1000);
 Wed, 17 Jul 2024 08:10:06 -0000
Subject: [ANNOUNCE] QEMU 8.2.6 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jul 2024 11:10:06 +0300
Message-Id: <1721203806.547734.831464.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi everyone,

The QEMU v8.2.6 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-8.2.6.tar.xz
  https://download.qemu.org/qemu-8.2.6.tar.xz.sig (signature)

v8.2.6 is now tagged in the official qemu.git repository, and the
stable-8.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-8.2

There are 23 changes since the previous v8.2.5 release, including
a fix for CVE-2024-4467 (qemu-img info command lack of input validation).
This is supposed to be the last release in 8.2.x series.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-8.2-hash master-hash Author Name: Commmit-Subject):

46300ebc38 Michael Tokarev:
 Update version for 8.2.6 release
57d9378af9 3936bbdf9a Vincent Fu:
 hw/nvme: fix number of PIDs for FDP RUH update
55b151b6a6 e389929d19 Markus Armbruster:
 sphinx/qapidoc: Fix to generate doc for explicit, unboxed arguments
8f7bb1266f a0124e333e Maxim Mikityanskiy:
 char-stdio: Restore blocking mode of stdout on exit
b932f9fbd4 7aa6492401 Stefano Garzarella:
 virtio: remove virtio_tswap16s() call in vring_packed_event_read()
0d2c267638 a113d041e8 Cindy Lu:
 virtio-pci: Fix the failure process in kvm_virtio_pci_vector_use_one()
aea89f4179 7ead946998 Kevin Wolf:
 block: Parse filenames only when explicitly requested
46fdbe667d 7e1110664e Kevin Wolf:
 iotests/270: Don't store data-file with json: prefix in image
6a2774e8ae 2eb42a728d Kevin Wolf:
 iotests/244: Don't store data-file with protocol in image
d7e7f342c6 bd385a5298 Kevin Wolf:
 qcow2: Don't open data_file with BDRV_O_NO_IO
38fb9d1edc 7619129f0d Richard Henderson:
 target/arm: Fix FJCVTZS vs flush-to-zero
8c56d9f61a 76bccf3cb9 Richard Henderson:
 target/arm: Fix VCMLA Dd, Dn, Dm[idx]
40e04161b3 903916f0a0 Chuang Xu:
 i386/cpu: fixup number of addressable IDs for processor cores in the physi=
=3D
cal package
df0e72dc86 641b1efe01 Thomas Huth:
 tests: Update our CI to use CentOS Stream 9 instead of 8
5d9f2461b4 6d3279655a Fabiano Rosas:
 migration: Fix file migration with fdset
1229d60714 521d7fb3eb Richard Henderson:
 tcg/loongarch64: Fix tcg_out_movi vs some pcrel pointers
f4564fc8d2 6b4965373e Cl=3DC3=3DA9ment Chigot:
 target/sparc: use signed denominator in sdiv helper
1649e9559b 54b2792102 Ilya Leoshkevich:
 linux-user: Make TARGET_NR_setgroups affect only the current thread
40682cfcea 3b279f73fa Anton Johansson:
 accel/tcg: Fix typo causing tb->page_addr[1] to not be recorded
d08c1fd6db b1cf266c82 Gerd Hoffmann:
 stdvga: fix screen blanking
1798f38242 a276ec8e26 Philippe Mathieu-Daud=3DC3=3DA9:
 hw/audio/virtio-snd: Always use little endian audio format
fdbeeb454c 77bf310084 Dongwon Kim:
 ui/gtk: Draw guest frame at refresh cycle
fa275f2211 2c3e4e2de6 Alexey Dobriyan:
 virtio-net: drop too short packets early
3e09472893 3973615e7f Mark Cave-Ayland:
 target/i386: fix size of EBP writeback in gen_enter()

