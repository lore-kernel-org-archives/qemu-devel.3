Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2F7C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1rH-0007Kk-CT; Thu, 06 Feb 2025 08:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tg1r7-0007Jg-Tg
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:23:47 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tg1r5-0003of-LL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:23:45 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5D5554E6013;
 Thu, 06 Feb 2025 14:23:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 3S7rGU2rkOM8; Thu,  6 Feb 2025 14:23:39 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6F2C44E6005; Thu, 06 Feb 2025 14:23:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6C77A74577C;
 Thu, 06 Feb 2025 14:23:39 +0100 (CET)
Date: Thu, 6 Feb 2025 14:23:39 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
cc: Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Lei Yang <leiyang@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/4] qdev-properties: Accept bool for OnOffAuto
In-Reply-To: <6e6935dd-fae7-4cce-acad-69609eba9b6e@daynix.com>
Message-ID: <4363863f-3ba3-95b3-61ec-6fade162218f@eik.bme.hu>
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-2-cbf0aa04c9f9@daynix.com> <87cyfwxveo.fsf@pond.sub.org>
 <44b21e4c-b076-41bb-9564-1e7a8cf4a450@daynix.com>
 <87r04bs8sj.fsf@pond.sub.org>
 <6e6935dd-fae7-4cce-acad-69609eba9b6e@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Thu, 6 Feb 2025, Akihiko Odaki wrote:
> On 2025/02/06 18:48, Markus Armbruster wrote:
>>>                                              This problem can be solved
>>> using an existing mechanism, OnOffAuto, which differentiates the "auto"
>>> state and explicit the "on" state.
>> 
>> I guess you're proposing something like this:
>> 
>> * auto: on if possible, else off
>> 
>> * on: on if possible, else error
>> 
>> * off: off (always possible)
>> 
>> Which one is the default?
>
> I converted on to auto and off to false in a following patch.
>
>> 
>>> However, converting bool to OnOffAuto surfaces another problem: they
>>> disagree how "on" and "off" should be written. Please note that the
>>> disagreement already exists and so it is nice to solve anyway.
>> 
>> Yes, converting bool to OnOffAuto is an incompatible change.
>
> Not just about conversion, but this inconsistency require users to know 
> whether a property is bool or OnOffAuto and change how the values are written 
> in JSON accordingly. This somewhat hurts usability.

Worse than that, the help text is also confusing.
Excerpt from -device virtio-gpu,help

   blob=<bool>            - on/off (default: false)
   busnr=<busnr>
   disable-legacy=<OnOffAuto> - on/off/auto (default: "auto")
   disable-modern=<bool>  -  (default: false)
   edid=<bool>            - on/off (default: true)
   event_idx=<bool>       - on/off (default: true)

For bools it says on/off yet expects true/false. Wasn't originally 
true/on/1 and false/off/0 accepted for bools? Where that got lost? I think 
getting back that behaviour would be easiest for users. Users don't care 
if OnOffAuto is an enum internally and can't (or don't want to) remember 
if bools are written on/off or true/false so accepting these as synonyms 
would help users.

Regads,
BALATON Zoltan

