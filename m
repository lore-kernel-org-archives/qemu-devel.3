Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ADEC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 10:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sASWv-0006Tc-MA; Fri, 24 May 2024 06:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sASWo-0006Ob-IO
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:52:02 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sASWl-0007dd-5Q
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:52:02 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e538a264f7so98871961fa.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 03:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716547916; x=1717152716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kFIVEJTgY5LlkMw7cZ3HEZddVYi18q8X6osQf1D0X6g=;
 b=MNHsBfob/tOdIvUrSRbkHOwv+i6nRLuFW8bGYDIcqxYgP/HD7nwqZPBR86hEzQzz/b
 pzStCMdUogxGUTRxviFiJCfuthQ1XDEYECnwhiL2q2c4C62KD0J4kxuxr/vTdrjLI1Qx
 2TVTCdLArmmhMg/oKTw8jPVOthdzm3wdEDAqMP+PVQw7nbah3f7WGmy4fd2cmO+I2RAN
 BNPmPzVtYXJZVGGyBgjvopVhktu89HNFmlPppVT1qKrresqxbpxpPhIUbZ0P/SV+J8NC
 /FvnjwluhuKP8u67uaOBhByS9NIF6WNSAgxBOyQ0nOSilEV8h3AZjoMCbQxgV4o8Qd8P
 Gncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716547916; x=1717152716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kFIVEJTgY5LlkMw7cZ3HEZddVYi18q8X6osQf1D0X6g=;
 b=op65AtU+k5UdrlcNy08p9Pr0PRmqMSomVThNA6TioKElplayurKijgJA9GHcxGISEO
 +/h0Mfn82TVoheiVJdoMT5qf8QJQcoOCQ1NlEwCpCN9x4slgiE0s3xqRMlBpzYPpV5JO
 7EOilTjYgfD0xkLhdeeQP37lcqtg7uEKrgK656c0kokATWiKWrTJPMVWc8q9bklUfk8+
 CaP/gMcTMpTswFXDJLzFsMDpNH1sxZgQtmeiD56QRqB4LIS+m5iI8ov2FvgXmCb1MD92
 Bou62ybmlWiVxwVlr9fvrtuT9HYFhCAl5Iij7JefnRyYKC7Mzaz8ZZfqCL/yA0obvQwV
 Ostg==
X-Gm-Message-State: AOJu0Yx4je/x72QQ1iep2dfsB4BUX9XilSFXbpKN7jbqhIdaTvRyf/jP
 dLgjte7LTqsDWdP+M/1cvIDYjLm0LnXd824NE+w14AogpvieY7U9cCENOvX6
X-Google-Smtp-Source: AGHT+IHLU+50DMFIXtkI+bDAhS+PAb4gGnsMzpXWbf7n+j77wzYqjOVb4zh/14RCnGz0UJIQpwiTvQ==
X-Received: by 2002:a2e:7e08:0:b0:2d8:a921:dfc1 with SMTP id
 38308e7fff4ca-2e95b0c2295mr10868451fa.20.1716547915566; 
 Fri, 24 May 2024 03:51:55 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e95bcf4bdfsm1481221fa.63.2024.05.24.03.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 03:51:55 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v7 0/8] xen: Support grant mappings
Date: Fri, 24 May 2024 12:51:44 +0200
Message-Id: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Hi,

Grant mappings are a mechanism in Xen for guests to grant each other
permissions to map and share pages. These grants can be temporary
so both map and unmaps must be respected. See here for more info:
https://github.com/xen-project/xen/blob/master/docs/misc/grant-tables.txt

Currently, the primary use-case for grants in QEMU, is with VirtIO backends.
Grant mappings will only work with models that use the address_space_map/unmap
interfaces, any other access will fail with appropriate error messages.

In response to feedback we got on v3, later version switch approach
from adding new MemoryRegion types and map/unmap hooks to instead reusing
the existing xen_map_cache() hooks (with extensions). Almost all of the
changes are now contained to the Xen modules.

This approach also refactors the mapcache to support multiple instances
(one for existing foreign mappings and another for grant mappings).

I've only enabled grants for the ARM PVH machine since that is what
I can currently test on.

Cheers,
Edgar

ChangeLog:

v6 -> v7:
* Use g_autofree in xen_remap_bucket().
* Flatten nested if-statements in xen_map_cache().
* Fix typo in error message in xen_map_cache().

v5 -> v6:
* Correct passing of ram_addr_offset in xen_replace_cache_entry_unlocked.

v4 -> v5:
* Compute grant_ref from address_index to xen_remap_bucket().
* Rename grant_is_write to is_write.
* Remove unnecessary + mc->bucket_size - 1 in
  xen_invalidate_map_cache_entry_unlocked().
* Remove use of global mapcache in refactor of
  xen_replace_cache_entry_unlocked().
* Add error checking for xengnttab_unmap().
* Add assert in xen_replace_cache_entry_unlocked() against grant mappings.
* Fix memory leak when freeing first entry in mapcache buckets.
* Assert that bucket_shift is >= XC_PAGE_SHIFT when creating mapcache.
* Add missing use of xen_mr_is_memory() in hw/xen/xen-hvm-common.c.
* Rebase with master.

v3 -> v4:
* Reuse existing xen_map_cache hooks.
* Reuse existing map-cache for both foreign and grant mappings.
* Only enable grants for the ARM PVH machine (removed i386).

v2 -> v3:
* Drop patch 1/7. This was done because device unplug is an x86-only case.
* Add missing qemu_mutex_unlock() before return.

v1 -> v2:
* Split patch 2/7 to keep phymem.c changes in a separate.
* In patch "xen: add map and unmap callbacks for grant" add check for total
  allowed grant < XEN_MAX_VIRTIO_GRANTS.
* Fix formatting issues and re-based with master latest.


Edgar E. Iglesias (8):
  xen: mapcache: Make MCACHE_BUCKET_SHIFT runtime configurable
  xen: mapcache: Unmap first entries in buckets
  xen: Add xen_mr_is_memory()
  softmmu: xen: Always pass offset + addr to xen_map_cache
  softmmu: Replace check for RAMBlock offset 0 with xen_mr_is_memory
  xen: mapcache: Pass the ram_addr offset to xen_map_cache()
  xen: mapcache: Add support for grant mappings
  hw/arm: xen: Enable use of grant mappings

 hw/arm/xen_arm.c                |   5 +
 hw/xen/xen-hvm-common.c         |  18 ++-
 hw/xen/xen-mapcache.c           | 234 ++++++++++++++++++++++++--------
 include/hw/xen/xen-hvm-common.h |   3 +
 include/sysemu/xen-mapcache.h   |   2 +
 include/sysemu/xen.h            |  15 ++
 system/physmem.c                |  12 +-
 7 files changed, 224 insertions(+), 65 deletions(-)


base-commit: 70581940cabcc51b329652becddfbc6a261b1b83
-- 
2.40.1


