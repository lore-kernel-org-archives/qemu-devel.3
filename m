Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB91E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNsXo-0006yH-HL; Wed, 18 Dec 2024 06:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+6cdea2fcdec3a6535aff+7787+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tNsXM-0006t2-1f
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:48:24 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+6cdea2fcdec3a6535aff+7787+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tNsXC-0001mZ-He
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=jg1ApF1FBq7qUthBRhKyBV5ogiYGWDI5PYkmARZl4IU=; b=nUr//ODTSo1hlngj5VlWTNO7jw
 sMTChpaDv0WIb2blShekRxx37k01nCwAK1t9+684mDjKxkTWJK6x7s/DF26lr/vJptfumpMAPVacp
 kl4cpLoIZb7nL2Qm0kTS3KGcjqBCP9M0cyTXupU8HwZzot02rTbh8CCPy6SPCpjF9qEdvixWnZeI7
 cqv9hwl6vxtSoqhjDtaoc5EDI+9Fpatt7yJFc5m0h/uJKf5vnHgLYb/bPRkTauOa0Z9PHnMe3OXdt
 VXzZ6376SDkkA/IKcmk23AA2eh67ztATq+t93XdTE6bmNIfugus8perHHztfS3k0MSCNyGBsjAmTU
 JeiuKXxA==;
Received: from [89.27.170.32] (helo=[127.0.0.1])
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tNsX4-00000005GQV-1qSB; Wed, 18 Dec 2024 11:48:02 +0000
Date: Wed, 18 Dec 2024 12:48:01 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
CC: Paul Durrant <paul@xen.org>
Subject: Re: [PATCH] tests/functional: Convert the kvm_xen_guest avocado test
User-Agent: K-9 Mail for Android
In-Reply-To: <20241218113255.232356-1-thuth@redhat.com>
References: <20241218113255.232356-1-thuth@redhat.com>
Message-ID: <9B5DDDDB-769B-4654-BEF1-D3F853EA05E5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+6cdea2fcdec3a6535aff+7787+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 18 December 2024 12:32:49 CET, Thomas Huth <thuth@redhat=2Ecom> wrote:
>Use the serial console to execute the commands in the guest instead
>of using ssh since we don't have ssh support in the functional
>framework yet=2E
>
>Signed-off-by: Thomas Huth <thuth@redhat=2Ecom>

Hm, but serial is lossy and experience shows that it leads to flaky tests =
if the guest (or host) misses bytes=2E While SSH would just go slower=2E

