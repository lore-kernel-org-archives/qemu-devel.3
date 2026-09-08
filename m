Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B86C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 00:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3jY1-0003oJ-Uh; Mon, 07 Sep 2026 20:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1x3jXz-0003ni-Un; Mon, 07 Sep 2026 20:18:47 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1x3jXy-0000rO-CT; Mon, 07 Sep 2026 20:18:47 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 84010601DB;
 Tue,  8 Sep 2026 00:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6B61F00A3A;
 Tue,  8 Sep 2026 00:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788826723;
 bh=CSdFSMYTXg/JWzH126EAE4K4hO75Qr+4To5HeGqZT3M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=A51OmvZ9MTKBb5gzftR/7cwApjMXNxzvzqnWo/JvVbohmoUCpnpbIG0doJuTCWgxY
 Bx5OXMo8mjOyOkfaYcAK3/OwwISikAiMtBHqKLKMuQHimaUYLqdk7xQX7OZr9vApf9
 UpVbiDDUI9wv27+Bawgw/63AJWP7rRY1PwQ3+M4omTQgB5uXmt+eI4I+IlrCOoXZTI
 9vUBZ1iWVQN0iDWPnmU8A70UfgDlVG8KZgpB3AfASpkaZjNoMPTEBMmsmzOdUu39R5
 JvzEuf6NKkv6ONwOwBDU8oyDoSfdaCDHetJC/30/WYbdXqeyZBVY9X926Y3kLwq4ep
 lol9JRrNG+f7w==
Message-ID: <ca718051-98b7-4154-a9c9-b2cc0633c700@kernel.org>
Date: Tue, 8 Sep 2026 09:18:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] file-posix: reject a zone append to a full or
 conventional zone
To: Niklas Cassel <cassel@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260904161801.1568841-1-cassel@kernel.org>
 <20260904161801.1568841-13-cassel@kernel.org>
 <08401f4f-1bb6-4445-b157-9135458d32ea@kernel.org> <ap6WTkOuuXVqNEEw@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ap6WTkOuuXVqNEEw@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=dlemoal@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/7/26 19:47, Niklas Cassel wrote:
>>> diff --git a/block/io.c b/block/io.c
>>> index b59c7fdf3e..452254bc63 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -3378,6 +3378,15 @@ uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset)
>>>      return offset >> ctz64(bs->bl.zone_size);
>>>  }
>>>  
>>> +bool bdrv_zone_is_full(BlockDriverState *bs, uint32_t index)
>>> +{
>>> +    uint64_t zone_end = MIN((uint64_t)(index + 1) * bs->bl.zone_size,
>>
>> I think this should look at zone capacity, not size. For cases where we have
>> zone cap < zone size, zone full condition is reached when the write pointer is
>> at the zone capacity.
> 
> There is no concept of zone capacity in QEMU upstream yet.
> 
> It is added in Sam Li's QCOW2 zoned patch series.
> 
> But yes, I already have a patch that modifies bdrv_zone_is_full() to use
> zone capacity rather than zone size, once it is introduced.

OK. Thank you for the clarification.

-- 
Damien Le Moal
Western Digital Research

