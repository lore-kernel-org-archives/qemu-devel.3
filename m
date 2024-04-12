Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14B3C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDWH-0002f9-AI; Fri, 12 Apr 2024 05:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvDWC-0002dp-IJ
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 05:48:24 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvDW8-0006kM-Gg
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 05:48:24 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5700106506fso335406a12.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712915298; x=1713520098; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZB8y0xNEwspYUuJxh7QF5y7cPX4V9BxIXwM0skdv1E=;
 b=Osg2HxdyAxqTkfUeH+GhjY3mfDEoF5T05WTQ6IP+t9g9o4mrm7wV7DJs+pqtlym1BI
 1GFc3b1EfupoNHC7GrCeZUa5LEy9iF45QMXHzdsvWmybynpf+ZfpmksVS6L/CeV+uMqn
 04dFDFMPx2G3neZ+vgiZUhWydF4ei9IpWExY8IaJOC3qy2fpPNlpqiujT7vXwNNpeWrp
 VFkF3XJDdD53NwN5RLQqeyFlZy0Lbph4bnaVxucGaruWD3aKyHunAR3iTnxuPah+Ki/e
 h9V2i1k15bmPyquM83CrMvHlZOU+JYwCD/nO+W2xefkYNfvi7y70ZkAl4gw8eFXTZN/M
 EZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712915298; x=1713520098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZB8y0xNEwspYUuJxh7QF5y7cPX4V9BxIXwM0skdv1E=;
 b=qOe4nLcSdb3gQQTKSN2U5nUFsdijC7lROIthsD5h40hhxjUflWH1hBLcxJD36WG7EP
 wrmfCcdR8dPVLynYURrbuNX5jZ+QhpjMnjSYGwJ8aFikaSuDHdzGKTe/rpHwASDohcon
 zvUGXJ39WBT6TTs0i0Bcnl1afpJMBiRHA2ihr077vW9Ca+HM1mIqWRMnLBY+fDliEsbi
 2fOSX/VfADexk0fZBHzBe3VUm9gToEIkI5n1PV2HjWCqiKtwkwnsNM7SxGViY9Tdw5Zc
 gMBhZyH5HXhDv7hNJRc3O66LNupj4gj/Q/3U5umwfJAzfaJXh1JTRbbC5SUslABy9DRe
 C0aQ==
X-Gm-Message-State: AOJu0Ywx8Vc/3eHPJuCaEzJHRl3W3cUGaHO/OYIXywuzB2i/d0Q7yEsH
 ks98zdKUkJOBW1T8ujRjwTak8Iv/IBS49oTlAj2LXhZDH0NXRbntUeWcLLp481OGLG1Dg9ia9ah
 O8WfzYzABfyQ95QlrROv47N4jayamfVInEAVfyg==
X-Google-Smtp-Source: AGHT+IF3TI86TAXH/Vff4KI7pLvNcQ9azZKz4+CCPp6R6F3ywlHopf2Eg1dI8da18/R4K1cJJHd3PcZ1XaQHCLjOfVU=
X-Received: by 2002:a50:8a91:0:b0:56d:f246:bfa4 with SMTP id
 j17-20020a508a91000000b0056df246bfa4mr1938855edj.23.1712915297839; Fri, 12
 Apr 2024 02:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-23-richard.henderson@linaro.org>
In-Reply-To: <20240412073346.458116-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2024 10:48:06 +0100
Message-ID: <CAFEAcA9cY_DOpg7+5pVtH3biLMOUburV89=EE101fyDvdsV33Q@mail.gmail.com>
Subject: Re: [PATCH v3 22/27] linux-user/flatload: Replace sprintf() by
 snprintf()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Fri, 12 Apr 2024 at 08:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use snprintf() instead.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Message-Id: <20240411104340.6617-5-philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Rather than this, I think we should use my patch which
drops this dead code entirely:

https://patchew.org/QEMU/20240411115313.680433-1-peter.maydell@linaro.org/

-- PMM

