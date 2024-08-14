Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8442BC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 02:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se48u-0003Na-EV; Tue, 13 Aug 2024 22:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se48s-0003N5-TT
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 22:53:42 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se48q-0004GO-R3
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 22:53:42 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2cb81c0ecb4so343621a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 19:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723604019; x=1724208819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Js+71lSMb+UgCw75FcHPAWtIQ6M9BFEoBFtIsjGF0Po=;
 b=rorcf5wECYpahrGepIZ5n75kRS+Sfbl4y7ibJ+PT6VVpE5V5SGMdTNHI4L5Wh/YOXy
 L/x3DVmDTEH8PSDk6agTIgFFl95r+9iZ99VxTSrwC/u1/RyZdbCnnDQ11Qe/pqwfc8lG
 zidhoVVzhfQPLG88NsKWYqfa7N3lkv9TtzfFHNPUG2YTULvLxL0jNPNz6WWvQ/NF6Kwo
 oRZ96uK6Vwz1Sg+dI63x/JZNiQeG9GZ+d27nqS5PA4qOwdIx0zb8EWfdqdL91eMYxr0Z
 oseHbtlsXD+m3uumfKgfS2yXZXMEOhHC18wFqU0gGQqi7d9qKI014USvy2O1hCGKv+an
 8A3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723604019; x=1724208819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Js+71lSMb+UgCw75FcHPAWtIQ6M9BFEoBFtIsjGF0Po=;
 b=XeJ/Kz6Lyy50yWwpVLs0pj2+VGbnhw8pQa245eV4EVY10NT3mZR17PFR72GoJ8fudD
 E9YrLOzSvH3EUPobZCJFst2xp09TQSe8gmJvtxZ/98QzUuarxdN12GrhqJOh40jN8hDR
 Hi9gH21vsCZEBDQQNH5R4K1OgaF7htO9ElwPt/eyo45yw99gMPrvTYIru8O64dPsBlDl
 1xFng2hVIE4flijChzpYbCARcVYBTEpb0OSbgk33YXdLZJFBxgOpJHzgyHRPeQm6ZRFm
 156hLN9hR1978nDPofiRlo+wqoMk3MXS0ajoPOrNrghUwOEYST0Rt47BpFpk6PKNDP69
 HlGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmzKuZkEXWY7YvK+nZs6aH9zcLmV389zTgLj0sDIi0JlXFWZxy/6kZnJ8Lamv5MudmExgpMUi6oFx0atF+k8NbTxol7RY=
X-Gm-Message-State: AOJu0YxgwnMal2/faSPNSJLs6aAVNuaU3g+jGW5xGMqJ4prx2FoIqP96
 10qqL8kuQ5gmzSuqKxo1DeWAy/3QFrYhPjDiPTTzsXPDal7i0EnNZRwc2Y+JBSlixoRFHu23TWp
 JGzU=
X-Google-Smtp-Source: AGHT+IG426BvgXMlZcxd8vX/IZIKoV+2JP8Q/cGLkecjtBgvfBYsR6F1WLt7X4HaHkX17N+RUyha6A==
X-Received: by 2002:a17:90a:c714:b0:2d3:ad41:4d7a with SMTP id
 98e67ed59e1d1-2d3ad415253mr900759a91.4.1723604019050; 
 Tue, 13 Aug 2024 19:53:39 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca30bsm359299a91.7.2024.08.13.19.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 19:53:38 -0700 (PDT)
Message-ID: <ea5771f1-6422-4177-b949-d5f97c35abea@linaro.org>
Date: Wed, 14 Aug 2024 12:53:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for-9.1 0/6] Miscellaneous fixes for QEMU 9.1-rc
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240813170556.104193-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813170556.104193-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 8/14/24 03:05, Paolo Bonzini wrote:
> The following changes since commit 9eb51530c12ae645b91e308d16196c68563ea883:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu into staging (2024-08-13 07:59:32 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 3ef11c991e501768f2fa646e8438f075be1cd2f5:
> 
>    po: update Italian translation (2024-08-13 19:01:42 +0200)
> 
> ----------------------------------------------------------------
> * fix --static compilation of hexagon
> * fix incorrect application of REX to MMX operands
> * fix crash on module load
> * update Italian translation


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

