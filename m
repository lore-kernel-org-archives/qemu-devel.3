Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D670C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhBg2-0007BS-Qm; Mon, 04 Mar 2024 12:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhBfu-00076n-Js
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:00:32 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhBfn-00023W-Cz
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:00:26 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29ab78237d2so3149750a91.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709571617; x=1710176417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k6Hg4T4X/NC6MVox5Fg510dea9QkgpxRKyZmA4RoKBc=;
 b=n/W6peQrr8hRS0H2ieZ6ULJJAFhcFj15nOqQK+02Se9IsJPxQFxCaLSyuKjN1OE/2c
 uHsBbAGW2//fQLSBrhZ8GU6GLBU2tWwCjAjkIq78dA0PKE5OAJrdkPOxQd1X5amoqlus
 OEgwrYeEk4U/+pXROHLU4zqDGv/ejxObhYBRoEblBoTvDOJONCo5pAKamSKo/8ZwnBwg
 6fwqcomsT4szkcPzx7H1aLJqz2oLDV5qOkcHK1Aa1sIb1cIhglZsuMHWhTGAgxaHDBv2
 3cMOI3Yu28d3CNBjsZKhzVAOmkHI78LBY8RfdZMa6KuOz5pkyPr6UJs0Oyw7sdpFoeTG
 TW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709571617; x=1710176417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k6Hg4T4X/NC6MVox5Fg510dea9QkgpxRKyZmA4RoKBc=;
 b=Sn3LUQsk4LhkpFknmyku5EiNp36PODwRRvy+nG7aXYkqREaqQAzofgRHFE89JtAD4t
 x65Rn6uRWHCy0IbASmw6Yv2d9eduvNvy80IOUwu4kKYKdVSrrp3/S05kSCCelypNUl82
 wx+KJmitvy5rV6lSXhaW7KuBl9lSlCYZFTF/aKSitEAJEf7WmWmNLYE/4KiaQU7wCjWb
 rCiQgGQLi6o/qUVJts7eSYm1cna5vsfiQRB4s/8a0D2GbViyE9PT2/VfCJYfqJqAXggp
 MoQBIGOWZ6sfOqBX5ZI0YyX+A3gSn5bWAeqsvIaTkA36pGQSNmUNyiazg6CsJlB4/HhC
 1SyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQfWjzjf0oDTMMsLJ++TAF3a6uDvpKqESOZrz0rYYQvfSPSgsCdkSP0xJMwg5FKGAH+mMwwH7KpLWyIOraqb9CBGT05mU=
X-Gm-Message-State: AOJu0YyTfAHIQuonkR9zyLBIhkKRuk+KDOL04rK3JNDZgG5URM58IvSt
 ML7JlPnVX7UCr1rfnd6BrMV/9y4GEzBossjb8dgU2FSKNMgfLMBKNODDlUdgqog=
X-Google-Smtp-Source: AGHT+IG3X1LbtvNWBa39G2x5dSC2I4dh7PLjQ5P8sgRObi7FDUN6+60Ot0jCCMdzebIHb2yCqOTdFA==
X-Received: by 2002:a17:90a:d811:b0:29b:858:f646 with SMTP id
 a17-20020a17090ad81100b0029b0858f646mr6935305pjv.8.1709571616677; 
 Mon, 04 Mar 2024 09:00:16 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 g4-20020a17090adb0400b0029b2e5bc1b9sm5047132pjv.23.2024.03.04.09.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 09:00:16 -0800 (PST)
Message-ID: <8fc36a59-a666-4c29-8964-c0e71c77b45b@linaro.org>
Date: Mon, 4 Mar 2024 07:00:12 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] util/log: convert debug_regions to GList
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 deller@gmx.de
References: <20240301174609.1964379-1-svens@stackframe.org>
 <20240301174609.1964379-2-svens@stackframe.org>
 <87jzmiz3oa.fsf@draig.linaro.org> <87jzmiuol1.fsf@t14.stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87jzmiuol1.fsf@t14.stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 3/4/24 03:13, Sven Schnelle wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Sven Schnelle <svens@stackframe.org> writes:
>>
>>> In preparation of making the parsing part of qemu_set_dfilter_ranges()
>>> available to other users, convert it to return a GList, so the result
>>> can be used with other functions taking a GList of struct Range.
>>
>> Why do we need to convert it to a Glist? When I originally wrote the
>> dfilter code I deliberately chose GArray over GList to avoid bouncing
>> across cache lines during the tight loop that is checking ranges. It's
>> not like we can't pass GArray's to plugins as well?
> 
> Good point. I'll change it back to a GArray in the next iteration.

How many address ranges do you expect to have?
If more than a couple, then perhaps IntervalTree would be better for a balanced binary search.


r~


