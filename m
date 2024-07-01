Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC96EC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOK4e-0006iS-KM; Mon, 01 Jul 2024 12:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOK4d-0006i0-Fj
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:40:15 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOK4Y-00049o-SO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:40:15 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ec52fbb50aso38014311fa.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719852008; x=1720456808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/vppvP8skrgjJebq7oiDhjhYkIvm7ho28q3tdDR9vek=;
 b=ijPbXPdVnCuSGSNjF/Mb5d+OiAe/nv7nF/auKIqg90/wNjT/rUuFcF1wNNxh2nkUCM
 Ea5Gidx/ZGCcIq1Jwi3qL3vhqxYNaZtKtIwQmtNl3WM4qLXcRy1gu7ETPjuGnW5tcQn9
 P+JWF5bMbqvewkAyT20T3SF6P066AB6UkXMwIWLua2FnGTMf1ijMHw1EThT372F6Y+sC
 N8x5biW6WjXS+/hV0FhXjcaW+SdRmsCI+aP201Z8PGaEIHIkr7ECQVCxhcBAFCH0VLYo
 xz9/BJoVCNraVrKIgaEiBdZIfQeJfzn/zZB0LlTV0DdKHBk8uKASue/NdSMmzz5s+gmG
 1NzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719852008; x=1720456808;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/vppvP8skrgjJebq7oiDhjhYkIvm7ho28q3tdDR9vek=;
 b=Mi0wkm4RXd6p/ExyszfryV3QlCAH4uF5F02j5fRKWJribM4JeCfA0lMj3eLxkOrEdS
 kYgNmnt2+VBufXCQAC0DaFwAlOAVm1KMjTn6TvDCv8osStHefndxzOOs0IuFCz6JmoAq
 yJxIK43E80XYv8yWKli+5OLW3Vfqipk334AcIIHKVN76PwgeRpFysR6YZq6iGdSJ0yK9
 lijwb+cj+eoVH7C6f0SLgIhVLREa7fe7eBOVtIaG+2tuH4CKtSeEFDVb2Rl/9SHS09fP
 0NSseB4p5y6rkwFYOB5qnSFt13H/uQHx+4jyDXtgl5payDKUclACGdrv/+iQVIXDFawg
 +qwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1bkVMqRxgwnxIZY6bZKsqA2nbCpdkTqMLotQRYit40ndXQg3ZA+gwLGfPFQDHxKeN/msItGwFmkbvzekLG8wSVvrcd8E=
X-Gm-Message-State: AOJu0YxzZixOlXGBI5Qi+AlDbLf14WPrtfUtYWDtk2Lzw5r5+XirJOmc
 V6roSTM3vwv8ndJ6rXtAi92E0VEG7rqAaFuEe8F2t+UKXCzxebJgN9QkRxDcJko=
X-Google-Smtp-Source: AGHT+IFzDLpZIPcU5cPHxcdR6l/gmeihjo5CZsX/7ae6m1tJmHrXcIvD1s4gXwsF9FN1K39+ggJKTg==
X-Received: by 2002:a05:6512:3d86:b0:52c:e086:7953 with SMTP id
 2adb3069b0e04-52e8264df6amr4850802e87.4.1719852008311; 
 Mon, 01 Jul 2024 09:40:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b061eedsm154150045e9.26.2024.07.01.09.40.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 09:40:07 -0700 (PDT)
Message-ID: <8d6d673e-2b89-42be-bfa7-aa3678fd697d@linaro.org>
Date: Mon, 1 Jul 2024 18:40:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 18/98] hw/sd/sdcard: Introduce sd_cmd_to_sendingdata
 and sd_generic_read_byte
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 Luc Michel <luc.michel@amd.com>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-19-philmd@linaro.org>
 <1e5806db-d4e6-410f-b856-53c6a3f62999@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1e5806db-d4e6-410f-b856-53c6a3f62999@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

On 28/6/24 09:44, Cédric Le Goater wrote:
> On 6/28/24 9:00 AM, Philippe Mathieu-Daudé wrote:
>> All commands switching from TRANSFER state to (sending)DATA
>> do the same: send stream of data on the DAT lines. Instead
>> of duplicating the same code many times, introduce 2 helpers:
>> - sd_cmd_to_sendingdata() on the I/O line setup the data to
>>    be transferred,
>> - sd_generic_read_byte() on the DAT lines to fetch the data.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/sd/sd.c | 39 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index d85b2906f4..1a8d06804d 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -142,8 +142,10 @@ struct SDState {
>>        */
>>       bool expecting_acmd;
>>       uint32_t blk_written;
>> +
>>       uint64_t data_start;
>>       uint32_t data_offset;
>> +    size_t data_size;
>>       uint8_t data[512];
>>       uint8_t vendor_data[512];
>> @@ -1083,6 +1085,29 @@ static sd_rsp_type_t 
>> sd_cmd_unimplemented(SDState *sd, SDRequest req)
>>       return sd_illegal;
>>   }
>> +/* Configure fields for following sd_generic_read_byte() calls */
>> +__attribute__((unused))
>> +static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
>> +                                           uint64_t start,
>> +                                           const void *data, size_t 
>> size)
>> +{
>> +    if (sd->state != sd_transfer_state) {
>> +        sd_invalid_state_for_cmd(sd, req);
>> +    }
>> +
>> +    sd->state = sd_sendingdata_state;
>> +    sd->data_start = start;
>> +    sd->data_offset = 0;
>> +    if (data) {
>> +        assert(size);
> 
> Shouldn't we check for buffer overrun ? sizeof(sd->data)

OK if I squash this?

-- >8 --
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d292e0adb5..f2d069c2da 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1123,7 +1123,7 @@ static sd_rsp_type_t sd_cmd_to_sendingdata(SDState 
*sd, SDRequest req,
      sd->data_start = start;
      sd->data_offset = 0;
      if (data) {
-        assert(size);
+        assert(size > 0 && size <= sizeof(sd->data));
          memcpy(sd->data, data, size);
      }
---

> 
> Thanks,
> 
> C.
> 
> 
> 
>> +        memcpy(sd->data, data, size);
>> +    }
>> +    if (size) {
>> +        sd->data_size = size;
>> +    }
>> +    return sd_r1;
>> +}
>> +
>>   /* CMD0 */
>>   static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
>>   {
>> @@ -1920,6 +1945,20 @@ send_response:
>>       return rsplen;
>>   }
>> +/* Return true when buffer is consumed. Configured by 
>> sd_cmd_to_sendingdata() */
>> +__attribute__((unused))
>> +static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
>> +{
>> +    *value = sd->data[sd->data_offset];
>> +
>> +    if (++sd->data_offset >= sd->data_size) {
>> +        sd->state = sd_transfer_state;
>> +        return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>>   void sd_write_byte(SDState *sd, uint8_t value)
>>   {
>>       int i;
> 


