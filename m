Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334EAC52D71
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 18:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbOnD-0001XF-2B; Tue, 06 Aug 2024 14:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sbOn7-0001TE-U5
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 14:20:13 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sbOn5-0005Iz-VO
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 14:20:13 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a728f74c23dso107926866b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722968410; x=1723573210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=F2Q8ARQWPkZG7WAqjFmxJ/8+odByxc1YLJGGmnQA2as=;
 b=VaBsbUrup2PqToEsGUZfBiWdR/qLVlNWiNJ3fQQz+kHTNIY2BGvcOfI8IZ0IIKbTMi
 LB+EG1QGAvJBsMKEJZRRswCU11BQ7epb0Z/gehSFWq+Cg3etV30Ek3IWknanQtcVJJgI
 72UMuSqDZzvjI1+3UolkqK0BDxkxXmG9IA+ahMoo6KbeEFt6Lf9JpVg5CTg04nVI/pwk
 hNS8kQ0tklg4fHDyZirlaIXvdcx9AXL3a5NbScZjZ80/qBNyxBYD/YGhOsXJE1BvXj7S
 Tgf+5c18b8i0vLjiK35DY8M6ZoWy7+Ipg4IgXxTAaJTvzr/63UcyKBLDzyn+6r0jHZD6
 qaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722968410; x=1723573210;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F2Q8ARQWPkZG7WAqjFmxJ/8+odByxc1YLJGGmnQA2as=;
 b=tblpShyMpbkHituG7dQWuI3TyU67F5EkhRpKssSm/5QhdBZxzMDj+WajlhqG59nLv1
 GwdU2lbJvbpNxaqs2KNP9waQSR+tqwLUSk+WARNu6SdwZKwTBFUG8nvsHW57Lmkxu50k
 wSDWXnqmtPA6f+jnMihItCAmK+rIslHH3NtACGVgSncwpsXdV9EUl6XNudzMASH6d+di
 5IvLLO5jJmRIi7nKekpThropXw/uX1/Ceu4bAkuzevbtmjwjIAAT23RxY9Fi9kqedE/n
 HkZvbIZviAAMdbRy1Qgej4pfUFKvgf5MEkAeYiCi3sO2YttWYHxLDVxFMXpUxs5mn256
 lW5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN/AXU/FrYob49oD5IsdC5CMXFyM00kvMtd/tioIlOSTsy7QG2CIhIVANxumoaJUNzrQNz8x6MGyeqjvHnewZ1KMM0MAk=
X-Gm-Message-State: AOJu0Yy1FSWkhnRIUBri1ZHxrqo7swhLwZ7JQLTtJGgKnFq1UD1mnAaQ
 /y7iXcQXHK1ptQp6y0FrJ7tzU7vHoPsQcfzPgOg0SctlqmTz6iYqU+8WTvon5iE=
X-Google-Smtp-Source: AGHT+IGPn0ybi8q2QWtQUgttzKHLgQajIsoU7p0aIZGtYSOCPmuSWlb4w/FOZI/RAhpXXrZvysLW0A==
X-Received: by 2002:a17:907:6d17:b0:a77:dde0:d669 with SMTP id
 a640c23a62f3a-a7dc506c299mr1149565066b.45.1722968409637; 
 Tue, 06 Aug 2024 11:20:09 -0700 (PDT)
Received: from [192.168.200.25] (83.8.56.232.ipv4.supernova.orange.pl.
 [83.8.56.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d89a9fsm563924066b.156.2024.08.06.11.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 11:20:09 -0700 (PDT)
Message-ID: <9964eb0b-7466-4e99-8fbd-82f7efab1af9@linaro.org>
Date: Tue, 6 Aug 2024 20:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Bump Avocado to 103.0 LTS and update tests for
 compatibility and new features
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Radoslaw Biernacki <rad@semihalf.com>, Troy Lee <leetroy@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Beraldo Leal <bleal@redhat.com>,
 kvm@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Paul Durrant
 <paul@xen.org>, Eric Auger <eric.auger@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Leif Lindholm <quic_llindhol@quicinc.com>
References: <20240806173119.582857-1-crosa@redhat.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <20240806173119.582857-1-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x634.google.com
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

On 6.08.2024 19:31, Cleber Rosa wrote:
> This is along  overdue update of the Avocado version used in QEMU.
> It comes a time where the role of the runner and the libraries are
> being discussed and questioned.
> 
> These exact commits have been staging on my side for over 30 days now,
> and I was exceeding what I should in terms of testing before posting.
> I apologize for the miscalculation.
> 
> Nevertheless, as pointed out, on the ML, these changes are needed NOW.

Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

SBSA Reference Platform tests can be done in 1/3rd of time is a nice update.

Serial run:
real    6m20,324s
user    12m18,446s
sys     0m36,686s

Parallel (4) run:
real    2m22,658s
user    11m50,514s
sys     0m26,088s

