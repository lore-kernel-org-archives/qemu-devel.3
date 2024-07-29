Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C719DC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPo3-0000vB-JM; Mon, 29 Jul 2024 08:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYPo1-0000uV-Q0
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:48:49 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYPnq-0004fV-A5
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:48:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4280bbdad3dso16708805e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 05:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722257316; x=1722862116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z2EStrleTeeleDlySJ4oWmBhlW2TkIR4Elyvbtua6eo=;
 b=AckyxqulP+DFGAdvet+uiGRSlwIvPvlpwZWjDsau2djjsFcomyVporeShx9vcEZSjR
 m3Vfr6y0IaxW7ZQeL3eNTTUbJk4uIuQ9YMM9NOF0qMLfzHYe6Nnu86ZtB3uBqSNt/lFK
 A2xc2wmSkkgz5da7vf7jpicgA5vCN9/6td1g0YZsj+DWBbDwIjITn6MQwWTSQYY1nOS4
 pvHaSMw13I/sHwS6uRP7SbOllPnDqDsEKW8Xt77FgOMQAJk1FaytsP2FxZJKesYq1zm2
 0jwL4VYQUvb2ug2deiF7l9lZlYSyBsaWCFH/z1rjOlwb/+sYt1r54Cy4sJ8VoNcxe0N8
 LVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722257316; x=1722862116;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z2EStrleTeeleDlySJ4oWmBhlW2TkIR4Elyvbtua6eo=;
 b=XoF6SPcKKa9GHSI/NoAGM9bbUCW2+46Pz3BPqc3CTc/CK5+c8y+2aMh2NrDtHTJPmi
 fneYA3WAGpdhqrjJT89cEW274B/8reFhUMIgMZc/CeMNfsO+87HUjJmEsP+6hIHRqAuD
 S4IrpXUCJZvey7np5chdKmF4Y2KDXNzHdh9DV1al4Q5zFoOeklDkfY+tQRCGQ8IkzRPt
 4pI9YT9qWlZeJA6Ts7po5A5zuBbm/KTHTK7GcFH7mFwwOO1DremjfxebThfSuFY8B/aF
 70EfCmWAvhkgzIELwHbcgd8dy3AB+NPZuqOf7mdmdlkFROkn4DNQ8DnreLTWErIGcfHy
 z+eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8571BbhKBq2K5RergbkYs6+oTb+FGWMis587lSUp9uQBRJ6663GsRKuIxvj5/kBCK0+to0qqK4QEgoPaWEIP2gZZE/bw=
X-Gm-Message-State: AOJu0YyD3Q3nvL09WyxpNff6J8SxDSeZdnubn2DkYkC1obMKWonzpFIX
 SMa02YOlesRWw7WhcIHnwlbeozrp2bwmI3K/RB5yqlWRk0Ra6PrpHWVZAexlUas=
X-Google-Smtp-Source: AGHT+IHU0ebfF7lFyclbhbiU0WKQWYQxjpToCix0do8oNlkd2r+4Qpp904lsTim1qcm5edirq3ldug==
X-Received: by 2002:a05:600c:1550:b0:426:668f:5eca with SMTP id
 5b1f17b1804b1-42811d6dc2fmr46702495e9.7.1722257316316; 
 Mon, 29 Jul 2024 05:48:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f92c7cb3sm219830115e9.0.2024.07.29.05.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 05:48:35 -0700 (PDT)
Message-ID: <a23d8e15-5174-4bce-9beb-b9b20a075b6f@linaro.org>
Date: Mon, 29 Jul 2024 14:48:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/23] tests/functional: Convert the
 x86_cpu_model_versions test
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-14-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724175248.1389201-14-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 24/7/24 19:52, Thomas Huth wrote:
> Nothing thrilling in here, it's just a straight forward conversion.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/meson.build                  |  1 +
>   .../test_x86_cpu_model_versions.py}           | 63 ++++++-------------
>   2 files changed, 20 insertions(+), 44 deletions(-)
>   rename tests/{avocado/x86_cpu_model_versions.py => functional/test_x86_cpu_model_versions.py} (92%)
>   mode change 100644 => 100755

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


