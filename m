Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAF8CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNwm-0002xx-E7; Mon, 11 May 2026 06:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNwH-0002oW-9C
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:32:48 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNwD-0003gf-B3
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:32:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso37698155e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778495553; x=1779100353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AxFchPChBZqoxllwc2s3Hblldrqrne/9XqRt5Wx0d2Q=;
 b=oK+KwOd2AWcvZ6rYMVz6s13/EqlzshfchnZixkclBJwz4l8k93+pQcDYuYows5YKxv
 e+kAgq7kiqMtQGscs4fLhmXIQNVpM9Evktk1W8JTUD4BEcxN4cjlXurP5HBzD4fKxAeA
 D+8dTb6MT2lTHuLwmuUrwbKcPxsTQoWSDY2yqFJE73ws9yjt+oH0gOyp4HpwfuZEBY0H
 CUSC37y7W0v2jH4rtQrXtsRJJ8grMY1dYscg7obo+WobDxE5ahPAuiCwslWF0xtjgZ6F
 peznM7I4pTEBalazjaYyFlNYNFI1ejT4hzhq0wJdhptqHLFIvnVQrkXAR/Qb+8YfMoMs
 L24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778495553; x=1779100353;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AxFchPChBZqoxllwc2s3Hblldrqrne/9XqRt5Wx0d2Q=;
 b=khsdZv2AUpjqxZ9GIl1D5M5F3TR1hAgBbFi2XQQy2iqfIUmkCIK9B9l/GF8A1eVr+A
 GSrsok1ixL6tNWdYGivUr8dx/BGr9JO9erghIu4k2KYVdf9x1GTrm5RbM6q5u0sIVtra
 s7qAQzHTafIAIIKihqICWJpDMFiJoctRz3pIC9aWfZTJScn/IxO9vYs9DwewuqJOvz/S
 yg+jOxLNtKNpGYMFLgrHOap3cBmxJI48AV0yBZ+XuESI+QMbPimKCri0nB9Yvaa/r5Fb
 iVOa/q0yYUxDQN2LCH7awXisyw+V3c+B5te8iz5zQ8jMw0x0K0DElHDJEtfdB9FHxGsn
 fZxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cJ1raBL4cPhD+oUgmAYCu1GhBSAQQsuuGT8Cjo78DzyI8sXiXymPhbR139cUijqnUWqaWU9dAFg5x@nongnu.org
X-Gm-Message-State: AOJu0YwGjP9kEyK1e4Oc1/7WiDJAAQi+oCjqNWfQvTmn059XnIQ/TzS8
 SJz2CGoTc+kmiLSxO7vn7GZCbZLKmQq1P3/bqNaWn5tMt8PPdAp3b+pHHJF1FsBZzCE=
X-Gm-Gg: Acq92OHEsvgB9otOpGu4qgul/slAMXVUiLQii9yvaMQWqBaKyFC+ge7KbFH4VEcEdHd
 GMmBGT+Xi1VaYLNbwhscgVn33WopGeITlNC8J7pxHVLTgHWWA8qEHkeJ8eyTIsRIr756NnDLKL+
 eEwHZcfk8dTs8Re4ElPvqs4m6xwRkxyPIPLyUtV9mgLfzUWVmiiN5vkk7fqHoCUcw87aZ/5+zzs
 /0ol/5EMcJGVXmcYRU1s97uuvk8zUruxn3VUkC2oyP8PGzENzJVicosgpkYbS9FsIKMRqB9HhyA
 l3JNo7MK/6MhbAfrl+v9ubScOQvYJO7xtmNGNlDaygwCUnRQ4Z6Ack+j+/j1yF6JhN1uPNqN5i5
 VN9vsPYULpQFLN7rRiYGoPg4e+QmR9GiapHK2JhmKWQaSenSd7qJrVAbau7kFLYqjloOpbsYkIs
 K6SJCsxxC85jJ1foEAEk4700RQ0YFoufB+xRTi6HXNd38+KYYl78f+smjW3wv1qYnmag==
X-Received: by 2002:a05:600c:3b17:b0:488:acbc:b2e with SMTP id
 5b1f17b1804b1-48e51f32c94mr366846665e9.17.1778495552565; 
 Mon, 11 May 2026 03:32:32 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702ec426sm170327945e9.10.2026.05.11.03.32.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 03:32:31 -0700 (PDT)
Message-ID: <21b759b0-e72e-49c4-9e1a-112fdb8e1370@linaro.org>
Date: Mon, 11 May 2026 12:32:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] qom: have object_set_props_keyval return bool
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260508112429.643360-1-berrange@redhat.com>
 <20260508112429.643360-6-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260508112429.643360-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 8/5/26 13:24, Daniel P. Berrangé wrote:
> This matches the convention established by the object_set_props and
> object_set_propv methods.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qom/object.h    |  4 +++-
>   qom/object_interfaces.c | 13 +++++++++----
>   2 files changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

