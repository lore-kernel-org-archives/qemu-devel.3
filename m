Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C80C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 05:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMhhD-00038R-CW; Thu, 27 Jun 2024 01:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMhh8-00037x-GT
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 01:29:19 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMhh6-0002zk-1f
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 01:29:17 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-706680d3a25so3721094b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 22:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719466154; x=1720070954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dU9aUxjj8dKgAT2QlhlYyUwg4GO8VDM8+cvs/Wjcybw=;
 b=o4J97tPS31cTeKFMHL1JbHipXcsFwZSSrzQ0vQXAgkJeJ/rb+IkYEvGm6Hi1erX/tP
 4tMl6Zm/n4DzHOnKBtiX+hTAQbDwQ+0jNedQh8NWJoJeujCRSFCVrI1GuFeb0+qRTtAd
 VcEcf1GKjfuV3oGrMx/ulXUn4WCwQJgJd29NWVxNVGn07t4HWvm3xVsTKWpQEtCTFnBh
 0BpWTNn2ZkAfbbPLFo6MX7hODkEaJTetgakQiMLxnatovQlcKCkF8gWmmn7vlPDQlLo2
 kYIJ0thYh7BmgKTIAoN61Loks1ljhqLbbsl9kxQso7Un6B752HTmYF1zYn7eZe+4cr8E
 tq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719466154; x=1720070954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dU9aUxjj8dKgAT2QlhlYyUwg4GO8VDM8+cvs/Wjcybw=;
 b=afyXu2M2CGeJBO+qXisdEDrTFKv8mUorx6whCvc52YK+9+1sFo6co+dNd26qRBk8o4
 oCSRhQSg7OVcTeAboCPirp9tIWT8XJ+z12C9iHEvOf5wJGWmgkH7ld5L8m7vitE2KlSH
 SjmnpnBoxu57M2ujbYaAuAtbT4Xtx3ZyldlW7LwEiwD36fM3LZkuF7xePcynU0N4/DOK
 zhtiVW3u85p9fnbKLLmo5aP0t6jJ7pmkSoKpfxRTrVYE5m+DexwJEV8D2NocAzRjcN61
 tGopNRc65uVSZRFSOTzqSQs+4Rn/XODpUA3KFKZmDcltpXwWLUvhl9vjsaVjfQk8EJfN
 LzmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOC3Is4B8JD+om9Chb5vGC8ldJgmEWwWXTt8yu60qgevoegWmy+B/w0uH92doZ7vk7Z9FRFxlYUoerT2rDH/brOjEimd0=
X-Gm-Message-State: AOJu0YweV72uURRGC5Ne7hrJycdGxKrHzb5zqcikz/cWKu9yqNVHYpR7
 soQqd6CsoguqZLpPIlWNJXmLHsHNzKjJsK4RNvK2/sJfx+tmYa3WXu4t/bJyNsE=
X-Google-Smtp-Source: AGHT+IFiUJsZJCHiOQsr8G1mSgyEXot3uZgMeeeqqcq/v2RKIW01pZ0nVLAVmadvLantQUJq9MuCsw==
X-Received: by 2002:a05:6a20:1e4b:b0:1bd:25b9:380c with SMTP id
 adf61e73a8af0-1bd25b938c9mr5301848637.46.1719466154087; 
 Wed, 26 Jun 2024 22:29:14 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac97956bsm4100515ad.157.2024.06.26.22.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 22:29:13 -0700 (PDT)
Message-ID: <b34d0699-42cc-405c-a511-e58445bc362d@linaro.org>
Date: Wed, 26 Jun 2024 22:29:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] tests/plugin/mem: add option to print memory
 accesses
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
 <20240626233757.375083-7-pierrick.bouvier@linaro.org>
 <OSZPR01MB6453C257EED6AFD784FFFCDB8DD72@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <OSZPR01MB6453C257EED6AFD784FFFCDB8DD72@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

Hi Xingtao,

On 6/26/24 20:17, Xingtao Yao (Fujitsu) wrote:
> Hi, Pierrick
> 
>> +static void print_access(unsigned int cpu_index, qemu_plugin_meminfo_t
>> meminfo,
>> +                         uint64_t vaddr, void *udata)
>> +{
>> +    unsigned size = 8 << qemu_plugin_mem_size_shift(meminfo);
>> +    const char *type = qemu_plugin_mem_is_store(meminfo) ? "store" : "load";
>> +    uint64_t upper = qemu_plugin_mem_get_value_upper_bits(meminfo);
>> +    uint64_t lower = qemu_plugin_mem_get_value_lower_bits(meminfo);
>> +    const char *sym = udata ? udata : "";
>> +    g_autoptr(GString) out = g_string_new("");
>> +    g_string_printf(out, "access: 0x%.0"PRIx64"%"PRIx64",%d,%s,%s\n",
>> +                    upper, lower, size, type, sym);
>> +    qemu_plugin_outs(out->str);
>> +}
> I think it may be helpful to output the GVA and GPA, can you append these information?
> 

You mean virtual and physical addresses?

> 
> Thanks
> Xingtao

