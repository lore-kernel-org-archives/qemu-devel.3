Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5A5EB26F9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 18:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpsl8-0005Qy-7J; Tue, 10 Feb 2026 13:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpsl6-0005Qm-Vz
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 13:46:49 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpsl4-0003i2-RI
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 13:46:48 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8230c839409so1061464b3a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 10:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770749205; x=1771354005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yz+Cn5D7k59z4L13LLmxBimr2pmgG2cVJI2V2LjwNZw=;
 b=pcybB05W5GimTv9Y/a0tadkRtBACAfopfxaln5b2c12JRfntZC/Y4qcUr+HiFjPFqr
 sp+xB/4Zm48jpcFC9jy2qnWYnMJq3HHFtx9IQnhMEIchh0hqHlsUnNJyfW7iEv35KjB/
 mJ+8UZswh+royLjGtZbs9yd9jhxsbAzdj4Q1Tb44ekZVyR7Ma7IRI0hYQ7OT+SHsz+yU
 QhsJBnArfzAADRj4Ynr/E787oUZ1XFBoj6qzWbyBEarqbz6behGQPqLebtbc0ezrLEcA
 cNISsqp2CWWrH/wy+0rfHIYjLQp72v2K7aI+7wHKQVXwdn3vOHXcU68PSsNg14BUMiyc
 0BNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770749205; x=1771354005;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yz+Cn5D7k59z4L13LLmxBimr2pmgG2cVJI2V2LjwNZw=;
 b=p41HOxGIFxQfgxURpDlC2WqCE/RSMXx09L0i/WxfCHFtLJ2ZIGO8pZ9H0RbiitGJyu
 q2H+ZP7JHF1bT/jqMH6oLUdL8oOpxiZUM+ce4cjeKa2r+/OASxT91damD+BNr4NNnk74
 HgH+Qr0hq6tHbfJz4tmIThS12OQIF+ShDNTTCVBDcbbkNJW16n8lTVlAqF0JW94xrOJX
 WfCYZkPXjDWjQHoY7Ff3+oxpYKUHkup3xJP6bi93cHtYb1OnIjDKwwmL9UbYKYKcDOmn
 spE2G5keLBDGH/VtdbCnvk6gheIMYvRNbMhnIS6NTPXj3eTb1xN3cDty6jYFAbXgvJUG
 8Bsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+ScEItYmBNMWTg8MbPtnF7e6Crmx9N1kxNhdD3ndKXzErS1HcRs5hj7B9Ibu5BtUPL/0kBA6/ZeSe@nongnu.org
X-Gm-Message-State: AOJu0YydYcx0KkUXPQRETtisxYX3wyEEJiTbFpl9uQIZ86KhJrBqe5n6
 B8SYM0BJzOPDuf74l9nG6eItuWJKLFvT5XtOYn2Or+lC58+vXOG+MLgsg6LsDTTzZO8=
X-Gm-Gg: AZuq6aJ7zEBU8F6zmbFUbABqI1t0xlWDMtqbooaL9yWqXzuYgu1hwAjawG9YY0Kz4En
 7rtOPW7llVmXJsFu/GyeRe5pVOGFpsNHdC+nf0Hbgh7dyXNCe0N+MgcvJXiUtAzWbI9nIps9jHd
 nMyCgJRP/DEP5LnuNNviAj4JSOqQQMtdMIg4/w54OoxiqJRW1PzHKnx/UoEq/aWBCp+ecg087ct
 EHyKbqIH3wNWAjfyAvbZaCJWGLnH3yESqatqZ6lt+EZZ5lsTXT6dJvu9JCoWlrgpt+7I+D2/ceW
 UuMl2PqFig5N0MX2iqBSN231sMZqsE/V2OjhKsfwhmoImEIRxofdk6TanHziVkITW0HaoQ1Clqg
 EUZV7y7+c3l8eKRqik/KtQzeVuLc/sh7gfUwp5UM+DEEixkUv58YeeekETakKVoasTn9AHBW18K
 OHm93EOejBWBhwmrrWS9AuKfjEjIx7CWF8Wdnf/DowmHvf9cc7YqCULxwCkPcCARlC747I
X-Received: by 2002:a05:6a00:6a59:10b0:824:9451:c20e with SMTP id
 d2e1a72fcca58-8249451ca83mr794323b3a.59.1770749204997; 
 Tue, 10 Feb 2026 10:46:44 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82441695f50sm13432404b3a.22.2026.02.10.10.46.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 10:46:44 -0800 (PST)
Message-ID: <d53a944d-be77-472e-a37c-4173533b6167@linaro.org>
Date: Tue, 10 Feb 2026 10:46:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: don't access 'cxx' object without checking cpp lang
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260210173355.776365-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260210173355.776365-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 2/10/26 9:33 AM, Daniel P. Berrangé wrote:
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 2d114e9018..9ad16d1998 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3194,7 +3194,7 @@ if host_os == 'windows'
>   endif
>   
>   # Detect if ConvertStringToBSTR has been defined in _com_util namespace
> -if host_os == 'windows'
> +if host_os == 'windows' and 'cpp' in all_languages
>     has_convert_string_to_bstr = cxx.links('''
>       #include <comutil.h>
>       int main() {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

