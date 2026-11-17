Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E1E606A330
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rM42LZOs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOni-00051h-LO; Tue, 17 Nov 2026 14:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOnh-000518-0u
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:25:05 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOnf-00067D-F3
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:25:04 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8b68e59ab33so163770b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794943502; x=1795548302; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VZQXKu+gh7117b+ofqeeCxyj54F0KDbdKpdIDb7gRAg=;
 b=rM42LZOsFzKcD1B/kaP1Io68VIUFBRDtl19ZQ4WZdbQbtWl0SHDzJsVAc8bi0gvgxI
 M0+D9R8aNPfy0OppZYXuVVOhBKF3ScYgO0CXK+i9tnngTvwun6Ok6m9w2PhUqCQBQFGl
 7fhUj87YViZ4lfSvkunW50DgX0AC3pn0mW9zy2cr+8oW3CZcM2rjvvY37GcEj0eEmmrQ
 mwqYWddGU5zxjuraxr8UM0K8yMmU1YZXaH/8JeeJ2hkSsuQ09ptsv4H2Z0B+HdMwKutP
 DrOhlMEHZX1C39FZmdGWqNq0dCgf3Zq8yJdtq/Q5NLPhXt88FxKkoAIQvQwP3ywd3mX/
 Mixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943502; x=1795548302;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VZQXKu+gh7117b+ofqeeCxyj54F0KDbdKpdIDb7gRAg=;
 b=n9C2sSKDyLYm7gshEbZ0pc07n893JT4b7TqhlBbjf2b+OfcXXLIJMdy9TSEjm1wlxc
 K138IUHf1jNFlONgVVBb9E4DPTpHJA76Ht1oFEUm1tK5kA4jb4YQ6YQa1F2q3iXAKX1h
 hyhjG4CK4hHjMqDN8tmo9crfRMfzoYrkRV2s+AQlCYjTNiutqWMRaqBmsM538dUx1RXA
 cJSlnZeBJDoYreft49GUVaIJEalcE8rp/8ZEEl6lZyjoT2NxJHgXlvGngKSp5fwqc0vx
 UmavVXfx2EElDOy63OVArRZyJtMr5+nWD95p7fPvryalBEFzSVq5bNbOMbp6d3RIyTmA
 OsWQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHq6E2oWxMIlOxdo5kpuuXRz2VUysgs4spAHRrxz+X4NDIaDI/9wI6JhDxG8vDfQW7KKkWc0kTIHMBi@nongnu.org
X-Gm-Message-State: APuU4Z8OCSQCosI4bhTc2FNBh9tL3CcqplLo11lwOfe0kY0RC3kHP+3b
 klMY0bT85nZ8Fg1Lq2FGJs6A8u1nB/FTB7C3MEFuVflWfVGiTPngBquWUVgQHEFFTYU=
X-Gm-Gg: AYBFou1FdNASn0arkhSBqcsU7t9a06u875YTL58GmRp6FvyZLleCxTUEJk1WIFxH+Xt
 D+skiSQ5VETnA+hGqwupmHuUnMxCksrtJdxwKs93fNjO1uljx0Plm1KlNQUUq3XQiZu5KVsNEeF
 REOfsjx2Zsngls4XixODVaGfW39th+d+EGrO8Iqe2IEruV4Nj5tqlnmg8jPwugB/JicXagXBTwm
 6UROcYQTpeXOYFH4EL1/kLvF9cOTMfiooPJ6DwuDxkotL/L5dDIPhNIAUgJBmeSNBfqTcRAVDMn
 zWmfhwOGTi6sqntcq4GwYI49kUiNxupAJ2Ula4fQAA4iuC5ATyl5DLUKboUIwAkPbNegTJes2wP
 XolEv9KSNWY8FflSpWF+WujDeIlpvCBvZuQu1XTueeKfyjwlLEWuXkmoJia56+4Pn2yhHEqDs0h
 6Hu6uxb8dT6rQu/w8CPpaB6fXOs/ptcWDFl9TSe49hxsKhjCAKfXmNdDNa0D1e1puI6b4q5JGcD
 uQGkeWAtRl0de54398ZzlVX+3sF8sYERszf8unkrv4QMqdUemWVUDl1kNSQLOn1d8WFI9WqwOOv
 irIeMwo7bh2PFqx38dniUZBy21ZorTPS/i9+oC4cWX3uy/su6xRWUIvTQZq/PFgGk3bJtLk=
X-Received: by 2002:a05:6a00:2ea7:b0:8b5:a10a:a3e7 with SMTP id
 d2e1a72fcca58-8c5d4eba267mr130651b3a.49.1794943501664; 
 Tue, 17 Nov 2026 11:25:01 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c5cb93d023sm59688b3a.47.2026.11.17.11.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:25:01 -0800 (PST)
Message-ID: <21001b17-c1d0-4a7e-a679-ae5afe5bb6b9@linaro.org>
Date: Tue, 17 Nov 2026 11:24:59 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] target/mips: Decode 6-bit bit number of nanoMIPS
 BBEQZC/BBNEZC
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-17-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-17-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> BBEQZC (MD01247 p.38) and BBNEZC (p.39) encode the bit number in
> bits 16:11; bit 17 is 'x' (don't care). The decoder used the 7-bit
> immediate (17:11) of the other P.BRI branches, so a set bit 17 gave
> a bit number >= 64 and raised Reserved Instruction on cores without
> 64-bit operations. Decode only 6 bits for these two; BEQIC and the
> other P.BRI branches really have a 7-bit u field.
> 
> Fixes: 11d0fc10b7ef ("target/mips: Add emulation of nanoMIPS 32-bit branch")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/nanomips_translate.c.inc | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

