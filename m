Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBC9C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 21:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siguz-000461-Nj; Mon, 26 Aug 2024 17:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1siguv-00044v-Mj
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 17:06:25 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sigut-0003eN-VY
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 17:06:25 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71433096e89so4056989b3a.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 14:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724706382; x=1725311182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Zm2+q44/Px+3oIsNsyINxSDAfUi1A0GOLi55frXrmM=;
 b=jVTuAl0TvjAajskBJ/7qL/f60T4Wk86bVqMQ06ahU5JzdrRqM6i9iTYW4Sqn1KJb5H
 QkoptMY8ZwYva284GuOmVbijG/ogMD6wXOgVsDLxZguG7sxoOAiYIWSeptb+eHaYFCGz
 fgvhNI+WRhlaCcuTC/v0VwjmMYReEAEgi6BNOVJcBM4OX+SelBprV5dvPgvva7PIqEoq
 3nGMyXEsS+AghC8OrT1Nf22VubcTc0eGzcZCD6brfLidHpc4JZn+Wm4VtzMzBs0LvvS6
 I/rUPwkr80ipsUqhVsEVaDF5BlzBVmCsnORfNoGueG+5hwGEZW9LRTGUxaACekkYtTPg
 rDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724706382; x=1725311182;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Zm2+q44/Px+3oIsNsyINxSDAfUi1A0GOLi55frXrmM=;
 b=qzDrktMNvJ9/unMcuA5paVRp6F6vcNNgSu5dO2ZSrHvgroeJt/p3waEN2wKEj2ajwW
 VKaZyfdqt322BZAdA4p4Ep5+DnWiLniuj43jKY5QxPhnUQT4eLyP7jA+tkHEOJ9f116k
 +mY6xfKNE/pPhyU7hrwBOklX1iAfPMQPE06IeA92MMv81H5IsdEBRHzkh1Zwsac3pf/0
 Im1NAuQSj5zjIvy9aglsj9e12VkuTksaaTwhsDxudE7GHBiG+LKS03z0RAM3DFCSjs/F
 VOyv6pNpkPCrMXQaxx7AOxdQ+72/drWGhhcLHlrvjNgxcXozesvdT2WN451ZfMk7O57G
 FjBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgxaxJL8RRlC5bb2UiLleZq7cDEY7Sq65kL6AwjWQWEk1Y3951gMluLaSNDhIy6dPtIYKeXdG5qJyu@nongnu.org
X-Gm-Message-State: AOJu0YyC7f8PYFea8yFJ4ZGF716yvc2sFKncpGUxtlz+fbKSP+1OYkMa
 qxtJvNjIiBCeE9sLycpXKBosJxm/i25qDMMlukqg3qs+bBuwqyNHHts6dGq8RN8=
X-Google-Smtp-Source: AGHT+IF4+IBEiro8oXohhNbApOI+LiJfljc/YPQwAzeAcq41zM+arSs56qd5Z1G+b9WpTbNoDUNO/Q==
X-Received: by 2002:a05:6a20:9488:b0:1cc:c202:b289 with SMTP id
 adf61e73a8af0-1ccc202b35fmr708105637.0.1724706381454; 
 Mon, 26 Aug 2024 14:06:21 -0700 (PDT)
Received: from [192.168.98.227] ([1.145.75.248])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d613a420cdsm10339930a91.28.2024.08.26.14.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 14:06:21 -0700 (PDT)
Message-ID: <beddf021-3731-4a2b-aa35-a08e717ea7b4@linaro.org>
Date: Tue, 27 Aug 2024 07:06:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] Optional fixes for 9.1.0-rc4
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240826094330.276592-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240826094330.276592-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/26/24 19:43, Thomas Huth wrote:
>   Hi Richard,
> 
> since it seems like we're going to have RC4, here are some minor
> fixes that could still be included.
> 
> The following changes since commit f259e4cb8a8b4ef5463326fc214a7d8d7703d5de:
> 
>    Merge tag 'pull-trivial-patches' ofhttps://gitlab.com/mjt0k/qemu into staging (2024-08-24 08:09:27 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-08-26
> 
> for you to fetch changes up to aee07f2563d27167935ae3557a9f435937eb3f9f:
> 
>    tests/qtest: Delete previous boot file (2024-08-26 10:58:11 +0200)
> 
> ----------------------------------------------------------------
> * Disable the broken qtests in the MSYS2 CI job
> * Replace deprecated keyword in the Cirrus-CI scripts
> * Fix a simple leak in the migration-test qtest


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

