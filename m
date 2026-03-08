Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588F3EA852A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 15:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzG4w-0004JV-Aw; Sun, 08 Mar 2026 11:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzG4o-0004Ia-Ps
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 11:29:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzG4n-0005ro-9T
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 11:29:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso118066985e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 08:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772983792; x=1773588592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xfB2u8eoG1ydvVGb8ZGozC/G0yzDcUpwoYNq228hqJo=;
 b=izAEj/XX3oDwypk6dlx1kalJfWqRMsc5TwwRB9HpWLuvZtn40iLDDzIZCv6+gVB9WS
 /GNgzc8wA+k9Dw19IbzXbahzkMDV6f0Qv17kD1hbH64lYsrkgt2rz++P/tMSShD/WZpp
 Lfwkp2Zw92o99GHFarwlqvsCDLYnZWrJ9tf7ETGScMTzetWiniJ4PJnbeRv+lrmizHVE
 iukhwIH2JSd4opaQLV46OcTuhY140FFE03I45VDHfPV2+zGOoYGE6tjaQOqVL9lDgSNB
 p22imrWh6TB65FZCxLbQFzPI89+AGmMkD6i4Tajz/rfsmKBWtwPFhug+U8gn/rZOEOAg
 MrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772983792; x=1773588592;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xfB2u8eoG1ydvVGb8ZGozC/G0yzDcUpwoYNq228hqJo=;
 b=k2Qa5/X3ANgJdBak3IxKtJ8Z1l67J6QOROyJdi80IcdV+GwIEl7tmVWewGICtmbqu1
 iRfGBfEthnNwh2+DXahZG4L9+g2wZIy/4rU9mFEzt2uiFGYoVtrybG3lM1my9OrUREiW
 1b5uX4EMOj+QF+elnhuduurO4aEQyTMZ6ObOnKUVJr0v1A/rlqyqK0A1NPYrCp9zaLiX
 ilTbuNieucEhObP6565GWtHs8fvlJm477738r1kB53l42pYQDDc6YrlQAuU/O8gfFB7d
 LURtSTSfRPWb0tHthCtSnNCx+lXxRujll5lvMqOQMlFzpw4UCn20orB+LIK+h+AdGuBl
 8oqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOI+PbxHm8r7vsYyC7RCXbkhC6aFS7TLw1b3/zfLV4ThXf1VJ0XMfDcNv7IV1N6bCdlQnAnNAOJqDR@nongnu.org
X-Gm-Message-State: AOJu0YyhixWZNlVvtlT3LmjN+VQ8bIlIPRPPKoN3VSbl4bOcJZxMezzP
 sEpdKd84zH2JfO78Zx6iXPXC8j+sPER56cAk75Ud+uXS5LrJdEg6lPOZWjiD/OLXG20=
X-Gm-Gg: ATEYQzxxw9fvCPDWPLkgUM+lVrHGjYybHjTry6z2Br35ybgR1IfWKx4rI4fHPfUOgj6
 M4MJCYMNmlB69FK7zW8mkRPpKgQC3gpPlxoGLZ68wwO5cuVqi9f/ncLT8Sp5IPgQjhVdUzwOjtL
 neVfR9kbSQgj9DYD1VlaRpyWFLYb3WSXhkOFuIAvVkIWBm57lbjWUR+T+5mO9Qgp0lNQ0uvlu0H
 nxliJVHK7LuQ6cGgc7J4gj7eTJxAKRw2Oi28n6GWMrGyCuXWx+VTqi0OvhqzLL8ptA7ZVkA2gy/
 YVMXyEQFOiPWPWn2RvVf/vl7RNUn4c96sJo+icya6QSSTOqCYN6yEd2sDDKl4QGLAGhYTbbGlSy
 eolQSNysRx/+hy1snbgRMh3bOZLJrBYMVhmMmbUH0DPUxOYY8tdkG1b5AHS+yoRSD+GecN8Uf1+
 obczUK3g8l4FdtbVVz17s3wn1NTGssSisOeVekwr9RgNfEEiY3NH/o82gsnXA7vUPhKA==
X-Received: by 2002:a05:600c:b93:b0:483:badb:618e with SMTP id
 5b1f17b1804b1-48526923941mr138173785e9.8.1772983791590; 
 Sun, 08 Mar 2026 08:29:51 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48535863e40sm72248015e9.14.2026.03.08.08.29.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 08:29:51 -0700 (PDT)
Message-ID: <31c5f7d4-6adc-400d-87fa-d1e784d6baca@linaro.org>
Date: Sun, 8 Mar 2026 16:29:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 05/13] hw/arm, target/arm: nested virtualisation on HVF
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20260307180330.75168-1-mohamed@unpredictable.fr>
 <20260307180330.75168-6-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260307180330.75168-6-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 7/3/26 19:03, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/hvf/hvf-all.c    |  5 +++++
>   accel/stubs/hvf-stub.c | 10 ++++++++++
>   hw/arm/virt.c          |  5 +++++
>   include/system/hvf.h   |  5 +++++
>   target/arm/hvf/hvf.c   | 42 ++++++++++++++++++++++++++++++++++++++++--
>   5 files changed, 65 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

