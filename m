Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D57DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we5UW-0006QK-Ou; Mon, 29 Jun 2026 02:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1we5UP-0006Q2-AF
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 02:29:05 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1we5UO-0007BI-00
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 02:29:05 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-139f71a5201so399849c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 23:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782714542; x=1783319342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uO2haJur9yzLtnRg8mjMnWsOUoDCKHXBtNwk9hxctjI=;
 b=IuyKCqwPfKorQuFpMaLu3foVVNMuqpLvwFoLtbMKb5TmmswQiSVHqAtiNYrt5alQZ7
 LVgMJNu/1xHHw/iAILvTwgsL++t+5zZxaMA0tP21E6TqV7i86FMpRkFf2r1PfmIAL6gp
 oFpuo7hZ5uqF9TWQk1bSSwSj0JtyQsoNLRjzL9QEXKVHd9WRrN3qLAEWOzfxYP6YWHIj
 E0iH+GMD3ZU9ireLyLCvq3IVye7KBzpMd2fBH45qAulUvmCW+cIj24IsX0/p6ZuoThZ1
 lvThQuLMQYcihBmN/El1gAFppwVkPtMeowGUFFbtPRT9bccPKqykU5m5gV2LaDoqC9DD
 B9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782714542; x=1783319342;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uO2haJur9yzLtnRg8mjMnWsOUoDCKHXBtNwk9hxctjI=;
 b=YC5Boy0R+oe3LW4TpbwkOzDeU5aDGwHWCpdz/JTUqssUan8m4CpC9ZbUmRXilkc7hx
 0BQhF0hlWPZfKvPjbw7zwecLUjKpagn0imlRdzv5shGfWIb1g+nVdENKLKF/10pGH2sI
 af8D6TaHiYggnFA0DO6Uv/bFTiLej604SwzXn1cvz3l7vE9dmj3GVIzEAvOeC57QAmax
 CHknhj7SbQHtyXX/dyNeX9k/QtjkPMz0hhI3mtjvUkbOxNtlNdG4V3sZ/HFjXjYizVNN
 b3CrjfMe0oV+vGBFq3EG/Yxnk1AbuMvmkGGy8j88gaikflzhpX4KtQwKZEy7vyo7FaW/
 mMTQ==
X-Gm-Message-State: AOJu0YxpQAf6VrzWacUzRlDaTh/QxfZyQVTbYaN+KoFjMaa05UYyULhr
 viSiryAU25X7+yN4j0/JUTg/E9WKnanBsVSqWAX1N3YtTem+g+N3P0ZFdzp2jdLo
X-Gm-Gg: AfdE7ck1RoQoa4xYypTpwRJFOS2shm/3oQzteqL4Y+K7K0qHwsR8tNtKjHhnHEPPsl9
 KFTrQm+KOKSTUbzq1Rq7GcMDhVtEw804cIiq8chS6Cf42eHRDAKI4ZCc/BIEA2wWgECWKtUYA/Q
 8cI02ZgMuCXQIBw9pViClo3JmPqK9tfl3OUKed2yD0dttvWTOQbl3y/0Leu5TmDAMm2F8NlVS4G
 M+0WyDd0m3E00K/aeX5eb0k1vu9/s5W99WKsg5Tt1BmrdYML2HlrdTNh+9prcFdupQLFRJvtANM
 DI57tZI6S9aWQ3j350Tb0N4FoVAk/x73BSjHM6/bj0Z8zWBW4u1kvcU8VCYQ2STknvpjRzDVZsZ
 su/ZbSOx9dnrj+1SPFeSdY8AGZhojRQnXbfvwJ/Z3qlji4v9rq9NpNoeQFMB9lL/eLLo48GWdrt
 5RezAwRPMTBJAhnq3uSKzRdZRFYA==
X-Received: by 2002:a05:7022:6b91:b0:138:4952:5f8e with SMTP id
 a92af1059eb24-139db94aba3mr13905649c88.3.1782714541828; 
 Sun, 28 Jun 2026 23:29:01 -0700 (PDT)
Received: from ehlo.thunderbird.net ([46.42.179.137])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f318f3sm45749575c88.2.2026.06.28.23.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 23:29:01 -0700 (PDT)
Date: Mon, 29 Jun 2026 06:28:53 +0000
From: Andrey Polivoda <apolivodaa433@gmail.com>
To: qemu-devel@nongnu.org
CC: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_target/i386=3A_a?=
 =?US-ASCII?Q?llow_transition_to_virtual-?=
 =?US-ASCII?Q?8086_mode_only_if_CPL_=3D=3D_0_and_CPU_is_not_in_long_mode?=
In-Reply-To: <20260622082119.11903-1-apolivodaa433@gmail.com>
References: <20260622082119.11903-1-apolivodaa433@gmail.com>
Message-ID: <E7710613-C3E9-4089-BFC0-A13D246B5CCA@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary=----CPUVT20WTC7QUI1J3QWM8U1ES8UU0G
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dl1-x122b.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 PYZOR_CHECK=1.392, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

------CPUVT20WTC7QUI1J3QWM8U1ES8UU0G
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

ping
https://lore=2Ekernel=2Eorg/qemu-devel/20260622082119=2E11903-1-apolivodaa=
433@gmail=2Ecom/
------CPUVT20WTC7QUI1J3QWM8U1ES8UU0G
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><body><div dir=3D"auto">ping<br><a href=3D"https://lor=
e=2Ekernel=2Eorg/qemu-devel/20260622082119=2E11903-1-apolivodaa433@gmail=2E=
com/">https://lore=2Ekernel=2Eorg/qemu-devel/20260622082119=2E11903-1-apoli=
vodaa433@gmail=2Ecom/</a></div></body></html>
------CPUVT20WTC7QUI1J3QWM8U1ES8UU0G--

