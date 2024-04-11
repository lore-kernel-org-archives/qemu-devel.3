Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19806C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 21:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv1sm-0007H8-Hx; Thu, 11 Apr 2024 17:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rv1sl-0007Fm-5V
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:22:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rv1sj-000264-6r
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:22:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3442f4e098bso758895f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712870569; x=1713475369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GhCiyIYKMi7y/uDOSTPpcNjv70nLXfZKkQZydMmIQek=;
 b=L/IsXwAu9ihTFVQnzotdXMutHsLDKq1NkNlAQ6T7zCDs4l401w3aF1aWGpn77i3iUb
 ujXWvMullPDpm24J9n9W96KcaKobUyjh6+OAoI+BobiTVlIJsycpLMR9U+MvGIPOJF1u
 8bqe/IJLR1l/vbVkPsEoCeX+4dN9Av9VTsE/glxe8KD7hMXfhRSxPfrm//5jVEXsivT0
 w0KSY1dQIPkDwxbgkgCB+j9p3x+KGfFrYvbQa2LnhMs+mrv9UItlSDAU8U61RzO8dHaC
 mBFbzsqyRI08ULbQQmWZS1I0t1xR+mPts/t65ZJIE9atvrQi0j3NMJjrqwugqyghHgDT
 3MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712870569; x=1713475369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GhCiyIYKMi7y/uDOSTPpcNjv70nLXfZKkQZydMmIQek=;
 b=oUQhibBBMSqrdHSY34ShMHNMg5HomMKuhni2iHKcHMFjwg0HsMlAljJVjc1co8omUm
 /hYqw/LjRaff+msOYlP3L8dI6nG/F7mkeU6D3inWAEAjx3x7oZL4JW2Tu4N5Ptd+cN7h
 fB8CYMoYoEuDiziNt8yWI1nEZzFsdxz3QKuLHE0VgDpRg/bnEPb9ljqRWufYWdsP3B13
 v7qcXDUoXsh1zRBAtKsewvL+dnlpMIOQGFAbsSGm7zj0pJ1Bs0kGkHnaB2Hmo5rsfk4z
 Ji8Xs1rfvxCvy4+vkqpT8xCqUpE5z0K/uSpwtIOz+nRREzCc9oShmYAjNd3s2hNZm2l4
 vADQ==
X-Gm-Message-State: AOJu0YwwJqy1OyAJR3KVKEK+9ThxFlZMpUyk0W69XVmcFN7BvOtqE1vV
 boC3jMdsAwD+/7Uof69LZoW4d1s+JJ0wd2RZlt0rDcIQEu2AQ/vJAIDdh7BJtj8=
X-Google-Smtp-Source: AGHT+IF4fSJmlwrQ3frdYMEEpvg3l+GnSvWUVBHZ2q+q6hB1uuDAK4S1VvzhMUNdh03ey9AGj/WOzw==
X-Received: by 2002:a5d:45ca:0:b0:346:f830:db09 with SMTP id
 b10-20020a5d45ca000000b00346f830db09mr342568wrs.31.1712870569248; 
 Thu, 11 Apr 2024 14:22:49 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 w13-20020a5d680d000000b003433bf6651dsm2640582wru.75.2024.04.11.14.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 14:22:48 -0700 (PDT)
Message-ID: <6309ca6c-6a31-4861-9cff-bef3326c6126@linaro.org>
Date: Thu, 11 Apr 2024 23:22:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] hw/net/rocker: Replace sprintf() by snprintf()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>
References: <20240411104340.6617-1-philmd@linaro.org>
 <20240411104340.6617-7-philmd@linaro.org>
 <CAFEAcA9_pbMBjNsOJe2LkfC6z5wuRMSM1pL7X0aHVjdzysoLOw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9_pbMBjNsOJe2LkfC6z5wuRMSM1pL7X0aHVjdzysoLOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/4/24 13:30, Peter Maydell wrote:
> On Thu, 11 Apr 2024 at 11:47, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
>> resulting in painful developper experience. Use snprintf() instead.
> 
> ("developer")
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/net/rocker/rocker.c | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
>>           switch (offset) {
>>           case ROCKER_DMA_DESC_ADDR_OFFSET:
>> -            sprintf(buf, "Ring[%s] ADDR", ring_name);
>> +            snprintf(buf, sizeofbuf), "Ring[%s] ADDR", ring_name);
> 
> Something seems to have gone wrong here. Shouldn't this have
> failed to compile ?

This code is guarded by DEBUG_ROCKER, which is why I didn't noticed :)

Indeed when enabling:

../../hw/net/rocker/rocker.c:930:65: error: extraneous ')' before ';'
             snprintf(buf, sizeofbuf), "Ring[%s] ADDR", ring_name);
                                                                 ^

