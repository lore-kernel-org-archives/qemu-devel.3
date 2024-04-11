Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E48C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 20:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv1NA-00078V-Et; Thu, 11 Apr 2024 16:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1N6-00077b-LQ
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:50:12 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1N2-0004wv-Ez
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:50:11 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-36a3b9bc797so1170465ab.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 13:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712868607; x=1713473407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wYl9hKGRD29tCif38dwA9tV+sTngp8c3HAIW4/e57aY=;
 b=rC1ObVFBg2aIMf5W/Mb8RA4BVsHMs/dm1Mz1qNGkI8qHSXAwugFqpQhKmVy+t3vJnY
 nEaJ8JuTMn8QuNItHB0krLXEPPGBWD0VanR+jhym96f0uV9CXjjXEtc/exf/d/FY6/RU
 AmEVQjCo9uLbsZ/uzIRpiyIrHunDa0fgCakBsubD/Y8phYytAG6tsH9/hCNMp61sFi3C
 58QgZ5grODtcldYQghB4zJID6oqGZk0kRmlHVpg4o09AHDb2GFAkspejIKwrqJlXIR7W
 reE0lC8jpBNHtFs58lsgXlRHtC5lLeL560Vep7FjAepgjQv+4HiAk9K7R1f77cnn5vZZ
 ZmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712868607; x=1713473407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wYl9hKGRD29tCif38dwA9tV+sTngp8c3HAIW4/e57aY=;
 b=aud4Z5geYo/WuqnteyCYITcu2bCmZLGkJ4kiGhenGJEidIlj/4hgdHENXiGbn4+4RL
 bN3lpdeuwreaeuRnc0R5CIbRuDQaELFEaPkGZE5wNlB/ldctHUi54JbidYAeuivUKpZL
 oKSm4Nw5kkdKQQSocnsBOHiLR7ujC1cYPxNhX5Eg4Ml2V/TIL5QluPvv3lnFbeVMPlcX
 ac2MhCPxdncRikCj17yjdXZiUq8gb3CJNpsq1wyLYMArqrjNQneAIHsgzrNCbB/mZQtR
 TJBXi+9rOWR1WQxBX6EeLAOem1IsLPnMpPh9Drq6GfWVA1SBqft3UO0Et5T/xv2cTnoK
 kQGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/l5bx9bqs83QWPFrm/mfBWD39vH6fVuMBZ1tUJRq11KKdq1csSa5P8DL++YRVlazN0xhIoAg4eVg2IeiR5ycke4suyk4=
X-Gm-Message-State: AOJu0YxVToUaP9BlIuI2eZy8lKR8DjuB/zX+IA646c5+swUkQqPibSYI
 ZhImN1Xdp9QLmcdcp4U/YmjLn4SiCqgOMi4zQpM7A0DW55szOpFlMnlCmGoKSaY=
X-Google-Smtp-Source: AGHT+IGRXCbQxp9tUowh3jXiilQ0NHGBgeO2SfB0gQPwAhZpqELYzxYmUyo4yeNvhT4vmav+OfNtQQ==
X-Received: by 2002:a05:6e02:174a:b0:369:b97e:7e52 with SMTP id
 y10-20020a056e02174a00b00369b97e7e52mr870114ill.21.1712868606751; 
 Thu, 11 Apr 2024 13:50:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 o35-20020a634e63000000b005f072084432sm1493255pgl.38.2024.04.11.13.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 13:50:06 -0700 (PDT)
Message-ID: <0e0d59c5-d628-414e-9f16-2d5b75f68ec9@linaro.org>
Date: Thu, 11 Apr 2024 13:50:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] util/hexdump: Replace sprintf() by
 g_string_append_printf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20240411101550.99392-1-philmd@linaro.org>
 <20240411101550.99392-10-philmd@linaro.org>
 <19938e9b-ddd0-4dfe-a75f-f4ad0f281a85@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <19938e9b-ddd0-4dfe-a75f-f4ad0f281a85@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x133.google.com
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

On 4/11/24 13:43, Philippe Mathieu-Daudé wrote:
> On 11/4/24 12:15, Philippe Mathieu-Daudé wrote:
>> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
>> resulting in painful developper experience.
>>
>> Replace sprintf() by GString API in order to avoid:
>>
>>    [426/1310] Compiling C object libqemuutil.a.p/util_hexdump.c.o
>>    util/hexdump.c:35:21: warning: 'sprintf' is deprecated:
>>      This function is provided for compatibility reasons only.
>>      Due to security concerns inherent in the design of sprintf(3),
>>      it is highly recommended that you use snprintf(3) instead.
>>      [-Wdeprecated-declarations]
>>              line += sprintf(line, " %02x", (unsigned char)buf[b + i]);
>>                      ^
>>    util/hexdump.c:37:21: warning: 'sprintf' is deprecated:
>>              line += sprintf(line, "   ");
>>                      ^
>>    2 warnings generated.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   util/hexdump.c | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/util/hexdump.c b/util/hexdump.c
>> index b6f70e93bb..2ec1171de3 100644
>> --- a/util/hexdump.c
>> +++ b/util/hexdump.c
>> @@ -19,7 +19,7 @@
>>   char *qemu_hexdump_line(const void *bufptr, unsigned offset,
>>                           unsigned int len, bool ascii)
>>   {
>> -    char linebuf[QEMU_HEXDUMP_LINE_BYTES], *line = linebuf;
>> +    g_autoptr(GString) gs = g_string_sized_new(QEMU_HEXDUMP_LINE_BYTES);
>>       const char *buf = bufptr;
>>       int i, c;
>> @@ -27,30 +27,29 @@ char *qemu_hexdump_line(const void *bufptr, unsigned offset,
>>           len = QEMU_HEXDUMP_LINE_BYTES;
>>       }
>> -    line += snprintf(line, 6, "%04x:", offset);
>> +    g_string_append_printf(gs, "%04x:", offset);
>>       for (i = 0; i < QEMU_HEXDUMP_LINE_BYTES; i++) {
>>           if ((i % 4) == 0) {
>> -            *line++ = ' ';
>> +            g_string_append_c(gs, ' ');
>>           }
>>           if (i < len) {
>> -            line += sprintf(line, " %02x", (unsigned char)buf[offset + i]);
>> +            g_string_append_printf(gs, " %02x", (unsigned char)buf[offset + i]);
> 
> I find using g_string_append_printf() simpler than checking snprintf()
> return value, and don't expect this function to be in hot path, but if
> preferred I can try to not use the GString API.

GString api is pretty good.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

