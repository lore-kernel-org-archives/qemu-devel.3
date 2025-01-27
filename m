Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9F2C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcP6x-0003uj-Ht; Mon, 27 Jan 2025 08:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcP6r-0003qB-2h
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:25:02 -0500
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcP6p-0003NG-6g
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:25:00 -0500
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so7241098276.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737984297; x=1738589097; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMlMZixLUZNUXStYeVlvk6q/O/yYQ8+E2isojwrzrt4=;
 b=SZR2kecY26amNVU3DoQVp9YjLSVsWWX5tZAhIw1a+e0U/QZe+rR+4rDGcVGEK2VJvd
 yin9gyHt4r/L79UDkxS2kHlvyljg/umVdFnIYfEDsgXueO92qhFYTMKx/fBOG6qY1kIV
 kn+CcSALTk68vlF5QSou7HZUZsFeHw6CZUxyW8N8cCi+nsqTfgR+mfATy7acDCfsjA1Y
 qPXcIn/Fp683yxffTFEcLwXnuRaL19E6+0iKwWGiJq6RVtb5MAQSc/smXT9YR7jHRtus
 opQXeWuFAoRSfKnLjtPE3MWtCCDd+fXKnbuIBzSCWs8qdqDNj2xe81luukYjXm1Z03a1
 jSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737984297; x=1738589097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMlMZixLUZNUXStYeVlvk6q/O/yYQ8+E2isojwrzrt4=;
 b=unt/EBw+PgUp9OFBW1alpbKNPrmWSb3vHOrQ/NZ7GZSznLm8SXyy3va6yLOdt9Dena
 UK1BXBxD1rQGyXxsULqPH4LoJs/9DkyLm85vrioQpFHp5Z9sEaLjuJO4KYxzhJ+KkKrC
 uAOm5ERXzU3Q0Hz7IKGexpbk197ObraQnno0rlaSPYxIrsz4QED4V/ERffqugw3rGYbG
 X21HpOKrSk4Q/9PlvyO/1IV42renYKG6D8m6v5Y3S3Pnnnah3Gwv4bs3FTwhvo43oyRx
 r0qhYjHeJeaJOHFQIlF9ycCkX/La9IRKKjkClbaZZdo91EmcOdNfcIpZR6Z44j1yuBJp
 tSXA==
X-Gm-Message-State: AOJu0YzEKKEEmSqU0SPWnwhNrMQkV/6X3eYdrsdnAmVlC6evFMg/HfTz
 PEEKVWGWOgS5Ar1m26KiGZQzzLkAore1/10DorCzMiwoPIN86fv+PlR3HxjbiZc/sahqc3Vj6Iw
 8EUP6vjS8D25kUXv6ornCqtDroyLzlcXv7jBzVmpG5x5Ggvz8
X-Gm-Gg: ASbGnctmZ5OG6ogUr7r51/JG1hKkIiGGEshzoRLpgN6sBCWIoHp+Ljm/G0v4kUp6Jrj
 gNVFb4tcDowCHotoQKa60V1NyiB8j7gvExpDzlDGqbsRCq+acS0OmAR5p+0O05GzsfIjy+HEAaQ
 ==
X-Google-Smtp-Source: AGHT+IEZrhAQkatJRrQI7wyX0PhtVn+oW+ZFoac06CLXu/hgg0BO5SUf6UMsVhUz19juz1MM9+RhbQdJ2qu0AIJ78Vc=
X-Received: by 2002:a05:6902:1791:b0:e54:a2e1:9aaf with SMTP id
 3f1490d57ef6-e57b105aff9mr29361442276.18.1737984297608; Mon, 27 Jan 2025
 05:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20250111183711.2338-1-shentey@gmail.com>
 <20250111183711.2338-7-shentey@gmail.com>
In-Reply-To: <20250111183711.2338-7-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 13:24:46 +0000
X-Gm-Features: AWEUYZkHKCt9owcbMBbChf8bAJS-sYXZh8H3fLQsLixpY4PZL9vDJpS3xsEa0N0
Message-ID: <CAFEAcA_m29rWYQPtz=xSBsS_FXb5_L6+DGBA2o_TrLcFy6YC3g@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] hw/sd/sd: Remove legacy sd_set_cb() in favor of
 GPIOs
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 11 Jan 2025 at 18:37, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Commit ce5dd27534b0 "hw/sd: Remove omap2_mmc device" removed the last use=
r of
> sd_set_cb(). Rework this functionality into GPIOs.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

What is this for? We have a non-legacy API for "the SD controller
needs to know when the SD card is inserted or the readonly
status changes", which is that the controller implements the
SDBasClass set_inserted and set_readonly methods. (See the pl011
for an example.)

I would prefer it if we used that consistently, rather than having
two mechanisms, one using GPIO lines and one using class methods.
I think we should delete the sd_set_cb() API and handling code
entirely.

thanks
-- PMM

