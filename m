Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674F7CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwDs-0005cn-Q8; Fri, 31 Oct 2025 16:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwDq-0005ce-A6
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 16:59:46 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwDm-0007Jn-5F
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 16:59:45 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-429bcddad32so1138625f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 13:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761944378; x=1762549178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LUryjflOUZXkXwvlMvxUa6zvEky4v5mnX1iFHy5dTt4=;
 b=rn4mjcjJeozEk8iSjbW236Ugvrhg9zVc7r9jVOktEWKsAmaGdYZJeft0bcHy86MkMW
 9WbVgi5h+vKPLRceZnq2H3czBjlPafAvb4rumpaMH1EsJtRN/5dDESHTc07Q43Y6BtTa
 EBDKeObAB/A0TFfpgOJjn1WmoWhqEGgZr6JMydO4YGtuOs+MR/KVrcMbco9h7v+PyZnK
 DQHKjSuzwtqotdZnW6m819ZWYEMub68rc3f+7lr8Yk7kbbuUg0kaBaTz9hVdhzSyhzUW
 d3yafAQ6CHnMF72MqwNWzvcYmlpljDxh+AtsmA09RWjmKhvgwxAUOWdQoRwYIMcWPQrH
 g/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761944378; x=1762549178;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LUryjflOUZXkXwvlMvxUa6zvEky4v5mnX1iFHy5dTt4=;
 b=BAPMgnoQXvHNqcuVJqYoG9HejEFTK0yuqdZTz/reqrrCjg2ExOICuR//HJMfwO0MBC
 daNAbcmuh4DPG5z0Ai9HCRuerlvaoioN2hcwy3W99LGIZqoewCaepVTgolRoXZ0lI7Le
 EK4CNrswogt4lWvznHVYKnjX6dabLwBd8m4bBQxmx2LBnGCftwR2zoLrryco2S7xSYQy
 Q+EX1ATl5c8Asgk1YK/LGcZzLpcYMRmi5EDBRM4ZInAE9zrMpzpKgpAkMCUlHSdXZ1K5
 aGO5rr2V1hbQ6UpVbHrk0vnZSb43tpaeCfCobF9T/OemwGqdbmVGZVs85XpphS5GKYED
 VCTA==
X-Gm-Message-State: AOJu0YwVv4DvgwRQrgLiG6mryuaNAxANwhLJPxx1fMtJOIsk0p5XyYl0
 coMLIY2D5ghOkQ2lc+vd1RFzxBv4WbrS8rtx1TCskSuB4Hzl8yhS8KXWaUgRDBxft/c=
X-Gm-Gg: ASbGncsUJ4sArDWH7nxVrilaHrlXevYMPOcW7x75e9MUnMJDzUQMtY98LJ21wObrgcf
 8kM+Ur8DKYzxZtqBwuF6OPHx5opBSCltW7yDkmO7+gWoxqthShoyPMfH8h+vrVRGA2vp7SaxZae
 SbjlyE/B4JwT4TnSRpQm3TQL1KzyZ42ZOCJmlREERBa5cYHdySHc1kF2Y3IazCWmIlVrm4RUWHh
 TLxCHjKWsPDsXeMtE+kNrhLMdFPn13J4GmouGSKOSW4ZiX3xX47zmf6d8xQnG3AMkiAguvyMwhz
 4cBGaXvmp2bt2KI5VQ5aeWPIgVFQHA8KRPfvriHT3E6aBTKF06WcxGJhyhwJy99lfjqrJArhWl9
 DZh0GmPfcAGmRKcmdjFsdJ/8ErT7pJ2jiRmz1PdINWbF7UUYp4XRhLCus6ACMzaNyw+0+H1gSyG
 cTva03OFqY4tEfAULIII8ML1n+RSkOEF7WH03MerrrvuA+yZU16cIZgCYHxiwwlsXhmA==
X-Google-Smtp-Source: AGHT+IFQVnLVLYx2LIC6YRD7Tq8AhS9WPqqGn1XR3ji29H4TlpDE0/B1DBMNhYbJkSBWLOen/Qv31w==
X-Received: by 2002:a05:6000:1863:b0:427:4b0:b3e5 with SMTP id
 ffacd0b85a97d-429bd6ada25mr4784267f8f.47.1761944378246; 
 Fri, 31 Oct 2025 13:59:38 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13e16d8sm5418738f8f.31.2025.10.31.13.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 13:59:37 -0700 (PDT)
Message-ID: <a2b0ff97-3acb-4aed-8ad7-de6cd232e43c@linaro.org>
Date: Fri, 31 Oct 2025 21:59:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 berrange@redhat.com
Cc: qemu-devel@nongnu.org
References: <20251031190246.257153-1-vsementsov@yandex-team.ru>
 <20251031190246.257153-2-vsementsov@yandex-team.ru>
 <d0f6aa76-08c6-4630-927e-358c8f81f383@linaro.org>
In-Reply-To: <d0f6aa76-08c6-4630-927e-358c8f81f383@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 31/10/25 21:54, Philippe Mathieu-Daudé wrote:
> On 31/10/25 20:02, Vladimir Sementsov-Ogievskiy wrote:
>> QEMU_HEXDUMP_LINE_WIDTH calculation doesn't correspond to
>> qemu_hexdump_line(). This leads to last line of the dump (when
>> length is not multiply of 16) has badly aligned ASCII part.
>>
>> Let's calculate length the same way.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   util/hexdump.c | 38 ++++++++++++++++++++++++--------------
>>   1 file changed, 24 insertions(+), 14 deletions(-)
>>
>> diff --git a/util/hexdump.c b/util/hexdump.c
>> index f29ffceb74..7cfc547261 100644
>> --- a/util/hexdump.c
>> +++ b/util/hexdump.c
>> @@ -22,6 +22,19 @@ static inline char hexdump_nibble(unsigned x)
>>       return (x < 10 ? '0' : 'a' - 10) + x;
>>   }
>> +static size_t hexdump_line_length(size_t buf_len, size_t unit_len,
>> +                                  size_t block_len)
>> +{
>> +    size_t est = buf_len * 2;
>> +    if (unit_len) {
>> +        est += buf_len / unit_len;
>> +    }
>> +    if (block_len) {
>> +        est += buf_len / block_len;
>> +    }
>> +    return est;
>> +}
> 
> 
>>   void qemu_hexdump(FILE *fp, const char *prefix,
>>                     const void *bufptr, size_t size)
>>   {
>> -    g_autoptr(GString) str = 
>> g_string_sized_new(QEMU_HEXDUMP_LINE_WIDTH + 1);
>> +    int width = hexdump_line_length(QEMU_HEXDUMP_LINE_BYTES,
> 
> size_t

Hmm I now see why you use 'int':

../../util/hexdump.c:107:36: error: field width should have type 'int', 
but argument has type 'size_t' (aka 'unsigned long') [-Werror,-Wformat]
   107 |         fprintf(fp, "%s: %04zx: %-*s %s\n", prefix, b, width, 
str->str, ascii);
       |                                 ~~~^                   ~~~~~

> 
>> +                                    QEMU_HEXDUMP_UNIT,
>> +                                    QEMU_HEXDUMP_BLOCK);
>> +    g_autoptr(GString) str = g_string_sized_new(width + 1);
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


