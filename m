Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E149DC54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rknGc-00016M-CW; Thu, 14 Mar 2024 11:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rknGa-00015l-H1
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:45:12 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rknGY-0007Hw-Br
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:45:11 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51320ca689aso1371359e87.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710431108; x=1711035908; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/tsVpAtLaCvgN9dlkyI0vmkggG/7Ft3hdDWmTwIV4EI=;
 b=YjyIaU3vaHaupY5rj6xVSciFTRXy1zDNUQxn2/AYUtP7tvy32OgeNdHibk+Ro5m8tS
 Kz+9oB27UNc5FScuDJ2Re4jm7zZ02tvsMNBz+U5kkfAbCmIzXy93eJJZpHRIu326FpIK
 vGNPvWo1I6Bv2htalHi83BPzHwbKTWIEVDRiV6udyHS8nPcHe7H5VhASr/Z+U4YUic9c
 2n8TocKPWfSu5LyDZrlK54vjNi/KxWO5i8vAPq8rIAgI1IoaJsxtMT+rockWpJ/sGw+7
 aBqfpVImQx+EecoJzevYJkg4oe+l8iOUoDgEAri2KS5XzwRo35wjeh4O52k67VCPO0K8
 uOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710431108; x=1711035908;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/tsVpAtLaCvgN9dlkyI0vmkggG/7Ft3hdDWmTwIV4EI=;
 b=qOsQAmUhAyyAy7inoO8rrGXuh30eLP38WlSOYiSF10goq9FAc/xxyZr6rik19E8fd0
 5GY1XoBBTR7HT3t+b+s4WQ2l0c9wLQKkF9yJFfduKAFsWkvLlwUIO3xcHmIf0e4zRT25
 e6CAaPl7V6Wp/Tbypt3XFxdI/FHOkIg4QVJ8fqMOLoXKyJ5VlOiXfEieCmBFFZCSUaUP
 7dEavvDQRAQPQPmB02f2TZofEqMJISWuHlbL1LCshjQENW7L0sWHqjJe9M21An+es9Nr
 z2qEwSP7uQkSnwz/eBUYjB03fABW7mvPte33aoe7j3jj0GOXCdr2w8HPqp+Vy01j9NlU
 80Uw==
X-Gm-Message-State: AOJu0Yzz/ga2OlC/9AWYPISb4fEqgoPKWivOJDs/17piqpLPz78yEri3
 s7VKd0d9B+3X3SEgYcnSqp9/4AP5P0uVAPv6S4WX5arxy6GVz2E5tsLcTlI6dtw=
X-Google-Smtp-Source: AGHT+IEfxXoYx/PWLLBuRXi1GuLyNwYGCNRR5aV+gi7tPa7CTzK3jfbM2g0zb5wzu6qel03oMuWRlg==
X-Received: by 2002:a19:5f04:0:b0:513:97d5:245e with SMTP id
 t4-20020a195f04000000b0051397d5245emr424208lfb.31.1710431107975; 
 Thu, 14 Mar 2024 08:45:07 -0700 (PDT)
Received: from [192.168.200.106] (83.11.22.169.ipv4.supernova.orange.pl.
 [83.11.22.169]) by smtp.gmail.com with ESMTPSA id
 y24-20020ac255b8000000b005134751aca7sm314837lfg.275.2024.03.14.08.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 08:45:07 -0700 (PDT)
Message-ID: <42b7eeb5-9105-4958-8b57-1c7b56e52010@linaro.org>
Date: Thu, 14 Mar 2024 16:45:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] tests/avocado: use OpenBSD 7.4 for sbsa-ref
Content-Language: pl-PL, en-GB, en-HK
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org
References: <20240314-sbsa-ref-firmware-update-v2-0-b557c56559cd@linaro.org>
 <20240314-sbsa-ref-firmware-update-v2-3-b557c56559cd@linaro.org>
 <87bk7hggcz.fsf@draig.linaro.org>
 <7da62f7f-3e87-470b-b089-1bfe5aa97555@linaro.org>
 <87ttl8g8ue.fsf@draig.linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <87ttl8g8ue.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x12b.google.com
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

W dniu 14.03.2024 o 15:56, Alex Bennée pisze:
>>> If we are not going to delete the entries then at least use a @skip
>>> instead of commenting. Maybe:
>>>     @skip("Potential un-diagnosed upstream bug?")
>> Daniel or Peter suggested to open a GitLab issue and use
>>
>>      @skip("https://gitlab.com/qemu-project/qemu/-/issues/xyz")
>>
>> to track progress.
> That's a good idea. Are you going to respin?

Opened https://gitlab.com/qemu-project/qemu/-/issues/2224 to track 
problem. Subscribed to arm@openbsd mailing list.

Will walk the dog and then mail them with problem.

And respin patch series tomorrow.

