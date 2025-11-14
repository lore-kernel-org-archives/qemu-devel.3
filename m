Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B527CE8D53
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 16:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJwtS-0003Nl-EQ; Fri, 14 Nov 2025 11:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJwtP-0003ML-Vx
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 11:43:24 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJwtN-0007np-IS
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 11:43:23 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so24478765e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 08:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763138598; x=1763743398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iO+BNlBT9P+e+qmdEE0iGw+yBdKFzfcLrai8JYuyG5k=;
 b=chXTiQ+Jqw4YRABsMNzCzkybAq1qJUfxIkvYq+xvaJ8Ixfj8YvMDZYu48gaGEpYPMr
 HuvkZvuAirfyV+KbKvWi4lGM1zBYzyo64NmQ3Mw9ca1OfSdyNmP3lqhef/EL5jC6gpB+
 So8aBKWHjvpLQM2ySnhikx5p5emEX/BTJRklUj9Xwxo964wm48d9kO1sqDUiXIX4EZM8
 F9pWukFtTGUOQZy/x40tNzTx0MtdVlnN44m0Tii690sE3nDrlNo5b36txBmOUnobw0ST
 o5LTi6YETMYkszoOOzhQohU0nvQl+kXJdbqv+RdgjlZH4eItHxpNamUHTao6JiS9n+Jy
 qbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763138598; x=1763743398;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iO+BNlBT9P+e+qmdEE0iGw+yBdKFzfcLrai8JYuyG5k=;
 b=iBCJQHSMKjRA2lH4XzqY9+V7nG5rd61sQm4W3c09j3h+6nyHi8MPhYZqnZnJrjt7BL
 lmEOEmMAQJ1KrrdbWI8i14YTYokRONmL0+0ybiGIFUZRBwzy7dbz4ffb5L8qWcUHZPKM
 JrV0rTvmUV1nqtlf82/yrfYO0dGPhmRWc8h6bHd8BuCAa+Kvt0UGyHTRFDT0VDpjFjc1
 tnfd6SFQzZw1rEOLdGcvRYDa065nP7hGdQDhLrhUnbuxt0fdFu/xVC7wMUm20DyD2UCV
 Jc4Na5AxIxojD5MHEHF03E39wmW6ha9W3Dcwabadx6dHTRGnI8t2dBppPK8TJBxG7iOX
 vcnA==
X-Gm-Message-State: AOJu0YxSyd4Y2pEV9EjfdvKa8CHNUuWyrwp8bkk6hZ1A94U01CPB95ky
 c4Apcc90LI5uluCyaRu8sC3W1p5B8ldIUIZNPHQlUhyfKorxHVXI2Lt8zPG464PXAeO8TX+WzWc
 kc9gr
X-Gm-Gg: ASbGncv6lbl8IJPv1KicQ8y1JadELT6/bcTefjfzC6yxmt2k7gioN53kdJOHhFjqbgr
 yNtOzuOsWd23qtOq/TCBJVv2usvSV1R3jbnBABqeV3bEa+zeGdo19JV08t6j3JBM60sAzPKMHP6
 HxyUOJlFZRqJIrZAEILPzOEWQKbRzUMkLj0HE3u1GN3a3RVaBzoGGbBA9YYKO208t01+dFSjcrc
 WbL55mswMeNlSolR8SC69RLHclY/vQh9HQPNSdfhskwIqW8xwvNZzGFpHjy2qJ5By2DfCjeerHv
 vBY2KikbQFvybvkpZyZjSE653LAvB5VdSzby/h0SX2NJ3b/pGDo2fjnEFUeTH0xKVpD5GCuNYxu
 0p9QS9J0qhRQjFwt9S8cpbqxKPr3ZKuXspMWFAzd9vEeM0+xRnmyK/6cybPri1VlH35sN6wJRNx
 w4c+sM1sbB+uw=
X-Google-Smtp-Source: AGHT+IGG9QdTnS5vnw7tJUl9nt/ml0xyeXeaMawIbJ6yhYc/iMpBL9ivAgKK07GMtEktdBVIWH8g0A==
X-Received: by 2002:a05:600c:4594:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-4778fe9a707mr34417485e9.22.1763138598483; 
 Fri, 14 Nov 2025 08:43:18 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bd2fa91sm47432115e9.17.2025.11.14.08.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 08:43:17 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F09705F820;
 Fri, 14 Nov 2025 16:43:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Fabiano Rosas
 <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "open list:Raspberry Pi" <qemu-arm@nongnu.org>,
 Florian Meier <florian.meier@koalo.de>, Florian Fainelli
 <florian.fainelli@broadcom.com>
Subject: Re: [RFC PATCH] hw/dma: don't allow weird transfer lengths for bcm2835
In-Reply-To: <4d6d7e9d-0952-4158-9ef4-6093a16e9dd9@yodel.dev> (Yodel Eldar's
 message of "Fri, 14 Nov 2025 10:05:58 -0600")
References: <20251111105429.3993300-1-alex.bennee@linaro.org>
 <4d6d7e9d-0952-4158-9ef4-6093a16e9dd9@yodel.dev>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Fri, 14 Nov 2025 16:43:16 +0000
Message-ID: <87wm3so997.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Yodel Eldar <yodel.eldar@yodel.dev> writes:

(add Florians to CC)

> On 11/11/2025 04:54, Alex Benn=C3=A9e wrote:
>> The datasheet doesn't explicitly say that TXFR_LEN has to be word
>> aligned but the fact there is a DMA_D_WIDTH flag to select between 32
>> bit and 128 bit strongly implies that is how it works. The downstream
>
> At the bottom of page 38, the datasheet [1] states "the DMA can deal
> with byte aligned transfers and will minimise bus traffic by buffering
> and packing misaligned accesses."
>
> IIUC, the *_WIDTH info fields are implied as maxima.
>
> [1] https://datasheets.raspberrypi.com/bcm2835/bcm2835-peripherals.pdf

That reads ambiguously - you could start a misaligned n*WIDTH transfer
and the hardware will write bytes until aligned?

If it does indeed work with byte accesses maybe we can just do:

  if (xlen & 0x3) {
    .. do one byte ..
    xlen -=3D 1;
  } else {
    .. existing 32 bit code ..
  }

but I guess we need to handle unaligned accesses as well.

Florian,

Can you help clarify what the datasheet means here?

Thanks,

<snip>

>> rpi kernel also goes to efforts to not write sub-4 byte lengths so
>> lets:

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

