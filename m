Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC0FCD8C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 10:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWAfK-0006Yl-0y; Sun, 07 Jun 2026 06:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wWAfI-0006Yc-6e
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 06:23:36 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wWAfG-0007k3-De
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 06:23:35 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45ef372c58aso1811712f8f.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2026 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780827812; x=1781432612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hc8mCq5/6auKFII+6P3fHnTH6SJMLoD83Uvbj0vKy7c=;
 b=Sm+j7RPnHiIP6JOL7xq6LrSYHEVFyKPL7lF7idYPMUguPfVx0O30hpIvfzkqIbCzYK
 C49dKcN3kKgfxiTYsMGzHuqWvBMJ6YEcCZSf0XWjjSfRoKtY6C5NGreqTC0wJxkpuJkz
 iuzsMjcGZMlpJgAbcFAHxY8GW7rR4rp6JdoIDYs3pgyMChkudbY7ugjLMHOU0v5uoHbU
 5+4oun0Z1ew1VD7tTC6N4VYkMntNRCygHA2FkTSkkdWm0807Q7SrNVyhEmNPDC2P6GuQ
 ETFalDcHX0g9VR+z8upXhbRyxbhf0EK0ha53jm+ULR/r4CZ0y6yNllBaSCTR9tSvaLG4
 x7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780827812; x=1781432612;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hc8mCq5/6auKFII+6P3fHnTH6SJMLoD83Uvbj0vKy7c=;
 b=N+OmVnWFGw10R8Jfb03rUuwh5DeqoyCTmYvG/1SHmOH/WqPWYDmGf9tptrdrlheg+0
 4r7aviW5sw8nJbxPLN3AcUsGqkEo1Zpv7iwJvwCYchpNLQWQMrWZDilTnpdyzLITkqpe
 Y/mixOo+kn8D2zRLADEQ4AE3OxBaqf0Eb0xtXvDlUnbBsFU7HwOStQHLUQ5V5N4f1KL6
 8lMPePfvvzntDOHuITIoZFFduQwx6sV98YkP5fs9wMErF1uZ2Is5a82hNMEz8vwOCFZ8
 oG6cWEgoMikt3r5+9LlMzh76VOZvEbowV4StogPZJmL/6xcMgBZx/CIfqWL63wnoxFj2
 nQNA==
X-Gm-Message-State: AOJu0YyeXguZzmE7pqt9I9U0/aU+/WePQ7oW+ppqD4fhG2X12vitIS+G
 Bt+KiKEs3cNgPJm46/XfzJ+6iab4S8143q1TO7C/+yOj/R2EykHg+QPhuvZO2AjTYB0=
X-Gm-Gg: Acq92OGTstaT6uXXjuW470m4kQj23IqYo0y2zEdu8Edv1GlwiaXMIWXr23dyh406PMW
 sXkaVhhOPUv3uCvSSlzhQ4cAGCC4OW6R24635ltwF8znU9n3juUvA1naSo3DjQ+x4RGzIUs9nL9
 HxKmiY7hxjsLa3LPvU+SmCbWxnkgohjIYEsNV3C4mzncFqYPTt/4mEhsKRaU0ttqvrer0NeBFMN
 lU8rKVZDFdZEzJjBAL2inKEogKaganIbOVteTevaooLXhid7D5wrCsXpfCEn5fCmSoPd4qGhJoa
 SMO7STyerAAxs0IBN3p4QjN64gVlXrF5zoXZbll4YUVb1JNcGNMIvXz28z1d2pqZEuBod0vJ+ZI
 lQZYXfE9GcLo2KrwNWizPOeM/V2deleuQwUZvx2xcE8moVyc3LY7d2z/DTkotBntZpsubCd3rUp
 izFSVg89WE/Ksl2jkLx3FvicxQbZ8NXsGsIQ==
X-Received: by 2002:adf:e608:0:b0:44a:2cb3:b633 with SMTP id
 ffacd0b85a97d-460304fae53mr12462507f8f.12.1780827812007; 
 Sun, 07 Jun 2026 03:23:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f34413csm41454653f8f.21.2026.06.07.03.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 03:23:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0D2855F7C7;
 Sun, 07 Jun 2026 11:23:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Jason
 Wang <jasowang@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,  Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/5] docs: update mention to ubuntu2204
In-Reply-To: <20260604215148.3769627-4-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Thu, 4 Jun 2026 14:51:45 -0700")
References: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
 <20260604215148.3769627-4-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Sun, 07 Jun 2026 11:23:29 +0100
Message-ID: <87zf16vece.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  docs/devel/testing/main.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index 3408b5836dc..1a884da3eb6 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -711,13 +711,13 @@ https://github.com/google/sanitizers/wiki/ThreadSan=
itizerCppManual
>=20=20
>  Thread Sanitizer in Docker
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
> -TSan is currently supported in the ubuntu2204 docker.
> +TSan is currently supported in the ubuntu2404 docker.

It's actually a build dependency (or should be, I can see libasan but
I'm not sure where libtsan comes from) .

>=20=20
>  The test-tsan test will build using TSan and then run make check.
>=20=20
>  .. code::
>=20=20
> -  make docker-test-tsan@ubuntu2204
> +  make docker-test-tsan@ubuntu2404
>

So we should say any host build container will do.

>  TSan warnings under docker are placed in files located at build/tsan/.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

