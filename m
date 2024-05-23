Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE11C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 13:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA8um-0000xD-EV; Thu, 23 May 2024 09:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA8ul-0000ws-4p
 for qemu-devel@nongnu.org; Thu, 23 May 2024 09:55:27 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA8ui-0007ka-A1
 for qemu-devel@nongnu.org; Thu, 23 May 2024 09:55:25 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5766cd9ca1bso6287087a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716472523; x=1717077323; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eoMDYv6Pr0/M5PDIzOn5GQoV8a+8rzEppAxC02rkN9I=;
 b=zJnAdjLh/vSuRNnZ/sM/NvjVnXmOSE2UTbdwI0tZ7cdfFBKbr2tcWj4ReTN0cSPzA4
 P35PpoJq1TcZHWqyLnj9ktQYazugwgEqNR3OwB0kedpR3rgQOPMzGb3ZOR43fZ3OxYdd
 DdeCHhucvJkSO7UtSpKHh8+CjkViVfhUsDcUOBXsk1xTsQTXkJv2LYcGRitbR1bVW8gt
 uKiuKDAaerkAza+p0BUYxgJHAVJ2W2fQqIf/2RhytUU0OUJRaE60aQPehMBv4TICXy2o
 KAKBB01WkYYh2+18tpuxNAKi0j9WiiFxaoSKKkqqtHhQXqs7EKHLUPNYhPUGop0QgwoZ
 sGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716472523; x=1717077323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eoMDYv6Pr0/M5PDIzOn5GQoV8a+8rzEppAxC02rkN9I=;
 b=V8GXoQOUImtcN46Ygxdf8CuytyVePlo0/+nVNHD7xP2cjVjYLo33VsoGTbluJe2TaF
 wcyDI8v4BS8boAjjCl7voRXm5A5nimM3b1sgc6gdH8GphyV8PMx/SlO6eteOI9i1mTme
 zTHXLQhI4yhdlfVhMtfhCVXxohDO1kweFGuyO2p8CXV3pWzvBb96ROFYB63RO+Es7WeG
 /LZA/xSWXlqFTqyqS9GAHsI1OGMqRJnmW6ZBO3vaiGj7L7IlHtdxZY/BKDQzrpsiNoyv
 cPwPTJZ16RRgyp+TbnAwQgAio/E+I8eo3uKGiSCIvMbscFydfjJPP1IUxYsqiT18J8U0
 2vLA==
X-Gm-Message-State: AOJu0YwoU9Iu8n391OVZ8cJcFhU98Rp5ZAcJpOj9TYQFyeA8p/3deQWx
 6J4B4OlPi9luwW4E28p5QZvbxRFWAaYT1wmqd0HFcrmAetPVAvN4Gpg9aaRduksUUN4E3y2sZPh
 UHLMwS69ahTwKNXH5FJGiRHtghiriLwgujIZ/Vw==
X-Google-Smtp-Source: AGHT+IHJ5YyI1tMhVzUfuWyYkC6u6cu4ZoBOF0WTSbgIcK3D8yzVBM+Rg5kMRWsPQYf4RQNdCc2VmUH+E48i6tjoxiM=
X-Received: by 2002:a50:d790:0:b0:574:eb43:3862 with SMTP id
 4fb4d7f45d1cf-57832a01cd1mr3130594a12.5.1716472522741; Thu, 23 May 2024
 06:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-24-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 14:55:12 +0100
Message-ID: <CAFEAcA8tdCvbpuyo3=0A3WAT1NpxeWUjD3=K29P3sncZRXFcTQ@mail.gmail.com>
Subject: Re: [PATCH 23/57] target/arm: Use gvec for neon faddp, fmaxp, fminp
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 6 May 2024 at 02:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h             |  7 -----
>  target/arm/tcg/translate-neon.c | 55 ++-------------------------------
>  target/arm/tcg/vec_helper.c     | 45 ---------------------------
>  3 files changed, 3 insertions(+), 104 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

