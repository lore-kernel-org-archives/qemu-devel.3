Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B01AD3B992
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 19:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3WS-0002BX-5z; Tue, 09 Dec 2025 14:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3WO-0002B0-SW
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:37:18 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3WN-0002Wb-1e
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:37:16 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so6272205e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 11:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765309033; x=1765913833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=axZH327WMSTcP/2VZHx0m+uCUX4M/Wv5dwHts3NrVvE=;
 b=rtX+/q4o97h/RTKEy+qk/HEPqDTBy90N56cRyKmQyMNmf83HVjae9PxKzjbgU7rkzX
 lx81VLP9nb4Twcln5iz4cGn70Qmz0jOTBO48GOqJVPRnUYKHwS/R86LLDi3Jx6BJ08i3
 gWqzaplCIn7MwksKI0iHdgJm+Qzvg0EPRjHO2FOKjHSvfGiJ2zzJzIrSMjmyTiOq4D9F
 ZVTgRvUmjRzrArvvwBB7woFlAiuo2qmFsRYNiGX87io0Ui1T41V7seiXXJHAWozBRU0w
 BW+qRqU/eYG9qKzfN7TRr5wG/ELEG8eGuXlAg3dVaZxRn71g/woyJ5x2OZNv21+yc+nM
 XiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765309033; x=1765913833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=axZH327WMSTcP/2VZHx0m+uCUX4M/Wv5dwHts3NrVvE=;
 b=tpZLy8SFYWWKZ2IkqmO7bP8/4c/pgKHPFcR0xweRzi2GghUuUEOhDFfBPPz+0mgMvK
 dDfOePM3wyPA9wpfHnNHY+WrrM6r/90Tz3oiuDkJmCrnNbLgLLq+EQLuoCleCb00ztyi
 6dyGyqhOe6RMo4nDRPLtDocvisftqYmcUhMaGfBTJiIl+TIay07S0m7+eXJg5qQ5nTxr
 cgnoTBfqzIf3TJwB+wTpv5VVR+xrmKCYD6UKPvbgdZ6gQCrxzdtLCEkxC2Jn1Jvi8NSr
 TWVzkoDCvaLefVnpDDa6sgi6sOsIIT69EL9+eySN40n8mASJQk1ku0RbX9NxuCdkXoo2
 i6uw==
X-Gm-Message-State: AOJu0Yx6pAnL7a7Ua09/Ka6qsgPZc6OfO+g1cBDGPA90Erq3fDuonHZv
 twe4N0n0kuttK9LrbOkXLm6oaBXrrIPQFqc9mMmZLiMZB1Pnvjgx7UcQOuf68bluNjKkVz8nQoq
 O7nXi5Mg=
X-Gm-Gg: ASbGncs0uVrKElnsGhE9vQFqO62kLICeE+NvaRVhaN7GZpkYxogoSBW1/TbT50PW1RS
 jZ3Kk1H0KBGsv4PctkdaEVnkn23MER0Fo2FgsDrdFXhbrBagLpss98YE9ATQNVzjLNeBThwBVD/
 db+gOBFN1tsUQbN5zD6vj3/+lMsr+JqXq/fmnQEs5gih7C41udf4Hod3hiyZbo02G7pxWJTcvs0
 nqHztagd/cswk67Xf0hI7tlO2OW3sYtgZJe+WR1dzHv6x1W0iDb+CtBGGJg4+7T4jdcGIMWNFVv
 fFjD1acrAq9Z5RQkeZaXgFeNzwRYY1JsmOCGaEYmON+/LZ/2e+DY+uIZcXmqzzx+ozrDpYiLN/u
 0iKHTKa4aAf44lyjGhmADRmELEAqsP3Oc94znDinUHFVXosdqfS4e/LWbwXIFsXzzp5TPnO5xZ3
 7ErimJxXBxq7qT9qHD14ysY46nAtPGtfPuWZiSgnnT4/OvpTSTFw0sEWSiWkiuDrzT
X-Google-Smtp-Source: AGHT+IFUt+JamcXhys7Va+4fsZlspu/lYTAC3YGfuuFefc0iRI3I0ikFsm+lKhNYTyNBU3gSGDOCqA==
X-Received: by 2002:a05:600c:a01:b0:477:63a4:88fe with SMTP id
 5b1f17b1804b1-47939df379amr119192575e9.2.1765309032645; 
 Tue, 09 Dec 2025 11:37:12 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d9b5c73sm25624165e9.6.2025.12.09.11.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 11:37:12 -0800 (PST)
Message-ID: <59d0c2a3-d2c5-481f-96b8-494e6301593c@linaro.org>
Date: Tue, 9 Dec 2025 20:37:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 v2] osdep: Undefine FSCALE definition to fix
 Solaris builds
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
References: <20251203120315.62889-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203120315.62889-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 3/12/25 13:03, Philippe Mathieu-Daudé wrote:
> Solaris defines FSCALE in <sys/param.h>:
> 
>    301 /*
>    302  * Scale factor for scaled integers used to count
>    303  * %cpu time and load averages.
>    304  */
>    305 #define FSHIFT  8               /* bits to right of fixed binary point */
>    306 #define FSCALE  (1<<FSHIFT)
> 
> When emulating the SVE FSCALE instruction, we defines the same name
> in decodetree format in target/arm/tcg/sve.decode:
> 
>    1129:FSCALE          01100101 .. 00 1001 100 ... ..... .....    @rdn_pg_rm
> 
> This leads to a definition clash:
> 
>    In file included from ../target/arm/tcg/translate-sve.c:21:
>    ../target/arm/tcg/translate.h:875:17: error: pasting "trans_" and "(" does not give a valid preprocessing token
>      875 |     static bool trans_##NAME(DisasContext *s, arg_##NAME *a) \
>          |                 ^~~~~~
>    ../target/arm/tcg/translate-sve.c:4205:5: note: in expansion of macro 'TRANS_FEAT'
>     4205 |     TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
>          |     ^~~~~~~~~~
>    ../target/arm/tcg/translate-sve.c:4249:1: note: in expansion of macro 'DO_ZPZZ_FP'
>     4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
>          | ^~~~~~~~~~
>    ../target/arm/tcg/translate-sve.c:4249:12: error: expected declaration specifiers or '...' before numeric constant
>     4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
>          |            ^~~~~~
>    ../target/arm/tcg/translate.h:875:25: note: in definition of macro 'TRANS_FEAT'
>      875 |     static bool trans_##NAME(DisasContext *s, arg_##NAME *a) \
>          |                         ^~~~
>    ../target/arm/tcg/translate-sve.c:4249:1: note: in expansion of macro 'DO_ZPZZ_FP'
>     4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
>          | ^~~~~~~~~~
>    ../target/arm/tcg/translate.h:875:47: error: pasting "arg_" and "(" does not give a valid preprocessing token
>      875 |     static bool trans_##NAME(DisasContext *s, arg_##NAME *a) \
>          |                                               ^~~~
>    ../target/arm/tcg/translate-sve.c:4205:5: note: in expansion of macro 'TRANS_FEAT'
>     4205 |     TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
>          |     ^~~~~~~~~~
>    ../target/arm/tcg/translate-sve.c:4249:1: note: in expansion of macro 'DO_ZPZZ_FP'
>     4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
>          | ^~~~~~~~~~
>    In file included from ../target/arm/tcg/translate-sve.c:100:
>    libqemu-aarch64-softmmu.a.p/decode-sve.c.inc:1227:13: warning: 'trans_FSCALE' used but never defined
>     1227 | static bool trans_FSCALE(DisasContext *ctx, arg_FSCALE *a);
>          |             ^~~~~~~~~~~~
>    ../target/arm/tcg/translate-sve.c:4249:30: warning: 'sve_fscalbn_zpzz_fns' defined but not used [-Wunused-const-variable=]
>     4249 | DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
>          |                              ^~~~~~~~~~~
>    ../target/arm/tcg/translate-sve.c:4201:42: note: in definition of macro 'DO_ZPZZ_FP'
>     4201 |     static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = { \
>          |                                          ^~~~
> 
> As a kludge, undefine it globally in <qemu/osdep.h>.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/osdep.h | 6 ++++++
>   1 file changed, 6 insertions(+)

Per IRC:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


