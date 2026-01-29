Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119AAD6100C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 11:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlQS5-000278-Bx; Thu, 29 Jan 2026 06:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlQS3-00025n-1g
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:44:43 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlQS0-0001zc-Gc
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:44:41 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so7122725e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 03:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769687078; x=1770291878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=slA8qQWgTbCJmbnyBTQLLyxMas43L/3iJNnxd2vpl9c=;
 b=dbVfUUEgO5tzb/sPLl6AfhG6C9+Xo+ZnDkc68n+1I29QDv7KRu6sQmxa0sjv/1rjo0
 daTD6wvc+YspEwxpWVbjzvDaR5DXuyoalqk804Qy1pU4SEXMgfieXbKPUlYFxopzisSg
 wXo70PK76ND0dXMcEybug94A8MnW5FUlfp+3NERUQ8iJIgGH+fNiHdRx0FGag/nDQkEg
 WLkIn2rULppSOOiYewrb7cAXgT4GrE70eOhQFtCa2pad5LwuWbaqb5ClQ9GJmK/4EFiV
 e4RcgOniEB8EViXryYGNvrXKDv51at2k8yhxQ7+PKg4Eg4LDtfVN9KY2yiIsD+FvEo8v
 4Ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769687078; x=1770291878;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=slA8qQWgTbCJmbnyBTQLLyxMas43L/3iJNnxd2vpl9c=;
 b=uH6r90eaTUihTwoRCiazYLmFMY1NXoW6eHIstN6eWA4Od0hv87yyNGc+XsDj2pdhBd
 SmHu52ee6irA2AKuid77oP5GvSJOTiUddvye0c5HsdUBUez2Aipx41n/uwOzwo0bQtAx
 VlLF4T36+sJioQIsDcdbm2lEtU9C0mMSqzsN6v7MHpA0r11QaWBAR8fHS3hZdwskKjJc
 ZrfM7rGGb4RLiN9vStc7r3K80aw6Mvs/fAqx77tDc1C+xgxurSJJuwiwMDJAMyP8bL+K
 Ra0sKNtDofdm9UVKFJZxn8aZvqTKC48OPAhrSguwzDEdrzuCG5Lz0BnyU+IszNC0D8zv
 99Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLkh346U6JbJ6MB57wzYJt9y0I2aRNdTI/8EHXiZgZagwyUOpVYjNwaXNxlwJNmyFYjX+y6m3o5nAy@nongnu.org
X-Gm-Message-State: AOJu0Yz4K2/lhE9rP07Jxjjy0eufk7u5yfs3GFy+J7HdKZ4V/C+Dh9SV
 +LBkJfJWj7ZkXiX3Qw3Frnbwzujy60cSp56D6NYtzqmqR2lOqXEB3U2H/+C4nhS1gQ2SssmYWK2
 1iME+Byg=
X-Gm-Gg: AZuq6aJ89F15veWjvArZrrfi0Moe7tdP7WyII5M+ekh33pPlpE351EA+vluFzVtp0L5
 1w0t260Kti4erq4wQweeWznOiNQSIQLLrmynoOymuW85EB/ncpe+9jJT/RiJ97aXQ2fDuLh/X+g
 cLzNMd4VtZqd6pWmKSaacXmzDKC1MLoGnTi+gGByKxmIYGyS4MdjZxA8/bGnXZ3CVIsSXKame1j
 lEbKot0lPrTdfrCdkZ0QNBOvZ2XeX51WgxOcp2BKBh3HFCRM6cXWBB7368m9cS8OKycrtvGQOlK
 SM9VbcIKWrG6KOGiv0d3wd9IIzK5/o+/9ibx47dwiLESoynt2E59IU3q8swN6I5CSGaS1s5dYac
 +E1CTZkGFvv6r+s0nx9j/JHBniOxBSjoaThtrY2VLsszQCvUH+VtqinK6cBIO7s7JtR9Zbyc2xC
 IziMDnT9G5G5D51V5C3A7DY3uSJatKtpp5unS6VRYTUPm+sDIukx5CvMpcLROw0jix
X-Received: by 2002:a05:600c:450b:b0:47d:25ac:3a94 with SMTP id
 5b1f17b1804b1-48069c788a3mr106342955e9.17.1769687077963; 
 Thu, 29 Jan 2026 03:44:37 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4762sm13600410f8f.6.2026.01.29.03.44.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 03:44:37 -0800 (PST)
Message-ID: <2236a948-023f-4de4-9a7f-8840dcb5b60e@linaro.org>
Date: Thu, 29 Jan 2026 12:44:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] target/arm: Report correct vector width in gdbstub
 when SME present
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260129113455.1283266-1-peter.maydell@linaro.org>
 <20260129113455.1283266-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260129113455.1283266-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 29/1/26 12:34, Peter Maydell wrote:
> Our gdbstub implementation of the org.gnu.gdb.aarch64.sve feature
> doesn't account for SME correctly.  We always report the Zn vector
> registers with a width based on the maximum SVE vector register size,
> even though SME's maximum size could be larger.
> 
> This is particularly bad in the case of a CPU with SME but not SVE,
> because there the SVE vector width will be zero.  If we report the Zn
> registers in the XML as having a zero width then gdb falls over with
> an internal error:
> 
>   (gdb) target remote :1234
>   Remote debugging using :1234
>   /build/gdb-1WjiBe/gdb-15.0.50.20240403/gdb/aarch64-tdep.c:3066: internal-error: aarch64_pseudo_register_type: bad register number 160
>   A problem internal to GDB has been detected,
>   further debugging may prove unreliable.
> 
> Report the Zn registers with their correct size.  This matches how we
> already handle the 'vg' pseudoregister in org.gnu.gdb.aarch64.sve: we
> call sve_vqm1_for_el(), which returns the vector size accounting for
> SME, not the pure SVE vector size.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We should make sure we have agreement on the gdb side about
> the interpretation of this bit of the protocol. See this
> gdb mailing list email:
> https://sourceware.org/pipermail/gdb/2026-January/052056.html
> ---
>   target/arm/gdbstub64.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

