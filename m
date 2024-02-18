Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B66C4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 05:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rba1Z-0000P4-KJ; Sun, 18 Feb 2024 00:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rba1W-0000OV-P7
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 00:47:34 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rba1U-00040H-Rh
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 00:47:34 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-214def5da12so1307063fac.2
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 21:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708235250; x=1708840050;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fLD2G7b/gc3u6Zm0GpLIgynnW6CskVg7NeyeRzWFwAQ=;
 b=2wUZ1GenjWWszPvw7c3fauDeEhm7AjlYRRCalnKMGSB/GETLphgrprQZJLwbymsNhx
 rG++o1FtYBmWEd3w2c6RgnQhS3wOUWAuiNotAIUWJ9yNJUwudkAiojC3hPN5H96w/F0a
 Qd2dpbNlAMpyqurNcPGvCDWeh0O5bgTK3QOLLDHkEJOIVY+Vn8KQsjSjICkolWbDm6NI
 FgalM24fPKBYs6qfBL8STtl1GJy8CzKmjtkkS6wAXYBOUgOP1yckRKRYl399v81aKMr5
 AUeZiewoTPBqDjeLjepeIMeQUHCdxygc4bPYBGwfwGLhlzCjZ8WHM6QyxZtg568wioL/
 RlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708235250; x=1708840050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fLD2G7b/gc3u6Zm0GpLIgynnW6CskVg7NeyeRzWFwAQ=;
 b=jUAFXx0ILfVJJtX4kyLkwcoL20PzMNHxDJFpEsmAb/anq9quFLTHEac4NKHx4qAFbI
 /nGj4/QlgUNe5w5Mm/mPHMlsFlbS5QgLv3arvzp4uxk7glHGXJnODJCNYO3DagA4x0TK
 OKWaYodIGxNoP+Zp4IY4fFv6tNe5x3TN78LG+0d7wqVahhiyJrXvHFA5t3tHG6t3e02D
 Ck78Y4jbu1HE68GGvgu7Ib+UUxQ5CSi+R+ezMtWbaTAbYBBKYcSCrxNv7zYJCkkKJTck
 Dk0Wyc484V4O4QHTEuis5VIlBHpT2blqTK/YU3vrXWpm8zqzlSxU4L5AIYGwRjawv/Za
 wndw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG4sVI/OKefPYL+PykpMlwcD0eZU9705ob5bpylYFh60b5Bdrnqy/ingqhhF25wNM1Pu2pH35gmx/TIEm9XP6e6VHMxi0=
X-Gm-Message-State: AOJu0YxX1W25gQemlAok6YwZhTSizznbV1bpY5NSMPCcrgQ2dcPk8DUc
 JEy4RiWYWV0QleZQn357ALT9HAxmvwb19qCcOosR+u4G1J/XbVmVjAMrZ/vPh4Y=
X-Google-Smtp-Source: AGHT+IEVnE1x/FaH3ITWn9Lss/JfHzgEsSt1MJHKPapNPjiilCZrIqlzn2x+k1/TzHtMecE4bzK+Og==
X-Received: by 2002:a05:6870:c115:b0:214:df30:3b77 with SMTP id
 f21-20020a056870c11500b00214df303b77mr10333512oad.1.1708235250151; 
 Sat, 17 Feb 2024 21:47:30 -0800 (PST)
Received: from [157.82.207.250] ([157.82.207.250])
 by smtp.gmail.com with ESMTPSA id
 l184-20020a6391c1000000b005dca5caed40sm2384968pge.81.2024.02.17.21.47.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 21:47:29 -0800 (PST)
Message-ID: <e22f1045-afdd-4a02-bf41-ae48ea4e0934@daynix.com>
Date: Sun, 18 Feb 2024 14:47:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qdev: Report an error for machine without
 HotplugHandler
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
References: <20231210-bus-v2-1-34ebf5726fa0@daynix.com>
 <87h6kpgrl7.fsf@pond.sub.org>
 <cbda6265-5027-424c-be93-86073d9ad63a@daynix.com>
 <8734vzsj6k.fsf@pond.sub.org>
 <ff212914-32b5-442e-8f67-4f01a7208a0c@daynix.com>
 <87y1dpgvim.fsf@pond.sub.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87y1dpgvim.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2001:4860:4864:20::36;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/20 16:53, Markus Armbruster wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2023/12/18 23:02, Markus Armbruster wrote:
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>
>>>> On 2023/12/11 15:51, Markus Armbruster wrote:
>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>
>>>>>> The HotplugHandler of the machine will be used when the parent bus does
>>>>>> not exist, but the machine may not have one. Report an error in such a
>>>>>> case instead of aborting.
>>>>>>
>>>>>> Fixes: 7716b8ca74 ("qdev: HotplugHandler: Add support for unplugging BUS-less devices")
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>
>>>>> Do you have a reproducer for the crash?
>>>>>
>>>>>> ---
>>>>>> Changes in v2:
>>>>>> - Fixed indention.
>>>>>> - Link to v1: https://lore.kernel.org/r/20231202-bus-v1-1-f7540e3a8d62@daynix.com
>>>>>> ---
>>>>>>     system/qdev-monitor.c | 13 ++++++++++---
>>>>>>     1 file changed, 10 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>>>>>> index a13db763e5..5fe5d49c20 100644
>>>>>> --- a/system/qdev-monitor.c
>>>>>> +++ b/system/qdev-monitor.c
>>>>>> @@ -927,9 +927,16 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>>>>>     void qdev_unplug(DeviceState *dev, Error **errp)
>>>>>     {
>>>>>         DeviceClass *dc = DEVICE_GET_CLASS(dev);
>>>>>         HotplugHandler *hotplug_ctrl;
>>>>>         HotplugHandlerClass *hdc;
>>>>>         Error *local_err = NULL;
>>>>>         if (qdev_unplug_blocked(dev, errp)) {
>>>>>             return;
>>>>>         }
>>>>>         if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
>>>>>             error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
>>>>>             return;
>>>>>         }
>>>>>         if (!dc->hotpluggable) {
>>>>>             error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
>>>>>                        object_get_typename(OBJECT(dev)));
>>>>>             return;
>>>>>         }
>>>>>         if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
>>>>>             error_setg(errp, "device_del not allowed while migrating");
>>>>>             return;
>>>>>         }
>>>>>
>>>>>>        qdev_hot_removed = true;
>>>>>>           hotplug_ctrl = qdev_get_hotplug_handler(dev);
>>>>>> -    /* hotpluggable device MUST have HotplugHandler, if it doesn't
>>>>>> -     * then something is very wrong with it */
>>>>>> -    g_assert(hotplug_ctrl);
>>>>>> +    if (!hotplug_ctrl) {
>>>>>> +        /*
>>>>>> +         * hotpluggable bus MUST have HotplugHandler, if it doesn't
>>>>>> +         * then something is very wrong with it
>>>>>> +         */
>>>>>> +        assert(!dev->parent_bus);
>>>>>> +
>>>>>> +        error_setg(errp, "The machine does not support hotplugging for a device without parent bus");
>>>>>> +        return;
>>>>>> +    }
>>>>>
>>>>> Extended version of my question above: what are the devices where
>>>>> qdev_get_hotplug_handler(dev) returns null here?
>>>>
>>>> Start a VM: qemu-system-aarch64 -M virt -nographic
>>>> Run the following on its HMP: device_del /machine/unattached/device[0]
>>>>
>>>> It tries to unplug cortex-a15-arm-cpu and crashes.
>>>
>>> This device has no parent bus (dev->parent_bus is null), but is marked
>>> hot-pluggable (dc->hotpluggable is true).  Question for somebody
>>> familiar with the hot-plug machinery: is this sane?
>>
>> Setting hotpluggable false for each device without bus_type gives the same effect, but is error-prone.
> 
> Having hotpluggable = true when the device cannot be hot-plugged is
> *wrong*.  You might be able to paper over the wrongness so the code
> works anyway, but nothing good can come out of lying to developers
> trying to understand how the code works.

Hi,

I'm now revisiting this patch and now I think it is still semantically 
correct.

This patch indeed prevents hotplugging a hotpluggable device and that 
may sound irrational. However, we should note that the entity that 
prevents hotplugging is not the device, but the machine that lacks a 
hotplug handler. So we can say the device itself is hotpluggable, but 
the machine is preventing hotplugging.

We already do similar in a case that a device has a parent bus. 
qbus_is_hotpluggable() returns false if the parent bus lacks a hotplug 
handler and prevents from hotplugging a hotpluggable device. The device 
class must still have hotpluggable = true in such a case because another 
instance of device may be plugged into a bus that has a hotplug handler.

I'll submit v3 soon so please check if this reasoning sounds valid for 
you and review it once I submit it.

Regards,
Akihiko Odaki

