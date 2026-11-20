Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4FC606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=boBOM9wB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULeV-0006mV-FY; Fri, 20 Nov 2026 05:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xULeM-0006mA-2z; Fri, 20 Nov 2026 05:15:23 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xULeE-0002HL-E8; Fri, 20 Nov 2026 05:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795169703; bh=DRH1brrSDCG+vr0/ewnAaNZmuQnIWmyfpZfk7fAJ19s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=boBOM9wB2fkuyNjqirYlVp2a6X/5HgGGSmzAwjpWzBaoI2oULIodw7YVAmA3liFln
 Pzc7BPzSDVJ+y9z50WDrNSLVFqp0EdI3ceUx5tn5iKA0xYliljtz5o6QEUtkwEuuEf
 a9NBZVHD5bGdhfx3ifmM7pt6rnCH/IeeERA4vsf1XRi/sRUeZHii43qF8ugxMf6pwr
 IuIcq6cNsl5D85thOZoQ2t11fbY+3XH0b/EB/EVeJxz8PveB3V7IhgB8cJOxJ5HMS6
 DAYMpL5nMsRGzFVCHds1JZ69BY4JO3a3pblk1ClORTiVWQT4GFcyW9xdWuYf7ZlP3J
 1yOSSTRcwNq7Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 41D9B1E842B;
 Fri, 20 Nov 2026 13:15:03 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 32FB0461FAB;
 Fri, 20 Nov 2026 13:15:03 +0300 (MSK)
Message-ID: <1daf2d1f-e2c1-4ba8-b98e-7b6d7f18e3ea@tls.msk.ru>
Date: Fri, 20 Nov 2026 13:15:03 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-crypto: clean up every data queue
To: zhaoguohan@kylinos.cn
Cc: arei.gonglei@huawei.com, mst@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <a16d5437-dd54-49dc-b53a-c8756afab274@tls.msk.ru>
 <20261120092817.119611-1-zhaoguohan@kylinos.cn>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261120092817.119611-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/20/26 12:28, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> On 11/20/26 8:25, Michael Tokarev wrote:
>> Is it a qemu-stable material?
> 
> Yes, I think so.

Yeah, this was my main question.  Good.

>> I found this change while trying to pick up a subsequent fix in this area --
>>
>>    902c849979c hw/virtio/virtio-crypto: Drain in-flight operations before unrealizing (CVE-2026-50625)
>>
>> which touches the same place, and wonder if I should pick this one too?
> 
> Yes please. 902c849979c was done on top of this patch (b35d34e3ccd
> in master), so its context won't match without it. Picking
> b35d34e3ccd first should let both apply cleanly.
The context is not a problem, applying the "Drain in-flight" change
without the "clean up every queue" works just fine.  Yes, it requires
a bit of tweaking but it's okay.

My question was about this "clean up every queue" change, - it looks like
it's a change own to pick into stable branches by its own.

It's just that I found this change while trying to apply subsequent change
in this area.

So yeah, I'm applying both since both makes sense in the stable branches
independently, and applying one on top of the other avoids back-porting.

Thank you!

/mjt

