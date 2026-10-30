Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A6606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=St6J30rI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMv9L-0006YB-NB; Fri, 30 Oct 2026 18:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMv9K-0006Xt-Qm
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:32:38 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMv9J-0005wW-4q
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:32:38 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-833e671ee9fso1383557a34.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793399555; x=1794004355; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4nh6sTDVOb89FtOp70uAV8vjI1dkSUB2r/ud8sqqvMs=;
 b=St6J30rItya6pxxZ3aPmqJgYfssJ6Ze/13Z3MoA/9geYMagWUnBBCSrztdwmUVpYxA
 ho+cii/6Wg5Jhg0e7marTGXxK8RkZlybl8zRRBMH95OIOJj7NrgcGoS448vqRRwjOhlm
 4EJ7la3+VN1avR1CzV2P29Xra5es2c0uFcOL7P8NflDCAsdtyI+Z7eV2tm+NkghWYqoE
 qihIVBDS0byrXkLbAwdhGiro6t1AhOYnCg9bewdFKUqTerlXCGeJKJJhVyCxbkLQwQeg
 JrDQK92iVgAU/KeJypQ153X8M7N+SK5ZY5wm0wxBXZiF0Rk6vLW4FdvzkwE+q706T0Hy
 /VTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793399555; x=1794004355;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4nh6sTDVOb89FtOp70uAV8vjI1dkSUB2r/ud8sqqvMs=;
 b=EBYjTiLwr1Cz+lZnqhbco4oqMAv9mztcKeJOnpLeNqXjPCICWyoDdEY6ZlIU5sTjeE
 j3Uy+H9wMlsJdhm0dxw4Dl5d4y1/M86NFT7PtT0wZw9LZGrCXYKxNzcdY1/5w73Wxktw
 mmMxsrtFqP7XHp4GogkNgtbXjgEWv+ISXzIlEnzXqv8HHmiRRvCqNdBKkS9PaGHNR2Sn
 xkwFEs+BAXe9ehIPEMAJvCqxAiJD1JBJR6SR8WnWHb0RKrTgEBxynY9O0m6g58xaF8QS
 LJk6cNwWd6V0h2b2mCKrWc8/fI7OTq80rn7qqJf6iyCMSbJdBilue6qUWVjjk8OrKj3X
 HgjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2BZi380UcUMgJZ2cjNzDfDF29RWeYFduYZhBGXtYMjDzdb12o1XayPQcnn84P5ewaHdxbjvyF91Ky@nongnu.org
X-Gm-Message-State: AFq9FYJsIKN05SB0WUbV4M6/XvuqRokXA/xciidbJ4QsSArnBRrANNo/
 Nm1PuKktrRD9qrHMvGDBhP/XPhNQJOulj3ofR2R3k9D9BRlPDCQAecSLlcb2LS80AZA=
X-Gm-Gg: AYBFou01/mgXgjfaHDSDYENnLH6XfHf52/B772Gz0Lv2iJ1Qhcgkk2LWQVGTjYFPrNe
 wS/Di++QBSZoo9Mf3YCuZJXl4FXU75pZQuiEme0ZRQAfussczhE5Df88LHukZ+ULZoNSbzEAuKD
 QXg/V2Ks7AlESQPWFVwW5yeRgfoGgRa+EEp/dgmpYnlVf624F8SQ2sxcS+8xDIOjdOpa2KYBhdX
 5E3qmVL5mctiWdowcUaDBBHDggwjUlV3wumOtZCjA4c2JIzEnwOyUdgKUbPeYa5uhdcmN0yaZP5
 CIkLsUIgtJvRCXq7SiSbOKbcqYEn3kYlcc1YMRdIUWiOeDeheRLL84EPj+GKrkA7JPduOyqdgpJ
 MSKYDKR+7W4R0dSE7zEmd0OlBM2zwqgEx+U9mi1wCpQmYXMqyVcB0xnpwyscO+4I4c5Dr0hBhy7
 aGWh9mq/52TkrbUgGKkxEiKcWHgSJdTjMEKV6riVkIlCmNOeBOE52084kDCdBw4KEWBw+o0NrYH
 tcUbCnKIsttpv2hfouxLPPnGG85+T20syBGVHMXuhOruBeIgQ/wWuj/yqqPPjgg9SRFr+g3Vvg8
 Ro2O0YDWVDCnBylabxqDDL2GF5yI/Nn9+UmgYl74O9lldw==
X-Received: by 2002:a05:6830:410f:b0:83c:1efb:6424 with SMTP id
 46e09a7af769-85d36313b23mr2908595a34.1.1793399555571; 
 Fri, 30 Oct 2026 15:32:35 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354985cdsm3128899a34.10.2026.10.30.15.32.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 15:32:34 -0700 (PDT)
Message-ID: <5160fd10-ed15-46ad-a482-add47af53a43@linaro.org>
Date: Fri, 30 Oct 2026 17:32:32 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fam Zheng <fam@euphon.net>, devel@lists.libvirt.org,
 "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>
References: <20261030193416.1691807-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261030193416.1691807-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 14:34, Stefan Hajnoczi wrote:
> The following changes since commit 7f36b1fbeb1f6f070cd5f8eddb3edbcafac15440:
> 
>    Merge tag 'pull-tcg-20261030' ofhttps://gitlab.com/rth7680/qemu into staging (2026-10-30 08:16:19 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> 
> for you to fetch changes up to 0a7dca50fd1d11e901c37aaac6b2a952b4919fc0:
> 
>    virtio-blk-test: Test truncated serial (2026-10-30 15:31:33 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> virtio-blk serial truncation deprecation by Kevin Wolf and a qed block driver
> fix for CVE-2026-118594.

Applied, thanks.

r~

