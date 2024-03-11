Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABF9C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 14:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjgT6-0006CL-PD; Mon, 11 Mar 2024 10:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjgT5-0006By-By
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 10:17:31 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjgT3-0007Uu-MG
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 10:17:31 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33e6aca1ca9so4203224f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710166648; x=1710771448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4PjyGUcpb4+797tvwMwm1vie3TWgtIa7ruEj6TvdiQQ=;
 b=XH3yTGKZjovsm2d9Me6wGoXkvbxJnH09upiMLLOFDPuKuikHF0JGn8t+fDeMUAcEre
 sTI66k4m0ZNV23KoE08ytINkXA5rU07xP/nDtkU4CLvfd6gyDQ4XGQhrbogrz4u4UCdq
 te7Wi/IUilmg71rmZ9arbA8rc1Ymiz4KQi36PrG7FeuXS4h2RMZeLJ0lnS/DN9Ctabok
 KbzRN5eD2pE7xUk7UzbmLwCluZ30kfEyLNPszsWVy4H1G1s2PwaARaXVIdE7QhWMoTFi
 zr0EMFK0DE1svDTgyMLnfRCXTEkBoHIG0pEmvQVxj2F5GZsRJxZHl2U7O+oyS9Og9epm
 ocgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710166648; x=1710771448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4PjyGUcpb4+797tvwMwm1vie3TWgtIa7ruEj6TvdiQQ=;
 b=EkAJYz4NgE8vnnm8Gl+xPBbUx/CGMykzVx/8QD2ot1U12QqA2a4Ar8zjz0HVfo7qvT
 A2pS9mQlC6UcxlU/eQtIT1Pw68kNptFxGRfhhsLl350O2p48m/3FjIKw+W3t6503Hr7v
 mc4ChkcDva7JXsEzF9WMW3+r+LA3QYzJDFdo93M9h24UG/uxcamY1l4Lsd6km5mxDbpc
 m5RmyzmR7N8xiY0YRaopwnITXFb+ov07xPWCciHYq0I8fJ73sUOREgu7on6iRyVcEqjD
 aEn+wA+mbygdLnUgGTZei/juXfg72A7c44iMcuJpQundIrBv8ZjiBhqdpqSytTRf2Raw
 lUTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU07CkmAINSjeVOB9Svmf74xTNvmVUorUCoz5gsKrHw63SuPVCGdAq+RN+7KWIMwcW/FEP1R3o6eMRueVri9fcUG1YxWCI=
X-Gm-Message-State: AOJu0YywbUNh8V+dARMHFWXjBBMi0ot7L+25KeEOST4ggFviC8QMXZBR
 JxbmW3AvH31Wq25io+TBj/hEMgh1fb5wl+GqkDRkq41lpfxBo3j4hFl+prOptbk=
X-Google-Smtp-Source: AGHT+IGiyce0PnPC+hlyoH3fR7nN/yQ6omaEIlzuwTit4zHAN+Yc+6UkjOpqfhws8oo5DrY5cwUCaA==
X-Received: by 2002:adf:fa8d:0:b0:33e:64f3:65a5 with SMTP id
 h13-20020adffa8d000000b0033e64f365a5mr5446420wrr.52.1710166648099; 
 Mon, 11 Mar 2024 07:17:28 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a5d6acc000000b0033e7a499deasm4334460wrw.109.2024.03.11.07.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 07:17:27 -0700 (PDT)
Message-ID: <91bf8d9f-1a60-4280-a44d-25b6339d11e9@linaro.org>
Date: Mon, 11 Mar 2024 15:17:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson.build: Always require an objc compiler on macos
 hosts
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240311133334.3991537-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311133334.3991537-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 11/3/24 14:33, Peter Maydell wrote:
> We currently only insist that an ObjectiveC compiler is present on
> macos hosts if we're building the Cocoa UI.  However, since then
> we've added some other parts of QEMU which are also written in ObjC:
> the coreaudio audio backend, and the vmnet net backend.  This means
> that if you try to configure QEMU on macos with --disable-cocoa the
> build will fail:
> 
> ../meson.build:3741:13: ERROR: No host machine compiler for 'audio/coreaudio.m'
> 
> Since in practice any macos host will have an ObjC compiler
> available, rather than trying to gate the compiler detection on an
> increasingly complicated list of every bit of QEMU that uses ObjC,
> just require it unconditionally on macos hosts.
> 
> Resolves https://gitlab.com/qemu-project/qemu/-/issues/2138
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Per the commit message, in theory we could allow a no-objc
> build and disable coreaudio, vmnet, etc. But I didn't really see
> a reason why that would be useful, and it's bound to keep
> breaking unless we actively defend it in CI. So I preferred
> to simply require ObjC on macos.
> 
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


