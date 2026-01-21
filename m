Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D120C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 20:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vifDm-0004bP-EE; Wed, 21 Jan 2026 15:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vifDk-0004Uk-CZ
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 15:54:32 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vifDi-000522-Qx
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 15:54:32 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso833999f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 12:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769028868; x=1769633668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GADz4nCcV1baN5WGsrXQRJuIVCPgCjoO36BO4nREQGA=;
 b=Zn826/G+5PdIQLtu456tpW9gFkQJiyiVUUWUYlXudKKZJVW07d/52EBP1DVAc0drv3
 9TXi6aL7dFoIaPRfTYEgvMGJypxUM9RJafnZx85nMQAZXQlkMDq2ZMlX9ETi/QAeyc14
 +24Kz56B2ZaId1XxbV1EOI9bDIItGHI3rQDHqqcadpScRiSkzjFDbKe6Vb7l45GebkP1
 inV3HDbbvCNUmP1NJsOj+62DdTnhk3MMI/p+ETHWYlKOFvAOA4DtfhocOTmeVyNn1XDx
 /LbTd6Y9LutJniqWwcNQTd4OFxswKZ0Nf+Z2+XdSoli38rgO/jW2/HDAxLsK9rM4+/+S
 oXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769028868; x=1769633668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GADz4nCcV1baN5WGsrXQRJuIVCPgCjoO36BO4nREQGA=;
 b=BaeVvwLjD8v0ygdsNzuWNwIUUiJHtAiP7nPE7sQTivwRT3skgc7Wcpw1vXFDEkyx77
 YANNbj1mUE/UzkeIlXVhWi25JlyBr3omhqVBrHsxK7FQJywxYUNIWZis858//VLDW8pw
 nScPYpuRGAh0mInRazYvofeLTl5i/rVHmtTP7Tm/NvrEUoPzYV8bUCX9mFzFSF5DzjcB
 5F9EEgL7AiVk0SJINJ6g1HvSIqp5PdsR5MVJuIKFNMxHUYlrxFZc3HxADNO1JeEzRMV7
 cbTmVFa8bRy35ex7SNzQQYXNjC8Q1xn82fWD0otVXchvyyH3HU3p8RvNH22sIqdTbR1D
 Fl9w==
X-Gm-Message-State: AOJu0Yz+nftvhFveTJCRBUi+kvcXrm2XLZhwyf/c+D/nEnCvVhtGLpP7
 NBkQc/awYiNovMTsyOTRUW5RmCS5arwQO5oWKZ9HZSm81FJXKzvGxiVuy1hVFay3gLhQP9GnhWp
 ffbs5ZwE=
X-Gm-Gg: AZuq6aI7TgY/52jh5rE8NbUpl+VcTHvNWrrFmgLcXaoFEDRvqhSd38pLkrtIslE8qz4
 Dbx8EaIRRzzCZ9+PKOHNLRgbpkUfeHWY4ny4q3Hny9URcop9/vw/0pBm6mB9uhcfM4VwdhrB+oP
 In5Ub06DGnn2un2W+23zR4gjgJ9u6s/aMUDcdwx1RZVMAklnuBhRHn2EOOIZ0i323Z/Cm8+v9EG
 aqP1Wc0DlX08pG1IFmrqFF6WxBx6Q4Nspwn6k58Yrf2anaGyRSd1e99+JpQufvBd+WjGEyjP+3z
 qzp1geVvreraPR+pjAG37OGndt9/AN02ATP3dAYB4CBKbwtrU8N48+pDalz0X1VRDcHSBsIIMa7
 xVp6zkO5Dw4ByXQzWNeURlexyoiEzS0eSPmhubUhJvinwhBXhASsisKoUJddhM4/RNOFS4eZiPm
 e+SNvYoYjde7Cm47gAqcKsIonp5PgmGBkrGNnvjPnlHzOH9Nvv8rU3AQ==
X-Received: by 2002:a05:6000:2406:b0:425:86da:325f with SMTP id
 ffacd0b85a97d-435a5f93e4bmr1208875f8f.27.1769028868394; 
 Wed, 21 Jan 2026 12:54:28 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43596291e0asm10456933f8f.15.2026.01.21.12.54.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 12:54:27 -0800 (PST)
Message-ID: <086363c7-caa4-4d08-8844-2f5387b477b5@linaro.org>
Date: Wed, 21 Jan 2026 21:54:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] dump/win_dump: Build almost once
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260108161220.15146-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108161220.15146-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/1/26 17:12, Philippe Mathieu-Daudé wrote:

> Nikolai Barybin (2):
>    dump: enhance dump_state_prepare fd initialization
>    dump: enhance win_dump_available to report properly
> 
> Philippe Mathieu-Daudé (2):
>    dump: Abort in create_win_dump() on non-x86 guests
>    dump: Build stubs once for non-x86 targets

Series queued, thanks.

