Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0910FC36006
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 09:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqUuT-00060v-S5; Tue, 17 Sep 2024 05:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqUuR-0005zt-BH; Tue, 17 Sep 2024 05:54:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqUuP-0000kK-Hv; Tue, 17 Sep 2024 05:54:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9D0718FA06;
 Tue, 17 Sep 2024 12:53:47 +0300 (MSK)
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 85B2E13DDFD;
 Tue, 17 Sep 2024 12:54:02 +0300 (MSK)
Message-ID: <9732ed11-ed5f-4b2a-99bb-7de629148d95@tls.msk.ru>
Date: Tue, 17 Sep 2024 12:54:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display: Fix mirrored output in dm163
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-trivial@nongnu.org
References: <20240915125725.33099-1-ines.varhol@telecom-paris.fr>
 <10b98c97-ff2a-430f-ab76-66cc5948b0f8@tls.msk.ru>
 <CAFEAcA_xsqUbCcgstwJWmF2uUWJGskZ04r6dNkiNpQPYbrMg2w@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAFEAcA_xsqUbCcgstwJWmF2uUWJGskZ04r6dNkiNpQPYbrMg2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17.09.2024 12:39, Peter Maydell wrote:

>> This is an interesting device, I wonder if it is used by anyone?
> 
> The device is used by the Arm b-l475e-iot01a board.

I mean if it is actually used in practice, - there's just 1 commit
for this file - it's addition in Apr this year, and that's all.
If the image is inverted, I wonder how it worked and no one
noticed :)

There's no problem with that, anyway.

Thanks,

/mjt

