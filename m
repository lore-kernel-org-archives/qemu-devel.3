Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6918C27C52
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 18:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFIFr-0005zm-Do; Thu, 06 Jun 2024 14:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFIFp-0005zU-JB
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 14:54:29 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFIFn-00014D-Rl
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 14:54:29 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f692d6e990so13610525ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717700066; x=1718304866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5TWmG/xSqRgltafEsTxDutOaWtCUU8BTr5ihDYO0uKM=;
 b=AgYPV+NUpM+1Dyvpd+1nHHrlKLJWlyUIOGiRkztE5CBuqXDntiUwoNnj3v+PLOllGI
 1VAXLX/cFPIokyAielLEYNYAQM4YaPjRNbt0iIix7XPPw3DCGYSitzq8z5aNUIlt8Ne9
 UHKQD+RvKPWF0rw7h4SNKU0eLEOL0pu0F3VoEhkqoh4ygSn9nf5vqR0fSPex3VzpeEcK
 iNq0v/Pg2CkDOBUZSANw6MYdWzAeTGaA3Grau+zeyxnjggbhpnT0Uoyc/DE5giknQCf3
 LlxC7eDzsOpuENpCNJ9IlSZulHP8FPgx8f/yDaVVbemxZ1YOuBprn2vjh1wYE0CleBXU
 jOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717700066; x=1718304866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5TWmG/xSqRgltafEsTxDutOaWtCUU8BTr5ihDYO0uKM=;
 b=faN5aIA/rkE4uRHyoQWH4tyr+IHPNirle78su3fh5kIn2M7fgfBMrtzEqnc12/8txF
 0sQXHIGOrtL6QMWUxj1l6XQtjBxf4De7USSvmSrk9lcgnTiILEoK88gHnzojDbpvyLPE
 KQJ9ns6WVtZhl45EfHLjBYWk3AsozD3tLhon6gt7hpqbeUo9usKeNjfBVgp1fMXiWSOL
 b2Y77DTDnjULMRHOFsrswQ3WKODXErjdQGMPIyAAyGOPyk9ryG83uBLH626tr08kk94k
 xy8J5qxKlagLzRGNP0d1jiyoqZ+dUKI9QQ6j4myijr/GPrs3v/uSPcqJLnrg045wqCCS
 T0zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFjxbJDL1oqougu9sXPzK+CTFYhW8pszdsoM8duV8U/pkXs21n0vGk+T2lt2yPPLlBc3ShJ7iZto2OrUvdK1dclt1Uin4=
X-Gm-Message-State: AOJu0YzLaNio1XhvA52L8/DCbA7Acc9mM3hl9PNJQD5/ZRBcyXPSdGkw
 Br4JoYtUm7n1W64Nl1mNN52F7ZECG0M8HSa7Ya+5yKJIZSybKjHp/tsTQ6F8KA9VFGlX/gEGhHf
 E
X-Google-Smtp-Source: AGHT+IG/WaIJsx0XxlMdkFVNhmDMPgsx6vmkMWq/CDCnhy6PncNStGRLduqJWuH/i05mYt3LFvljTQ==
X-Received: by 2002:a17:902:c951:b0:1f6:7cc9:fb31 with SMTP id
 d9443c01a7336-1f6d02c054dmr6200575ad.5.1717700066328; 
 Thu, 06 Jun 2024 11:54:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd7e29e1sm18486525ad.224.2024.06.06.11.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 11:54:25 -0700 (PDT)
Message-ID: <56f019dd-6e65-468b-a0ce-8a7a6f85d8fc@linaro.org>
Date: Thu, 6 Jun 2024 11:54:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] testing cleanups (ci, vm, lcitool, ansible)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240606115047.421045-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240606115047.421045-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 6/6/24 04:50, Alex Bennée wrote:
> The following changes since commit db2feb2df8d19592c9859efb3f682404e0052957:
> 
>    Merge tag 'pull-misc-20240605' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-06-05 14:17:01 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git  tags/pull-maintainer-june24-060624-1
> 
> for you to fetch changes up to c99064d03fc574254ab098562798c937a4761161:
> 
>    scripts/ci: drive ubuntu/build-environment.yml from lcitool (2024-06-06 10:26:22 +0100)
> 
> ----------------------------------------------------------------
> testing cleanups (ci, vm, lcitool, ansible):
> 
>    - clean up left over Centos 8 references
>    - use -fno-sanitize=function to avoid non-useful errors
>    - bump lcitool and update images (alpine, fedora)
>    - make sure we have mingw-w64-tools for windows builds
>    - drive ansible scripts with lcitool package lists

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


