Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F64ECD980
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1nu-0006Ej-Am; Thu, 05 Feb 2026 11:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo1nq-0006E7-J1
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:01:58 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo1no-0000TC-57
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:01:57 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so9771715e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 08:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770307314; x=1770912114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GapX0mUKNWqc15BBJeo3kTp0NqBidqAS3uF9EkG68i0=;
 b=nlWBxFz960A0eU5eObXlLDU4d4eTMdRaUGZKOeMcap+S0nefRWSVIqrRThE3LrzfEX
 0FanWqKdXO6hyWpCMO69naY58kXexLRCz9JHVx9LkxOHH8OpD6p+ZMaTQ+u7L8ljyuXK
 M3gqiSXLNjhYjnTsjTuzGvDRgdDGAQHYb2uxxBHGl9R71pqlHw0lWbiLlJ3kN9uvH69C
 2TSSM9Nw5KU55E0WweJ6BppqUxi3orByxpx3aw/X3m0XhwF9HruV3nEbtaJZdiOGHexx
 xyoHWOh9yp1wPHmpX3SKvw9GzTx+HSDVzonFQkO2MFtDE0VDJMKvrA6OLx7bqQJUd3ko
 +Mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770307314; x=1770912114;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GapX0mUKNWqc15BBJeo3kTp0NqBidqAS3uF9EkG68i0=;
 b=R7HoqZ3pp0ScJdeSqaSUDwLY//ZjyPumGsFx1hHwE2f29EzylUmyGoIT8sSmQYraRz
 aGZIbLSNJaWivTA+jIJpgdpRR7fJF/xDagw7R57N9Ayt/XEMbp2wAcXX6BUiOnegU7yv
 Zdc80nIf5BUEwkve/NLw5xbl49Ju1D6U27P9QWR4YA21ccSRlFV2m1S41J0R0uwd5p7V
 agO18felPQcC8Gt0TvlPIoLrqFI4UfwYRPPwePjXQp3get0n52xX/AEqRbhvDQTnr/9g
 ibSKC/5jjFR76A0b0XbeHLsjI58rKfkIWHfPQm+Z4btbQ8px40RLophIriuFuh5LWCtr
 jxBw==
X-Gm-Message-State: AOJu0YyQqYSqz3F2MydTGU1Qo+0cNldl2iC9p6NKCkXJTs0bYi4H/Ogu
 PCAics1Ivq0o+7BU7YGfP8uEEnbTkme3X1eCkO2pg6SX+k/eSsey76w3KqDTrGPE0Fw=
X-Gm-Gg: AZuq6aICGz8VeD2UbBYifjMIbYs8Qamd4WuaReAxIlnjLXUFQBEDmhJnxpOuqv+o0Bz
 laTwGFYrmaqA4mg4eKxP0GQJiR/snq6Qi9CJAuO4JiwjEhk+7Mc1yzmfe+ysWwmDlL6cDgX1u17
 ytUCjWNhp394sqZVx2/+ZWRGpYZkrqjHZUjmW9j+FcOP7YAd8eogReHGeELYgv4MTjL7taxZVvV
 l2ME62zO3GrDuy5hHKVWNITEXxAp7sQGIGpkspzAiOQUy/UK3Post9oH1NbgbJVUgcKkSvZwIZP
 ZlPlSsjzhDM7fkUKkaKehnOS5U9KCyde/2hVMfYW6DUKUBL0SlNF1hqmLnQWnckPs+RKNAOURbS
 gmmhcrJTY1ZiBNcyBY9TEb+W2qdgf7vOBpqWBHA12rDoCplJHQO/e1AUdpNwdYOTDv8mT4zFstJ
 mpagDd6EBHUBBFKKZ5cpYf2EXv19kE8X9KhE3PavbIQU9i1TUFXunv9A==
X-Received: by 2002:a05:600c:1e1d:b0:480:6bef:63a0 with SMTP id
 5b1f17b1804b1-4830e9681c5mr74030515e9.21.1770307313857; 
 Thu, 05 Feb 2026 08:01:53 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805faf7sm14534859f8f.30.2026.02.05.08.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 08:01:53 -0800 (PST)
Message-ID: <2473c90e-7171-421d-99ab-a2448210ba2c@linaro.org>
Date: Thu, 5 Feb 2026 17:01:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qapi: Add hexagon to SysEmuTarget
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260205030617.266625-1-richard.henderson@linaro.org>
 <20260205030617.266625-2-richard.henderson@linaro.org>
 <CAEqNhNbw3EKT1Cra4-UjMxvNCa+4Acjg_OFwdLvBdW3rcLudLg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAEqNhNbw3EKT1Cra4-UjMxvNCa+4Acjg_OFwdLvBdW3rcLudLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 5/2/26 04:49, Brian Cain wrote:
> On Wed, Feb 4, 2026 at 9:06 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> 
>>   qapi/machine.json | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 907cb25f75..ef8575b6eb 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -28,6 +28,8 @@
>>   #
>>   # @loongarch64: since 7.1
>>   #
>> +# @hexagon: since 11.0
> 
> I-owe-you one hexagon sysemu :)

Please!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


