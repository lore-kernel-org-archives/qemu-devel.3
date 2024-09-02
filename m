Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DEDCD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 13:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl70L-0003FO-J3; Mon, 02 Sep 2024 09:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sl70E-0003Az-Dx
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 09:21:54 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sl70B-0006hT-LW
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 09:21:54 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c0aa376e15so2325989a12.1
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725283310; x=1725888110; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g3lXrGPID2yV/S6Bim8AfswiQZUQMpjqLA4/7h3Dvhw=;
 b=h/QlHiERaZ9gNQbyOONS6muRIgpkklZ4bgeWRuyxzzsysHqMQkic0cJtLD89aRLfyk
 /JlSuB5Sv3GTwf4HZ5dZXOR25izyJUo/HM2we1QjtK/cTROMpnmZXbizeR2ZlHVUuSyF
 vY+kYAgYBu1b2Eo5RhBJG427f0wcYLjp48Gx2uWjFo+m1Swxlr1e0dwTRj1eNUpMlUTr
 h+U4Uz2I16+7wgINLxJBXGgl2rbLeDU50IVxEhkLJqqhicadwoj3y+mhCMuBnW9EkXxw
 Z3nJsjnVX+LwT6dkJ6mJo6spP8jFGgiYB3S3ukZXH1Apab41JsaWB1IgfMiY4b8KTft9
 vi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725283310; x=1725888110;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g3lXrGPID2yV/S6Bim8AfswiQZUQMpjqLA4/7h3Dvhw=;
 b=HGNdY4gGMJ4MqYujWkIuKCiWcipXA+7RetlhLzw2cG2siVYHxpt4XQopB831+wi/GN
 Lvdg3xv0xFefltSBb7EVqXyMgPVtnuaVGCwCzic06ubxuwdOHArg7xefvE8iFCsPe90G
 jZNr90DQdWTzF5kAJv3LKDMRFUcAVcXhNkZVEXmr43gmlKL2LGPnB9jNAv5yDw/tRCn2
 FXDs6YlqUbz06a8YHz6AKexQ6B40sWDCRUNfiav89xP1SJKRuJbF1vGpJVTA8c/FxZtT
 LhgFiq4PJd2t3y7OuCye2bm/PwqJdewV1OFMzvA8rzCAZ1948XP6pW1JcfghEK7nSccJ
 klKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb0hhY/U9Cx6I7usB4cIMIt59xZqDyhb1Zy1GbTTmiff2wNLSr+fN7TfQS+uEMtkSM2uKP37zUvuC+@nongnu.org
X-Gm-Message-State: AOJu0Yz3AA6dW/GShWmO5oEbmQa/HBcIOB/XZVsY7lrC97KmxMa8UoBL
 +GmkrPj69FSC1j/TnOcmR09FYvWN4l4cdA82htNzQILxPzT2cN53zSgBaabRusG59zIKc2BaXDO
 yutIHHE5uUqTXs0ZPxg5r2Ao8alWqoHyappLKug==
X-Google-Smtp-Source: AGHT+IFV6lums/KhqZrNi6gTn3vmrqhbZc2Oi87klN8LbdG14PUR3llJVRJxmykrQWONrn1iyqqGcsH2lsCQkibLDqk=
X-Received: by 2002:a05:6402:27c7:b0:5c2:5620:f72 with SMTP id
 4fb4d7f45d1cf-5c2562011e0mr3222410a12.0.1725283309516; Mon, 02 Sep 2024
 06:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240830152156.2046590-1-peter.maydell@linaro.org>
In-Reply-To: <20240830152156.2046590-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Sep 2024 14:21:37 +0100
Message-ID: <CAFEAcA_g5ikdqXQB7t8x215TQ0O2YoE4S=Xa8TcrUxba1kddyQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Correct names of VFP VFNMA and VFNMS insns
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 30 Aug 2024 at 16:21, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In vfp.decode we have the names of the VFNMA and VFNMS instructions
> the wrong way around.  The architecture says that bit 6 is the 'op'
> bit, which is 1 for VFNMA and 1 for VFNMS, but we label these two

Doh. "1 for VFNMA and 0 for VFNMS"...

> lines of decode the other way around.  This doesn't cause any
> user-visible problem because in the handling of these functions in
> translate-vfp.c we give VFNMA the behaviour specified for VFNMS and
> vice-versa, but it's confusing when reading the code.

-- PMM

