Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7E9C28B30
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 17:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttVXz-0008R0-KH; Sat, 15 Mar 2025 13:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sa.z@qq.com>)
 id 1ttVXw-0008No-Rp; Sat, 15 Mar 2025 13:43:41 -0400
Received: from out203-205-221-153.mail.qq.com ([203.205.221.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sa.z@qq.com>)
 id 1ttVXm-00023x-1e; Sat, 15 Mar 2025 13:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1742060602; bh=0263ToPUCWoLI78FG41lXWz1Jo55O5cNcJGdMQaFmWs=;
 h=From:To:Cc:Subject:Date;
 b=QnDRPUbeb1MU7BUqNaEePB1hAlmEsMuMtBCTYkA+2xhsmPK9GitxZVk4/UC8WWy0Y
 PWSPH1Xgc5FwIS+97m3ZUa2LeJuJ+OUkYG56rzLWJ3Q0t5J/XA4kY3iiySDZeNu9vr
 1y1AJwq+iPNTPeBh+mP6jizoJhxJtmeUEyvU4Efo=
Received: from localhost.localdomain ([120.46.176.49])
 by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
 id 78C1D249; Sun, 16 Mar 2025 01:30:12 +0800
X-QQ-mid: xmsmtpt1742059812te932whp2
Message-ID: <tencent_768F19A8DEA12BC51D868074DAD0E933DF0A@qq.com>
X-QQ-XMAILINFO: NAuAIaytDrXpXMJ3eSIW7TnHT1eOfEYkTJa3+oqWvQhKDNlQbuGPjJFEy1Ls8t
 Bg0WmxytakLrbSWbz5rXUVctEDWKFmz6NSLSDQUPeGeahGbwNR63LSdZpOmlDSppPmY/NETeHrnw
 BxJ+qxFfmBs5mrdRaxr0exi4qD1/diSve3tVoJa5bdG7GI6wsdoqmHkGMnr+ptBPzMeVgfKTG208
 atKLp8rl03AR1PfbiXhlmeMr7G3A3gw4m1/1iR7Rv/AP2W1wZP1PlnFNYKml2WjR30SiPsXUzcyz
 OdcVEbR5Bwm0HOOtyY635x/c6U3KJVGrXv/OjaDPUGpiUnXnXkN51xIR+CH4I8/cH3W+G8nNdtVF
 FaCRG/VV2YhDjatJ31pCRA8HEW+MUa1fnlEjTe8/jHKwRo8pkG/M8nSSgFbP7Thoye0CmLReO7BL
 IMscgeB+T3TE9OVHurUuYeqx+yPAoLOnLVL/ndlkcBezqsngxsG/zUyiU5/7CO8CowNXhTuosRy7
 F4k75JAuZphG4e6sWL8urAInKXrtOOHTB4DbxAgnJkyOu34hnzbzJGKRGo65dHegZdDkSNEVYHEP
 qy9qsl4MJ2tZG3m1YzKTvORzn2/MuY/gBwde48/7W5TpZczN9S+YQBWQ7lM3FPd9NXmA2m/CkWkF
 H+09Ba07Qfx/We39MZxLKoIFPq2glatcqkcTNjPPYg5qrx60m4Lk6ed2Tbrly/ahxWI+h3JPNk0l
 32ByJVLdljU0cKbvd61+x0aZN58PtAVCVsGymzKLhAKIsqdSrW7mg65DJp2pAX9DpMWUiDidXIsK
 T5uDoB8o+wVEitFAYw0RtO8R4htWwvg7Yfg/Hruc7sMzyXIKPNCv7v6MGZComF6pVFjq7PAVlLJw
 7JFEbV8Q27cRj0LPSd70v/kZADDfi4i2iCsMutSM6heaLhcCUhouYHabItwEYn2M07kwHcFi12CG
 NISSiiQXBazcUv/3vLyKHkJaYAotD05JKcWGFFD3hbYIuIDaWsuQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: saz97 <sa.z@qq.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, saz97 <sa.z@qq.com>
Subject: [PATCH 0/1 RFC] FUSE Export Coroutine Integration Cover Letter
Date: Sun, 16 Mar 2025 01:30:06 +0800
X-OQ-MSGID: <20250315173006.51920-1-sa.z@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.153; envelope-from=sa.z@qq.com;
 helo=out203-205-221-153.mail.qq.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Changzhi Xie <sa.z@qq.com>

FUSE Export Coroutine Integration Cover Letter

This patch series refactors QEMU's FUSE export module to leverage coroutines for read/write operations, 
addressing concurrency limitations and aligning with QEMU's asynchronous I/O model. The changes 
demonstrate measurable performance improvements while simplifying resource management.

1. Technical Implementation
Key modifications address prior review feedback (Stefan Hajnoczi) and optimize execution flow:

​1.1 Coroutine Integration
Convert fuse_read()/fuse_write() to launch coroutines (fuse_*_coroutine)
Utilize non-blocking blk_co_pread()/blk_co_pwrite() for block layer access
Eliminate main loop blocking during heavy I/O workloads

1.2 ​Buffer Management
Removed explicit buffer pre-allocation in read_from_fuse_export()
Replaced fuse_buf_free() with g_free() due to libfuse3 API constraints

​1.3 Resource Lifecycle
Moved in_flight decrement and blk_exp_unref() into coroutines
Added FUSE opcode checks (FUSE_READ/FUSE_WRITE) to prevent premature cleanup

1.4 ​Structural Improvements
Simplified FuseIORequest structure:
Removed redundant fuse_ino_t and fuse_file_info fields
Retained minimal parameter passing requirements

2. Performance Validation
Tested using fio with 4K random RW pattern, and the result is the average of 5 runs:
fio --ioengine=io_uring --numjobs=1 --runtime=30 --ramp_time=5 --rw=randrw --bs=4k --time_based=1

Key Results

Metric	       iodepth=1	           iodepth=64
​Read Latency	  ▼ 2.7% (3.8k→3kns)	  ▼ 1.3% (4.7M→4.6M ns)
​Write Latency	▼ 3.6% (112k→108kns)	▼ 2.8% (5.2M→5.0M ns)
​Read IOPS	    4740 → 4729 (±0.2%)	  ▲ 2.1% (6391→6529)
​Write IOPS	    4738 → 4727 (±0.2%)	  ▲ 2.2% (6390→6529)
​Throughput	    ~18.9 GB/s (stable)	  ▲ 2.1% (25.6→26.1 GB/s)

Analysis

​High Concurrency (iodepth=64):
Sustained throughput gains (+2.1-2.2%) demonstrate improved scalability
Latency reductions confirm reduced contention in concurrent operations

saz97 (1):
  Integration coroutines into fuse export

 block/export/fuse.c | 189 +++++++++++++++++++++++++++++++-------------
 1 file changed, 132 insertions(+), 57 deletions(-)

-- 
2.34.1


