Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5C0C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 15:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tacDY-0000WL-CI; Wed, 22 Jan 2025 10:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tacDU-0000V0-T2
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:00:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tacDO-0008Fx-Lb
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737558021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=POlz4POCIL9jNnb+niuB0G+X/RMlLL8vO4VLJU7O3JY=;
 b=MgTTmF+cg60kcCaBFU6vLu0SpqSHngI58plH7wG5O4d9JEZFOs6TS6foTNXPRwgGz0OWhj
 r2fZpTHyd7BFRna4JkoVMV8QZb345s3eh47bzx7rvmrzhmNgn5SszBvCq4LpjdHzHqSr6o
 UG9urZrmSLtydwR6O1jC4srQXCdySTM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-WmRayQBaPrKcuTRartYh4Q-1; Wed, 22 Jan 2025 10:00:19 -0500
X-MC-Unique: WmRayQBaPrKcuTRartYh4Q-1
X-Mimecast-MFC-AGG-ID: WmRayQBaPrKcuTRartYh4Q
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa689b88293so730160866b.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 07:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737558018; x=1738162818;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=POlz4POCIL9jNnb+niuB0G+X/RMlLL8vO4VLJU7O3JY=;
 b=T3OgNj/jvdT0vRLsl7drXIVoG5XxKcj3OfCKJk5N7q8siAV6Za2dnCyzIqrCMnUSTD
 MMOihVTxIJ/rmQnLd3l3KWrmhW88qxyv5vDYt7z8r6O5rzxukiFshOdXtrncDWs2SSJY
 PuRpsR/8LGUHX/iKRwW2RoJ8HmQ1jqWtqwZyh5i3KxJOAo2lHKjugTxWlLzjOdsazkSr
 91ZVmhuW7Wy5HA4QGFIguW0OG0m0iQCuaPhVqsaAFcFnokJ0jdccfh0wroYkj8nyBgn6
 3woVtY3S9Dsdwp9bqXR506wvlst5SXhBqJGk/1WBxKeNcGPLr1nRrMtHUeeoClK/47Jt
 FJuQ==
X-Gm-Message-State: AOJu0YxG7rBvpkLP3qXwxnC4nxkcxwEMU31lT61Z1hKlGBR8Uj60sh16
 rZSlYF2tDx6zXCFitVesil//reWicNmx9CIzB8+amVp26r6i+Ra+NhcPcbNqkw7uMAbDq7xh0QD
 DFZULYyBDKUJUgBi3nqxVX5S6pP/joLuCMemHaCeodwlxcpwd2hup
X-Gm-Gg: ASbGncujLSul17N/saysfI4tjfM+d5KKE1S74vKi4BVR1zsHmV6eeP41kZ7jiimtlqt
 kWvGFps66Fy26LO2sqPRM86hLzL6xcwAuUCzHC2bPpQu5jfYTLUmk27ln2KruM34NQT+RGVj/DP
 gh97kddcfiBZwGCFeZTx5tu0LzvMEDQ6zdgGPrKx7aRahQZlbPBIoyV201ZTZS9dATqZCdlhU+y
 hIW18SC5Fu3aeUYmdV+ujfTzBpjgCuJcWU8qdNn63fXJnOsIvNKRNHF0FOH4e1JGDjWWzMzcAU=
X-Received: by 2002:a17:907:6d09:b0:aa6:8935:ae71 with SMTP id
 a640c23a62f3a-ab38b0b7f21mr2005327166b.12.1737558018019; 
 Wed, 22 Jan 2025 07:00:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN1t+NlFl7VeBM57UE85R9UjvwoSv7A2Q+GbNoK+wbwwUtjlEh37HaE0sPoxQ5GMW97o+PZg==
X-Received: by 2002:a17:907:6d09:b0:aa6:8935:ae71 with SMTP id
 a640c23a62f3a-ab38b0b7f21mr2005315566b.12.1737558016617; 
 Wed, 22 Jan 2025 07:00:16 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ab384c607aesm914089266b.23.2025.01.22.07.00.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 07:00:13 -0800 (PST)
Message-ID: <6d7ad183-6685-4ba6-a8ef-d899162879ea@redhat.com>
Date: Wed, 22 Jan 2025 16:00:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] rust: pl011: extract conversion to RegisterOffset
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-4-pbonzini@redhat.com> <Z5EB3b0VqvqxUaWm@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z5EB3b0VqvqxUaWm@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/22/25 15:34, Zhao Liu wrote:
> On Fri, Jan 17, 2025 at 10:26:50AM +0100, Paolo Bonzini wrote:
>> Date: Fri, 17 Jan 2025 10:26:50 +0100
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> Subject: [PATCH 03/10] rust: pl011: extract conversion to RegisterOffset
>> X-Mailer: git-send-email 2.47.1
>>
>> As an added bonus, this also makes the new function return u32 instead
>> of u64, thus factoring some casts into a single place.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   rust/hw/char/pl011/src/device.rs | 114 +++++++++++++++++--------------
>>   1 file changed, 63 insertions(+), 51 deletions(-)
> 
> [snip]
> 
>> -    pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u64, u64> {
>> +    fn regs_read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
>>           use RegisterOffset::*;
> 
> Can we move this "use" to the start of the file?

I don't think it's a good idea to make the register names visible 
globally...  "use Enum::*" before a match statement is relatively 
common.  For example: https://doc.rust-lang.org/src/std/io/error.rs.html#436

>> +        std::ops::ControlFlow::Break(match offset {
> 
> std::ops can be omitted now.

Done, add added a patch to get rid of ControlFlow completely.

>> -            Ok(RSR) => {
>> -                self.receive_status_error_clear.reset();
>> +            RSR => {
>> +                self.receive_status_error_clear = 0.into();
> 
> Emm, why do we use 0.into() instead of reset() here? It looks they're
> same.

Fixed.

>> +    pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
> 
> Maybe pub(crate)? But both are fine for me :-)

The struct is not public outside the crate, so it doesn't make a 
difference, does it?

> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thanks, I'll post a quick v2 anyway once you've finished reviewing.

Paolo


