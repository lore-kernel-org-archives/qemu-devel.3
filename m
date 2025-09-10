Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE22CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 15:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwMNN-0005G3-9P; Wed, 10 Sep 2025 11:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uwMNH-0005Fh-Cj
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 11:04:43 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uwMND-0003Qq-Nj
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 11:04:43 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 49DD756F31B;
 Wed, 10 Sep 2025 17:04:35 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id U42ZVCVOR8MK; Wed, 10 Sep 2025 17:04:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E6B6956F2CA; Wed, 10 Sep 2025 17:04:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E49C556F2C1;
 Wed, 10 Sep 2025 17:04:32 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:04:32 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 00/25] tcg-plugins: add hooks for discontinuities
In-Reply-To: <87ldmm5x28.fsf@draig.linaro.org>
Message-ID: <453e44ee-f32c-887c-b488-34b9e03b65e8@eik.bme.hu>
References: <cover.1757018626.git.neither@nut.email>
 <a1c2d356-e664-2632-002f-d0b9bea06e1e@eik.bme.hu>
 <cf6e7db43e9e9e59b6c9edb1c172b01ae62fb23f@nut.email>
 <df0a8c4b-ae9b-1582-1570-6cb588149a7a@eik.bme.hu>
 <3c8d0c3733edc984937ac33a417488f92dccb148@nut.email>
 <819c9f3b-13f4-2ef2-e651-5cfec52f2e12@eik.bme.hu>
 <a2eaee5105fb4b3302e2f65bb8bbea987a85454e@nut.email>
 <a18a99ca-8415-71bf-3022-c9a98e46c2b5@eik.bme.hu>
 <71a535f9154ddc269c0a948053e39053550bd8c0@nut.email>
 <87ldmm5x28.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1854827598-1757516672=:84971"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1854827598-1757516672=:84971
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 10 Sep 2025, Alex Bennée wrote:
> "Julian Ganz" <neither@nut.email> writes:
>> September 10, 2025 at 12:06 PM, "BALATON Zoltan" wrote:
>>> On Tue, 9 Sep 2025, Julian Ganz wrote:
>>>> I ran streamPPCpowerpcO3 on qemu with these patches:
>>>>
>>>>  -------------------------------------------------------------
>>>>  Function Best Rate MB/s Avg time Min time Max time
>>>>  Copy: 2867.6 0.056828 0.055795 0.061792
>>>>  Scale: 1057.5 0.153282 0.151305 0.158115
>>>>  Add: 1308.8 0.187095 0.183380 0.193672
>>>>  Triad: 1111.6 0.220863 0.215902 0.230440
>>>>  -------------------------------------------------------------
>>>>
>>>>  After doing a clean build, with the fans still audible:
>>>>
>>>>  -------------------------------------------------------------
>>>>  Function Best Rate MB/s Avg time Min time Max time
>>>>  Copy: 2932.9 0.055131 0.054554 0.055667
>>>>  Scale: 1067.9 0.151520 0.149832 0.155000
>>>>  Add: 1324.9 0.184807 0.181150 0.191386
>>>>  Triad: 1122.0 0.220080 0.213896 0.229302
>>>>  -------------------------------------------------------------
>>>>
>>> What was different between the above two runs? I guess maybe one is with plugins disabled but it's not clear from the description.
>>
>> The difference is nothing but a a clean rebuild of qemu. As you see
>> there are fluctuations already. Plugins are enabled for both cases.
>>
>>>> On qemu (6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8) without these
>>>>  patches, but plugins enabled:
>>>>
>>>>  -------------------------------------------------------------
>>>>  Function Best Rate MB/s Avg time Min time Max time
>>>>  Copy: 2972.1 0.054407 0.053834 0.054675
>>>>  Scale: 1068.6 0.151503 0.149726 0.154594
>>>>  Add: 1327.6 0.185160 0.180784 0.193181
>>>>  Triad: 1127.2 0.219249 0.212915 0.229230
>>>>  -------------------------------------------------------------
>>>>
>>>>  And on qemu (6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8) without these
>>>>  patches, with plugins disabled:
>>>>
>>>>  -------------------------------------------------------------
>>>>  Function Best Rate MB/s Avg time Min time Max time
>>>>  Copy: 2983.4 0.055141 0.053630 0.060013
>>>>  Scale: 1058.3 0.152353 0.151186 0.155072
>>>>  Add: 1323.9 0.184707 0.181279 0.188868
>>>>  Triad: 1128.2 0.218674 0.212734 0.230314
>>>>  -------------------------------------------------------------
>>>>
>>>>  I fail to see any significant indication that these patches, or
>>>>  plugins in general, would result in a degredation of performance.
>>>>
>>> With worst case Copy test it seems to be about 3.5% (and about 1.7%
>>> with plugins disabled?) and should be less than that normally so it
>>> does not add much more overhead to plugins than there is already so
>>> this should be acceptable. It may still be interesting to see if the
>>> overhead with plugins disabled can be avoided with a similar way as
>>> logging does it.
>>
>> The thing is: that's probably just usual fluctuations. As you have seen
>> with the first two measurements the values fluctuate quite a bit between
>> runs of the test on the very same qemu (assuming that a clean build did
>> not incur any _other_ relevant change). For example, the best rate for
>> scale shown with plugins enabled is one percent faster than with plugins
>> disabled. Is this significant? Probably not. Or at least it doesn't make
>> much sense.
>
> I wouldn't spend too much time chasing this down. As you say this
> fluctuation is well within the noise range.
>
> I can recommend hyperfine as a runner:
>
>  https://github.com/sharkdp/hyperfine
>
> as it does some work on how many times you need to run a test before the
> results are statistically relevant.
>
>> I may do some more tests this week, with runtimes longer than a few
>> seconds if I can find the motivation to set up everything I'd need to
>> compile your benchmark. In the mean-time, you are welcome to make your
>> own measurements if you want to. The patches are also availible at [1]
>> if you don't want to apply them to your local tree yourself.
>
> Balton,
>
> I don't think worries about performance impact are justified and Julian
> has certainly done enough due diligence here. If you can come up with a
> repeatable test that shows a measurable impact then please do so.

I agree this testing is enough to ensure there is no big impact. I just 
wanted to make sure there is some testing and not just adding stuff 
without worrying about performance. I'd like to keep QEMU quick and only 
add unavoidable overhead where possible but I don't demand to spend too 
much time on that. If Julian got interested and does more testing that may 
give some interesting results for possible optimisation but if no time for 
that this was enough to measure the impact for this series.

Regards,
BALATON Zoltan

>> Regards,
>> Julian
>>
>> [1]: https://github.com/patchew-project/qemu/tree/patchew/cover.1757018626.git.neither@nut.email
>
>
--3866299591-1854827598-1757516672=:84971--

