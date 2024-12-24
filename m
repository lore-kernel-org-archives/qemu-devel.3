Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9135DE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 04:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPwUq-0008Vt-V9; Mon, 23 Dec 2024 23:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konstantin@linuxfoundation.org>)
 id 1tPwUm-0008VD-Sw
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 23:26:13 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konstantin@linuxfoundation.org>)
 id 1tPwUi-0004FZ-Eh
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 23:26:11 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id ACCA6A4130A;
 Tue, 24 Dec 2024 04:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574D1C4CED0;
 Tue, 24 Dec 2024 04:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1735014362;
 bh=SFFUqGqHq+33K1zhBRKBjnoqdrzRGDcND4pHtlO8Et0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IFZ57E+6uyYBGu4cvcw358rv3KmmRb2neqJ5vAbczxXTezRJ3RL+4vac6qm1QG2zJ
 lZf+Ab1Dl7wa6fGDhzE+4sHPSLHsWvM42XrqKAg1BX09YBc/wx11a4KOzcND+wtaNm
 BrCUj0nlph9ntrvJTsWWe+T0jbe3mv29pjIw9DO8=
Date: Mon, 23 Dec 2024 23:25:58 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] Add a b4 configuration file
Message-ID: <20241223-swift-of-splendid-protection-b5dcac@lemur>
References: <20241222-b4-config-v1-1-b3667beb30a4@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241222-b4-config-v1-1-b3667beb30a4@flygoat.com>
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=konstantin@linuxfoundation.org; helo=nyc.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Sun, Dec 22, 2024 at 04:53:41PM +0000, Jiaxun Yang wrote:
> +[b4]
> +    send-series-to = qemu-devel@nongnu.org
> +    send-auto-to-cmd = echo

Hmm... does it not work without the above line? If so, can you please send a
bug report to tools@kernel.org?

Thanks!
-K

