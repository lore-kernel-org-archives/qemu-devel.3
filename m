Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FCEC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjcNS-0005Ye-Ds; Tue, 14 Jul 2026 08:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjcNP-0005Xo-IB; Tue, 14 Jul 2026 08:36:43 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjcNM-0006WB-Cn; Tue, 14 Jul 2026 08:36:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a25:0:640:ba29:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 4AE6A80A43;
 Tue, 14 Jul 2026 15:36:32 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5a::1:8] (unknown [2a02:6bf:8080:c5a::1:8])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id VaONQL0a0Sw0-yIJoiHhx; Tue, 14 Jul 2026 15:36:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784032591;
 bh=6uSMJQ8t1CatWg6aZw+GMRxYGLlOZ3ukNyDlSKBy1eg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VZ0ss2+s9pqvLamT45OKWnSf/oS6tyfKKG/Jo7e1nzasXE6gxnn7VjkcF1S2eV7GK
 N7372KgymgITjCK+TbNt4YP1baZdWlrmVot6L/3tyokRUBJbUkRoWDRnrhy0AjO5T3
 evkI8vA/8nLR8g2BDgKWeoquuNT9wYgkH57XetA8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f354fb46-c2f2-446f-9d03-8ee03c3c4fd8@yandex-team.ru>
Date: Tue, 14 Jul 2026 15:36:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iotests/migrate-bitmaps-postcopy-test: drop the
 postcopy timing assertion
To: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
References: <20260710161309.1104712-1-den@openvz.org>
 <20260710161309.1104712-4-den@openvz.org> <alYdU5b2l9N-WZPe@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <alYdU5b2l9N-WZPe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14.07.26 14:28, Kevin Wolf wrote:
> Am 10.07.2026 um 18:13 hat Denis V. Lunev geschrieben:
>> test_postcopy_success asserted `downtime * 10 < postcopy_time` to
>> confirm the run spent meaningful time in postcopy. This is an
>> unnormalized wall-clock heuristic tuned to old hardware (commit
>> e80a4150a5), and fails on fast hosts where the bitmap payload now
>> transfers in under a second while switch-over downtime stays fixed
>> (e.g. downtime=0.6s, postcopy_time=0.8s).
>>
>> It is also a weak proxy for the regression it guards against
>> (postcopy degenerating to precopy): that is already covered by the
>> bitmap sha256, mid-migration update and persistence checks, none of
>> which depend on this timing.
>>
>> Drop the assertion; keep printing the timings under debug.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Hanna Reitz <hreitz@redhat.com>
> 
> I agree that this assertion failure doesn't mean that the test failed.
> What it might mean is that maybe we didn't test the code as well as we
> would have liked to.

Yes, the aim was to guarantee, that we don't simply pass the whole bitmap
in downtime, not starting any postcopy at all.

Possible alternative is to do query-migrate exactly after RESUME, and check
that remaining is significantly more than zero: this data is transferred
in postcopy for sure.

> 
> Should we try to slow down/throttle the migration artificially to
> trigger the cases we want to test here more reliably?
> 
> Kevin
> 
>>   tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
>> index c519e6db8c..f9c55b6395 100755
>> --- a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
>> +++ b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
>> @@ -186,7 +186,6 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>>           downtime = event_dist(event_stop, event_resume)
>>           postcopy_time = event_dist(event_resume, event_complete)
>>   
>> -        assert downtime * 10 < postcopy_time
>>           if debug:
>>               print('downtime:', downtime)
>>               print('postcopy_time:', postcopy_time)
>> -- 
>> 2.53.0
>>
> 


-- 
Best regards,
Vladimir

