Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79947CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 07:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBqz-0002sl-8E; Fri, 24 Oct 2025 03:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCBqx-0002sG-IO
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:04:47 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCBqv-0007X0-EO
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:04:47 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4270a3464bcso1251209f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 00:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761289483; x=1761894283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cz/YscZ8sVZFu4ytxHS+AYKtg+NBUWy+A3KdiVTcnIo=;
 b=Rf1khyibyKzy8rGdDZubkCrh76ldJeBA1oZ1gkpRWhUhHMrBzLC6SbbqvJ1NmQ/Tfx
 tvhZ7bpBzQNMoCucCPnEwjpDZY/Mi3Yz4Cp101UdEJbJklhKAO2uknkIDYAtTQOSgC9V
 HGZZM6CpImcsgRZRch4V3sSxLtB0V7NOB2c+fdcHEe5OxOqkuP4h4Fgu1//XCeZEQO2D
 mdoi6hmmCGu3Kj44W+UDf5klLqe34q4iVkxjpA9nMbDWsJdcGrZgDElS0+vYIacRX9Wl
 +bbT/r/oF7Xj3fo+45qp5gra43+hf6VKkrPBDUasTq6GQzY8LAqPxIdO9Uzo+eSMKXgw
 EKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761289483; x=1761894283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cz/YscZ8sVZFu4ytxHS+AYKtg+NBUWy+A3KdiVTcnIo=;
 b=ClLKP1Wtvu6BpWTNPVL1MELCnKq0VIlGi1RK8X314Sl2IMN1ZIKiD1S6YFHSJuiGE5
 3zdtXxYsgLP6S5sU+byAXMWDE2tTinjh9SltOfH95xIr5+vMnuJ0mqIu91wWpKOPh963
 W7OquiR8umstu6TUXrTm24yjY950qbserEQKpo6UrFB9VGiHvyvhNFLQc5xGLR9EEmz7
 oIqy5LmMbN+Mn/W52i5bevvuqoi+bSLneQYlmogWA3sxy9pGLPZvSCX/tYmr3kE13qOn
 bAauOW3AJUw0cE2YLh3WJpGOcfNn7+3h4hZTjTq59dW8Oxj7EES0QtHl6Ao+LNQyoNy2
 ckZg==
X-Gm-Message-State: AOJu0Yyg+nZ2K0eNhA0rhlybOeuTm3ohMWqSWVXxsP1Oqb9wj79R5Y6Q
 KW4y/YELiDuJ3NMvQ0y6/bOFUSt6LGTlYZ76Hsgot20TsuYtGboCL5noElX82Ad5Qt4=
X-Gm-Gg: ASbGnctqc10plZ8Gd8Vsb17QCLszL/2i1oPJHdJZcTI+BPOlxAuVKjSwTXxN6sK2qsq
 l1etSLZcv7c1+4i7hWJ2o975cPsbpqX2fHE+2mAns+PYoNVhuiKlZU+/UngVFU6iWfIT7syPJv+
 Tzfg/xGfL+koTCA0uT3Ip/v1u36Zrl2zK5Wfgbs+ycdobOuR8LXQRHo93yKktZzJCzhFcCUVCcj
 8dyCcIr54qj636u0ST8Ner+RiUTQuuDT5Atjv3oNOcRgL+3RqRiPwzyrhxfwFC9FZg/iHfBAjW3
 7WTDx9BQOz69U5Lt16TEex27Pt1USZZSCgIZMNC6lkWyLjJ4SpuKFZSQmoN3Fd+VVqe16RnZrJT
 OZmrBz/4UpTNYnPa1AjYzHV39ZF2kZiy9XIzooXqMU9c5cK+9FE1vDPiz+KDchMJX9XzqEJizxI
 eSnnJnOvVnuRyC2xfg67ejn9E3XllY2dm66U9yMhC0rhgp6T2ptC4ucuNNiAfXPMg9
X-Google-Smtp-Source: AGHT+IHfl5tFmUnk2F2ZLT2s30YXzku6qdrTo3Y/xDUhU7+GfilRTAw+BEltjEJGBWoB+u8/pQ9esg==
X-Received: by 2002:a05:6000:2c13:b0:428:3bf5:b3bf with SMTP id
 ffacd0b85a97d-4283bf5b5a9mr13887252f8f.43.1761289483341; 
 Fri, 24 Oct 2025 00:04:43 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898ccc60sm7886911f8f.34.2025.10.24.00.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 00:04:42 -0700 (PDT)
Message-ID: <961a8b24-0f7c-4ddd-a6e2-1f558ddfa304@linaro.org>
Date: Fri, 24 Oct 2025 09:04:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/ppc: Remove the unusable e200 CPUs
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20251024065726.738005-1-thuth@redhat.com>
 <20251024065726.738005-3-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251024065726.738005-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 24/10/25 08:57, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> There is currently no machine in QEMU (except the "none" machine)
> that can be run with with one of the e200 ppc CPUs - all machines
> either complain about an invalid CPU type or crash QEMU immediately.
> 
> Looking at the history of this CPU type, it seems like it has never
> been used in QEMU and only implemented as a placeholder (see e.g. the
> comment about unimplemented instructions in the POWERPC_FAMILY(e200)
> section of cpu_init.c). Being completely unused and unusable since
> such a long time, let's just remove it now (without deprecation phase,
> since there were no users of this dead code anyway).
> 
> Note: The init_excp_e200() is used by the e500 CPUs, too, so we
> rename this function to init_excp_e500() instead of removing it.
> 
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/ppc/cpu-models.h |   4 --
>   target/ppc/cpu-models.c |   5 --
>   target/ppc/cpu_init.c   | 147 +---------------------------------------
>   3 files changed, 2 insertions(+), 154 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


