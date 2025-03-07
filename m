Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5D5C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdSA-00048l-CX; Fri, 07 Mar 2025 14:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdRd-0003ne-HK
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:33:23 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdRc-000732-22
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:33:17 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22359001f1aso57051155ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375994; x=1741980794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u3kjokVzIaezggl6X9BH2jkPw8k9xqIqx0wCQNs0kXA=;
 b=JP7xDEUlgJP5XCvy1XGay4E7DNcSRBhZGfe5pzRYcdugbuC/x5pGIZFA+8Y5mfgqQ1
 /PnPKOfBuwbOA4Ug+4nJbTZHaxugqv7AQVoPOHCrVuUEGfvkFJFQ4XrgTQRQrQljRGYX
 Dd2QsFGsvTuX0dfaK/89tWJPFWnV7lLSPLFThRSXXAIlr9AGu1vevwr2bGewkmGhFmlx
 cgi9mNIeF5bPdqD8XWaWwNYDV+U8/n/WD1X7OSfciCw76t/GphtevpPKTBe8LrS49Qmc
 gFtxteQbdk02SP02f12yvljTjcmUBQW/lFw6GoYSNUjPzYU80sS4z5EJ405wV3xpsV8q
 tMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375994; x=1741980794;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u3kjokVzIaezggl6X9BH2jkPw8k9xqIqx0wCQNs0kXA=;
 b=KdzrJew3Iyrb5Fu1qUMbVr3GOg0uJPA9gVEqlEktKvqnX9+VAUIFFaFBRxJnL3atsb
 c+P8XGOQ4z8Ccx+QniFTtOyrS2yvCch3H6b8fDGOnR8sBToc5sA301yDvBzGQYEs8uWS
 7mdzy7NfNwy9RMYqzvJQ51STbgFOF8Ovegz/w+1pEhg/FameWOeS16BXDvGphgvykIeR
 dAAHx6LxISYApxxoDAZepeGWnj+mTtjJF7Y86U20HqKRhjAnIegijO57wPXe8eYFmSGo
 S4A177J3nnDwRKMsQRpyw/t9SLCALGb47QjgPDe9fH44gj3UVXOm2mA9QitVCsZCAkSm
 8cIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUeJL9oJlh8jF2XX4B3KMjHeYSp/lUFlBqp863n+9PSwam5KRqoq2Hg7N1KL8ZhzaJlcqga8iPSCQR@nongnu.org
X-Gm-Message-State: AOJu0YxqpL9mgQePeYSvUcyJqk+Vo7CUvE0bLtMIQinXLJqkfFW+1E3S
 qT4rl42atBJ77u/kkv+AfXASEKlleEZ+653kZr0huwXeqoRpXj+KUor/H7Dlr9I=
X-Gm-Gg: ASbGncv2KC0vJ814IkyjbbNYWiIhwv+UOX795CrY77+LO1cscilQPXn88tHWrMInmqu
 GJZqCQkRfDp6dba/44Kjd2g07RyksyevRnh4V6/Wb+wStVO3hGPjKx4uOzOmYWvdVg+IS0935K4
 bIJR/uy/bflS49/vfqWKFxZwwMNCMmAObTYaaBOC02/SzGLWEbqipLMBWMPGVqujol9Qo6Dog2D
 LH9OZDAlEjPX7J+w7xvA+CaXRBpjmI3E4rXz0WUYM8LhJQc1LfKdMMv521CnDt/6296fSf8K3f+
 3WqDZ1PljFWtDeDhBR76uV2dLY/35ldHcmv/F8qf4yUJ1vf15AsrfB5GFyMxDaICeu62R18PcTH
 mXzaEBgaf
X-Google-Smtp-Source: AGHT+IEQOLI770TWa27yduqe67P21zhBtRAIhboQgxBkp3Oh+eooU56f4qRJxrvGavqUpSRVsMkxOQ==
X-Received: by 2002:a17:903:40cb:b0:223:6744:bfb9 with SMTP id
 d9443c01a7336-22428ab7691mr82163675ad.41.1741375994492; 
 Fri, 07 Mar 2025 11:33:14 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f8c2sm33992215ad.116.2025.03.07.11.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:33:14 -0800 (PST)
Message-ID: <b294d3cb-e8a8-4811-ae23-f82f6cbb784c@linaro.org>
Date: Fri, 7 Mar 2025 11:33:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] hw/hyperv/balloon: common balloon compilation units
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 manos.pitsidianakis@linaro.org
References: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
 <20250307191003.248950-7-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307191003.248950-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/7/25 11:10, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/hyperv/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

