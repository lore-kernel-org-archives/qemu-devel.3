Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C6606AA68
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=aaQeff58
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnNz-00034P-16; Tue, 10 Nov 2026 10:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnNp-0002yw-LO
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:03:39 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnNn-0008Rg-C5
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:03:37 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4922dbcee23so1184386f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1794323012; x=1794927812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0cnKz6Y/cklnPMd8EG7yJoXLcetG0974eo77SG4TVHc=;
 b=aaQeff585Yy1DS4wk1s9BhvGkCj5npxtieFGKIGZFIa6cdI3eey9KXTDaFXY56Xro9
 JCtd3bzi2uNekYaVyAmw638sy7RqcpXPwsR8qx9k4uVlROw/dhKVISkj2Fyk/aFR7aZt
 B9EHfIIyz0QyF9saf+XgpjtqvnqydhQ/AQqvxm4tJDmQFb8imCChj/fOKrGxgAdqfPmp
 KnB39q+Kter30scTRijhR5ewTOpQdQUHDprBfyEu4DtqfU9rfIjxde9gX8U1T1Jplb/A
 mb+f8WP2eQ6dBJoBOpsrZ0cSHad00+sDJjGlMBGiIgbDMx3Dx+rH87pLVwpGgUSy9wGI
 XFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323012; x=1794927812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0cnKz6Y/cklnPMd8EG7yJoXLcetG0974eo77SG4TVHc=;
 b=CPKKEiM27bhVoux7eYlfV/ITvPt7jKWtnBqDGLW99ZZbBgigo+ImZ+2MJSaj9elLhU
 Q6BHYYHBS3R24UVPhOWLVEc8JU6WiXdYgSMUT8Pa9PsbvN3GAdnyi7p41IQNW63E4YR3
 aJiinZ0Xyx832U93Mi8jL7yZUzUTGKogoXtxGIKY2kzW0zZK91j+5RJNiKKzzh3L8Urp
 kv7xGE+J+ZMHvuqwHI8TTMb3CNAFoRM+7Hr7KG11nIb73Y+L+99Y5KLu5PrttXw3wQiA
 lF5K5aGogh95WVPmZV5JWWK5SvJfxsYBhCuhpRNvEIbo6J7hVNZOD/bxfQv9VjYE+FdF
 cPxA==
X-Gm-Message-State: APuU4Z9JZurf6UvHY+jPEa3NSG5Y/IFWsyUMAx1+bj+pNrBvnbIz26Ss
 xqNoTTG52IBdS/UX0YdEBigH7cXgq17uF8JqNxrFTxZ78ZNMH6V6nGDXav02xQ8lHryrRkZ6i6r
 humAnUOQ=
X-Gm-Gg: AYBFou0Yt7Az0NGoz6XHSuESX2f8skx4xewWHzOjdVQjUQtokXdK97ZqzZfD/V5qKE1
 lQoMdZZwOFJmB4CZEdC+/jQKdBOODA+dxThqXD5z/4xL4UHkykfEA/K9klcy12sVO6KuTXBMbZS
 b35MrZjAWkdq4DvJC/UbtWYNYedmJ0z+dRLsHqGJf1p5lwZt2wAGExKvDK+RS5l1X/SHHJuk6B1
 KSk/grX4/L0MGzsYuRAP3MIDFY39Q/XXvoNoF/x2CCiygb2x/qZxKEkL+FGzG7zfXOYsZEKBY3/
 PiCA9sdFjNzgEEdLccaj2U70QQSrqHl27TdAD54Lu5OY8aLesPmhowKYn8ywl6rKrKjgRCGkGK6
 2stKXOYT5nirG87ozfhnWTTHi9CkaO99igYQhLpChnV4288Ti3oh0Ckij6X0LQtO67d4NHcVT+5
 JOc+0c0YHAap58yx8p9D3nsGs2hBzCR0/v1Wz11whHfptIzXf983DwS/TBZ4j1Ri8v97RWdkn0z
 Gwb9FD9yQDYJu/C+3wJc+9LKG5I32Xr0HShMp07heZ4diFyEzAX4te8xkbbnIxnYLG1uriTSa70
 aS7AxFpd2QvfOQ7WgeVi2pQaRsAy6Ck5fgXVmnamj86Fptld6/Dju0/x0qY1enQTtN+0FPVC
X-Received: by 2002:adf:e006:0:20b0:493:d5f0:4e4c with SMTP id
 ffacd0b85a97d-4982fd3e436mr3797705f8f.23.1794323011886; 
 Tue, 10 Nov 2026 07:03:31 -0800 (PST)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm5116931f8f.49.2026.11.10.07.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:03:31 -0800 (PST)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, yanfei.xu@bytedance.com,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH RESEND 00/13] migration/rdma: producer/consumer send path
Date: Tue, 10 Nov 2026 16:02:34 +0100
Message-ID: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::432;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a rebase with no code changes; the prerequisites (Yanfei Xu's
two RDMA series) were merged in migration-20260925-pull-request.

v1: https://lore.kernel.org/qemu-devel/20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com/

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


base-commit: 71f25c75417d31c214ba2cd26b273c114fc99987
-- 
2.39.5


