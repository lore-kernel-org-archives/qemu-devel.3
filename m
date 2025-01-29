Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1AFC02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 13:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td7l0-0005LU-OF; Wed, 29 Jan 2025 08:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1td7ko-0005H9-2U
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:05:15 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1td7km-0001Nk-Fu
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:05:13 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e58a7e02514so959657276.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 05:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738155911; x=1738760711; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JU4TDlxCE+t7ZND6wDzoLkm61xjMqr4BdbepcimTqYU=;
 b=RRJlezexEZZY1AVdba6qETp/wwLCUJ96EkMG4Zw0RtJxuYgcM+V/C3KZq5gcnbFNFQ
 IsYbub++2LwABsfDoiOU38MsdiYFBcekcTdyYXqOxPDD3/Z8Em2W+OjbLKGOU1UnQtX5
 2Ke8Er90W+c9AJQ/kd6ZFR4gKY41NyAaGgwcPBR4/oS4RZ3ntwSbFOQ4eqdqZBSimo0G
 FUaXfqdRp0Kev45t4mL4plGXL2b/gkpHi4SyJRdD2GGn1xsW2HOV7ExY40bRtgeeedhm
 r86pVeiZ41jLV4YDGvgxQGZKMIaq99cnccRo3hA8/b0zquLVR5HCQ+rCRqDZYhHARGDL
 DewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738155911; x=1738760711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JU4TDlxCE+t7ZND6wDzoLkm61xjMqr4BdbepcimTqYU=;
 b=O/z9t4Q22Cpb67o/1F9+OMURhEAPnEV4VGcGrF0wJDDBCh62tMWOjJfy+G5EvU9lCq
 Er/Q+dIpL354PqynG4SsPmaDEgS4wRxwpH7JEkDZV6vZzl18U6rX3XsqP84gIEXYGeJc
 RiMg8XkaN6Abtn3t6u+o+dDLdUsIjZ6KPSa1YZjk9CJTDorI0xtdWpsjpBRDeoUILcoI
 rM1yzCjDJOayiiKQsVlAYZt4A8DIMERx4cz3BY+ueaxNOuQqusRe2M1/1f0TaQIb5u4m
 VXGtPUbfPjlXml8fJwKvjFyh+mAh+di/gkSQGn6SqqJFVqCABi/p7uGa4m9h2Rz3Cxtw
 6GBg==
X-Gm-Message-State: AOJu0YwPfAWlgIx4xgmpnmDBD6kAyOr9SHsgF4Yv/VRmleA+oIoMXtqu
 6oOWoHGh1E+a9oabGC1uHlJnlCbOs2fKYgJrDBYGYVh8i0Yggv0vgNiElRfvqFBPLyOEcF/1Lhd
 71egbap3SQKxJbMFjraQTM3uzC+O+8fl5Hmi5/g==
X-Gm-Gg: ASbGnctVax+CJU82p0h1dnJRUIz/vP6mcuNag/jpYtN+tcc6q6rVuNuYaeA6BrRePed
 Pqkn0xXX7H6yopJsRzzR1eV7/CoCEhmntuowefKNOHvE/XuTHLJ3ot4NGms4yU2Bdj6J3PdDKhg
 ==
X-Google-Smtp-Source: AGHT+IF4hmDpYYOOoJ3jYURogwLypheEHQMigALube1PmqiIg7aK1ut2tiJ1upF2fqqejYTSaIsgrmj4agSmhi8SFvs=
X-Received: by 2002:a05:6902:f85:b0:e57:37d5:e271 with SMTP id
 3f1490d57ef6-e58a4bf76f3mr1899347276.47.1738155910831; Wed, 29 Jan 2025
 05:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-25-peter.maydell@linaro.org>
 <d8d04708-ddc2-476e-9e17-8493f573d7a5@linaro.org>
In-Reply-To: <d8d04708-ddc2-476e-9e17-8493f573d7a5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Jan 2025 13:04:59 +0000
X-Gm-Features: AWEUYZlYfmBFHjlgH3-eArKvibNnb1YlOXjZW0f6_7TVfixUmtuqrHFG-6Gaf0w
Message-ID: <CAFEAcA91VD57mPb4y2bzWnf-p6o6O8Q_9HCdM0HGReddBp8WsA@mail.gmail.com>
Subject: Re: [PATCH 24/76] fpu: allow flushing of output denormals to be after
 rounding
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Sat, 25 Jan 2025 at 16:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/24/25 08:27, Peter Maydell wrote:
> > Currently we handle flushing of output denormals in uncanon_normal
> > always before we deal with rounding.  This works for architectures
> > that detect tininess before rounding, but is usually not the right
> > place when the architecture detects tininess after rounding.  For
> > example, for x86 the SDM states that the MXCSR FTZ control bit causes
> > outputs to be flushed to zero "when it detects a floating-point
> > underflow condition".  This means that we mustn't flush to zero if
> > the input is such that after rounding it is no longer tiny.
> >
> > At least one of our guest architectures does underflow detection
> > after rounding but flushing of denormals before rounding (MIPS MSA);
>
> Whacky, but yes, I see that in the msa docs.

> BTW, I'm not keen on your "detect_*" names, without "float_" prefix like (almost?)
> everything else.

Do you have a suggestion for better naming? Maybe
 set_float_detect_ftz()
 get_float_detect_ftz()
to match set/get_float_detect_tininess()? Though "detect"
isn't quite the right verb, I feel...

And for the enum

typedef enum __attribute__((__packed__)) {
    float_ftz_after_rounding = 0,
    float_ftz_before_rounding = 1,
} FloatFTZDetection;

?

(the detect_tininess functions work on a 'bool tininess_before_rounding'
field in float_status, but I think I prefer the enum here, since
what we're setting doesn't have an obvious "on/off" that a bool
would be the natural representation for, unlike e.g. flush_to_zero.)

thanks
-- PMM

