Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F648C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 06:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNjE-0000YD-6k; Fri, 23 Aug 2024 02:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shNjB-0000Mq-7W
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:24:53 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shNj8-0004p4-CA
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:24:52 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a86933829dcso188770066b.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 23:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724394289; x=1724999089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PZOOgz7uQIr0f5rSfdodIpxzU4J+C234VWKIA2Uc9Bs=;
 b=Bx08tJiEJuABclIVDUqCannv5X2OTwE5JsNoNdwYL3K89TYtmbivP34HEqRj0cwgeQ
 12smzDcemGeCGCNbIZ3Et2bXmiz9ZpWfgQ9563CgMslncrGy/aUDEUlzMZxYSo5EfgK+
 lbnOjAFcE4X7GWYgKeMhioCCREzUym7r2Myz2Wj9B5gcBEFYufuc7eRfsQVVWpQHME9D
 qDROUupd30KM/6215VAEPxEleZdFuy94RyxVAM58keeCk1v/c56xWSaCU+rGqXE8F7fw
 0pFctWeaeDoshz4OSyx9qpJiFO9o+DBnI6E8SDHAS+q+9TkO0VKlruPGhsQkdLKu/HyH
 jTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724394289; x=1724999089;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PZOOgz7uQIr0f5rSfdodIpxzU4J+C234VWKIA2Uc9Bs=;
 b=VWPWmu15i9H3YpCqGhXHd0lzZbKEpyNqq+ZKDWauXeMwEXkE2OVrcENlfZWOUx87DI
 TgMulia4NAT57mnDKApSrqsGOo3M0vN4s3tarPYtVcPJXFPzTxSJWmLmLVbd03I1ys2H
 irJPz44e4CJSR+j2WuEUr4WW1qMRFmT0wXHlwsrhJm1G5YwEo6TYaAOJqHE8a6XLNuLM
 Vs0ZoOqqkHPoZV112OXL9NdblSUIUTdQF8U9M2F1vyL8W8zjojM0sPj7WC0hfilnLT8W
 igCaNzlq13Alv3yt/jO4PLsRwjXWOsvi5GaY1/gNU5OuujVQLvmZfBhxQFs+2SWMGxMt
 X4ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuecZ9NdoIkRzT/YEMVV8FnNNqdpNykJAqxpb/mEPqFFpLf61rH7PvTct9WF2fTMzV03yyqjZaPQfq@nongnu.org
X-Gm-Message-State: AOJu0Yzry+6Ny6zpBdD7V7GOM8v8CHh0xZfD42ZZIG9WqdwHzi11X6QM
 e/8YZ0LGKU6yvTmnye5rqwang0zEbCi5WXY67DRmtJCHeaivWgvfB+tcL2Tvmqw=
X-Google-Smtp-Source: AGHT+IF2q9DqIRDUFo0VyvAkVXfxk5oxetbS8ePk6aQHHAOAsemVZSzdQ2vLQU9ggR7p1x1GSRMrvg==
X-Received: by 2002:a17:907:e606:b0:a86:96d1:d1f with SMTP id
 a640c23a62f3a-a86a52ba52emr83485866b.26.1724394288458; 
 Thu, 22 Aug 2024 23:24:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f47d31fsm212546266b.151.2024.08.22.23.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 23:24:47 -0700 (PDT)
Message-ID: <776a3b71-2495-40dd-a813-55000f997c2f@linaro.org>
Date: Fri, 23 Aug 2024 08:24:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/35] tests/functional: add a module for handling
 asset download & caching
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-15-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240821082748.65853-15-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

On 21/8/24 10:27, Thomas Huth wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The 'Asset' class is a simple module that declares a downloadable
> asset that can be cached locally. Downloads are stored in the user's
> home dir at ~/.cache/qemu/download, using a sha256 sum of the URL.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> [thuth: Drop sha1 support, use hash on file content for naming instead of URL,
>          add the possibility to specify the cache dir via environment variable]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/__init__.py |  1 +
>   tests/functional/qemu_test/asset.py    | 97 ++++++++++++++++++++++++++
>   2 files changed, 98 insertions(+)
>   create mode 100644 tests/functional/qemu_test/asset.py


> +    def fetch(self):
> +        if not self.cache_dir.exists():
> +            self.cache_dir.mkdir(parents=True, exist_ok=True)
> +
> +        if self.valid():
> +            self.log.debug("Using cached asset %s for %s",
> +                           self.cache_file, self.url)
> +            return str(self.cache_file)
> +
> +        self.log.info("Downloading %s to %s...", self.url, self.cache_file)
> +        tmp_cache_file = self.cache_file.with_suffix(".download")
> +
> +        try:
> +            resp = urllib.request.urlopen(self.url)
> +        except Exception as e:
> +            self.log.error("Unable to download %s: %s", self.url, e)
> +            raise
> +
> +        try:
> +            with tmp_cache_file.open("wb+") as dst:
> +                copyfileobj(resp, dst)
> +        except:
> +            tmp_cache_file.unlink()
> +            raise
> +        try:
> +            # Set these just for informational purposes
> +            os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
> +                        self.url.encode('utf8'))
> +            os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
> +                        self.hash.encode('utf8'))
> +        except Exception as e:
> +            self.log.info("Unable to set xattr on %s: %s", tmp_cache_file, e)

This line is annoying on macOS as it is logged for each file downloaded.
Is it really useful? Can we demote to DEBUG level or log it just once,
given all tmp_cache_files will always be on the same cache_dir thus
filesystem?

> +            pass


