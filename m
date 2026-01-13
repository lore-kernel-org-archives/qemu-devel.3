Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850ABD30CC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 21:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfm4h-0008Gu-VN; Tue, 13 Jan 2026 16:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfm4g-0008GP-GN
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 16:37:14 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfm4e-0007pK-Vn
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 16:37:14 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34c2f335681so4672662a91.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 13:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768340231; x=1768945031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D3u9NhNhYm3nkmNWnWJvr9xhkT+Tpwb7c7kvOZNM8wg=;
 b=XASC82SEY+gJdfK74mgFLinEIGz3gmpmgpXepJJZKagq1cx6oPcy9uCy6PgFgMrNVZ
 oYnLZ5og/0HKjDpKoC/EcAyvjmuJzFoTuCru6oawc759w8zWjufrKI3FRNRh0aONhtP5
 nbgqC0G9RMuXXyJTtBBVRjxmcrkjvZKPmACVK6H6LZp/+DSZC3DwgIasVOdH1K7ebxIO
 Gl5yd5Y5jgCVuF8uW9JpfRVPQiqeJVhLuIy96qdq1Tbkivl1EnDYzu+Mmhktk0dAC9MC
 PV3eJlFEM2ZSJi2NhXH8Bs7bdzOphv2zm8Ou0ptsC8Sq9gndCUvggXmkZEfzi5p20Tjh
 PJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768340231; x=1768945031;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D3u9NhNhYm3nkmNWnWJvr9xhkT+Tpwb7c7kvOZNM8wg=;
 b=E40653G4RoPvqkXhQj3X+wplCghK+eYihOrJc/uZ33aL15+HLXJkQYavnKFMJieF+Z
 6v9JpZraqyF2d78dLh99WoeOaqRyoZb4PZJRSinkM6kN9H8S1lmDfVCeywRikgzPwX4y
 F6i2jc1Ab7ADnmD6RaTHVCqCliJ+KaeK9oNIC2IDsXQgPrcTyhXpy1ZKLHgmjBa0ubPv
 nXdck/YGF27WFl/Bi87rP0DoJPjrde8Vnn0yJ+C+wy5QpAmOXb/FCl3yjkz4jJPLeX9L
 APMbjrtBFbjClGLUN+TbIrHzbU/tZCBuUPzerw4aT4qqGXIsjlAM84fDnuk6vDOkkuJh
 2L2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJnm/QcNX/nCEgaggjCmBUGsBPboIX1dhwvHcMVTIUvhr1P6tMx/Zf7qlueGtYaBc3Kv7BoXSO4cWY@nongnu.org
X-Gm-Message-State: AOJu0Yy0DUFT+9rne0l3alS3dpbLzI71wYDodYq8cvHYIV2rVSvqeTVI
 baPjnSHC/9gpqZX2rpRSfPOkSUaNpd/QvPvmIZryXbhKJpBzpRB3o55xOes0fPsZYELKEV0ub+W
 8hQWhQbA=
X-Gm-Gg: AY/fxX7lDd73UfD4P4mL8ng1jfiGMCRhwqsHtv/AyQJrj65XzJj661BGnKWBWG1BPRT
 XsYKZwDLlpAlXW2BuVeGm7UCvHtWeFP5RCcqOtrCGlIblhRXoQasMcW/ts/nn5alipbfYAmyovs
 PFEIwFJK9JHj3ZxxW6IvTaOyhUawSSp9oRzf95cz9mXp6kmddGoxXWmQ55h6+iAiCKg+EyxxhXf
 kxXVQWfmrREBxeJSM5Dyim2eSQj6Gw51y9FAQXd1ZAmmaTz29ccOqusKMTVI8wjCQi+4YYS040E
 l9+0v9fTvG1nIidr/xyieqrzOPVEvJNz9ZfUtcVml1Ou4P59By2PgVaj5aGvn2LZ6zK6pKEvlJo
 38zXzkTFulCNGhva+/jb6jtNIdJHL+kWB/0UAzp2J2vXsCh+gjAeQw4Hk474tJ5KU1ztdyNkdB7
 KbtOppXqOsoMA1az930ZKOLsLm/M3/xC27MVKmFrFDfFhYir9ajoyjBGa5
X-Received: by 2002:a17:90b:5206:b0:343:a631:28a8 with SMTP id
 98e67ed59e1d1-351091a9fcemr474566a91.37.1768340231304; 
 Tue, 13 Jan 2026 13:37:11 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc8d29516sm20854366a12.19.2026.01.13.13.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 13:37:10 -0800 (PST)
Message-ID: <1f5016ba-bae2-47f9-9a58-713416196aa6@linaro.org>
Date: Tue, 13 Jan 2026 13:37:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] .gitlab-ci.d: Add build tests for wasm64
Content-Language: en-US
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <cover.1768308374.git.ktokunaga.mail@gmail.com>
 <ee30d4956a485fd46b4735028486d3fb7b22fe60.1768308374.git.ktokunaga.mail@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ee30d4956a485fd46b4735028486d3fb7b22fe60.1768308374.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 1/13/26 5:54 AM, Kohei Tokunaga wrote:
> The wasm builds are tested for 3 targets: wasm32, wasm64(-sMEMORY64=1) and
> wasm64(-sMEMORY64=2). The CI builds the containers using the same Dockerfile
> (emsdk-wasm-cross.docker) with different build args.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   .gitlab-ci.d/buildtest.yml          | 24 +++++++++++++++++++++---
>   .gitlab-ci.d/container-cross.yml    | 11 ++++++++++-
>   .gitlab-ci.d/container-template.yml |  4 +++-
>   .gitlab-ci.d/containers.yml         |  3 ++-
>   4 files changed, 36 insertions(+), 6 deletions(-)
> 
> V5:
> - Fixed wasm64 tests (build-wasm64-64bit and build-wasm64-32bit) to share
>    the same wasm64 container. The build-wasm64-32bit test passes
>    --wasm64-32bit-address-limit to the configure script so that the output is
>    lowered to wasm32 by Emscripten's -sMEMORY64=2.
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

