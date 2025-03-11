Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65656C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 09:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvTM-0000zV-Td; Tue, 11 Mar 2025 05:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvT4-0000cj-N8
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:00:07 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvSy-0001iY-NZ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:00:06 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-391342fc148so2406820f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741683598; x=1742288398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bpCEWWNPvzqb3rOyOlkFLzMAqItDhePeEA5w9A+Lq6w=;
 b=OwXrCYlE6uw39xaQNuCV/l+TKD8JYV41YzsVKPP2bgLPQBnUHGeKtB9LjQUyN+CPXc
 cW99DTj6JQEcBI8AxfjNxL8sMyyCuXxU2wKM7rqQ+26yULSPhyM7srr3pKJjSQiErtnj
 l1cf30wT3TJOhNv9i76/XvMEXzxtL4ORrH0Av271gGU03JuTNvEvAKuZynNCU4R3UME6
 2PARI9e+tqeTOLzBFB5WuwqUenQS5vylfmu3YPwQsIQ8w45w1dhnCptpjoekxOL49a0p
 WekleYy/rPpxXbiavwXZ/GPj4sxGoXP7gQX7FxJI5r52bQfPKi9akks4EV3mtb5iNYM7
 mbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741683598; x=1742288398;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bpCEWWNPvzqb3rOyOlkFLzMAqItDhePeEA5w9A+Lq6w=;
 b=JDDQpl+zybkLAzfAgEHxmm+3wmUlbvkEre0zIR3DR7nbDbefhWKjSRSr8MTmrWcnTs
 Xoan4F311D6a4qNDeYPlhFPZbL13p9y+xyZ/mI1h4qgzq6I5KTWRTnLdcGzak2n7E9jh
 qcSSuiww9rb4WdlAcDGt1If4iyQQmNrM6GQTZ2mZXJSJRHeR9M0ty6COmUBY7RclMFLf
 K2cNWBZvhPg7r4SNDqbZgujj3FbtU7kcM0s4V79BUd/dG+pvOw56xzotEjPstyCUN1DZ
 bFJmMZsK0LzxEMqevz+dkBR4k6IXxUgY2IxbeIJMZakgRMBAatUn33JofQFxecN40J85
 oPcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeZfaHbm5aAnHnPbv5MQYY3ao75CvKLhbW3Drb0V6qe1qNLFNQ9hE617283esRvZqAsF91Fh3AdCOw@nongnu.org
X-Gm-Message-State: AOJu0YxZALqeP44jKfxez6KL+c8cCZIOa0/GbOTkaszNJ3SozoZj+a2b
 akitnZsGOl4yklcF6Q5ZZrbSdatarwbTNmPkYzzCdavJSvksvmgzJ2EdAZ8ZrGM=
X-Gm-Gg: ASbGncuLBPZJDgZ2QSiAxx7T89wz11dtXCDR386YemzD3iN2AmC5IdZyfgHTq009NW/
 R61b9W11/pLvJldWdy4KmQkId7D/E9QlEYB/Za4veOwKC6ds+j5Hl0Y2L1w8dtksKaUSjfP+Phq
 MVuxGo519e5ha3nUtOMqXto6sJGFr8XsQTHulXrzolBMCjgKc5LLCvVNO5VYE0q3nvpF7OYiqcW
 4DEfJyWIIIy4IovG7vMJT80Ts4KKfO0yHn6PJ3PZR5cKPV0nu3RbqeJr1kkwuwBqtwy03kWIkRY
 zbVrsJZRiVYrs6TFRXuH2sJ8+9drXqSz5F3b1HTUW9joW7+Nmj6/0ysZ6BW3d3oQN/ILHKutgx6
 j9SYWiMe4S/cC5N3uUBdX22w=
X-Google-Smtp-Source: AGHT+IFdUKEObe7nPuf8FVkkpcv1aIRuGZWjfliBLacmfRuUYl6sPAoOo+CuwTJKVzQ/O1FjRMD3tw==
X-Received: by 2002:a05:6000:2a3:b0:390:efe7:20fa with SMTP id
 ffacd0b85a97d-3926c69b312mr3560764f8f.47.1741683598400; 
 Tue, 11 Mar 2025 01:59:58 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb79fbsm17765161f8f.13.2025.03.11.01.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 01:59:57 -0700 (PDT)
Message-ID: <4f0367df-d873-414e-96fc-1a874ee1f501@linaro.org>
Date: Tue, 11 Mar 2025 09:59:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/net/smc91c111: Fix potential array overflows
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
References: <20250228174802.1945417-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250228174802.1945417-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Hi Peter, Jason,

On 28/2/25 18:47, Peter Maydell wrote:
> This patchset fixes some potential array overflows in the
> smc91c111 ethernet device model, including the one found in
> https://gitlab.com/qemu-project/qemu/-/issues/2742
> 
> There are two classes of bugs:
>   * we accept packet numbers from the guest, but we were not
>     validating that they were in range before using them as an
>     index into the data[][] array
>   * we didn't sanitize the length field read from the data
>     frame on tx before using it as an index to find the
>     control byte at the end of the frame, so we could read off
>     the end of the buffer
> 
> This patchset fixes both of these. The datasheet is sadly
> silent on the h/w behaviour for these errors, so I opted to
> LOG_GUEST_ERROR and silently ignore the invalid operations.
> 
> Patch 3 tidies up the existing code to use a constant defined
> in patch 2; I put it last so we can cc the first two patches
> to stable without having to also backport that patch.
> 
> thanks
> -- PMM
> 
> Peter Maydell (3):
>    hw/net/smc91c111: Sanitize packet numbers
>    hw/net/smc91c111: Sanitize packet length on tx
>    hw/net/smc91c111: Use MAX_PACKET_SIZE instead of magic numbers

Since Jason just sent his network pull request, I'll take these
patches via my hw-misc tree (with patch #2 fixed up), except if
one of you object.

Thanks,

Phil.

