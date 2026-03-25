Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D723109C029
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Q6f-0001Up-FI; Wed, 25 Mar 2026 11:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5Q6d-0001Ue-KC
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:25:15 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5Q6b-0003rb-GZ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:25:15 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35b905e9dc0so1533168a91.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774452312; x=1775057112; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ag/aka8C9pnC+0DUb2Tn6sRVfGdHbRnlkhGyDmi1fto=;
 b=kF1Gp/Xz+R3SDRWNKs8wcNNizmGaSuvDMTXJx9o20MR2dW5I9FZnh5zlbFlG8X3XL1
 qWuZORh9INsT6DxUxTVAHmywqRMTyqd0FQr99JwamTN/cHTo939hch/ALVwBczqWlJrw
 eDDw1Ktf1nkODhdGOyAgY8lliCcOXnEg161ydvaOmaVHwhklc8kLU4SJsH50lRRk3jRs
 AknF7YRQu2m+WVjU9kbJ6PPDQmz/MG6mT/Oi/w7cQcgytGS/beYOkPUCXdjTi2/yNqI4
 0RWFvyd7a3Dv1PS/7nfqQUYGhY7PPhVP9OsXHcb4OSwMhbyQbqaxwnx8kx2IH8apHpwi
 6bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774452312; x=1775057112;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ag/aka8C9pnC+0DUb2Tn6sRVfGdHbRnlkhGyDmi1fto=;
 b=GPCvbHiMx/VLjQuvjuAS/C6BDW3yUXWe2mrbf56BSyxnKreUdebSIcJB6PUeQI4F3n
 n/yJe4YGGkbOZykPLr5AnjJcXKhbRd1NcQ0p2NLu48aG1RExUxr5E2cLJS5ooMy7e9dg
 zkwsUjBhWa06d+4GYZFd4qpU/Mo8bq6zL50fsJtkItHQr+/8DnZd91k4gXGsXZN/b4lB
 5UEAQuSDHlO8hlmbDYq5nohDIJnXOK/XDM4gh/7VC0BhDQglk/C3SPoas5pLv/2neSVr
 rVTZmSqihMHTdpy9e2NeCO8t/Ow1Lnb20eIyLJeYXcu6Ba1NWVIfdF5H41xyahc2bNa3
 Y8qA==
X-Gm-Message-State: AOJu0YxP26Mw61x+evRpyPo65kCxzmp5YjclyeYRM3dOL+okxv8Y5V4T
 q/RrJseqzTuDkY6aYoIVcwHgZhpLlQI2MILcymMtHI1qGRCHsQmUf8SV7spE/SiEo94=
X-Gm-Gg: ATEYQzz3Mg5ux/n8O83n281fWO1hAWlKfHnGF7Kcfosg8Lm40wJTuH6l566AaK3GR6V
 YvbauFWq0zEmrBH5Fsq2GzBc8kNItkZLN/C6h8NGJN8Xz0nJxmLnd30hm/eEODID3NgSmIUfw8x
 gdZlDzWTrzCrNWIPXY9qR+I1blkTIgaM1fwxcZzJRAHsTMXFcRD54YOyQ94UieyJHjfv6DxNo2C
 zbxUn4C06k90kqKMfA1tr8vjGggF3Hi6nTFgaGGYwG7KiNa8C7UY+oljsBvOLkiPh/7v5VOOk6k
 xE64caSLxu0uHDQJm+WZoT9V8OVb7wyqJ9cs5Xogg/3hKfEkUuRPk0TSh38ihgVf5X/A5asGM49
 hq0hlH1Uw+z9+4E17jqulJVXRI3zuuuZ/+1aaC/jXvGfu7la3+sK5aVWZ0BMaRIfFUW8RartsbX
 7OFZPxMgMm+I0kF69/tjWGzf5TQFTkFQrD6GVI9Ku5xEpxHDN5CjDBor/ckMy2dBcs6iF4
X-Received: by 2002:a17:90a:e705:b0:35c:d98:d684 with SMTP id
 98e67ed59e1d1-35c0dcc612bmr3785669a91.6.1774452311875; 
 Wed, 25 Mar 2026 08:25:11 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c74443ccb56sm13302301a12.25.2026.03.25.08.25.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 08:25:11 -0700 (PDT)
Message-ID: <572d24c1-a930-4164-b331-c6d408b3e2ce@linaro.org>
Date: Wed, 25 Mar 2026 08:25:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/tcg/plugins/mem.c: fix endian swap in
 update_region_info
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20260325024252.3369186-1-pierrick.bouvier@linaro.org>
 <20260325024252.3369186-4-pierrick.bouvier@linaro.org>
 <87qzp82awo.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <87qzp82awo.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On 3/25/26 8:20 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> value returned by qemu_plugin_mem_get_value() is always in host-endian
>> order, so we need to convert TO target endianness and not FROM it.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
>> ---
>>   tests/tcg/plugins/mem.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>

As a complement, GUINT*_FROM_* and GUINT*_TO_* do the same thing (they 
both swap value). The FROM/TO name simply acts as a documentation when 
reading the code. That's why it was working before as expected, even 
though it was sending the wrong hint for the reader.

Regards,
Pierrick

