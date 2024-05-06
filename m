Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4653EC25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 22:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s46QD-0003ky-If; Mon, 06 May 2024 18:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s46QC-0003kq-KG
 for qemu-devel@nongnu.org; Mon, 06 May 2024 18:02:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s46QB-000558-6p
 for qemu-devel@nongnu.org; Mon, 06 May 2024 18:02:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41ba1ba5591so18342395e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 15:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715032972; x=1715637772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z/NM+IXBlP1LsbnNYizGmHdOl7jEWI4LmUu/NXT7fi0=;
 b=C9Jd7H35NJwfFNGrEZNKjQa1sgXcuyewnyeZQxSnJvaFwW4HLlAlElPVaylNr+cMZv
 kZzWPVrCGhO3ot9OBonW52Uj9H5rs2NXRLHzrH/6ZHSfIdN6zysa0Wy5TauT8Zi9wBw2
 QOsJ0130vQZ1MPDdW6nK00EmkSyEeeJqLeEWWxs4g/0LCEYH97CJDPpVCwXxN/7NpcCl
 rby9gb93AQiUR/toWpk4ubt2/zgnarGJxsltFUlhLXqF40adQLZybdMD3UBtK2GIh3gT
 L+sGvTUHeCr30IKEFlWU/GJrQtyUgBS+5TJIsdaL2ycO03RJccJugm8xTMyrr5tC2a9B
 x8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715032972; x=1715637772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/NM+IXBlP1LsbnNYizGmHdOl7jEWI4LmUu/NXT7fi0=;
 b=I3/wDDnL7VCGvCiTsyj/+6PtWE43mRN4MiCtkz3kI2SY1TOj2G0YnOuzpcenmYqhJG
 UXzESs7eJYrJRrnXt/IlA0LaCfwT4CEtuDx7Sk6Pktcatw42nntPu1JB/8FnCtVSDVUV
 R20xMs0ko2WOF1dATnb/NdQorJseMPl+KKiED9FBoHxqPIahpRSebAmXRy2ZxiONRcJK
 XeBfvsSWjVSjbZfxr4tLR64AvI440BZUjIKfE5hEmguOlJr5xVUgZBQsH/H7HLgFDcqf
 rdjOiFLXM1VfneoDGVeYygKwcjhhVsLvFW98zzqhKGhQdwLvwY6NJ/bBy9MrkxVAnBYw
 uffQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPO8rMytTpkRg/zGwXI3FvyS5S+fViC7fIi1DodU6cLmN5UZ7SGZNp0IVKPHjSryoHA/0lgFfBM7VBUgL6vgASR2ecil8=
X-Gm-Message-State: AOJu0Yw9hyBGUC4pzp4gT525I7DUg1RIlr0POyRuXXs8BLghpXASI0NQ
 X7iUb05bTjbQjBVmqn3g4eESfH5OhyNy1TzjWaNtNZ33AZgNXl7KQLO2rbo2Rw4=
X-Google-Smtp-Source: AGHT+IFoz7Gt4zM4nFapQOYeo69hl1dUZrXoHFOMUhqTXLwKjfl/EvrDeTl6yKE6IbBLjhmeiBXohQ==
X-Received: by 2002:a05:600c:a06:b0:41d:9d8c:5a34 with SMTP id
 z6-20020a05600c0a0600b0041d9d8c5a34mr8823252wmp.9.1715032972174; 
 Mon, 06 May 2024 15:02:52 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a05600c470e00b00417e8be070csm17275734wmo.9.2024.05.06.15.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 15:02:51 -0700 (PDT)
Message-ID: <d5770936-75ca-43be-b4a8-2919f6f2dae3@linaro.org>
Date: Tue, 7 May 2024 00:02:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: Rename ubuntu-22.04-s390x-all to *-system
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, thuth@redhat.com
References: <20240506202341.422814-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240506202341.422814-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 6/5/24 22:23, Richard Henderson wrote:
> We already build the linux-user binaries with
> ubuntu-22.04-s390x-all-linux, so there's no need to do it again.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


