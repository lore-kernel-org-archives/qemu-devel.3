Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE6EC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjbMN-0005Dg-Lq; Mon, 11 Mar 2024 04:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjbMI-0005Ct-9u
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:50:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjbMG-0005wL-K3
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:50:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4132e2bbbdfso941675e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 01:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710147006; x=1710751806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=20vlk+6S3lJCnG/5mYz+CtRJ6I3/jbKq8+mjn2nZsrU=;
 b=wnbjZI7uyOOdQQeKVV8zFe5XmYIDv+GXnHdxxRoGdCa1VcDDOKIdvwLcjMHc1KldZp
 P6Ly3AAL3h6PufHKn7Srhfg2QmxA6WBdnMPKwHRnSjImkCwaczpm5SWGPNgdjOXNZA0J
 Jia3Jj78mTZFvkTHl8qifJty4U/flihGzy1H6g/4FsLDIYUOYZaffFjfbYK6EdHnpcRc
 FPPJUZQsUNpzWtzXnrWP8rnKgVjcvRrNVY0b96zCXyJj5F1Sf6HD6b6mXHlqik13QHx9
 fRpphmrckeey2mD6ffSdvoXIkB7W+bHIj7Eo84KWw51/ZWbzWxyuMqIP2ze7kdYtLxgl
 u5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710147006; x=1710751806;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=20vlk+6S3lJCnG/5mYz+CtRJ6I3/jbKq8+mjn2nZsrU=;
 b=rhNgWThnyGTg3aBQuZsy2Cf2wmYz9em5O8w/NEOA8naOj8xybLQbcbK5UGY/Toxdu9
 2jA2TvFqE+/fwxc0QiREH+4xC6xhUfkjQqLn2qx/p8Yut17PP5qGh9/cksFytHLl1b06
 sIR7hYWdl2G/CrSp5fqRenLZ/zJUdSg/I+mSK5CPl87mh34ezMQ7QondPSJ7N5OqJFVY
 mLfdaHiimjW0j5FxXnyx4mcQqj0kgSXRiQpTUSOBstmsiYhUeRH15ejozXIzMFr+OOzG
 iFooYexTC3ATLMRJAR34twt6e2jldz1MhdeClT76d3W0lefkl0vrCETV2MhBTaxwFNOJ
 MTEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuQiuqRQGI38J/nQK95E0VXP2E0rMSZfu4bfU8lNakRdqhxleYmIz6ZVzJh+AgSDdsN6CvkTGXH1ZSQhaa1khc+tY4Wyg=
X-Gm-Message-State: AOJu0Yx+9JVeRxxW5AsbRgBHXbzhNZJCRAZ2fZ30zYaF0A5usWlYmj8x
 bITEzz6qu+lBNBOiNlfHPUYP9XVrK7FyLKQFb1URUQNgftgasJHTXq6tPXILpdw=
X-Google-Smtp-Source: AGHT+IFcyC+9BsHxTtOLInB3ejvYjOQfBNxbQJB1hFiZNtmhnSRBVWpGGZeeo7imMPb2xvpZhsG6tw==
X-Received: by 2002:a05:600c:5114:b0:412:e38a:d829 with SMTP id
 o20-20020a05600c511400b00412e38ad829mr4402419wms.36.1710147005740; 
 Mon, 11 Mar 2024 01:50:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm12791228wmo.0.2024.03.11.01.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 01:50:05 -0700 (PDT)
Message-ID: <8f284db9-db08-4eb1-9068-1e7539ae16ba@linaro.org>
Date: Mon, 11 Mar 2024 09:50:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] hw/core: Cleanup unused included headers in numa.c
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
References: <20240311075621.3224684-1-zhao1.liu@linux.intel.com>
 <20240311075621.3224684-4-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311075621.3224684-4-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 11/3/24 08:56, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Remove unused header in numa.c:
> * qemu/bitmap.h
> * migration/vmstate.h
> 
> Note: Though parse_numa_hmat_lb() has the variable named "bitmap_copy",
> it doesn't use the normal bitmap ops so that it's safe to exclude
> qemu/bitmap.h header.
> 
> Tested by "./configure" and then "make".
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> v3: Re-included hw/core/cpu.h since CPU_UNSET_NUMA_NODE_ID is defined
>      in this header.
> ---
>   hw/core/numa.c | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


