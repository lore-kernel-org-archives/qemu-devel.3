Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BA3C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KQw-0003l3-Li; Fri, 25 Apr 2025 10:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KQs-0003eo-M9
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 10:53:39 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KQq-0007q9-MU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 10:53:38 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso1453246f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745592815; x=1746197615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wf9Oi6RXI8od/ky+2U6tBOV5Z9gdYLa8whtijbKV9xA=;
 b=GHwsR1GEpQUswl6NbZk26lB7J5yv/7j6XutmHFzF4RUmkeiLrXN+0jQn0M57lkAZ4y
 /u/rk3bM+sNhUVEtOu4yZe2HD6e/YTRGf4EULmubhU2fdTyw0ga+xeTC19ApnJQOPY28
 q/HGkyqCLPUDuogf59M/NVXXtctKjphiYeu6SR3iHtS5BFWWTgaGztRqzccOGtOs34LN
 ldv0IOMGAQPWVOzxIyv3T5ACA/KFaUpgpBS4TddXRalWd2wd84AfE++IjY+dXRm8jXJs
 ldbzMLLGO0OCYAYxfoeuOoxsow841mARf06+seBs6F1z+nv0+I7dQ3oKL66qelNe7hvA
 qzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745592815; x=1746197615;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wf9Oi6RXI8od/ky+2U6tBOV5Z9gdYLa8whtijbKV9xA=;
 b=ulx0TmCfVutQ8Yu8NGzy4BJWb5E9nuszqz0jDVUswiKJG2qhiTxGoNNuhnqwizS7L6
 /4oRexUQRTU5wIbVvt/Y+Xuu/FXXOZIQq9Ej1BaAgkGCigtcrtHCu5In0fzHuNaONe5M
 vTjhhcNxvcTA6jIKIynhShEXgs495zbaPiqROSraqES/iBFEllVoQV5ZO93IlpWe3YtX
 Iu8gPz9pI0q7Evj8mGbYZh/cKr57jpmL9aRgpcOtDfwY1NBLU+YDlohcO9AlQPZ3aoHA
 ORkDjMmsATUPidPR/E9ELZombprvaYo7wGedBVMz/EHoY1n7wzg2OM19CP2AYoznePB8
 rogA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyqD4VbzL9hFwK2TzLg8OIO5q8jhkKklqC0j6JDEB1ixALyzCk2r4wdpVsVY9edxs6AURUy7BxCWRd@nongnu.org
X-Gm-Message-State: AOJu0YwYx2ckDofaGljAbwFriGjj0ZU/pkUut6qZyoe7BNjQoNLVpDm2
 5nSvRkU4tBk/Z3Stw8tftnEyrfBxNvkfRiGZDH5U5wSLgzHTZ/QyhUzChfPPhIs=
X-Gm-Gg: ASbGncvMcSDakbDCuY8kGDBCN21GKu9FSOfkEoemtt683/0r8PHqTctwPzkTgi1bJPf
 JFwDG9kDRaZYAZeGSXlly8HpvE2jWItdESxfHAYcbixjiMkyuJuJdgOIY9IGRSf1kg6QU7GJmdr
 hMP3pVo86xkQBVgHJJEZv6rq8bWso0p9g9/P5cCFohXCGe95wKgOGwvkOU9jCljnBacQET7AshF
 p1L4cpSDYJfOEf/QANkZB1fjMNyRfQ541ZEqvXxuXPSqTIVgdxzNeiNkuLEj+b+M8KhfHABiyc2
 mAtCnXzPUuBru2AdABxNjNwaB3yW6RWMqI68DXX1EBTObiJdw+LSYpctrMGUMd9cW80XcMdyFca
 0bjRJ7REz
X-Google-Smtp-Source: AGHT+IHU6OdKhIhGldbUGA9NCxoGCkDJIm8moWgxc0hzHo+BeqQdWwtHxgbEmEbz6YCbQ41bwhW77A==
X-Received: by 2002:a05:6000:4028:b0:39e:cbf3:2660 with SMTP id
 ffacd0b85a97d-3a074e0dea0mr1974523f8f.3.1745592815067; 
 Fri, 25 Apr 2025 07:53:35 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8ca72sm2543614f8f.4.2025.04.25.07.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 07:53:34 -0700 (PDT)
Message-ID: <554241c9-1bc7-4b05-8c1c-a80cd44d2ae9@linaro.org>
Date: Fri, 25 Apr 2025 16:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/20] qom/object.c: Fix type conflict of GLib function
 pointers
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
 <8ca13f4e2b9eba9d1f6030b0afb442a24330e463.1745295397.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8ca13f4e2b9eba9d1f6030b0afb442a24330e463.1745295397.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 22/4/25 07:27, Kohei Tokunaga wrote:
> On Emscripten, function pointer casts can result in runtime failures due to
> strict function signature checks. This affects the use of g_list_sort and
> g_slist_sort, which internally perform function pointer casts that are not
> supported by Emscripten. To avoid these issues, g_list_sort_with_data and
> g_slist_sort_with_data should be used instead, as they do not rely on
> function pointer casting.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   qom/object.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

