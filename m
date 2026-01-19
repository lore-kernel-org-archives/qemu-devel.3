Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958B7CCF2DD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 18:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhuNv-0000Jx-Mw; Mon, 19 Jan 2026 13:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhuNn-0000A6-Rw
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:53:48 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhuNl-00063W-VM
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:53:47 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0d6f647e2so44974365ad.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768848824; x=1769453624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AY5MzOw4a8HckOvh6QLzD6UgkgdI/FRbQtUT79On6BI=;
 b=sJjn6Ooe5H5wAD23o9eEV/NYDKdmmllJXrtlPnW46d5UOhQxf/5rEE4B2dTZNblGgO
 O2LlTdpcvyBhp5URdvbdk9Gf3EVtRPYGbDvZuVxPEMLj7Viru0vlqImXrZaFWXIG9lCA
 7n0p2OoWC6R/Ft/gTIzewWWMV3Hx2VdqR2mN4pU6J2PzafnwL5CGcGgwcwjyClGyuphT
 i7dp+rI/JN7HFFJNF6dlhy1Ticli0W+cje4Af9OlOrWR8+59DlxcWNBJEOSN2GLfQR0c
 lrB1DOdnKFdofcs6dTQOnN9ptmiS3VIsmuUmRLI/UTWvxdxWFYZNVaBuHAFQxVL8nDCE
 iyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768848824; x=1769453624;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AY5MzOw4a8HckOvh6QLzD6UgkgdI/FRbQtUT79On6BI=;
 b=h91OXACDR5f0QjIXMhK7Tzb5XPD57dx3CarxNAu9E8rl4VDXzEff1+dwHF6zH6YRko
 bIKtvnpC7zHZzdS3vdksIHM7pq/GFWdVjJ1QOpWHGi23YP7jhu6djVnSm8TO3uu21+m8
 pVFqmSjrh/au3hA/g2Yu5qM6BBwakamrViJH4VYq8VDT9VRx+d8lYKXVDgxG7H4wz5P1
 gVFJI5Xtvy8O+1Nrz2F+G6JCLDQ6CatujzPYFN+VxOJzoanthhis/dcaSJmfaiyYwOso
 FWqptKdNI12wdyfA05BiUM+KSbOqKJ1SJVkOa5YFUdoLp+quAqwTZXZNKC0FKG5Lm9io
 /cWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFx31os+BuQhl5XZC9oGUdgwSgmUs6Xyo0aLYYtgNy2lAGWfKlmg99HhBuTUaip/C8FjlSXQV3nisw@nongnu.org
X-Gm-Message-State: AOJu0Yyd+VNgENbtO1GD/b/Xici2DHc4aXbaU+sPiz+3JodoeadkkW3y
 m52bKMCjoA1cEnjGLJp78YAMAsQsOjxYnjF3U7pJE2iWHCMkeOcAqgZyLRNBtP3t/EM=
X-Gm-Gg: AZuq6aJxYmqmJZk3tDpus7TdPpqRlbFaX2BeX2a1nflr/Kdm8RuHTqJYcFeakbX0E1L
 dMX5pZvN+GmymcxcC55vmTdNtrFwuaKBv4slmETXgyHH3HmG4XvDR3oQKOFpXU2JVyvsRyVeU89
 mLbblQ+KWJypSr9boxQrQ4qpq0y+wJ2GKi5Dd4tknxrXwct7/Ot/vB/vxLfQhhfOM52+ltkPSco
 R/AqfXOxd7BLUNfmcEM7JbV9pyKack9Xl5D1G/hszOY9YGmoJiA0Ou+vPbnxYTPa8pfcCoWEn1B
 G61XjCG7vxc+eLXXsXke5MqkgWG8j0g3sq/vwP98C7qRphFH8yJMA52ZzimJg1B++SmuNYw6E3l
 9M9xjy3l1MPdZI+8CcXzdinZwAp89mJN/Nq9kc3l77h3zI92rLGdg09JJKvyJsjysNyJ6OhhHBQ
 5N3daY6zH1wB5o9foZCzLmzMALXKi+3S2+Nl2lSa6R0SPS5+9Zn7tFAY68
X-Received: by 2002:a17:902:f685:b0:295:96bc:8699 with SMTP id
 d9443c01a7336-2a7175408damr119166905ad.20.1768848824415; 
 Mon, 19 Jan 2026 10:53:44 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dca71sm99186625ad.48.2026.01.19.10.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 10:53:43 -0800 (PST)
Message-ID: <16e93209-efed-4bea-9e21-a5299154e9a9@linaro.org>
Date: Mon, 19 Jan 2026 10:53:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: return bool from register r/w API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@fhofhammer.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <f877dd79-1285-4752-811e-f0d430ff27fe@fhofhammer.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <f877dd79-1285-4752-811e-f0d430ff27fe@fhofhammer.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/19/26 5:18 AM, Florian Hofhammer wrote:
> The qemu_plugin_{read,write} register API previously was inconsistent
> with regard to its docstring (where a return value of both -1 and 0
> would indicate an error) and to the memory read/write APIs, which
> already return a boolean value to indicate success or failure.
> Returning the number of bytes read or written is superfluous, as the
> GByteArray* passed to the API functions already encodes the length.
> See the linked thread for more details.
> 
> This patch moves from returning an int (number of bytes read/written) to
> returning a bool from the register read/write API, bumps the plugin API
> version, and adjusts plugins and tests accordingly.
> 
> Link: https://lore.kernel.org/qemu-devel/60089475-3891-4448-bfe0-8dd698cd2435@epfl.ch/
> Signed-off-by: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
> ---
>   contrib/plugins/execlog.c  | 14 ++++++++------
>   contrib/plugins/uftrace.c  |  8 ++++----
>   include/qemu/qemu-plugin.h | 19 +++++++++++--------
>   plugins/api.c              | 15 ++++++++-------
>   tests/tcg/plugins/insn.c   |  4 ++--
>   5 files changed, 33 insertions(+), 27 deletions(-)
> 

Thank you for the very quick patch Florian, looks great!

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

