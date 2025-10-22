Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10935CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBZsn-0007JE-80; Wed, 22 Oct 2025 10:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBZsf-0007Db-M6
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:32:04 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBZsc-00052U-NI
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:32:01 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c0e8367d4eso2374323a34.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761143516; x=1761748316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u5F569Kj5IT9zkOFE5x+E5Dmrt3rMNP1fLrTfr3rdRg=;
 b=XV0aXpbQrXQy4R3tTw1FNSxFKLJOXPLGvMHWuofllEqXC7vQqZoGtAlZ8G9cYKTHVr
 +Pum3kJxza/q1Kr1JHEHAnF3+nWtoFFPY7yEvZX0s5iNZ4q1oXjferR/JrBOrWia9B/p
 Cxoyi3fPMCtc7D2wp2DpDG3QQsfBb0AWI11SBGiw6g99SkrSamqoowSwZSo9HJo1CF8y
 dQ+DEXnG/0A/nKdLSuxlLcva6p01we1gK+CArJ7jTcOBquKigngWwbVNyRg1l5LjgLKp
 VqaFrAA698crAZxYqznMnZt7/uJ+DmrwMTPOxf8rMV0lMbJrwzI3DWMs62Fwh4bMLSKc
 26OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761143516; x=1761748316;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u5F569Kj5IT9zkOFE5x+E5Dmrt3rMNP1fLrTfr3rdRg=;
 b=uglyTqOEiWzgw2+QF3JNvBASdjQKG5W4/cWKWXzlktpm0PTdPgXRl3FdwgKX4vaCjl
 d/9KWQwJIkZ7CN+hd81TdKqGvn+hc7Rs7PaqkRp0TDKZxvz0V+QO49TrW5dopzQo9REW
 1c7s6D7CDrUbVmsRVZWKWm3qMsB3GanDv9l0jfcSXlu60z10GY+GjXfejTiLJ4pIny4p
 ISk0KDQsCjy7IbqG1ZSM4+hmK1yeh+rqJyc9+JJrqW4WR0SS8QG4mWdzFj/axF2ben4+
 KtBY6C+uQPDVzyv2qE2q4RH/QSggLizjoEnFdiB0207T9YFOWO6ORzwHRVnsr5ht/8U0
 5ESQ==
X-Gm-Message-State: AOJu0YxUd3DEB/2+dEqQwm085pcNdfoWoNf4+0P7yleDQkAonXX7ve+B
 DbjbAuZIxTbM4S/T5MX+O3Zv8KyjpZGFwVUaLtxIMRfHOP8wkbyX0yf4bEr3Gb27tG8b5RPdelI
 MWuk8
X-Gm-Gg: ASbGnctq9J2MzSxyq8K49TP6mvKV4HPP7T11QvPxkuwJGLwUVcfSlLkfzY1C0ferpAH
 A902ZwnxID2jr6NcefB3qBjb5Q/1GX0Lf6m/MX101nu7M84+dYvDBG7KXttpL4ILB4/t9+P/Jpj
 GlRtVqChfn9/I9EYVEhvY6A+iW48DwOh6HOpDu50meYgEMv9Pc2PBpXiDmSrNnJT8i43xjPcRYM
 arzs+gBOcws9wzmCX2/PO60HUELjIsWrZqpNA/2MIZBPJi1xFyjoXEnZhn1BhbNz8cO2XUvfTsy
 0+kfjjY3BRimLl9NSRNKHJUTYu8yDibt11Tv0BUPAo3p4sRXNP58/3fsOFlxYeZ3FldJWBKbEch
 rSVkU+5dGCalMhNEJ5bRfCNBbe8fcF12DZ7yTtinEadfSaOtc9ZalvC5boJaAcHtXhYPWRRDgSP
 BK+fl3OCOPqCL4YV5eMZsUCJzkMkxW+hBv2e4Vqg==
X-Google-Smtp-Source: AGHT+IEd/R8i/2aprODsJQlcn5r56XFWddLlTXHSBdr8EUjVBy5GX/cqazcO21c4fRNCQFJxoOksuQ==
X-Received: by 2002:a05:6830:4901:b0:759:19:a328 with SMTP id
 46e09a7af769-7c27ca51324mr10704482a34.16.1761143515855; 
 Wed, 22 Oct 2025 07:31:55 -0700 (PDT)
Received: from [10.128.41.227] ([50.194.179.134])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c2887b926fsm4693666a34.14.2025.10.22.07.31.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 07:31:53 -0700 (PDT)
Message-ID: <da1a0b39-0747-4b96-914a-0cfee8e87e76@linaro.org>
Date: Wed, 22 Oct 2025 09:31:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] vfio queue
To: qemu-devel@nongnu.org
References: <20251022121846.874152-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251022121846.874152-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

On 10/22/25 07:18, Cédric Le Goater wrote:
> The following changes since commit 3c0b42c68f98fb276fa248012642be8cbf2cab70:
> 
>    Merge tag 'pull-request-2025-10-21' ofhttps://gitlab.com/thuth/qemu into staging (2025-10-21 08:59:35 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-vfio-20251022
> 
> for you to fetch changes up to ecbe424a63c9f860a901d6a4a75724b046abd796:
> 
>    vfio: only check region info cache for initial regions (2025-10-22 08:12:52 +0200)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Fix CPR transfer
> * Add support for VFIO_DMA_UNMAP_FLAG_ALL
> * Fix vfio-user documentation
> * Update Alex Williamson's email address
> * Fix for vfio-region cache for the vGPU use case

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

