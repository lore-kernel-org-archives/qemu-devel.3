Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2D606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=BM6juF/P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUFK-0004nH-Ct; Thu, 29 Oct 2026 13:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xMUEw-0004FH-4A
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:48:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xMUEu-00049U-2S
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=SeH+F466AKLi/xi0X62c9OOXZIW/RHok9Q2oAn20ymI=; b=BM6juF/PtWKbze/FFBLcPzsKOj
 7A/qsWokTyxl5Iyk5m/lDRw0BLGVzOhREFkE8rw1WUQfoaO4DJqw265oMpo4+/ZEaAlyvipN639c/
 5QsyvQERr9/5pgUJh8D7N2GPu0gWhOiEv0NSOvUemyDETCVl9rkgsXM2pZwR+AmVqjJBi2aw+PvPQ
 LS+i6r4R+YApv5lPl0fA25/Tmf3LRJaysgewcUawTAVqZFLBTxzY039ErUVMjyn2ZmLUkCynEr5rk
 NMvehM2bGO3IkRvKoTKpMxbv5YapiDHflY1D3/t8Edpxs+whACGwFm5cIsVyZCUQfj2Ej72Sm9V7U
 qC3AUhTb0g5idFfqOfkZw2I6FOGVLaD7TB8B59busZoqxV6UxQp7PMXHfwVaahejMpkRCCBQrjkdl
 cjXLK/5xZ5+iA7QLdWAK1TW05gSUgaKcy2SsvwDH/43aQdmnR92SBd8oeifKtoomI0XtGVAw2UDVj
 LZADBTkm1oJb/DO/9pjuJ49vVVPr5cfaksjr9jHFXrF6dboR9OG/BJ1sbH2G8/Sh15NNAnyzExK2P
 /LU4Eho+MprBQbNENba4vZwbOyJrSykZz/f9iH4SW518LOb9SsDY39/PW4MRJC1UbCxWyNJH2pjEy
 xUOARDxs65PPQAg7nb2/zgrNW5t41BL5FukDaE2CE=;
Received: from [217.155.175.48] (helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xMUE8-004aaC-Ac; Thu, 29 Oct 2026 17:47:48 +0000
Message-ID: <52b69ff0-4741-4a30-8eee-b1e9db415f66@ilande.co.uk>
Date: Thu, 29 Oct 2026 17:48:29 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
 <20261028163245.1031673-3-richard.henderson@linaro.org>
 <e366030c-f780-4e96-ba2d-558359013969@ilande.co.uk>
 <be52ccd2-f368-41a7-83f8-dfe5c4409c4f@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <be52ccd2-f368-41a7-83f8-dfe5c4409c4f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.155.175.48
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 02/16] tcg: Add tcg_gen_lea_{i32,i64,tl}
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 15:51, Richard Henderson wrote:

> On 10/28/26 16:12, Mark Cave-Ayland wrote:
>> Does this also need a corresponding documentation update in docs/devel/ tcg-ops.rst?
> That's in patch 1.
>  
> r~

Sigh. So it is. Apologies for the noise.


ATB,

Mark.


