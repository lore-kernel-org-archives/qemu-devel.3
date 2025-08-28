Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08809CA0EFF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 01:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urRMW-0003pA-FC; Wed, 27 Aug 2025 21:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urRMU-0003oh-TB
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 21:23:34 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urRMS-0006HD-Nd
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 21:23:34 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57S1NO42008539
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 28 Aug 2025 10:23:25 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=r0YXLRyqod+LYi8x9Xilp6ORJH10psLQR/TwmZxt3IE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1756344205; v=1;
 b=qkw2TtnYov0p7xwZQq1Uf4tR4TEUsqvxvjGLF5ug0OoLxsG5VZFH+UTtEN3eNE98
 qkc6x9LttC/uv9En5nw0WTHeYHedeIu8+mtUYFqqfH8fFL3uOth0KDcHJwGXuf5R
 vfhDl8H63ECY2l2bzeG+nA7HLuknYtf0FZuZgGoYOaPNpZXoVF46Rp3RIUbi6tZO
 VCTw+Z/oWeLoNl6Yjiqpv3y8wtVikkZIcWKUC7lS/PdFgs6hWvSaBEXdHqXCha9T
 H0wiPPINbXZPk+gX2yCvrw6LNf2m7/q48HmehBU7NgrWFN2xRMQumfYPB3+TQ4LJ
 2WVAE5JVl7peOIFv+t7xyQ==
Message-ID: <c8498b04-4937-4a1b-aab4-04a6ebaa3e57@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 28 Aug 2025 10:23:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_aarch64_virt_gpu: Skip test if EGL
 won't initialize
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20250826123455.2856988-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250826123455.2856988-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/08/26 21:34, Peter Maydell wrote:
> If you are using the Nvidia drivers and have installed new versions
> of those packages but have not yet rebooted the host kernel,
> attempting to use the egl-headless display will cause QEMU to fail to
> start with
> 
> $ qemu-system-aarch64 -M virt -display egl-headless
> qemu-system-aarch64: egl: eglInitialize failed: EGL_NOT_INITIALIZED
> qemu-system-aarch64: egl: render node init failed
> 
> together with this complaint in the host kernel dmesg:
> 
> [7874777.555649] NVRM: API mismatch: the client has the version 535.247.01, but
>                   NVRM: this kernel module has the version 535.230.02.  Please
>                   NVRM: make sure that this kernel module and all NVIDIA driver
>                   NVRM: components have the same version.
> 
> This isn't a problem with QEMU itself, so reporting this as a test
> failure is misleading.  Instead skip the tests, as we already do for
> various other kinds of "host system can't actually run the EGL
> display" situation.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

