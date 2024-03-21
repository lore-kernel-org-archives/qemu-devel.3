Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B46CD11DB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 20:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnOdw-0007Da-Kv; Thu, 21 Mar 2024 16:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnOdv-0007DQ-2y
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:04:03 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnOdt-0004ew-GE
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:04:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dde26f7e1dso10260355ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 13:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711051440; x=1711656240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IjxEZPKFtcHsfHvdW61Y1eV5ILahDZUUOX9CbImvJNU=;
 b=JKsmxvbNpFrW6WsBLD8yCuGEvCfFzcdHe9QN3q2glxFcpEDRLzjT6MtW8BckF2vNQn
 mYNzGpy8zBfDuN+/wcrdmeOmkDpRPeiaYDMkEG9VIhtYMYBFWjI0AZyaygod44+YcIfz
 JlyAABeBakJ6UzEDXBOs2NJ2h1pTQzBZKanjiIsSNmqUAgIUDtWvcOIZ+GSFHOh1lhQ8
 I/XdC2u8bEZeDwN7qo8v2+qEx/vWoDpGfBQuJmIZ4rgfUmaH5JT71NUxxwYPXwQmzP0M
 YQ5tl1jx0friInqYsUW6tNEgnCiP+m4WsazvTZQGxzlGCNftVOSkhcOAimFHKMiGrPgs
 rIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711051440; x=1711656240;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IjxEZPKFtcHsfHvdW61Y1eV5ILahDZUUOX9CbImvJNU=;
 b=lpZCTGNmGMryiaxK7DLOHgAWgKot/Nltw+blWcbmiupnakOyRWwWrVOVOqBxcHLU6b
 hiUddTBl0NEITTltpOmBGY7FXopxb0JeN9cnz9dxQOkOpFv5nN9FxhcHKec1pSR6KpAz
 0ADkB5Vya/hufC7HW3fFIHGtqA0wOG1dYHWdgRhkUc7OdvAeJD4Jsc/wRiB+l7sFiGD7
 bfBPgdbdNnXGQe9K3yzQoWHfmV68CzI70UWgauj1DmEzAJL5iCCrDF3QrNWwrzjbyjxn
 XLgBPpG0yHMB3+sTkZlCKfzNs9c68fFSv3590Zr18NSR/foPE2Pi9uKn/vnHAyH3xAke
 HT9g==
X-Gm-Message-State: AOJu0YxfIugN+95E8h3X4JVIu1jvHzLoh066RIyWB2h+ztQFclSzrEo5
 Ysm0/CtCft3lkuHMVGDW685j/GJp4AGULnZLiqMAikhnXjuZyz0H6jJG2+pH+Kc=
X-Google-Smtp-Source: AGHT+IFiT+cQJwPQGuSAK/9ViBf49c04bF2uFDwsXblUAHdZWjLUa2cV/GFSzTcPzjUug60OLPxM7w==
X-Received: by 2002:a17:902:7c95:b0:1e0:4dfd:c121 with SMTP id
 y21-20020a1709027c9500b001e04dfdc121mr401453pll.68.1711051439885; 
 Thu, 21 Mar 2024 13:03:59 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 a11-20020a170902eccb00b001dee1e0beddsm232159plh.246.2024.03.21.13.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 13:03:59 -0700 (PDT)
Message-ID: <ee2d2e6c-1843-4be9-9a0a-3505b20d9926@linaro.org>
Date: Thu, 21 Mar 2024 10:03:56 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/hppa: sub: fix trap on overflow for narrow mode
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240321184228.611897-1-svens@stackframe.org>
 <20240321184228.611897-2-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240321184228.611897-2-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/21/24 08:42, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/translate.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index f493e207e1..4d2b96f876 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1213,6 +1213,9 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
>       if (is_tsv || cond_need_sv(c)) {
>           sv = do_sub_sv(ctx, dest, in1, in2);
>           if (is_tsv) {
> +            if (!d) {
> +                tcg_gen_ext32s_i64(sv, sv);
> +            }
>               gen_helper_tsv(tcg_env, sv);
>           }
>       }

Difficult to pinpoint exactly which patch should have added this.  :-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

