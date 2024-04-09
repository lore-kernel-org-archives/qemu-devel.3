Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76228CD1297
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 08:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru78v-0007uv-T1; Tue, 09 Apr 2024 04:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru78q-0007uf-O5
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 04:47:45 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru78n-0006ae-2r
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 04:47:43 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56845954ffeso7209240a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 01:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712652459; x=1713257259; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+HJJA/aXH9ZH+a8SxaouqSZfKOjFnzxLaaAoUsxw4P4=;
 b=Yb2gYxnkKKlbKacFBoiUrLOYkAv0/lCKvPHBfEn+aSBVRRXi+RSftgPWgotmZ+ou+t
 zJE4NbA/UNTZ4Pv9Stp4/34Uuu0Qd/wbj1Z0JjoysRLZcohH/rj9yIaHtZozW01ORiF8
 SpbJCI3FC3a6NzOkWkYdWPfdC6eGFUB+FuQUgt/v5rxoQd1/GaLgbTF3Csbcj7G2Id/s
 0nDxmkKYmOx/2nS/ZcTSYzsPesVsCInXfKQznMIdrlklpLwWC2UM5OFTEXd9TiaXFZ0U
 rBqdG8p0vLSYiFKHGMhXhI+hTvc23uw8xGLdB2/ODs+HJYZ9ZWDDp+wa6Wns60BVYGsw
 nlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712652459; x=1713257259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+HJJA/aXH9ZH+a8SxaouqSZfKOjFnzxLaaAoUsxw4P4=;
 b=eH48riOqLQ6s7g1A+2CgHtp+O3Yluodvkk8HppkCq5+WnA3YCvEAs7DsBcTQyv2as8
 pqGxLngi7pEqW8VPxLwAdpS460CxACDSh0Y7Is7Tzj8pV6SU7Q5MzKFC5mvA9qnTEDwR
 O3pZ5Mw+KLz6d9KJbba1jj4XqCfY+79qZB6uGkhHzN5JTVKwaZtpOjvItyamWkodGLMh
 eHavsmIroP7mVM0qnWpnIyLMTwW92GoQUWYzQHIJ3zSDax1vOmiurE1omcopSecqx6Yy
 W/oTsY+krViIcG89D/qfAGTME+EyWiJ1iNVpNTqfnG1ABXfEzETBwE8ij5xLV6133ZhW
 uP0Q==
X-Gm-Message-State: AOJu0Yy6C5xlMmVoo+6aYsGRvN67kXR3rYm8kQo6vKDsRtScW92lBeOh
 IPE34wrKe+kKa0RI/0o4sSap/kJP5QI81/Z+u8shnfoz8in0nGPRf0zlFYdBBoRXEbqdzic5bcg
 zOAL8CZFliw1R7JV+rSTigQwO1gWNIlVsibxsIg==
X-Google-Smtp-Source: AGHT+IH4XgHPO76I3+vN7eu3A2q0nK0d4xEL/6N3V42BCSRRhXmfuxnYGe/VaklxrxHwtf0Np/vK+z0VrLTjdqwgiYE=
X-Received: by 2002:a50:8ac2:0:b0:56e:64a:2a47 with SMTP id
 k2-20020a508ac2000000b0056e064a2a47mr6404224edk.42.1712652459273; Tue, 09 Apr
 2024 01:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240407184354.1839435-1-peterx@redhat.com>
In-Reply-To: <20240407184354.1839435-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 09:47:27 +0100
Message-ID: <CAFEAcA8Sr+2wEznF2QOyp1AeTX4JYS9ARHxm_VG9rYgyCEdNBQ@mail.gmail.com>
Subject: Re: [PULL 0/2] Migration 20240407 patches
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Wei Wang <wei.w.wang@intel.com>, 
 Lei Wang <lei4.wang@intel.com>, Avihai Horon <avihaih@nvidia.com>, 
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Sun, 7 Apr 2024 at 19:43, <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> The following changes since commit ce64e6224affb8b4e4b019f76d2950270b391af5:
>
>   Merge tag 'qemu-sparc-20240404' of https://github.com/mcayland/qemu into staging (2024-04-04 15:28:06 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20240407-pull-request
>
> for you to fetch changes up to 8e0b21e375f0f6e6dbaeaecc1d52e2220f163e40:
>
>   MAINTAINERS: Adjust migration documentation files (2024-04-07 14:40:55 -0400)
>
> ----------------------------------------------------------------
> Migration pull for 9.0-rc3
>
> - Wei/Lei's fix on a rare postcopy race that can hang the channel (since 8.0)
> - Avihai's fix on maintainers file, points to the right doc links
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

