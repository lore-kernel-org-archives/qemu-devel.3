Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9794C531F9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 06:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnsmA-0001MJ-Or; Sun, 26 Jul 2026 02:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wnslf-0001DX-FD
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 02:55:27 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wnsld-0007xG-Vo
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 02:55:23 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ceeee8c46bso5654885ad.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 23:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785048917; x=1785653717; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DgDdyxg5locYdUtc1a9e95dY5Ousl+T1QclAxxkyGrg=;
 b=lHL5XbqQ09atRgDX87dwywgFzsyhtGr7XMjaaBqOStG7XTQCkAJyFTn8SMVv2xc+b0
 0GjogXwJaARYPSgcZ5QHHfDPSkm7ogXnEbYb0qWBN/3MDk9CAqobpQYcpQtt/NlqkGSw
 LSQ4VLIh+9R8GsmGPLt7qOEjUsr4groLJMTBatiMqmP4tqQmG42PJDtJyAxGG36P8HBm
 A82NGoRuNaKApngcvWiUay+b24cd+ylAQkciLkeSPjNVSc3CPlk09m7v4N4aOnL7lSMe
 jOSM01uBccoM7yh/j3Voc9+GyjM5Mw2cCpzJmWkLhypnw9Xhugq70sfPsRvOsm0tk0cJ
 HSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785048917; x=1785653717;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DgDdyxg5locYdUtc1a9e95dY5Ousl+T1QclAxxkyGrg=;
 b=qJ3gEJ7Jjxs+2j8JaSO0UTHAqJdEoQ064uJzgzvDPVpxIg/bIvCIQRSfbbLPWvXuUF
 Ccv5vH+ZLyYAiKy3/byj0897ZYnNqM30MhLjheMMyyLPC9Ve8yoEZmW5r33wUgOAFrH6
 f3Sz+MN9iiPFefDGZfjAlvE7LyHlxRG1BiptcrdS53yWZRYRElht9GgT21CtrAwRtZyd
 P29m6dp0Yf7VAAagBn7EbsRMXP0f8zON5H6hy9omauvyGWgoo8grZCvw/zvtkfzg4kYs
 RabecC2gH8dsTVhzgzKnz6jK8ftqCz1hU41GZWucW0iCJ5fJ+leaF+cGuNKe5pPERYJV
 /nag==
X-Gm-Message-State: AOJu0YxIPK/BZqsiSzOjgv2losDNRkzScdFMTHOu0gdKZzDCsqQ6AKrK
 xLhZ8Bq7cHoUj/UHbZwa0yL21hTjMnuPag3zHvRv8Jcmaefb6wqMgOEf
X-Gm-Gg: AR+sD12GvC5ZpzvwgBvC8tGV+zkaBHVhUqpuxgxYfdoy+fW/3XozAzhx0vDx1VoI+yC
 Z5nJtWqMngTcOZMM7iWC11VYipn43xvlvkfR4rOU99TlLrMRzloETyzib1rmdpYnXcLu6Xk3kT0
 tJ6basVRBWxYoLV/b5vaJwtFs45jhiD7TK0gSpEU41TtSxwo6thGlUPH5QDoXiDb9Sro5WZkEu9
 mPNuKW1I4uJcjB2BhXKJfmP1q/zKywE2O/YYj8zF5ydNaMBgXx9rBBp/nIFwhnSo8lzPClE7Zdh
 lNPrRfVOUzQrCW2AbVNvC8tvOL0ZeH4cIGDpgnDOB5p/neARihcR55osOkkmZ0IUCGbVHwfhbPq
 QPPlPkuanbubNaOtdHKTkDL2x+4rRW9X/aGAU0GBh/sSP8YnyvqOuxnJJg80tZqV1Dvnsi2jO2f
 jbvvSHOaGH2Aroq/8I3xwW
X-Received: by 2002:a05:6a21:6e43:b0:3bf:b625:5bbb with SMTP id
 adf61e73a8af0-3c67df85cffmr2828693637.6.1785048917577; 
 Sat, 25 Jul 2026 23:55:17 -0700 (PDT)
Received: from DESKTOP-7HME356.localdomain ([38.34.7.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc44cb92sm29618246eec.13.2026.07.25.23.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 23:55:17 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 7/7] hw/riscv: k230: add a noc stub region in K230
 board
From: Junze Cao <caojunze424@gmail.com>
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com
In-Reply-To: <20260721161335.73872-8-dingtao0430@163.com>
References: <20260721161335.73872-1-dingtao0430@163.com>
 <20260721161335.73872-8-dingtao0430@163.com>
Date: Sun, 26 Jul 2026 14:55:01 +0800
Message-Id: <178504890123.906524.3326796358963636469.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785048904; l=321;
 i=caojunze424@gmail.com; s=junze-gmail; h=from:subject:message-id;
 bh=QiXP8SoqawPQPX5NLQ3lMjmVZL/Qk7IdL2S4e4vFh1w=;
 b=VD7b/MuZ2bt2kGR41m5lQ2gfrlngmfoXPzUPTJqjQHey24FQv9m+5Hl0p5uV44YmASXihqTzG
 gfm5eYCfeDPDoTYcaWShTrc2tDerY5aYITqHuX/JeXWf+7ejHep29ZP
X-Developer-Key: i=caojunze424@gmail.com; a=ed25519;
 pk=lnFIWNw+6CoDrHFIKUJKdgrRbvgAbQGcEFiVsIigOJ8=
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=caojunze424@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, 22 Jul 2026 00:13:35 +0800, Tao Ding <dingtao0430@163.com> wrote:
> The NOC address was accessed in the k230_unzip driver, but it is currently not in k230.
> This commit uses create_unimplemented_device to preset the region.

Reviewed-by: bbbbbq <2082291273@qq.com>

-- 
Junze Cao <caojunze424@gmail.com>


