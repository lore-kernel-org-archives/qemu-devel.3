Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49919C0218F
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 17:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tedmN-0001IT-Mz; Sun, 02 Feb 2025 12:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1tedmL-0001I0-2F; Sun, 02 Feb 2025 12:29:05 -0500
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1tedmJ-0003GG-Ia; Sun, 02 Feb 2025 12:29:04 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MulyX-1tM93Q0S9b-00zzlA; Sun, 02 Feb 2025 18:28:59 +0100
Message-ID: <b713bd1a-0cd6-4b30-8ba7-daaa829bfe28@vivier.eu>
Date: Sun, 2 Feb 2025 18:28:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] net: Fix announce_self with vhost
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, 
 qemu-stable@nongnu.org
References: <20250117111709.970789-1-lvivier@redhat.com>
 <fee03f11-bcf5-4586-abc1-2d38ce6a7f9c@redhat.com>
 <9080590d-d823-473e-833e-d726490f1b18@tls.msk.ru>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <9080590d-d823-473e-833e-d726490f1b18@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WifZl44NxP9mQsuvXR20EljXkw49jgRyoEesBSkPjayTCQOhQYn
 ECIRBM8fwPc8Em26fAawUJ4u4UfbjjqF3qGxkgBs9ZFhzyUYS9Gu9+4d6VWTOCsL7QfOjgu
 o/kNpWLA5KZXpSr70zgmtzLGlnbmeOrRcCC11Xd6l7lb0RrEarDwC4KnqlppSBuiwMj7bR5
 c0IapAm4TP/MB1cw9SwUg==
UI-OutboundReport: notjunk:1;M01:P0:1QkxLZ5M0vo=;zPYyeQxSyozltL9HoJTeiVinhSi
 OP8YKHpyTakyU47lJKoGSzMnxP5kUNcHG5KrlOVeVcYjOVuoymE+Di3tWO3bKJD/blvgMmf8S
 /zsc7Eb9q5rD4iCjGpC/+Uq6WXY0Fuqv0tRH1Uw6HjLah+PeLsFafdFK1QfElPmY7WI13QVjC
 ophJMEL2/TybAHfeehYJfvAKuHfEOXr5ihLEFBiUbGJtDom3rE2V0vAyTXdLn82PNRV/KGWz/
 qxLCRAgCHKGQDo7BkxxlTHNqyTJ82etJXpJ6i65GoPo6yU/P6/+e1ks+Cl0+peKIZNeXIDLUI
 uTBTEYRIIIRP0e0CDBt7qC4mwiAD2zNUum1OEnIwJ2+UmDe91M91TZy7oHx6nX5K4RwxHEYpT
 UmiLRtbm6tDNVZVl9qYvLdiRD1jcddFgnXyhUbyCP0CjQ2LliQgWybTS14FTb2zzgVIBkL2hI
 aYkePHzxVdD6Nz56Kzj48iOD4nsJBWOdRtUeuRzFe3ZkQab5vaS7kAzTjQ4Pkd4bTzoUNyb98
 Trk6ysqB9d0NdHjbKRsWh0bc0nYsgLJhiMmDyC/qHeikRuL4tiQGim3GLe09jCunDBGRe/mAq
 SkUQjFvKJTzQA00o+KU9Zynw+GzNZujCHPFRieYO6juk2YyyAi5aMiKGO0AxuKKdWf0Jc5ZgG
 LGMXh5s3ZsDVPhQmrOOCjYjd/WedVvx3jEl62xxOBUYTAmha9adYHLNjI1KmA1auZ0aos+bXa
 PAFACDthJ91AjHEPtPSpghkuAXaqBCu9dmoxGwcvFCIyCXJTcJ+RcALOXPlkgtRlXhX3AP2bW
 8cBU+x2p+M0GcmmnWCgm7ig7T3KJMVlvOuSx6Hj3660rScxc9/gkiWaFNvnsxfx4WQ/eLwscD
 qykznZ8vlKdjfT0DF/vS9BJnGJGMkctCwuRTgR9sjUv6U2dzkG9rrUX3gdUe/vDoWYjwHvKh+
 yUOPuaapJ14J3io1kbzQHZ2a1DF8cYyb7kisUBaFbdC7zqBG8Cv+wemJqn0VK77k0GdvxQL65
 uSAodhr4BFL2JxLMo+muQD42YHdg/M5djZtvZAD7/AFpG/gZ4F43UWn+lo1JregFKRP3A6YAD
 L/0OqlwrsnToINgiRjTTn9keUK2MXh5vZsWPj9bnUyk6Px2GFDw+DhVxH4a2oWL6TRIfOinFi
 PW3xceLQUm5rkPhf0DnPcYbZKCgoWm5HALTKTc3JB7IJXzLZtfeOS+CbDO6UvOS/2xey7kloW
 hOayCvJ5tGJuPn6b6au2zFzbxMZBdxjeVhUOXW4hZHEpHbGj2C9xx54=
Received-SPF: pass client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Le 01/02/2025 à 20:36, Michael Tokarev a écrit :
> 17.01.2025 17:05, Laurent Vivier wrote:
>> CC: qemu-stable and qemu-trivial.
>>
>> On 17/01/2025 12:17, Laurent Vivier wrote:
>>> announce_self that sends a RARP packet after migration
>>> or with announce_self QMP/HMP command doesn't work with
>>> vhost because of the vnet headers.
>>>
>>> announce_self is the only user of QEMU_NET_PACKET_FLAG_RAW and
>>> this flag is not correctly managed.
>>>
>>> This series fix a problem with this flag in filter-dump and in
>>> qemu_deliver_packet_iov().
>>>
>>> Laurent Vivier (2):
>>>    net: Fix announce_self
>>>    net/dump: Correctly compute Ethernet packet offset
> 
> Is this one - "Correctly compute Ethernet packet offset" - needed for
> older stable series too, like 8.2 and 7.2 (currently active ones)?
> 
> Since it doesn't apply without 4b52d63249 (tap: Remove qemu_using_vnet_hdr()).

It fixes 481c52320a26 ("net: Strip virtio-net header when dumping") that is only in 8.0.
But I'm not sure the bug exists without 4b52d63249 (tap: Remove qemu_using_vnet_hdr()), so it should 
be tested first.

Thanks,
Laurent

