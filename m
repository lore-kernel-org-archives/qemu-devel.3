Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1603DC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 10:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEyd-0004Ki-EK; Thu, 20 Jun 2024 06:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKEyc-0004KQ-Dj
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 06:25:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKEyX-0002ja-D1
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 06:25:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42179dafd6bso11483345e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718879102; x=1719483902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bHf/wo4DLJ43wcn/eqL+pUng4AaFD84YcWmBRC59BCA=;
 b=grjaXgtSZQuiAbwlbutGssay6wslX/RWg40kZyuNh4+PXhTqj/xmsDIjKhc9g+I0lE
 9vKQfQmfq8RchZW7RPoIOHYTVaoJCJ9j8gc9yDdF06WC1+rp+PW7DLmycz5LdKFRj8yU
 fkTciW9H4ilTHNRZUT6ptzBxy3Yv7TBBogEvnG4Zt4mr1ocNvmAvA+AP5YqHTnfCoVFn
 xp4s69WtD3p7oSeOifnWNXz2UA5ErQ5Hi6vwsIZnS8jvvootSrg1yjikHWXQg2EWLNO4
 ZShwKSd0OmZnZjzt6OhPkO+MCbr9Nnug1BQRqP4MG0WRZv535T7XeGCKvJagFYda1nwC
 bbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718879102; x=1719483902;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bHf/wo4DLJ43wcn/eqL+pUng4AaFD84YcWmBRC59BCA=;
 b=gIkLNIyskdEKblgRYhnTy4tTU+7qFWJZw0ACEsmh1gLxL8wn5/n9YzLLUNNiq4BpJu
 hpERVafVz7PhM/16bjOV+VW1OSDh2m7ubZPEFm5jBMxDz0FDx9462FM/CSa/UzHdHg9s
 qr109hjpG0MkAlC3COeuei9rkhaQ/pr2722AHZAvh/8RnodHQZTR/rE5usy1EB8noP5k
 Vnk8V1tU5z9h9OFeiKVN/Py/CG5+Hqb4kRVPeIzHv+nx6oqqPnvYk5Y0wsCdU9OVmvId
 1HZ75vaWizHLZK0YTfR9t/LQ1C5Z6hqkVDo1AVKMVUQfG7RnzcSUEFWnl4vAKxB0CKjK
 VFPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9xCPuxhT1I7UiHm3pIZipDcqpiJXGbi0/12F4cWI+CtkvuZHEL6ve1gIcwSTJLqDZ0j577HehXjAUqrqlFaVMTshGZI0=
X-Gm-Message-State: AOJu0YyRO2T0vaw8ltxb5V+dXyiquoTQE4KxGf3eGPtrxPiRczL5oaBd
 5HI/dCq4DsTta/Ev/+qTr6C++z4hIF+OiUrv6J4O0BkPTcn5/y4FLL7/zcaWwvk=
X-Google-Smtp-Source: AGHT+IFw3YA6IPMJxxjJlz+3FZxS3yIHWAjlyez0G+p99KLv5CeQuCtG8AppcrWwevLVhtrnlAkhOQ==
X-Received: by 2002:adf:ed0b:0:b0:362:70f6:697d with SMTP id
 ffacd0b85a97d-362ffb42a7emr5082860f8f.16.1718879101977; 
 Thu, 20 Jun 2024 03:25:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.40])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3638eb9c2b5sm3935201f8f.13.2024.06.20.03.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 03:25:01 -0700 (PDT)
Message-ID: <41f18234-2018-4447-9142-81355967701c@linaro.org>
Date: Thu, 20 Jun 2024 12:24:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/32] hw/sd: Add emmc_cmd_SEND_EXT_CSD() handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-23-clg@kaod.org>
 <59f1da17-719d-4389-b21a-053b2ee980dd@linaro.org>
 <54bc25fd-acea-44a3-b696-c261e7e9706d@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <54bc25fd-acea-44a3-b696-c261e7e9706d@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/6/24 09:23, Cédric Le Goater wrote:
> Hello
> 
> On 6/19/24 7:40 PM, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 3/7/23 15:24, Cédric Le Goater wrote:
>>> The parameters mimick a real 4GB eMMC, but it can be set to various
>>> sizes. Initially from Vincent Palatin <vpalatin@chromium.org>
>>>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>   hw/sd/sdmmc-internal.h |  97 ++++++++++++++++++++++++++++++++++++
>>>   include/hw/sd/sd.h     |   1 +
>>>   hw/sd/sd.c             | 109 ++++++++++++++++++++++++++++++++++++++++-
>>>   3 files changed, 206 insertions(+), 1 deletion(-)
>>
>> First pass review, this will take time...
>>
>>> +static void mmc_set_ext_csd(SDState *sd, uint64_t size)
>>> +{
>>> +    uint32_t sectcount = size >> HWBLOCK_SHIFT;
>>> +
>>> +    memset(sd->ext_csd, 0, sizeof(sd->ext_csd));
>>> +
>>> +    sd->ext_csd[EXT_CSD_S_CMD_SET] = 0x1; /* supported command sets */
>>> +    sd->ext_csd[EXT_CSD_HPI_FEATURES] = 0x3; /* HPI features  */
>>> +    sd->ext_csd[EXT_CSD_BKOPS_SUPPORT] = 0x1; /* Background 
>>> operations */
>>> +    sd->ext_csd[241] = 0xA; /* 1st initialization time after 
>>> partitioning */
>>> +    sd->ext_csd[EXT_CSD_TRIM_MULT] = 0x1; /* Trim multiplier */
>>> +    sd->ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT] = 0x15; /* Secure 
>>> feature */
>>
>> We do not support (and are not interested in) that. I'll use 0x0 for
>> "do not support".
>>
>>> +    sd->ext_csd[EXT_CSD_SEC_ERASE_MULT] = 0x96; /* Secure erase 
>>> support */
>>
>> This value is obsolete, so I'd use 0x0 to avoid confusions.
>>
>>> +    sd->ext_csd[EXT_CSD_SEC_TRIM_MULT] = 0x96; /* Secure TRIM 
>>> multiplier */
>>
>> Again, 0x0 for "not defined".
>>
>>> +    sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x7; /* Boot information */
>>> +    sd->ext_csd[EXT_CSD_BOOT_MULT] = 0x8; /* Boot partition size. 
>>> 128KB unit */
>>> +    sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x6; /* Access size */
>>
>> 16KB of super_page_size hmm. Simpler could be the underlying block
>> retrieved with bdrv_nb_sectors() or simply BDRV_SECTOR_SIZE (0x1).
>>
>>> +    sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x4; /* HC Erase unit 
>>> size */
>>
>> 2MB of erase size hmmm why not.
>>
>>> +    sd->ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] = 0x1; /* HC erase 
>>> timeout */
>>
>> We don't implement timeout, can we use 0?
>>
>>> +    sd->ext_csd[EXT_CSD_REL_WR_SEC_C] = 0x1; /* Reliable write 
>>> sector count */
>>> +    sd->ext_csd[EXT_CSD_HC_WP_GRP_SIZE] = 0x4; /* HC write protect 
>>> group size */
>>> +    sd->ext_csd[EXT_CSD_S_C_VCC] = 0x8; /* Sleep current VCC  */
>>> +    sd->ext_csd[EXT_CSD_S_C_VCCQ] = 0x7; /* Sleep current VCCQ */
>>> +    sd->ext_csd[EXT_CSD_S_A_TIMEOUT] = 0x11; /* Sleep/Awake timeout */
>>> +    sd->ext_csd[215] = (sectcount >> 24) & 0xff; /* Sector count */
>>> +    sd->ext_csd[214] = (sectcount >> 16) & 0xff; /* ... */
>>> +    sd->ext_csd[213] = (sectcount >> 8) & 0xff;  /* ... */
>>> +    sd->ext_csd[EXT_CSD_SEC_CNT] = (sectcount & 0xff);       /* ... */
>>> +    sd->ext_csd[210] = 0xa; /* Min write perf for 8bit@52Mhz */
>>> +    sd->ext_csd[209] = 0xa; /* Min read perf for 8bit@52Mhz  */
>>> +    sd->ext_csd[208] = 0xa; /* Min write perf for 4bit@52Mhz */
>>> +    sd->ext_csd[207] = 0xa; /* Min read perf for 4bit@52Mhz */
>>> +    sd->ext_csd[206] = 0xa; /* Min write perf for 4bit@26Mhz */
>>> +    sd->ext_csd[205] = 0xa; /* Min read perf for 4bit@26Mhz */
>>
>> Class B at 3MB/s. I suppose announcing up to J at 21MB/s is safe (0x46).
>>
>>> +    sd->ext_csd[EXT_CSD_PART_SWITCH_TIME] = 0x1;
>>
>> SWITCH command isn't implemented so far. We could use 0x0 for "not
>> defined".
>>
>>> +    sd->ext_csd[EXT_CSD_OUT_OF_INTERRUPT_TIME] = 0x1;
>>
>> Similarly, 0x0 for "undefined" is legal.
>>
>>> +    sd->ext_csd[EXT_CSD_CARD_TYPE] = 0x7;
>>
>> You anounce dual data rate. Could we just use High-Speed mode (0x3)
>> to ease modelling?
>>
>>> +    sd->ext_csd[EXT_CSD_STRUCTURE] = 0x2;
>>> +    sd->ext_csd[EXT_CSD_REV] = 0x5;
>>
>> This is Revision 1.5 (for MMC v4.41)... The first QEMU implementation
>> was based on Revision 1.3 (for MMC v4.3) and I'm seeing some features
>> from Revision 1.6 (for MMC v4.5)...
>>
>> Do we want to implement all of them? Since we are adding from
>> scratch, I suggest we directly start with v4.5 (0x6).
>>
>> Note, EXT_CSD_BUS_WIDTH is not set (0x0) meaning 1-bit data bus.
>> I'd set it to 0x2 (8-bit):
>>
>>         sd->ext_csd[EXT_CSD_BUS_WIDTH] = EXT_CSD_BUS_WIDTH_8_MASK;
> 
> 
> I applied the proposed changes from above and the rainier-bmc boots fine.
> Here are the mmc related logs :
> 
> 
>    U-Boot SPL 2019.04 (Jun 17 2024 - 07:49:13 +0000)
>    Trying to boot from MMC1
>    U-Boot 2019.04 (Jun 17 2024 - 07:49:13 +0000)
>    SOC: AST2600-A3
>    eMMC 2nd Boot (ABR): Enable, boot partition: 1
>    LPC Mode: SIO:Disable
>    Eth: MAC0: RMII/NCSI, MAC1: RMII/NCSI, MAC2: RMII/NCSI, MAC3: RMII/NCSI
>    Model: IBM P10 BMC
>    DRAM:  already initialized, 896 MiB (capacity:1024 MiB, VGA:64 MiB, 
> ECC:on, ECC size:896 MiB)
>    MMC:   emmc_slot0@100: 0
>    Loading Environment from MMC... OK
>    In:    serial@1e784000
>    Out:   serial@1e784000
>    Err:   serial@1e784000
>    Model: IBM P10 BMC
>    Net:   No MDIO found.
>    ftgmac100_probe - NCSI detected
>    ...
>    [    0.640650] mmc0: SDHCI controller on 1e750100.sdhci 
> [1e750100.sdhci] using ADMA
>    [    0.658402] mmc0: unspecified timeout for CMD6 - use generic
>    [    0.659014] mmc0: unspecified timeout for CMD6 - use generic
>    [    0.659314] mmc0: unspecified timeout for CMD6 - use generic
>    [    0.659722] mmc0: unspecified timeout for CMD6 - use generic
>    [    0.660740] mmc0: unspecified timeout for CMD6 - use generic
>    [    0.661139] mmc0: new high speed MMC card at address 0001
>    [    0.662825] mmcblk0: mmc0:0001 QEMU! 16.0 GiB
>    [    0.688329]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
>    [    0.692837] mmcblk0boot0: mmc0:0001 QEMU! 1.00 MiB
>    [    0.694416] mmcblk0boot1: mmc0:0001 QEMU! 1.00 MiB
>    [    0.695166] mmcblk0rpmb: mmc0:0001 QEMU! 128 KiB, chardev (243:0)
>    [    2.455427]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
>    [    7.624272] EXT4-fs (mmcblk0p4): orphan cleanup on readonly fs
>    [    7.624837] EXT4-fs (mmcblk0p4): mounted filesystem 
> 6f526507-e73b-4094-8f08-f310b5da5b3a ro with ordered data mode. Quota 
> mode: disabled.
>    [    8.024897] EXT4-fs (mmcblk0p6): mounted filesystem 
> 6dc9b0da-2b0f-4822-9eac-df4dd782ddfc r/w with ordered data mode. Quota 
> mode: disabled.
>    [   15.991016] EXT4-fs (mmcblk0p4): re-mounted 
> 6f526507-e73b-4094-8f08-f310b5da5b3a ro. Quota mode: disabled.
> 
> I think these initial values are fine to start with.

Great! Thank you for testing them :)

