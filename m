Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E1ACA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 05:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDbWW-0004Dw-6E; Mon, 05 Oct 2026 01:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xDbWU-0004DZ-96
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 01:46:02 -0400
Received: from out-130.mta1.migadu.com ([2001:41d0:203:375::82]
 helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xDbWS-0004LA-2s
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 01:46:01 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=0bSI9iHzVfqIqONNnEGJ+D36BiLzHuwyXEeW+SaWjyk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791179155; v=1; x=1791783955;
 b=ndJMJAhfh+jfSAbeDKv6SMongujeEwyM7WPrIwFAl1Xit5mBqvehyO5cTRaf5eyllbdI44S1
 xosMzUZwKuGiPhsMYynUuzNg8t6Nv7acGG4gsea1pF06nwiSZk7k5OxvcABnmS28ka+6ELq7OYu
 QR6YxFUSWaUSlBZ9qacQXA9o=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 48b33e24cb5d2c36;
 Mon, 05 Oct 2026 05:45:55 +0000
X-Mizu-Trace-ID: 48b33e24cb5d2c36
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: marcandre.lureau@gmail.com
Cc: qemu-devel@nongnu.org, thuth@redhat.com, kraxel@redhat.com,
 philmd@oss.qualcomm.com, qemu-stable@nongnu.org, junjie.cao@linux.dev
Subject: Re: [PATCH 2/2] usb-host: free configuration descriptors on error
 paths
Date: Mon,  5 Oct 2026 00:45:48 -0500
Message-ID: <20261005054548.131526-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJ+F1C+nphu4S_ZJhr7oKV=s3q8SK=OBFpK3JVV1Ovx8UH8EZA@mail.gmail.com>
References: <CAJ+F1C+nphu4S_ZJhr7oKV=s3q8SK=OBFpK3JVV1Ovx8UH8EZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:203:375::82;
 envelope-from=junjie.cao@linux.dev; helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Thanks for the review. Will send v2 with the g_autoptr conversion.

