Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C79C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdUx-0006uQ-8x; Mon, 10 Mar 2025 09:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1trdUd-0006tO-J2
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1trdUb-0001lc-MI
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741614507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TPYPoqdKsAhoFrVEpoKBHHD+oewtOQ2llx0WU8MnTug=;
 b=DxqPaahGIi5cdfmaH1PC6C6Ru+yi1yvfaQ1NIPxA3PL5uRkWfXIrBcfY2aLRYqbuG3b6HS
 WNGGWfI1vJI3wJIRb23qTtpzscimhwwq/Czcr4yU7WwYbrBTHxtE+Mc9hZMjaz3Ena6g3/
 zymy918avRpd+InRFV7O7EaMXSsJZ3c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-sZEHfeBxMq2kDg-Dn7lohA-1; Mon, 10 Mar 2025 09:48:26 -0400
X-MC-Unique: sZEHfeBxMq2kDg-Dn7lohA-1
X-Mimecast-MFC-AGG-ID: sZEHfeBxMq2kDg-Dn7lohA_1741614505
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ceeaf1524so6956665e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 06:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741614504; x=1742219304;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TPYPoqdKsAhoFrVEpoKBHHD+oewtOQ2llx0WU8MnTug=;
 b=ot7g1v9BGnvNwsYdlPQDDuTngqHxpbiVFi9SYLhoOdWyyNucE28HQUxqFpuMUz6gS7
 27J971R0K0lWULVCmlyvSvWqZ1Sgo41ZteMLooHVi8OzuaLHk1yJi9Dp04cEojFHiJGr
 UAtgBmEBj2AkW7sQktkhA5RGrbhpG0dfa9NZvq88u4tX/PL/gUTyl86ruQ8uL4OZLHEr
 OHctjQVXuSTH6L/SbHtbhstL0UMzTONTc0MmEQFiFdrmE95ILs/VaKopT3lAdHq0WK6N
 q6zlZo/RI/Gub6GTkWg9FsvlZahj8dUIs3PG/84wRfMUa3aysrHnjKmvBsRyD90ucoZl
 80KA==
X-Gm-Message-State: AOJu0YyC2bN6XOCwOIDXeID0Pvb8gXrFgw03DHGOcA6vaIbEB2Rxc/1b
 JPMWjGJlUwqjUcmdNcQjqh7+Dt09SFpG3nvU6A9Buhxn/2xJb+k+HZotTf5P8zaZrMss/NK8NL0
 i3A1ADDcZj9BUwc60N2WOhvyrNT4JdVCfguAygnl9wq5fm0LmBsDI
X-Gm-Gg: ASbGncukgaQYGYzWz0nitOUNw8MJRVEsFlY8hljGMx72T70xvidrwoOvry/PL5DLbID
 NbP0cl1W4INTGdMfPeg3rnSIi8KcfZBwVJkEEttnCDqVmFQ5x+2FEtRIxCBDcBRUm+Wuz0wDzD/
 d9KEc3eWKsSYo4NNhP2yoG6GBvD2JXm+IRXAdMp494rBVUtCvPoiwmIe1fWCPnGot4C4anGN0Ew
 So6e4lxEw9iYRe/Wmu3PATADCYSBOAk3chuvqTJHD8UsP1ocoAA3GyD9zYPn7qsbLP82dDpyoTx
 4XH0ABqS//EDiF+aVdTqMrovNKmKDVswN7R9G4Utw9EhjWM=
X-Received: by 2002:a05:600c:3c82:b0:439:4c1e:d810 with SMTP id
 5b1f17b1804b1-43ce4ad68b1mr61326625e9.9.1741614504532; 
 Mon, 10 Mar 2025 06:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcwmLlnCsF+mPsJuuEZC3uo1DefheSwN35SOHe8bjg+nHi4CxyLn89yUv8fMn6nCYaUfsEAA==
X-Received: by 2002:a05:600c:3c82:b0:439:4c1e:d810 with SMTP id
 5b1f17b1804b1-43ce4ad68b1mr61326275e9.9.1741614504154; 
 Mon, 10 Mar 2025 06:48:24 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cefd99c48sm58997175e9.23.2025.03.10.06.48.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 06:48:23 -0700 (PDT)
Message-ID: <b6988de5-42ed-4e3f-ab39-921912e9be0c@redhat.com>
Date: Mon, 10 Mar 2025 14:48:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cpus: Introduce SysemuCPUOps::qmp_dump_skeys()
 callback
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250310133118.3881-1-philmd@linaro.org>
 <20250310133118.3881-3-philmd@linaro.org> <Z87s-Z0IM0613sbG@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z87s-Z0IM0613sbG@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 10/03/2025 14.45, Daniel P. Berrangé wrote:
> On Mon, Mar 10, 2025 at 02:31:17PM +0100, Philippe Mathieu-Daudé wrote:
>> Allow generic CPUs to dump the architecture storage keys.
>>
>> Being specific to s390x, it is only implemented there.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/core/sysemu-cpu-ops.h | 6 ++++++
>>   target/s390x/cpu-system.c        | 2 ++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
>> index 877892373f9..d3534cba65c 100644
>> --- a/include/hw/core/sysemu-cpu-ops.h
>> +++ b/include/hw/core/sysemu-cpu-ops.h
>> @@ -47,6 +47,12 @@ typedef struct SysemuCPUOps {
>>        *       a memory access with the specified memory transaction attributes.
>>        */
>>       int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
>> +
>> +    /**
>> +     * @qmp_dump_skeys: Callback to dump guest's storage keys to @filename.
>> +     */
>> +    void (*qmp_dump_skeys)(const char *filename, Error **errp);
> 
> Is it right to hook this onto the CPU object ? In the next patch
> the code arbitrarily picks the 1st CPU and adds a "FIXME" annotation,
> but the actual impl of dump code doesn't seem to be tied to any CPU
> object at all, it is getting what looks like a global singleton
> object holding the keys.
> 
> IOW, should this hook be against the machine type instead, if it
> is dumping global state, not tied to a specific CPU ?

Hmm, you've got a point - the storage keys are part of the memory, not of 
the CPU, so they might rather belong to the machine instead, indeed.

  Thomas


