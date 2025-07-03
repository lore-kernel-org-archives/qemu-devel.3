Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932AEC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXIxN-0005Gc-Gp; Thu, 03 Jul 2025 08:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIx9-0005FS-PN
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:22:12 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIx7-0003t6-3K
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:22:11 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-70e64b430daso60891527b3.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751545327; x=1752150127; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vAigPDr82y1J39/o53j42j9ra/pn+xHQ0yh75wmRnjI=;
 b=cjb2UqfzDUAh3EP7S7N3c76jhYbDHp0Ve8H8q49CDVP4iLcXcWEoZ5UEx2219ltII+
 A87oqVmb4YeydwaVoHx0aoxbeZnosWzRTeHnO2TRjWYFjUsFUQuaqUdNIZEb+SbUJuNm
 R+DrQQAyC0JSREUVPR1MSkU23uFY8X+MmC1WF1Zznwjbgu6u1b+H7+eaN7AtotAn0vFm
 6sPVzvxg4QMOiI86BG+UYPqGzDmlgN1ChsD4k+SqkDnjExxd624OO2jKn+8MtmYYBtU1
 dxV7+d8oWsyQh2EbSBuf1z/KTBxANkvb2eNK5Tn93zuMxiocJifbz6iu38GtiWTLahIN
 Zvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751545327; x=1752150127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vAigPDr82y1J39/o53j42j9ra/pn+xHQ0yh75wmRnjI=;
 b=nseW4VQjYU4wi5sqTAAHwv6u215nGQXoflNHv4O2k4Y/x7Q579MwXoLwtxKi0hWLKt
 GmmGonPhPBGxn/gG+3n/NuuYRyLsvEmUkMQ8k0H2Va56TPbKfJzCj5t15c//o3DEQ81D
 qrCI/cQ4ZdRdH/uJPU05HYouD3hZRV8TbUozitjwtkDC2VlzMuRq9vEDnWnP2OauMqF7
 OlSUogW8ybQR1WDW62OBjjkdggYC0H6LqKVVs1HtCI3UmrtxRJ8w5DYQh5K/bO44iGOq
 fA+2JWogt+pSVYRfcPSzCgO1zcuhxZ6+QFanSNPeEQP20eZAVwNv8DUXhpZExMU/iHSH
 pgWw==
X-Gm-Message-State: AOJu0YwSy27RaQv5wXSWF6zALgBgs1oCXbAkpsmzz50xpv7TMR6gZOKQ
 QSh11exvukKyRJtJHFcphAZXq7w3baVGdbP4U6eJP+5+HMmRP/9kMd/9um/NHivixaVmZtjhD57
 4pb+6cO3HwBFsN1DymFjvNQn834nFuBkqQ+UdS9hUpxfv4SpPwDf9
X-Gm-Gg: ASbGncuMHkshSzSC7Tnix9naK3uepoYrbbKiX7uXUZ/z6tkTCnhuPxxhENjDggLDcGW
 J5vnRDoFiSsZv7ohhp2r0ed3x24nTSwSxiV7CrbKfQqzSmNt21bNI7kIzLU/XUc+fTzKK+w1Gwg
 9bFaU9kFhtMobOsImxuE9YutHcatyrjNrSLZVoioR2cxR8VJzmS3xMNQU=
X-Google-Smtp-Source: AGHT+IHUPivvzJlqRD7c9p2QdWOqBVuuvOfr9lL4coNcuQNYW9tYnL0KH2TE/eoono49ZGwHCVtFJ4ddK8JVtaP/rlI=
X-Received: by 2002:a05:690c:4447:b0:708:f6d:b79f with SMTP id
 00721157ae682-7164d47f68amr93282397b3.29.1751545327333; Thu, 03 Jul 2025
 05:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-73-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-73-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:21:55 +0100
X-Gm-Features: Ac12FXw6FwPOlOUdM5AoYxBcizpkPsw6r_QbEPy-Y4UdzxjpE9n4zVV8pu68xO4
Message-ID: <CAFEAcA_5o+a+NHT8nJZFLxLfSMXcAy9NDsy0Xbp-BPKthjrO3g@mail.gmail.com>
Subject: Re: [PATCH v3 72/97] target/arm: Implement SME2 SEL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    |   5 +
>  target/arm/tcg/sme_helper.c    | 315 +++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c |  31 ++++
>  target/arm/tcg/sme.decode      |   9 +

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

