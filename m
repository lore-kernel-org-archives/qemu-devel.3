Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38B5C52D1D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcZM-0001sy-84; Mon, 29 Jul 2024 22:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcZK-0001e2-1K
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:26:30 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcZI-0007aG-Iw
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:26:29 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-67b709024bfso29337237b3.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722306386; x=1722911186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jWAsRYj9wPysg3AlR0EXI7oeYMhruK0UyYdo4inlPic=;
 b=t/1tqencJ5260BwDxSYB56+sUwzA1kRvAKTFKwpDVm1MYupBKmsNBfwRTGD8vvSV8u
 ZITfEa5ISpVGaMhD695YZRSW0pG7jyfIZs2pDvmNatGmX/RDuascR03LGOY0rR3r7qKc
 8+M7vg0rAj0wApH4x2UwVeYwJ5L6h5dAhkFSr/mQ+ya1iHpp+QPzZEpTYvOTAaUvBQ4a
 GojY+qFCA9TFnVy3kyw/Ph67TMiPSU5n53rLBS9t+dYft/AVWLGPTqGLlMJTrAiAKgrM
 gHKZFWFOkBMdR+xXK3iv4Yg6jMbRi25sUOLIf1TnjM9WnLcy2RH9OAENkKIWTTPznmTH
 abiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722306386; x=1722911186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jWAsRYj9wPysg3AlR0EXI7oeYMhruK0UyYdo4inlPic=;
 b=JtWM02zNfMNpc5BCLHwN4tJot7YlsljZjwdKbCKk6knqjMXNeX1w9MxuMQ8yFf/tm2
 Tq6ru3EeeAi7QWr3XWkC28hPXHlAfw3cIbMLjFmxCxjxnSNJW3Oy6ZuaybRLsbxYtNeQ
 cM2AsIfjUtFDRMUb+CuQcafiJaL48ZZmL0ZzqBjsRmOIvsqJ5dObGf5SC54t0wUR7vrD
 A6lEFhet5b+mbUU1rmiXTeilCXLsosNhci4Jc6Y98o/88g0QW0l/+NAkezTsb5V8jVEb
 9+RsBiHF+p57fVAqaJx1mC5wQ2rFC1DAvRSt05fGoPxG61E6HnQKRMQ0hNgPwHt/BwD3
 RP6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKZfZD8x/5c4Di0ZOmNk6FzXxGcKCMq3Fc/HD/sWk99kkEoprQoYIfNwj1cQds5hSS7yBSS+MI5nK0AUSg3zJTQNNsyXE=
X-Gm-Message-State: AOJu0YzNIj3NsV+2BYvkuIP3+qKoX/SfoqzccueMA64xgWPIsUA4LXnb
 3KBXUCbySWOHOW0Ad3Qwk6sMrdNmkOdNWzo6i7d/VdGBP8oTMDcsB2LJBQgX/oBPJ8fY0EIC4XM
 q1u4=
X-Google-Smtp-Source: AGHT+IGrkEIqWV2RzV9qcXIswKQOiahnB78NqdDE7CIXJHe99a7Ru1V3w80n3VDWp5GhoHFPoURO9w==
X-Received: by 2002:a17:902:7795:b0:1fd:6e83:ade7 with SMTP id
 d9443c01a7336-1ff0483293fmr97233295ad.22.1722291716026; 
 Mon, 29 Jul 2024 15:21:56 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7c7fda4sm88083335ad.22.2024.07.29.15.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 15:21:55 -0700 (PDT)
Message-ID: <9b502cc8-a0b3-46c7-b4ae-815ded4478d3@linaro.org>
Date: Tue, 30 Jul 2024 08:21:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] gitlab: record installed packages in /packages.txt
 in containers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240729144414.830369-1-alex.bennee@linaro.org>
 <20240729144414.830369-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729144414.830369-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1132.google.com
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

On 7/30/24 00:44, Alex Bennée wrote:
> From: Daniel P. Berrangé<berrange@redhat.com>
> 
> The lcitool created containers save the full distro package list
> details into /packages.txt. The idea is that build jobs will 'cat'
> this file, so that the build log has a record of what packages
> were used. This is important info, because when it comes to debug
> failures, the original container is often lost.
> 
> This extends the manually written dockerfiles to also create the
> /packages.txt file.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> Message-Id:<20240724095505.33544-2-berrange@redhat.com>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/debian-all-test-cross.docker    | 3 ++-
>   tests/docker/dockerfiles/debian-hexagon-cross.docker     | 3 ++-
>   tests/docker/dockerfiles/debian-legacy-test-cross.docker | 3 ++-
>   tests/docker/dockerfiles/debian-loongarch-cross.docker   | 3 ++-
>   tests/docker/dockerfiles/debian-tricore-cross.docker     | 3 ++-
>   tests/docker/dockerfiles/debian-xtensa-cross.docker      | 3 ++-
>   6 files changed, 12 insertions(+), 6 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

