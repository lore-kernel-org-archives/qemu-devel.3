Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93F5C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 14:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treLY-0007Wy-ON; Mon, 10 Mar 2025 10:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1treLX-0007Wc-67
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:43:11 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1treLV-0002Wp-BJ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:43:10 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so3528733276.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741617788; x=1742222588; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AK4GAtrIkICur9775qYB5WW7gfZBTN0oWrIaeShpZNI=;
 b=YOAXxdKNa36ntGqWrY5qwuHeaTn9xDT/fypAg2fgTMHttBirHCO9IgJ5EggxhSPTgA
 D7elpxcA8nwc5ARjPRVzwHjYgSc0I0oLa80LXG+2d5J6N95n7dg+RKRl8KrxRduUvw0u
 N2J+yUr5HG+8N+ZiDgM9U6W0EPEWp/AZ/QPUF/VKW2RPmsqOMad5G4ISyaXQsBo1vNt6
 xPTF6wUT8ErEG5/eu4xM8PqEB0xPqnofcRzCSi6dVh/YO8UVQx92fRKvIUxe76dIsoYd
 VvDJQrmbCgUqImB0fcfoOUlhqjlgxI7uczPdhotSCUNuaC3PahdlU0Lm3PAJDVVLw9yJ
 +xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741617788; x=1742222588;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AK4GAtrIkICur9775qYB5WW7gfZBTN0oWrIaeShpZNI=;
 b=ue5AwUvM+db3MJwBSw8oLu9M6dB8ZmPXD71rcSszvaL5wnJp15JOsagrckkZMSU8N+
 GSWj2glmdmyXE6WEHI1gQJWSh6ckR8YfSZvInsvFaUJXycRA9M1co516fKpVwUXZOkEu
 VCz2/yvudBN6WrjQmgS7/dfdYk/+bdANUPEweugN/JNSU7SBco/lqRvWMgp+9R68OvVW
 XaZ53lPP9GJ4qwX1Yv/IjSInX+pYxe6sTN4EM+OkLI77ffznxfQKAIS2RQKLpOdiVKxK
 mk1lyp4NLAnTDdIX3WKKY63wTNaJcMq9uMrzhbhoI8dFVQe72uIAILVK/gI9FMMFHMXf
 MtHg==
X-Gm-Message-State: AOJu0Ywrnvukg3nVzVA68v6s9q2Tti+6VyOm5Lsllq7+XAdsp+37fE9Y
 UgZ0gBqZuspgonbNZl41GT12GpKIbKAFAvu9eWnXVRvD3IuVkqZ71YeqkH+VYCf3S2/M6EY9kje
 52pvoPe05SnsvztUi6Hrt74jYzchLQmojMKi4aA==
X-Gm-Gg: ASbGncueirE0+crQ/K1eriCSMjPvx64yukc9R1ceSJGXaO4tkMV3aZVvQQ4hh17WTB7
 1m7EHVvD7aoEQHEoa+1M09eZclIGaqjOqa5xGjBnxHm72ygY0sB+mRcBs3dXIA0vtdVSiMJm/0Z
 gG5cVLYruMm2wBMhixr3mQ86/ZsGo=
X-Google-Smtp-Source: AGHT+IHY7zT8K9MZdjKo3TYvRYnCH8XHMqyqLke+H1jbGAUdZ4kJg+oNGaEOL2T4GPyc4bE1nhTEn14wyRhxyDMXRNQ=
X-Received: by 2002:a05:6902:320c:b0:e5a:b05e:4da8 with SMTP id
 3f1490d57ef6-e635c1ec1fbmr16504436276.42.1741617787810; Mon, 10 Mar 2025
 07:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250310012825.79614-1-philmd@linaro.org>
In-Reply-To: <20250310012825.79614-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Mar 2025 14:42:56 +0000
X-Gm-Features: AQ5f1Jo09qEstp32yf_C1bFj3a84fYZNtSzWFtDVSb6pKdObc6b5Ugwzd67mpI0
Message-ID: <CAFEAcA_fRWgntwbiFiDJqAkthR8vBzrkLOLkp5GeHD9O8xTMCA@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Mon, 10 Mar 2025 at 01:28, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi,
>
> This series add support for (async) FIFO on the transmit path
> of the PL011 UART.

This hasn't made the last pre-softfreeze arm pullreq, but
I think we can reasonably call "don't do blocking I/O"
enough of a bugfix for it to be ok to go in early in the
freeze cycle for rc0.

I've applied it to target-arm.next.

thanks
-- PMM

