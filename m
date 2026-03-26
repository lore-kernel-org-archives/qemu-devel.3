Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5956410A62F9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 14:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ltG-0007rN-Hm; Thu, 26 Mar 2026 10:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1w5ltE-0007rC-To
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:40:53 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1w5ltC-00037E-BT
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:40:52 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 625F93F620
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1774536048;
 bh=aVeLRD6bSpyTFQYba6djbj0AzTU7073yz5Sc7AnUARA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=P8Ch/LgtTUVNtG6M1gtIofX6N6dSneLK8CFGvthNDC/S3SeNTQ5YQPdcM4h1VzPiz
 Ob11r3js6ooTNV771JKEFds9jKNtRn5UVUMcDFNfbpoQydn7fqqEZr4ZukSbILLleV
 150x+7c6hfBIfh+aSs3FmaXOlE0G6mxpeD7dXlyI5T/Y2paluMW5nRWw0XkPaNXIWY
 nJShT8uMFo6t8HB52wL+IL5H9u43q4DVwPK5CaYp54Iyd/k2NpgWsnSRWESLqawb7I
 edWCvHGJdI658sxLfSNVIQKjYzLp/iImY7L6FwIi33UL42vvJ8riWqAyNXvLnwTBMm
 6XwwIVVOh4JRbe3lH1Rvmee2YYvAZDu4nYOKz1+UWUc2q/qMl2AaoawkTMVMV/Xl0U
 z5Cbeyr5pYz6FOiYje5P+DJsey2RZ8sqG5tj6BGRIsAAZww+wlZj1/ZBzk4j5KIDUT
 rZRhjy1DZrHQzH+0tieuSkHHq9XYmIJdBJqdTRT1BR2Rr/nnxiZJ3xe6AP9qidONGy
 JR8qZc2Ta7Y6Q4dVGxNj32hQxJxq3bQbXs32SynowuB6R8hCxJXUAun2t0djnBIjjK
 xYgTqa4zoorcmtOhBfpZz5w3bRj/KSLSm1+SYnI9mgBOPFolKLSjR2BRd7oUmu4bET
 F7tK0J/lgsgSyrgTPoBMudgw=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48535f4d5e1so14337885e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 07:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774536048; x=1775140848;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aVeLRD6bSpyTFQYba6djbj0AzTU7073yz5Sc7AnUARA=;
 b=PXyiFse0QktqMF+BnQc4xgnPZPBCYY8dMjj09lHsi3iEXL6bFXu2Sd7nM0Vcl63S7q
 oL2bt0CrEcBdjL+7+KxiK39sJUBtHvsYW82JCFf/HOJ7UE2mBRkx94RRR3mIqwcuwcWv
 fTwAuUiphiNZmAVWfLI8+h7NlydIckhiIpf1cRhCDsLge6UUC9zUoHbfIeNR736EG54H
 s8me13dO7lpP4SdTxDEgtpp6zYP074QszfdUMsJdpM0HRQZSWQZzEt1zP34noNLqF7St
 nKKM2rhMZvf0uRofMpk5h94vfxjACLQjHYZ7whYW/mSkFG6cpIvgo1SG8j0ANN8Eq2Zz
 0oGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMGwbQWmq/KPME+0t2p3cpnVkoIA51WXiriRAR/GV5bVhy5GipcT59sMArAjrGvbEwQ9vRQBPu2NeC@nongnu.org
X-Gm-Message-State: AOJu0YwJGmzR24SSsPj6X6Nuk0fYQlGjMo4rmcBRcEIlunxhk4dTIj+2
 iWrIyrfrVgwuyQXEy1QXCO3uSLGcNXuFgj4HFReRQc2NHOifvEjUobEEts1Vz0VNBjLupgCVJbF
 tZ90hGDaRE7X4hjEkt9c7LehLJiz9NZkmHhkrJHErseQfCy0wzRlt+98WVkev9mK2H4tVsvZc
X-Gm-Gg: ATEYQzyhfpqp0x3DL/+zfrkkvB42Q4lp1p6b8h9Z0+eWODkKjT6RrSZwWK64sg0NuCh
 912oQoaADZC40P4Izyayo4deMadZAcMulJRj1desy1KerM9ZT+iS8CoYBEk7KYOajd4AQJcHeuM
 DNVysKumowBTZb7Y3/USJvKJ6EGWhFyDjqlbDnvZOlKhqfrRJbXN/3CF1fjGg3fmq9PpAZqyGcD
 GMZ+5sDGcGoT8nLS7H+pKppxus3z99nqvEZKNBhht1bAO7ybHAAzfvER/x4ktmmiKBw5XsGlTnJ
 APA7i/WznRzs4tWW+pnCpcl2oBvPnhZo8zhCNbDTHIEiMr1aUr2TsIIQEIY9q8UJ1mSjtwA4eRj
 ruU0jILHb8txjmEHQbpqmdhq2xyGpGign5Jodfcu64PGp/EXctFEj0lIk5DZJdiawDTPGJUbuu7
 xkrX+RmjqUXx5jKJxJabHilFw9AFF6DwTWQa+m6wNQGdHUUnkb0c4=
X-Received: by 2002:a05:600c:3b12:b0:485:363b:fafe with SMTP id
 5b1f17b1804b1-48715fc37f7mr118007475e9.1.1774536047847; 
 Thu, 26 Mar 2026 07:40:47 -0700 (PDT)
X-Received: by 2002:a05:600c:3b12:b0:485:363b:fafe with SMTP id
 5b1f17b1804b1-48715fc37f7mr118006935e9.1.1774536047429; 
 Thu, 26 Mar 2026 07:40:47 -0700 (PDT)
Received: from [192.168.103.137]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487208b206dsm55435895e9.1.2026.03.26.07.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 07:40:46 -0700 (PDT)
Message-ID: <eba3e18f-9dad-4f53-ac1b-47b625778062@canonical.com>
Date: Thu, 26 Mar 2026 15:40:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/acpi: correct field sequence in SPCR table
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, Ani Sinha
 <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260326121947.51200-1-heinrich.schuchardt@canonical.com>
 <20260326093653-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260326093653-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 3/26/26 14:41, Michael S. Tsirkin wrote:
> the fix is correct, thanks!
> something more to improve:
> 
> 
> On Thu, Mar 26, 2026 at 01:19:47PM +0100, Heinrich Schuchardt wrote:
>> On LoongArch and RISC-V invalid SPCR tables are created:
>>
>> Terrminal Type : 00
>> Language : 03
>>
>> The correct values are:
>>
>> Terrminal Type : 03
>> Language : 00
>>
>> This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
>> SPCR creation to common location") that swapped the fields.
>>
>> See the specification of the table in
>> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table
> 
> should mention revision you are consulting.

Revision 1.10 is the only version that is published at this site. But we 
do not adhere to one specific revision. See below.

The bug exists for any revision from 1.00 to today's 1.10.

According to the revision history version 0.95 removed language codes.
Version 1.0 
(https://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/SPCR_Tbl-v100.doc) 
called the language field "Reserved, must be 0".
The sequence of the two fields considered in this patch did not change 
since then.

> 
>>
>> Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> 
> BTW I think the link to the spec should move to build_spcr.
> 
> And also:
> /*
>   * Serial Port Console Redirection Table (SPCR)
>   * Rev: 1.07
>   */
> 
> is probably wrong:
> 1.07	Fixed incorrect description in Stop Bits field. Undo accidental removal of Flow Control field. Edited formatting.
> 
> it's likely not the earliest version we adhere to.

The revision level differs between LoongArch, ARM, and RISC-V in our 
code for no obvious reason.

The LoongArch and the ARM code call build_spcr() with rev = 2 which 
implies specification revision <= 1.07. This matches the code comment.

The RISC-V code calls build_spcr() with rev = 4 which implies 
specification revision >= 1.09. We mention 1.10 in a comment.

Best regards

Heinrich

> 
> 
>> ---
>>   hw/acpi/aml-build.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 4b37405088..a999320e61 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -2115,10 +2115,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
>>       build_append_int_noprefix(table_data, f->stop_bits, 1);
>>       /* Flow Control */
>>       build_append_int_noprefix(table_data, f->flow_control, 1);
>> -    /* Language */
>> -    build_append_int_noprefix(table_data, f->language, 1);
>>       /* Terminal Type */
>>       build_append_int_noprefix(table_data, f->terminal_type, 1);
>> +    /* Language */
>> +    build_append_int_noprefix(table_data, f->language, 1);
>>       /* PCI Device ID  */
>>       build_append_int_noprefix(table_data, f->pci_device_id, 2);
>>       /* PCI Vendor ID */
>> -- 
>> 2.53.0
> 


