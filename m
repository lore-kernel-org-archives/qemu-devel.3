Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76639E6BF04
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnFQ-0005Zz-0B; Fri, 30 Jan 2026 07:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <reinoud@gorilla.13thmonkey.org>)
 id 1vlnFM-0005Um-5F
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:05:08 -0500
Received: from 2a02-a46b-bd8f-1-bf6f-2443-36bc-c202.fixed6.kpn.net
 ([2a02:a46b:bd8f:1:bf6f:2443:36bc:c202] helo=gorilla.13thmonkey.org)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <reinoud@gorilla.13thmonkey.org>) id 1vlnFK-000876-Ih
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:05:07 -0500
Received: by gorilla.13thmonkey.org (Postfix, from userid 103)
 id 58BE814D1EB4; Fri, 30 Jan 2026 13:05:01 +0100 (CET)
Date: Fri, 30 Jan 2026 13:05:01 +0100
From: Reinoud Zandijk <reinoud@NetBSD.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: tests/functional: PPC test failures
Message-ID: <aXyebV4U_KG0A-MA@gorilla.13thmonkey.org>
References: <5100b77e-eb58-4651-bb43-13ccc6b531ce@linaro.org>
 <7fb919fe-10b3-4c0f-a71d-65367fbf5772@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fb919fe-10b3-4c0f-a71d-65367fbf5772@redhat.com>
Received-SPF: none client-ip=2a02:a46b:bd8f:1:bf6f:2443:36bc:c202;
 envelope-from=reinoud@gorilla.13thmonkey.org; helo=gorilla.13thmonkey.org
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.4,
 NO_DNS_FOR_FROM=0.001, RCVD_IN_PBL=3.335, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Thu, Jan 29, 2026 at 06:03:07PM +0100, Thomas Huth wrote:
> On 29/01/2026 17.39, Philippe Mathieu-Daudé wrote:
> > qemu_test.asset.AssetError:
> > https://archive.netbsd.org/pub/NetBSD-archive/
> > NetBSD-7.1.2/iso/NetBSD-7.1.2-prep.iso: Download retries exceeded
> 
> Looks like netbsd has got a "botcatcher" in place now, so you cannot
> download this from a script anymore :-( Unless someone finds a different
> location for dowloading this asset, we might need to disable the test.

I think it might be better to take a newer version?

You can also fetch

https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-7.1.2/iso/NetBSD-7.1.2-prep.iso?key=NetBSD

and rename the destination file to the one without the tail.

With regards,
Reinoud


