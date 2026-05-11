Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAB7CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNop-0008Tv-Hp; Mon, 11 May 2026 06:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNoo-0008Ti-3k
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:24:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNom-0004JM-In
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:24:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so48376235e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778495095; x=1779099895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OnpIAZg96hwYNyhTXcZZufRbRj0hTzbD9Y3atUeAz0w=;
 b=kK4bmh/8/YSmVr0f8XLzzWWCjdfcCvdWtE1ncU0h1f3TO6HdnK5M3DrK0Q5sdfPlVu
 E1/keKLfHNuc8+F9JO8T5RzbE6PHvzyyKaNz3rJpNtiB5/OyVKbqoXnvFJinxSqfEOf4
 Fm3QRnAfbRAuq4wrai79e6YjgJwZXH5yaiQuK75dU/mwVyo3+IBZjHOhKZ6ie/YWJxjF
 vxf0rtVGD3x5y1NEbOCs2RjRe9X+b5D8OW38OkgfXmVQFMDSBDlj25R8S43EG4iHVagl
 YCxI8CEwtSAxwSjGtWCZWKRF9Nkd0zzlIg53G8J9eEVPBT5n55pAeex6P/l0IOBlfkRh
 AgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778495095; x=1779099895;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OnpIAZg96hwYNyhTXcZZufRbRj0hTzbD9Y3atUeAz0w=;
 b=kOAv21rN+zMTJ470fUAGEOn62vbFe+LEjtsnqGP2ePTY7B4LC3LcPxKD+0CJe8YTu9
 TUMF12t4OFY/kp46P6MkmXtoDnoKahy+VYlJDbUAdUtXaQPJK1jK2o/Tai+YAUWL1hRD
 ereAV67jNyi59MvtMLp4t0wB9lfUrGswkiLBtizgU+X96qxalpWy2hTVbbGDRzyUrSQr
 AsINZxbqFtI68ZE9hRPt3rEJmVzYkpLrnOAIzjTJut4K/6vMOGEsLTahpGLGoeno+gl5
 Kz+T7QlUzGJxWL/y0sKz70tGxU7LJip7tcw0u11PQtpdPcgtQDd62GeY0Tpv7DadoQVt
 Ux6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ++Iy3Kg68Ma6xxt7Cs4e4K6yOLZ2PZj0zXR8/MjHOuTg0nX6pwgBlAjBhP3awxqh2EP/Jt24H48qND@nongnu.org
X-Gm-Message-State: AOJu0YwTiNokOWQElRM61BpvLpfFS5k1f3TMXCjoau5+LWITXpWm5QHb
 gwl2YXUrxq7laBXFb+Lj6qGnzTf9JcfKPBgrxru1t4ondj7LQhxlfxoc6DYQtq+z8/E=
X-Gm-Gg: Acq92OHkrkhvYpR/tsJMLana/1g6apImdUs8bChqGaFdzD9ASAv5L06gbYDaDZ4ZkRB
 O/o6zUfEf8yumBGnCNJcqxgDv7AeRbeW0pnHNr/gqdoEOaeMkFQdkIoKV0FQuI2O0DLQPQTOUAT
 FtFs1j2ZDecmjvjux/9LChIZQSqlHUa7D6QKly4fPKrMbfz3Eu9VbiCfc4HAfHHgDfsQOpSSLrr
 sWfal3SVzglHigALOST4QoZb337t4CJB0Va+nizOMqrptpA51w/XqmazyIa9VuqB08AMq1HJ/mc
 wV0lBJL1LhMlQB1wL4gdVrN7noNlgbFt4OsTNIwl9YJ8gZyOjgcYX+EnkRgHqSGinCJYi29hhmP
 YabqrysYK2n3WTWZyApUu9E0XgCaksOjhmVnj1m0dSId4YnUQBxBdC97paff0DwweFhMXVZIC+F
 8mNZm9Y53MrCupFXTun3+TSAHdj6wDMni8eMuqRDy8ulj3/yi9TJpECxn6JJnwN7MHJA==
X-Received: by 2002:a05:600c:4fc4:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-48e706ba591mr139689765e9.9.1778495094735; 
 Mon, 11 May 2026 03:24:54 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702f48a8sm171447765e9.15.2026.05.11.03.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 03:24:54 -0700 (PDT)
Message-ID: <652b601f-4bcc-43da-b652-9417143bd185@linaro.org>
Date: Mon, 11 May 2026 12:24:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] qom/object: register OBJECT and INTERFACE QOM
 types before main
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
 <20260509005453.3984184-2-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260509005453.3984184-2-pierrick.bouvier@oss.qualcomm.com>
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

On 9/5/26 02:54, Pierrick Bouvier wrote:
> Those types are special, as they are the base of all other QOM types. In
> next commit, we'll introduce an extra step in module initialization for
> target-info-* types.
> 
> However, those types depend on TYPE_OBJECT, which is only registered
> at MODULE_INIT_QOM step.
> 
> To avoid having to introduce another step, and modify all code calling
> module_call_init(MODULE_INIT_QOM), we simply register those base types
> directly in the static constructor, before anything else.

Clever!
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   qom/object.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)


