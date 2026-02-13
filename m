Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C6DEDF176
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvDU-00056u-Tc; Fri, 13 Feb 2026 10:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqvDP-00051p-No
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:36:20 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqvDO-00058V-23
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:36:19 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso12676985e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 07:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770996976; x=1771601776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RzDU3ddb4A+ofVCsqZ4+Cvkw1tTrPo0GiPsdWh1++0A=;
 b=BTmkiUMatxeh6jiL+tbxznlvFLTqRawwPn4kAVKdnQNf7OwUIY9vmJDZ4P61dcKcXR
 OgHt68B6gsHMQuu0ifRrf9sVhAqKxEDM1QUDSlGNgIt1CGTNydz4cXOuNKbAWEnjO+tS
 DCAkFU1zXv5W8JhpVhbjxK0b88bo4zhOJT+OT8RTt/o3tBLdY7Lx1Lvq1eT68KOYeekI
 eRxZUnG1F7Z1mVcrobP1dZM+rLb52GKdi0BFlKgECxA/Owm0eH1vhKw9QiOK/y92SRis
 RFqYBwEGH0scJjZ0c9XN5hhWbu71Bv59aYPIghZ0eJNjECd0+5A+m+fiknIF5XojVzgU
 fXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770996976; x=1771601776;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RzDU3ddb4A+ofVCsqZ4+Cvkw1tTrPo0GiPsdWh1++0A=;
 b=P4K+pq5H6ltkNj10/S18u7+p0QlovwMqt7OyC8lCGDtv2T7wmQWI992XX/m6c8AKCY
 Mdge0w+OLctz8J49//VjDoe/ekXrdoVE9hOqTFchMJQr/AUnoDi9o0M4cEXYrErfjhIr
 KUDJL/TEeW0taoassVz/DANeSqKG08Q2oe9PpAehEhFGDq5TlEgTqGwi+kHuj68+UEFP
 jxQSDrEKjTIyMnm3UL6tX9LBWo6l5UW1nAkf75IE71y3jItQ6XvsnDcg3sz/uLHBFuLc
 +HHJHHSO7KbfxXZFL5C+2L7el0mMr/dr5G0X+pTPa/ImP/jGZVEYt0Sj3ewCeUxLt85P
 NXuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW7TyXIKnoKzIfhFAVe75rVfxv5871vHIcwU2S+2PoeeXKVIC/a0cfhC5ykgYaM07kCSac45G0bsXM@nongnu.org
X-Gm-Message-State: AOJu0YxI+2QVuJJZpBVCR8E/a4aWXzrmhrKwqOwfCkMMjAuODkS7smWI
 u7SagA8vlFApbQtzwDP5GhLPtPj4+q8V91Ef7POakiZoA8V8E9XMs7p9UFlAoxMc3/c=
X-Gm-Gg: AZuq6aIWmDsxmDwtl0dKsOwB/cVgm9ayrg5+wzGKWiaMlpfUXbncZyzaup+eg962cgn
 1OGFgbE9iqoDY/0Fv/y3A17G/cbcDJeJLSG9r71BYXpsBBVEp12xFtATdNwT/DKZ/V1QA9y4KfF
 0oXtzzyujzeEXO/nDMUIU8FBrDRrcjQS1nuzoLGJ2Vx1RRCRQAEJi6nJAA9ZFMytASc/wI6NTji
 K07lsd+JZ2ZTSYTWJUc1wz3DIIrwZKTrpAhYioBPr86wD4qcF4OP6t7svA2Kjhiiobnnqr/Ebtm
 oou1QrOvRUBEO3wKqzUvZ8H67XCLd4uAWe2sCueA/fHWrKDfgo/HqmuC0Na6WkmjAbaTcH1L4yg
 AYXVe+Qrq0ckBbRFjCNgsA+fixsevlaXa+erjgdoPyHqUNoV3o6/1UGMWKtfPPMcS35veFl3W+q
 SeuMOVzlZzEOZTVSb60H+gBEZzfrHaJOvrkHDH10YYQL2vrZ7crF9/SWb88JMKJewx4A==
X-Received: by 2002:a05:600c:4e4d:b0:482:f564:d613 with SMTP id
 5b1f17b1804b1-48373a26355mr37197755e9.15.1770996976412; 
 Fri, 13 Feb 2026 07:36:16 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5e11f5sm259779755e9.4.2026.02.13.07.36.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 07:36:15 -0800 (PST)
Message-ID: <0b6c3472-ef6b-4dc1-bcd2-ad4711f0e126@linaro.org>
Date: Fri, 13 Feb 2026 16:36:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] whpx: refactor whpx_destroy_vcpu to
 arch-specific function
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Cameron Esfahani <dirty@apple.com>, Peter Maydell
 <peter.maydell@linaro.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260213034556.13471-1-mohamed@unpredictable.fr>
 <20260213034556.13471-5-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260213034556.13471-5-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 13/2/26 04:45, Mohamed Mediouni wrote:
> Avoid a TARGET_X86_64 define by moving platform-specific code
> away from generic WHPX support.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-common.c    | 5 +----
>   include/system/whpx-all.h   | 1 +
>   target/arm/whpx/whpx-all.c  | 5 +++++
>   target/i386/whpx/whpx-all.c | 6 ++++++
>   4 files changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

