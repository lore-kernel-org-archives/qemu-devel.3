Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F36FF53D87
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Cxt-0000BC-G7; Mon, 16 Mar 2026 14:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2Cxq-0000B2-N1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:46:54 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2Cxp-0006BA-4w
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:46:54 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so59641595ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773686811; x=1774291611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZORAx5okj97F1LsSgHyM9lahihlA6VdW3AFu49zcYg=;
 b=Ah16Fiq00+zEL3vE8XKUNqIqT26zeWk6gSvVbZb8aLg/pPoRqHjJgHGHxSP9GFdnHk
 b1ZSHsIyMUWCyQd3s9jGoKMen4d6waQ00TrBhSTxK0QeF2hWL0mU9MowcUp+pJ7hAzuT
 q49OwfDtGjzEfOiQaWsydIhOovKEpggj+BzStAfRzri+decANAdic/qfujqw8SvtoPx3
 qENyK1pjZOKT9d68izgWl+eZnxwpcfKle+MCxSdyM1gJYFn0dI/DbZv8SsMKHgRAUsrN
 VrQdgzLtOVVdyNhrooiReXZpBV7p2il5LJFT/NN0hZjZ36uVzxt8lUHuJIZ4ueoQF9Qh
 rL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773686811; x=1774291611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jZORAx5okj97F1LsSgHyM9lahihlA6VdW3AFu49zcYg=;
 b=D0ES1ck7g3Gwr7XRccO2IezXmCqYltMGZYcsuvBkW8WH+h94LDWtEfzGqvAUHJnC8Z
 UZ8K9KB9xlzt0IcLhINRP0rFgU/b0j7AUkU2B16oRSEtOBcdr2gh7RkNSc9VXjKzId2H
 eLsdiYyjGXExiPk7s6B11EaLc9aNjhw/wv9EtPN/pxwCpkyKSFPy3hyBC55KKNKLW+Km
 CiJ7rt7GbixEJMClPNLF3/SyO47XGCyRgn2GHGjcnXJdIyZGjysTThJLdPa+OKS3AeQj
 /OvguC9mLTlGtv1GYf5zJVW5v5WAczc3FrHFiGUXkzvRP0mB1KRN9s44brL2odXvcCgP
 pBEA==
X-Gm-Message-State: AOJu0YzC3K4kO6EJuKTA4PKooaESMmduFh2gZrmwCfhfX1ZHkEodSISN
 O/YIyVW8XPy4w+KDClL8nY75o6o//98S2+NnIuKmUvVOx6QS/NgmtWQzSLZ+kqXc
X-Gm-Gg: ATEYQzzpii5Zuy+I6iGbXmiz+j7nz9fFk3RDaexZ3u3J5aVQKFv4TMAjWRQvxt/oBsN
 eKUApoldIu3bhavLorqesCWwg9ZhEdE91heg8XBh0Gj6QdjHIbmiJs/hM7ymc+eESk9hEnBoml7
 iJwS/iHBeHkbhqXeEBi5cJXLKoj9HrsGJpeuYggzvKiXqaGZ6C2qmrPRbkScYUZA1Wqel60lAWK
 dzYXnz5UE8R59oaR6jjFmX6e0ehnCYaZV+cafV19xrb/Dozciv2+V2TAYGegE87Qhmv+RdsRBHV
 Ao7f3tkkLTUnFSCWKMpQ0e+KmfEpbq09iEKRabso7tGiYK2Uh9BBTyPCKPkZUnY57cNgvs1856w
 W4x4XklYHQOAaYdu8nzzodgcxfpEFaVZMkt/+KNEtOT0cnERuxafqebrh+Qv8scLFsORPklTjwh
 Q9KkczV3Tyt9E20U/U1Ojq0mmas5mgsu9zwXt+5MS2FD1XtT5S4Wle/TDIC+dx8QSOZ33H7gmty
 exwxklHfg==
X-Received: by 2002:a17:903:32cf:b0:2ae:4948:f866 with SMTP id
 d9443c01a7336-2aeca9d13eemr155409805ad.22.1773686810619; 
 Mon, 16 Mar 2026 11:46:50 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b04f40f515sm77284145ad.74.2026.03.16.11.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:46:50 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [PATCH v3 v3 0/4] Fix error handling for callers of
 load_image_targphys, get_image_size, event_notifier_init, msix_init
Date: Tue, 17 Mar 2026 03:46:36 +0900
Message-ID: <20260316184644.68116-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311183432.214960-1-viking4@gmail.com>
References: <20260311183432.214960-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Changes in v3:
- Patch 1: For next-cube, use a local Error* instead of &error_fatal
so that load failures are reported only when !qtest_enabled(),
matching the existing guard. Distinguishes "file not found" (error
set) from "file too short" (no error, size < 8) in next-cube.
(pointed out by Peter Maydell)
- Patch 2: Drop leon3.c change: warning is meaningless for baremetal
programs where no BIOS is expected, and error handling already
exists downstream. (pointed out by Clément Chigot)
- Patch 3: No code changes. Add Reviewed-by tags.
- Patch 4: Replace error_propagate() with conditional errp passing:
(s->msix == ON_OFF_AUTO_ON ? errp : NULL), avoiding the need for
a local error variable. (pointed out by Akihiko Odaki)

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413

Trieu Huynh (4):
  hw/core/loader: fix error handling for load_image_targphys callers
  hw/core/loader: fix error handling for get_image_size callers
  util/event_notifier: fix error handling for event_notifier_init
    callers
  hw/pci/msix: fix error handling for msix_init callers

 hw/alpha/dp264.c       |  2 +-
 hw/hppa/machine.c      |  2 +-
 hw/hyperv/hyperv.c     |  4 ++--
 hw/hyperv/vmbus.c      |  4 ++--
 hw/ipmi/ipmi_bmc_sim.c |  2 ++
 hw/m68k/next-cube.c    | 11 +++++++++--
 hw/m68k/q800.c         |  2 +-
 hw/m68k/virt.c         |  2 +-
 hw/microblaze/boot.c   |  3 ++-
 hw/net/igbvf.c         |  2 +-
 hw/net/rocker/rocker.c |  2 +-
 hw/pci/msix.c          |  2 +-
 hw/remote/proxy.c      | 15 +++++++++++++--
 hw/scsi/megasas.c      | 16 +++++++++++-----
 hw/usb/hcd-xhci-pci.c  | 16 +++++++++++-----
 hw/vfio/ap.c           |  2 +-
 hw/vfio/ccw.c          |  2 +-
 hw/vfio/pci-quirks.c   |  2 +-
 hw/vfio/pci.c          |  2 +-
 hw/virtio/vhost-vdpa.c |  4 ++--
 20 files changed, 65 insertions(+), 32 deletions(-)

-- 
2.43.0


