Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF55C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvJq-0004zU-Hi; Wed, 03 Jul 2024 04:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvJp-0004xK-9a
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:26:25 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvJn-0005Qx-Cx
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:26:25 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52cd717ec07so6318297e87.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719995180; x=1720599980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P3iWR+2TGuQDrXlJJ42OmFmEQ49VfHO1e3z3bM4w8n8=;
 b=sRe5UqaWjcXINHkEVO5Rqy8RmHQI6Dkk68bW5ox0sq6jPPn7i9IIRpLWP6me2xqpBS
 g20b8HXFkZrDCFyTaZkJwq4x1Iv8ttp5BZJbntRRBdM9rYgnO7YPiUZe+GvcPdip2t8M
 WG/6caWvl6ADmKI61VCpJVQr5KagjgiHOTEJO2/z8PlgfL9ipY5nEVJbKyi/NEPCsqfd
 x71D3AsrCLFoINGZJNb3251X2+kbYHdSr4xinYT4SHd05UZa9lUCZaroOmBvGF2Miitt
 Q1ThzXiGmNDh6CNkNuGS7AAujCxwYNTr9NJqJnjc46d7qsMW5JNZqXoZlnUEC2VVicII
 emCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719995180; x=1720599980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P3iWR+2TGuQDrXlJJ42OmFmEQ49VfHO1e3z3bM4w8n8=;
 b=gXa+a2p5HaHEikRyrhshznYkmwPhCr2ebNGjjxG3TYFZNXUI5BK9A5HyTVjx2/HBIZ
 vjGriHdXjK9B6qGsM24Vwr9nJ5NPIZxHHFNZLy3lFsIoo8Qzt5IKXxmvlMZSva6hg4CO
 Vf5cjagpgzBMRCrZqcOvREQewZTfYyY/TjzuJU3WtHLU4L3Ca1Wtt2tj4DAc+xTCJhme
 ixk7/cUnTobpCaJuNFPXoeiqgIXIRxF7UIERl6J4b/aOraYEk6Gq7TezGZqyyG5o13kF
 +N4nrBc8liatC65w5zw7KHVLeF2W+PWwfNJfF84Yuk9xPkvyRh3DqDF8rxodHaLUbYSz
 Hv3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCqevW592tqMUuEYOLuni9Yqs7G+DgEzH7buTiGNlhdSv6AObT4iMSGZ3mP8wd7DQ/P8155uaWFKwHd0LAJUNqF3opnak=
X-Gm-Message-State: AOJu0YwPqYhuxediDs9LN6BXSAm2OTqZuxaaE3n8DIYVfUBHIR61CGj9
 c7sXK2OQb2rbPRRYuy6ZmD9qALHIHWPRugCcGXAs3fpDFxhlxsjX7URFgGvtZr4=
X-Google-Smtp-Source: AGHT+IHaXDQaXLmVL3HpOPsYuxJBYxcJ0viCA+Y/Tmncwtnlet8iqza3DOpPV49GYJeDLsQJP4Gp3Q==
X-Received: by 2002:a05:6512:3d9e:b0:52c:c5c4:43d4 with SMTP id
 2adb3069b0e04-52e8270faddmr7716778e87.53.1719995180694; 
 Wed, 03 Jul 2024 01:26:20 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b66csm224838415e9.18.2024.07.03.01.26.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:26:20 -0700 (PDT)
Message-ID: <70becccb-97c7-456e-a8d9-f690e0acb5fb@linaro.org>
Date: Wed, 3 Jul 2024 10:26:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/22] qga: move linux memory block command impls to
 commands-linux.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613154406.1365469-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

On 13/6/24 17:43, Daniel P. Berrangé wrote:
> The qmp_guest_{set,get}_{memory_blocks,block_info} command impls in
> commands-posix.c are surrounded by '#ifdef __linux__' so should
> instead live in commands-linux.c
> 
> This also removes a "#ifdef CONFIG_LINUX" that was nested inside
> a "#ifdef __linux__".
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qga/commands-linux.c | 308 ++++++++++++++++++++++++++++++++++++++++++
>   qga/commands-posix.c | 311 +------------------------------------------
>   2 files changed, 309 insertions(+), 310 deletions(-)

Reviewed using 'git-diff --color-moved=dimmed-zebra'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


