Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3067DFD88C7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05ec-0003T0-Fx; Tue, 10 Mar 2026 18:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05eO-00034t-G1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:34:06 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05eM-0007Rs-DL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:34:03 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so7382032a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773182040; x=1773786840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4hX5NNmFeeurVlMxYxeBTfUoQ2gdRNsswUC6nvUAhOE=;
 b=fLjmPa4xEq6HANvTYTUKtPDWHKsDrkPi+Yx1zEkqlRV2/Y8afaRVrmcBU3Nlwdug93
 Xralkq4dv6+yJs9q7l5e5ffprPcXKlmhW/u9vPxa1NP4lXdG/CrsjouUQi5y5kWZHY/h
 Pd2sNBSD94Qj4WHgtSMKkvwXM7hiZqaVtcvNdQMBub514Fd+YsyhY2+9yt3SAqVzWKiw
 w+TwHN/uiVOHMs4HxuXUk9dvoUPjsh0AWCBmx9cGI+G263ef61g740pYjLa3ubYfbwgG
 cy2ebwgx7Dmm7x7UDIDJGgdCl6+++5mNONyhmE55g616MIrYpFnCbzMvH99VD10HhdcJ
 zfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773182040; x=1773786840;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4hX5NNmFeeurVlMxYxeBTfUoQ2gdRNsswUC6nvUAhOE=;
 b=kp0tuZ60gKTXAaNKdl191y3OPbWGafO4LXaf/2cpROrbFQ4HfjemTQNoKs+H9mfEJ/
 YLAajCsFY+Q0o3OXsIcT8+1U9DAWlm/GWq3USoojX5vtLKFCNhCyd5CTJpOgpgKQsZER
 DDqkFEJs/OWFLsRZndoYJiIRU8utQEtCckCxVgVwqMh9Ox9cK5ZRJbuunzY4QgrCvisV
 a1pBXl7DdPH7OLuV0LvyWpVnglqBvps5pqabwx1HHIFzvv1pFPAcBVJND/ZxlRqorS6M
 HbEyh62wpsld6D6kxf8mOqDQ4gHdXzlAAECVDApFgig4hqsQRm79uTMBcrAbpuN+emOp
 Z9YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/OjHUU/s9JMmeIz5cbERN2eXMN0VsCmO84uSn5pVgZXxSKLw9PmlC388hE+Zhx4lcYXN+GMWQvXGT@nongnu.org
X-Gm-Message-State: AOJu0Yx1bLIWQb35msAZBswa0qxWQArwV/8y5Q/CkKZpwVSEnLrqfXrQ
 p2XoO1xPhnJyaW7IWiOgiz5RhFWUyRt4B5nQGoBhYiARo1ecnGUowDflzZa21iD2d5c=
X-Gm-Gg: ATEYQzxuyIa0fooevKFSIj7lUpbjJrbBOQe5YtS/0rELdnJR9SpkptWLjWfpfSPSuIA
 2Sl28kuyCXPQPyDmzx06/lXt7Npn8oEt274zj74YlqDWueDmOB8ZsVuQ0HhuIrTVuyH6VsZhzNQ
 MZa4fGhohSRWYIabdD2EFfA8Yz963Ffy19VrDyxvO6x4fCxxlrZGNDLqo6ePwrcXMvhB8UCVgAo
 A/KmZa66Tk6YxzVlsCB7m0CP2osyS0/w4J06vF/TyyRwqDXsSp5YYUOvCGJ0a5xPBvPjHn7IqP1
 HHOLiCYShmRRPgMzv85vkTkllwpzs27Rgwn7VunxKOXpLoXVoPPN2qtJPqnI9R2BzsY17IS8ZlP
 RgjiLUJFv0WgV2SEgwxLMp8dW7H2HfJmVfC8vG5dh1FWNw4ostEMi+sRMAKwl/9sDDBn495yH9P
 Vv653foj1aAaHhLSB+lRoyeWuEGcnkZ/XVseX8Uzu4Iy2TL0HUCXUdU9UCTEkZ7jtraw==
X-Received: by 2002:a05:6402:4405:b0:65f:8271:3f7a with SMTP id
 4fb4d7f45d1cf-66319cc6cf4mr130701a12.16.1773182039867; 
 Tue, 10 Mar 2026 15:33:59 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6631457f349sm145109a12.13.2026.03.10.15.33.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 15:33:58 -0700 (PDT)
Message-ID: <78c8b024-6dd5-4f1b-a19c-c7a71c7acc9f@linaro.org>
Date: Tue, 10 Mar 2026 23:33:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] tests/docker: add gdb-multiarch to all-test-cross
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260306161728.2657486-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 6/3/26 17:17, Alex Bennée wrote:
> This allows the gdb integration tests to be run as well.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/debian-all-test-cross.docker | 1 +
>   tests/lcitool/refresh                                 | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

