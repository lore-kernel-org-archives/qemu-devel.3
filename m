Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D8AC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2P3-00023J-BV; Tue, 12 Mar 2024 09:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk2P1-0001uN-No
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:42:47 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk2Oz-0003l6-ID
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:42:47 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56877761303so698657a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 06:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710250964; x=1710855764; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlr2qjgtUSWk7GyxjUfmV13M45JiuI79pZ+72BqfW7s=;
 b=l67z4jNlxM0QCbz5ONbtT+Ar/OSa+l0H9b83SCrdOa44qLi4yEHfLWjsnewbdjEOWF
 U7sLw8vrillaqLRkq60sXO0LjPXRI7v4a0fGycDc55c/HSiyaaFe3VDLDXoB1Oo8IH9a
 qv/Ww1VsyGluJhcQOxGokaRwZs3gnOJt9ZXF6+n4UTZm0G5ss//V+XK8ydOJyw54H3yA
 JDd49tMuD5YENAi4O4xDG5LuhkabqnfpNSqeCDu0bKKNbDOmqqK85SQfsXWn2ZvFBcKC
 XWTSWD2Pff54ciJxCE3NAZm+xAmxG8hWA/+e7Dz3LFN2Z8/dEp/+r5DIzes8px4iLhFj
 io1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710250964; x=1710855764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlr2qjgtUSWk7GyxjUfmV13M45JiuI79pZ+72BqfW7s=;
 b=JJFzxw5/lYEAkzE+29lkO0V6Qx2+phkMOnAFcK5gQW3oosvx5QhyFVnvWcSod+taxG
 B51PmwZcf+j9/XqhXEg+uQQbx40KAX1OGdi8iBqXp6LTnF0QpYYZRTsJafPxBY5yF1aX
 O0UyAz+QHho0IKV57x3NzQd6V1mSCJHiCy+ayiAVO93vcpe4Imt4rhhyhkXv7fIDmQKF
 LZv454A9ne1A2tLOYDiDWAHkPtIky8ZqYhz0yDSEADy+ofFTaIBe50X5nRw7691Xem30
 dvZ4l/QziDq35j3OsetqD+VMkAaDflBJrtCfFbGDv3Sm1tABYu5lEW12lfzxQZHhtxwW
 EQwg==
X-Gm-Message-State: AOJu0YxLXrvK0qxYXWo4UmQK6frVr4my0VNm9KAhsto/4edaRjUnFXKo
 q3Zxohue9/QlN39UgQ+MHVtU6UjP84u1WCNqwMTYAb8dUvfdeAREwAPDhY6uF2zP9kgOYIqBua+
 w8y1b0ZTjKh23JVfgSUV9Jdqk3PVmjwHKRFTXWA==
X-Google-Smtp-Source: AGHT+IHRBRcF3SXk2BTuLSTHMm8DS9J72iec9+IZb2TaBQv3BWCQnxAOB3oBHv9uvyjpXl+kA+GTM23xre3exrAv6tg=
X-Received: by 2002:a50:9f28:0:b0:566:4a85:ceb3 with SMTP id
 b37-20020a509f28000000b005664a85ceb3mr1396461edf.9.1710250963904; Tue, 12 Mar
 2024 06:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240312112532.1558319-1-alex.bennee@linaro.org>
In-Reply-To: <20240312112532.1558319-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 13:42:32 +0000
Message-ID: <CAFEAcA_Vok6GcphdFv_NZv7iCeLpebS9JWZW5yHeRx1w9EY00g@mail.gmail.com>
Subject: Re: [PULL for 9.0 0/8] final maintainer updates (testing, gdbstub)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 12 Mar 2024 at 11:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf0=
5f:
>
>   Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into sta=
ging (2024-03-09 20:12:21 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-final-120324-1
>
> for you to fetch changes up to 0532045e8112c13a8a949e696576672e64c6fa14:
>
>   gdbstub: Fix double close() of the follow-fork-mode socket (2024-03-12 =
10:48:35 +0000)
>
> ----------------------------------------------------------------
> final updates for 9.0 (testing, gdbstub):
>
>   - avoid transferring pointless git data
>   - fix the over rebuilding of test VMs
>   - support Xfer:siginfo:read in gdbstub
>   - fix double close() in gdbstub
>

This makes the s390 CI jobs fail:

https://gitlab.com/qemu-project/qemu/-/jobs/6374182015
https://gitlab.com/qemu-project/qemu/-/jobs/6374182020

fatal: --filter can only be used when extensions.partialClone is set


thanks
-- PMM

