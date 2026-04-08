Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3422C10F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXxN-0006qK-LM; Wed, 08 Apr 2026 14:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAXx6-0006LZ-Tu
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:48:36 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wALfb-0000N0-PW
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 01:41:45 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-358ed696623so2539376a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 22:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775626902; x=1776231702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dLgFWQqIzhFZMkNgi9lrc8hfI0DMw6Dcno86XH5Qgqs=;
 b=DGF6jnJFPhgmXe91PcetzsikK7X8o5fukPZcROSc252djsWTD8oIQOHN/zSZ046k5E
 +9kuXY3q5fv3owQhLX8BxqjaVFdtGESCbIr37nGNaOkhWyCbf1RYAgUWGTjmv2qpVvjx
 mzAwFQDG3BTb0PIGgJEPRA3LIAgiAFcj30EqHmFO9qm80+PymOeei7h/Cm9pMqHK9a2s
 9wZro3fxDDL65kPTtRnnLPI5dE0V847sp3zmL9DYIjdPVOl8BgldcpZ6ikNdDqP16Ee+
 1IBeQY/hC1r+7ZQHiFVIEulN5tI2MkXMUZs1DBegO9jnai5nzhkUk09ctCI35gY4jUNJ
 w/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775626902; x=1776231702;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dLgFWQqIzhFZMkNgi9lrc8hfI0DMw6Dcno86XH5Qgqs=;
 b=W6AbJt4Lk6OwHaNKqBCe9OlGRHQVmdgxurJVCrarq3lHrCHCy5WerFsIKL/Q2EJwnS
 0IoNrEGT8E6PeqfDcJThOE423IOY42rck9xWH0Wd24Ei6S1FlerB5SkJBCWGBg1qrpXf
 EIVP4/RGwQkEMy9NimU3Z3rVmMdiof6ajrdCyRVCIHazpZqZ3vbVuir5Uso/HNYQgNrb
 ceN2t7mU2++iBp69MdHm04YYw3pJoYcrxe5w2pXKyvyOJiejXDaB8MT5OzDOPKcezRKT
 hbi6yh+I11ryWJnHzNGjxaxfAFQ3iWA7xbAEHLzplUcH/RoNqJLe+ESWY/BMbARcil7g
 ldNA==
X-Gm-Message-State: AOJu0YzUoqs5srH9pJvG9OwOYvDxeuAP/OIiT2qQYKhI5jxF/6TxrYHf
 8c1YBpoP00bDIfdaPdF+zG9t9KMZQTASmAOMcoZB2pRl/AXo4Pd19akzlT2ShOsquI9R5heV7tW
 zacZbK3Q=
X-Gm-Gg: AeBDievyEEsGZ3jLeVCj5T5Kc7zURBdPcg592P3XMqw2H0ypCbN67SBn+yiDkpjxyix
 SNmKC7YZ5u97pBMIOif4eArjrUj3BmIwGNuZwtYmtVyPJUOlpHqdsOBI8x8ZWbtilFLM7flCNk0
 oSGjyZOjPRZlw+QHQ58pnqQ0qm/oDs2h4/rK5RjN+cuRF/m+Ab3Ke5bL1o1afjCkpkmv1c50NuW
 88anxAexk5Ri8O4yjRxOsAEn9jWliXQoETMl2He0WyvZk3xGxaULqqaYkXMkdJytb+W8BWVv0bo
 f5wyPhHV3mID+5qIQApFEKdoz2qP1gIpic8VMweWxOELzLohdUoVK69LxYQAb4TQCRLB9FUch9Z
 4ljW+cibVCbzLrGMxa8UkRvg2iGgYWhoxDIWb7bOvMc69A2nGnCkPOmLhe9LK1hO1cge89pXJ9G
 aTi82XRpE1qvd8nzhEtmD6Xo5LAUveMdmG1NAhQ2KvPkbeYNP/Uaf3JSCVI2XSDBEsuhU=
X-Received: by 2002:a17:902:ccc4:b0:2b0:61c2:8e83 with SMTP id
 d9443c01a7336-2b2816dd5fcmr196978585ad.20.1775626901761; 
 Tue, 07 Apr 2026 22:41:41 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbd9fsm187447865ad.75.2026.04.07.22.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 22:41:41 -0700 (PDT)
Message-ID: <28e042a8-876a-43af-8154-e48481c20f2f@linaro.org>
Date: Wed, 8 Apr 2026 15:41:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 27/35] target/arm: wrap event_register in a union
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-28-alex.bennee@linaro.org>
 <0877e0da-c083-4293-bba2-5c1d2e2315b7@linaro.org>
 <87zf3fawif.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <87zf3fawif.fsf@draig.linaro.org>
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

On 4/7/26 20:35, Alex Bennée wrote:
> I wonder if there would be a way to use a Generic so tcg_gen_st8_bool
> would always map to the right size whichever arch we are on?

The only outlier for sizeof(bool) that I know of was an ancient x86 Darwin, which is out 
of the support window.  I think there's zero point in planning to support that.


r~

