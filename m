Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34D2E74AC4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 16:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIW5x-0004OU-1d; Tue, 03 Dec 2024 11:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIW5s-0004OG-6c
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:49:48 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIW5q-0003yV-MC
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:49:47 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385e2880606so3767278f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 08:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733244585; x=1733849385; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i1hMtiGHDBEgnbtVAkEEcj2ceq9cb3BWZuBAEBlVxrY=;
 b=N++JwswCWNwJYj3ClrGYFGiOxT32VGB+l8MHnDw+uikXJ3Cccs7AbJgKz3O3j6U1CB
 V9YQ/JYoxYGJRpExDSvzg8JPcaYO7wy6l3X60yVl0GmjZOlvfCCwMwwlj+JoRHD2jWNp
 YW3rD53056UlrWLRfbtpZn19CxL3a22mQ/6cRiTCYreIGHdJRn4KdEioEGEUoxztPvQg
 uqvlgtEMPXfVx+XXrHkzOlvV17wWSV3x3Vp/AU0rUfagzODt0Q0oIi6Qkgo1GDcGnUxO
 P/JE2xqB1+wq9CikcJtMAQ+ixCMFLGL7x38MsBndpck0wfXAUX+nXi+1vaF3qCRPC0VF
 O3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733244585; x=1733849385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i1hMtiGHDBEgnbtVAkEEcj2ceq9cb3BWZuBAEBlVxrY=;
 b=UgXysSL5G8qq763bUAY3r07RRRe47+h2Xm5BM2Cv2EoNAJQYzfuVwzBYH+Pk0LZBTX
 w8Xq1WQ3k80qZN72aev0e5ez1SYTOazDyge4NUUdkyvD0bAnc3rI9+p92s1fvHxZk6KM
 6y0E+304FmI5VuUuZODbvzxxfb3rmSQvJfvyffW6CrKAPnCDbJZZPSzJoMlA5a6bIhlB
 8WMm6N2zQZY4e7x3bmSCDAuSpmM/sPNXe9QYzPcb+z7HEgpV9ddrq9VdQi2nrwFP1Hy2
 ekA27VvrnffsgVTlqQUWQPWC8FyhC+2wJsFl1cKjG4DvboLGVGm9KYyLTxsGMLVfBeWR
 fzsg==
X-Gm-Message-State: AOJu0YzJpbrNXgwUgBXcBOSptd9n9kfpJXvRWATv0YUzNYq8Iu/A7JMT
 SKZ0RUCQReJ8GBZZxh4jzVnUz5zpTjos2Ppr2OYlXHivw9AnUsni+icGruRvWIzi0Gzouuo5xVZ
 Fyh02goBbyvW0IDoyoE1KGb2XYOS3czj1nmdPsw==
X-Gm-Gg: ASbGncsPXg8qL85zidGDufVAI4H8VOhYHrVoVyS6YP0OP27RbH4Ka6YC/kShwTXuFil
 ZOePZm+bMHgblasKBmtwwQcBwCjHPWPc7
X-Google-Smtp-Source: AGHT+IHWPdnTm2fGuQ9VVypibcSnlMUQRKBNEuGZFuszfPxBG2uUxHfp6/prwdNe73XTbd38yB+aq0fKsdPjRdrfLII=
X-Received: by 2002:a5d:6d08:0:b0:385:f17b:de5a with SMTP id
 ffacd0b85a97d-385fd3f2ccamr3411160f8f.28.1733244584833; Tue, 03 Dec 2024
 08:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20241203111513.402641-1-shorne@gmail.com>
In-Reply-To: <20241203111513.402641-1-shorne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2024 16:49:34 +0000
Message-ID: <CAFEAcA-GN-vpzCay18YVagOjd0Gr=eN=CbfV5H1jzxMNd=40Cw@mail.gmail.com>
Subject: Re: [PULL 0/2] OpenRISC updates for 9.2.0
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

On Tue, 3 Dec 2024 at 11:16, Stafford Horne <shorne@gmail.com> wrote:
>
> The following changes since commit f0a5a31c33a8109061c2493e475c8a2f4d022432:
>
>   Update version for v9.2.0-rc0 release (2024-11-13 21:44:45 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stffrdhrn/qemu.git tags/pull-or1k-20241203
>
> for you to fetch changes up to 3eb43aeb164f1f83c97ff693c7d464b49755110c:
>
>   hw/openrisc: Fixed undercounting of TTCR in continuous mode (2024-12-03 10:59:25 +0000)
>
> ----------------------------------------------------------------
> OpenRISC updates for 9.2.0
>
> This series has 2 fixes:
>  - Fix to keep serial@90000000 as default
>  - Fixed undercounting of TTCR in continuous mode
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

