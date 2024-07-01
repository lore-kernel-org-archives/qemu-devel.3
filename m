Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A4DC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 20:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sONVT-0004dM-CQ; Mon, 01 Jul 2024 16:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sONVL-0004ce-9C
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:20:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sONVJ-0003HN-72
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:20:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4255fa23f7bso24441765e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719865199; x=1720469999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AR9qrNaWoWQK2s7XEXDWY9RmVsa4ook45PiyXKdO23E=;
 b=kqYi7syALal2mKwU8qOkdPI5XK+jC2rT+jugk6aObkBUnF8hhEsZ/9q5Lz7y3VvsuX
 CXXMeCA8mfaHnBk5KlgYKb6qlljZgFUdf79Fn03CP4mr+CkZp4LqtPosHqr1CQ9idIUX
 TPxnGpo5hP2J9Ks6akRQNJGOVmb1e2k4FaeRVtV/N2SGw+MfXUULPaO6K+jMabF3sbpk
 hUqzhOJfZQm4zAZYJAKwjM+hVVRGIkG06RJcOySmKax4eYkQhwks9N4wWR97ihm3ff7b
 Ks9luymaZH0ReALvFnXJSY6JHwBBWQ8d/TGbexZzySm6reLG/07uFhGqs/5Wi54lFK2R
 U8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719865199; x=1720469999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AR9qrNaWoWQK2s7XEXDWY9RmVsa4ook45PiyXKdO23E=;
 b=NiOphiAyBKK/Pm35EZaOphPiv88MH9UEevOmJyfKPJ33pQBJwgafJWBXHGVLbb6zTD
 NJxjK8WIXvpt4izSXHe22XaWcYtfG+AHjRId3TeECUBFd+PIwk1Wfc/1wUZ9NrBcsyPX
 QqlDC3UgR5FoinmbCKKwVM4vVo2eJ+hyRxlModzqvjjKdTAmawrhxghTjNpG86r7rahS
 3te8xfijmbpelFQi1KdVZQqedbGZsz1ZPx7yM9ofhO0hLYs14aruZhpiKEocvPfyMhaE
 Q8toHf3Tf9z30795Z73j/kW19KNA2yo3d/03NAnsewu+OgwW4cRMz2McAnyfRWIWUZwC
 YUcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYUZRwX2TUnbes2Jv4HG7owPOHV7hJ0wVhuzqTvb7yjJCsULE8ND2xK/qWUKbAkq3Yli5SD1R6AWE7GZAuIlZo7Y64MIU=
X-Gm-Message-State: AOJu0Yy5Ea4YDvmBGrCeYE5tLLGBwjNeSsnqEU9DtAsUxXnZruYL5tMi
 Xwcvmwy1UyNFt2bgy949cjA1uI53lB+JmmJv8uL4XfchetRm/nx7W2MHm7U9pNQ=
X-Google-Smtp-Source: AGHT+IEWKhxnFseU3x9YEclWlrbkhNhcLGfBZYH+qm+qqBrgN4j0h2sXqPRroSAIqcPSKxOzpDEJaA==
X-Received: by 2002:a05:6000:1045:b0:367:13a:5276 with SMTP id
 ffacd0b85a97d-367756ad617mr4468152f8f.20.1719865199160; 
 Mon, 01 Jul 2024 13:19:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb97esm10993410f8f.89.2024.07.01.13.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 13:19:58 -0700 (PDT)
Message-ID: <4c9f7f51-83ee-421a-8690-9af2e80b134b@linaro.org>
Date: Mon, 1 Jul 2024 22:19:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 18/98] hw/sd/sdcard: Introduce sd_cmd_to_sendingdata
 and sd_generic_read_byte
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 Luc Michel <luc.michel@amd.com>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-19-philmd@linaro.org>
 <1e5806db-d4e6-410f-b856-53c6a3f62999@kaod.org>
 <8d6d673e-2b89-42be-bfa7-aa3678fd697d@linaro.org>
 <6af8fd8d-9724-4c4f-9956-c19ff463d3c5@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6af8fd8d-9724-4c4f-9956-c19ff463d3c5@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 1/7/24 18:54, Cédric Le Goater wrote:
> On 7/1/24 6:40 PM, Philippe Mathieu-Daudé wrote:
>> On 28/6/24 09:44, Cédric Le Goater wrote:
>>> On 6/28/24 9:00 AM, Philippe Mathieu-Daudé wrote:
>>>> All commands switching from TRANSFER state to (sending)DATA
>>>> do the same: send stream of data on the DAT lines. Instead
>>>> of duplicating the same code many times, introduce 2 helpers:
>>>> - sd_cmd_to_sendingdata() on the I/O line setup the data to
>>>>    be transferred,
>>>> - sd_generic_read_byte() on the DAT lines to fetch the data.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   hw/sd/sd.c | 39 +++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 39 insertions(+)

>>> Shouldn't we check for buffer overrun ? sizeof(sd->data)
>>
>> OK if I squash this?
>>
>> -- >8 --
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index d292e0adb5..f2d069c2da 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -1123,7 +1123,7 @@ static sd_rsp_type_t 
>> sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
>>       sd->data_start = start;
>>       sd->data_offset = 0;
>>       if (data) {
>> -        assert(size);
>> +        assert(size > 0 && size <= sizeof(sd->data));
>>           memcpy(sd->data, data, size);
>>       }
>> ---
> 
> sure.

Great. Can I get your R-b tag? The final patch is:

-- >8 --
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Thu Jun 13 16:21:12 2024 +0200

     hw/sd/sdcard: Introduce sd_cmd_to_sendingdata and sd_generic_read_byte

     All commands switching from TRANSFER state to (sending)DATA
     do the same: send stream of data on the DAT lines. Instead
     of duplicating the same code many times, introduce 2 helpers:
     - sd_cmd_to_sendingdata() on the I/O line setup the data to
       be transferred,
     - sd_generic_read_byte() on the DAT lines to fetch the data.

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 18bb2f9fd8..60235d3898 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -143,4 +143,6 @@ struct SDState {
      uint32_t blk_written;
+
      uint64_t data_start;
      uint32_t data_offset;
+    size_t data_size;
      uint8_t data[512];
@@ -1080,2 +1082,25 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState 
*sd, SDRequest req)

+/* Configure fields for following sd_generic_read_byte() calls */
+__attribute__((unused))
+static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
+                                           uint64_t start,
+                                           const void *data, size_t size)
+{
+    if (sd->state != sd_transfer_state) {
+        sd_invalid_state_for_cmd(sd, req);
+    }
+
+    sd->state = sd_sendingdata_state;
+    sd->data_start = start;
+    sd->data_offset = 0;
+    if (data) {
+        assert(size > 0 && size <= sizeof(sd->data));
+        memcpy(sd->data, data, size);
+    }
+    if (size) {
+        sd->data_size = size;
+    }
+    return sd_r1;
+}
+
  /* CMD0 */
@@ -1914,2 +1939,16 @@ send_response:

+/* Return true when buffer is consumed. Configured by 
sd_cmd_to_sendingdata() */
+__attribute__((unused))
+static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
+{
+    *value = sd->data[sd->data_offset];
+
+    if (++sd->data_offset >= sd->data_size) {
+        sd->state = sd_transfer_state;
+        return true;
+    }
+
+    return false;
+}
+
  void sd_write_byte(SDState *sd, uint8_t value)
---


