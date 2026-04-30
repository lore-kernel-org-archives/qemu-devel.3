Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C07CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVUs-0002f3-HJ; Thu, 30 Apr 2026 13:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wIVUS-0002T1-Hh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:47:57 -0400
Received: from 7.mo533.mail-out.ovh.net ([54.36.140.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wIVUJ-0003Uc-RP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:47:54 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4g61pk33Hgz61Sw;
 Thu, 30 Apr 2026 17:47:42 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 30 Apr 2026 17:47:42 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.170])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4g61pk1qDPz7tl2; Thu, 30 Apr 2026 17:47:42 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 D96022403AF6; Thu, 30 Apr 2026 17:47:40 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0049375919d-e85e-4ca9-b6ab-3be7c6e77efb,
 9F47DE0B15482FF6BC55B1CE858CC0DAC5AE7A4F) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <e5c8fbe2-c22b-4d95-ad52-87b29ed92a96@kaod.org>
Date: Thu, 30 Apr 2026 19:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/41] hw/fsi: move OPBus address space init to realize
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Ninad Palsule <ninad@linux.ibm.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-29-c413f3605311@redhat.com>
 <CAFEAcA-krpQw4atHeDkCae_7EJEtUrwGNHMnYxu4eNAXdyykeQ@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CAFEAcA-krpQw4atHeDkCae_7EJEtUrwGNHMnYxu4eNAXdyykeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 10790061758303022107
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG0CqItN+gnkCjlq+XxABJQ4Z/JnGQ1F6r7bnFdERQpEms/WdjRHPy7hAAR9TDx/TrZC2UopsB4572nx4wLBSHoDwbtsECQNZ71YJdltEe0Wru1HdBBMQc563AWvZiNjr1/higOCct09hmYp0YpcRGqgYC8gkrdUAetuTBI1NSR5UzStRr7ySiP14fk8tifOK3nypTX6vnCO+pPaPk2lfoUxDfz4zvmPnv9sOxI+J9D340tgf5f9SICKWnK2ieXbG5NGNPfoayskKD26AfzHVhEPEKUFtjdzvY9LCIlY1V09aX+eocAiSbDVebAdtzQuqO1i9SkMbuMiHiA5dPhew9ZQYGHTwtC7yVNjRXYxuaQlnOqceZ70d8q2uttrZ02cngMNcdFJRKwWU2jfTqmq11Ej++TsYjGYNgLyHqcuFgpsakZ9SmOSOv4cUAF27WalhhEgMsywcry0hNcEjRQQLE6zKVmwiyy5jOnKYRdljzqtw/hYl5G0mgoyWyRLsMFvA4w9AwL7gyqsjfZvh4IcUi1U3uDYwbn//Bq6xc6paYA9JQ1kEYko8y5Q4kszFIE2a64ZYtYQfLVa4pJT8P1jpvREg/0HKsAxg4nAkoJ7w/ihFcP6FGVgxqzbTj2274kn5k/ytkAM0kU9opIpe1TJdT/JDtwqLVgvzhCLDKOzFq+Xw
DKIM-Signature: a=rsa-sha256; bh=ea1UUJdMFsM6tOAMjh0/ZUK6MYHuD+kl8s66Zioz5J0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1777571262; v=1;
 b=cdH9PW88DMR5nEtws+NnnJCJjg9nagirG9Qu/bENR4woNlNTOktFomJv08m+DE1tU2G0WI5y
 uyI6iOr3OlN4ED4JwnFRspLZJxKzX+1SlFznO/imXwM1pFr2aQsp84vUf8csmJCb3srns0TVab0
 sBe22T/iMhQYFHJTyNKdyJldVKTKbPIRyqayA+i2Y98yoNkuV4VEryO0jZNMjRokuJ12fykvWX8
 C19fGLIw1hX478Kdpu+as4Vjpn9HOPbzV45ldTw0tHlu4B/rf7TdEzAmG7+3yV26AWvpeh+KXmJ
 qmA5uLYeA4AKyusdD8FwopHc3j/Bh9M94oZjgfrnwgl3Q==
Received-SPF: pass client-ip=54.36.140.182; envelope-from=clg@kaod.org;
 helo=7.mo533.mail-out.ovh.net
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

On 4/30/26 18:09, Peter Maydell wrote:
> On Mon, 27 Apr 2026 at 20:45, Marc-André Lureau
> <marcandre.lureau@redhat.com> wrote:
>>
>> The OPBus instance_init initializes an AddressSpace, registering it in
>> the global address_spaces list. When a bare OPBus object is created
>> and destroyed (e.g. by qom-tests), there is no finalize to remove the
>> stale entry, leading to a heap-use-after-free when a subsequent
>> flatviews_reset iterates the list.
>>
>> Move address_space_init to the bus realize callback and add the
>> corresponding address_space_destroy in unrealize, following the
>> NubusBus pattern. Also fix the memory_region_init owner from NULL to
>> the OPBus object, so the MR is properly parented instead of dangling
>> under the "unattached" container.
>>
>> Fixes: eb04c35da2c0 ("hw/fsi: Aspeed APB2OPB & On-chip peripheral bus")
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   hw/fsi/aspeed_apb2opb.c | 31 +++++++++++++++++++++++--------
>>   1 file changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c
>> index b9d72f3ecf6..5d1e471288b 100644
>> --- a/hw/fsi/aspeed_apb2opb.c
>> +++ b/hw/fsi/aspeed_apb2opb.c
>> @@ -282,13 +282,6 @@ static void fsi_aspeed_apb2opb_realize(DeviceState *dev, Error **errp)
>>       AspeedAPB2OPBState *s = ASPEED_APB2OPB(dev);
>>       int i;
>>
>> -    /*
>> -     * TODO: The OPBus model initializes the OPB address space in
>> -     * the .instance_init handler and this is problematic for test
>> -     * device-introspect-test. To avoid a memory corruption and a QEMU
>> -     * crash, qbus_init() should be called from realize(). Something to
>> -     * improve. Possibly, OPBus could also be removed.
>> -     */
> 
> I think that what this TODO comment is trying to note is that
> we do the qbus_init() in realize because the implementation
> of the bus does things in its instance_init that it ought
> to be deferring to realize. If we fix the bus to do those
> things in realize instead, we ought to be able to move
> this qbus_init() to the fsi_aspeed_apb2opb_init function
> where it more logically belongs.
Yes, I spent some time trying to understand and untangle
the issue, but eventually left a TODO comment as it was
too complex to address at the time.

> Cédric, I think you wrote this comment; 

I did.

> what do you think?

If it is now safe to call qbus_init() in fsi_aspeed_apb2opb_init() :

     for (i = 0; i < ASPEED_FSI_NUM; i++) {
         object_initialize_child(o, "fsi-master[*]", &s->fsi[i],
                                 TYPE_FSI_MASTER);
         qbus_init(&s->opb[i], sizeof(s->opb[i]), TYPE_OP_BUS, DEVICE(s),
                   NULL);
     }

then, let's do that and remove the comment. If not, I'd rather
keep the comment.

I don't remember why I thought OPBus could be removed.

Thanks,

C.


> 
>>       for (i = 0; i < ASPEED_FSI_NUM; i++) {
>>           qbus_init(&s->opb[i], sizeof(s->opb[i]), TYPE_OP_BUS, DEVICE(s),
>>                     NULL);
>> @@ -348,15 +341,37 @@ static void fsi_opb_init(Object *o)
>>   {
>>       OPBus *opb = OP_BUS(o);
>>
>> -    memory_region_init(&opb->mr, 0, TYPE_FSI_OPB, UINT32_MAX);
>> +    memory_region_init(&opb->mr, o, TYPE_FSI_OPB, UINT32_MAX);
>> +}
>> +
>> +static void fsi_opb_realize(BusState *bus, Error **errp)
>> +{
>> +    OPBus *opb = OP_BUS(bus);
>> +
>>       address_space_init(&opb->as, &opb->mr, TYPE_FSI_OPB);
>>   }
>>
>> +static void fsi_opb_unrealize(BusState *bus)
>> +{
>> +    OPBus *opb = OP_BUS(bus);
>> +
>> +    address_space_destroy(&opb->as);
>> +}
>> +
>> +static void fsi_opb_class_init(ObjectClass *klass, const void *data)
>> +{
>> +    BusClass *bc = BUS_CLASS(klass);
>> +
>> +    bc->realize = fsi_opb_realize;
>> +    bc->unrealize = fsi_opb_unrealize;
>> +}
>> +
>>   static const TypeInfo opb_info = {
>>       .name = TYPE_OP_BUS,
>>       .parent = TYPE_BUS,
>>       .instance_init = fsi_opb_init,
>>       .instance_size = sizeof(OPBus),
>> +    .class_init = fsi_opb_class_init,
>>   };
>>
>>   static void fsi_opb_register_types(void)
> 
> thanks
> -- PMM


