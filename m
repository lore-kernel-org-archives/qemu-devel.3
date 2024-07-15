Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E76BC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 13:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTLeU-0001XP-4D; Mon, 15 Jul 2024 09:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziyao@disroot.org>) id 1sTLeR-0001Wd-6Y
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:21:59 -0400
Received: from layka.disroot.org ([178.21.23.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziyao@disroot.org>) id 1sTLeO-0003sR-7t
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:21:58 -0400
Received: from localhost (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8303E4145F;
 Mon, 15 Jul 2024 15:21:52 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id anx3OCLEccJR; Mon, 15 Jul 2024 15:21:51 +0200 (CEST)
Date: Mon, 15 Jul 2024 21:21:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1721049711; bh=vGR01nL2OTl0N0bc+FRDWfJQUaZ/KoF928QoociNh1I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iSRxHLuAOYPWSh4PGI8kSH4ytH4f9uEW5D5jGag8UnFJTIAOBpkIW6z0WIOt5Mq8n
 txURZxQHtDj2Kai0lZWI5+ozGfngzmvNu3M3rhdsNIUaqupSns1Q2Q7esb6HU1epkK
 89CKmKtRKQBYpsp5pFys5tVA5LsO478OeLlr895j4E6jHYIXqSaplng9X8LOfb55LE
 bhjnvKTE/5futIGyL5ryhNhqjCubh9HbiA6tT0iiXjvVV771yTdQ6AXv7/lU0eg0ZV
 lZv3JevaGf9fzIFNH7DoLmHsB8gFpKDKAlULOsRj/tfDYjv7z7UioMh7s+tM57PWmb
 VfdBbOwTiuXrA==
From: Yao Zi <ziyao@disroot.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] meson.build: fix libgcrypt detection on system without
 libgcrypt-config
Message-ID: <ZpUiVe4wTHm7lmpP@ziyaolaptop.my.domain>
References: <20240706201226.46089-1-ziyao@disroot.org>
 <ZpE1ApH6sWuRdf-L@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZpE1ApH6sWuRdf-L@redhat.com>
Received-SPF: pass client-ip=178.21.23.139; envelope-from=ziyao@disroot.org;
 helo=layka.disroot.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, Jul 12, 2024 at 02:52:02PM +0100, Daniel P. Berrangé wrote:
> On Sat, Jul 06, 2024 at 08:12:26PM +0000, Yao Zi wrote:
> > libgcrypt starts providing correct pkg-config configuration and dropping
> > libgcrypt-config since 1.11.0. So use auto method for detection of
> > libgcrypt, in which meson will try both pkg-config and libgcrypt-config.
> 
> The pkg-config file seems to be provided since 1.9 in fact.
> 
> Where do you see that ligcrypt-config is dropped ?

Commit 2db5b5e9
("build: When no gpg-error-config, not install libgcrypt-config")[1] in
libgcrypt says that

> When system will migrate use of gpgrt-config and removal of
> gpg-error-config, libgcrypt-config will not be installed

1.11.0 is the first release containing this commit.

> It still
> exists in the gcrypt  git repo and in Fedora 1.11.0 packages.

It does not on Arch Linux. For Fedora, I have no idea.

[1]: https://github.com/gpg/libgcrypt/commit/2db5b5e995c21c5bd9cd193c2ed1109ba9b1a440
[2]: https://archlinux.org/packages/core/x86_64/libgcrypt/

Best regards,
Yao Zi

