Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B989CC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 06:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77KP-0000zb-LL; Tue, 22 Apr 2025 02:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77KD-0000p8-PC
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:41:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77K2-0007p0-Ix
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:41:41 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so2458679f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 23:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745304093; x=1745908893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YweAujch6X+IzetnIcpOjGXiSDNATL6ECW1Z8embAd8=;
 b=ow9MxQ0cROdSHPeFPh5PPSPtA+0Q4i6LstUVqGIginKDVRWiskOehL4ODNs3iqW6JQ
 ySRaWa5gUYxlmkQ1ool8TrjJ2EQx8fD0YSG+G/qWsbF2/iojsjSsNtxwaZf6DrmGRoMw
 7GMIaoawu81ctOhHBaCqV1YGGr822jEExWfMd3/Vz5UBu5+glOUDs8I9DL6vH1IOSMR3
 CxOBmHjnVUx5p7o2raAiz3/ym2TU0MjId+2JMpej4W8tSv9DvDmCVlUqY+5T1l/B6VW2
 MEDMRImdv91KtDao5VGj0u1CCns2pa1B8AsmZrrOIAHGUEhTok92mqkDgklnzu+3Yu3P
 Fibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745304093; x=1745908893;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YweAujch6X+IzetnIcpOjGXiSDNATL6ECW1Z8embAd8=;
 b=Q4OeLyiLRiDM7mNfvs5HPzKWnN+tFR/NyO7+XdT5Mgq1Q4pRVO8S5YhuETdKJ4fx+N
 MVCT9bVM34Vav9//WEy0kSJbUubmanKwvWyTCkl2iUl2FLp+4yUXVDiJVTlSONcCBkWc
 3q+IMvLqYLt2I7I0QOzvzs2Yh22mbAhKJpsO93xBxMBbWWR1GFmxYoU1WyxbzrTTBGZL
 8kZ6IebWP8QdgWx2rMu5xxRdBIo2t3M9YHxSQcON88X7h57uaA62zeuDR6BMj6pF1P9D
 3zPTHq7WKIBbB9wH48rizrKF2z1Z1x4mvKsQwpOIqhiId5bOBEyctICS/InYwEQVVLB+
 dOag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmrH6FXq/Hv9dqjKx1RNX3rTD3OzD7bhuThMqHwGmcih09rd8tdywDA9CniGhyk6wWlx/XQYxCGe3/@nongnu.org
X-Gm-Message-State: AOJu0Yw82LysEhjYy0jmccNoKtjo8I8nlGjiUL5oy+X8G11m5Xr6P1k6
 qqTbVRY5JPM5QRk1YDXmpCpDEE0BSpX7KNfe173wr09UW9qqF8cMmsS2QeBJnM4=
X-Gm-Gg: ASbGncusUBsrwFimtDvD/Cp4r2c0sE/NO4ZzHuZN4fR59UYQWqm6Esr8CehkuX61GQE
 QyMriom2LF+1E3Xltm+Wqlf0aTjw9Lgt9BbTlLGsVCtSXYiBI4zpEGXXMS8D0VutJVMpfKqZdOl
 TqNru6WvbAVzAX/CdctqeH75tIhpZIC3wH3Kjo32Bgg7cKbH92DKdzRAJjYFElel454A4d9+JAL
 7zd5qO28c3IDT5YPW0B+J1C5/0v2Qw/jBQ5BfFqX2Cu2/XnLsgnAP0D+F6zxjw6HQ/9ZJMVISIC
 RevkMui7Xt3/m8AjLMDKw+ZVvaTHlXAKLRlLbggdPEfjo+qWLadtKuET95OjXLaEbkU5osR57yQ
 nWzjtWCVt
X-Google-Smtp-Source: AGHT+IHzjEl+8lPmhKSabXC0zUI9tf5BnCeJoTQo1HR1FIk+Do0DmX0vATxLBq/9dEodEtSs6ecG7w==
X-Received: by 2002:a5d:6da5:0:b0:391:3aaf:1d5f with SMTP id
 ffacd0b85a97d-39efbb09d5bmr11235926f8f.52.1745304092791; 
 Mon, 21 Apr 2025 23:41:32 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acca9sm161223325e9.12.2025.04.21.23.41.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 23:41:32 -0700 (PDT)
Message-ID: <7907635a-7486-4bd1-b040-5c5208495452@linaro.org>
Date: Tue, 22 Apr 2025 08:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] hw/core/loader.c: Fix type conflict of GLib
 function pointers
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
 <26dfe9191154ca65dca6ef51ce768ad2a0c30d5f.1745295397.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <26dfe9191154ca65dca6ef51ce768ad2a0c30d5f.1745295397.git.ktokunaga.mail@gmail.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
>   hw/core/loader.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


