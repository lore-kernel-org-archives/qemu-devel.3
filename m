Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED90EEE265
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 05:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbXIJ-0005cm-67; Fri, 02 Jan 2026 00:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbXIG-0005cH-TS
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 00:01:45 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbXIF-0006qa-2U
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 00:01:44 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34aa62f9e74so15082070a91.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jan 2026 21:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767330101; x=1767934901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xl3krVWdC0nnBH5V5QytgIWOb85N/rQRWfUSupDomBk=;
 b=NGMJkFqFvB2/mHL/4NYGNir2P5NGTU9Cj8A9PV9te6O+QGyvyY7gGSWLSxGSfVej5X
 xGmk0yKn31AEi3rad8so2nyUlAx/7mL+AOTIpK3goqfrfqlF8721KZRKvW8Hzdj5ScHM
 KTeajcf5HI19IPhvCOmLQ1NCFYSUtlfECRE3fnsFVbft81nQtjx5TZy4Pjgy5lvdLelP
 wduCBPUN5bQh+YgtwdBQrbF7nkWn+A2h3PmpOvYgTCnVzE4GT5dP7HSQ9sRGGg+Wr8Y0
 9PdMWcLLAdt2Pqz3gDbNBRPDvCCP0PJVxUdDzIE4uo8wZXnstb6ZXGi/OUF3DUnyCsDD
 tc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767330101; x=1767934901;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xl3krVWdC0nnBH5V5QytgIWOb85N/rQRWfUSupDomBk=;
 b=B1xeNBgj0qZMHXMRqCh3fdOpGul91LnW64rXU9DHmrh4GqvgSw1lFv4dFbCcufiTHr
 UIGR4YiL15Jiid2aaOjBEOvtAfiFHqFb97Ehd/EsUSKCue3rgKZW5FrpplsgfESPXISH
 AaVH9SSoefaUReE//v6SrR5eeUasKF3ofJPWEb9reKLWoqofgekH3pMoJpyrIa3H4gAC
 8CaaIIBnTxi46kybXqJJf3QvWpEZLWZx9HNNa6vVebF6CC1er9jR5di2f9ntkZOqLfOs
 +s7kzjWw7JaVRZDZpI2K7CHTtt9ShLlVVHsQ7BdsLlmKY9356+ievlmSxf1TfnmOaf1G
 WDnA==
X-Gm-Message-State: AOJu0YxhR7+ObB8F0e9DMFz+7HB/n9yZTjBK8I50UMJ6gVEsrIEAtgxv
 To5D4igO0EO1IS7A78xqNh4SWu09SjIB0JnAN/Qe9+PqUe2T9B1kwjJyfpfzFk12H30=
X-Gm-Gg: AY/fxX7KNSX3B4N6A4AtK0LjvbbMurd0o8t6eUcj9UvHcv6QnGrKERba5/iC2vLLCvC
 mMsb9v6rcvMOnRFdm9v6r9ONFoYnjRmkEnffitezuC4V1rDHN26RVqh54SOeRCQr73o6Df5Wmfe
 eCfuRd1FDbbI/CDKkhZV6ips3qcA4Bj9OrMQS9qTLphRgK6eGeCrWL7D+xeRMctc7sRvuIasEdG
 hVlSUYfm44LwCVsrdpjs+Mc9KCK1ZwYtDtGSINEe08S9C67zebvvDFxwOY4sjL3OJtvL4YLM8Mv
 TQYl036xj7vbTWgu80Rel5c7xbD7GANslL5Zhbgon784dTctCX9scrks4ZoeReedEVuevFWnhSo
 SXnglxsbJTEePq6uAYSzhCw2afYxOF64sWqdF3NWdLzljo+CQIxWVgv22iyBYj0jUhYgEPaSZDr
 XM+kLt8OUCRLRb4rbtu3mSj+OtSQRCWs3HUwVgu6S3UR1/aJsE5JJapoT4
X-Google-Smtp-Source: AGHT+IGpgBBScNQSjcCu66WRKbCJW3jJ7pARVuEeEfT4QCg7LomywswoD5J0DekBClNEc+4zXq18OA==
X-Received: by 2002:a17:90a:dfd0:b0:34c:253d:581d with SMTP id
 98e67ed59e1d1-34e92139ac9mr32417073a91.9.1767330100778; 
 Thu, 01 Jan 2026 21:01:40 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34eacbca905sm16294044a91.5.2026.01.01.21.01.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jan 2026 21:01:39 -0800 (PST)
Message-ID: <523e0a47-9076-45cb-bdc7-8310cbde0566@linaro.org>
Date: Thu, 1 Jan 2026 21:01:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] include: qemu/ctype.h -> qemu/qemu-ctype.h
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
 <20251231073401.2097765-6-pierrick.bouvier@linaro.org>
 <CABgObfY1wpqryyBbf3tpCwZGT0izto_hda+izOUGZ57jwQzXMg@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfY1wpqryyBbf3tpCwZGT0izto_hda+izOUGZ57jwQzXMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/1/26 12:38 AM, Paolo Bonzini wrote:
> 
> 
> Il mer 31 dic 2025, 08:34 Pierrick Bouvier <pierrick.bouvier@linaro.org 
> <mailto:pierrick.bouvier@linaro.org>> ha scritto:
> 
>     This headers conflicts with C++ ctype header, included from iostream.
> 
>     Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org
>     <mailto:pierrick.bouvier@linaro.org>>
> 
> 
> Stupid question sorry: the header is meant to be included as qemu/ 
> ctype.h, not ctype.h; why is include/qemu/ on the include path instead 
> of just include/? Can the include path be changed instead?
>

That's not a stupid question. Looking at it, inclusion comes from 
plugins themselves, to include <qemu-plugin.h> instead of
<qemu/qemu-plugin.h>. I thought it was needed somewhere else also.

I think the rationale is to make sure that people can't pull anything 
out of include/qemu from plugins code, which makes sense. That said, 
there is still a lot of stuff that can be included from this folder.

Thinking about all this, a good solution could be to isolate 
<qemu-plugin.h> in a new subfolder (include/plugins). This way, we make 
sure plugins are properly isolated, and there won't be any conflict with 
existing ctype header, so this patch can be dropped.

What do you think about this?

> Paolo
>

Regards,
Pierrick

