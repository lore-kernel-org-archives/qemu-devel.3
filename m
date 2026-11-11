Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E16606D73B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WRZW23nz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRCpn-0006eV-4f; Wed, 11 Nov 2026 13:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kmehltretter@gmail.com>)
 id 1xRCfI-0007pm-I2
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 13:03:20 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kmehltretter@gmail.com>)
 id 1xRCfG-0000My-M8
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 13:03:20 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so605625e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 10:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794420197; x=1795024997; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tgKWHNhio8mHO1eN3LpgCA5pobvY69HgJjC9S5SPFiw=;
 b=WRZW23nzE0Exb6mkedhM2uPcpT/tsK96JRxLhSfVWn70Px/MGGkaUYbE+MrHHbfi5a
 YbMhhBCzRObKzbbRRj2hVAoNHrH4abwDDqPy2y119f+RUxGy9EjGl2zlw85g/DcO3oXn
 jGb9/HATlRvMF+t7YjZpuo8CqcjPqvHREL6puGTky+ZpOA+EoV52HAuJ+HkLkLEPn4B4
 mf4cy9OaL+cT1fwf9AuzMGNNNY5MQtKXaNI4nfRlQeNpChVhXqrNZ5z1hL4NiBsJgFDY
 tA8Ag8JDC74e+Z3KYZRsQOnZBQBOfoTC9fmO3lYV13RMtVk5CSgsHd6UyqXLm8jqga1v
 5NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794420197; x=1795024997;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tgKWHNhio8mHO1eN3LpgCA5pobvY69HgJjC9S5SPFiw=;
 b=K4XD2iPWbRv0F2fLv1pVGY1iXgKJjdUUxbk1vNQQ3v8O4doaUx9WBkftD24qqE2kbp
 34Wu+Ryi/4M3nQNWcLXU7urJG/xehdyJuIPAK0OwN/bz8vKTyP+24Ii359cB1yAH2RtZ
 Y+XEBUFtmUQQyFGAgV+Mdzcf3aETJQkwqk0RRYeG3+9EqNO45dUHqpYzERz+7IajFye3
 J7UsLTCkHjAeDRj/ayCvwcoYVD/sZiHyun/5Awe3hOuL7S1S5AnKUo8NCX2vHp3VAfdK
 2uj7ewGUXQx/YleG1XkqPm2LaCJFa9bFUryaUBSzEO5jCZv6x6zS/YGl+aAFvYLo5/q2
 1D+w==
X-Forwarded-Encrypted: i=1;
 AL+hErETh6Xazsz508lX/Uo8pSQvMQZ7SwyWbtOekMxQ3wyBkTTYkvHIEh3zVNt9RHK4/mJnQCYw8KKB5Ase@nongnu.org
X-Gm-Message-State: APuU4Z9nfmSneJR2uBORR69E7CdGCyad6GwV6afHPv97unRyoNE+bxKL
 AWw6UTJVZ5pbUxdu2Oh7M4Mt5bgShSmZvdpeHkouVoVxyQRas3CEAJjv
X-Gm-Gg: AYBFou13RblfuKmODI6iGnOYUKHossKP0dA9MbEvE6d37I4GfudX7qrAad63lx3OFhF
 2a80EAh9DQ/jMF5gOJATWyuqW1+5JzwNZQQGeEKT20keMGRoBB83WT8ml4CK5HeIULWA+sv21U9
 hKc0Kt/MhsPcmhGAgrnjw7rsGbyN15Q0FNauU8/6Nq9XRGzVR2FMJLGXz3xhZw3iO+hNBW0Vull
 5RBX+QyYC0Vvz9ZO8OiLPIc12OFhDBy7+9tNzglTs7a65IWw0p74z7WkB6f08beFzUEONalI8kf
 8YcZ/MtL0Yr6AHPYfZyEOqUk20cVysRQ1+y8XnTJZ/kEfUuk9FWIVPAeU1dBVr8bTRdJUl0jAEJ
 2ROJtlJzvb0FTF00Pv93EsjzthMe6L+LHYp6Op8IhOl50SoJWKgz3Kp+ZT5MNrWdusNfCm79ECs
 bvP+zedb4R/ydYJzw0dqEwU4tSJu9u7hiZQ4MIZmV/wj5dOTHYQRhWEjLC1xPyxBe182Gdrrv1F
 76LTflfewLIBYD88N1JI80mHlS76S2QPInYvNBp1ALEHwHFipQmk+chQLqTDvTsJqPW6YjrV8vX
 4DJjfTipMOsxuR282wXVbZB6Prw+i6JsvNfFHBN6Ye5PilMZGFog4/c1sOq5Ha9OXmOlhq5V52M
 5h6HFPCr6MRqpdwtrAMNZWD5UMBvCq7uQnrB35PtaRyl1aI0FbRIQ/Ap9fePZOKPzdZUrDwSt/2
 aQAQljEXGs0yXkUJYUk2ZYQ2mc0pXOro9eUlpJOFkkUvmwYvv+8k1i
X-Received: by 2002:a05:600c:4eca:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4bb4e28456amr4833635e9.10.1794420196468; 
 Wed, 11 Nov 2026 10:03:16 -0800 (PST)
Received: from MacBook-Pro-von-Karl.localdomain
 (dynamic-2a02-3100-a181-4b01-25fa-1a8a-4f45-ba49.310.pool.telefonica.de.
 [2a02:3100:a181:4b01:25fa:1a8a:4f45:ba49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e28c882sm5388115e9.6.2026.11.11.10.03.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Nov 2026 10:03:15 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] ui/dbus: validate clipboard selection in Release
 handler
Date: Wed, 11 Nov 2026 19:03:01 +0100
Message-Id: <20261111180301.2388-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261019131143.2555126-2-marcandre.lureau@redhat.com>
References: <20261019131143.2555126-2-marcandre.lureau@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=kmehltretter@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:14:09 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 at 17:11, marcandre.lureau@redhat.com wrote:
> The clipboard "Release" D-Bus method handler passes the caller provided
> selection to qemu_clipboard_peer_release() without any bounds check,
> unlike the "Grab" and "Request" handlers.
>
> An out-of-range selection reaches qemu_clipboard_info(), which asserts
> selection < QEMU_CLIPBOARD_SELECTION__COUNT and aborts QEMU.
>
> Reject invalid selections with an error, following the same pattern as
> the other clipboard handlers.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4717
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

With this patch, Release(3) from the reproducer in the issue returns an
error and QEMU keeps running. Tested on an x86_64 host with
qemu-system-x86_64 -machine q35,accel=tcg -display dbus,gl=off.

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>

Karl

