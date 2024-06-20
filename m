Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B2FC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJqA-0007tn-J6; Thu, 20 Jun 2024 11:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKJq6-0007so-Mj
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:36:42 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKJq3-0002Ut-4A
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:36:41 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-364b2f92388so710537f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718897796; x=1719502596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kBelHbT28/Diop473YxP3LQrHyerXnAYSm6Ciyy6cC8=;
 b=mrxQ5iAEIzT6YXW2dXGehpqC9ls3B4yD+pZHFI93KKBMt9FFPW4XEWsC3J1HfGodCE
 s6GG1iQ209HiN7FrlBdgBxTa5TyHEhdp3Jlann90YuGJP0lJd6BRdnR8HWsMthITf66v
 OV0aBFWG2UJT6n3xGVRmPzMqQC7Im3s2i1pJ2S432zCpAyJ8Q8RNYqCp/4i+0mUD2K5K
 g57/3hNj7UL6g+2rQoVQmqMq4O4DO9e4lLH95TVHPKy7V+Zkt+ppxjCVcL9OyXTteHcF
 ZbtQ+mEGSIQZL3IcckjW2xOVuKdZJjjnvbw01KIfKdmv23Zej7zXjalGYkRoYes5j1DO
 j6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718897796; x=1719502596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kBelHbT28/Diop473YxP3LQrHyerXnAYSm6Ciyy6cC8=;
 b=Svh7tMOBb495mX9pYtgLt2g3Gcxu4X5BxyoyuJdvBfEKa03VNpgjs8DDPPwGsZSfAB
 FKw67H+goOsc1DSoVw/nRg4643dHx/9Hw5ozvdhXG9W4hdPLIyObsXiWiA4/idVZ/KfS
 Ydpm8Kt7Fj+PANvbSOQNY3KUW67dyqMxsNBJkxOMiDJpk9YEvfbijDn/p6oXqu1GNvd1
 0b8f8B2jNgQeGJpdVnRXPJEIQ0gEyScToJQKgcYqfuUGXvTRsp8t7lSLhY4JXA91r+2/
 /3g2neY9NQ9Kqg3YB2WIlx8MvUlOABFqqDxJbQSGN7sCvS31GPW1q+5e3S8uQqklfX6U
 Ra+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpzJ3OgKVJZiOi+cMnpgYZW6aemEV+7yY19UM88MZRsCytuqe1VqhA3GmkyrO96+US5d0Qbw9yJFUWv1GxmlrxqXrSK7Q=
X-Gm-Message-State: AOJu0YzZPAMD8jQsJgb0OsLQdXbyi+bbe1kbKtuELFOcZd7dlbxluXyh
 5QDk7CJUeZVggfUscm2QYuvOv/gxvNuCZuu20rG6fM/2ZeqOEJZyf0qC/D1sOto=
X-Google-Smtp-Source: AGHT+IESuhZFJcdm5hes+a066GEweTu8SnfStPf1hkxE4lrjoWZg84KFkN5dQa5LfuOSsL3U9/ThLA==
X-Received: by 2002:adf:edd1:0:b0:35f:b03:bf45 with SMTP id
 ffacd0b85a97d-363175b92f4mr4438519f8f.24.1718897796372; 
 Thu, 20 Jun 2024 08:36:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.40])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-365a20d9b13sm551183f8f.85.2024.06.20.08.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 08:36:35 -0700 (PDT)
Message-ID: <37f2ce0f-b4a8-44dc-bc94-e706eeab6663@linaro.org>
Date: Thu, 20 Jun 2024 17:36:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] accel/tcg: Avoid unnecessary call overhead from
 qemu_plugin_vcpu_mem_cb
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jamie Iles <quic_jiles@quicinc.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Nicholas Piggin <npiggin@gmail.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Max Chou <max.chou@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20240620152220.2192768-1-alex.bennee@linaro.org>
 <20240620152220.2192768-13-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620152220.2192768-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 20/6/24 17:22, Alex Bennée wrote:
> From: Max Chou <max.chou@sifive.com>
> 
> If there are not any QEMU plugin memory callback functions, checking
> before calling the qemu_plugin_vcpu_mem_cb function can reduce the
> function call overhead.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Message-Id: <20240613175122.1299212-2-max.chou@sifive.com>
> ---
>   accel/tcg/ldst_common.c.inc | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


