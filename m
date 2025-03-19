Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88BFC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 15:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuve7-0001tA-LL; Wed, 19 Mar 2025 11:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1tuvdy-0001sS-TU
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:47:47 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1tuvds-0003jm-TI
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:47:46 -0400
Received: from kitsune.suse.cz (unknown [10.100.12.127])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0866121EDD
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 15:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742399253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=I8k1IUskQ8YaPn+YZlX30+dfb7fHYZtT8hPS7sr8ogw=;
 b=12hC9FkcO/k8zJgbYiGTCBiNVGIYMLy5PsT/kgjtTtUcjSwFX/HwzNq3Iio6IeNW07RYk3
 RkBALdSnMlASj2KK7QnriNlliXGwfw5N2f0Jo5YXh9e2Xnwr4xJ4W19HtWDnhrqOWWqgC3
 Q/I50A4x3ctEnEuXyMrd8L4AD6tBcXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742399253;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=I8k1IUskQ8YaPn+YZlX30+dfb7fHYZtT8hPS7sr8ogw=;
 b=uiUt2wKMhD6gaEHm0EakeEPRxDie38MxxGMaf/9igRiQtu+IL5JFCDjN3ljVgRfzDX3PjC
 G1xOYS/+sNdTJjDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742399253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=I8k1IUskQ8YaPn+YZlX30+dfb7fHYZtT8hPS7sr8ogw=;
 b=12hC9FkcO/k8zJgbYiGTCBiNVGIYMLy5PsT/kgjtTtUcjSwFX/HwzNq3Iio6IeNW07RYk3
 RkBALdSnMlASj2KK7QnriNlliXGwfw5N2f0Jo5YXh9e2Xnwr4xJ4W19HtWDnhrqOWWqgC3
 Q/I50A4x3ctEnEuXyMrd8L4AD6tBcXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742399253;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=I8k1IUskQ8YaPn+YZlX30+dfb7fHYZtT8hPS7sr8ogw=;
 b=uiUt2wKMhD6gaEHm0EakeEPRxDie38MxxGMaf/9igRiQtu+IL5JFCDjN3ljVgRfzDX3PjC
 G1xOYS/+sNdTJjDw==
Date: Wed, 19 Mar 2025 16:47:31 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: qemu-devel@nongnu.org
Subject: qemu-system-ppc64: ../system/memory.c:2666:
 memory_region_add_subregion_common: Assertion `!subregion->container'
 failed.
Message-ID: <Z9rnE7VoDfnGO8WR@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-4.25 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-0.996];
 NEURAL_HAM_SHORT(-0.15)[-0.761]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; SUBJECT_HAS_EXCLAIM(0.00)[];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_ZERO(0.00)[0];
 MIME_TRACE(0.00)[0:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=msuchanek@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hello,

reportedly since the inclusion of Linux patch
6aa989ab2bd0d37540c812b4270006ff794662e7 powerpc/pseries/iommu: memory
notifier incorrectly adds TCEs for pmemory

qemu fails to reboot VM. When running Linux with this patch inside VM
qemu crashes due to assertion failure:

KVM: Failed to create TCE64 table for liobn 0x80000001
qemu-system-ppc64: ../system/memory.c:2666:
memory_region_add_subregion_common: Assertion `!subregion->container'
failed.
Aborted (core dumped)

This only happens for VMs with a PCI device.

qemu-system-ppc64 --enable-kvm -m 4096 -smp 8 -hda SLE15.qcow -vga none
-nographic

reboots fine but

qemu-system-ppc64 --enable-kvm -m 4096 -smp 8 -hda SLE15.qcow -vga none
-nographic -device qemu-xhci

This has been reproduced with qemu 8.2 and 9.2

It seems failry easy to reproduce but I can provide specific kernel
configuration or kernel binaries if needed.

Thanks

Michal

