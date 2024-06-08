Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DD6C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 20:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG2Tq-00067X-2u; Sat, 08 Jun 2024 16:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2Tn-00066m-As
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:15:59 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2Tl-0005oA-UM
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:15:59 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3c9cc66c649so1685961b6e.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717877756; x=1718482556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KbA3wvPc4Ecsl3vxYNNpDkQdxutDfv/yDxeR3MXD+Ag=;
 b=FD5EOFPWQvuVas+mRo5W3Af1BQEB79kdHTs3pgh1ykF8Ey0IUtWZoM+ituO5tAnNlf
 Hmm9wsZ+7ZIt89pfOCV5ZTllmd85iM6AildXBU5K4rWvjY/6PIS6E46Q0Gb7pHSGaE1p
 f5jgvIdE+WtxXqMRIfdMgnuF0muwqmDJtpLxOBdhmKVnKhf72K4WV0LaYRDraaz8a0n6
 MboIEneiqpev82oy7T+K1vzMAB6m+eIwjKA5kinYPN3lD1CUeip9+ikyEJF0I13FHwLs
 aBTeoe6Wt8GYDClNKSJnx5IxleBEy5pzzvlbuc2w8f1TMwq3TNoJlvdtaNEz3I8OA09d
 f/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717877756; x=1718482556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KbA3wvPc4Ecsl3vxYNNpDkQdxutDfv/yDxeR3MXD+Ag=;
 b=gSKeWgg7AjcKnp7IK06xuX/s5qDc2QC0muMmDJL1c9JHagtwHV2boLMvThM4Pzh/eL
 /JIiEiKNt3/DxitIFdJL9YQTAkksWVZ+FbxtBYkdxPPnMt6TpBlWdEtjoRertKWg1eQu
 ZEhauOLlI/CATV5O9m65IJ2QhG286wAanyTgiQlXJPS36pnqtdoe9KMboAkyBsU95RkO
 jKzw6EGGOHOTd/1cIzLstSZmEljaVNIBCWBEbgmFOazCbjMNkBZ77Z3+OWyQgsBfatuF
 qWKSZU12k9YD6ZM4waMSa+2CJ1EXjG1B5tfitkmfbhEr8qGf9lc8z8q5BHk5Qorofp7k
 gcFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpz95ABie7SOMHZtwBaiYi9D/m0M1FgL3EfNN3V4nTzJvvdmQJOglGH0FyZ9Czdv/iMGn0xEWz5KTw6O15jZUxB3+28kY=
X-Gm-Message-State: AOJu0Yxmn8xkLzrGow96TgCksmxeAlWm60EEKhfCu5zNuXl9za2ifRzG
 p1nWY5dPNwZMT4ciPgMuN9zv/vwVRc4VijVNEWPEuisxxJdndtLcJ5YvSNysQfIvc3Geieyn7eC
 x
X-Google-Smtp-Source: AGHT+IEHb5T02pjoXB5U4l02izNUip1Yk59HUFtiXq+T0JLssd47SiLCQnJO9M3S6ycoShLg7jv4sQ==
X-Received: by 2002:a05:6808:302:b0:3d1:ff8e:a5b6 with SMTP id
 5614622812f47-3d210d6fc5amr5609347b6e.15.1717877756420; 
 Sat, 08 Jun 2024 13:15:56 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-704218a7607sm1684383b3a.130.2024.06.08.13.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 13:15:56 -0700 (PDT)
Message-ID: <a77556c5-16c7-4676-8356-df1b2adf49ac@linaro.org>
Date: Sat, 8 Jun 2024 13:15:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/25] target/i386: do not check PREFIX_LOCK in old-style
 decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-25-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-25-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 6/8/24 01:41, Paolo Bonzini wrote:
> It is already checked before getting there.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 26 ++++++++------------------
>   1 file changed, 8 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

