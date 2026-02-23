Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2932FEC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZw7-0006wo-Ad; Mon, 23 Feb 2026 12:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuZw4-0006wU-7F
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:41:32 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuZw2-0000Gv-L3
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:41:31 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8220bd582ddso2062039b3a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771868489; x=1772473289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6KZrm9qGTNNUk6b7A4nto/oqJi6i7qoWG7eK39hkOho=;
 b=vWyY/gbj8XAA1Hqdon4f1fZh29gRkrrhdTiPMfaSPtQCNWixdtwkPefX7u5uNc94c3
 KxmiWJtDWIXFNL+B4jcN+6asyTlPPNxCFtfUKs72hJC+fMDOV4TzFK+829v/C8uckCWq
 Lf0eWZHPPlYXoCJEGl3WpFtrSPEzQeppg/D5J39dfFlO8fBdgpbug5z9V9BMgCYqIxaG
 71OXB1jF0+pNJKs3wbnHkY6/20bCCQmIhai4SLGSnh2uCQrzTUzx7hK3HySjDwNUUeNl
 VcPIPSPHfEcKgyWXwQoG61x5X7iaCYUV9AYKEy9VJ2n9/Faf70Tl73Ky8seWXRB3TNAu
 QDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771868489; x=1772473289;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6KZrm9qGTNNUk6b7A4nto/oqJi6i7qoWG7eK39hkOho=;
 b=RLDUNj1qddi5FV8g2B2H72humx9Qjpjr1YHU8ZMpJc1pg0MF9RC23uxasTc/vrmbWE
 64LnMWE6p4HZ2YclZYy9urL8qlGoO7taLsGEvQaByESq+uj4Vj2xR7AQbk0kerJwL0YQ
 4m8OCazITbzrOzTCllV8l8Uh6YD0L/pmVsrllGsRPaTRuKMrhH71guEomZaVBaWXSVza
 dFTh01LdNmMeMHjni66a9St9TN3jvv5PQ7iqp6LBRzg8KmM41yRDCYteFSNCWSIEhMxj
 G9npki4v3/tlamJHZspDn4TW3CWu90WycELNmyW6g1FppaT6GkIyTyMhVx7SKK1GlQ7s
 wRmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2pe0WbJWwnUJr+724FPSzqfHoqJ3tVUxsxDwECjpthTKN6rsFcnMLwqnWXpu0hAWY9vluBmsKa/GE@nongnu.org
X-Gm-Message-State: AOJu0YweUlI9yTsj0c7fCIqxWeNjiUO7NOafDe4jgd5myCCU0SpA/Tqx
 hn967uXm+rOtltvxldq/V96vF3G3xTytUNAg/j4x8XLQiCqjr3EH7RpkT5omzCcA7oNpzvULHBj
 fNKrT
X-Gm-Gg: AZuq6aIpdyOinXpnSI+sFjpSgkwTeWCgUSlxlLNseIDSwRu8Nl51h2NZvudUd1I42vr
 wI5kzPxCQk/7QR72piCQHXTaUdHJEdJyITICCYX8iJpN0gxwO4wb9RXRS0vZBD1QMtlHv7M9A9e
 L+J3Vw310VEZ1yeIEDwQXBGfXEKmTVzoqXFwH1kLEN5YHuYENizkZlKXJwJ9sooudDwBp3dcETz
 ahw+uiB3WrKdKYeoa0ZGFmp8oTynxkBEwdh+/1uO/XfM7Sk5/Y7+jBKhLeuq0s8MJwVlRP431lb
 EEBIfwXxAQAdbdlw7wJhafPUqnQSawj4+Aa7nTgHKGtMla3tWmN56xhC07Y+9ACAahSapUbvw+f
 17JZkWrYLakzh2KGZp0hWiGjhjj4ez9KJ3FhZa2Fz8RKDkTLSIC/XPegKpV7SK3XgCAh+PgYMyv
 lN19nxysGmt5bElbrDp/2swFXNqoK5XW9rrf5RuvF3WJkAvQOoIoWht0lIq4BEGqEBG/TI
X-Received: by 2002:a05:6a00:1c88:b0:81e:af19:34b8 with SMTP id
 d2e1a72fcca58-826daa22a20mr8190046b3a.43.1771868488901; 
 Mon, 23 Feb 2026 09:41:28 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-826dd86c93fsm8489475b3a.38.2026.02.23.09.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Feb 2026 09:41:28 -0800 (PST)
Message-ID: <8c18fbfd-6e86-44bd-87c7-c5213cf761df@linaro.org>
Date: Mon, 23 Feb 2026 09:41:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/kvm: Don't free migration-blocker reason on
 failure
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260223173232.453165-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260223173232.453165-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 2/23/26 9:32 AM, Peter Maydell wrote:
> The migrate_add_blocker() function documents that if it fails it will
> free the Error it is passed via its reasonp argument and set reasonp
> to NULL.  That means that in kvm_arm_enable_mte() we don't need to
> call error_free(mte_migration_blocker) in the failure codepath.
> Doing so is harmless because error_free(NULL) is permitted and does
> nothing, but we can remove the unnecessary code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This seems to be the only caller of migrate_add_blocker() that
> was doing this.
> ---
>   target/arm/kvm.c | 1 -
>   1 file changed, 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

