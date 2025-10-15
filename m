Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD66CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95q8-0004Rp-Ad; Wed, 15 Oct 2025 14:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v95q7-0004QG-15
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:03:07 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v95q0-0006TM-AR
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:03:06 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b67ae7e76abso3207954a12.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551376; x=1761156176; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0eAfi5QLPpUAGtOJYXOZuvC7Oc661EEatCUY/qWrYdY=;
 b=LuEGEFJVwWEYnDpUO9s7aAwyOL8/lkdevycQHRPeG0ZREKtmVgjlSoBUVwZfv8fNZj
 +B9USAjQewmm2N76eZnsNq0kbhh9sSjo6FL6CnF+kBE2XJY4v7Ffcdlw7Or7n0TvEfzR
 aUzRgPU0eKVu/7ublxNttAAce4Dv36t45pozSo4KQkRBKIJ21TaPSyLvdR7Cr54MlHmn
 KGumKU20fH0CXK793Ejxri099XIEKSFlDYYx4T4kg3VBNKboHxPLqVF3EIZ7MEbu+huh
 /nibTV254gq70GGwG8/T29W1fTIr1xDgG9TGJS1tADyzFeaO+FVfo21BQhHZE5ypTEbv
 /SfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551376; x=1761156176;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0eAfi5QLPpUAGtOJYXOZuvC7Oc661EEatCUY/qWrYdY=;
 b=L4kSWbJFv5Xizh5jKILhIkP3u86SbOe8mvxuFsFbY1yB9Tf8lVqtuYDju6jH5ToIh+
 8R2GqXJZ4+pIz+DfBzBRZ0S6s60vLbSrhWuumKohKm4PNk6M2kIG16VvWTYCYWf12v+n
 WMTyosUjwSTxNNVFbtuGmgn7nIP7I4vuvC70PIfvy4P4CevQSnuWZC0l/iKauNzynMy4
 ovmS9lR5r3P8nIVguXvxi/eB2g0AlfpHkellHpPVTGqDkQU8XesYD3ZRQralugIRhGC9
 SGXQaYhZvuN1nUvf18G4ROWTUyfcawN/LqlOXdBKs3TVbp3ATESiV06HeyZ4qUgbt3TA
 aEuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCdYpYh4u+BxYAW5f9umXPbS+Sl0ARBKM3L8arBBkP8f4uGXPH+gSIO7vVDt1tJE5pSm/Eqr+plhWC@nongnu.org
X-Gm-Message-State: AOJu0YwmdGaRLCLc9xj3m6Yxw+KjgfdMdSrALURQFLt3eSUDXbBTBOuG
 ZXn7TbcXWxiu++7ktG7+Lp7soXs+Ju87jBwk4ej53+FlhcPbNJp8HuRQC5pCnwUhm48=
X-Gm-Gg: ASbGncuVyPfnVQmCl2v64lYW7PgL5hlYc8q4WFuj0bHHOTbYX3UvVO/uoRkhp/Wu6Yo
 qH99unavOwHltxUGRAQfMw0uVn1R+0tWp5tMI/uLduCGsLdvniQgXDdJdbaH916Jzl28hk8jJwz
 G+qwdUMs3vZBKtufKim8kBVoCnUkUW58xOaI9FF3QcPT17hCuRIWXRzaLp72u7WS5UGU/GHBJDt
 c24EEGLKNPXRdAFXr2GvS+0lowKOx3fN6RE05PTjf73qYviL4HMF/dF3+BvAtAsSlQVprVvhuZf
 eicGA2aoVK6L5At4pShN7Ds+i8la+DacMPTDWm5q7YwuyUe1YrYIOQK0YbtugtqZHqtJzwphRqy
 JIS4A2GEovhkjC4+Zx6mTNsyr+HYbgJsNSWGwSJGiLfDSJuYKoIWoXxVpng==
X-Google-Smtp-Source: AGHT+IE+7FQ+j2I27IJCv0r7O17KxS55hsOXG9jzrm8TiZVAvJ3pcMfeY8XNVKkTq/ihlEcIuBnD6A==
X-Received: by 2002:a17:902:d588:b0:27e:f06b:ae31 with SMTP id
 d9443c01a7336-290273a5f2bmr364950655ad.61.1760551375481; 
 Wed, 15 Oct 2025 11:02:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909930d1c0sm2995305ad.4.2025.10.15.11.02.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 11:02:55 -0700 (PDT)
Message-ID: <2dc77308-bcaa-4c7c-904d-8b71ccfa0983@linaro.org>
Date: Wed, 15 Oct 2025 11:02:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] target/microblaze: Have do_load/store() take a
 TCG_i32 address argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251015180115.97493-1-philmd@linaro.org>
 <20251015180115.97493-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251015180115.97493-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

On 10/15/25 11:01 AM, Philippe Mathieu-Daudé wrote:
> All callers of do_load() and do_store() pass a TCG_i32 address
> type, have both functions take a TCG_i32.
> 
> Suggested-by: Anton Johansson <anjo@rev.ng>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/translate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


