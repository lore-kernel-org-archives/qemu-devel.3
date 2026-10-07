Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B8BCA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xER4N-0007s3-Lz; Wed, 07 Oct 2026 08:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xER48-0007rE-4e
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:48:15 -0400
Received: from 2.mo508.mail-out.ovh.net ([5.135.90.177])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xER42-0005om-9z
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:48:09 -0400
Received: from DAGFR11EX3.OVH.local (unknown [10.109.231.2])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4j0CZy2NV0z7t7P;
 Wed,  7 Oct 2026 12:47:54 +0000 (UTC)
Received: from [10.46.75.159] (109.190.254.5) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 7 Oct
 2026 14:47:53 +0200
Message-ID: <7857b84b-ef59-45cc-9ebc-c6446ad8ba97@ovhcloud.com>
Date: Wed, 7 Oct 2026 14:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nbd/client-connection: Fix client returning a closed
 channel
To: <eblake@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20260925155346.357703-1-guillaume.vincke@ovhcloud.com>
 <20260925155346.357703-2-guillaume.vincke@ovhcloud.com>
 <arbf-WK4eJCeNX35@redhat.com>
 <19b7e322-f98b-4059-ae5e-95b2bdfe0c0c@ovhcloud.com>
 <asVIFdF-xYwkJ3R8@redhat.com>
Content-Language: en-US
From: guillaume vincke <guillaume.vincke@ovhcloud.com>
In-Reply-To: <asVIFdF-xYwkJ3R8@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.190.254.5]
X-ClientProxiedBy: CAS2.OVH.local (172.16.1.2) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 4573968375487086887
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGyWgP/5lju96S58we1TEh1wXYXZo6yyb/XCpjq+RooVbytVP0cpHI+t+ISIUBPHFUa3/20ef3u9jRwpsqvbcski4GUTkiVkr+Wka5S4bDERSIar3PlWuOE/zpCM9PI2PeNuuwzjCkARlUGD3p1WDOkW6mRou4+4G25WC9b133Tp0+w+B4OUC/Hdce0V/BV1n7MjwOK3+z9SDeWFPSjp2YFnDMBa4dYFTzIJxvQPSXNRw3pezf2zpU0SIKKuuQLGDr1tGF4DVhhPo5H5xspX12gIbnSvA+OvmS/dduzw4vQel/QKvQgV55hD79dD4dNa/owT1BGRLPXAp9oG0U3CL9JsuW+G9JNxyhm56y1MtmdoGPMTRZWURP/JB4pJlgn+051sy4jAEILzqzm4mZ+z9tRffB1qmyjACO3m3fT9ydDTwseFni5cuHynzifyXDGZCzFOuLSm3gVpNbLEr3fIXNVsJK/CQUP6flDaZ3v9oOxm0bICXC7LEYud3DHoWtmJd3zx0ZSFMHaEqQuCgYWeQ4uE5xfGdcrieEPFbNpOvD8lunknw7FFfnf2/B4LwAF9ujCDKTebQ9U63HeL1NvQwdlIbOtkOsAfx6dNtBT1kApXNU7EuL+5SKdEXXebhD+9WmAY2enOkXVXuKQqZI8eVEje1ChA+L7vFvE9Qw66qbuWg
DKIM-Signature: a=rsa-sha256; bh=Ek9UwoiQxFredt5folchxkPy5zhvZM3iHEO5X4kohtc=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1791377274; v=1; 
 b=XgsX19fcGCW5D7T2k9QLEAzrh4JLQFXzP88/kXb3U8AYA5EDjo/hKhCYzlAgqUh9jwTvFjSX
 Y3GrhD4LOYu/YvLOM6ACZCN/0cL/py36N/McOl+Fdnl+E06krEWZhnm5ST9u0XRY9dop73lmO3s
 Dbsz/gWTq6/sD8l2cjJzcaKA=
Received-SPF: pass client-ip=5.135.90.177;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=2.mo508.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/6/26 21:13, Eric Blake wrote:
> On Mon, Sep 28, 2026 at 10:23:49AM +0200, guillaume vincke wrote:
>>>> +static bool nbd_channel_is_closed(QIOChannel *ioc)
>>>> +{
>>>> +    char data;
>>>> +    struct iovec iov = { .iov_base = &data, .iov_len = 1 };
>>>> +    ssize_t len = -1;
>>>> +
>>>> +    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    len = qio_channel_readv_full(
>>>> +        ioc, &iov, 1, NULL, NULL, QIO_CHANNEL_READ_FLAG_MSG_PEEK, NULL);
>>>> +
>>>> +    if (len == 0 || (len < 0 && len != QIO_CHANNEL_ERR_BLOCK)) {
>>>> +        return true;
>>>> +    }
>>>> +    return false;
>>>
>>> The last group could be shortened to:
>>>
>>>      return len == 0 || (len < 0 && len != QIO_CHANNEL_ERR_BLOCK);
>>
>> Thanks, I will make sure to include those changes in v2 once patch 2/2
>> is reviewed, to avoid a new submission for these alone.
> 
> The changes turned out small enough, and I want to get a bundle of
> pending patches merged, so I want ahead and made the minor changes and
> included this on my NBD queue.

That's perfect. Thank you for the edits.

> 
>>
>>>
>>> but that is not mandatory.
>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>
>>
> 


