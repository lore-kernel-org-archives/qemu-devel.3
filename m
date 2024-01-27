Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C83C47422
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 02:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTYIB-00041R-5c; Fri, 26 Jan 2024 21:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTYI9-00041E-Ja
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 21:19:33 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTYI8-0004Cu-4m
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 21:19:33 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6e10eb1433aso695394a34.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 18:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706321970; x=1706926770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l89I8WeB64TVNRCH0uOW5JHZXPJVX7tgdxXq2wRWDAc=;
 b=YAu1FTcPoMdsH99IFu5KTNGpelqoqGDpyKfrdMQXhTHLjHWDjWzgAGUu2l8FOapPxV
 kkUXz+nlF4ovKV7obosWFTPF6quVbeNUITZtCfUVV9kb2rG1uwYMaPTxdkHjO871D01C
 r98M019xFLTTDnPEnZgXTdVgLcOTI1vhVYju0mXCZvjEkYnhHylGKBP2sRvVjZZKAgFk
 VNWQjwI6ivaPHgo0xVMsqNLE00hnb0zG2tMys4m9q9RY3vBWW5RGH/GwopfcrD3Myc5m
 3vVrPEDwfqrUuvnk9bGwv8L08tzJ9q5wrZKNWG/bD5tBu2GsUDTcKE7117ijX/Q9PVwq
 /y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706321970; x=1706926770;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l89I8WeB64TVNRCH0uOW5JHZXPJVX7tgdxXq2wRWDAc=;
 b=QV9Wyd8KXLO4gZY99p2tTJbJQiDbHH+LiBAfRcQDuSct3KHra1y2Z8/d3u1CUUSM2i
 rXJA972ZZcHtM4MBAz7G3wtyGLbOHzZOC/VxvpTEjPBWj9+MDBNh3Wzjf4/o9UkaOqG8
 xb3hJgge9bN2qkydYtiWacP/pcPKEIsfpsz+pUNxq1RanzZTIQ+rcxKBgekviyOLaIP2
 Onga8IW77f/FK5y5rvweDt7kQJ/K4MaD4enGG+GHSG+UBzYbazdgwswwKd/Zx1Z+JiPX
 0p4enUVIuKGYVHsdX50n+NlaCMCakxRa8tM8NIZHJXQKqd6XCVGf44Sxd6hn7YxATvCW
 Gn6w==
X-Gm-Message-State: AOJu0YxYUXVWYFmvaE6SvA9oGPJO5Shp9TnpXO1KaTENQYVSfaYYVQA4
 PabTcXPDeITj5X00u9cAK0+8HKOCr9c5PjXZlq20eV99c8/LrN3CBUGTw5If4e4=
X-Google-Smtp-Source: AGHT+IGLgXgPSFOzYxW4GYjwpoFRAPudiPk82BzRsCG9aZyfwIyiE+v3fe5wbOH4pQBt98db/lqzVA==
X-Received: by 2002:a05:6830:1bdb:b0:6dc:259:4f9c with SMTP id
 v27-20020a0568301bdb00b006dc02594f9cmr807380ota.38.1706321970010; 
 Fri, 26 Jan 2024 18:19:30 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 m66-20020a633f45000000b005cdfb0a11e1sm1811363pga.88.2024.01.26.18.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 18:19:29 -0800 (PST)
Message-ID: <f2f0ba9b-2487-4395-9d8d-f7ba80b7cb74@linaro.org>
Date: Sat, 27 Jan 2024 12:19:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hexagon: modeling a shared lock state
To: Brian Cain <bcain@quicinc.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Sid Manning <sidneym@quicinc.com>, Marco Liebel <mliebel@qti.qualcomm.com>,
 Matheus Bernardino <mathbern@qti.qualcomm.com>
References: <CH3PR02MB102479550F96F09E0C9D50BA7B87B2@CH3PR02MB10247.namprd02.prod.outlook.com>
 <7fc5e75b-4968-4df8-818c-ab2c4c758531@linaro.org>
 <CH3PR02MB102477AED4556B477B083ABB3B87A2@CH3PR02MB10247.namprd02.prod.outlook.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CH3PR02MB102477AED4556B477B083ABB3B87A2@CH3PR02MB10247.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 1/26/24 02:28, Brian Cain wrote:
>>     static void do_hwlock(CPUHexagonState *env, bool *lock)
>>     {
>>       bql_lock();
>>
>>       if (*lock) {
>>         env->hwlock_pending = true;
>>         cs->halted = true;
>>         cs->exception_index = EXCP_HALTED;
>>         bql_unlock();
>>         cpu_loop_exit(cs);
> 
> In place of the above - we have cpu_interrupt(cs, CPU_INTERRUPT_HALT) -- but is that equivalent?

No, it is not.  Raising an interrupt will not take effect immediately.

>  Is there one idiom that's preferred over another?  Somehow it seems simpler if we don't need to longjmp and IIRC some of these patterns do.

You need the longjmp to halt and stop execution without completing the current insn, so 
that the insn can be restarted later.

Oh!  Just remembered.   You'll want cpu_loop_exit_restore() there, so that pc is updated 
properly.  Better to unwind in the contended case than require the pc be updated along the 
fast path uncontended case.


r~

