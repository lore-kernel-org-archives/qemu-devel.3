Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A680CC6B16
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGe3E-0000ql-HC; Tue, 13 Oct 2026 11:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xGe3D-0000pz-4l
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:04:23 -0400
Received: from out-251.mta0.migadu.com ([2001:41d0:1004:224b::fb]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xGe3A-0007se-Ui
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:04:22 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=6wjlRuu4oZukn7XAclCKfUWgcTNLkdUdRP1/f96/PVc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791903856; v=1; x=1792508656;
 b=gpPpG6nHicVuh0+Jxyplfi3Ke9iZnN8KmghU87Jh4sZrKyBHQkDK5l4TR2Z8SAhi3ZfCnqXy
 yKZsDwbl6BLoDHkLomFgqMhRdAZMre7kBVdJnfuh5PhDKLWAvdeKxoKzFHIIwPK3GJ6WLuFfgBq
 dDawbUlh6kMKx7PXR6qU1EL8=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 43077e197ef95ea5;
 Tue, 13 Oct 2026 15:04:16 +0000
X-Mizu-Trace-ID: 43077e197ef95ea5
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, tcalifano@redhat.com, junjie.cao@intel.com,
 junjie.cao@linux.dev, marcandre.lureau@redhat.com,
 abizerlokhandwalastd10@gmail.com, thuth@redhat.com, leonardi@redhat.com
Subject: Re: [PATCH] hw/usb/dev-mtp: Fix assert crash on undersized BULK IN
Date: Tue, 13 Oct 2026 15:04:05 +0000
Message-ID: <20261013150405.142564-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012140839.93559-1-tcalifano@redhat.com>
References: <20261012140839.93559-1-tcalifano@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::fb;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

From: Junjie Cao <junjie.cao@intel.com>

The check is correctly placed before either copy, and the early return leaves
s->result queued so a later BULK IN with sufficient space can deliver the
response.

Reviewed-by: Junjie Cao <junjie.cao@intel.com>

