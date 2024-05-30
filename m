Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A40C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCexm-0007es-Ki; Thu, 30 May 2024 08:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCexb-0007Zj-Fl
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:32:49 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCexY-0007nB-7p
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:32:45 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57a183ad429so933735a12.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 05:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717072362; x=1717677162; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=68YfPb/qlTPEVjtIVILBn2rrVyHz+ITENgnTaqVbEhE=;
 b=KRr5cq/QZIRWuwyM4aKadkqrJ2P+2OF54gpScxlNCsoynG/cfqXDnbl9WfuU/YzXz3
 efhSSXOufRzteX+yWSxEh4dmxT+FIj4KpF5rqfLgaLp6NAZBuRfH/uAZpJmGQ7djRoPl
 MSVOv4SNOC+QcJTloSaevDUddsh4ynxzbzu63gzLPSusda4e3Z4Sdy/2xdNdm6UXxiRT
 SUBoaCJag5cW+ZTeOGuoacbNlZ4hvTryVsHnu5AKoBn9qwBrkQWjadQ0w5obgNIQZHo8
 QDEDQtLWNBE/3aN5rVARjSRY1vNKlic4Q7ut0fur/Uh5NZ0zFDmDvYannREUurWBRMHD
 uQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717072362; x=1717677162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=68YfPb/qlTPEVjtIVILBn2rrVyHz+ITENgnTaqVbEhE=;
 b=jbtQUjrvq+FMVCixCziOd1bn03uB+D91+wDv0j0mIWuH0iUHx9jcV2/Ya1q0U2Axph
 6nuDCBRo9rOwlbO8d2L1cg+5bt4cUeWdKTHQ2YcKzCOmiJ0z9HZWT/dmbnSfYpShsvPZ
 /Y/ZyRZrQIvDjpAdKsjuAsZtSLY46uZHVKDinDH+HnByGm96HSH26gVty8HzkJ58Cqsz
 N11DSoPcj1RzNjfMxX3Aw0UPRtoHeocbx+quJkQL2x38XfAkni9yoGSHQmRIykAl8bpJ
 Ts91rMiJkfvFq4bAHLdDF9YujYxe8O2uA7a4w5EAVifXeso4zzIYNgvRwx6MFaWB8oyf
 yQ+Q==
X-Gm-Message-State: AOJu0YykiBsOd0AxWID5ePMxH5WJBnmXobBJ3HxbiWS1KEgtHpHnUjkj
 SFZoge89NpSKAPXuGr1gMYmI3Lo5uHBRfpG3lpP8bCESEFUnAx0eMRoVc5c9pfXZE31yCFadU21
 Hg3KZ5H99mpwcD7kX3QocdxF3CeyRWQleKBkUrA==
X-Google-Smtp-Source: AGHT+IEysxwhX+y7hr7x6DjT1KAvL7Zw/ZlAmtybDDRVi4UToA3atWiNfsg2kR40H4Wt68ujeKKXKrY4tKCQdaXRgEY=
X-Received: by 2002:a50:a414:0:b0:57a:2cf9:f614 with SMTP id
 4fb4d7f45d1cf-57a2cf9f703mr190907a12.32.1717072361702; Thu, 30 May 2024
 05:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240519094106.2142896-1-rayhan.faizel@gmail.com>
 <20240519094106.2142896-4-rayhan.faizel@gmail.com>
In-Reply-To: <20240519094106.2142896-4-rayhan.faizel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 13:32:30 +0100
Message-ID: <CAFEAcA8q=AHi=L2zDwZgYbemB1vaKHQpmW43aOWSEu=2JHOV8w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] hw/misc: Implement mailbox properties for customer
 OTP and device specific private keys
To: Rayhan Faizel <rayhan.faizel@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Sun, 19 May 2024 at 10:42, Rayhan Faizel <rayhan.faizel@gmail.com> wrote:
>
> Four mailbox properties are implemented as follows:
> 1. Customer OTP: GET_CUSTOMER_OTP and SET_CUSTOMER_OTP
> 2. Device-specific private key: GET_PRIVATE_KEY and
> SET_PRIVATE_KEY.
>
> The customer OTP is located in the rows 36-43. The device-specific private key
> is located in the rows 56-63.
>
> The customer OTP can be locked with the magic numbers 0xffffffff 0xaffe0000
> when running the SET_CUSTOMER_OTP mailbox command. Bit 6 of row 32 indicates
> this lock, which is undocumented. The lock also applies to the device-specific
> private key.
>
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

