Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DF4C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 22:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTqsK-0002ti-O2; Sat, 27 Jan 2024 17:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTqsI-0002tF-Uf
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 17:10:07 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTqsG-0008H3-4l
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 17:10:05 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-290b37bb7deso1495642a91.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 14:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706393401; x=1706998201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ll/FDJoseyjepV4b3I7mrVDEfd5pJiXxkRfu0E9NRX4=;
 b=a1rMK9zZMEWAWdfGKPKh+yIMh9d8ah4O3Zvfnv8rK0kSaTtrdB2K7SnOTocKxGxRoi
 2rpyp3qy8dR4VagUWNLB9LhmjHg/3a5LxApKWvYu+xCPqMwm+9O6nTOcYQO/6KehdLGN
 MxU10joIBIN6yuyX1BAQGAfs+gNMc53oZP8qVVzmnCY/N+6oOAyAJg33UbI7h0ofElSG
 cYFaetvbXB46ijcHCUpEcms4gDlqwxrlvt4WPgqQZrfyIKK3Czgowg1f8OuPn61de3ft
 KxMid8DxXht1Yf0o4DbaOI+Y18SddlYW72Sqv7Rf9QNLd90luWyIJx2zDlzmdmFNyNr1
 VRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706393401; x=1706998201;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ll/FDJoseyjepV4b3I7mrVDEfd5pJiXxkRfu0E9NRX4=;
 b=Xr/sUbSS9wfpU1uVCCQ8hgYt/7uNJ4MSKo7B85D54ZzIgMQGiq8dlosPlodWe7StN5
 k8DBPMj0QGWPZEMutkbptTX1fxAqS9zI5pil4kByWbaxi0rvx8lxNilb08jO3DXwzDpk
 3OhZ0VQ6pNTc3jPbN2mK8cVmlc2ltbnDkYafsYQUfF7abNIYwY1cpKtGrUgt3suHYbSb
 W11MCn86znxYXbXkWrmysugSHcf6Rf0U1oH+cmvts0nQtvmieTHfq+AybsGh6wQ+Mr1g
 fHgxovCZaFQszl2Gh4POsiaPgnD8z4bXnGhnkL4QKbygfX0YoTb4Og5wUrm9guol6PXy
 s5Pw==
X-Gm-Message-State: AOJu0Yw8WYWRUyrvxLsgK5sXxM+9rAaJ3GulyByPbytBfLs7p21WMVjt
 kUoFArYswiJ/MZK6G7IJhO41W8YYOQqiZa0kn5OjvO6WE5aeJOv7ghaXFQ2w0j6YQa1l9X3h1q7
 5gIAO9g==
X-Google-Smtp-Source: AGHT+IGzizW1c5sHyWZ8sYQd0+BEC1RUZkW5cy52xNcFZ2cdCJ7JoMS5x5PcSqBk49vatWY9+IxTxw==
X-Received: by 2002:a17:90a:9f0c:b0:290:cd3:a2d2 with SMTP id
 n12-20020a17090a9f0c00b002900cd3a2d2mr1414957pjp.3.1706393400964; 
 Sat, 27 Jan 2024 14:10:00 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:a829:f39c:2095:de50?
 ([2001:8003:c96c:3c00:a829:f39c:2095:de50])
 by smtp.gmail.com with ESMTPSA id
 nc13-20020a17090b37cd00b002927a36b7a0sm3334092pjb.23.2024.01.27.14.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 14:10:00 -0800 (PST)
Message-ID: <aea3d4c9-66ec-4e44-ba2b-e53632735a74@linaro.org>
Date: Sun, 28 Jan 2024 08:09:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/arm: fix exception syndrome for AArch32 bkpt
 insn
To: =?UTF-8?Q?Jan_Kl=C3=B6tzke?= <jan.kloetzke@kernkonzept.com>,
 qemu-devel@nongnu.org
References: <20240127202758.3326381-1-jan.kloetzke@kernkonzept.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240127202758.3326381-1-jan.kloetzke@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 1/28/24 06:27, Jan Klötzke wrote:
> Debug exceptions that target AArch32 Hyp mode are reported differently
> than on AAarch64. Internally, Qemu uses the AArch64 syndromes. Therefore
> such exceptions need to be either converted to a prefetch abort
> (breakpoints, vector catch) or a data abort (watchpoints).
> 
> Signed-off-by: Jan Klötzke<jan.kloetzke@kernkonzept.com>
> ---
> v2:
>   * Refactor watchpoint syndrome rewriting
>   * Drop ARM_EL_ISV from watchpoint syndrome
> 
>   target/arm/helper.c   | 18 ++++++++++++++++++
>   target/arm/syndrome.h |  8 ++++++++
>   2 files changed, 26 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

