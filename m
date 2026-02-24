Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB15F4BB65
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwQ6-0000aX-Aa; Tue, 24 Feb 2026 12:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuwQ4-0000aM-TW
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:42:00 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuwQ2-0004gk-IT
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:42:00 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8fbb24a9a9so8131666b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771954916; x=1772559716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c73tMjZaLaW0cvtYDRwIEKRne7mCeOyd8ZOQSJHGn2U=;
 b=BNV6QS+kqQB0oleP0/OGFddFyN90RKBOom9aL3W7YUBA9UNLac+4hQGZurc1pvqCIQ
 dQlmIA+byto+/ZARe1eKqXbRH0g4TYtv2XZfMdozd3TkWXXLsowjkwqWH6I54k+7eK6Q
 u8btjT28+NceSBIvSGikEOs04k/zOFW5tGzHCf8aAqIeQ4eFtZOcUfiB7a04ITFKwabp
 eMuOe6o0MM1vBVn8R9ZoIQyT0lgv8Td+VNeEK9OWL3JpNqOTESLuAPjnXFgsTiHa6dB1
 2ISq75euEGD+3MHNexBFuAupogWGFxwupB7yuS3bVoRvHPN0PGpdNcAzuo7b7M4vvFJ2
 dCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771954916; x=1772559716;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c73tMjZaLaW0cvtYDRwIEKRne7mCeOyd8ZOQSJHGn2U=;
 b=COUY4xDbml5b0KEl9IGBOmqRfg/vfVLSQJlfO7mtVosgWAUtZSuu9rUwlmP0i9WXO/
 XtWhQ72ZxdtITpQthTkat4YQydn6wUzZKlXwJzOESJi0pN2cls4UCSEyIT8AAWpYVQmB
 ufVIYZwYjk62SnWir6//djrozSvHoVw7KxXOm2uCEgetp98AsrJwe84bfcZeREJ9oT5V
 o+xe+J4COg0RqKQDii4ZLD211DUcWFtXNpr6Ea6SKmjohcZaT13lqbgaDIL89hB7bsBm
 xZfrgERuWJwcpwwaq1Fvy0tAxSJtQqTUTPc6IpgGwmzqVXT1YBkfi7UGCmvTmDJkjEjG
 oH/Q==
X-Gm-Message-State: AOJu0YxOfgWVU62fz9xWwu1a9rPvvZlfclNYRxU6/vSZuKrEIg5djYYA
 VWdpFZ7pShb6TZjZ5Rc2mcbHltJpS0H9DiZz2e6DrV+5WV2ANDD4p4W/u2rA7DxL+8M=
X-Gm-Gg: ATEYQzy7//Fvjr+YLQsGnfjYzG89TuQRAbNUawQT4n+QXzvY73SceX33Lf6MjH9yeEI
 trOcX/fTwT5k7vbeJYYS7p/BYGmFUK8UB7OypGc4UxUnDhvDkeNeqtWco9a/q6+A3OogmjKV4er
 ab2CiXBPaxBHYBk/4T43BIlpaCA6gFWGeCYmpBEsG5+4orx88/vxM5LzyaJ6bTl8QtCLPGDxZkF
 sTSLtlMnCk8V4j+n63B/22OoH6P8zWv1//lh21qCKKDSBGpQ1stvg+99VDTkMbvaDrxfVGvP4FK
 3ZPrItdZi+KkLcBrejXwKdTyf3j1KjeOw9YFv+pPS7k0hMgA1jg7+4GjdOHMrA0EEsH4MTXfky2
 U917rxUwFkxRSO0+VO5DNRi72B5c/YPTTBW6IGk6ZOFCxqHo4Jg80qC/LvGyMLMR+tiJKFkma54
 UXlWf5rZv2Qhywxsx7hjTqm50=
X-Received: by 2002:a17:906:9fc8:b0:b8e:7e21:133e with SMTP id
 a640c23a62f3a-b933cd86d28mr39275566b.27.1771954916509; 
 Tue, 24 Feb 2026 09:41:56 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084f191b9sm430466966b.67.2026.02.24.09.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 09:41:55 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0621A5F7B4;
 Tue, 24 Feb 2026 17:41:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [PATCH v4 1/7] plugins: add flag to specify whether PC is rw
In-Reply-To: <8dad9153-1e97-4087-a243-3e40cee83572@epfl.ch> (Florian
 Hofhammer's message of "Tue, 24 Feb 2026 16:48:24 +0100")
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <8dad9153-1e97-4087-a243-3e40cee83572@epfl.ch>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Tue, 24 Feb 2026 17:41:54 +0000
Message-ID: <87342q3uot.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> In addition to the flags specifying whether general-purpose registers
> are read-write (rw) during a plugin callback, we add an additional flag
> explicitly stating whether the PC is writable. This is in preparation of
> a patch that allows to explicitly set the PC to divert control flow from
> within a plugin callback, which is currently not possible.
>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

