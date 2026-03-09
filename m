Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF56DF417F5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbz8-0001MS-7q; Mon, 09 Mar 2026 10:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzbz6-0001Gq-AJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:53:28 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzbz4-0005yK-LW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:53:28 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64aedd812baso10449471d50.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:53:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068005; cv=none;
 d=google.com; s=arc-20240605;
 b=gm9R3+q01T/ydMGqp/jxppW28EpdYFvLgZM6M2qu2WUjyqHsM8iBJ9VWj17hZ8GJDi
 DvOK4k9b+0w/wn4iP4vkSZt4+a9+etzqFfOM1iP5b8M0BmFegpzYzkJQP8s/TSqmmKms
 +7wEAHC19k9MFKlzgB2vov2wBG6nvpaJjKkfURNqI7imSaISwnyc9in1W71FdrokOcDe
 ozeTmODDU+Dwrh0DtjePpu7pEN9/D7qvzKkSOnoGgv9qTJidMd+DDKmVByElH4tQoCkf
 NzjRlIgVnTWsMShtu3/umo1Lp6l0xZ22L9zvhjZzQH31FbZEp6c8YCpJfAIn6wEghH3o
 HJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Pk0tganCzc+Jby4hmtfYDqSWTiay9/ai5AVifVYMoAw=;
 fh=cEq0JthdzFc1puQ59qRylglKocvWLKop/c1b5vgcHUY=;
 b=O393QkWg4pf/jcMqaUfX+aJJrs9xplESroo1220GSUPPca7LsOOZv8vtfWqZuwIiPs
 jChUDTqx1lRWgVou7bteTPBwfVEO+15bMJrRZdUGehirLmSDGWKQ2iXJ7NIS3BCgejSF
 7ssmEHvpvnVfdt3EA6Rau0VgIAeppcewEh0ImZ/cDwURh0ZKa69h71HIklMOtfzi2WNd
 dicn2cQDlBoSnq47B5iQyuLcksRmhJ7GgPIMjsd8/A218Jq7W2TVWcIgIh9eGOsmDF7O
 1YlJzz3jnTI9/QQwXvpp44FGliSVqbqSMZFHZOMbWIKnERSGx2FureqpU+EXXsWLVqtT
 3MmA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773068005; x=1773672805; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pk0tganCzc+Jby4hmtfYDqSWTiay9/ai5AVifVYMoAw=;
 b=E+IKr6GxyyzWfCnfRHZZQjaqSbI4ZcrwnB50ETiEVjVIzu3v7V7/RCVTU4hqQWGnFA
 poMObSti6wya8IPTH37ZgVUxYdoZi4YegFHu21GWbKGeh2W5vjSgjgjpe+38SCcRm0me
 y65x7hwid9gchmslLiLjj2LDn548YpzyjOZX627y/rcl1ZX/4ddxd6+Rj4L0gLEda8oW
 SVSdSgDtsTSf4vZKyjU+bf07gDmHb23UB3sx9KAFUf/r2SPq16ELKKbhU8ys85He6b0n
 ZazpIFz5ElwMPnRZ8AAAS82fvSM6C4mJzThFKkaZ1HGCpmWklbQKxJ/FyuFC7L9Dg70+
 uXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068005; x=1773672805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pk0tganCzc+Jby4hmtfYDqSWTiay9/ai5AVifVYMoAw=;
 b=tFzCtwviUJM6VLCkHvxGNeXOGrmB1wFtQMHoR/weUB4FSgodFDYHacGFeVBURwXHFw
 u84mH0cEspJQf9bx6nMAjcpVBQYyHl2E5KxOuAOsZn5ROSF2s4rm3KB+Q4Re+yRq2ym5
 1aeKWYPwtr4S81h4ZyLfi+BbBcjCkLLGH9e0Mb2itnfC2WZs+EfE1nvUc4G2gWLlgEpT
 H1vtX/c0Ptw+2st/4Qs+E72sbPjNaXn5bKFKunILcDzLJEkRIITBbm22wiT5u+IiE9hZ
 u2mTkN8MHzpx7NaX1wFSBotWvTnVB/0IeQT+ccn4Put5lESJTIbhOhAEpByqSKk9g2pb
 5cQg==
X-Gm-Message-State: AOJu0YyobHANjRBof3yZLeO0TnYklyJemBbnB6znVw5WQPiYe2QTq7av
 RGbiOJfLvtIjqa8W1m9bueUxQr6HE0SyF5PCYZASkcA9v7WdUa6UR1hCOe2dmYN70xMQGciV6HN
 zpTowohFF+yjAJe4Za/PIKXrbXPFTJn0MuKAoXFXydEN2qQVRsoKp
X-Gm-Gg: ATEYQzzsUzaBHx6PXbYAh1QpRGLmxftMMfpEhbnCu6HRYtkH8fML8hzykpBClDgCP/b
 1gQnyof3JFmSah1cxHbe3Hf/GV3LGPLjHUY8wghHJ+Gzzmro+z8mso5sk28FVPoBF4RGk/hSvNy
 JQtrmNkXzJ3FXr8SYXPQncyuJ7Di77tGzjRAi0RTE0hv0pWD5nW7JwaK23wk0DadS3x+0V+0uU1
 ycvX2HJSKC4SemF4yEb1a/zTqaIfWi74W9nLOvo6QHnKKHaTqHYEw57hvRFVZiqxMUJbYp7mMQu
 li9H8Hfv/0zVixO2NIkAWF3GZ1pTQUtr4zI7U9h6AjSYLFrdVzkXhkb3iPAewE9bzf4=
X-Received: by 2002:a05:690e:11c8:b0:64c:9fe1:38d7 with SMTP id
 956f58d0204a3-64d143a1751mr11027855d50.85.1773068005550; Mon, 09 Mar 2026
 07:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260309101529.25695-5-anthony.perard@vates.tech>
In-Reply-To: <20260309101529.25695-5-anthony.perard@vates.tech>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 14:53:14 +0000
X-Gm-Features: AaiRm52wpA-OltA-Sw21G2qiV2JPYv7RxxYwgDJlDv0Pi3YNhaUMMLzqvLE7OSo
Message-ID: <CAFEAcA-4rUu+3nnU8-Q6jbHjF3yCg0dQLmLrKTha8=DiPbE1Rg@mail.gmail.com>
Subject: Re: [PULL 0/3] Xen queue 2026-03-09
To: Anthony PERARD <anthony.perard@vates.tech>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Mon, 9 Mar 2026 at 10:32, Anthony PERARD <anthony.perard@vates.tech> wrote:
>
> The following changes since commit 1ae4271ab8dbfbf5dc28b36baa7f3fd5fd2215e1:
>
>   Merge tag 'pull-11.0-virtio-gpu-updates-060326-1' of https://gitlab.com/stsquad/qemu into staging (2026-03-07 11:22:16 +0000)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20260309
>
> for you to fetch changes up to 5a0b8890862251de3f182020cdfa3faaec7623aa:
>
>   xen-hvm: Emit RTC_CHANGE upon TIMEOFFSET ioreq (2026-03-09 10:48:33 +0100)
>
> ----------------------------------------------------------------
> Xen queue:
>
> - Bug fix handling framebuffer during migration
> - Emit RTC_CHANGE event
> - One build fix
>




Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

