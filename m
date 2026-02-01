Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76693E6529E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgbc-0001Fj-0N; Sun, 01 Feb 2026 18:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgba-0001CX-4C
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:11:46 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgbY-0007UM-L8
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:11:45 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4806f9e61f9so18411975e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769987503; x=1770592303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9+af2AYfBOaayRMRjFnKyM/rQuJd1PVpNgpOLykWVI4=;
 b=ul6RG96O7uHRYjhcBN5ZwPsDugsBZCweVwDMyXiyrfKRJ5ns9Bj8mnsNqlFIhgCf8Q
 JBgT/ETsF7fmwzPfivlD74cqUJFkZxJd53FgwrXJpEwmFL04I0Fvw8SWHfmGuxiyZs44
 2LML7JBq+pO3AgJ/pVKGPy5xQfeBWLG7knbmUmT59LlBjMNfXT1P1Bbrg41uExzkBtC7
 E1d/YpJM2GuSoL34HUuYekMvq2cBmiJvFKKwXIxQzqTUk56a1mk93MirFtEWl+l9g+sN
 M0UZcmXbejaId+Q+0wu+KJ97+y8yHcBDKBUOrbEIhnYrtJN/jVGkyCD225jSi7MQmTqB
 18Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769987503; x=1770592303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9+af2AYfBOaayRMRjFnKyM/rQuJd1PVpNgpOLykWVI4=;
 b=M3DnYgnIKgrKDv3ivSZgWitPXsht8zmiotFsY+mv2Wzh1Vd//cM1BScgNnhX8oXWld
 mV2wPxgJRrnCr8lEwK7DoajIn02J7QjBz/2aR4sDStZ1ghNhMH/6+KkPmwaVGXpxPsif
 7rYc3PvDsbhaQ+m6iyV3X8r/2YiKNrEODQMMnzP4DNHC27My3FKGMn8wuapzuiAjT7GP
 z3TDTXjrzrGhQorIWBKG2PcCE2tjjka/NLi2CV1EoXWCaiNJPU2yMJO4bqxaTQ93Ce2D
 8SfaaZnxEQFRxJZjLJa84BO1eNrC8n8h1qdDVKsZSCx9J6y+6itht5bDWou7A5AeAMpF
 a6Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1+6fCrewgsy1bDII+jU8bqolp4N+gF5W4dMMKFgoen4A1g9acky04wc1Fxfv7q+sFsLPM5pvaAyJt@nongnu.org
X-Gm-Message-State: AOJu0YwWre9Vx2XaTGnIY+nMr+0ofpG9rkPB1g1XiSahepCBg6PBtmdW
 kIcuti6QqAI+VTlpF26rfWHBA0wpOJbfwPJ/cz88LTkTczaZpwycHXhNRRCIo1F5Lxc=
X-Gm-Gg: AZuq6aJpQ3fSPKknnOcXQEFfxlIiyKLqxI1sSD17QoFoQcJmCpREnAXcGiCifFqTAKG
 QCslLFueCpAclDLrf0Z6wD7mFXdopG/RKFEmLUe8K7CxPgzkNIQ+Q3sUscNABfC/X7515GHVnZq
 VfaMehsU0kVMInnHHRR0YmxDB6znS1fCxKpf8MxsfE7M2JrjZSktQd81eE0i/BH0EvkonHo4u7D
 zpj2txfmkZYdN0HIL1Oq9RT/aCdCe2sbyJNPHrVsKBnGbgfLcaKsQfmc5luWb+1G64bnMrwWCeb
 F3aufmT9Mmob9ZDHWS9x0qXFKsQOQVTbfmCZCH58fvshl4qT2dmZW+e/KycR/tymeDA+TFL0gus
 sLWBA9ag4Jg3ZJudrHws9iqmEOtUrOmrhR9vEVVpaRF42lQwdqYAqRPN3yE3spzNJKGhUVQQKmj
 kjDKkElsvnIhxzmKD4xwHz1WqcryZyDEgG7qfIHlSIKlb1N9/yjMNjfw==
X-Received: by 2002:a05:600c:8b65:b0:47e:e61d:b8d2 with SMTP id
 5b1f17b1804b1-482db486ee9mr133909915e9.27.1769987502911; 
 Sun, 01 Feb 2026 15:11:42 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bee687sm629472255e9.5.2026.02.01.15.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 15:11:42 -0800 (PST)
Message-ID: <fe229361-765f-49f3-9c48-f44b76e3eec2@linaro.org>
Date: Mon, 2 Feb 2026 00:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw/virtio/virtio-qmp: make compilation unit common
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-6-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260131020100.1115203-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 31/1/26 03:00, Pierrick Bouvier wrote:
> All compile time conditionals have no impact at runtime, since they are
> representing only possible features for devices present at runtime.
> 
> In case they are not present, associated features table will never be
> used. In case they are present but some features are not, matching bits
> will never be enabled, so those entries will be unused.
> 
> Thus, simply expose everything and call it a day.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/virtio/virtio-qmp.c | 70 ------------------------------------------
>   hw/virtio/meson.build  |  2 +-
>   2 files changed, 1 insertion(+), 71 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

