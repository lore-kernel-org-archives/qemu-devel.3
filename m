Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6771EF3C99F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuej-0002nQ-84; Tue, 24 Feb 2026 10:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuuee-0002mr-T6
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:48:58 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuueb-00077g-T8
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:48:55 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6580dbdb41eso7505054a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771948132; x=1772552932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uML87t6VTnfe6OqPR7lcOZF7XhWhMoV3DRRxCoR7948=;
 b=M8knFMlOtiTsXKzLYbyrl1jZSCVZ7i1lVS/wotiXzBeCd7plUziIj6fuolqCeQoqfG
 kAdO80zsUrYPtFsjd4jIsOAHZFgjinCrMEIiK0CQHqW/tCSt4KOrRbazeR2RSUM7b90B
 rLwtNvuaa79r+tkIBhfFFEo16TNp7KA3lSi3RZHS1szJC4zp7n84XyyiM2r2ADGbDzct
 NTBZeYSHlXvBnaxw/085gQ6SgQfEfRKfZtpfQOT84yLTKldFfXLOZ0/20ICabE5961UZ
 0tiBkKxrmFOOHlK6QT1nTq1Oif3aAstsF7sYxMNooslARtD9IdzCTwqRnQjxrMWPVu2s
 BxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771948132; x=1772552932;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uML87t6VTnfe6OqPR7lcOZF7XhWhMoV3DRRxCoR7948=;
 b=uUgNbpeyDgXPDYBzaIQNCnDltY5g+sG23MKDE9sCPl3tS8gSRJVttAUKSQ9Eypv3lV
 2fKpISDH1YOvQW8POTf9N3DIsK+nuPWL0MrMFz1UtnrW2HeOj+NoAfhmXR9bct5qIQOL
 ZJJPnbD0A/MVHRKD15CZEExb3A4e+G1EDQAQ3YSC4q4mw63geLp3n5wVtus/B/wMDtM8
 uzumE0zNFiI2rOKj7aiJxFBMrr27z7wnv3VNAi/BEv9FCRs+J7ypY6Fjcl0NmQSZcV0o
 sbH7RrASytNNEJwtyu8+LDO7VBwHmbAcSr39LnJ2pxYLHfoyg8jeT5S5sVevMOJNeRUx
 i0uw==
X-Gm-Message-State: AOJu0YyXgTAIeH0/I9HWA13oTr5sqFzn/Pu0Z2pc5798EaJcZRy5bYRF
 4JbQ/X8NphzaFpsNj5xAnsgx+aLUsELOR4k1aSXEZKAf+iy99exUbSEIoWwNLn8SsxpWYEozQXV
 KNZpN
X-Gm-Gg: ATEYQzzoWtUcxS0DgBx/uxCJyEaad/8lftCWhpeFDwiLgncAxtvDj7qd6+4jidEv2bn
 PHLWIoEebx6rm7wbqeqG56xVqGWDdlcX1X36OC0X5zAF0vpqKwgB9WmRG+xHmJjCBoodnE1XJs2
 zgfnlx0PNku1h1Lna7sNFsFWG85KDjpBnuhX5bORDIQFUFcpcr5Bx8bLOEg77IUSw9n0o7hyLD1
 4rRvttzrf60uu/LxP96mVEK+NClFr4+uNAqtdy0/YGBW6wvwIfM0LOEU8Ua8mKRJ6DSkW80jPK4
 6nQIwcWci9gvRyB5U8+cqpe4TNpk3tJYDltQB/D/xGpVhZq8KcNzug6pqCani14Ga2TLskFpj00
 PZIA8FOaqDarDe8l8txBeMshfO0lxqaARpVLDn6eWDmBbdaVnVrsr/ppPcNvBk3jsxPDdwUI7KW
 SouoJ8B98e+LddZrXY9cOM8Ds=
X-Received: by 2002:a17:907:2d90:b0:b8f:f078:4f5f with SMTP id
 a640c23a62f3a-b9081950b7dmr768622766b.7.1771948132247; 
 Tue, 24 Feb 2026 07:48:52 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084c5de7esm424447266b.1.2026.02.24.07.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:48:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AD9575F7B4;
 Tue, 24 Feb 2026 15:48:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH] target/arm: set the correct TI bits for WFIT traps
In-Reply-To: <CAFEAcA_rhRnJWQoC501HimdutMKessVbAF3VV=J6tFFvHMzriQ@mail.gmail.com>
 (Peter Maydell's message of "Tue, 24 Feb 2026 11:20:36 +0000")
References: <20260220171945.1065102-1-alex.bennee@linaro.org>
 <CAFEAcA_rhRnJWQoC501HimdutMKessVbAF3VV=J6tFFvHMzriQ@mail.gmail.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Tue, 24 Feb 2026 15:48:50 +0000
Message-ID: <87h5r63zx9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 20 Feb 2026 at 17:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The WFIT trap should be reported as 0b10.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  target/arm/tcg/op_helper.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
>> index 4d708635068..aa14f15eb62 100644
>> --- a/target/arm/tcg/op_helper.c
>> +++ b/target/arm/tcg/op_helper.c
>> @@ -448,7 +448,7 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
>>
>>      if (target_el) {
>>          env->pc -=3D 4;
>> -        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false), target_el=
);
>> +        raise_exception(env, excp, syn_wfx(1, 0xe, 2, false), target_el=
);
>>      }
>
> It would be nice to also report the register number in the
> syndrome (especially since KVM will use it if it's there),
> but that is architecturally optional, and getting the TI bits
> right is a bug fix.

Turned out just getting the rd information is trivially simple so I sent
a follow-up series.

  https://patchew.org/QEMU/20260224154347.344219-1-alex.bennee@linaro.org/

>
>
>
> Applied to target-arm.next, thanks.
>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

