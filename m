Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E304606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=cyW5HOQ6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRJHh-0001JK-5J; Wed, 11 Nov 2026 20:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRJHc-0001IX-JR; Wed, 11 Nov 2026 20:07:21 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRJHa-00015K-18; Wed, 11 Nov 2026 20:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794445632; bh=L6iwk14/s0Q/lYo1afbZesjxnpahO7buYGv6wl1kQ1U=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=cyW5HOQ6Ac0aKORAjZP8Ulj7dizYQmZb2izmHLU8ty1EgaVQ1UVK2EjtscmvxlNaV
 3rpwuGwSVZ853KijAbtsfsFu/JzvcHWb+XOGHRh8gJAhNYz+IXQS25VoQa5y06CzXZ
 OGqDIwfjoBPG1UUk39+MEkR/ahEOsesQv/QTIs8ePXzK2foiKDHq+RcnaDVvPhVQ9A
 s5zlQJbX2tMevY00Vz8q87VWNL1HaSFDHYaizPKYAHFZwXwACnzFsUQdPUUt50uf70
 UMrfFubwACWqtBYfEweviP7vEK2yA2WfyHr531wplbCyBtqtdBLgOJEdIG2d98SB+r
 YWo/KZA4u335w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E42E61E58ED;
 Thu, 12 Nov 2026 04:07:12 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BFFFA4594F9;
 Thu, 12 Nov 2026 04:07:12 +0300 (MSK)
Message-ID: <d03d2ee5-5b19-459a-82db-244603763894@tls.msk.ru>
Date: Thu, 12 Nov 2026 04:07:12 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/slirp: Fix incorrect permissions on samba >= 2.0.5
To: =?UTF-8?Q?Niklas_Hamb=C3=BCchen?= <mail@nh2.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <c2b98872-4649-c291-bfb2-0fd5b3d40ac4@nh2.me>
 <CAFEAcA-TxOys5d=SAqwqU749j3-UoBf+WsWpMYZW_35w1r2ypQ@mail.gmail.com>
 <55c9d253-8f4c-cd06-77b4-fbbb26cda619@nh2.me>
 <c1c454bb-bf22-c985-5aba-0c7ffb3cb759@nh2.me>
 <4ddf5981-4748-4519-b367-98d2a528b99b@nh2.me>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <4ddf5981-4748-4519-b367-98d2a528b99b@nh2.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 05:55, Niklas Hambüchen wrote:
> Hello,
> 
> I would like to follow up on my 5-years old 2-line patch that so far hasn't seen much review and fixes the QEMU + Samba integration.
This is about

https://lore.kernel.org/qemu-devel/c2b98872-4649-c291-bfb2-0fd5b3d40ac4@nh2.me/

So, why it fails in the first place, and why it needs especially the group
of the user in global section?

What exactly it can't access without group, and why?

The extra comment in the generated smb.conf seems unnecessary.  But this is
cosmetics, for the start, It'd be nice to understand the problem.

[Dropping qemu-stable@ from the recipients list]

Thanks,

/mjt

