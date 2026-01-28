Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554DAD46BE0
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 18:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlA2y-0006uy-D6; Wed, 28 Jan 2026 13:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlA2x-0006uB-7h
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 13:13:43 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlA2v-0002hi-MZ
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 13:13:43 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3540266d356so45982a91.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 10:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769624020; x=1770228820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9H65GqOasZHtJ1PHcnmkFJKUeF8wOBvmcJB3jyV1ebA=;
 b=L9lmSa/+vyd7MSa3/ru+M5SJiL3dal7i5/5jTrOvmCiyioWZM6kuxs0S4GOGBsh/j4
 l3HOMsKZnVex434Zcv3YK1jGM3/wB/bjwBIM0+fCgOgjc4rouCyoSmS+m9bplg9yjNE/
 1lvsODRf6kVw7f7MURcehgvMfeSyakq8wKg56NspeBYc6Ks0R08cKgKjzNwbL+sIulFZ
 g1XzYA8dFryPy/DeNmA6JVbN30U2VPcxUO5Vuv2pC7h3cUdN7dA2CmpAZS3auLlPNVTr
 tLrk1GmXoFwIWI5rng8PHcaaSwNp0z/Z5uzDDnb4DbiUxQPXz6axyGpBy14g16YAPoEU
 mITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769624020; x=1770228820;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9H65GqOasZHtJ1PHcnmkFJKUeF8wOBvmcJB3jyV1ebA=;
 b=ma9v39dSEeTX89SbFSm6aiE9qISfwAsLl25lc7u8wLcYv78K/KXYvSraU6Zy+V4W3f
 F6pZhYHpcRdaJxPMlJR6WPsGsr2Ldlk7m/rdMJNZKdoZ8k9U5EgWHMXZ7rBugOJlLVru
 WIFXghYIjE+drtx1bLEUeTs/mhddXfkt50dIppPbXhCE1pM7540V+XrpShyy0/8Iu37y
 QMSNyXlQTS4oK3a7U0TxSaTpVzLg2a3sq1Cfn8F5G9FvWfiarXVkL6vHRLIeWFI6aMLa
 SHSHsybpi4W/4XATw4eU9TEBfU0CYgxY0n2weHB1ukaRq0b5vztBHtld8O+Q0exuiHzj
 IZaA==
X-Gm-Message-State: AOJu0YwDzod92+ZeWbTxLS9OiKheZRzXoQobeTUmEUVk69EFAEiVYmYr
 6cVYR4kpmoUVcqP6JsRLCBdg9B6WNZpmY+NF8X6pqPnNXOjtSbHFZdxhH3cVT7r3Hzo=
X-Gm-Gg: AZuq6aKp5mEFOvFPtTe7AsTns8MJSuHw8to+LMpNDqRtbpYCViWOxm8/6Dms4erXfZN
 6lapu4aKSBvkoUATbr/vWRoHqhBsmo4qiKM7hNd4DikFyhJFZzkYa9l6H7Ivbra/0C+BhD9Z5DF
 GcTHJxGSDDJhjgcFArhsT6aIF0cA7rODNQXMSSv9ckIL5Jms4d6LJuN5/WcDkFL20qDeBao1ClL
 H5HVaydEgCuz06T9CoCdjklR6gQUGYDEEDwaDQIOpbn2oECmomYs5KCulbVJQzjvxql8/Q1sVLY
 hZMd4obbk1E5HPJTJONywVA6rqNNED2VRFu/9ApKkaT7oELuRirZv+OeTKKPfecD35MXnuz9+lt
 K/+S0I/5jm1EMpAg+W9+Z0jYOy7O5y34xC2VJWLAbKA9ETfWfiU9eR2SghMDfO689vG7lGaSuuE
 nYl4eG09zrWSNh0ZUc+iHyjXQ6P5yE/e7U+86BSDfQXtDVHHZ0fvAA1jKg
X-Received: by 2002:a17:90b:1dc1:b0:34c:2db6:57d5 with SMTP id
 98e67ed59e1d1-353febd9b18mr5162481a91.0.1769624019960; 
 Wed, 28 Jan 2026 10:13:39 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0230sm6220494a91.11.2026.01.28.10.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 10:13:39 -0800 (PST)
Message-ID: <1d9b0101-a5a3-45e8-b647-dd23d3b7c274@linaro.org>
Date: Wed, 28 Jan 2026 10:13:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v4 03/11] plugins: use complete filename for defining
 plugins sources
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
 <20260124182921.531562-4-pierrick.bouvier@linaro.org>
 <87cy2uat5e.fsf@draig.linaro.org>
 <1daa47ef-c2b5-4fae-aec7-744c5411a7e0@linaro.org>
 <87pl6tabuo.fsf@draig.linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <87pl6tabuo.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 1/28/26 9:25 AM, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 28/1/26 12:11, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>    contrib/plugins/meson.build   | 10 +++++-----
>>>>    tests/tcg/plugins/meson.build |  7 +++++--
>>>>    2 files changed, 10 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>>>> index 6915ffa5fbc..3d2d7862e0c 100644
>>>> --- a/contrib/plugins/meson.build
>>>> +++ b/contrib/plugins/meson.build
>>>> @@ -1,15 +1,15 @@
>>>> -contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
>>>> -                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
>>>> -                   'traps', 'uftrace']
>>>> +contrib_plugins = ['bbv.c', 'cache.c', 'cflow.c', 'drcov.c', 'execlog.c',
>>>> +                   'hotblocks.c', 'hotpages.c', 'howvec.c', 'hwprofile.c',
>>>> +                   'ips.c', 'stoptrigger.c', 'traps.c', 'uftrace.c']
>>> Argh this keeps conflicting with other changes. Maybe we should make
>>> this a dumb list:
>>>     contrib_plugins = [ ]
>>>     contrib_plugins += 'bbv.c'
>>>     contrib_plugins += 'cache.c'
>>> etc?
>>
>> This applies fine as of commit 9ad7f544c69, on what are you based?
> 
> plugins/next ;-)
> 
> Pierrick is going to deal with the pain now in his first PR!
> 

Enjoying the rebase process now :)

We agreed with Alex I won't do the array change to not delay further 
series in flight, since this additional commit won't be reviewed and 
need to be sent to the maili


