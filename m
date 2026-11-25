Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED1F606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=bd2tBtE1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIiD-0004js-Sm; Wed, 25 Nov 2026 14:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWIi4-0004fk-5S; Wed, 25 Nov 2026 14:31:17 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWIi1-00012d-3F; Wed, 25 Nov 2026 14:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795635058; bh=/+1It/2tTBAq0uwzXlWoTi1pSxt9x0wsZNJIWyXnizk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bd2tBtE1yk6nJ/yFWnR4m9lPmfjtVj4jp953ws4HhyPyZyxtoRn2ynn4ukR0D5oOJ
 eQApSZRZrz6ocAT60WAb+0olJRPA0beTVPaRpsQnOzRRgm+Fqk710aW32AdIPmqESW
 cL8b+AmA+JeQ4wJaQwlxwFjgSaccSG/o6gTiTDavPRPvXbmxVNigsl3HoLzwM3ED4+
 X5D8xgZoDE5OQ5CSOpXi+EWw4JVEehnKm9Sp3YmbZfpx0qjnh1G4EIVHd3Npe0gGcU
 HUuoP2MSjlk5I6D5vPLrZwHbbJLlQGRywNm6FEYaCMTPMvbDVIdARK3niS8inlpdr9
 Seygszsg8LDVQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 953A11E9D5B;
 Wed, 25 Nov 2026 22:30:58 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8261C468B1C;
 Wed, 25 Nov 2026 22:30:58 +0300 (MSK)
Message-ID: <c1440bb0-482f-4c51-9f9d-5c6a25733b05@tls.msk.ru>
Date: Wed, 25 Nov 2026 22:30:58 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 9/9] hw/sd/sdhci: Report Auto CMD12 response
 timeout in error status
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-stable@nongnu.org
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
 <20261123225349.54981-10-philmd@oss.qualcomm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261123225349.54981-10-philmd@oss.qualcomm.com>
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 01:53, Philippe Mathieu-Daudé wrote:
> Auto CMD12 copied an uninitialised stack buffer into the upper
> Response register when the card did not respond.
> 
> Zero the buffer. On timeout, set the Auto CMD12 Timeout Error status
> bit and, if enabled, the Auto CMD12 Error interrupt.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d7dfca0807a0 ("hw/sdhci: introduce standard SD host controller")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
For 10.0.x stable series, I'm also picking up:

   3025ea65bd5 hw/sd/sdcard: Factor sd_response_size() out
   b82e7a2a1da hw/sd/sdbus: Provide buffer size to sdbus_do_command()

Sure I can easily fix this "Auto CMD12" change for 10.0.x, but
it feels the above two changes are safe to pick and makes the
code closer to current.

FWIW.

Thanks,

/mjt

