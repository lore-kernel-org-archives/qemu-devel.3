Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC5EC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 12:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBw7w-0003wT-Du; Tue, 28 May 2024 08:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBw7n-0003s2-Po
 for qemu-devel@nongnu.org; Tue, 28 May 2024 08:40:21 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBw7h-0006jE-0p
 for qemu-devel@nongnu.org; Tue, 28 May 2024 08:40:15 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e9819a6327so9176831fa.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716900010; x=1717504810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BxvUUpbUGxOXZOk1HUQWJh0qCUJCPLPx6QBHYn2ClBY=;
 b=SP9N/c8L4MOdzsw/LWwK5qE3u32KrXi/cOwY5M2x5Kf6D8BkLtn32zlE/XRvHCS6Ef
 fvymaKxh2pXx+1XRLlbdSjPb+AfALcvRHeTNi7xneRgXAMo7LshT1NEeY7lSX3gYLC2t
 IqdmIXQkGfZqoEndLVhG4Rp4/DP4U+B2Nw7JlKIA3Cly7Z9cccEjZYPlNpjdoruJPg2o
 k2zN6hRgT95eEmGyrObf1JpLPQEyCa9Mj9Me3yHcP2jYHIbE8PARADxfylbt9wt198aS
 fhCVdiI7cc4W97Kp+O2fI6sARRreJEf+WKsfP2j1m4mTGj8Dy0eV35mChNS0SADRNKgC
 C4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716900010; x=1717504810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BxvUUpbUGxOXZOk1HUQWJh0qCUJCPLPx6QBHYn2ClBY=;
 b=TCWNLfyHQnMK4aFdQvjWOXeWCqf/otaFa42IouCY3E781OnqllA3jc9G8sZEQtlKzq
 Q9NkJBQuNoD+JJPwBGxCrm7JMJ48CIRAyCoEy8Khi+Ci1WBVHVIxl+OiWn70Lragh5Xj
 LkcOFfE3uh3tPJU0275DIrRTnf/x53lRj7MzaBGCTda7SmJkK7fkQo5/T/OVNSgF3ZMI
 Vu+i/TNmeAFge7kKWYoVSBxRw/PWe2ZPoOaK8NekAlpLzYO384QdeHyppgbnLTMdfx+l
 3gZO/hhww5CiwPqp/AM4GJGpVk5aeBA0sFN7yiJFkJuxto01iylaJj2lkqGS4WOTEAiA
 wfjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbyTZ86dt2NCy4QkhqyUNA1+WdwYHtCjLcc0awckLhcSGk7p8Xx2rMZKHEtlOF2Vh57QqgfrK/1CRIzFbwSgOZ1JBC0Og=
X-Gm-Message-State: AOJu0Ywi9whwXSIdx7a8k2ENMH9pIX9bbzbLMW4l7zLncqEX35Iyl/7z
 DQH8z1uWfUYCpebbnZRRs0GorQEbEG3e6rp5liAaSrU+/1CQdM9rHNCoTzOYGpc=
X-Google-Smtp-Source: AGHT+IH9F2kmwYW0qZOYWHPoua5sg5eXh9HJCAgtFEfHOHqZeX1ag2YKpP2PjrYoCztassnb9If/ag==
X-Received: by 2002:a2e:3308:0:b0:2df:fa4a:ef15 with SMTP id
 38308e7fff4ca-2e95b24dec7mr77064961fa.39.1716900010504; 
 Tue, 28 May 2024 05:40:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.214.26])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fad6ccsm173571545e9.32.2024.05.28.05.40.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 05:40:09 -0700 (PDT)
Message-ID: <f3c1220a-c613-4c05-82a9-c99850a2a8c7@linaro.org>
Date: Tue, 28 May 2024 14:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/12] tests/qtest/vhost-user-test: add a test case for
 memory-backend-shm
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, gmaglione@redhat.com,
 Raphael Norwitz <raphael@enfabrica.net>, Laurent Vivier
 <lvivier@redhat.com>, Brad Smith <brad@comstyle.com>, slp@redhat.com,
 stefanha@redhat.com, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240528103543.145412-1-sgarzare@redhat.com>
 <20240528103836.146338-1-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240528103836.146338-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 28/5/24 12:38, Stefano Garzarella wrote:
> `memory-backend-shm` can be used with vhost-user devices, so let's
> add a new test case for it.
> 
> Acked-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   tests/qtest/vhost-user-test.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


