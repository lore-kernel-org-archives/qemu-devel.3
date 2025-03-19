Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27C6C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 01:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuiEE-0004uD-OK; Tue, 18 Mar 2025 21:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuiE9-0004t6-U4
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:28:14 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuiE8-00042u-69
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:28:13 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2239c066347so134697425ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 18:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742347690; x=1742952490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VT6F+S0mY5XnyBUyAxSPlQL59VTprbZvAxsDXsFTqD4=;
 b=TvFCbBkvHaNOWfH/459tqtrgfqU+poob7oWcf8IuACXCd+F6Jax/JSvFreyK/t/YLh
 e642yL2xebLpkIRh0D2QXHcwM/a8bLE5UcYOFSk8OFUOM1T+Ayxtvvc0QMTIKDRsl6iU
 JZeEFFiMxMoHU0f4YT22NHVFejRMwUbLDiuiyk9QaGmS7geor7V5WBJrR51hDcro6qaM
 4dqDsxEBdCB8VW4zty3LViwPWpdcM0OLFt9oqyPaOsl4fslZy+oZ0UUhx5ZpPBj4RYQU
 KPntHO5Obk3M+xomYM6wMw+lcb3KwCJwVKIyWSq2Tv3M9kowirlCDjIWsuF9MHGVkvqj
 arcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742347690; x=1742952490;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VT6F+S0mY5XnyBUyAxSPlQL59VTprbZvAxsDXsFTqD4=;
 b=mFyyDvoODwL7FoekKlFhLJ42vqal0TfhbivxJSZbk5OQO+vH6k+pB3n/Xr213FfiJH
 gFKt/XMCuqNAg4E7X42fdId2H6vVOxiP7QZ7QixoWiMpu7AfB6M839bKyfh6+FrLjVVC
 lBvnuuiM59JIWJHr5gbub8yJ5N4xkEndqmPBqtNND6FtHf4grw18qX+AL3yUftVkIqa1
 AWlDohbMGRmXz63f1MeYwjmsb0zqoj0p3Et8Vjc3MNLjV/WWHl3+5hwekSbRA5tV9qDo
 0FFh5zF1J+DUVbo4B+Gm9eO4m5RvifbCu05iLCV74PTf0l1gTVPtCMF3xKExfYk5OTLo
 XEUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW64Al5M5KTw5CZNcQsSIVSVBQX6jwhsoLnhffQbIjVYZdEUykWeePEJxNpvCz33vPtsYGWQCGpnwwX@nongnu.org
X-Gm-Message-State: AOJu0Yydpmlp6MDg2SlROahtZB1NEyNm0gSSGT9QdDHAXukXW7RQRZ4U
 w0JFfN+ZJZmQ9kJMR+X+TR5l1eETTK7uSaLzBD8+/yflv8aOLpJ9JNMu85suwDA=
X-Gm-Gg: ASbGnctJsqIg81AJoafb4VPT8cm366WTpqbxIZa9ytCmwwlt4o+bjMxdWMEwLf47qoB
 pIryChcBUy92pk5VzpHdCKBH+ATeqitbk6zP4FaN+dmcwsV5kpzOZrg+qW82sM9XAvr7d5KYDOT
 GA5TGaz/n+Q+B/nc4VaGat9Kr7N5lXXtEmm31NeVIgKSlfvJmporm3KmbWKC3R0E9ZEMhhAndFx
 595KHuXiOAgYdz5ITCgBZ2PRWvSnqJLrzEpF8bZcu9nZAERZgqVh9/B27sBhkJoGinIK9zhf+8L
 Soozvyu5h0G+2zzvRU7k8W/mEdGg8N0QLbzFM39XwQ/C4UktHk1u36/j98cVydye0fiL3T/o/Kj
 /i8cZDyI4
X-Google-Smtp-Source: AGHT+IGKqlxLdVlIFWILUYs0qhL5XIlonNRdYT+Ty3OKP4MRxeuVcvshiT1FZCjcaVzOyAy1FdsL2g==
X-Received: by 2002:a05:6a20:748a:b0:1f5:769a:a4be with SMTP id
 adf61e73a8af0-1fbed40bbf6mr1329041637.36.1742347689754; 
 Tue, 18 Mar 2025 18:28:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9e2f45sm9744159a12.29.2025.03.18.18.28.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 18:28:09 -0700 (PDT)
Message-ID: <5d665b08-f79d-4559-83ca-9f4faaaaeb12@linaro.org>
Date: Tue, 18 Mar 2025 18:28:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/42] accel/tcg: Perform aligned atomic reads in
 translator_ld
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-12-richard.henderson@linaro.org>
 <2fe37412-dc19-4e32-9f97-1cdcf71fb720@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2fe37412-dc19-4e32-9f97-1cdcf71fb720@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/18/25 17:15, Pierrick Bouvier wrote:
>> @@ -329,7 +331,39 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
>>           host = db->host_addr[1];
>>       }
>> -    memcpy(dest, host + (pc - base), len);
>> + do_read:
>> +    /*
>> +     * Assume aligned reads should be atomic, if possible.
>> +     * We're not in a position to jump out with EXCP_ATOMIC.
>> +     */
>> +    host += pc - base;
>> +    switch (len) {
> 
> Should we have a case for:
> case 1:
>      uint8_t t = *(uint8_t *)host;
>      stb_he_p(dest, t);
>      return true;
> 
> To skip the memcpy for a single byte?

I guess only the i386 translator is going to be issuing byte code loads.  I wonder if it's 
measurable?  My gut reaction is that it isn't.


r~

