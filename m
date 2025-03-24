Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED6CC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 08:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twcod-0002qA-41; Mon, 24 Mar 2025 04:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sa.z@qq.com>)
 id 1twcoX-0002ph-HT; Mon, 24 Mar 2025 04:05:41 -0400
Received: from out203-205-221-233.mail.qq.com ([203.205.221.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sa.z@qq.com>)
 id 1twcoT-0006d9-Gn; Mon, 24 Mar 2025 04:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1742803517; bh=M0AebHbWlzW8Hied416z3SaDV8X6LvMttUbkEpuVRHM=;
 h=From:To:Cc:Subject:Date;
 b=nj98BVxGIxqt7pEEXX5yMohRsz/wwt+nEftEdAhoPjvTTYUP8z6MKCSISn8u2uUA4
 DrqWJex0058Avr3Sa4MMe+EtLoXaltfSnzAwM5YyF6w7Yk89Hyga0UCDVqBgTJnQGV
 kbiw73mU62thOw67DSubK9FBHCnX1CsNXYpVr09w=
Received: from localhost.localdomain ([120.46.176.49])
 by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
 id 14FB9632; Mon, 24 Mar 2025 16:05:15 +0800
X-QQ-mid: xmsmtpt1742803515t577p4abw
Message-ID: <tencent_4E3504A0739AEE8199766C5415093D24CE05@qq.com>
X-QQ-XMAILINFO: Mh8zSn5h7V45vr9Dmd/ASDX9ZQc/PPSikapeITg3F8vcyWvW+kwKm63bKf/LX3
 bDp+O2QDsMCxT3OaVtw8RkmiyoKCRVTCVT3jzMq0wajerZv2y1avWfiJ6Ix5pbDu6zaSan+wUkvT
 88FYkOz7vSw/dUTwv0LUdJQIC95m8gVewoGXeLNP4YEzCcKiZBRlgL+CZKDkp1wNIp5RWEBoAJiD
 43vgRfDFjTtZNEiEel4cuj3llpUCi1gtaa40PmkLXTwUU1n5ZKSQQ4FQwBekrMiDmxfu+RioQepK
 rlDRRQHJrZuWBVA6Jur5eWSIFWKU/++Vnsw41Vj9WcEIO/3usvn0d5HKd9MwIXEdXmJdaWx0Lmbx
 Qf3bv6OjNW/Aib6EZV/TydP95QAFTa4E4/ExHODpwQ3sAzCIjhhkWlSh0MiPVcUOyPlCTg5VxtDK
 blz17uz7JIbJ1+4LSDFV5TCU7J4WevTukURVRP49p0njt9K+IxjEJxmX0chhX0sqeDKaPCeePygW
 0NfqIXw7emO5jo9R0eUHMjjWH6Vt2bMhy0HY51b22w8gn4ql/Pwc5eztIOyZOF7bwTBz6WeVnfOV
 jW6w5DjeWBWm89oqRkiia34ZDWEhMOZ5DXjrOHDEnqngziRqqCwAM63S4ADZhnUPHNLuMUkHAP2b
 ubaVLW7jlIjaCekxNYJNoj91hBlI9ZhVrzxPP303/8n8jptABkFR3EDuk5u+bKNoWsNX0QHKbdGx
 D+Q/zVkohv3K8t3VxUU2DWNlW4YyvarypywGFBi/SceSmMIvdMajxJx2U2miX8d9y0fgMjni3zYc
 wQBLvVzWNITnVXgVUW2/bUbqFtjzp0LZ8cvExl0AiMtEwGiUs2d4z2zyGIAL4HiCvMlEH4j2rLta
 T0Mchguhz67uWqsRBvb71ApVVTfmr0fCDi/SAYr89DqkSptz1JAorEkrRbREEzdA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: saz97 <sa.z@qq.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, saz97 <sa.z@qq.com>
Subject: [PATCH 0/1 RFC] FUSE Export Coroutine Integration Cover Letter
Date: Mon, 24 Mar 2025 16:05:09 +0800
X-OQ-MSGID: <20250324080509.150472-1-sa.z@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.233; envelope-from=sa.z@qq.com;
 helo=out203-205-221-233.mail.qq.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This patch series refactors QEMU's FUSE export module to leverage coroutines for read/write operations,
addressing concurrency limitations and aligning with QEMU's asynchronous I/O model. The changes
demonstrate measurable performance improvements while simplifying resource management.

1. technology implementation

   according to Stefan suggerstion, i move the processing logic of read_from_fuse_export into a coroutine for buffer management.
   and change the fuse_getattr to call: bdrv_co_get_allocated_file_size().    

2. performance summary

   For the coroutine_integration_fuse test, the average results for iodepth=1 and iodepth=64 are as follows:
    -------------------------------  
    Average results for iodepth=1:
    Read_IOPS: coroutine_integration_fuse: 4492.88 | origin: 4309.39 | 4.25% improvement
    Write_IOPS: coroutine_integration_fuse: 4500.68 | origin: 4318.68 | 4.21% improvement
    Read_BW: coroutine_integration_fuse: 17971.00 KB/s | origin: 17237.30 KB/s | 4.26% improvement
    Write_BW: coroutine_integration_fuse: 18002.50 KB/s | origin: 17274.30 KB/s | 4.23% improvement
    --------------------------------
    -------------------------------
    Average results for iodepth=64:
    Read_IOPS: coroutine_integration_fuse: 5576.93 | origin: 5347.13 | 4.29% improvement
    Write_IOPS: coroutine_integration_fuse: 5569.55 | origin: 5337.33 | 4.33% improvement
    Read_BW: coroutine_integration_fuse: 22311.40 KB/s | origin: 21392.20 KB/s | 4.31% improvement
    Write_BW: coroutine_integration_fuse: 22282.20 KB/s | origin: 21353.20 KB/s | 4.34% improvement
    --------------------------------
   Although all metrics show improvements, the gains are concentrated in the 4.2%–4.3% range, which is lower than expected. Further investigation using gprof reveals the reasons for this limited improvement.

3. Performance Bottlenecks Identified via gprof
   After running a fio test with the following command:
   fio --ioengine=io_uring --numjobs=1 --runtime=30 --ramp_time=5 \
    --rw=randrw --bs=4k --time_based=1 --name=job1 \
    --filename=/mnt/qemu-fuse --iopath=64
   and analyzing the execution profile using gprof, the following issues were identified:

   3.1 Increased Overall Execution Time
   In the original implementation, fuse_write + blk_pwrite accounted for 8.7% of total execution time (6.0% + 2.7%).
   After refactoring, fuse_write_coroutine + blk_co_pwrite now accounts for 43.1% (22.9% + 20.2%).
   This suggests that coroutine overhead is contributing significantly to execution time.

   3.2 Increased Read and Write Calls
   fuse_write calls increased from 173,400 → 333,232.
   fuse_read calls increased from 173,526 → 332,931.
   This indicates that the coroutine-based approach is introducing redundant I/O calls, likely due to unnecessary coroutine switches.

   3.3 Significant Coroutine Overhead
   qemu_coroutine_enter is now called 1,572,803 times, compared to ~476,057 previously.
   This frequent coroutine switching introduces unnecessary overhead, limiting the expected performance improvements.

saz97 (1):
  Integration coroutines into fuse export

 block/export/fuse.c | 190 +++++++++++++++++++++++++++++---------------
 1 file changed, 126 insertions(+), 64 deletions(-)

-- 
2.34.1


