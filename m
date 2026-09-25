Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0891EC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8Rf-0006mA-UN; Fri, 25 Sep 2026 12:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8DS-0007pX-2D
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:02 -0400
Received: from mail-wm2-x0b.google.com ([2a00:1450:4864:31::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8DO-0005vr-3n
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:01 -0400
Received: by mail-wm2-x0b.google.com with SMTP id
 5b1f17b1804b1-49cfcf2548aso4532925e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1790351514; x=1790956314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gxs1zteg0oJgOLh9bWSpvJH5UE46pzc88b0ND8irtRg=;
 b=PPZJN7iYXizp3yHjP/Kpi5+OSZsLXLv3pYZEo5f34v4Xx/jnSCSBWzm9Up/K7H+Mgt
 YmUuPAJ1Mu4/NZaoTN4h3r20y2y+LsTfHQnLheBVHHvtXeMALTlzAXxmjiRfmSaA/nPw
 W/N5o37gZIMvRMDrgVrW8Egn8IB0prDXpa2J04jVz4UQOARLvocHQr55h1E5BwG+5pwp
 VVwTZLR/KU8xUy+xeP2xhLTBUSSbs28kLIjLqvh49qTT5IkJkSP3y0NiYT8sxvBFJlS9
 uFjAxLQBt4jyGeOgxXfEMcr/71rt4RIiv/BEJYqVwcJRK3VwpOuqrBTyrqhvohIL6Kvw
 MI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351514; x=1790956314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gxs1zteg0oJgOLh9bWSpvJH5UE46pzc88b0ND8irtRg=;
 b=Z558o77A/ro9rUqVFutq7LsD/FQtMdahJuT1wuBhoYpohi56YrRnYlqW52BP8lkSl4
 QQU5WGfmZKK3WB7Dacfl7BD8lFZgGbBBRLyHjtqh8ZRLCVGbMpC4nhAf13mv6IPymEFP
 HYQVidtYYvA3R0pznUBLHI/L8I7Wu8amtSYcEI/nEvKKaihJy0IrTDW8GsaMijbsnknb
 BD6ZieSN22HOu/M8yV10FTIgwveFgQGYJaqcsKu0IP+k/kPzfL0LirN+jnaUjKPkSr3S
 tWve/TJ2sFELWe7TbFBIfmC/UIjiq/SUVzEsnQvxgmSas8SjH3Qh1UgWMNgaynNQx90F
 tZrw==
X-Gm-Message-State: AFuF++mBCM21EUAJHluRIViKcFedufD90uvm4TkVnY/zuLbwNeTtg7Vt
 IkHDgcoI3xMOTMyFSYAqnCllIQLh6mcQ3lFor8aQB4Ta0qsuFCL2K/kUtfQFh80kYduop477WFX
 18CmN/qidaNE4
X-Gm-Gg: AYBFou2gYCGKFYgwXC/pmfyXrZwFv4whB1uaLid4B8kQT4suSwgcxu88sCVfLO5lOBU
 A2gt+Ebsy+DZ6tfBxp77uL+9rcmcp8NlC4ZoW+sqHcsR5TdwwH/9Iq/0IQe85fzPqCVNwYI4fAz
 bDmaUhhlXvfmJcI38+3XWMCZSAHsntUssRb73/i6T5fBBfLLmSFs8UzVaW4v8I85nwmO8tgWyxe
 6NLr2t7vzuhftZHYlZKjDVMRB5EfTbNx9erMtDFe/sIikIUrQEnLUhGLQNVJ4ybcEdSBna2gBfp
 QifSPb+dMpsnbUp47r410FsLEJWddTWGQ60xsdk+qKf3hViVY4F62id772KSmvWvcY0PjKE0Pe6
 bkMedgwXMWWxiZBKK0UaPnwFBqHmQtGCGn6sjSCi2Of42d6YMTPCqIAneZxsb9iT33DgadSmOh8
 3tmr3PIn1qG+oHHZFx7uWvOe3dp6bj0TJ9qoJG94MlAKCshR9obJX7gVk9KCYfJJv4dl8oIBQ/n
 Uo1HOt3HubphobdRq8TyA6FOjsJqLLJUb8ducVQ0Q==
X-Received: by 2002:a05:600c:6287:b0:49d:827:e5b6 with SMTP id
 5b1f17b1804b1-49fe7babaadmr98468075e9.20.1790351513600; 
 Fri, 25 Sep 2026 08:51:53 -0700 (PDT)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm112435875e9.0.2026.09.25.08.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:51:52 -0700 (PDT)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH 00/13] migration/rdma: producer/consumer send path
Date: Fri, 25 Sep 2026 17:51:35 +0200
Message-ID: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:31::b;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wm2-x0b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:04:38 -0400
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

This series splits the RDMA live-migration send path into two threads:

  - a producer thread (the migration thread) that scans dirty pages and
    records which chunks must be migrated, pushing chunk descriptors
    (block + chunk index + dirty byte span) onto a lock-free SPSC ring;
    and
  - a consumer thread that owns the RDMA queue pair: it drains the ring,
    posts the RDMA writes and control messages, handles chunk
    registration and barriers, and polls the completion queue.

Chunk-granular descriptors on the ring replace the previous per-page
merge logic on the migration thread.

Dependencies / how to apply
---------------------------
Prerequisites (not included; apply first), both from Yanfei Xu:
  [PATCH v3 0/4] migration/rdma: Allow multiple writes per chunk
  https://lore.kernel.org/qemu-devel/20260913062455.940447-1-yanfei.xu@bytedance.com/
  [PATCH v3 0/3] migration/rdma: Misc RDMA migration fixes
  https://lore.kernel.org/qemu-devel/20260823021657.2824542-1-yanfei.xu@bytedance.com/
The base-commit below is upstream master; both Yanfei series are recorded
as the prerequisite-patch-id entries after it.

Note: the misc-fixes series here is Yanfei's v3 rebased onto current
master (trace events renamed qemu_rdma_* -> rdma_*), so its
prerequisite-patch-id entries differ from the v3 posting.

Patches 1-12 are the producer/consumer split.  Patch 13 (Jack Wang)
negotiates the batched chunk registration capability so a peer that
lacks it falls back to one chunk per request.

Results
-------
64 GiB guest, single-path RDMA, memload workload (one-time RAM fill,
fixed dirty set).  "before" is the single-thread send path with
only the nb_sent-stats patch (patch 1) applied; "after" is the full
producer/consumer series, so the delta isolates the split itself.

pin_all=off:
  - total migration time: -16.2% (24 GiB fill), -14.2% (60 GiB fill)
  - transfer-phase time:  -16.3% (24 GiB fill), -14.2% (60 GiB fill)
  - RAM throughput:       +17.2% (24 GiB fill), +16.6% (60 GiB fill)
  - guest downtime:       -55.3% (24 GiB fill), -23.1% (60 GiB fill)

pin_all=on (whole-RAM registration at setup is unchanged and dominates
total time, so the split shows mainly in the transfer phase):
  - total migration time: -5.0%
  - transfer-phase time:  -10.9%
  - transfer speed:       +12.9%
  - guest downtime:       -1.5%

QP saturation was measured with the new nb_sent send-queue counter:
send-queue "drain to zero" events (queue starved empty) fell by ~99% in
the transfer-bound pin_all=off cases (24 GiB: 26609 -> 276; 60 GiB:
63771 -> 641), while "full-queue" hits rose.

This is the first step toward RDMA multipath migration.

Dmitrii Omelchenko (12):
  migration/rdma: Add nb_sent send-queue-depth stats
  migration/rdma: Add producer/consumer send-ring types
  migration/rdma: Add send-ring lifecycle (no consumer thread yet)
  migration/rdma: Add the send consumer thread (drain only)
  migration/rdma: Handle write/flush/reg-stop on the consumer
  migration/rdma: Extract qemu_rdma_write_file() and dispatch FILE
  migration/rdma: Switch the producer onto the send ring
  migration/rdma: Add producer/consumer tuning instrumentation
  migration/rdma: drain the send ring in batches
  migration/rdma: size reg_resp.len by the register request count
  migration/rdma: batch chunk registration in one round-trip
  migration/rdma: trace batching and register runs

Jack Wang (1):
  migration/rdma: negotiate batched chunk registration

 migration/rdma.c       | 1275 +++++++++++++++++++++++++++++-----------
 migration/trace-events |   18 +
 2 files changed, 956 insertions(+), 337 deletions(-)


base-commit: 3876503faff51ce3a132dbbd0ab42c10f2269319
prerequisite-patch-id: 52ae8b66be76e06e9c74c2fca1dced7f76a260b0
prerequisite-patch-id: fadde94af9705117610d71a769d67fdd40b9de4f
prerequisite-patch-id: 8f458aab8e4d1ab1f8d1810051a624341cc9faa8
prerequisite-patch-id: a7c1ffb7ac1c0b9a31858aad636616916e963663
prerequisite-patch-id: 8327b7f067c2925781d68a6d506bf0889f31e186
prerequisite-patch-id: e1879a49d37f2a1b6ea797d3bc48e016f865cf9e
prerequisite-patch-id: 3d8d7869b69fa850f37558f3170e95a46517b3f8
-- 
2.39.5


