Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC221C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgjN-0003aG-5t; Sun, 04 May 2025 17:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBgjK-0003a0-Mv
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:18:34 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBgjG-0000bL-I9
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:18:32 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso5347174b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746393508; x=1746998308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XL9Dp+3Ijo9o4E7lEJHRkNbVrgZrOjZ3VFlMuZDYPYU=;
 b=B+RyJOXUAMsz3gEI7TdzibCLDG/HStrvF/X8m8F2yQLZ27zTFggNfz2LZ3Ok41Rr/8
 dBTD7Ygo6cGYAL+IBSeRjVhfwCS/brdMGZWo+9ZC/kLqMKR3sZj6IVSClECklYS7dHB+
 63198roqaFfNoSPVJVTjDlQdN4je3KVoZk7yQUTnu1tN3dottFOiQ4yma8GLFS3jSKmH
 VFGdD2iXNpL/eiIL/3SNYZmX0CCYRolta83M/jdzOKDpKj/+qEJGWHOMLFc0/HarKkST
 q3iweNuWxMi98oZZPBSYMBr0PSUJyIHeb2LYro6wfHLaYjZXUhutDUymAyUVUzFRdF1I
 eG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746393508; x=1746998308;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XL9Dp+3Ijo9o4E7lEJHRkNbVrgZrOjZ3VFlMuZDYPYU=;
 b=lTsP5QNK0TmgOKB46J9Z4VpB3RzvWAQTfL1HhU30UX8jgS87pk8FvWJDtdMYahFvjM
 mQ61ivB9ynlguYQSONwXoEVLlhTKXK+mO5f2K6d8en6AY8iSjpeQROm44zUANrTz3t5B
 JerDZvR7JCjcXFXHYL7aERYU3CqFSoePmH2ZeJ3iIc936DEHNSBfu/9fZYD9Wjjm2Z7p
 YCMvOLXyjQl1fZFRbbECTk7fT2Gf9WP7iEUvgDPd5e4sO2bl5eU6E/OIn4Jo/OXZvCjf
 zJ44gdxiWIpry0OLKyLZJCM+xYGVVrG4VVvyoJz9FN1WmN8qtwtIMLqLjRGbVdeQBQIc
 lVxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFJRUPir/WthQyevdnGcjfFJl3HheH3viZSUwMxP6FkSrTFK3Rj9xtpsgZTErLCaKEKtddUas673Uh@nongnu.org
X-Gm-Message-State: AOJu0YzyPOYqHuYHb9w/FHsQEqpphbvV3LUyA87SWgN8+GKLR9lDsPn4
 2tHRbInmmENA7nqJw4aSupsg4Luf9Y1ZTrqQh3pbo+BdGAxv/hXEV+cOVoz95Zo=
X-Gm-Gg: ASbGnctvA1tChRWXg//p3JwSIAj5Zl+Xo2m0roa6+Y1/VYyCfoLIZvtTglaqy17mbZY
 JP81L52h8HxR0fqgKQV4kzIIh3NH4qhaN5GwWpl/YRSBISKA6kZEfeUqvbPc1AN5VcGtEjpbfvl
 3TCpJdcR+ZVBlzEyNQIQPlmgK3onysF1kJo/jjFmtftKs1Djfn3R840wWnl41F72Uu4z8x1jNHx
 bRE7lrT3AV+F+haHAlEXrW/INxPLnL+vEIsFK8KR0SxvOVZ0QbmpaTDMUe8YqMb9upH+f0rsm/j
 AJ/HUQu0qNC1J9coE33HiyJAYHZ4+mUzk9zAZ0NlQGD6YvsmDFGFuA==
X-Google-Smtp-Source: AGHT+IE07EJkdNhsyk0pLI7qJlxhEjtV/w030yjvwQEcCmejOc99t3R7tRfb3LerRPeqNoTBwl6B3Q==
X-Received: by 2002:aa7:9304:0:b0:736:31cf:2590 with SMTP id
 d2e1a72fcca58-7406f164a6bmr7399845b3a.16.1746393508649; 
 Sun, 04 May 2025 14:18:28 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058df43c8sm5294678b3a.84.2025.05.04.14.18.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 14:18:28 -0700 (PDT)
Message-ID: <eab4b9ab-8c1d-49fd-8f7d-a835b84e8639@linaro.org>
Date: Sun, 4 May 2025 14:18:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_HAS_LEGACY_GUESTS to runtime
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20250502214551.80401-1-philmd@linaro.org>
 <20250502214551.80401-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250502214551.80401-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 5/2/25 2:45 PM, Philippe Mathieu-Daudé wrote:
> Check legacy guests support at runtime: instead of evaluating
> the VIRTIO_MEM_HAS_LEGACY_GUESTS definition at compile time,
> call target_system_arch() to detect which target is being run at
> runtime. Register virtio_mem_legacy_guests_properties[] at runtime.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/virtio-mem.c | 77 ++++++++++++++++++++++++------------------
>   1 file changed, 44 insertions(+), 33 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


