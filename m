Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFF9D3B7D0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 16:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRurS-0005pn-9S; Sat, 06 Dec 2025 11:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vRurQ-0005o0-Ew; Sat, 06 Dec 2025 11:10:16 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vRurO-0003h9-6r; Sat, 06 Dec 2025 11:10:15 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 62E54171B4C;
 Sat, 06 Dec 2025 19:10:06 +0300 (MSK)
Received: from tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id 63FFC32DF47;
 Sat, 06 Dec 2025 19:10:09 +0300 (MSK)
Received: (nullmailer pid 2700444 invoked by uid 1000);
 Sat, 06 Dec 2025 16:10:09 -0000
Subject: [ANNOUNCE] QEMU 7.2.22 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Dec 2025 19:10:09 +0300
Message-Id: <1765037409.358237.2700443.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi everyone,

The QEMU v7.2.22 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-7.2.22.tar.xz
  https://download.qemu.org/qemu-7.2.22.tar.xz.sig (signature)

v7.2.22 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2

There are 25 changes since the previous v7.2.21 release.
The changes include a fix for CVE-2025-11234 (use after free in websocket
handshake code).

This release is expected to be the last one in 7.2.x series,
except if an urgent or security fix will be needed.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-7.2-hash master-hash Author Name: Commmit-Subject):

30a68773a4 Michael Tokarev:
 Update version for 7.2.22 release
d0a90254f1 5fc50b4ec8 Peter Maydell:
 hw/misc/npcm_clk: Don't divide by zero when calculating frequency
842f4f8db3 032333eba7 Peter Maydell:
 hw/display/xlnx_dp: Don't abort for unsupported graphics formats
ed8911d1c6 f52db7f342 Peter Maydell:
 hw/display/xlnx_dp.c: Don't abort on AUX FIFO overrun/underrun
516bab6fdf a01344d9d7 Peter Maydell:
 net: pad packets to minimum length in qemu_receive_packet()
28efd5e5dd bab496a183 Peter Maydell:
 hw/net/e1000e_core: Adjust e1000e_write_payload_frag_to_rx_buffers() assert
84b22d847c 9d946d56a2 Peter Maydell:
 hw/net/e1000e_core: Correct rx oversize packet checks
ed8bb28165 6da0c98281 Peter Maydell:
 hw/net/e1000e_core: Don't advance desc_offset for NULL buffer RX descriptors
b048921c1c 9d86181874 Eric Blake:
 qio: Protect NetListener callback with mutex
cd990562fa b5676493a0 Eric Blake:
 qio: Remember context of qio_net_listener_set_client_func_full
737c9f03e9 6e03d5cdc9 Eric Blake:
 qio: Unwatch before notify in QIONetListener
ab84c84130 59506e59e0 Eric Blake:
 qio: Add trace points to net_listener
020a726791 ad97769e9d Richard W.M. Jones:
 block/curl.c: Fix CURLOPT_VERBOSE parameter type
514a83a038 ed26056d90 Richard W.M. Jones:
 block/curl.c: Use explicit long constants in curl_easy_setopt calls
ce3d901244 3995fc238e Daniel P. Berrangé:
 crypto: stop requiring "key encipherment" usage in x509 certs
cebdbd038e b7a1f2ca45 Daniel P. Berrangé:
 io: fix use after free in websocket handshake code
911c814c8c 322c3c4f3a Daniel P. Berrangé:
 io: move websock resource release to close method
7769aada0a 2c147611cf Daniel P. Berrangé:
 io: release active GSource in TLS channel finalizer
f3929f32fb 003f15369d Daniel P. Berrangé:
 io: add trace event when cancelling TLS handshake
87ceabcf34 0db2de22fc Peter Maydell:
 linux-user: permit sendto() with NULL buf and 0 len
a041632d4c 7c70893216 Bastian Blank:
 linux-user: Use correct type for FIBMAP and FIGETBSZ emulation
c88a40041f 58aa1d08bb Paolo Bonzini:
 target/i386: user: do not set up a valid LDT on reset
5adcdce946 5142397c79 Paolo Bonzini:
 async: access bottom half flags with qatomic_read
9fed0f14b2 cdba90ac1b YiFei Zhu:
 i386/tcg/smm_helper: Properly apply DR values on SMM entry / exit
f4ede985eb df32e5c568 Paolo Bonzini:
 i386/cpu: Prevent delivering SIPI during SMM in TCG mode
873955f965 df9a3372dd Mathias Krause:
 target/i386: Fix CR2 handling for non-canonical addresses


