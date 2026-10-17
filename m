Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E54CC6B2A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 06:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHxnt-0003QP-I7; Sat, 17 Oct 2026 02:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xHxns-0003QF-Ki
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 02:22:00 -0400
Received: from out-7.mta0.migadu.com ([2001:41d0:1004:224b::7]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xHxnr-0002vn-B4
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 02:22:00 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=zzke8iSUXVexgdpVBjiBzSm98jNaIYwvsCpi7zeX+oM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792218117; v=1; x=1792822917;
 b=EukhoslzmNjgWr+s5bScUJhpTmZSSbY5MjKAWbiXWj9pdF4vVzq+23m/xsjfsHqwcZ773TOq
 C5bSRN0LH/QkrR5Sqxr+1cBDD+AnRgZxqIIWKSkD1QyYmqDQnkIPlhoVttL8oD1fzPaSKQ/cwpQ
 6qjSAQePZ71g2uC3KZVFFieQ=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 9583a17527554ff0;
 Sat, 17 Oct 2026 06:21:57 +0000
X-Mizu-Trace-ID: 9583a17527554ff0
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: thuth@redhat.com
Cc: peter.maydell@linaro.org, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, philmd@oss.qualcomm.com, qemu-devel@nongnu.org,
 junjie.cao@intel.com
Subject: Re: [PATCH] tests/qtest: Cover OHCI endpoint type mismatches
Date: Sat, 17 Oct 2026 06:21:48 +0000
Message-ID: <20261017062148.610962-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c5fab461-2645-489e-ba72-5ee7b51a2507@redhat.com>
References: <20261016093011.521951-1-junjie.cao@linux.dev>
 <c5fab461-2645-489e-ba72-5ee7b51a2507@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::7;
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

Thanks for the review, Thomas. I've merged the duplicate checks and
moved expected[] as suggested.

v2 also removes the x86 restriction, with little-endian DMA accesses
and PCI host bridge IOMMU bypass. The tests pass on aarch64 and
ppc64 as well as x86.

Junjie

