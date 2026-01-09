Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F4BD232EA
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7CQ-00052C-OF; Fri, 09 Jan 2026 02:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7CG-0004we-1j
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:46:13 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7CE-0002AS-GU
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:46:11 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso24541355e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767944768; x=1768549568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h82IIx96zJD53657FJoohxW7xxaVI1uiq/BF2lw6vsA=;
 b=OzX7SvWbNtcKdJ0QG1snPXHeEwI4c+Wf83yV2/z+Ypz9AXAOM1Tll9eciCWY0wcfFo
 3JlFygLOWw/bD6/GCCobS6QXE80AAvdKmjfKeQmaxyu5bovUPkaosPMBIVCaED2p8bQQ
 /cLIXR8thteGVPoL4EENYfYgkT+lR5F/pEJ82wkgoD2S7gj2HwviPpeGeUBSdfs/ZHIC
 eu9uHJSuu/9HiXvp76BNEg67wgiGKNpFWaha3V1T5DTycHTy1GfJ2niacwLKxgiLLdTC
 skEbS3aDEOMtB0oxEtHBqfxjiowpkrk7xizU/fNZkx+Urj+UhLCCRLRgnRtI+eU2+1yI
 AXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767944769; x=1768549569;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h82IIx96zJD53657FJoohxW7xxaVI1uiq/BF2lw6vsA=;
 b=J9RfATTSbL0UpU7mKgo9xV70EIGhBFIxrSKswhs8pYHhTO6oYiLYK0ZAG8Ej0ReQO7
 8EOPlXFUVMkbjfcD8dVkrvHshpUi92lgvhQePS9he8lH6qmZQ/O5GeDPaV7MMQXXOPB/
 vrsJEIa0f7tnSy7Zx0G+QdgPA16nyRm5osTzha4JCDT86kv3u/hKvcWPj712tri2PQmO
 SXrQGbPpLwiak8ykDoKdB6HBBLsBGRiMe0aI7JO2HvyUihTLGdQhzr0pvcbuj3vcmmkn
 nU8juvnDv9JRHvQmCmZZGcKuGZnQeTMCAsKr15D/R60nBobAqF37ECWnwRV9umZySaZ0
 1RPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbArFSnsiglebvr43v2HJ8WY4NWgoWA86bF4r/DKXobmhdRt0guwA+lU1IQ4l6dhxU5jeUNJBuQxYk@nongnu.org
X-Gm-Message-State: AOJu0YypLjwFQbs4TaAPHP+3J0u+miyV1soHVoSNnZVujY3+nAJAmVdh
 LE9bAe1pwT/3wJ23a2diuMvZ4jfqr4Vq5HoxiT7WtR0g3ctS2xfjm5mwemLDdf6hpzo=
X-Gm-Gg: AY/fxX502IZyLUDUxGCWYghm380sjmsvJbygcPBEIgGa0ZUkfjXf5oqxQwta7JZA7w4
 Adeh7ToOZm6VzzjkpfZmX7HZFcNRIoeFiivTTxG3ZWyDekH8k+6XwI1/JGAI+zVA/9TIESAD/hx
 P8xIejInpN37knoJwLK1QkYK2i8jnlW7N3JjNjMZY2vWwzEJ1ieC/dFwfpOlwlr5buXXkFsZ54Q
 lK3hniE64mR0NFyYaltKnXIh5ApAbp5058hquAJ8tZBsvCVIe+QNTEz2U8fRumx7J7fDRkyeLLM
 x4NQRdljacAxmOUKTNPTY3z21FKHegVswxek+sJWhLFi/Jft3F141luzaS+VjIrgTzujFAzJbvg
 Xn6D3ko7+2rnJvx0JsaywcFQjBsFZVWI7yckTyxqw/awqjmHz4LVfKXepEu6OqajJBpJz1PWiun
 EvbMFmio3QzWOVe/LBGXTuqs257Zjr8jtsHKsOgjNxjEET0BsmSVBEDjQagf9XSgI4
X-Google-Smtp-Source: AGHT+IHroRoOqAWsVWSoMIskmHeWjS1c1j/qL3bHO5nuNOHG5rgUzKkF8KEHwikhVpH0Qd3DdAZ1dQ==
X-Received: by 2002:a05:600c:3ba9:b0:477:9d88:2da6 with SMTP id
 5b1f17b1804b1-47d847d0f30mr118711795e9.0.1767944768646; 
 Thu, 08 Jan 2026 23:46:08 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e199bsm20843897f8f.16.2026.01.08.23.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 23:46:08 -0800 (PST)
Message-ID: <54c52092-1bde-4191-be43-794e385c39aa@linaro.org>
Date: Fri, 9 Jan 2026 08:46:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/29] target/arm/tcg/translate.h: replace target_long
 with int64_t
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jim MacArthur <jim.macarthur@linaro.org>,
 anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-12-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260109053158.2800705-12-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 9/1/26 06:31, Pierrick Bouvier wrote:
> target_long is used to represent a pc diff. Checked all call sites to
> make sure we were already passing signed values, so extending works as
> expected.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate-a32.h |  2 +-
>   target/arm/tcg/translate.h     | 12 ++++++------
>   target/arm/tcg/translate.c     | 18 +++++++++---------
>   3 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


