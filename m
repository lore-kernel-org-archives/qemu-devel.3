Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F157DC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 18:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPnMN-0007Px-00; Fri, 05 Jul 2024 14:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPnMJ-0007Nt-Hd
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:08:35 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPnMH-0003gD-Db
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:08:35 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c9a10728abso1123375a91.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720202912; x=1720807712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t5zezrf1sHAVVchOpUooyJ569Xl2SupUDV2Cs1wrhg8=;
 b=xwD0zrzEOB8/FG8P73DwlvNdrT6ODezZh7EZsDEhxjqpQkVAWDCidl6dO2TIvhCBow
 +A+vbF3EaQ7lp9OtPC3lrWNegrGf38+hHMWsDCd3vbtG2XEtJxzcFPXK/TJcbqHLvRiC
 Hoc1cJpPKW8o4w7tk8GS59FLkAQ1xBQmjhH0lJhOFmBLlCmsD7DKQt0S3MKftZjH+7cJ
 TeJz3POyiktSlyFOmxxt0q/W6hx0WGvV/ReDHZFHHVP9XZpIWzJOA49jsmeLqWa7M7xR
 v8DlHyhj4NBAZChBfAI99F4Xw+LKyRzhoVMEzM7hNoU96n0U5K1OhqjOrcGwC9E1ISSx
 SYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720202912; x=1720807712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t5zezrf1sHAVVchOpUooyJ569Xl2SupUDV2Cs1wrhg8=;
 b=NguvpCHdCCL/dMetJU8aFgFy66CT/oby59IGITwoEU0OT4ZtoS65nn3oFUwoTDprrQ
 TMbcpSQA5WEmAM7oK+XBt4dOsthA4ncKtbQrlKVDTx1w8ojj7anOILGeMkOFp4a9JvQQ
 Tr+kwzGa8xImQcp+d5RYHqTMWYK61Mhct6BP3Ts0tTkHzzdOMgNnnTGflfSsEUP4tXpm
 AKMNz0R6wGOCrWXOtOG3FagBwjes8OSrdplLWFbLs67InxmfjbDk64JDt94n//XdI/aS
 zecQtXEjZk59fLmQstIh/a4EzZmBNO2uqVSoovIkMLO/lUSjnSFNJY4rlLdp4VKBFmvg
 rqHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7VaM+/B70r+9X+KEZPgJbo5UKyjE1zvyQ2qztOACMJukcF6qJ1cuRh7J7By1Tqg5IXFidjUMBzJp3M7gPyd6BLG3DSb4=
X-Gm-Message-State: AOJu0Yw6KKhtXt9qwXi9CND2TvT4XyS2iRY3wB1YuIk+iVE60bxFSI24
 xNRF+63hzJsCJiHbqMXg24qWj39l7JyUUHPQQo6dHyH6DZZxiWdt0xmzRmXgYrDeeQ1V3dcjwkJ
 r
X-Google-Smtp-Source: AGHT+IHWOcj9BTLe4KZKp5eRffOTneWD6cd9a5WqcWgU3jpcQoawazrIfcXmJtYCguwT1+vwcJnzWQ==
X-Received: by 2002:a17:90a:db09:b0:2c8:ea7b:8891 with SMTP id
 98e67ed59e1d1-2c99c6bdfcfmr4062879a91.29.1720202911524; 
 Fri, 05 Jul 2024 11:08:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99aa895ecsm3670283a91.47.2024.07.05.11.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 11:08:31 -0700 (PDT)
Message-ID: <625fbd21-31be-4d88-9249-ddcf0fb91c7c@linaro.org>
Date: Fri, 5 Jul 2024 11:08:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/40] maintainer updates for testing, plugins and gdbstub
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 7/5/24 08:30, Alex Bennée wrote:
> The following changes since commit 5915139aba1646220630596de30c673528e047c9:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2024-07-04 09:16:07 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git  tags/pull-maintainer-july24-050724-1
> 
> for you to fetch changes up to 340ca46b681b1e9cac1643a7fd964947aeb68a56:
> 
>    tests/tcg/aarch64: Add MTE gdbstub tests (2024-07-05 12:35:36 +0100)
> 
> ----------------------------------------------------------------
> Updates for testing, plugins, gdbstub
> 
>    - restore some 32 bit host builds and testing
>    - move some physmem tracepoint definitions
>    - use --userns keep-id for podman builds
>    - cleanup check-tcg compiler flag checking for Arm
>    - fix some casting in fcvt test
>    - tweak check-tcg inline asm for clang
>    - suppress some invalid clang warnings
>    - disable KVM for the TCI builds
>    - improve the insn tracking plugin
>    - cleanups to the lockstep plugin
>    - free plugin data on cpu finalise
>    - assert cpu->index assigned
>    - move qemu_plugin_vcpu_init__async into plugin code
>    - add support for dynamic gdb command tables
>    - allow targets to extend gdb capabilities
>    - enable user-mode MTE support

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


