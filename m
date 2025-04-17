Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD63C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Rwp-0002oG-SH; Thu, 17 Apr 2025 12:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u5Rwl-0002ni-Di
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:18:40 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u5Rwj-00054u-Ow
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:18:39 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso983850f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 09:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744906716; x=1745511516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UH2wT6uE5R6HdIGixMAO0vVonM/z0oULdFeYT9l2A3w=;
 b=b5vSlkJgSJ22M/Jq6Rz4C2N/jTMQCQMIRGpHB3z1GBvMcjOzpNOAcnjN35zCObNXvJ
 wFYYRXhEUV/t3eYVMTnMM4B57OVauLRmZtzYDXf0r729Cg/bsqG152dBdARoXl2szXPP
 aTfgEl2NatC23FcyP/ewWPPjdEJnFuy3fcultqwU+Wpixqh9ksknbiuwZtYqCFammA2d
 13cD1eB/Wvdxa9JBCThGgf7rSb9W/vbGzKyJb5gnpm8GTbMELRS8q1RJ8fFoNP+Wr1Eb
 SWfx7+se5aOsMcfivfn9u89RzZ8pimSdbvUPLgzUrwCi4I3+JzcGun/7a5oEGiUg8L3s
 TOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744906716; x=1745511516;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UH2wT6uE5R6HdIGixMAO0vVonM/z0oULdFeYT9l2A3w=;
 b=sqZVNOePQ4o7ByGlm5uK2APiLIa1to/gGdrKcXUcojnzIl8cIvAUlJbFiN9/OlAeVC
 acEV1E/EU30xMo9utWg35GpkQGJyBpTlTbRCNoa246aZvSbEXDSDJg+vnVj+shcZdY22
 qf3cUHR4V2nuJnMsaMPCXfuSxRJ8X6w9fu7cqhFbSNukiXTaRZF9vBD1RmL4KkAzQgw3
 irFWgd9poPt/7S7vRVcd8BY2+lvZJCmY5YATpCoGk2E5seS1EjrL6LeZ4Yrymd1kFD3o
 ENRBdGj60r2rf6c/m4zuNp+jETspzMxz4mT58CL1iyblVNpRZe4bGjmIBEXjIEXjuNvi
 2wcA==
X-Gm-Message-State: AOJu0YxL42XF3/DNfQ3ZWpOHpo8jE2nYfiIo7QERv8BVHTInnAFYTxtt
 l9LgChgU109Qabk8q20xOZLmr9nJM3Ma85dCJt+EPAdPF/LF86fxM9b6qzcEziMEg09oQ4e4NYs
 s
X-Gm-Gg: ASbGncvVpvf+bqZ0xkeGIVaIbN3jLc7FuIAGN3ysenMEU2JkIPFQ91cuHzLyCcTAaxx
 Xg8UTOLFbQUVk7kFxcdN6MDXx3eXbh/1V5xEtG2De0G3Oq5sR3oS9W+0nRrd/vziwaQXFTKyaP9
 OMEde4MXkHuBEYma8jHm6HPxbufw4h5pA6oGw5WvgggS4DoUgXBeTjYrAbKjJbreH9P1s0yiN4Z
 n/LsEDSsLMpVTmTzcteZq1kR6Rr1ud/X1GdoUofnNpue+oEPKt6Xnr//oZgI3lrSthDjMnjUpx+
 sD0fqb3CvLgJCLwAa9z2rHpxF/w2iFT3YwkLGUCMg8s=
X-Google-Smtp-Source: AGHT+IH9qHTXdUnUJJm3gez4pI7Eop4mlOWchK3szarm6Ock0bEwOVcDMrA6eZpeCJv5g2MKpGXTvQ==
X-Received: by 2002:a05:6000:1a8e:b0:39a:e71d:ee34 with SMTP id
 ffacd0b85a97d-39ee5b9e3aamr5270831f8f.37.1744906715718; 
 Thu, 17 Apr 2025 09:18:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa420837sm48436f8f.10.2025.04.17.09.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 09:18:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 583975F893;
 Thu, 17 Apr 2025 17:18:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 8/8] gdbstub/helpers: Evaluate TARGET_BIG_ENDIAN at
 compile time
In-Reply-To: <20250417131004.47205-9-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 17 Apr 2025 15:10:04
 +0200")
References: <20250417131004.47205-1-philmd@linaro.org>
 <20250417131004.47205-9-philmd@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 17 Apr 2025 17:18:34 +0100
Message-ID: <878qnydan9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Rather than evaluating TARGET_BIG_ENDIAN at preprocessing
> time via #ifdef'ry, do it in C at compile time
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

