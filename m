Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC91C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52Ax-0003ep-7l; Fri, 11 Sep 2026 10:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x52AT-0003U1-Rk
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:23:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x52AR-000561-Ue
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:23:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso5558905e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789136629; x=1789741429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jzDFr11Fp0SL6C6eP0+GXQwEmJckykJ1FNyg+39+OQM=;
 b=VwaBsEqZPA0+ZfyElIHhOLJ7j7l6bMiNi7si/oqETw1jsa7mAszr0OZ12QB/ZL7cFU
 +rucBmkASab50K8B6XSQaP+SmVGtNlIWQFiF8MJyH6sSK2xKdX5XHMnDYtJF9ybaQ0je
 Xlg6g8Kb3CCJBOqKvib689QnOlTYHamVwawOFDyqSzDFSQ+jgcWUBsKdlQ9ps6WmX/yE
 kf2e56tus8xVc8EotOUIeIBi19mwEd2itS9+JKhu82SOqlD57quuSVjyV5R7WjSPwpuz
 m1qUS/poXplzCVVkge50CzXJ8aOV1eqTuKxwyQwJ0UfD4h/ojYVNSKspBMfJYgcz8/VW
 pHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789136629; x=1789741429;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jzDFr11Fp0SL6C6eP0+GXQwEmJckykJ1FNyg+39+OQM=;
 b=CusgcgU2YuteYlpy7TgQgpTj59jVFJoQMXVnz4mIpV1aW6aQiKye2mM5uhjDENE/yF
 AItkP0PQfGOZ4FRcjLqxNzxD4SNXdoQD5DYz8qEVADuu9ximSRVN7+iC3YEhMRcKwbY6
 ORcrDswvbOxjdP47uKKzvmuoyubPWk3sgWT+rdp4vYPJHhKRIIrd/DPMKtTz6XT73lvv
 YkjEA6evBABCJV2r3kxwo4ZAl4RTIhIv8sI4IblpOik9l2YW0jpK49C7tpTDkFnEj+Nv
 GxT3mIgS/c/bKQGOChyn5Lmy3FM4/AQdZiMohcGvFnrrOaA81+YPrM2LPEXht8L9u+es
 w8MA==
X-Gm-Message-State: AFuF++kzyfKeFBhx/Wq5yJj9jJThQsozLQCJqPxE7r1oU+9nISADlsSM
 fWqhyxzBQoVVJBmWlaM71ynFYEmxTBjrRqQ0NzmoqQCxVbcqBqoA2rbrtSCj2K/80LyeeWl0KyS
 u19CG
X-Gm-Gg: AYBFou0ZcFVJPIuSZ7f6wJef1gWGLt+V4CA2170PGTxaaSmNq7B/YzLpbT0Aa1o8Gv7
 IK9gfAuXBOFPJN7AanFK8hyljEZCop3KEo6avOqmQayhPT9UA1aoxuRvCaF4JodSWcNfPaNP1pK
 +j8wGWH/Aic7bba985kjtQgkRTIlM/l+YxZ7X40LCyMbJdbPxtH/aDEH9bomyKsMjmYJh+4u0Ls
 G9zwJdTqQuMZCWWH3lCe7lg8tMiQ8qgD9Q/4s2SDlary1cbn/DEmefXuCoriPRByJYYN7KSV0zK
 M+xCxXdHYxjWO1sh0im9ColTeT2X+SGRsBgrf+2RwK0kojmxYUK9BACKqnoOBzEneZ2HvXmc169
 aDQc6WLhZ1qLMH1Tsnh82NuAA3eVSfBzbjPBHWUNFaM/uNni8OKEUk78QW6Fcg7LFIzAJcxUcn7
 se2weNOKiD7/H3sdv19sY6Sp9KS3Xelg56vCkVn76/wlmtmRgaxCoEEZlGNctQnxGhOwY=
X-Received: by 2002:a05:600c:4114:b0:49e:5765:1426 with SMTP id
 5b1f17b1804b1-49e57651482mr72013445e9.3.1789136629514; 
 Fri, 11 Sep 2026 07:23:49 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a007:bd26:918e:c58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee5csm6398448f8f.20.2026.09.11.07.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 07:23:49 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PATCH 0/2] migration: defer a post_load which only rearranges memory
Date: Fri, 11 Sep 2026 16:23:43 +0200
Message-ID: <20260911142345.3999518-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=den@openvz.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Restoring a big Windows guest spends most of its destination-side time in
post_load hooks which do nothing but move memory regions around. Each one
ends a memory transaction, and a transaction commit re-renders every
flatview it touches at a cost which grows with the number of regions in
the machine. A hook which runs once per vCPU therefore pays that render
once per vCPU, and the machine gets slower to migrate the bigger it is.

The Hyper-V SynIC is the case that hurts: restoring the synthetic
interrupt controller maps a message page and an event page per vCPU, so a
64-vCPU guest forces 128 remaps, each with its own rebuild, while the rest
of the stream is still being read.

Patch 1 adds post_load_deferrable. A vmsd which sets it has its hook
queued during the load and run once the stream has been consumed, in the
order the hooks would have fired, with the whole drain sharing one memory
transaction. Patch 2 sets it on the SynIC subsection.

It is opt-in rather than automatic, and the three preconditions are
spelled out on the field: the hook must not fail, nothing later in the
load may depend on what it does, and it must not read guest memory or
resolve an address space. A hook which breaks the first is fatal rather
than silently reported, because by drain time the source may already have
been told the migration succeeded.

Deferring is not free in general, which is the other reason it is opt-in.
Deferring the APIC post_load, whose cost is a synchronous run_on_cpu per
vCPU rather than a memory remap, moves 3 ms out of the section walk and
pays about 9 ms of drain for it. Deferral helps a hook which repeats
topology work; it makes a hook which does cross-thread work worse.

Measurements
------------

Destination-side non-iterable load, ie. the sum of vmstate_downtime_load
over non-iterable sections, on a guest which has actually programmed its
Hyper-V state. Five interleaved rounds per point on an otherwise idle
host, twice; medians, with the spread across all ten rounds.

  upstream                          377 ms   (363-400)
  + pci mapping transactions        247 ms   (242-255)
  + this series                      96 ms   (86-97)

Two postings against one problem, so the whole ladder is shown. The first
step is a pci pair which batches a device's BAR and bridge window updates
into a single transaction, posted separately and now queued in Michael's
tree:

  https://lore.kernel.org/qemu-devel/20260903184542.2629976-1-den@openvz.org/

Those two are listed because they change what a rebuild costs, and so
change what this series is worth. Together the postings take the load
from 377 ms to 96 ms; this series is the 247 ms to 96 ms step.

Where it goes: the cpu sections fall from 154 ms to 1.3 ms. The deferred
hooks themselves cost 77 us at the drain, so the work is removed rather
than moved somewhere the per-section metric cannot see.

The saving scales with vCPU count, since that is how many times the remap
repeats, and with the number of memory regions in the machine, since that
is what a rebuild costs.

Guest under test
----------------

Windows Server 2022, installed unattended, idle at the console:

  -machine q35,accel=kvm
  -cpu host,hv-synic,hv-stimer,hv-stimer-direct,hv-vapic,hv-runtime,
       hv-time,hv-ipi,hv-crash,hv-reset,hv-frequencies,hv-vpindex,
       hv-spinlocks=0x1fff
  -smp 64,sockets=2,cores=32,threads=1
  -m 4G
  65 pcie-root-ports, 9 virtio devices behind them, qxl

Host: AMD EPYC 7443P, 24 cores / 48 threads.

hv-synic is the flag that matters. Without it the guest never programs
the SynIC pages and the effect under test does not exist.

Measured with a save/restore harness rather than a live migration: a
restore from a captured stream walks the same qemu_loadvm_state_main()
path a destination does, which removes libvirt, the network and the
second host from the measurement.

CC: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>

Denis V. Lunev (2):
  migration: let a vmstate defer its post_load to end of stream
  target/i386: defer the Hyper-V SynIC post_load

 include/migration/vmstate.h |  40 +++++++++++++
 migration/savevm.c          |  23 ++++++++
 migration/vmstate.c         |  67 +++++++++++++++++++++-
 target/i386/machine.c       |   1 +
 tests/unit/test-vmstate.c   | 111 ++++++++++++++++++++++++++++++++++++
 5 files changed, 240 insertions(+), 2 deletions(-)

-- 
2.53.0


