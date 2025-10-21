Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BA7CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB91O-0005QV-Bl; Tue, 21 Oct 2025 05:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB90t-0004yv-HP
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:50:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB90p-0002Ag-Ug
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:50:42 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-474975af41dso4571815e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 02:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761040237; x=1761645037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mMJX/wH+okVW0st25o6WzIyQncimisroFN+FHTLvLoI=;
 b=Xu4YuM0WxhArduZiBCSBofTNogbQ21MGb/qqHWEVSHXYVPo2gEG72Vhr72s9cmGxxa
 lcsEFfkQBWG9XIfq5Mq1dTFqAOxK6UeLfWgBz8Ft05kMVCsHaGVuBLRjm4lyFRZYudk5
 6WpnlEdfj0hn3Ak0qb0t/EguJGiXK33+uMV9fnRhHBghwnSWNVzEr1P0l+f00FkUZi5m
 yU4GBRRT5neguQOvrRqVyA9jUmlWsT8ulsF4aM3YsFOKI5qGXctbd1EOySI0NjUqvMT1
 GC+7zG8aesKL65i3ngg/DRf6sUazwRAeVN9L4KZQGJnpu2oVAenLJV+bFAlBkwm8sRt2
 nueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761040237; x=1761645037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mMJX/wH+okVW0st25o6WzIyQncimisroFN+FHTLvLoI=;
 b=Q8kkoQGbtiXxGYc0igY1hl35zpA89bxsLX2MAT44R9nWLw7p6BAt+98S5cGJ/6tDYp
 aIKZR4PMXlcVvBG4EHcJ6/Y51GeTdhM+MeeRIZErSBM+Md2XecP8buQlVXpOjf2k9AQc
 EX+vl17cgvDGnHqRfN03x3bELN9bOXkVT7epDY/6rUUiRqdg7H91B2aiOzrp5A8EEPjJ
 NpqTVLRkntoaWnM4myPGAJ92Az474gwOSnVJ7y61g5p3YSLO+hOWcSxKmb2oCFazjeiD
 dd6bedfOctpjatMLQKXXwap5OK1FnzKR2637qrDOfsjURljT8l29JTh+fw2aku6OBxee
 6+LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBg8QOl7OsjJzS7vWbS/RLhMDkN4UtDnStM7/0afYFbDpogdchAjYAef/cyPGa9SVNh98LWBc3gHMp@nongnu.org
X-Gm-Message-State: AOJu0YwfUcjeXKLfDNN687vVQ1KovnQAA8DKxPbiCBotvAmp2MRIW8VZ
 1KI1YAewjEH+ZjcFK24u0BbddgkeTiaTb/yL6e9cLEq365j2OibmfBdeb7wjApORYrYHszjKieK
 GobCgfso=
X-Gm-Gg: ASbGnctHdJLpnub+Q9iCVOv6Eb9uosIRT18uaxbdnV9eDJbXtKFw+faCv2v/geEEVjl
 UX9u8is7FPJoWSdlC3KEreLsPHkSlh9MQrOOkPAucc9OZCDuXI5PPNnurkTvR7Q7+9mlmUyxiWl
 9iaJ9jFKBOLwU9KWfPYI5MDXdaFUatT7e+6QhlRNep8jMu0M3msLuPpKENDLDGdYG2euWt8Lrdf
 wg43F0fbxQjZuz+LKs8ZVmp1PCLvWhupWQubZFMHsSWGIGd3xJzjH1l5ccDg8nZ4dA8JjFh10Lv
 bpfTrYrGfksUD0CiI8T313KWsRRnSQWk8vFF6cvLOCjrW0R2ZJyCRer1MVqQwMPtijBHAbgLDS3
 u/x71OsIDgEl2y2oxyvwqE/hrjhuZ1Fabv0biOzStoc8eZO1w35uGPffErTKo4EcQ3wTyHFOWCK
 BZVfXt9dj9s5yka6/0Tccfk+LGR28RlgEs7/9eQcLgEyAe4jhOi3X9Wg==
X-Google-Smtp-Source: AGHT+IGg1tI+3+XDYpm+9bksDztDbROJGdR4CD8WHoGwTyKzN+GjZkTRh6POc/u+T3S5RJSo/4TQBg==
X-Received: by 2002:a05:600c:310e:b0:471:1645:458d with SMTP id
 5b1f17b1804b1-471179122ccmr108006745e9.20.1761040237512; 
 Tue, 21 Oct 2025 02:50:37 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5d48sm276468865e9.9.2025.10.21.02.50.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 02:50:37 -0700 (PDT)
Message-ID: <4247d2bc-a732-4f97-8b29-df4dcfebb6f7@linaro.org>
Date: Tue, 21 Oct 2025 11:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/43] hw/pcspk: use explicitly the required PIT types
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-5-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021090317.425409-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 21/10/25 11:02, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/timer/i8254.h | 4 ++--
>   hw/audio/pcspk.c         | 2 +-
>   hw/timer/i8254_common.c  | 6 ++----
>   3 files changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


