Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAB4C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6UAg-0005K4-HP; Mon, 13 May 2024 07:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6UAd-0005JQ-RO
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:48:44 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6UAN-0004eP-7b
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:48:42 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34ef66c0178so2920107f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715600905; x=1716205705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h3CwCjP9B/Dwvp/vX2oSoZOdgo+4ckHTMN2TreID0mc=;
 b=zJGuxPdZBCAdA+BtfLmwWaJvM91lKn6tmqVURbIKNxoFD+d7bzeOlqPhwsY0j1gHds
 jksR5A4oAUoMKJ2o/a+Hb8sanodb3KwzlfOx1BGA2+2Qwe9Dun1kqc1mzvcWMvW1PDPS
 KnZWz8uwMBmbv/Wx2duNC2/gIkWbfYDimczuPirGOmSwNy3+pmtc8Es4rzhlvwBLRU81
 VX0nQZIPslHsO7KsKTCKbyKoHR6/i6LKbbSKDgWt7qirO46vRIIfC1eTu4Oc5HpLcwwe
 7eltVfQM28H5t0+9vT5pwblDGa6l5caBzK8RJO9aK+grAGgcYuaolwKj3LQweDQ3Gqpk
 V1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715600905; x=1716205705;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h3CwCjP9B/Dwvp/vX2oSoZOdgo+4ckHTMN2TreID0mc=;
 b=lPt83xa8cP5MdK3/8CqNkX9vNxdErJdSwMIktGruHQL+07x/IUNvnh58rBaasha+iY
 5bgp2ucV4l8v25BP0rGv8Oal7Rg5zXM+yYNFjYXEeJpcg1vt/xqKkHjLnmardPAzZk+q
 xPUh1rP4a6AlOqmd7ttnpn8Nb9WEo5j4a4XMskTyBTJPbvcoS05J2JLueoznemAKEmqV
 91LSJcOku6mZcrhYwPm08nYsUoSuOgr/rrJWx2itt5tq3cZ631kk6YBKbmv37A8Cvbvb
 TyyREwxQeGMSX5lvcJfda4Gb8QhbwjIihRhXyOBOEXAlSkI0omSSM13TaP7UVNQK48cA
 hNmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXanbXCqCH3yGxwFg2IXnct6FQvUA6OhQJwgGZkHHh7XMaSuKHM2EYWfNKAYh0+6RGBRd7wlfnv0O8NbNLq97aLaLfvsfs=
X-Gm-Message-State: AOJu0YxREJVUWdUqkeRee8E9Rv3MWSku91+e95U7n2boOh5L+nJSoZfJ
 3AnvZzEDLMTT0Kt/PdFh48SZVJganllUiIUmx7J+EmjqZKAy0EoYyZl4rpDXrEVHvVXto6gNvaI
 ZDZo=
X-Google-Smtp-Source: AGHT+IFVXmcol4pzkP+hhNocZhUoW1nfEt5BXG6T+xxeOGrwcY5lWffP+jHyq58w8JSOl5Yda7x43A==
X-Received: by 2002:adf:e902:0:b0:34a:77af:50cf with SMTP id
 ffacd0b85a97d-3504a737657mr10782711f8f.36.1715600905415; 
 Mon, 13 May 2024 04:48:25 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b79bdbcsm10866516f8f.23.2024.05.13.04.48.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 04:48:25 -0700 (PDT)
Message-ID: <7ed09571-abca-476d-ab6c-4ff890b1367e@linaro.org>
Date: Mon, 13 May 2024 13:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configure: Fix error message when C compiler is not
 working
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240513114010.51608-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513114010.51608-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 13/5/24 13:40, Thomas Huth wrote:
> If you try to run the configure script on a system without a working
> C compiler, you get a very misleading error message:
> 
>   ERROR: Unrecognized host OS (uname -s reports 'Linux')
> 
> Some people already opened bug tickets because of this problem:
> 
>   https://gitlab.com/qemu-project/qemu/-/issues/2057
>   https://gitlab.com/qemu-project/qemu/-/issues/2288
> 
> We should rather tell the user that we were not able to use the C
> compiler instead, otherwise they will have a hard time to figure
> out what was going wrong.
> 
> While we're at it, let's also suppress the "unrecognized host CPU"
> message in this case since it is rather misleading than helpful.
> 
> Fixes: 264b803721 ("configure: remove compiler sanity check")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Reworked the patch according to Peter's suggestions:
>       https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04643.html
> 
>   configure | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


