Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624A4C48286
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 03:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWpIS-00045p-7b; Sun, 04 Feb 2024 22:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWpIQ-00044y-3E
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 22:05:22 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWpIO-0007aI-7F
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 22:05:21 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso3157112a12.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 19:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707102318; x=1707707118; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9S04RiO99WlFLBzi3eeLV02rLgr71eTbBvQMiYWRscE=;
 b=dTaqGUtEN15sQr/jgFPLCU3X6cniZXKXKw1sFlEIlGVDmXVlA7sKMzWMpujQR40nzV
 yMWDUtQh39dl8K8nlOFFT0Ial6Gb9IDsSY9wl+8PC9R7gjR87b80tBWWyW2AFhiSIA1s
 JCgL3G46tinWccqXV2XrOfnPcqE7A1uVR+QA7SJd0d9LI8sDud0v0TEmLu8JlQufy0q/
 PDoaY/f8slgOYJTBSekDj7j2olf+e3ytjIxzOC4w5V2M2SvflsArbVDkREGnYfhp4gFF
 kRTEducnZwtu7W8FXya+DumOPPEhu4kKfuWoBawTTKQVnBK/dO3Buhciqv+W03bJBADP
 ToPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707102318; x=1707707118;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9S04RiO99WlFLBzi3eeLV02rLgr71eTbBvQMiYWRscE=;
 b=RKQZXQO3+e3cx6MFV0ljJH+seTwINPt85vL1a0F8xgXsSsvuQe/y/ZkOxoL6qWJvs9
 htmJRA/dYlWTxa3Zl65RHwKzefjoAtRvAT068zCbzml7/ef9NY7tVA5WYnXOujh5LEZn
 L5OC8ORqBGubesf4lQ9ZEow2V6JrpDLGCb/7ErBCKhkNS6TOSXKUwULDIZUwUvMmQfmE
 uI5HU7mrFPsm/djLTwo5IRP22zW+Zr8TCHnLp4kdhPhLKvZArYTKiNLkRA5YqwVYo2+0
 wLIN2S8tdndESM64vPiHydzWoNlYrvkRyQm+Zay7zg3wVRLDHGoLgTCFJtU5+s5iYrCd
 IpMA==
X-Gm-Message-State: AOJu0Yy57cUXCi3IoBo13ARzGOFDSQnlHM8Bc5yVVtVXCmHFDXoupfHm
 76yd/LCXhoRYCCltw6fhk1SnDtp0kIk2uUdNsGX8TGS71DJXwmTKJLK638whwX0sr2hHF4I7R02
 oe7s=
X-Google-Smtp-Source: AGHT+IGksJ2/VohtBkeNTZFdvJfgj6ufZp25eUMg5yqeC7cEdjwXV6hPKGke/IjM0E2fzBz71usLMA==
X-Received: by 2002:a17:902:e84f:b0:1d9:c187:3f8c with SMTP id
 t15-20020a170902e84f00b001d9c1873f8cmr264529plg.58.1707102318616; 
 Sun, 04 Feb 2024 19:05:18 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXEJ5azJx3RYci+ApatfzCqUJYQgLm6SiupzB4Q8d5cPc1zH3IuMsD4b/BijNnVACAywv09slMavA3KzTfH/w==
Received: from [192.168.0.100] ([43.252.112.156])
 by smtp.gmail.com with ESMTPSA id
 la6-20020a170902fa0600b001d9aa671b31sm1289813plb.40.2024.02.04.19.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Feb 2024 19:05:18 -0800 (PST)
Message-ID: <ca83fc98-219c-47b1-a16b-f281d914e4a0@linaro.org>
Date: Mon, 5 Feb 2024 13:05:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/13] linux-user: Use walk_memory_regions for
 open_self_maps
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <20230901204251.137307-1-richard.henderson@linaro.org>
 <20230901204251.137307-6-richard.henderson@linaro.org>
 <9860cd401db66e6bf10e9e41df148b25ee6c73fd.camel@linuxfoundation.org>
 <c845093f-1fe0-477e-bf5e-db22c985241a@tls.msk.ru>
 <3cc4df1a6fe27b211b29d2c17846812936255d7a.camel@linuxfoundation.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3cc4df1a6fe27b211b29d2c17846812936255d7a.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 1/26/24 23:52, Richard Purdie wrote:
> Hi Michael,
> 
> On Fri, 2024-01-26 at 16:33 +0300, Michael Tokarev wrote:
>> 26.01.2024 16:03, Richard Purdie wrote:
>>> I've run into a problem with this change.
>>>
>>> We (Yocto Project) upgraded to qemu 8.2.0 recently and after that we
>>> started seeing errors cross compiling webkitgtk on x86_64 for x86_64
>>> during the introspection code which runs under user mode qemu.
>>
>> Besides your observations, please be aware there's quite a few issues in 8.2.0.
>> Please take a look at https://gitlab.com/mjt0k/qemu/-/commits/staging-8.2/
>> (and https://gitlab.com/qemu-project/qemu/-/commits/staging-8.2/ which is updated
>> less often) for fixes already queued up, if you haven't looked there already.
>> 8.2.1 stable/bugfix release is scheduled for the beginning of the next week.
> 
> Thanks.
> 
> I should note that I did test the staging-8.2 branch and nothing there
> helped. The issue was also present with master as of yesterday.
> 
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=15367 is Yocto
> Projects tracking of the issue which has the commits for master and
> staging-8.2 that I tested.

The yocto logs referenced here are not helpful for reproducing the problem.
Please extract a binary to run, inputs, and command-line.


r~


