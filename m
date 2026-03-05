Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E39F513E5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGsV-0000wk-Ad; Thu, 05 Mar 2026 17:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyGsS-0000wS-Tj
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:04 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyGsR-0002Ag-Dh
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:04 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-483abed83b6so71735015e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772748542; x=1773353342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sp4NGGwXe8WZ9WaE/Rit85H9U9O9209qhDh1s0NEE9E=;
 b=PsZRzz/P+/6F6U4LAos/Q+79mta2Z2G6Ah95dCt5XairvvXp5hAlWamrGLWlRenAD0
 Bl90fKdK5+MQ7RXPgfGX2mJDCnbBaNNwUx7gT3jP10oxLw/eBqWItdlEeAdUFwC1Ju47
 iwPHk4XS1iLW1Jd7EuVBHXp3Ea2VUtitksT11RucRqFMjmCMUQmEAIJ5rw4TqTMsYNKz
 sxPtbHZg3KqOjbtLstU+5YxjDwDCt1ZXaGM6psP9AdOd8jPjM2tn7msZDQp//oTSvFLa
 PrbRFpwRKXugqxwvwEFTOgrV2plC/whWrS4aMAZrRZ72FVFNijficYjY7i9CscaLz5nc
 6TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748542; x=1773353342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sp4NGGwXe8WZ9WaE/Rit85H9U9O9209qhDh1s0NEE9E=;
 b=ddAZBPCeqzIHnaoEMU4wJ8iL40K4cKEQiFyTWuVUPBx/RDEoFYcoQQiyuoruA96dfu
 Sj0eOAgva7lVrcHy37QatWLCdTdwZqEUE5fA84qKk9OZuSD3VGrNJHYyWtFLn7DXjSyD
 0xz1gjsBV0ioQQQI1gE8eclg7wgWV8KnTmKx/uEOwbdjfs103P9Bc5dr8Ff/cGnrzWr+
 7d6uc77Tm1eX03co6TZeLmT0eT+qSUUWJz6BMvCUj+AQJmUaF3Ie+k1or+h0Tos72laG
 Djy5r+i4SBFDYV0+Cgc7fZzDyJAaCoG9yrUQ5yBbrUbfZGcY7Sy3PhqlfpfWVKuzzOCE
 GMow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAwgukDUCIHPRFTCSPQ1x2V2hFILo5Wf1m5aTi/r8sbWW9Tig5EiVbGPvJIVDjpNOg4YRxDpsaU29N@nongnu.org
X-Gm-Message-State: AOJu0YzFiOF69BheCxQs7teKZXdqco5CH/Hu9uko+ENLJc7p63pTdIXF
 sFcLAzOGpsJxROmBCKYXW29eDuXMY5thAq2mx/Uw6ybzXPVjmmQyysC7ryJvU+dECKk=
X-Gm-Gg: ATEYQzxMVcG5K1bLGU8SPZ65sp98uZCcMsuJQYWPHlXWSSz4MP9QNHFmLaXE4F75U9J
 +CLHJxKeINunLFSWhAXy4hoRYDBs5jZSnFwTCwYKAz/d8/o1cMfhozHAy7NCA4w1RPQsHMWIE3B
 PWDn5WQlWhFidd4lJAPWsZfHq77dF1CHs8sshUvEDgKnA7U9CxU9n8xQtzXiR3ZEd+1fBHuMGtG
 3alfPJqIuM4QE2bm16whx8Hn7Wt4niLvGLk88yzO1Powkkba5FsMPhCCoCVBXJBmrm5+W8PPrb2
 N7aExPkYvjz4tbSwpAJxj9lTmNtUXbRmdAtTZANyzF+Cx72qq0dzvIcDc6gCCjA9dGacejdfqVe
 EakF+pFmrdIu8UysQFWpD9lp74kdgderWoc2ZMWLF4k9SCv1FTqhxGbSmMVU+W9hYDauACbXYgn
 Tko4lmfHuRwO7nMxPYeHruHk4lMVqlbf5gvAHZt+cK+qQ6hpAKQ4vqZepJyffJe5MdCg==
X-Received: by 2002:a05:600c:8411:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-485198744camr124994385e9.18.1772748541644; 
 Thu, 05 Mar 2026 14:09:01 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852378de92sm7310645e9.0.2026.03.05.14.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 14:09:00 -0800 (PST)
Message-ID: <3fdab598-c163-49ad-9927-b1f28668b5e7@linaro.org>
Date: Thu, 5 Mar 2026 23:08:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/12] hw/intc: Add hvf vGIC interrupt controller
 support
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
 <20260228220837.35275-2-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260228220837.35275-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 28/2/26 23:08, Mohamed Mediouni wrote:
> This opens up the door to nested virtualisation support.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/intc/arm_gicv3_hvf.c            | 735 +++++++++++++++++++++++++++++
>   hw/intc/meson.build                |   1 +
>   include/hw/intc/arm_gicv3_common.h |   1 +
>   3 files changed, 737 insertions(+)
>   create mode 100644 hw/intc/arm_gicv3_hvf.c

This patch is huge, so I surely missed details; but
the overall LGTM (it it won't break any existing feature), so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

