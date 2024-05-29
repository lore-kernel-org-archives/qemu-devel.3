Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FD8C27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJy0-00067f-ID; Wed, 29 May 2024 10:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCJxy-00067P-6X
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:07:46 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCJxw-0005hL-8q
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:07:45 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5241b49c0daso2496253e87.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716991662; x=1717596462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jc75QmhZgUScJV2QjYGkzz3TXBT+T/zn8wfny+YuTZc=;
 b=ACxOgqFO1KSz7IDbAA6z7Prakxa/ecY35QrxYv/OBHhTvC+Oqee9gFsmLiTk5Aw3n+
 Lg38E9yDgHQIO+fmp92pIbHzedkPHk3Ws4Ghu8htpRgO12/VumvuHXIU2OATWZSdbVnf
 Hj9Nz/Y2BiRIE6dpF+L0qhdzviV8q606baf+H+4w++1cU7R7D2aOcxxJ9VI6ptdd+laP
 WFcdxtl1IpH3BRgNCLYUU2e6xpe2HCR/sl2c5JLnmeJQr62IobEl8S/heG06end4UzxO
 fijFF43c9kcMEPyFkVgvxj+/WQRRJoq6MAdNfOJNcWRxL/XHHxNQIqSsvYB/UK1iDGAN
 bzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716991662; x=1717596462;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jc75QmhZgUScJV2QjYGkzz3TXBT+T/zn8wfny+YuTZc=;
 b=McQA52D4oF+w5UCkOsizqH16KowEKOLeIxQcNHJS++hfXx4CxwpN8HCQN6p9P98Yy/
 AVcY6jMYQO3zOs0Ho9OI64MEBQ64V3nHojS0TJ5nYbEpN0H/K6IdRDBfVNAkhJFJg2LN
 CSqGrrXjoavNbsAouAhl11jD6R/yyI7PN3LL6UkcbDdWKOv2RLq3yMy/ymbXQaUr1ehl
 111q452PixPepPB8DjOx6R0BvZL0oSe7RXDpiPINw1vs/EXQmznzAlGxw3+kwIVX01bz
 eYDdi07j4PqsSMctZsRgdmC2bTjL6QWVga2Ncy3+EUCb7kByM4Nk4N/hUkOJU0SnVnXP
 FMNg==
X-Gm-Message-State: AOJu0Yxg/OAK8XHis/9xnAds9ltAsfrSOcXLvKG0WULev/wtRetDnCL6
 3TtbQQ3TjCmBq6KjsuKbhlJXQKV0fbROU7prToihFJsrwk0hbrUTm2FhZxtg
X-Google-Smtp-Source: AGHT+IGl82xz1qcTJOLS66Vy6p5ukr/QmqkpvZGJV6Kdi3pM/i99RB2Kc3hRicYzIb1mYrcFO0XNwA==
X-Received: by 2002:a05:6512:3085:b0:529:b565:77a5 with SMTP id
 2adb3069b0e04-529b5657883mr5578782e87.49.1716991661390; 
 Wed, 29 May 2024 07:07:41 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5296e885e5asm1275806e87.40.2024.05.29.07.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:07:40 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v8 0/8] xen: Support grant mappings
Date: Wed, 29 May 2024 16:07:31 +0200
Message-Id: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v7 -> v8:
* Remove xen_mr_is_* stubs.

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
 include/sysemu/xen.h            |   2 +
 system/physmem.c                |  12 +-
 7 files changed, 211 insertions(+), 65 deletions(-)


base-commit: 79d7475f39f1b0f05fcb159f5cdcbf162340dc7e
-- 
2.40.1


