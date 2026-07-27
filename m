Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD01C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woGZX-0006fn-DM; Mon, 27 Jul 2026 04:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1woGZW-0006ek-0e
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:20:26 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1woGZU-0003dX-Fp
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:20:25 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6611669cd16so2984414d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 01:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785140423; cv=none;
 d=google.com; s=arc-20260327;
 b=YCjvNyR8yd/76HbohiUeEaIGq3wJnN2xxfVOjB312wVWGPJZCK++N63vnaKPPuJzde
 RS/sUMVGH903EaMlwEG0Feg0A0OKYuV4Tgk+gcYBSNgQ5FJ6o6G3PHW05JZ/vGAKn4qD
 vEJLHfB422TAHWrW9k4h8ywER33NzBkeKIY/tp+Jso7mVCDGEi+cRm3bgp9BCZPbGhyy
 VO0KlmxoN70wXSNFWk5KFk2HApf9iX0NPdJdNd/bd/GbmbZZkh5q2drEmx6i3EJOSkOV
 fxqdgIxvZjGhklUCbkznOO55+yn8eRIrN4mglzoJkViruhH3uil3yq5YP0fFblLIHJ9D
 c0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jY5R4YnftG+67F752+w1fCDnLdBQjLukzln0QJWYakA=;
 fh=d0f15bx3ZaGyK7JifOdMNzQFc7oCSEbXVVXrfMtAisI=;
 b=r1J6tpPRD8wo9IUbdqdsPFgueUVEo1CYw1x+P6/IV+cCvuIFprbEoppoVp1y3LmJqK
 hqJnGEfIxL1zEvTJDx+qPubi3GcZYUKgg8duWfr4pdBUIvAkNGVV1lkVSBSXlOwSfxXu
 5gTguw6EIScdXBF3WmIKnvttYFg0upGEPjzOdcLuYzMxSf3msAjjdAO3TDXQM+BgmY6b
 ydUzr7uamIx/1JaZMmTjh/+S8WXOGS9UZZomOCk0+HiSiwDJB/+GMy8S+PBwg8pp9Sq8
 03w+eYqp9lZmybY9gPM/x4W7JL0uvStBiK8ttDlB8tMCZ+V2XKUg++V4prwsGSOFFABP
 0HZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785140423; x=1785745223; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jY5R4YnftG+67F752+w1fCDnLdBQjLukzln0QJWYakA=;
 b=QirrN9HsWGijEltmMy6UcPRS55Ynk0Gfve2atWffmuSjyPRQzzXalUEVeLP9DGEhng
 2IDM5yLfCpSrXlpuQiXy0N9D2rstpSqqKatid6k05zwPlzVhAc9ey5kdSb/a3aDfsVF+
 imAjJyMvskiRz/3i+hAaXrPwtS0s8YneXO720VkFurOiwc4KzdfniULXgxdAC4xzhHzz
 zHq2SmSRWM1RGuw5Do1Nl7VwA6duggPPu0h2AdJtpXIjROcT87O67Lae2TJW/Xs3SupZ
 7Lr84DGjPbQfNSC+ibwB5y0dRDN9eycbtzrL9OzQihmprfV3nFmfj5AFZM8rWVQAC6kS
 S7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785140423; x=1785745223;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jY5R4YnftG+67F752+w1fCDnLdBQjLukzln0QJWYakA=;
 b=WcFm1PUv/kWWFAW2CAwGLw+GfzRM0VZ8Fk+XwMVnfmKJAiMHyzZf5M1EMNHTCe83UA
 /WqoAmGuGoNcx7GuHpTRy52e5jhnRYkdrAv1z6zT9RMz7aYbtwKTqveMzdiX6QAEF9Wn
 kHyyTkqkG/q6fMK/77ssW+i3tjAagX6OGe46P9IvyMImbNB6X/roMZdbuGrmtROgHEz4
 B0CvjKJNFuMlpF09FWfCo6MUXxWCdQNUBdseGYxIHEBuCJaY2HwwJxDO9Mp6gvJ9rZ2P
 E0y09TrFzT9LVgidp/sQSwaj6gFwg02gxJiiHKE1HlPfRmPq5XexPhU1SJSDTzy7k2XW
 7saA==
X-Gm-Message-State: AOJu0Yw2G16783xwu52TE5/7x9LX1T0fSibvPhwwmuA9SbPLImDWLL9D
 56kosiQMycX8nsRTjDClyKe8Fn58Y7eDf1L1hciTXK3NGMlHXCqIISE20nTvzs5ep7iGjVmI1ng
 fZZ+riWRx3oUA2kKrHVX5eSLFQAqiMzw=
X-Gm-Gg: AR+sD13cSXrpqZGEqqBuzXmXDtTmi4NXFmYw8gk0I4ADfGTsQu1WGR6rlIoazdfGj4h
 y2GGVmAsBt20Kp93u7s4rfFcFXDzeOnxdfId2bJfZHJwg6BCvPVScAM5hLLRvaFbDHhtWOF8KMw
 bjz14vv/tO1fl+nLeNJqd0FHMhFrao9tCn0QXS/GC+tTpF0RZ1FsXPT+IxXhFQwW6plx1AfdzCz
 Pg/HMrC8Rm7SNUJ1ZBPEZjtExfkqXMCT5B8Ak+vyZfKufh2iYtYic0d1dmB4s0Foah0uJQ4BCHE
 GuakzUv8o+jZEtHm2UTr
X-Received: by 2002:a05:690e:43dc:b0:664:d186:4737 with SMTP id
 956f58d0204a3-668c79ea27cmr1581439d50.27.1785140423193; Mon, 27 Jul 2026
 01:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785064312.git.flamboyant.h.01@gmail.com>
 <12e325190a15045cff5c429b154217814cd9e618.1785064313.git.flamboyant.h.01@gmail.com>
 <CAEUhbmUEF7fLEP9+HbE6mKE5OKsVm0rds+1S==BtRLArLZMbxA@mail.gmail.com>
In-Reply-To: <CAEUhbmUEF7fLEP9+HbE6mKE5OKsVm0rds+1S==BtRLArLZMbxA@mail.gmail.com>
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Date: Mon, 27 Jul 2026 16:20:13 +0800
X-Gm-Features: AUfX_my5W-JnReOjWkXYfWOzexfEZY9mN_IT7v3NsbVMsx3V2W48XUR2rDhTa1A
Message-ID: <CAAW0U4YezAk=RRM2ERqen=znt=kY4+nLrjJOEE2r=pwzc0Q+vA@mail.gmail.com>
Subject: Re: [PATCH 01/11] hw/ssi: Add K230 DesignWare SSI register model
To: Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel@nongnu.org, "open list:K230 Machines" <qemu-riscv@nongnu.org>, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Kangjie Huang <flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Bin,
Bin Meng <bmeng.cn@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8827=E6=97=A5=
=E5=91=A8=E4=B8=80 12:45=E5=86=99=E9=81=93=EF=BC=9A
>
> Please split the model into 2 models:
>
> - One generic model for Synopsys DesignWare SSI controller
> - One K230 specific wrapper model on top of the Synopsys DesignWare
> SSI controller [optional, if the generic model is enough to make the
> k230 software happy]
>
> This way we can reuse the Synopsys DesignWare SSI controller model by
> other machines in the future.

Thanks for the review and the suggestion!
I will look into the common parts between the generic DesignWare SSI
and the K230 implementation, and complete the split in v2.

Regards,
Kangjie

