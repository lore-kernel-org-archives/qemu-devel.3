Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243D6C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 03:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXYVK-00019R-46; Tue, 06 Feb 2024 22:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXYVI-00016Z-Aa
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:21:40 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXYVG-0007RN-0p
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:21:39 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d8ef977f1eso1868515ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 19:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707276095; x=1707880895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ut0mdhuOw19C4ktbIgM8zys3AStfoIFnjh+Ho8GeaVM=;
 b=Q/cyDjaeYpLCNuxKHBMiyYF33BQIp1LdUfDQeRi+BuqLnsX8HM+HBz61MeYk8UAvHp
 tzFJrJHCaVBSX0yZR+6WCs8BLAFGRnvHW1XWJmzJ1IJ8XKH5PcLyPc0jRcWtyfFYDifM
 C+IdEHxbxGdf+7tJUtyvImnSqX9dmLtE9opejdnpkcV6+syfXQ4FDXRw2zzPTRtYiipF
 k+45qx5vB/ywZgQClBAwX6ME4W4Ejxe3GvqLmElKmlYhT6h2Xz6AVLdBZTt+0YVX/76d
 C6iLnZ75KiYUefdAcGAT2M4YX6/PuFzRsGrglG03gyqSVUPadLYIxjgIX2nNG14VFJ61
 E80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707276095; x=1707880895;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ut0mdhuOw19C4ktbIgM8zys3AStfoIFnjh+Ho8GeaVM=;
 b=AbqjlynlOfqn0ubW4XhzhlIpJln8ts+GnGVldw0+YmI8u8V3WBHptYhEYAz53BU5Uh
 /lZ1hup31NFo61Rsr2s7V1jLIJIhRD8EuZYvEGpnHbmQp2nGjdp33DCRmqFHt0OJ6fR+
 Bp5V4eKdnEbr0mSUtwdE3eEPqe3ZbbKIpfE5/MStdSJ0Yr862OEZUdONlnUWMmK34gy1
 pPhns+mCT4GIAqI+PPKFATnkHy5O5Pp/bmxSfO7XSmfpsRb4jH66W2uNgSJeYBpcdKDd
 rubQZTTbCYxHS4VJNYU9KIox4cdsx14iPbk/+R40OZGGOxi6YfixoYCDOSbmqiVFXjz8
 e2BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgTd3VywSMM5mtPVVWrDP+TytiaEcde9j8XcJlO8OMst6Gc+NVETSzxwsOCfl1ejxzTauB+WKxeib2y8n2nNAaaEXzncg=
X-Gm-Message-State: AOJu0Yyx90Z9iGSp6OIJ4qEWkjcuZmpmxHoWPr+DAAic7p6bpwUOsP8w
 TJK7YVAFjQ16538jjpJ5yLYIalhQlDNHGLwvnUnel0/0G1OXH+cRL0w5a76WioE=
X-Google-Smtp-Source: AGHT+IF91akSQnEnX4pWka0pmpH36P8U9BZCesYDtSsvd8rm8MxjnwV+A9yaNp7w5suZxbsBN64IcQ==
X-Received: by 2002:a17:903:98f:b0:1d9:df9a:3e7e with SMTP id
 mb15-20020a170903098f00b001d9df9a3e7emr3738611plb.36.1707276095005; 
 Tue, 06 Feb 2024 19:21:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXEpkHpIZYSysYCnw0ZsHoCEZa4N3/qP3s0c9+4FR5HTREM09d7t/Jy0gkrfaOi66KMbBGHLyFSSuzvXjYeZ4Kt11W2PeNr6zCl7K2Lk1r/sRKQ2nsJzW8c7VPzPmAIex2ZyqzPnhxQT+/Xtii6N75f+yyMZqPSgZg7utLmCXGyPFbgeg/2qgOMVsgnH7D1yFOlp5cDD0NohoIiDRXQmNiayT3wpfexkLV9aKdg0EqrIc0OQkYadQYcTzkN1yGiUZEvDmPv/KtlCCyDubCfvq470dXm9Nyj80Q2+SmZOohI8jp+pQ==
Received: from [192.168.188.227] (60-242-98-186.static.tpgi.com.au.
 [60.242.98.186]) by smtp.gmail.com with ESMTPSA id
 r1-20020a170903410100b001d8f81ecebesm277656pld.192.2024.02.06.19.21.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 19:21:34 -0800 (PST)
Message-ID: <e4db51de-a040-4c9e-93fa-64a378e4e5fa@linaro.org>
Date: Wed, 7 Feb 2024 13:21:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/17] plugins: scoreboard API
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
 <20240206092423.3005995-6-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206092423.3005995-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 2/6/24 19:24, Pierrick Bouvier wrote:
> We introduce a cpu local storage, automatically managed (and extended)
> by QEMU itself. Plugin allocate a scoreboard, and don't have to deal
> with how many cpus are launched.
> 
> This API will be used by new inline functions but callbacks can benefit
> from this as well. This way, they can operate without a global lock for
> simple operations.
> 
> At any point during execution, any scoreboard will be dimensioned with
> at least qemu_plugin_num_vcpus entries.
> 
> New functions:
> - qemu_plugin_scoreboard_find
> - qemu_plugin_scoreboard_free
> - qemu_plugin_scoreboard_new
> 
> In more, we define a qemu_plugin_u64, which is a simple struct holding
> a pointer to a scoreboard, and a given offset.
> This allows to have a scoreboard containing structs, without having to
> bring offset for all operations on a specific field.
> 
> Since most of the plugins are simply collecting a sum of per-cpu values,
> qemu_plugin_u64 directly support this operation as well.
> 
> New functions:
> - qemu_plugin_u64_add
> - qemu_plugin_u64_get
> - qemu_plugin_u64_set
> - qemu_plugin_u64_sum
> New macros:
> - qemu_plugin_scoreboard_u64
> - qemu_plugin_scoreboard_u64_in_struct

I think the u64 stuff should be a second patch built upon the basic scoreboard support.

> +/* A scoreboard is an array of values, indexed by vcpu_index */
> +struct qemu_plugin_scoreboard {
> +    GArray *data;
> +};

Unnecessary?  Generates an extra pointer dereference for no apparent benefit. 
Alternately, might be useful for other data structure changes...

> +/**
> + * typedef qemu_plugin_u64 - uint64_t member of an entry in a scoreboard
> + *
> + * This field allows to access a specific uint64_t member in one given entry,
> + * located at a specified offset. Inline operations expect this as entry.
> + */
> +typedef struct {
> +    struct qemu_plugin_scoreboard *score;

Embed the struct instead?

> @@ -31,6 +31,9 @@ struct qemu_plugin_state {
>        * but with the HT we avoid adding a field to CPUState.
>        */
>       GHashTable *cpu_ht;
> +    /* Scoreboards, indexed by their addresses. */
> +    GHashTable *scoreboards;

Why a hash table?  All you want is to be able to iterate through all, and add/remove 
easily.  Seems like QLIST from <qemu/queue.h> would be better, and the QLIST_ENTRY member 
would make struct qemu_plugin_scoreboard useful.


r~

