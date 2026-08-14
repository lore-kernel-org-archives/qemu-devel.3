Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4DBC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wusDw-0004Jz-I1; Fri, 14 Aug 2026 09:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wusDs-0004CL-Bk
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wusDq-0007qM-7f
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786715117;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIPfZ+sRcDaH16HKOD8A6dsnT4wotNu3C+J44t4zOcE=;
 b=Y+KlVy5HylA0xAztR5ImY+vqn5c1wTmj9KsU5JH9TxYMkL5x3w9EzR0dChxlrRTwkMVy42
 V26DkGvQ5mKyaFOEeX+n/UjLgFdqzG+pWYhMi0VhSQGfEHKqmPWdnvdUrTPfRdzRbSrXHT
 BjznoEpGGvrgvtvUxM2tgyaPFS/h5Yc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-PID5X942Nae7QR9aRjMLEQ-1; Fri, 14 Aug 2026 09:45:13 -0400
X-MC-Unique: PID5X942Nae7QR9aRjMLEQ-1
X-Mimecast-MFC-AGG-ID: PID5X942Nae7QR9aRjMLEQ_1786715112
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49554715277so8375905e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 06:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786715112; x=1787319912;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MIPfZ+sRcDaH16HKOD8A6dsnT4wotNu3C+J44t4zOcE=;
 b=X5XIAhwbN0u6U6Foqoxh4nVEBUIOm8uIfbwoUb+wHru8K1+75PVcp38LV8i4SW6IpM
 F+b2ypkhEskw9pNXuVjOVcg/YgXbdVsaJyhn9A53PnYx546ZPgXiLrFRRjZ0NlXT19Bz
 IgLz6HK+5dGt+gl8dEG2Vpvk0KoctMpEH8A2EP9o/ydSDYejOQ+o1Ajg0e4a4gu2Pt8+
 McFw2RLXY+M8JVYmiiIYcgv3VsFS4fO9ztKYjv/Vul+gtzbkpt9E6Jz2La+uwWOoQmVb
 jPVNf0X8+WGOQ2xnsCnKljYn7Q8ZM6BS1IoDil6/809X1DiC8QUjB5V9757QCkLPdWaE
 w2lw==
X-Gm-Message-State: AOJu0YwhRGW8YunA476WUJ693ZBe1v5nLMkVzKnG/v1+xcIB8TFsA3/X
 8iIZe8RFk7hNVD635xFOsByIpKepvLW2qRbzl710Dm0KJaj3B1hdOahBCArNoe5iF1f5NjS/065
 3sE+ImkBKoop3HUqt/ae57hFL78M9wFx5eYnRIEWC4WGvwiyRkRXkCm7x
X-Gm-Gg: AR+sD13Iy64m6rHCt9+8tGv3kM8xQsFEyiShHdaz3+xFj7WAh+O2yOww3tWHRucwehV
 qhkDzBN23SGbarXnONiv+t2OiOwK8V8RIwTFfbgc1qYCh3nbmdDxH57xB6f9YP96GvLbcCvPVgq
 zHa/0QMwGFPquexTCevKRzHIhgyCiUHeyYE4DWsRFCTZyKuhpyU3UIo4DPeii1ngG8raA0Y80cb
 YVKTSHouUSv08X3RmIAYxyD3ay9MxNDW/i3mUhe9pOOeIlYZNv9hhLYE0z4oFoZ4Z5ahxvdMKv/
 tWWf6kI24+JgFJM71Y+0YUrv+EKfwiSUfl1din04IkE6CHmH4ZR14gVjzObHe9ROVg+po2lbPBq
 Kc7LWkq0hrTTqN0my6i1pAIbe/SZJ9GwSHVEU1mbnft9hNIw1
X-Received: by 2002:a05:600c:6c4d:b0:496:c06b:9fb4 with SMTP id
 5b1f17b1804b1-4998799df10mr55589985e9.14.1786715111849; 
 Fri, 14 Aug 2026 06:45:11 -0700 (PDT)
X-Received: by 2002:a05:600c:6c4d:b0:496:c06b:9fb4 with SMTP id
 5b1f17b1804b1-4998799df10mr55589335e9.14.1786715111360; 
 Fri, 14 Aug 2026 06:45:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b25ad8sm45861625e9.2.2026.08.14.06.45.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 06:45:10 -0700 (PDT)
Message-ID: <8d9e5cef-526e-4d4f-86a2-d86bdaeabd34@redhat.com>
Date: Fri, 14 Aug 2026 15:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 02/19] scripts: bug fixes in
 update-aarch64-cpu-sysreg-properties
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Prerna Saxena <prerna.saxena@nutanix.com>
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
 <20260716213858.609699-3-khushit.shah@nutanix.com>
 <b839f20a-da50-493c-9b71-78069b62b867@redhat.com>
 <7B85F7CA-C4CB-4EAD-BCB1-6D2135934F5B@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <7B85F7CA-C4CB-4EAD-BCB1-6D2135934F5B@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/3/26 4:32 PM, Khushit Shah wrote:
>
>> On 20 Jul 2026, at 7:54 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>>
>>
>> On 7/16/26 11:38 PM, Khushit Shah wrote:
>>> - handle quoted bitstrings  and decimal
>>> - skip Values.ValueRange entries.
>> The above is the issue you reported on my v6. See my comment on the
>> other thread.
> Acked.
>>> - Emit unique RESx_{lsb} names for reserved fields so no two fields in
>>>  a register share a name.
>> The requirement for naming RES field needs to be explained. I understand
>> that now you expose all fields including those which are not writable it
>> may be required but at this stage I still fail why this is requested.
> I think we don’t need to expose RES fields to users. 
> I was thinking of case where a RES0 field is repurposed for
> something else, but that should be taken care by zeroing the
> ID regs array before initiating the named model hierarchy.
> (RES1 field in CTR_EL0 needs some handling).
I also think so. you can rely on AARCHMRS desc to identify the right
default values.
>
> On why we even need to expose non-writable fields:
> - Assume some non-writable field mismatches for the model and
>   host, why do we want to stop users from explicitly overriding
>   the model's field value to host value?

I agree this needs to be checked. However as I suggested I think you can
avoid exposing them to the end-users as props. You just need to read the
value from host and compare it with the value set in the named model. 
>
>>> - Emit a dummy 64-bit VAL field for registers with no defined fields,
>>>  such as AIDR_EL1 and REVIDR_EL1.
>> This is yet another functional change that could be separate.
> Acked, will do in v4.

Thanks

Eric
>
>> Thanks
>>
>> Eric
>>> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
>>> ---
>>> .../update-aarch64-cpu-sysreg-properties.py   | 67 +++++++++++++------
>>> 1 file changed, 45 insertions(+), 22 deletions(-)
>>> mode change 100644 => 100755 scripts/update-aarch64-cpu-sysreg-properties.py
>>>
>>> diff --git a/scripts/update-aarch64-cpu-sysreg-properties.py b/scripts/update-aarch64-cpu-sysreg-properties.py
>>> old mode 100644
>>> new mode 100755
>>> index 9e829fda2e..ecc35db528
>>> --- a/scripts/update-aarch64-cpu-sysreg-properties.py
>>> +++ b/scripts/update-aarch64-cpu-sysreg-properties.py
>>> @@ -106,6 +106,29 @@ def collect_fields(item, bit_offset=0):
>>>
>>>     return fields
>>>
>>> +def parse_value_int(raw_val):
>>> +    if raw_val is None or isinstance(raw_val, bool):
>>> +        return None
>>> +
>>> +    # may already be real number
>>> +    if isinstance(raw_val, int):
>>> +        return raw_val
>>> +
>>> +    raw_str = str(raw_val).strip()
>>> +
>>> +    if "'" in raw_str:
>>> +        # quoted bitstring like "'0100'"
>>> +        bits = raw_str.replace("'", "")
>>> +        try:
>>> +            return int(bits, 2)
>>> +        except ValueError:
>>> +            return None
>>> +
>>> +    # unquoted, try decimal
>>> +    try:
>>> +        return int(raw_str, 0)
>>> +    except ValueError:
>>> +        return None
>>>
>>> def extract_field_enums(field):
>>>     enums = []
>>> @@ -124,32 +147,23 @@ def extract_field_enums(field):
>>>     if not isinstance(val_entries, list):
>>>         return enums
>>>
>>> +    # A Values.ValueRange field specifies start and end value for a range.
>>> +    # Don't enumerate anything for them.
>>> +    for val_entry in val_entries:
>>> +        if isinstance(val_entry, dict) and \
>>> +           val_entry.get("_type") == "Values.ValueRange":
>>> +               return []
>>> +
>>>     for val_entry in val_entries:
>>>         if not isinstance(val_entry, dict):
>>>             continue
>>> -            
>>> +
>>>         if val_entry.get("_type") == "Values.Value":
>>> -            raw_val = val_entry.get("value")
>>> -            if raw_val is None:
>>> +            int_val = parse_value_int(val_entry.get("value"))
>>> +            if int_val is None:
>>>                 continue
>>> -                
>>> -            # some of the values have ' like "'0100'"
>>> -            raw_val_str = str(raw_val).strip().replace("'", "")
>>> -            
>>> -            try:
>>> -                # convert into bin 
>>> -                int_val = int(raw_val_str, 2)
>>> -            except ValueError:
>>> -                try:
>>> -                    # Fallback to dec if not bin
>>> -                    int_val = int(raw_val_str, 0)
>>> -                except ValueError:
>>> -                    continue
>>> -            
>>> -            enums.append({
>>> -                'value': int_val
>>> -            })
>>> -            
>>> +            enums.append({'value': int_val})
>>> +
>>>     return enums
>>>
>>> def generate_sysreg_properties_from_registers_json(id_reg_names, raw_json_path):
>>> @@ -210,7 +224,7 @@ def generate_sysreg_properties_from_registers_json(id_reg_names, raw_json_path):
>>>                        msb > current_fieldset_fields[unique_key]['msb']:
>>>                         enums = extract_field_enums(val)
>>>                         current_fieldset_fields[unique_key] = {
>>> -                            'raw_name': name,
>>> +                            'raw_name': unique_key,
>>>                             'lsb': lsb,
>>>                             'msb': msb,
>>>                             'width': width,
>>> @@ -238,6 +252,15 @@ def generate_sysreg_properties_from_registers_json(id_reg_names, raw_json_path):
>>>         # Sort decreasing lsbs
>>>         sorted_fields = sorted(unique_fields.items(),
>>>                                key=lambda x: x[1]['lsb'], reverse=True)
>>> +        if len(sorted_fields) == 0:
>>> +            # cases like REVIDR_EL1 and AIDR_EL1.
>>> +            # augment a dummy fields VAL.
>>> +            sorted_fields.append(('VAL', {
>>> +                'lsb': 0,
>>> +                'msb': 63,
>>> +                'width': 64,
>>> +                'enums': []
>>> +            }))
>>>
>>>         for unique_key, bits in sorted_fields:
>>>             enums_list = bits.get('enums', [])


