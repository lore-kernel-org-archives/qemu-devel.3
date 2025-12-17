Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310AAD66B85
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 20:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVyBE-0006re-61; Wed, 17 Dec 2025 15:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVyBC-0006rN-BU
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:31:26 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVyBA-0006wG-Ns
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:31:25 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7ade456b6abso4984053b3a.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 12:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766003483; x=1766608283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fTVQ/fEeI/ZAlh6GQYyRGdGLKnhSALHm2pellZmlW7Y=;
 b=I5HFV55cEcwzINhIUz8hExCLN//h0TxCw5XruE3ZBfoi2QbwCX+5HgYiHQio19koRl
 0CoCbEFy6MbP3xf5ICeH2Q/HsjKlvru8oJ0Fbh1MpqCBAft+5giazWWVnyOHtVek7dFh
 8hN7w1eon23RhmJzf/pKrtL3oS+dYtggXt2xTekDhB/fQA06Ny2x6eU61DJkv6y6jEhw
 9HsKhHhs3FRcXuvG3db12UKvvEub9PGrNKFKvBed37FSuz18IYzrui0CAMWmSiPpQm8z
 DWEGzqgqnb/rw/jfiie3y3TqOZh9rkJS3H3ju5g7IS2e0JLQqSebfwut5twZXigrc07/
 k9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766003483; x=1766608283;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fTVQ/fEeI/ZAlh6GQYyRGdGLKnhSALHm2pellZmlW7Y=;
 b=urWxc9ycHuuaEB3juq0Rz8JfIN6Nt0X5Pkw9SsvIkqQ25c7+GOix6PTqLKCT9YUwFt
 UgprTVLEJBF+2yliZqT+0t2S6yF4SBNAUCXF1eYe2MUiDNvyuiQ3U3jLvTYpWwNokpon
 plz57c/Vh2+r9QW19QHu4HAYiUdtl/w8JRSP6RrpI5NxgbSQ8uebWayk/jAfCbbqzPEg
 D1lRulEyYwSX68DPZE9Cb/v/FOvXUlV3X/pcV2MJDaLUaOZ7RWYWQPLnjvMfWly7SfW8
 m/syHbC6QT1aauqJ7wC7JhVfU+cRrYVbe4n1iWybZW9+bxvjwg2RMKypFNrRj4SmA1+u
 EPcg==
X-Gm-Message-State: AOJu0YyJ38Rezuou8jO5q8+olUKSekaTuLlDlqrOVkIIVxlp53QpXHaq
 uTJYyCnorcPAsu26Fvio3LCpVBQO/HnCcm5hpiBRRqLgQ/4fxk+jDRBOZMS8MYjbK7llcbawM24
 YBbjnyA1Tpw==
X-Gm-Gg: AY/fxX55spS6PnMpu24Ws0kbSdavrnMCNZPwDyvMGW7QqdRMhVgmtSuip7s9xoI7exU
 FrnMTO4PaAYR6dvfO5LYaR78BbBakHYWlMqh7Ja4G7viPIQ+FTlKICbyhyD9rdzRRVLNo9CTeTp
 0chkUxeAe9d/OwJu5U4qjRoK5M5LK3t4y+/3XQ2j4UeRcnKfRyQ9moM1Aq7HlXPyVggrTxPWWDk
 pWvUn2QFe4KSezQPd6LaxI3R3S4rS42juyCYGWdZcVqkLcBA0zeIaAASNmu7GLAo1N2MIENAMyI
 AF1AKvEkegSJe8qbqZC41xlkRyXlvzX9og0Hon6kbd7FzbvEPVQACQc/nievefKGR+479Jp+aTV
 wip+IgNg+uG5k6/rhyxIc1VFh1mVBnGMhiOsvZXX+v6M/AdiWoEZtovMAFXUiOvgf7IP53vLLWD
 swpAPUcIOc9F33/gqJgDeREoterjJb/kPW4Sep6ZmN
X-Google-Smtp-Source: AGHT+IFO+OMjxQn1/aBK9dQCK52LUsVGovzV9zqCZaNWB2EXxHvzJnIKrwkYfoiAZrjroguN4f92vA==
X-Received: by 2002:a05:6a00:f0d:b0:7aa:ac12:2c2e with SMTP id
 d2e1a72fcca58-7f667d17b97mr17832413b3a.25.1766003483053; 
 Wed, 17 Dec 2025 12:31:23 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fe12128ebdsm327715b3a.26.2025.12.17.12.31.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 12:31:22 -0800 (PST)
Message-ID: <fe26a36a-51dd-47ce-98af-4741d2c4f196@linaro.org>
Date: Thu, 18 Dec 2025 07:31:18 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] system/memory: Pass device_endian argument as MemOp
 bit
To: qemu-devel@nongnu.org
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-14-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217143150.94463-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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

On 12/18/25 01:31, Philippe Mathieu-Daudé wrote:
> Use the MemOp argument to hold both the access size and
> its endianness.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   system/memory_ldst.c.inc        | 86 ++++++++++++---------------------
>   system/memory_ldst_endian.c.inc | 20 +++-----
>   2 files changed, 38 insertions(+), 68 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

