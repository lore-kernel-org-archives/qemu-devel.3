Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A00AFD9E0A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 19:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvhGc-0006CZ-FS; Thu, 26 Feb 2026 14:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvhGa-0006CI-QH
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 14:43:20 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvhGY-0003S4-3a
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 14:43:20 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8273eb7798eso483579b3a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 11:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772134996; x=1772739796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pnpimKbz2RFT9uySsmSKExBlh8WMAI7tgyTBqd2AWrw=;
 b=VyPsfBsEB8LkH0QR7qdgqQDy6BZYIjT1VSl+Sh/qV5MvRneJgwo15CFzRp5xz4LdmF
 C+dszyuRDLZTBMogIkV+OLdnRoRENLzLKMBEAMNlgx1LardELSy6QPXDQAHjjFjegiWb
 YGbd5PjXBqc30M8vqO79dKe2cnXEL4+ngbC/33CeFk1QrOTBLHAb0ZwK2OgspisIgbEX
 HqDrdr3YW2BGYoIySYx62Q6gcyr6xGYa4rt7ndVrbwA0EV8yRRGnfbeEOM2wiKyvmgqU
 Fltw4ZGttYRmT3xtIs2C9hVpHUnCLm9xK38JpqxbFro9eD0eEAvLlA58yqMa1q0GiB7/
 NvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772134996; x=1772739796;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pnpimKbz2RFT9uySsmSKExBlh8WMAI7tgyTBqd2AWrw=;
 b=A/FYBmwezcn8x1Z9UNsxeLEmJ45CvIzsiP5rbrcfDUtvlQ9Rtv3724KU0yaFyM1UFC
 2VYW8I469Alv9tuied7tW21cYYoxXGYANx4DuhwlU2mEArBnYsvNemiGmE5bcYeSNYvf
 9PKxGLB6GU6fwFm90UV3sYo/wCUbi1utJCeya1HCkWFIoB+FQSs/bLOSOsVYvO5cQBwZ
 fksKibmUg75WPaKiezITdnm66Hf9hhNl9KsLu3kfyJQag0I1foFv6SIw3Wen4aTR1a43
 MRxxDyNrr9zg8ESrEf2rjleKTspitSpOQhWd4NGoOUJfRSp7CRPgXKIlqbfJW0ix9S+x
 Qoeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLP7UHiW50gU6z5YKFSXOgW5fsiuWM7J4oxnxJOiio5BCHiGYurupk40LNAyPNanB+//LyQYUj5LLI@nongnu.org
X-Gm-Message-State: AOJu0YyN6cXzzgsZbsxjwTV6Yw3fyzjFqniwowIg48H4VC7dKsyvCsh3
 6Lrx1KGzooDWzS7xN4QUmsMMMegaltAj73KiHOhV052XzbZTJK4c3JnosYUnx1aWpaQ=
X-Gm-Gg: ATEYQzy/61ccuhOMsr0QUWC9eylyy8YUOQpkQV1umGQb4SWa1IlTFqOVIiawbR4qaME
 WaTSQ4Z4D7neYqN3lNjVFNerIQGQMPzs1vdm6GoaHw35Z/rnm+V70HN291g65dOCVgI+HphUJ1y
 yCXI0a5i+oL+SVRF8iKENgYOc4u4dp6X9UCr4N6yct1IIPQtDfWRDrKOOfkd++LjKJgTyJ02uh6
 EgxrjLjB8utTetrgT/ZRXVwSaoGXHWZIyhdw+5CZrU5MTKICdhJQb6jYPq4KmoNgqQ8TJs9Fxt4
 mUzKFUfSqMHh849+D8EK1pyJJR2uxJjePbyY8FtUIWDRn/OcqZBYJL502Al+4/HPD0q+EVN0Atc
 1nCbIJolwUB8U5MCzfcQm2dcrqOo+EAgC3IXX4S2RIKvYpkmwG+unvE+dRxklvPhalXMZHZrpnc
 sISYUCdIyuzjl2PkU4R8xvZ+cHgugbxJusdnr7es4guHHDwUKqQK8q9CqovItJyGFP+Adl
X-Received: by 2002:a05:6a00:2d06:b0:821:7d7e:41e0 with SMTP id
 d2e1a72fcca58-8274d93aa48mr275386b3a.5.1772134995785; 
 Thu, 26 Feb 2026 11:43:15 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d94de6sm3205632b3a.24.2026.02.26.11.43.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 11:43:15 -0800 (PST)
Message-ID: <ef97320b-17a2-4d2e-b140-30f571ee860b@linaro.org>
Date: Thu, 26 Feb 2026 11:43:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] plugins: add read-only property for registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com, qemu-devel@nongnu.org
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <8716147d-d5b4-4d8b-859a-26a5310973bc@epfl.ch>
 <5e43b8f7-e8ee-4cd9-b8a7-f4b4761b6137@epfl.ch>
 <87fr6nzi9h.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <87fr6nzi9h.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 2/26/26 6:33 AM, Alex Bennée wrote:
> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
> 
>> On 24/02/2026 16:53, Florian Hofhammer wrote:
>>> Some registers should be marked as read-only from a plugin API
>>> perspective, as writing to them via qemu_plugin_write_register has no
>>> effect. This includes the program counter, and we expose this fact to
>>> the plugins with this patch.
>>>
>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>> ---
>>>   include/plugins/qemu-plugin.h |  2 ++
>>>   plugins/api.c                 | 16 ++++++++++++++++
>>>   2 files changed, 18 insertions(+)
>>>
>>> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>>> index 04c884e82b..ae711758f1 100644
>>> --- a/include/plugins/qemu-plugin.h
>>> +++ b/include/plugins/qemu-plugin.h
>>> @@ -979,11 +979,13 @@ struct qemu_plugin_register;
>>>    *          writing value with qemu_plugin_write_register
>>>    * @name: register name
>>>    * @feature: optional feature descriptor, can be NULL
>>> + * @is_readonly: true if the register cannot be written via qemu_plugin_write_register
>>>    */
>>>   typedef struct {
>>>       struct qemu_plugin_register *handle;
>>>       const char *name;
>>>       const char *feature;
>>> +    bool is_readonly;
>>>   } qemu_plugin_reg_descriptor;
>>>   
>>>   /**
>>> diff --git a/plugins/api.c b/plugins/api.c
>>> index ca3e93a194..b2c52d2a09 100644
>>> --- a/plugins/api.c
>>> +++ b/plugins/api.c
>>> @@ -410,6 +410,12 @@ bool qemu_plugin_bool_parse(const char *name, const char *value, bool *ret)
>>>    * ancillary data the plugin might find useful.
>>>    */
>>>   
>>> +static const char pc_str[] = "pc"; // generic name for program counter
>>> +static const char eip_str[] = "eip"; // x86 specific name for program counter
>>> +static const char rip_str[] = "rip"; // x86_64 specific name for program counter
>>> +static const char pswa_str[] = "pswa"; // s390x specific name for program counter
>>> +static const char iaoq_str[] = "iaoq"; // HP/PA specific name for program counter
>>> +static const char rpc_str[] = "rpc"; // microblaze specific name for program counter
>>>   static GArray *create_register_handles(GArray *gdbstub_regs)
>>>   {
>>>       GArray *find_data = g_array_new(true, true,
>>> @@ -427,6 +433,16 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
>>>           /* Create a record for the plugin */
>>>           desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
>>>           desc.name = g_intern_string(grd->name);
>>> +        desc.is_readonly = false;
>>> +        if (g_strcmp0(desc.name, pc_str) == 0
>>> +            || g_strcmp0(desc.name, eip_str) == 0
>>> +            || g_strcmp0(desc.name, rip_str) == 0
>>> +            || g_strcmp0(desc.name, pswa_str) == 0
>>> +            || g_strcmp0(desc.name, iaoq_str) == 0
>>> +            || g_strcmp0(desc.name, rpc_str) == 0
>>> +           ) {
>>> +            desc.is_readonly = true;
>>> +        }
>>>           desc.feature = g_intern_string(grd->feature_name);
>>>           g_array_append_val(find_data, desc);
>>>       }
>>
>> While extending the tests for my patches, I noticed that there are other
>> registers that are effectively read-only as well, such as the vg (vector
>> granule) register on aarch64. I wonder whether there should be a more
>> generic support in QEMU for this or whether this is something that
>> should be handled by GDB instead.
> 
> I was chatting to Pierrick about this yesterday. There are also
> additional registers I'd like to make available as pure read-only and as
> they go through the gdbstub machinery that seems the obvious place to
> deal with them.
>

In addition, it seems that the set of register who might be readonly
could be different between plugins and gdb.
For instance, it can be convenient to set pc by writing to register in
gdb, even though that's not something supported by plugins.
So I would *very* prudent to change gdbstub default as a side effect.

For now, and the for the plugins, the current scope is fine.

>> The difference to the pc in that case is that the pc architecturally is
>> read-write and it was just QEMU who silently swallowed the writes to it.
>> For the vg register in the example, as far as I understand correctly,
>> this is not an actual architectural register, but something that GDB
>> exposes as a read-only register for easier debugging, and QEMU therefore
>> also exposes this register. However, writes to it with
>> gdb_write_register and by proxy qemu_plugin_write_register are silently
>> ignored.
>>
>> I'm not sure this is something that should be handled in this patch
>> series but I'm wondering whether this is something you already had on
>> your radar or whether this should be taken care of in a follow-up patch
>> series. I'd be happy to get your thoughts on this!
> 
> I think this is fine for now - for future enhancements we should extend
> the gdb machinery and then reflect that in the exported plugin
> registers.
> 
> 
>>
>> Best regards,
>> Florian
> 


