Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF48C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 14:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkm4P-0007X9-U7; Thu, 14 Mar 2024 10:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rkm4N-0007Wm-Er
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:28:31 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rkm4L-0001Di-TJ
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:28:31 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a466f796fc1so101391566b.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710426507; x=1711031307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=i7xc7pS6F3jcTF6TJfq3ZHnKHc45oSB+aQCWg+Hj3P8=;
 b=Ppe3Hz9IJ7f+UhHkmkN8AGK3OXh0FrJNkhZgW8l91hJMkPiMv1PfgoQFVZHvhRRTeb
 40UrW04E2sH5WqepuFHfmaTtMQvPq9MSyTSoj1qsX0uky99qyJ5D2pYg1H1JeqHetAg0
 ENCYaVBy2zrYSJndlMGhJuJ/il/K33JXrwTit/p9nvj0JI60OL0fB0HCYmgyba6wcVbh
 oO7pmtDeS5kUkIKDEanJPVbspV2xlw23O9Nn6mCMGNrkBOUbfSFWuTztEk+scz6PGA2L
 d/Rv6kcSZKnn7FgPGR/vNyp78Ilrf+7A4Sn80Fj8to+ckz6tpcKzf1O62a/I++/2nhHF
 wz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710426507; x=1711031307;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i7xc7pS6F3jcTF6TJfq3ZHnKHc45oSB+aQCWg+Hj3P8=;
 b=avha8B/bhqx0tyiy5nFJ57kDy4t12bT3PWJc0PY5TauiZ64H1xQQMAngiOgAAwiQdH
 k9ZQaooglwTe8kj5RnXGXkjiAM0akJ9gcMzsq10QkH+uQNrD8TTfc3D1k3BCVLdTerYX
 om7z2vdLfOOwRaMKr7SmxkLlWnINNjU5NBgIjZOjtHHW2rbQ3qg7vX9J2He8jO0E7fsi
 ib7M3yVg1NDlKMaw1LDfbPiu+AfpXKmGEO+HRH/S7LanvEZzTi8w2NVXHRcKzEO2yqj2
 sXwXjBZYAR99gQF2tI3qE/YdoePDikEUzEcSkXdkZvRWcJ/ow8exFO5eELHwG2042Km3
 srAg==
X-Gm-Message-State: AOJu0YxtooqojeojZbTqRWZ4BnCj9ziqMbVh5y4E6e/WyYXesqp0vru6
 wX7d/TsJN9IfEJ7PQ6cPvroGR2012EoKEpyFXrkOKznVMssGYpbHSsogeTGYLP8=
X-Google-Smtp-Source: AGHT+IEK1ZxfiOuBzAlxM880gF0382rndq2nqsWuUaychIvSogXSAcqwFw5jJqQkkxq60OtLJILCKg==
X-Received: by 2002:a17:907:198e:b0:a46:7929:8850 with SMTP id
 li14-20020a170907198e00b00a4679298850mr741109ejc.39.1710426507665; 
 Thu, 14 Mar 2024 07:28:27 -0700 (PDT)
Received: from [192.168.200.106] (83.11.22.169.ipv4.supernova.orange.pl.
 [83.11.22.169]) by smtp.gmail.com with ESMTPSA id
 gq25-20020a170906e25900b00a46636af78dsm757230ejb.100.2024.03.14.07.28.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 07:28:27 -0700 (PDT)
Message-ID: <fe009721-1eb7-4472-8ac3-e0482240a202@linaro.org>
Date: Thu, 14 Mar 2024 15:28:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] tests/avocado: use OpenBSD 7.4 for sbsa-ref
Content-Language: pl-PL, en-GB, en-HK
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org
References: <20240314-sbsa-ref-firmware-update-v2-0-b557c56559cd@linaro.org>
 <20240314-sbsa-ref-firmware-update-v2-3-b557c56559cd@linaro.org>
 <87bk7hggcz.fsf@draig.linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <87bk7hggcz.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62e.google.com
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

W dniu 14.03.2024 o 13:14, Alex Bennée pisze:
>> +# OpenBSD 7.4 does not boot on current max cpu.
>> +#
>> +#   def test_sbsaref_openbsd_max_pauth_off(self):
>> +#       """
>> +#       :avocado: tags=cpu:max
>> +#       :avocado: tags=os:openbsd
>> +#       """
>> +#       self.boot_openbsd("max,pauth=off")
> If we are not going to delete the entries then at least use a @skip
> instead of commenting. Maybe:
> 
>    @skip("Potential un-diagnosed upstream bug?")
> 
> but it would be nice to figure out exactly where is breaks.

I am going to subscribe to openbsd mailing list and ask there.

OpenBSD 7.3 works, 7.4/7.5-current does not.
And it is on Neoverse-V1/N2 and max cpu types.

