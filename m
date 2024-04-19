Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FA5C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 06:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxi8D-0005TD-24; Fri, 19 Apr 2024 02:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxi85-0005Rr-Hq
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 02:53:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxi82-0002tv-8Y
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 02:53:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-418dc00a31aso11135415e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 23:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713509623; x=1714114423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qnyRf1iHkspE8wzKtxgVQ/TMG6bpyIt7B9oBNHgRKSQ=;
 b=pO/I1uJyy3qi8URg6s1aBL7r5XV7+uarZP43wpE2LMBg8hVRzQcYnk4AUk7Sl1Hnlh
 QzCqmj0akqa1S5zWEqczT6XIs+eaUSt1qLndnMpjZ7Tgn0jqJcldx32moF+8Ycs+CSt2
 biok/NNWII+Wl8VvAUna7dmuIZ1DGFdHyuaO+gTrPd2oAypnWQg4iEEZrAI22z5UxVge
 rB6fVgpj+OOxerCFhd3NyfIw8MI6ESqoxwPJeS8CQppwUXQcdaR81KEBkdUQ52OquyX0
 VSBHY8Pk+CvKeCVq9UBZofJu2C97z4kZBHxfQuFdc1jSUi09pjS/OSf0TP/bSM2mXtTK
 6OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713509623; x=1714114423;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qnyRf1iHkspE8wzKtxgVQ/TMG6bpyIt7B9oBNHgRKSQ=;
 b=QtcNhsZSk7LtJfvRfM9JGGEjakduAgLg/oW2VAfSf4VZucr5fsy9Ct3voCBdFRqcg5
 0MOXYc6kHoAMh0kUbAl4S4Nd8sWNrypPCYqfrmyQIB97i15iWzHKvVO4vjg9UwUMDn2Z
 fKjaPMscDndfZI66C5Qn5idBRl18lonL+qOUVzCl9ameAWWjfv3d8Vz8uuvupqud5LiE
 GMjvZ+Py+UHdRmUamzF8ObADcsuvPFgARgUZalwCauP4o0dFACn2iQEO+EYjZdIbHI6U
 gFd07+0HN/CR8n7xNfog+goZvsFLS1MsWXbQxH6lLjLzaGMvmXnNhweyNskUpFmTWeTI
 v2hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuwPDT8NUw17L0DHyJ26HsdOqV0Zm0+jlqom3NoFZUPeMUxcROYRG5/RVLsMyfrW5EYoNJ05ljYxRYxmVvFaWx2oqST1Y=
X-Gm-Message-State: AOJu0YyWNQL1ACv8nBcdVxxi9g6vsZOq7q1ouWCJ50DrD5ncTqUwYX8p
 9UiP24QEMJSVRLqLV9Tuj4DZlfJsVhM72zsatWLFgzv1ZXKK4VYMHZBYzfPGnvhj/QwfCAPK8nK
 T
X-Google-Smtp-Source: AGHT+IEpJqTnf/gTRdTQwtSQFjfU7nEp+hXj8Oz3hygTxu2sY8cOW2KzP3CPQQPmv9iAA30eKUxPMQ==
X-Received: by 2002:a05:600c:1e10:b0:419:7344:c57f with SMTP id
 ay16-20020a05600c1e1000b004197344c57fmr187488wmb.35.1713509622909; 
 Thu, 18 Apr 2024 23:53:42 -0700 (PDT)
Received: from [192.168.235.175] (149.red-88-28-24.dynamicip.rima-tde.net.
 [88.28.24.149]) by smtp.gmail.com with ESMTPSA id
 h16-20020a05600c315000b00418fb3fd99bsm2762149wmo.43.2024.04.18.23.53.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 23:53:42 -0700 (PDT)
Message-ID: <5075024e-76e9-495f-bc93-a3dc102908f3@linaro.org>
Date: Fri, 19 Apr 2024 08:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] ui/console: Private QemuDmaBuf struct
To: dongwon.kim@intel.com, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, berrange@redhat.com
References: <20240418220541.931134-1-dongwon.kim@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240418220541.931134-1-dongwon.kim@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 19/4/24 00:05, dongwon.kim@intel.com wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> This series introduces privacy enhancements to the QemuDmaBuf struct
> and its contained data to bolster security. it accomplishes this by
> introducing of helper functions for allocating, deallocating, and
> accessing individual fields within the struct and replacing all direct
> references to individual fields in the struct with methods using helpers
> throughout the codebase.
> 
> This change was made based on a suggestion from Marc-André Lureau
> <marcandre.lureau@redhat.com>


> Dongwon Kim (5):
>    ui/gtk: Check if fence_fd is equal to or greater than 0
>    ui/console: Introduce qemu_dmabuf_get_..() helpers
>    ui/console: Introduce qemu_dmabuf_set_..() helpers
>    ui/console: Introduce qemu_dmabuf_new() and free() helpers
>    ui/dmabuf: New dmabuf.c and dmabuf.h for QemuDmaBuf struct and helpers

Instead of introducing then moving code, you could re-order
patches as 1, 5, 2, 3, 4 (in patch 2, introduce helper in
new dmabuf.c file and new header).


