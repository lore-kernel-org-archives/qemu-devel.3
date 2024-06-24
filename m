Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C81C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcNZ-00049o-EO; Mon, 24 Jun 2024 01:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcNX-00046C-Ir
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:36:35 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcNV-0005Ui-16
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:36:35 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c7bf925764so3136775a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719207391; x=1719812191; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zmddwG1XUgAHZfl1cEJisui/kr7qnIJZ3jHCYpNaBa8=;
 b=UIVMiOy6rv9fsdk6ryTRf/5mY68TW0ZyMmjFIITXwwEIe3GwOOwvl6n7sbuGJLYT0P
 MfYJAFXwc+W0qCf055guS7ufhB0NHQVRy+e/g+h0O1kmElHP1l5i21/eJp+jPirWcqSy
 ZxP1kO7bYf8quJ1C8eZs1ScGN7dZwJjzrqDCCrH8w39y4yM6SCIuhDc4sJkIU1IEx8bI
 82YHsyZ/6DFx9ARoNTecmYAz5Zwy0VNeCgq2xLI1LSE1jy7HBi60+Sms/Me5Z7OrO2ER
 ynNP1o9ybUJfwhYZ5gLO9i53ghhcfuKysYcr+uGwBvHHH0sB8flKvF9jcOTGxJf09NB4
 s4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207391; x=1719812191;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zmddwG1XUgAHZfl1cEJisui/kr7qnIJZ3jHCYpNaBa8=;
 b=N/uQxUrAHUo7dObIaKNcWlkzIiVRuM5F/247EK0UiTYz1pWluTYkdOqE0iVIeeuotv
 Ow6Lw8l4Ecxmy9uLf9ANq+Q4JppRbctiwCLdaIltwzp+4Sb7KMSduZFDeg0VC/Zt2bCx
 v5mbc04qqgECon3Icya3V7yCOHD8O0GyjW2L9lnCUfQ9TJDPGGZKGPMogpGuebYTqG4e
 1EbsIWw+qHnNQrYeuM1BAD3ZSPwc5UOzGhNShr+BNvbMh+F6f5A2p3/abbYxYvciyVse
 iI9IraYEsQZ5XQXqcQCnV+AheJi0Ym+YhtSlOdnjAl2FUwXMTniUXRtR1KmStzgw1y0O
 TbDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8or8CY4jT3JtwQ/bdBoEAoaDflsc1LWzUCK/XTOpJi9P5NKas8bAciLPzni6afRKBsHOgzqyVcFFx0H8ZRbpxeUQI3H0=
X-Gm-Message-State: AOJu0YzouEPsoN9WolcZQLJ/zzjTU9DkOafRIq7GjYnKq27Rkm+hpkkD
 PS2GAZYgqsJWMQgSmIuR+0sWyapIj9cyEX+Zx5R7vHQHLbebhxwTe3zgLEV4NnE=
X-Google-Smtp-Source: AGHT+IEfQJihTWSGcgoAGJHz+roQefE6n8Qbl7MTSbBqsfqSY0T2M4LupEDfBMMT6IJL7Gyulo/7QQ==
X-Received: by 2002:a17:90b:17c9:b0:2c8:647:1708 with SMTP id
 98e67ed59e1d1-2c861214411mr2694943a91.7.1719207391512; 
 Sun, 23 Jun 2024 22:36:31 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b401:1758:f7d8:1e03:a6d:61a0?
 ([2804:7f0:b401:1758:f7d8:1e03:a6d:61a0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c819a8c935sm5785139a91.27.2024.06.23.22.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:36:30 -0700 (PDT)
Subject: Re: [PATCH v3 5/9] target/arm: Make some MTE helpers widely available
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, peter.maydell@linaro.org, alex.bennee@linaro.org
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
 <20240617062849.3531745-6-gustavo.romero@linaro.org>
 <6c36a71f-f149-4a86-a015-d2a18129ac55@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <3c17921b-0329-4696-9f35-505eb78f3886@linaro.org>
Date: Mon, 24 Jun 2024 02:36:27 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6c36a71f-f149-4a86-a015-d2a18129ac55@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.379,
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

Hi Richard,

On 6/21/24 1:31 AM, Richard Henderson wrote:
> On 6/16/24 23:28, Gustavo Romero wrote:
>> @@ -287,7 +256,7 @@ uint64_t HELPER(addsubg)(CPUARMState *env, uint64_t ptr,
>>       return address_with_allocation_tag(ptr + offset, rtag);
>>   }
>> -static int load_tag1(uint64_t ptr, uint8_t *mem)
>> +inline int load_tag1(uint64_t ptr, uint8_t *mem)
>>   {
>>       int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
>>       return extract32(*mem, ofs, 4);
>> @@ -321,7 +290,7 @@ static void check_tag_aligned(CPUARMState *env, uint64_t ptr, uintptr_t ra)
>>   }
>>   /* For use in a non-parallel context, store to the given nibble.  */
>> -static void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
>> +inline void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
>>   {
>>       int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
>>       *mem = deposit32(*mem, ofs, 4, tag);
> 
> Move these two entirely to the header as static inline.
> In general, inline without static doesn't mean what you think.
> 
> With that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Done in v4. Thanks.


Cheers,
Gustavo

