Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1F9FA3750
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 13:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc1Jd-0008Ic-Qd; Sat, 03 Jan 2026 08:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc1JZ-0008Cp-6p
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 08:05:06 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc1JX-0005Qb-6X
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 08:05:04 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso4990065e9.0
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 05:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767445501; x=1768050301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rj0D9Fy4tsFBp/Nvluk1xzBMFXsNC8C1xdx0saGdjpo=;
 b=F0SLo2GF34Tk7VwT/EWDSdQc3QrgVyXH2guFFxVUkDoa9VoOzxIZl/l32rihH1ho5W
 QQmSau8kSQuBhjbsJ7gOGXBJg5RtjYDa044fjOavNHyWGH9GPLsFJa5rp62Ugd3mrPuw
 4/gO/5zD2UPUO0HAvIhYKDbrzj9MqbpU/l4KmGAK4QlDVN+1S732XK//WNevMX23Ort5
 jcR6OeU/n5YK3/Z951gkgVGGKWcc3cFejL6R6v2D6BlFDEh/rNZrO78F7XfYfXh+YDN4
 8fOht7/MbDPOOmm9NNPVLPqtMmlqdKoEAb8Fhmt7a0kigNrCsLgQrRrQbBQ8wLu1A0XZ
 r6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767445501; x=1768050301;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rj0D9Fy4tsFBp/Nvluk1xzBMFXsNC8C1xdx0saGdjpo=;
 b=SGT1ZCwlDrpYO+qC/kzTGnWO0cc3t5drxCdgSgbC8CdbF6GFaaFDXREBxbR+EP2Q/5
 FTGDec5Vei3FHL/E3M1GsvIffBk8vggniOBeotneu/lh5Aw/HuIgT68liiX0D++PLtmS
 dRK8YGEmy05r3DwJ8gYzPHE6RWi9n1qTB6do4lMbcdb40MTYyofvx5YxEKJvmTwiSO1/
 1AF0S7BCM7l4ETxDv9Jil4l35hrOonPV2uUw2yPtm7REhyE9jDIVcc27PBSO1beaJnaf
 vuAR/JhGijSxR6KdnaGhZTg3sQyPn6202t86UICJ550+TFnoVohz5Qs/Bk46OGHYWoDe
 gT9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBJsu9gC1X+MV2bTMaoroMFKTFKlTuVaq84GyQlGlFdPB9Lbxn5AOzWshB6qw1LiDzo9odBHQmhUEY@nongnu.org
X-Gm-Message-State: AOJu0YyogMhb01JUIDoQajixJwieWnjUvV1imKMNOjf9JPXZBMa3MB72
 mramfu6PzEWzvA5L3ZtuHjGAk6lnrl5gaRv2sz4PHdI93BJtZDEQX6pQRfq6vihUdmI=
X-Gm-Gg: AY/fxX7VjRjkCd1n6p79ngjZBfAikeKZXgvr5HeVYVoX9N4N8ygwMqN+b9p+bZlKLHe
 DbYJ/6f2ho17CFzZp/E5Vp+LlZOYKpPwQUXaiqugyUJzaMluaBY5yYXck48UXWCWVPtCVZfvAqk
 iMSKKsuv8UraPvPIlbSewSClFRSiU/rvIkmuiO3Tr1Bxb/64hrm1+BhOpZ6xS6Dk2n9L7YDSxoM
 U/qPJC9SBbaVGXjNqVo5uS4BVEAZnp43qlpiO2hc2SGVMie45oKwIRs8Z3XQc4Qn+omsBUt849f
 pteVizPG9pe59tQgaBURexd1tozNZaI/d43veqw+byCsuXFtD/NMBxxvFwhypazlAeuMQwpf1Ub
 lRVWU2BLAzvbVAyAQEef8RaLak+12AfJRLdLUfBmSkeMP4FBZMWViJIlLBqd2UaHo3UuiR0apq8
 0gN/3AY9KyKQN9D5hdrVntVmOXbjWHogcnVhfnQWCrXNL3nk8XlcR9uFsU/s2I46+Rw3aTZQ==
X-Google-Smtp-Source: AGHT+IEKnpOi0zHZL0+pmB+SYYwSSr7Kjgwz2zwVYa6FdVbOhiqY0+aWp4wjR7LMR2wyqYxGO7Vf/w==
X-Received: by 2002:a05:600c:a02:b0:46e:2815:8568 with SMTP id
 5b1f17b1804b1-47d6ba858f0mr34142545e9.10.1767445500681; 
 Sat, 03 Jan 2026 05:05:00 -0800 (PST)
Received: from meli-email.org ([109.178.218.84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d45aa2fsm34894095e9.13.2026.01.03.05.05.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 03 Jan 2026 05:05:00 -0800 (PST)
Date: Sat, 03 Jan 2026 15:04:30 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P . Berrang=?UTF-8?B?w6kg?=<berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2 10/11] meson: update C++ standard to C++23
User-Agent: meli/0.8.12
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-11-pierrick.bouvier@linaro.org>
In-Reply-To: <20260102214724.4128196-11-pierrick.bouvier@linaro.org>
Message-ID: <t8ahoa.1wey0u0q21lev@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

On Fri, 02 Jan 2026 23:47, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>C++ is evolving faster than C, so it's useful to enable new standards,
>especially for standard library.
>Update to most recent standard available in our build environments.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> meson.build | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/meson.build b/meson.build
>index 38767c2c68a..564cdde9153 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -1,5 +1,5 @@
> project('qemu', ['c'], meson_version: '>=1.5.0',
>-        default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++11', 'b_colorout=auto',
>+        default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
>                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true',
>                           'rust_std=2021', 'build.rust_std=2021'],
>         version: files('VERSION'))
>-- 
>2.47.3
>

