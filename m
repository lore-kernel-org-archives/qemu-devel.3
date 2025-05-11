Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51419C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDTY-0006AY-B2; Sun, 11 May 2025 16:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1uEDTV-0006AQ-SX
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:40:41 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1uEDTT-0006uA-5d
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:40:41 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-30a89c31ae7so5001096a91.2
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746996037; x=1747600837; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1yzQD4F7s8+6vEDWGn6czw3Jqad3rTywjc8Jd6/Iio=;
 b=V9f10+109fYLtU8QcOpfTQXouXF1ZswuiN804+ZQEDjlzqhKf/C/bg8Tf4vDgwb9oA
 c0GI0ApcbwZ5hGGjzoTCtfVvDpzIZRIoYKqEPtF+gOzf3tcnEKJg1rH2aCUzaVui0TQY
 qAS4xihMbDZvs6inZtREHCCv+I+ENP04CpTvuPQqt10rJQEBB957+qFPUuPk1IeH1u7r
 4l2rsrU0vcuFMmyD3+Jt0mvU1WEcYaj6aGi8C5hPnh9dNKqGAFXsH/BjMWfxzJk24E1h
 mIQN//WAGo7OzWbcRejWw+qYiAGDNibsnd4mgdVPKp3GVv/dee6a+BSZCwGuRjEoHlV4
 zrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746996037; x=1747600837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1yzQD4F7s8+6vEDWGn6czw3Jqad3rTywjc8Jd6/Iio=;
 b=lDsczSnQs8DMO1cmcH8qzW7h2QI4L4u90vdune8dX+S0CrQfgFKd+VXrIaD7dc10jh
 2wISdNtYBCHVV47KEXY62O8KSRKje39K6upEPFEceKxTlckwb+P5eUWtNJ+5T3VmKP0b
 QFOsMN/3d9k2+8sStUKJuR1R2Tk9GKd0bDbHM9U9ij4C/BEhUzEoseQFZ0Z3gFw4/Ork
 Sgg26zPUPRanJPw+qfzPpFRjCQNUXw14O/Ks9uN9ULowGf1dnjpRx0++Q9uWGvTfckBS
 lwFuPgIrDgnl5I7InztCbtVUa/Upl2LD5aCCOk5l6mOCH8jN6LRROiwGyPiYPLGFTJBj
 x7/w==
X-Gm-Message-State: AOJu0YyPLzjHCXJWC0oz7TMEYwN4sq0iG2dqsBboEewmCZ6MoKIkP0XN
 xbd/JtPXogyD2UHYVsHp1e1nxNOdKMHEJc+8TYrsszHnFEA0AGiZ29KpNFhYWNZJdXnvgy5AZ6C
 poc0ZX07jFONTdAmc/Zok26SoRhM=
X-Gm-Gg: ASbGncuRnG3xvr7gY/PEAiIejtd586o+SDBkZRZpKPm/cBjRTUwFTercQlaUuBXguNc
 TaOCVuduBqA8bqAYEWoReHgIGWyT6wRgddw1hEJCMUb63JtMCeD2bmunLcBOOa8wJaWbwcrVMQP
 IP81mmfOQnHS0ByRSy9a+70a1prOocPfsaWtJwhXvPIA==
X-Google-Smtp-Source: AGHT+IH48gQ9k6+9gV+/mvXFbbSoapXyBxFI96Kn7mBlF1Ze6jkf6GioAzHo5ywg2+XCjd63ZDrly6eqpx2hVfrNlFc=
X-Received: by 2002:a17:90b:1a89:b0:2f6:f32e:90ac with SMTP id
 98e67ed59e1d1-30c3cefc37bmr16838336a91.11.1746996037269; Sun, 11 May 2025
 13:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1746968215.git.neither@nut.email>
 <26b7c748557fb8dc655eb003758789263705d736.1746968215.git.neither@nut.email>
In-Reply-To: <26b7c748557fb8dc655eb003758789263705d736.1746968215.git.neither@nut.email>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 11 May 2025 13:40:26 -0700
X-Gm-Features: AX0GCFt17M_AcFdDrYptnd9AiPCSucryNr72Cp8YtLZTxkph_aeioZaKo7FI7sI
Message-ID: <CAMo8BfK33QYx0i39D=GBOQMAswku7szCMYsM74MEQoevDSrm7g@mail.gmail.com>
Subject: Re: [PATCH v4 20/23] target/xtensa: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, May 11, 2025 at 6:14=E2=80=AFAM Julian Ganz <neither@nut.email> wro=
te:
>
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
>
> This change places hooks for xtensa targets.
>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>  target/xtensa/exc_helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

