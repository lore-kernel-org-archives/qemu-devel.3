Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D72D3516F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sUr-0006px-RQ; Wed, 01 Apr 2026 06:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sUq-0006pk-PD
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:08:24 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sUp-0002jV-4n
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:08:24 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so1575760f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 03:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775038101; x=1775642901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uJb6GbXHvEGOULJXwHH+0m2FVUWWojif4hPs22Jm074=;
 b=QhlffeB+5ewJMbU1DojPXwonsLVQHpRIhqJFhA9Ke2/IMypZYmAFX4sDMj+ynP0F3C
 Ay6Bm6wt4vPWpj79xOLgLqi7l0oVScJO2OJ5529rP7Gk+dZjbrFWVWTx6eH7yVKYRCfM
 vvYQQpVn5eREoQyyLppWqdwglL/TERzIBzH2+l4ureHOaoihZOOil5CtDxy1du5aSNkh
 /PV7nD11LQWm0XZIHos9NGlX+MPN34afPCzmyqmp02DhY4RNsZKVlhQq1iLKbiUoBDl0
 OjOxzFJEmUVvaKC/qHSXfk8CR4EoVn4KwI7jZ+hasEH+DX+yjsXT32EwRVu8RmO2lnt/
 zrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775038101; x=1775642901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uJb6GbXHvEGOULJXwHH+0m2FVUWWojif4hPs22Jm074=;
 b=V/sEu6pXB2ULoJmQpFjEDSnET75TDqvmnTYNL/HC/sbbmv2RSnFHqBfaFMFFY0VBhP
 kbwdgD2ywDRq/aLkpcoG1qrzLA5DyoDfLNfCaIBge5HHwlGuOHKjL+fOhsCkfPJasSPy
 fQFa+WR/ksocoTscFJUcm/WKm7kP/K8yha+CDdHmgInxmsuE10HSczGjxuq00kCqRlSF
 pUyG3FI+FfGoiW9EduZ1Oy31HwpwBSjTQS41GzOvi92ijaOVUBYJJ9vVIg93cjQu1LAc
 co2F9STFep0fZRBhGNr2ckkap7dqxsKsOdq8FCKr6AWHzU7IXUJtgAL2yfojNFAPrdFg
 xdBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHhyonCXz5xxG845OHWWsuvktD0w1t4C5OjtHmDfFN0LQEq1qN5k5O8gkY3FjKxH3jAvZlU6xZVTes@nongnu.org
X-Gm-Message-State: AOJu0Yzz7+7iYoTFPFksZXK4JtNALvpEmbgTTd5GJM+0noidtk+hWCyB
 GGgC7asynikEI5rw0q7tYuNRDmd53zVYHcOhQFmDfBUUtMcUx2eEWnX3BzQhoA0cUaU=
X-Gm-Gg: ATEYQzy8Xmdhp2DcpR1XbJXz955YYhtEvatnzJDBWVSH7zcM0DEgGtTtXHzhi0C1ARI
 SEFCgK0+0d8LasNmJFIqtYje/o5I9TFPkXaRHRN8ISjMfKLaq7sWaY+w1HAuZ2dARVJ3qhJDiQ2
 BGq98ynaVYZeEIGu5M7TRgomBGDkH6zEcWNva8VhAPw/9Ujzy3MLpxYKR1oMIeUEzejBePr2Ivx
 0FikJsbS7t+eTzyO+vjbvsJ9nhMdv6sfnVR5lgLb5rjyvOXQxIr1K4irmwzqnIaJ8IcOhj9CBUa
 mImz8Zj1DxA7cQq7w90WuFF0RFxBZIwM8PYJrOdzCTQHPtOUGJz/Thgmc4Pbm+A6vfMfomV34cr
 w28NM5/PPizvwwF39bJIh5zc8M+GZ9mGDYW/EjlUA9G3JbsrsH21pxNT+M2vrogp0rb14jaFRA7
 BGg1Y8QJdc03Ssuw9+3a03RTnchF/bYj7+6E4VJGGt9X4iUoyU2Z8DkHhs8mJibTXClQ==
X-Received: by 2002:a05:6000:230c:b0:43c:e7a7:9256 with SMTP id
 ffacd0b85a97d-43d150513d6mr5248770f8f.12.1775038101030; 
 Wed, 01 Apr 2026 03:08:21 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf245e2f6sm35881062f8f.18.2026.04.01.03.08.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 03:08:20 -0700 (PDT)
Message-ID: <23eeccfd-c11d-4b85-830b-961fd264df9c@linaro.org>
Date: Wed, 1 Apr 2026 12:08:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] tests/qtest: remove -audio none when configured
 with --disable-audio
Content-Language: en-US
To: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260315201646.96862-1-heifetz@yandex-team.com>
 <20260315201646.96862-4-heifetz@yandex-team.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260315201646.96862-4-heifetz@yandex-team.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 15/3/26 21:16, Sergei Heifetz wrote:
> It does not matter much whether `-audio none` is passed. In the future,
> support for `-audio none` with `--disable-audio` will be dropped, so we
> should remove it beforehand.
> 
> (We could preserve `-audio none` with `--disable-audio` for compatibility
> reasons, but we choose not to because they have different meanings:
> `--disable-audio` will eventually mean having no audio backend at all,
> while `-audio none` means using the `none` audio backend.)
> 
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/qtest/libqtest.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 051faf31e14..a59fdaf3973 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -464,7 +464,9 @@ gchar *qtest_qemu_args(const char *extra_args)
>                         "-chardev socket,path=%s,id=char0 "
>                         "-mon chardev=char0,mode=control "
>                         "-display none "
> +#ifdef CONFIG_AUDIO
>                         "-audio none "
> +#endif

IMHO if we implement using stubs as suggested in the previous patch
review, "-audio none" is stubbed code so no change needed here.

