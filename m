Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0DFC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 13:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfgkc-0007du-8D; Thu, 29 Feb 2024 08:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfgkX-0007bk-43
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:47:01 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfgkV-0003xe-Dd
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:47:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-412c2352f74so1716535e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 05:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709214417; x=1709819217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uou0Ae2DMXBpv/Kv7DNXdvKJQbnvfnkSlMvXO/axBQ4=;
 b=N7uCt4ai5RDt22PqCwWkjkrl50cpvlmO1rlDgiWUEhbtEl9t21VJmxXmFw/BQ4wYdM
 Ms4spr/fyTGHAAxosUcGyyMtyYaZzv7SZfLbwukRzKiidMurYQqevuxD12osSMjAo15P
 ZOiBMKUwASObW+b7EAMGgm/72LIPhJRpsp8WVc2gxlO1bhwp4/R5fHQzL6mDKHsRxn5j
 YU78eqoKSgcOd8iJYHOS5EmiLwITABzVGzMYTcN2oLrFMYGEPzW9Gn+9GFiFwzLPd8iK
 LdcEl/WV0/FO5TVSLdl39HIcHGsmsuRGICumiOGuNxaICPjcrvTnuSu5mxx3iCEFsWXJ
 kSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709214417; x=1709819217;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uou0Ae2DMXBpv/Kv7DNXdvKJQbnvfnkSlMvXO/axBQ4=;
 b=MKlT3RyFMafZBvjN3WKIOlEu1eBAJK3z8wB/gSc0L9Vs8hjBn7QyqOAShH3SFsqoVE
 hhzwXNibEJSUbwxKYwM49VwJRn0WD/RaHEXFbA/GF1pnvoN7msULMj0umKvoEteubOLH
 KVctKGc9b/9RLMrpxnpnVK6TIGoo6YRluFnNEhoukgQ51AeGA+DciOmisHmqSKUIMADT
 AOb6Hq2pLS0oczsJOLwMAYQVwuuYdDgxUOubzS7SO3rw3vKxoeYc2rKaYtJBzvJoIWTt
 AOio0GjjWjYWRr9IZoK4T7pZREWN2f+33+uggQL5UTpNdt0lW/nMX8qvNThVMMJXtGIx
 Gspw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCNuGLulLehl+jVxvvUxJMr/Db1AbsvURwo20TlhTrM2MJR2qJKjxwbEX9wLsdV4LGBIYMw8Yt4f6aj4XybeTWhjVUK4A=
X-Gm-Message-State: AOJu0Yztx7SS1Et1ka1i8UNZKdNLWluFW+8SwJ8UjKS/1Hn/tSPeUIDW
 tUCpODORkwe2usAW3yEi1znH5hb4r8i2vZdO04tdD5hlGCHWDXpWGZEa5ZokPAU=
X-Google-Smtp-Source: AGHT+IF1MDQQQJC/hyRPzBplCBE6i+3xhzK6nP3ur46cAkHZwkIIJUBIlquy3p8IsgdRFx7iBLCgPA==
X-Received: by 2002:a05:600c:1395:b0:410:656c:d6d with SMTP id
 u21-20020a05600c139500b00410656c0d6dmr1875301wmf.18.1709214417042; 
 Thu, 29 Feb 2024 05:46:57 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c470a00b00412704a0e4asm5337620wmo.2.2024.02.29.05.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 05:46:56 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E1135F7B5;
 Thu, 29 Feb 2024 13:46:56 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Luc Michel <luc.michel@amd.com>,  qemu-devel@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 06/12] tests/plugin/mem: migrate to new per_vcpu API
In-Reply-To: <03ce19fb-0b82-4819-aaa4-a2241517090e@linaro.org> (Pierrick
 Bouvier's message of "Thu, 29 Feb 2024 11:12:03 +0400")
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-7-pierrick.bouvier@linaro.org>
 <Zd2sxjxegajy7ZbF@luc-work-vm> <875xy8b5sg.fsf@draig.linaro.org>
 <f0133db0-63e1-4634-a18f-fe181754e17c@linaro.org>
 <87zfvjagse.fsf@draig.linaro.org>
 <03ce19fb-0b82-4819-aaa4-a2241517090e@linaro.org>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 13:46:56 +0000
Message-ID: <87ttlr9ycv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 2/29/24 11:08 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> On 2/29/24 2:08 AM, Alex Benn=C3=A9e wrote:
>>>> Luc Michel <luc.michel@amd.com> writes:
>>>>
>>>>> Hi Pierrick,
>>>>>
>> <snip>
>>>>
>>>
>>> My bad. Other plugins enable only inline when both are supplied, so I
>>> missed this here.
>>> I added an explicit error when user enable callback and inline at the
>>> same time on this plugin.
>> We could default to inline unless we need the more features of
>> callbacks?
>>=20
>
> This remark applies for all plugins in general. Now we have safe and
> correct inline operations, callbacks are not needed in some case.
>
> Would that be acceptable for you that we delay this "cleanup" to
> existing plugins after soft freeze? So we can focus on merging current
> API changes needed.

As long as we fix the double reporting bug sure.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

