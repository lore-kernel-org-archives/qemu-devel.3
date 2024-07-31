Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87F7C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 12:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ8m1-0002WC-8B; Wed, 31 Jul 2024 08:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8lz-0002RI-U7
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:49:43 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8lx-00072t-Aw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:49:43 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4280c493719so34384405e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722430180; x=1723034980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RPucUTQVtF0V6TkpbC8BMHUq8utt2/CCWpIG/cxvpoA=;
 b=mGsda0yHkqbVH1S7ELUtmiVPVRBKyHkdKGFFzd/j5C6j1bAbM9959ltOLqIgIVjBJD
 NxbSxJ5P2Wqx7JdhqEfUiZm6I+2dWV8mF4LXxgo2oGVtj93fTFlKLHqLIlROJQaMjH2A
 Teai0EaF3IloA0Yczr3B+nLYtlsWD+BQT4/j3xF0wapxPyLwknafofNCtkeisFoNR9uh
 RCARwcFrOjmCcfQ9uAi4EqVVmlfm005LCGRGQrPufJO3ST175H6rHXZ+8JZWYZb/uPSi
 A1IpBXz9k7hBh8gikjlRPDUeJGcfUliliVPJ1Xo6qDmrWpx9pU+0PGJgTstAqswZOUXk
 ypEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722430180; x=1723034980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RPucUTQVtF0V6TkpbC8BMHUq8utt2/CCWpIG/cxvpoA=;
 b=jsh3G7nR/k1FgrSS9/Riw1r9ZtRIyYIb0kzbmQEZ9vbvX+v7jfewG7lR+L/6+G1r0S
 6Wt3kaZT8kMHTCbHFGV21HkQSpMRbUebWCFkOrLpCuV4CzOIQKpwrWDaMu+J0Yy4OiYQ
 +0k0dAls33VtpmaWaKlY7WOCaJskoKmfG8GiZy6KBJWujrUSb3+8/dqrrSKoEXZnrZTT
 kzXBoWee1g6wVC2d6jeNXXGgcdRDLCf0zuDMe7SXd0l4GfziqkB11+3Pm5xZ/0PZ4vHn
 ZaAc7iwXSDTp+3c6Em8qUpPh4J1a7icKBo3TdjNzkVxcqkpNziQXZBNFWXHXHH/HEv4u
 dxWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1LVmB2WXhdU7FJnVGYH4LxkQlru9pbYe0fONQ6AbQN77w5j8FrphxVa/SmS9QSu2qa93JtxaSN/6t8BRZbmjhmZLcty4=
X-Gm-Message-State: AOJu0YytwhGpMS8NHU8zrsm2YOrgVbZqtp0oywbSfcEWVQ57DDYhq8ay
 Lz2bELPAPvmuOXctIopaYeJbvf49Ra/fg5h3Aw1mkqgqvU9ymcQpiek1JTjGsV4=
X-Google-Smtp-Source: AGHT+IFm4kiHKXMnfrUgC+tDMWeXgqt0SPwL5BhpxPid0w10VcCcFRVnax3zUgIautCLmB5xJB5AdQ==
X-Received: by 2002:a5d:6891:0:b0:368:6f19:cbf5 with SMTP id
 ffacd0b85a97d-36b5d03cb72mr8605071f8f.31.1722430179593; 
 Wed, 31 Jul 2024 05:49:39 -0700 (PDT)
Received: from [192.168.214.175] (29.170.88.92.rev.sfr.net. [92.88.170.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367fc63esm16905872f8f.55.2024.07.31.05.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 05:49:39 -0700 (PDT)
Message-ID: <c98fd67a-84f8-49f6-91bb-315069617ac7@linaro.org>
Date: Wed, 31 Jul 2024 14:49:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/24] tests/Makefile.include: Increase the level of
 indentation in the help text
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-5-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The next patch is going to add some entries that need more space between
> the command and the help text, so let's increase the indentation here
> first.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


