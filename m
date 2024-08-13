Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FD0C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdq77-0001MJ-QZ; Tue, 13 Aug 2024 07:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdq73-0001B1-D6
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:54:53 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdq71-0005NE-Ou
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:54:53 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5a2a90243c9so4891056a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723550090; x=1724154890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KNrnLwkktj83LwX7k5NwtnBPwNBlV+p7Lc47hynjovw=;
 b=vjHIcoeajNho5c9Tw07WEwi4XoN5l7QCXbyWqmG9a3jQMb2mfW7SdtZQVzyeLMibaC
 h8pN8UTtOySIaat3SX0IGedwJ5ayWJbrXq2rGVVEOzCITcQdqwyGNsDTbIyYf6S0zPt4
 hyAUrqHv/t0NygfPAvqmXKpisfWJ5VFbcKHqX4oIFu1if8Jt++kcKPNXfmquKuPe9nrB
 0waWyDLyZ1JFXd/aauqSYLMjWPvT9O4oAgZtF+K1ctQuu0kJhHpOngdp1FMmc1DYKHDq
 mwEMaNpW5AEi3oIHTx7gB1gkcPXGoyucnk7HLHO2CofWPMN7Eu13t1/x+SQV24Bsln7x
 zEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723550090; x=1724154890;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KNrnLwkktj83LwX7k5NwtnBPwNBlV+p7Lc47hynjovw=;
 b=Kt3eWB1MoLWoseOimKyCFrAc4JBgaGjQQSFm8EDV29NAX6ev1b3gFFwADg7q5doFCC
 1qXEYUlBSyTfxInO0FvT00XRL8whDNalU00fNk/uVtwyM59CC4aVfGt9n5o4EaraTsGi
 doJ0Vo4y6FgvV5cJUTEQnoYt25eAyAJ5M33hoXe0b/G2gk8biI8m3Xm0QRarTNh76PAt
 BC7Bsi6OQ9IyltztlEH8U/1dDadkvFPnChHBwEyFCUy/C6/SID/RqFicaxGh6siOouZ2
 c+hffeRSy+Jf6INforOnL8n2bdKEiG6342sfkBpeWF2IqkaAkcuaN6uxxnUL64Z7SA9o
 UZMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2T2BhQYUl287RIbBU8cVxrDo65EEx7PUm1W2ZYxMqCruMoNJgXUtVTIdL9Bqne7RiGzEhw0nR7jyKNrb4Mm/IM8X38ng=
X-Gm-Message-State: AOJu0YycDHC8zVwQ5VHA8FRrA4IqIEUX6PsnESIPLmPuRr+JkSFtHAbE
 LjRwpYP4Q27mBi9rwMj+F2Z05Q0DPWCkULssuVYYv1aokC9RV8i0MXVwiwtUDiqqOD6WQSJcryW
 YEpI=
X-Google-Smtp-Source: AGHT+IGQ3xVvCGyXt9nTpNei7wN0zGjW4UI2TVSGKfRVtvkgWfY2N5ARx9vFYBvoXCO+dlI960Wssw==
X-Received: by 2002:a05:6402:84f:b0:5a3:d140:1a46 with SMTP id
 4fb4d7f45d1cf-5bd44c6989bmr2651710a12.23.1723550089555; 
 Tue, 13 Aug 2024 04:54:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd196a7ae8sm2933632a12.54.2024.08.13.04.54.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 04:54:49 -0700 (PDT)
Message-ID: <987865b0-5e2a-4da1-85d6-57f3f0ad2456@linaro.org>
Date: Tue, 13 Aug 2024 13:54:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Drop support for Python 3.7?
To: Stefan Weil <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>
References: <585da1f0-d755-47e0-bde3-eed6ca39c417@weilnetz.de>
Content-Language: en-US
Cc: John Snow <jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <585da1f0-d755-47e0-bde3-eed6ca39c417@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Hi Stefan,

On 13/8/24 13:36, Stefan Weil via wrote:
> Hi,
> 
> I just saw that the documentation still mentions that QEMU supports 
> Python 3.7.

Oops.

> Python 3.7 is an unsupported Python version since about one year. 
> Therefore I suggest to update the documentation for QEMU 9.1.0 and 
> replace 3.7 by 3.8 as lowest supported version.

Indeed, we dropped support for Python 3.7 one year ago, in commit
ca056f4499 (May 3, 2023):

   Our supported build platforms as of today all support at
   least 3.8 [...]
   Since it is safe under our supported platform policy, bump our
   minimum supported version of Python to 3.8.

> In addition the code which still mentions Python 3.7 or even 3.5 and 3.6 
> could be reviewed and maybe simplified, but I think this is less urgent 
> and can be done after QEMU release 9.1.0.
> 
> Regards
> Stefan W.
> 
> $ git grep -i python.*3.7
> docs/about/build-platforms.rst:  As of QEMU |version|, the minimum 
> supported version of Python is 3.7.
> python/qemu/qmp/util.py:Python 3.7+.
> scripts/qapi/introspect.py:    # TODO: Remove after Python 3.7 adds 
> @dataclass:
> scripts/qapi/source.py:    # Replace with @dataclass in Python 3.7+
> tests/qapi-schema/test-qapi.py:        # dict (requires Python 3.7)
> 


