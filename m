Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A41606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=net-art.cz header.i=@net-art.cz header.a=rsa-sha256 header.s=netart header.b=1v4BZq7d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIqsU-00061u-9a; Mon, 19 Oct 2026 13:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samm@net-art.cz>)
 id 1xIqsI-0005wl-W9; Mon, 19 Oct 2026 13:10:15 -0400
Received: from reindeer.net-art.cz ([2001:1468:9000:1:1::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samm@net-art.cz>)
 id 1xIqsG-00071B-Ll; Mon, 19 Oct 2026 13:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=net-art.cz;
 s=netart; t=1792429803;
 bh=58na42SJ/fJJYWKI0VXxiuh1wlPrmnEB6TsM8svrCcA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=1v4BZq7d4NLzIaIAeSsRiCw5lgNgG1cnGUZwWezOiFsOPIHKv94+/my1TKNVqG8f4
 FOvuXjpXSjX1KoPhJww7YvKmsb0umS2tli1v+N3TiMBlkqA+LOas+SdcO8ow2EmKEy
 7bQ+TQT0GrhcSSYlsQqQRszx+r/fvENDgf5lAsDJh6trjX7Cbx4dZ3KugWPPWYB2W1
 EvTsqAG4xl8+7BrY4NBcdGdL/RPTCpNeE1TtUL5vNc/htDlVsLl3Ka0w7Yos9Xy2Wk
 J3byG2kB6Tu6jBAGgwJ+czWMeIMPWBW10ItyEvwZOnzwDOfuZyHZjEcHhwgHEkRKUf
 41XRd5xxxV1cQ==
Received: by reindeer.net-art.cz (Postfix, from userid 65534)
 id 490DA3F0B0; Mon, 19 Oct 2026 17:10:03 +0000 (UTC)
Received: from owl.net-art.cz (owl.net-art.cz [IPv6:2a03:6920:0:10::101])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "owl.net-art.cz", Issuer "YR2" (not verified))
 by reindeer.net-art.cz (Postfix) with ESMTPS id BCED73F04F;
 Mon, 19 Oct 2026 17:10:02 +0000 (UTC)
Received: from [185.71.233.107] (account samm@net-art.cz HELO
 [192.168.101.162]) by owl.net-art.cz (CommuniGate Pro SMTP 6.1.20)
 with ESMTPSA id 3730709; Mon, 19 Oct 2026 19:10:02 +0200
Message-ID: <8b44d41b-4f0b-4346-837a-243a77734463@net-art.cz>
Date: Mon, 19 Oct 2026 19:09:59 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga: set FreeBSD virtio-serial channel to raw mode
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-stable@nongnu.org
References: <20261017201905.12211-1-samm@net-art.cz> <atUGjXcdSBqQWAIx@tulp>
Content-Language: en-US
From: Alex Samorukov <samm@net-art.cz>
In-Reply-To: <atUGjXcdSBqQWAIx@tulp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:1468:9000:1:1::15;
 envelope-from=samm@net-art.cz; helo=reindeer.net-art.cz
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 18.10.2026 19:49, Roman Bogorodskiy wrote:
>>
> Interestingly, the issue does not apply to libvirt (bhyve and qemu
> drivers) talking to the guest agent, likely because libvirt terminates
> guest agent commands with '\n'.
>
> Either way, I have tested this change on:
>
>   - FreeBSD 16-CURRENT amd64 guest under libvirt/qemu
>   - FreeBSD 14.4 amd64 guest under libvirt/bhyve
>   - FreeBSD 15.0 aarch64 guest under libvirt/bhyve
>
> and did not notice any regressions.
>
> Tested-by: Roman Bogorodskiy <bogorodskiy@gmail.com>

Thank you for testing, i was also curious how it was tested/working 
before, and now i know :) I found this when was troubleshooting why time 
in UTM/FreeBSD is always wrong.

Hopefully it will be committed soon.


