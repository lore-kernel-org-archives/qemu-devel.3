Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6B3C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEj7-0003Kc-VI; Mon, 13 Jul 2026 07:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wjEj3-00038q-7o
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:21:30 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wjEiz-00085Z-G4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:21:28 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66DBL0fL071516
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 13 Jul 2026 20:21:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=zmDBH4qOjoiTL4WslOnfhsFXbndTsnXGkFgdJVprOSU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1783941660; v=1;
 b=O29YLQINSea0gGUZJDGfLaZd5wx99LBVYmHTs7/mAlgr9vK/aFCcv9SFBLt9B8kv
 2VbcJbCKagPevgwfVsGS/dqsB5dXilzf6h3XbRvfxwT815sS9nWT7FF6SW7jKl+0
 NnjKsdjvq1+lAcMUbt2JdnIPLagHZTKbPn+4+L3Fe+/D40vORfeaXYhUXcUOmL7G
 54X1BGkX7SbN5yPIq2lMi+kiiig14RpBf3WCn2/3d+eTbC4xgO6i0Yf74A+6JeTN
 jeIYLr/lofGSZ5cccQqjMnOC44EhlMxjJyTR154JpbNhQpKqBC3VBnwMbHNJhFg6
 JGh9xsGufYMUE49zncwfAw==
Message-ID: <2c996e76-72a9-4e3f-b732-3cac1554be6b@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 13 Jul 2026 20:20:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qdev: Clarify instantiation and realization
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20260629-qdev-v2-1-8cd1d9be0d8d@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA9QJCfeBTi4GdatY0Ci7no8BQETxHd7i6TtJ7SFxEtjjA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAFEAcA9QJCfeBTi4GdatY0Ci7no8BQETxHd7i6TtJ7SFxEtjjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/07/13 18:13, Peter Maydell wrote:
> On Mon, 29 Jun 2026 at 09:18, Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> The distinction of instantiation and realization was vague in the old
>> documentation so this change clarifies it.
>>
>> The old documentation said:
>>> The former may not fail (and must not abort or exit, since it is
>>> called during device introspection already), and the latter may return
>>> error information to the caller and must be re-entrant.
>>> Trivial field initializations should go into #TypeInfo.instance_init.
>>> Operations depending on @props static properties should go into
>>> @realize.
>>
>> The first problem with the old documentation is that it is unclear what
>> "trivial field initializations" means and why triviality makes
>> initialization appropriate for #TypeInfo.instance_init. Another problem
>> is that the documentation is not comprehensive enough; for example, it
>> mentions @props static properties, but it does not say anything about
>> the other properties.
>>
>> The keys to distinguish instantiation and realization are property
>> setting and device introspection. The fact that property setting happens
>> after #TypeInfo.instance_init and before realization implies that
>> operations depending on properties should go into @realize.
>>
>> The fact that instantiation happens during device introspection but
>> realization does not implies:
>> - Instance properties should be added in #TypeInfo.instance_init.
>> - Instantiation must not have any side effect not contained in the
>>    instance.
>> - Any operations without special requirements should go into @realize so
>>    that they can be skipped during device introspection.
>>
>> Note these two facts to guide appropriate instantiation and realization.
> 
> Thanks for sending this. I think we definitely need to try to be
> clearer about what to do in instance_init and what to do in realize.
> 
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
>>    * Realization
>>    * -----------
>>    *
>> - * Devices are constructed in two stages:
>> - *
>> - * 1) object instantiation via object_initialize() and
>> - * 2) device realization via the #DeviceState.realized property
>> - *
>> - * The former may not fail (and must not abort or exit, since it is called
>> - * during device introspection already), and the latter may return error
>> - * information to the caller and must be re-entrant.
>> - * Trivial field initializations should go into #TypeInfo.instance_init.
>> - * Operations depending on @props static properties should go into @realize.
>> + * Devices are constructed in the following order:
>> + *
>> + * 1) #TypeInfo.instance_init
>> + * 2) pre-realize property value setting
>> + * 3) device realization via the #DeviceState.realized property
>> + *
>> + * #TypeInfo.instance_init may not fail, and realization may return
>> + * error information to the caller and must be re-entrant.
> 
> I know this is in the existing text, but what do we mean by
> "must be re-entrant" here ? Does this mean "even if you return
> a failure from your realize method you must be able to handle the
> caller retrying the realize operation" ?  (I'm not sure why that's
> a useful thing for the caller to be able to do...)>
> I assume we don't mean "even if you successfully realize you must
> handle (and treat as a no-op) a second call to realize", because
> none of our devices do that :-)

If you take the code literally, device_set_realized() indeed avoids 
calling realize after successful realization, but it doesn't report an 
error when retrying, so I think this means to allow that.

I don't think it's that useful, and it is likely to cause bunch of bugs. 
I can also imagine that careful developers have written device code that 
preserves this contract, though the added complexity is useless in practice.

In my opinion, the property should be tristate: initialized, realized, 
or retired. Then we would have only the following state transitions:

Successful realization: initialized -> realized
Failed realization: initialized -> retired
Unrealization: realized -> retired

This is another opportunity for refactoring, but for this particular 
patch I'm planning to keep it out of scope.

> 
>> + * #TypeInfo.instance_init should add instance properties but must not
>> + * have any side effect not contained in the instance, since it happens
>> + * during device introspection already. Any operations without special
>> + * requirements should go @realize so that they can be skipped during
>> + * device introspection.
>>    * After successful realization, setting static properties will fail.
>>    *
>>    * As an interim step, the #DeviceState.realized property can also be
>> @@ -40,9 +43,8 @@
>>    * point in time will be deferred to machine creation, so that values
>>    * set in @realize will not be introspectable beforehand. Therefore
>>    * devices must not create children during @realize; they should
>> - * initialize them via object_initialize() in their own
>> - * #TypeInfo.instance_init and forward the realization events
>> - * appropriately.
>> + * initialize them via #TypeInfo.instance_init and forward the
>> + * realization events appropriately.
> 
> This change doesn't seem to me to match the paragraph it's in.
> The intent of the paragraph is clearly "initialize child objects in
> your own instance_init method", so we want to say "in" the method.
> "via" here is for "how you do it"; we could make that say
> "initialize them (e.g. by calling object_initialize())" to be
> a bit clearer, something like:
> 
> "Therefore
> devices must not create children during @realize; they should
> initialize them (e.g. by calling object_initialize_child()) in their
> own #TypeInfo.instance_init method, and then realize them (e.g. by
> calling qdev_realize()) in their own #DeviceClass.realize method."

That looks better. I'll use it for the next version.

> 
> This whole paragraph is one of those we sometimes like to put in,
> which is sketching out a design idea or direction we have not
> actually managed to achieve. So it's part aspiration and part
> reality. In particular, the flat "must not create children during
> realize" statement clashes with "operations depending on static
> properties should go into realize", because occasionally we need
> to create or not create children based on the value of a property...

Honestly I would just replace "must" with "should". Hopefully people 
would understand.

Regards,
Akihiko Odaki

