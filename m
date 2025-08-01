Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF393C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvYP-00081W-Ib; Fri, 01 Aug 2025 15:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhttE-0000nx-8I
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:50:13 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtt7-0007Ql-Nv
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:49:53 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71b71a8d561so9690717b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070585; x=1754675385; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dQyXcQa4SNSPZ5NatskOVID/F7M2nBgxj4oyNcZTLQw=;
 b=h8M1McdU+3x2sNdn/3ETx5cnSwcL+p6eGof13H938D3eZUwban/0Nf1Dl8+57os1iJ
 y8deAC84VUes/1m4svDI1sm1Uv1fackkql/c6VvZH5aY45RBPaI1bzZe6KD+MkulBQAW
 5HaKNUW08CGlDfncdGfTBFVl9oZbS42DWG3X+s61bfPW6K/SFpx8xnYasfWu5O4RORcU
 fA6ckyXgWmXxCkxnjCDJ3glpDwFGw3ZiFbsFcsSY9HxCyNXY8SJmnf9jfYS6b6qztDge
 mGe5z9i8g++WCTKeE450vpeM2lhviZc/UWQjtyc6cTCRTSJ8D4+gGmTQnCkJxG3pz4g3
 zDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070585; x=1754675385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dQyXcQa4SNSPZ5NatskOVID/F7M2nBgxj4oyNcZTLQw=;
 b=ERNnfvzEA/3u5nfv3SQc1Q7ZaQjkPxeyixYq0Kr1qmWnmot31F4hyv85ZQ5Qy6FNf4
 bW1jzlY4VYj0M+USDD9a//eyA5QmmFuW/D/otQ2pFf4KvBkkA2pONikAZ88RSaTupLmL
 1WofT3An9KnBzAmLDLbHhkG91W7BLYx6T0FuTyC9jJy+jkcIa8fqiAovEIAfjmEfSl9J
 PlyKdWJymTT7viIYFKw6xUXnn/OAzPL6L7eqQgtTw9SrfXFSeTgBU/MUZi3U4EJ1yWjt
 60TzLPwdo9D0CYzY3HYejIoxVAW6E9buRz7DDdZKgc8MBgsSXEgh0Bda9IZrnaJy/pB7
 cyxQ==
X-Gm-Message-State: AOJu0YyrtUh4jkXT6Zd8a7ilz7MgM+Ur+QjCCtvhoJ99PKD47n2NCYCg
 isz3RBhKQeliTQgFxKzN71S3E6CnnGQpGyU08Vp2l6AlPxYK52+mX9vkVjqxwXzhf6dvouidfzZ
 lkTp0WEOdi+QqVaOf94QSXeUTYqHU1GjyQxcHmAdi3QJ9aMQpuVVa
X-Gm-Gg: ASbGnct0UZhv9RDr1lR0CSZ038NELzlk8/KJUbjiqiJ3SHviuHKZ6KSHk5kT8P+6AKt
 iBcIkcG1hw7ZzscG/dGDSxLdNP9HECqCnAONG7uUioRaiUHg1vJuDaTgF/35vKWDSz1osyAN3JB
 tMO7uzkfTATm7AehrN/040nS/UlA+RDMtAOiYVcim2t4AAlclJNEqpPXE/6rtj1yerdc3E/a1m/
 SmKiwJz
X-Google-Smtp-Source: AGHT+IFPyLOB/Jn/aw+9wDwIIYyNxKdi0WeRs/d0dalFvSylsFhtmDhmWTOH+T7qUGHSMaDTAHu7YFNm1VEk4ImFtRw=
X-Received: by 2002:a05:690c:d93:b0:719:c796:b9ec with SMTP id
 00721157ae682-71b5a8199b0mr98288027b3.11.1754070584887; Fri, 01 Aug 2025
 10:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-52-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-52-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:49:32 +0100
X-Gm-Features: Ac12FXwi3LU3xddhqrRHEGKd68Iqvv88k42LBAsoUVRTC8SXurWEWLS2lw8GUks
Message-ID: <CAFEAcA8g=u6nffbySmbq06hFm3awf=FcEn2-PdjUrqfr2m_pUw@mail.gmail.com>
Subject: Re: [PATCH 51/89] linux-user/m68k: Split out target_coredump.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 30 Jul 2025 at 01:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c                  | 29 +-------------------------
>  linux-user/m68k/target_coredump.c.inc | 30 +++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 28 deletions(-)
>  create mode 100644 linux-user/m68k/target_coredump.c.inc
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

