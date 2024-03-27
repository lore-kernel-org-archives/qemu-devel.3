Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D498CCD1283
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 19:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpZ9R-0005OW-3V; Wed, 27 Mar 2024 15:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpZ9P-0005O1-7b
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 15:41:31 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpZ9N-00078c-QO
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 15:41:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e73e8bdea2so233673b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 12:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711568487; x=1712173287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Deg2ir5sWis3phHVCg4N9dYJAIiflp+I2EsGLd/qvyg=;
 b=GOX28xL2y9ob2kWBaSma514O87uq/kbHuBJIHKslvUJhkXIaZdKrFJb3oO1VloiH9i
 8RP0CEo4lTRiy8fnBU6QPH8SafmirkDffgwHMqtzvEgPaQ85egxngPyTfK6AkQSZ5tJs
 KqId32Pmn5VKrFVqxKxrM9AnTmy0YvvOwMw0EJ9vnc2Q87h0Hh28g9WZca5hPj5WKCz1
 0gwEfAqna3h19FM0jcVaotzFoAxB2Nktwh3+kXM7fE9fFsNq2wxQDJ/mYSxlZNVqoJ/R
 8O7eHYzbnfjxr3Mz55prsJkyTiclAYM8D/Zdq5GxtAo+jHM9lS6PRtbYZ2VvQsk/gf2i
 nmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711568487; x=1712173287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Deg2ir5sWis3phHVCg4N9dYJAIiflp+I2EsGLd/qvyg=;
 b=tQ0a/ilcoxRu6NjFHoUlnsxLZFO3sBXeyzHAzThjGQjNPcAKxUMjzWv9R17mM64IDp
 YZekxWWcuEI/lSW0ktXqoVHAjxlGqj+LaAtSnCmfgYBNdTqbO5pYpnpahIbmXJJmcueY
 iroaF0PyRRb1DAbn9Wq3qTng27fwRfredyNtN+xP9QzRp9oRZdmj6VN9LGcwJtqBxL2P
 MUZBuh0h28UfaJw+tnXeqO+O0SleVx6GBl3/OPIxDW2gUhNyjyaqe+jJMGIwYxyP1D1P
 0QdVUoct+w+Qfn+V9GwZCobQr87zO559KJFz3Z/CIGK7IlyrXxf4phZYZYHvN/uyQeiY
 djGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL9uk9jgpUnMOBuXFG0dfZQsCrArlIkzB4sEArOT5Xj/R8h3amBbzjhF9LzW9VMReRegoOIh4p/q+nB+OUqYiyJd5anGY=
X-Gm-Message-State: AOJu0YwpV1pESoCPo1RyrcHwvUvbUHOsu/vn09QWLsjqcNOGURkT5iWP
 /sQEwXhMdexG5yW6tQNlvrIHvEsyGyHYzOM45aaDmvoRL6gH5kqUxzZjlL6o5lA=
X-Google-Smtp-Source: AGHT+IGOQDuOKNiTFQrXd37ruEPE+HLDkEYgqV8WP67ue+SOib12LCkE7GZXTgUq+Aou8/mDJlv8dQ==
X-Received: by 2002:a05:6a20:7f99:b0:1a3:c622:f509 with SMTP id
 d25-20020a056a207f9900b001a3c622f509mr1412635pzj.51.1711568486816; 
 Wed, 27 Mar 2024 12:41:26 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 f4-20020a63e304000000b005dc49afed53sm9803778pgh.55.2024.03.27.12.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 12:41:26 -0700 (PDT)
Message-ID: <296063ca-cea6-42ca-9acb-1da4a02a6afe@linaro.org>
Date: Wed, 27 Mar 2024 09:41:13 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? v2 1/3] fpu/softfloat: Remove mention of TILE-Gx
 target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Marek Vasut <marex@denx.de>, Laurent Vivier <laurent@vivier.eu>,
 Chris Wulff <crwulff@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240327144806.11319-1-philmd@linaro.org>
 <20240327144806.11319-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240327144806.11319-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 3/27/24 04:48, Philippe Mathieu-Daudé wrote:
> TILE-Gx has been removed during the v6.0 release (see
> commit 2cc1a90166 "Remove deprecated target tilegx"),
> no need to mention it in the list of "supported targets".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   fpu/softfloat-specialize.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

