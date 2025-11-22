Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD9ACFD2EF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 21:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMuma-00080o-E3; Sat, 22 Nov 2025 16:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMumV-0007zF-2K; Sat, 22 Nov 2025 16:04:31 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMumL-00063z-7y; Sat, 22 Nov 2025 16:04:26 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B232716D2FA;
 Sun, 23 Nov 2025 00:03:33 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 69AAE3223CE;
 Sun, 23 Nov 2025 00:03:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.22 00/25] Patch Round-up for stable 7.2.22,
 freeze on 2025-12-01
Date: Sat, 22 Nov 2025 23:55:18 +0300
Message-ID: <qemu-stable-7.2.22-20251122235450@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following patches are queued for QEMU stable v7.2.22:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2025-12-01, and the release is planned for 2025-12-03:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

This most likely will be the last release in 7.2.x series.

Thanks!

/mjt

--------------------------------------
01 df9a3372ddeb Mathias Krause:
   target/i386: Fix CR2 handling for non-canonical addresses
02 df32e5c568c9 Paolo Bonzini:
   i386/cpu: Prevent delivering SIPI during SMM in TCG mode
03 cdba90ac1b0a YiFei Zhu:
   i386/tcg/smm_helper: Properly apply DR values on SMM entry / exit
04 5142397c7933 Paolo Bonzini:
   async: access bottom half flags with qatomic_read
05 58aa1d08bbc4 Paolo Bonzini:
   target/i386: user: do not set up a valid LDT on reset
06 7c7089321670 Bastian Blank:
   linux-user: Use correct type for FIBMAP and FIGETBSZ emulation
07 0db2de22fcbf Peter Maydell:
   linux-user: permit sendto() with NULL buf and 0 len
08 003f15369de4 Daniel P. Berrangé:
   io: add trace event when cancelling TLS handshake
09 2c147611cf56 Daniel P. Berrangé:
   io: release active GSource in TLS channel finalizer
10 322c3c4f3abe Daniel P. Berrangé:
   io: move websock resource release to close method
11 b7a1f2ca45c7 Daniel P. Berrangé:
   io: fix use after free in websocket handshake code
12 3995fc238e05 Daniel P. Berrangé:
   crypto: stop requiring "key encipherment" usage in x509 certs
13 ed26056d90dd Richard W.M. Jones:
   block/curl.c: Use explicit long constants in curl_easy_setopt calls
14 ad97769e9dcf Richard W.M. Jones:
   block/curl.c: Fix CURLOPT_VERBOSE parameter type
15 59506e59e0f0 Eric Blake:
   qio: Add trace points to net_listener
16 6e03d5cdc991 Eric Blake:
   qio: Unwatch before notify in QIONetListener
17 b5676493a08b Eric Blake:
   qio: Remember context of qio_net_listener_set_client_func_full
18 9d86181874ab Eric Blake:
   qio: Protect NetListener callback with mutex
19 6da0c9828194 Peter Maydell:
   hw/net/e1000e_core: Don't advance desc_offset for NULL buffer RX 
   descriptors
20 9d946d56a2ac Peter Maydell:
   hw/net/e1000e_core: Correct rx oversize packet checks
21 bab496a18358 Peter Maydell:
   hw/net/e1000e_core: Adjust e1000e_write_payload_frag_to_rx_buffers() 
   assert
22 a01344d9d780 Peter Maydell:
   net: pad packets to minimum length in qemu_receive_packet()
23 f52db7f34242 Peter Maydell:
   hw/display/xlnx_dp.c: Don't abort on AUX FIFO overrun/underrun
24 032333eba77b Peter Maydell:
   hw/display/xlnx_dp: Don't abort for unsupported graphics formats
25 5fc50b4ec841 Peter Maydell:
   hw/misc/npcm_clk: Don't divide by zero when calculating frequency

