Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4FBD47CAE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 01:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgYPV-0007Lq-Oz; Thu, 15 Jan 2026 20:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgYPT-0007Jl-8T
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 20:13:55 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgYPR-0004AE-Or
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 20:13:55 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso11329565ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 17:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768526031; x=1769130831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=M3/Sniajm1GuEWA6Y2rlJYwUwPZAmxKiZQDs4S+19yg=;
 b=HEWV20giEur1fUA6YQkle4FJA4RMbx9WDQy+G6dcfb111+CiqF855V4cnv02smCCMO
 7ijXyTETMQUpjt8cMY/Sy62jZ2knr0qtBBG/4w9ajOhof+l7Mub2Ec8yqiEjXxl5ASt7
 Ebu5TmAVheD+ey6lH/48jjfEJLc5IovOW3MIx+BZMc3WoagP2kg/XfXagnQ2mg5CAWrz
 tbHd0bbn76pQ2yBcsLucUYCjEzob0mH7d9dCCkUot5YnXMjVeUJbTqTcrt8FGHwQQmpi
 HYfDacLPiOtTltIPfzlxX16lm4kxaj1dICEFFIFks+YLyethKS4mhzKJRxnAp0ysic5J
 a0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768526031; x=1769130831;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3/Sniajm1GuEWA6Y2rlJYwUwPZAmxKiZQDs4S+19yg=;
 b=GjLq6OXHHyRAegWhDbZgGbX3nToStpcKLBvcmOb3Y0HaHBXVKuh+S/I5oq1F1zD5cA
 81VyDrHPv1WsoJ7fa+LCOUrsCYLocdd4/YP56J54dP1bLgw+g3Fa4MKyw3L4akiMpen5
 EpmCYT9xaI9cCQf6ssJ5T0nFmOTp1Ih1p+8+gbGP56qhuCznGKVzjs7OQD9x8ce5XumH
 2gBOmPoR7rhUUXvnZPscFHcfnzEAiNHbH1z/eni+pcECUKQFXinmbQdGjnj2pKt9h4bk
 94qTUncmM/rpxws1CiVNJ5uYBy2PVfCSVeecH4QTJyQ5JRhHwb6gMtHTNRZEE6VWxctA
 qt/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8uwcKIGxHmtStirR6wMBQ+n7E2OtpKXQHaDSA1VYZI+RY6zv3KRuKr5j8knvsUnYZTUG2+TvAAdRO@nongnu.org
X-Gm-Message-State: AOJu0Yxdld7w5hdxjw5T9xDlxRtLwMTodPmLJUpqrQllT1bqm0QQYKGs
 I4o6k7Eybz64X0UvY/Y7GKjLk1wW3A9lClouTBGZNQqSRfCgcfrCw8BsCVS++KuEXZ0=
X-Gm-Gg: AY/fxX4bl6nJj8+c3XrWkoR8bstRcm6wM7pm3KfUgzEPya0KR4Do8xDwJuMRU/dnDKj
 Gl3VuJfI4bdl4YO3G/v4DQ6idXP8YyP3CBoyFWS+2MReHhUhWBrt0KJbvAPjQpVjB0+oUs6LXFD
 YqUTSGvF0TOwhMB993J2IbAjP2WHQWkdBoiLRiaCspCzraU9tV0XamDVrPNg6TmF2IjH12AkR2p
 +YPYO8pEglfNt4sATXXETquuznQaxB8oBD1krNQgkwJ0DGf8WsX2It1ebtT8tHltxKTQ+9Jr3CR
 /NIgMNe11Ip9ZBFUd0oyjMAd5vtI60pK4cmoyscsd9SEG1QaNbaj6dCrpeZaQ257Y1ktho3RA+p
 tZ/lrlj8SyR2p9peom/2xRnF/L+n7a9+AFdwTSVY/FTy8oleUmN9zAU7JE6ZEgu7w7wo20T+7T/
 6aeynlt+m6jg/4fh8rWfX+zErnt7++K0Xtg/V3EZyqdH395PHvVVqm1Etz
X-Received: by 2002:a17:902:d9d3:b0:2a2:d4fb:2e4 with SMTP id
 d9443c01a7336-2a71888b473mr8044425ad.3.1768526031392; 
 Thu, 15 Jan 2026 17:13:51 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb28sm4560215ad.49.2026.01.15.17.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 17:13:50 -0800 (PST)
Message-ID: <6364bd7b-057f-428d-9e3c-a13c687f04c4@linaro.org>
Date: Thu, 15 Jan 2026 17:13:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 15/26] whpx: add arm64 support
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
 <20260115001505.57237-16-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260115001505.57237-16-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/14/26 4:14 PM, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-common.c    |   1 +
>   target/arm/meson.build      |   1 +
>   target/arm/whpx/meson.build |   3 +
>   target/arm/whpx/whpx-all.c  | 815 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 820 insertions(+)
>   create mode 100644 target/arm/whpx/meson.build
>   create mode 100644 target/arm/whpx/whpx-all.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

