Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E23FC27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 22:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHWbW-0000hF-In; Wed, 12 Jun 2024 18:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHWbV-0000h5-G2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 18:38:05 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHWbT-0006LU-L3
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 18:38:05 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-35f1c209893so493806f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 15:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718231882; x=1718836682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xAcyqPEYHlPkD9zDogzw4s7gYXegrSSnSVOG5I06OGY=;
 b=vvaub7v8CmGEIs6Q4Kbp4zBnWo6x0eljLarDNRrc/XUBcAiuc4uvfcFpUTc59JzCxs
 qPyud6WEMYqXQwVgIdzndJymNo7QTar2LqZqnjUS3QaxC2x1sUcyZ1E9f0vchDLPpUN8
 uxQpmwi6h2lyKSqjynoEqQMROv4lAQfEz3TTK7Gvrm/l7Fj0imeft+M7wfpP28ByeUXx
 ELSLkTTw9dY63+mQEcoGfy436dnEmVMcWVAgIAcRThOoVpwHQ63M/LoqPRzQoFNkI4YP
 3J52PerqjwEo4mD9mgfaT9IOW2eN8obIW1fT6kHgv8gfN65OLkH4xca3mNcOnKoDNryc
 kr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718231882; x=1718836682;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xAcyqPEYHlPkD9zDogzw4s7gYXegrSSnSVOG5I06OGY=;
 b=cIiB3+xQFKqA643bhdPuxUYgiYVSDlg0TrjLMVhnC8GU3Eg7rklpKh/1bcJsb3Adk6
 X2+55BEddL/R2pIAupWw6fRK3z2uoZHR1/Y2sYJalnWuphM4WHv1qugkPQphPJoAUfkp
 frlJWQqeN8PDhERcHXRj2YC9YyUD28uiAsu3n1dcLDPRlc4Hl9vT7N7hBNjSEKPRrmHf
 /vQhV2N4EkPd++4v/pAadZ/MNt0EFi5UmzzuuTdvfTKvo/nNFbbV9iI0aCOK7kDhHX9R
 N7OWEMjFhanXT1XpBoA+UuYEH2x8ed/OLu7YXvmH0L0cIFOihkPkXGwbFXYmS7TQ1Ul6
 XXbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBNowkM6Y35t+HcdDLmS/ARLg5Rh6GvtsdRCBZjynJF47ScYnGU+zs/FjOQ9sR+WZ7QYCMAhvBymH2N2a5TWzpYkW0eZE=
X-Gm-Message-State: AOJu0Ywr3Dg4Ig4Ra45nUpT8Au3wDFXdORZNTznQ7tiUCwd4urkq0pKK
 8+8lbYziPaXqRF++cMu4bJMJYLHDfdfoGOsO/LtQ9/BHUXwHw60ytOIBWRuNxEA=
X-Google-Smtp-Source: AGHT+IGR1NJqbOlLAV4hUDOtULG3k7tLh6HqzCjKFThuC3Zk9qHwKjRURGU9JN426dLCp2UlZcG2+g==
X-Received: by 2002:adf:dd8f:0:b0:35f:2b27:232f with SMTP id
 ffacd0b85a97d-35fe89269d5mr2431497f8f.54.1718231881760; 
 Wed, 12 Jun 2024 15:38:01 -0700 (PDT)
Received: from [192.168.69.100] (sta21-h02-176-184-21-30.dsl.sta.abo.bbox.fr.
 [176.184.21.30]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750ad1absm27284f8f.62.2024.06.12.15.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 15:38:01 -0700 (PDT)
Message-ID: <d28958bf-e2f3-46f3-b6fe-dad7adb1b380@linaro.org>
Date: Thu, 13 Jun 2024 00:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/32] hw/sd: Add CMD21 tuning sequence
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-21-clg@kaod.org>
 <9962c6af-e72d-427b-b3af-5faf0447dae1@linaro.org>
Content-Language: en-US
In-Reply-To: <9962c6af-e72d-427b-b3af-5faf0447dae1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 13/6/24 00:15, Philippe Mathieu-Daudé wrote:
> On 3/7/23 15:24, Cédric Le Goater wrote:
>> From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>>
>> MMC cards support different tuning sequence for entering HS200 mode.
>>
>> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>> [ clg: - ported on QEMU 7.0 ]
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/sd/sd.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 4b4a4cda2e68..7332f7a18435 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -2017,6 +2017,30 @@ static const uint8_t 
>> sd_tuning_block_pattern[SD_TUNING_BLOCK_SIZE] = {
>>       0xbb, 0xff, 0xf7, 0xff,         0xf7, 0x7f, 0x7b, 0xde,
>>   };
>> +#define EXCSD_BUS_WIDTH_OFFSET 183
>> +#define BUS_WIDTH_8_MASK    0x4
>> +#define BUS_WIDTH_4_MASK    0x2
>> +#define MMC_TUNING_BLOCK_SIZE   128
>> +
>> +static const uint8_t mmc_tuning_block_pattern[128] = {
>> +       0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00,
>> +       0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc, 0xcc,
>> +       0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff, 0xff,
>> +       0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee, 0xff,
>> +       0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd, 0xdd,
>> +       0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff, 0xbb,
>> +       0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff, 0xff,
>> +       0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee, 0xff,
>> +       0xff, 0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00,
>> +       0x00, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc,
>> +       0xcc, 0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff,
>> +       0xff, 0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee,
>> +       0xff, 0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd,
>> +       0xdd, 0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff,
>> +       0xbb, 0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff,
>> +       0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
>> +};
>> +
>>   uint8_t sd_read_byte(SDState *sd)
>>   {
>>       /* TODO: Append CRCs */
>> @@ -2103,6 +2127,22 @@ uint8_t sd_read_byte(SDState *sd)
>>           ret = sd_tuning_block_pattern[sd->data_offset++];
>>           break;
>> +    case 21:    /* CMD21: SEND_TUNING_BLOCK (MMC) */
> 
> This can be accessed in SPI/SD modes, should we check for eMMC then?

This could do:

-- >8 --
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3c12ba2ad3..5bad19c766 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -160,12 +160,18 @@ static const struct SDProto *sd_proto(SDState *sd)
  }

  static const SDProto sd_proto_spi;
+static const SDProto sd_proto_emmc;

  static bool sd_is_spi(SDState *sd)
  {
      return sd_proto(sd) == &sd_proto_spi;
  }

+static bool sd_is_emmc(SDState *sd)
+{
+    return sd_proto(sd) == &sd_proto_emmc;
+}
+
  static const char *sd_version_str(enum SDPhySpecificationVersion version)
  {
      static const char *sdphy_version[] = {
@@ -2389,7 +2395,9 @@ uint8_t sd_read_byte(SDState *sd)
          break;

      case 21:    /* CMD21: SEND_TUNING_BLOCK (MMC) */
+        if (!sd_is_emmc(sd)) {
+            return 0x00;
+        }
          if (sd->data_offset >= MMC_TUNING_BLOCK_SIZE - 1) {
              sd->state = sd_transfer_state;
          }
---

> Similarly, other cases previous eMMC introduction only expect SPI/SD
> but don't check for it. I need to think a bit more on how to handle
> that.
> 
>> +        if (sd->data_offset >= MMC_TUNING_BLOCK_SIZE - 1) {
>> +            sd->state = sd_transfer_state;
>> +        }
>> +        if (sd->ext_csd[EXCSD_BUS_WIDTH_OFFSET] & BUS_WIDTH_8_MASK) {
>> +            ret = mmc_tuning_block_pattern[sd->data_offset++];
>> +        } else {
>> +            /*
>> +             * Return LSB Nibbles of two byte from the 8bit tuning
>> +             * block for 4bit mode
>> +             */
>> +            ret = mmc_tuning_block_pattern[sd->data_offset++] & 0x0F;
>> +            ret |= (mmc_tuning_block_pattern[sd->data_offset++] & 
>> 0x0F) << 4;
>> +        }
>> +        break;
>> +
>>       case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
>>           ret = sd->data[sd->data_offset ++];
> 


