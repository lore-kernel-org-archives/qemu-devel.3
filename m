Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD59D12D59
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 12:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQm8L-0000eA-TM; Wed, 03 Dec 2025 07:39:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vQm8F-0000dK-Ve; Wed, 03 Dec 2025 07:38:56 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vQm8E-0006vq-6o; Wed, 03 Dec 2025 07:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=m8zoo95n2aBfEFUrw3VI3r0Qc0YBatHFEv6FHIrKFYw=; b=fu7f7J12PHK8RNsXga7jDGBBmw
 Lvv/M1Nv2HGNr99ZvY7nPTlpkq+WdhYGIAFor0/RG+3JKnBObG8aOJwS4lSFdDeu6jmITD+F3W35Z
 56zQzPPMpLePuff/on3a+ng9hi7CPQ1qL6qQMpGI/RIK5JjMr4Kltta31ZTeR2ggWf/KGX0k1QYbM
 CTc/xlzwL2uSYDJdxOpACDJCVPLlTvKj154cCM19Z9pYEexyK4+Nw0deGQ70B4+hwYR8lwNLaOXI9
 CPb5YRQer7yUr4L0aqh0Sa0V027XIQhLJguKVFyyA362/nQ+Kg5qSa/gwfXQ4ywW58npvdrgZIBpo
 S5yy1Z47hUyLDD9hz14Nu9VU7Wmtr3N7Wu0vjCPpv+SHayYGgSYZQyTO65QLhrCq7WnbghBgEbNJO
 eJD/GNLl7v8GYIzct4sF1bgfAeNM8h9p+wO/UaeGAYBQ6LeftkUeAGL4iDAsk3csSeiA+sdwOaUcM
 KdOnGyWxyZ1lAb8SnBe09uwBGa15Y93cvrAIOfl0rwzVhljr10kyHQrNNpilGVwz3M8AQ1DVzF9gu
 bLyKcvx/6dpPhwDvmFxB6Ky1LQR1DXj5ct+HTwipjLthcftvR4zxQd2pTd/47eGp6tY4Uqk7dD7YJ
 yiXM9CKWNGtTeaH7S3Em8Ik12cyxDLn2szu10jfAs=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, berrange@redhat.com,
 Alano Song <AlanoSong@163.com>, AlanoSong@163.com,
 QEMU Trivial <qemu-trivial@nongnu.org>
Subject: Re: [PATCH 1/2] docs/devel: Correct typo
Date: Wed, 03 Dec 2025 13:38:48 +0100
Message-ID: <10763876.nUPlyArG6x@weasel>
In-Reply-To: <20251202131934.17324-1-AlanoSong@163.com>
References: <20251202131934.17324-1-AlanoSong@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tuesday, 2 December 2025 14:19:34 CET AlanoSong@163.com wrote:
> Correct typo in atomics.rst
> 
> Signed-off-by: Alano Song <AlanoSong@163.com>
> ---

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>




