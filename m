Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EB7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 21:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxCnf-0002dS-6B; Wed, 17 Apr 2024 17:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxCnd-0002cy-Ip
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 17:26:37 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxCnb-0005s8-OJ
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 17:26:37 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e2c725e234so10446165ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713389194; x=1713993994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=POm+hN+GZP65g9vRln1Kz3H/USW28OR3gDj/pS/CQso=;
 b=Pv3L0d9UmIWUJD5GgseErIKqYuvZtamUCgQRfGp4PbjgDQP/ZmUIlCGSiEWmZx7jyI
 dtvWub4patffAZirQPPOqlIJXZdf8NTssSNaaJWuglDbN5Obw5CQ7+zjdbyGF0INCLGL
 cmAmfpdqRODW9GO2WH6zDs8HhgXeAQvihIe0ijkWvbsBXr2tbYOIEY7mGvc6AWCvpfAc
 GdUR1IxiLAx65NQyPgEBtYhjhW+RuXH10Qy5x8FlFLmB+rKySsdz2hJsYxeCyUvJixDz
 eG05nz8Wi/krHEPtx0N4oIkgAwpQohn2+rjb7cjIcsEX0uy6HfkNYgCeAWAzA3+xS1as
 pG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713389194; x=1713993994;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=POm+hN+GZP65g9vRln1Kz3H/USW28OR3gDj/pS/CQso=;
 b=c8hE9ypwU8haVmQqmsu5Monap/Hcj4bJGkf76LxZDCYUeImPK8eeZPbR9XR+daKzS7
 o5JvmKVJPvOiCLCZc0wv2UyGvxuostklOx5NM0g8sMtOU6aSjJnzFkiNYlcJJpGCJL3R
 NLIKtSJFuofcRfdk31iADVE1Xxf4iZUz0maMEAqXDqHdrcLdZI1eIV5IfCebftDctAUg
 5YRs76rM/RwtieU4DYfT5r7+UlKgzPGCSs88Wznj0SQLvND4A6AiEC5Lnf9V3bv8qudI
 O8xtlWan0ezgwsq0KyRxdFINkIZ6BDlCX5WpIn8wmUKWOiiB2OJCbfblL0BNCmj0TB5g
 3jvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGdB5UwS3454RgLaQROrTXm/NeNZopPWS5mKHN8AL+rGCshYPb7GtRi5HuNjmAG1nDlm0prwRwFX9pK3fxTBOQexm9xjE=
X-Gm-Message-State: AOJu0Yz9Snk0VnblMQ4qLz2V1bf3V83s10CSclrCHIFuK0luFcxp1kWg
 yahZBKhfAfGtn5R5DCZw9/7YFWQyvmxcoB4nn2ON7QhrLJnQWao/o0qg71LwK8E=
X-Google-Smtp-Source: AGHT+IFeda13EeLTyo9KJ6DnjOwok/eRftCXa89xJjV1jB65JeaiYS65rJiR/vvo4WW00Aalbk0l9w==
X-Received: by 2002:a17:902:d507:b0:1e4:6253:2f15 with SMTP id
 b7-20020a170902d50700b001e462532f15mr370299plg.16.1713389194051; 
 Wed, 17 Apr 2024 14:26:34 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a170902ab9500b001e5119c1923sm96932plr.71.2024.04.17.14.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 14:26:33 -0700 (PDT)
Message-ID: <1144287d-da14-40aa-bb43-05e27f47340c@linaro.org>
Date: Wed, 17 Apr 2024 14:26:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Add 'info pg' command to monitor
To: "Dr. David Alan Gilbert" <dave@treblig.org>, Don Porter <porter@cs.unc.edu>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
References: <20240415160818.2316599-1-porter@cs.unc.edu>
 <CAFEAcA88myOeQwZ212q9R4EHBPpJbQ1qZYjuz6SS=HZbqS+NCQ@mail.gmail.com>
 <fadb288a-4c44-42c9-b706-f5595d97f952@cs.unc.edu>
 <CAFEAcA9Fe8TerNSrg_AfmpFZNL_4B9WV0OccFdLakJhtCN+m4A@mail.gmail.com>
 <bff71578-42ad-4af0-9ba6-e0962dd73710@cs.unc.edu>
 <ZiA5JZ5jzsjrv9Bu@gallifrey>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZiA5JZ5jzsjrv9Bu@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 4/17/24 14:03, Dr. David Alan Gilbert wrote:
>> In looking at x86 code, I see the following places where there is page table
>> walking code to
>> potentially merge:
>>
>> * target/i386/monitor.c - existing info commands
>>
>> * target/i386/helper.c - get_phys_page_attrs_debug
>>
>> * target/i386/arch_memory_mapping.c - implements get_memory_mapping
>>
>> * tcg/sysemu/excp_helper.c: implements mmu_translate() and
>> get_physical_address()
> 
> One thing to keep in mind (although I don't know the x86 code) is that
> you want the monitor command not to change any state, nor to fail if
> there's a particularly screwy page table; so no flagging exceptions
> or flagging accessed bits or changing the state of the tcg.

Indeed, the only one of the 4 that *is* allowed to change state is excp_helper.c.


r~


