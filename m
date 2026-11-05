Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284D606A333
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=P65It0ZH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1XJ-0003Eg-Ky; Thu, 05 Nov 2026 12:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xP1X8-0003CV-LM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:45:57 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xP1X6-0001n9-4m
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793900739; bh=JaJU5j59TEGOjcszgzA5rLUFgjkVNS9KuBAlBcxTTTY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=P65It0ZHl6ckx+7+uftoBlkn1/KZ+qLwgkwoarFwXmQhmBGDCv4cOw9fqVCqNxBcg
 pcUrA9zJ77LkyqxQJ6rNcECJjZpRBe6ldMq/afY0JsEYHne/ceiEStdMTCDcMWzyt8
 498dvGShkYgDbjnXsxr760XCtWWkPHh3kX21BtjlXNDO2133fb991DvQDtxay/+Jd5
 HCBm/qNgBQhT1TIln5l1ut0QRahCK6PHeS2v08WftCSuPexuTBz/8MkzeTpsnkIHjt
 2pHXRnkW+GSHAtsUolkVvbnfIh1vfVLKjpQrEOX3ytMeGIGTuLEumI7fwvfCnLxlvu
 JbWyULmI3Bv1A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 073161E41AE;
 Thu, 05 Nov 2026 20:45:39 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C1728454E17;
 Thu, 05 Nov 2026 20:45:38 +0300 (MSK)
Message-ID: <b8d8bb6b-2a2b-4021-829e-7e6ec3dc6d59@tls.msk.ru>
Date: Thu, 5 Nov 2026 20:45:38 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/22] vhost refactoring and fixes
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
 <20260715184145-mutt-send-email-mst@kernel.org>
 <89ef906d-56d3-40cd-bce4-5636dd963eee@yandex-team.ru>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <89ef906d-56d3-40cd-bce4-5636dd963eee@yandex-team.ru>
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

On 7/16/26 02:27, Vladimir Sementsov-Ogievskiy wrote:
> On 16.07.26 01:41, Michael S. Tsirkin wrote:
>> On Wed, May 27, 2026 at 09:16:01AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all. That's a preparation for vhost-user-blk backend-transfer
>>> feature.
>>>
>>> 07: rebase on master,
>>> 04: drop extra occurence of system_virtio_ss.add(files('vhost-user-stub.c'))
>>
>> so patch 10 is the fix?
> 
> Probably it's too late :/ I don't understand, what do you mean). Patch 10 is a
> fix yes. But seems it has no relation to vhost-user-stub.c ?
Hi!

I'm looking at cherry-picking this for stable 10.0.x series too, since the
bug is there as well.

Most likely on top of

   41d5e37e0e2 hw/virtio/vhost: Replace legacy cpu_physical_memory_*map() calls
   (Cc'ed Philippe)

What would be the minimal set of changes for 10.0.x?

Especially these commits are of interest, I guess:

   060ef8cac1 vhost: simplify calls to vhost_memory_unmap()
   4e61c89262 vhost: final refactoring of vhost vrings map/unmap
   c85f42703d vhost: vhost_virtqueue_start(): fix failure path

It's too bad I haven't noticed the issue being fixed is an interesting one,
and without Cc'ing stable..

Thanks,

/mjt

