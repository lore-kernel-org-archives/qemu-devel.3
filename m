Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA4EFA1FD7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 17:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFb1q-0004I5-LV; Wed, 22 Apr 2026 13:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wFb1l-0004FJ-0x
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 13:06:18 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wFb1i-0004Jd-Pl
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 13:06:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id CE11AC022E;
 Wed, 22 Apr 2026 20:06:09 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:781::1:26] (unknown
 [2a02:6bf:8080:781::1:26])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 76Xkde0K74Y0-BqluP01j; Wed, 22 Apr 2026 20:06:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776877569;
 bh=MIjcatyIOWyGC+cnq4VG//bVuH8UTsMRCDHu96PXmuQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=atTpIPWTHq64tBk2WeOv8gd/EqYfchzCGvu3EtC3C9UOhABII7PJ+2P/zmST74eAP
 7+kkWGpLlKXuCK6Y9zi/17sjHu3yTlV4BsgiOADp06z1vM9enBXkMtnINMFNSi8Qp4
 E3Pa3p+hNjBhzRGxVs1RWRDzWi7Sk79i1tKSQfm0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a8b865f7-1eb8-40b8-91e4-bd66c771c989@yandex-team.ru>
Date: Wed, 22 Apr 2026 20:06:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] migration/treewide: Merge
 @state_pending_{exact|estimate} APIs
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, "Jason J. Herne" <jjherne@linux.ibm.com>
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-6-peterx@redhat.com>
 <13359e7d-be22-4165-acf2-67de2fa3e7fd@yandex-team.ru>
 <aejsyzDCh5yOt9CW@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aejsyzDCh5yOt9CW@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 22.04.26 18:44, Peter Xu wrote:
> On Wed, Apr 22, 2026 at 11:29:11AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 21.04.26 23:20, Peter Xu wrote:
>>> These two APIs are a slight duplication.  For example, there're a few users
>>> that directly pass in the same function.
>>>
>>> It might also be error prone to provide two hooks, so that it's easier to
>>> happen one module report different things via the two hooks.
>>>
>>> In reality, they should always report the same thing, only about whether we
>>> should use a fast-path when the slow path might be too slow, as QEMU may
>>> query these information quite frequently during migration process.
>>>
>>> Merge it into one API, provide a bool showing if the query is an exact
>>> query or not.  No functional change intended.
>>>
>>> Export qemu_savevm_query_pending().  We should use the new API here
>>> provided when there're new users to do the query.  This will happen very
>>> soon.
>>>
>>> Cc: Halil Pasic<pasic@linux.ibm.com>
>>> Cc: Christian Borntraeger<borntraeger@linux.ibm.com>
>>> Cc: Eric Farman<farman@linux.ibm.com>
>>> Cc: Matthew Rosato<mjrosato@linux.ibm.com>
>>> Cc: Richard Henderson<richard.henderson@linaro.org>
>>> Cc: Ilya Leoshkevich<iii@linux.ibm.com>
>>> Cc: David Hildenbrand<david@kernel.org>
>>> Cc: Cornelia Huck<cohuck@redhat.com>
>>> Cc: Eric Blake<eblake@redhat.com>
>>> Cc: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
>>> Cc: John Snow<jsnow@redhat.com>
>>> Reviewed-by: Jason J. Herne<jjherne@linux.ibm.com>
>>> Reviewed-by: Juraj Marcin<jmarcin@redhat.com>
>>> Reviewed-by: Avihai Horon<avihaih@nvidia.com>
>>> Signed-off-by: Peter Xu<peterx@redhat.com>
>>
>>
>> Probably too late after all these r-b-s, but it would be simpler to review,
>> if renaming and reworking the documentation of the fields, moving them
>> to a separate structure, and combining two handler functions into one
>> would all be different patches.
> 
> Split of the patch might involve some code added then quickly removed
> again, which I also want to avoid.
> 
> Considering the reviews done on this series (and the challenge of finding
> hardwares to test..), I'd appreciate if you're OK we land this sooner then
> rework whatever thing on top if the changes will be cosmetic.  That is, I
> agree your question with the documentation for using "can" in the new API:
> it is a bit ambiguous indeed.  I'll see how I will integrate them best, it
> may depend on whether there're other reasons for a full repost / retest.

Of course, I agree.

for block dirty bitmaps:

Acked-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir

