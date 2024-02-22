Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397C2C54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 16:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCNf-0004U1-DW; Thu, 22 Feb 2024 11:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdCNd-0004PI-0a
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:57:05 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdCNb-0005R6-IW
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:57:04 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-563c595f968so2905487a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 08:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708621022; x=1709225822; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SEVNk6M0QlKdkG6bKeJ4g5smHGSMYbyjbGMbu2zztno=;
 b=umcK7io8mN3d0F3Nnnlrygo1NP0oJvhfTlC7aeAn1aAqsD63Sj8Kh2VcvRrUlHuaVi
 nSm6nMNcdCjN3urt9IUFMdhIztfOctxkbjjN6lVCK86IgIN3DjvXwvQxK0i4Zsl1JBL+
 41k42VDfViC8Ky0e6kmPvFomg43EA/FkYHNPJo4ePUQMPOokgg/St5Y0eUfd1MTnmUKN
 l0YIK9NEPj9iGDHrkMMma77Q0sXlF75yT3N/OpXr8YvA/fjZQgkGFa5j6hw+4WVqD/9C
 83hu/C6iYW6PR4VcOMyNl62qyzXC12+TIesfj8qyu6tAFOwizQ/U7BxzNQnN4gMRfrf4
 65iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708621022; x=1709225822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SEVNk6M0QlKdkG6bKeJ4g5smHGSMYbyjbGMbu2zztno=;
 b=ei7/489nnMbVhrhnGRlZr30ASmUxsLYncjEbDe8OKoZifKcs/xJGIoF+PwBD0Cy6Id
 /hzyHJU6MHMosjkl4smkxNClProBbg3Nkxn5qoHjoTKenGKlYMGm/12La5W4oclKNPIP
 6b6EaLTr+9W9FyUPTuUUBLgrMIRxiES+wNxnU7iYUVCVpYj30gSBtDwm8TibPyNwnIIh
 8tjp01nyelOb0tIKwABCMBVpb3qcyeqGQlkZRwTqgh7NUusAM6KseuHTN+DB2QJ+81Cr
 5t2IKHx6bHfms14Buh2yTTw6kaY/euw2CgNdl7pBfc/GNAJg85q5oAVVdueVMe61jt9n
 vPmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5IaMRw3NLzs4CE8saE0MPQrvc+Ph62WuaApk/rRa/QYa+knBZNtIHR7zm556YVRin5rgUNsB6/HqfxYA5j4RDUD829sE=
X-Gm-Message-State: AOJu0YyorrX3MICg1sjiAe35eB9ucCb88DFSIw5UDfzHlByj6BrkJImA
 Xf/XZWR6UBrPy0cb8R70keJ5Ar7q+PuCrGLqiR9tgEOZDgnD2p+JSlrRL0AIxv1S2cgan40QoWt
 me446PWV/Fmu7ibh8fqUG/YSho4HN7pGVovBkqA==
X-Google-Smtp-Source: AGHT+IHmsVm2rtLQ+DqejHxIBzGFcUElDLCPoX4wLyGpARpUpvCSWgr+cLq+Zsuv+xKi9zBv6WJOo0tGX9OcsQWi7ks=
X-Received: by 2002:a50:fc02:0:b0:564:5973:56f2 with SMTP id
 i2-20020a50fc02000000b00564597356f2mr8714584edr.7.1708621022002; Thu, 22 Feb
 2024 08:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
 <20240217-cocoa-v11-3-0a17a7e534d4@daynix.com>
In-Reply-To: <20240217-cocoa-v11-3-0a17a7e534d4@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 16:56:51 +0000
Message-ID: <CAFEAcA-P_kX_wM9VxTCLgOPp-Sw4VmvUJzC3ZyYrEgppUAqXow@mail.gmail.com>
Subject: Re: [PATCH v11 3/6] ui/cocoa: Let the platform toggle fullscreen
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sat, 17 Feb 2024 at 11:19, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> It allows making the window full screen by clicking full screen button
> provided by the platform (the left-top green button) and save some code.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  ui/cocoa.m | 423 ++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 207 insertions(+), 216 deletions(-)

This is a big patch and I'm having difficulty figuring out what
it's doing. Is it possible to split it up a bit?

thanks
-- PMM

