Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DADD75BDC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3MR-0007NP-Vt; Thu, 21 Nov 2024 04:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3MN-0007ET-PC
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:20:23 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3MM-0006ln-2C
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:20:23 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so5281345e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 01:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732180820; x=1732785620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0xU2e3IGaGnrZPCNbtih61Ah7tKbc/zkcpEJDNxMiNc=;
 b=heThBthT0vWysvxOep2TGNLSig5ZsW8xeclUsKk6kCQe/32vuG9sgeaJsRh1shGfgo
 vINplcYrHOwZuIvjPldNQ6w6y0rjKWCH96HoVJLKZi7Yy+ATe8CO3y9OTluylPjZjeOA
 rlgGvXurOy5bkfHN7uffQMD/zlfF5uBLrOMOLP3BxI0rq/MneN3FfQWTjgnY0h87nBcw
 naiBT6j6GaNbrN6HNmU2x1mcvm/IZuQafd4Bk5N7pzyuAZVlbHpoy3ZhvUgK1Ksn266N
 taUKF7HmQjRhNyne2b3vqk9HLKMQ5Y6zAoOVoxBrPotiB7eJxzdTtaTSJFXX5tzazMA4
 uojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732180820; x=1732785620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0xU2e3IGaGnrZPCNbtih61Ah7tKbc/zkcpEJDNxMiNc=;
 b=LH0bLzgaVqASlHZR2hNEZ+Z9WXHV1zckew/+/uyaG3boo/McMaH3ivAjku5eljIcr5
 4t+9gzHsD0gV2+ygdzF+sb2ehRshnD/Y5G2L9GVts0bqShllEW1SotbdXI+ITpaw73B5
 UI73ZTxd8iSnCQhOt1fWBb7ySrrC5YMJAFENtHkB6pD92rCUIPezDqFuTLBPLLlTZQ14
 eCd9UAWXgJH8njHxS950mAMEBa6EQK1wrwDIjuWEB5TiA1TP5Cf8lAXcao5e9Ol9KNtd
 s7UI3sr4hOQHCm8knypGZKqRM3JqMrfMegxvL8hDofm5E/3WnM+VfsFnJ8DEq4D+EJoQ
 DN3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5+LRkr9KF6Sl9YJuDisbri6rjuqd7f7vevODXIGGL6EFoCnEOOJ/3T04LXl9J2nfkfjBVsqlOsRTT@nongnu.org
X-Gm-Message-State: AOJu0Yxxc/RetN8pg1RlctMG7FAPL/X3YPel5KnqP0ynLm9QKhL/8uRN
 j6tI79dSXc35ydeEbRdxJ7We/XlUabfHvcMAF9rW19cyIYvTKWJ3lTG7BEoYtX0=
X-Google-Smtp-Source: AGHT+IG9emAhpiEvu6V/oLC6z5fuZoJCW8Ece6ODH1pbPPegPO9hukL2YrkSKLYGPPt+eOH68T+SCA==
X-Received: by 2002:a05:600c:1391:b0:431:5ce4:bcf0 with SMTP id
 5b1f17b1804b1-433489cc078mr57484835e9.15.1732180819668; 
 Thu, 21 Nov 2024 01:20:19 -0800 (PST)
Received: from [192.168.69.146] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b463ad45sm48995175e9.39.2024.11.21.01.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 01:20:19 -0800 (PST)
Message-ID: <b632c5ee-62c8-4533-81ae-497d33724fcd@linaro.org>
Date: Thu, 21 Nov 2024 10:20:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] tests: Fix test-qdev-global-props on anonymous qdev
 realize()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-4-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241120215703.3918445-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 20/11/24 22:56, Peter Xu wrote:
> test-qdev-global-props creates a few subprocesses and test things based on
> qdev realize().  One thing was overlooked since the start, that anonymous
> creations of qdev (then realize() the device) requires the machine object's
> presence, as all these devices need to be attached to QOM tree, by default
> to path "/machine/unattached".
> 
> The test didn't crash simply because container_get() has an implicit
> semantic to silently create any missing container, hence what happened here
> is container_get() (when running these tests) will try to create containers
> at QOM path "/machine" on the fly.  That's probably unexpected by the test,
> but worked like charm before.
> 
> We're going to fix device_set_realized() soon, but before that make the
> test case prepared, by creating the machine object on its own.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tests/unit/test-qdev-global-props.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


