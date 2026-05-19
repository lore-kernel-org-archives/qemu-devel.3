Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAC6CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPO7r-0004b3-RA; Tue, 19 May 2026 13:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1wPO7o-0004ab-EX
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:21:00 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1wPO7m-0001Ad-PT
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:21:00 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-69d377221aaso1208340eaf.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779211255; cv=none;
 d=google.com; s=arc-20240605;
 b=LI8KLVJbjK24l+p8InvXhBpNmUCmFH8ssfY55jM0jPcUK+Rhj8BeC2EKcSOGASAMAS
 NcZ6i10WqxkDzz4UvuqG618P/5n0S9aYkyrPfjw1owohPHCsF9EjTfC6F9MEJzUt7yI/
 Ir/TwsMd3BXQvvXYLwmu7JDqCfJ4uxeAA7y4noEmafulFvUFiSnCUhTGUOHT+qGMlxcA
 UraX5o8prUAlrpIunEHkmMUQHKyyo5i8PQgmCrlInrDm7WksLUS1SVggtrxTj9ZMzjOX
 cl3dW2D2yWL7E4dS5SBgyAFOXTtO9e/HHVmfcMBgR/Dc1TsA+KsFwj6SQXVAsyP2YTJZ
 tb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8RzE6KsJQFWWTPUhwPb8bOflHsHi42ro9MZpZRDsN5A=;
 fh=UAs5dmeEY1vlDEkGnKzhQ+VWmOFW4t80xWne8KHbuyA=;
 b=RdshWvjsmlLO3dDJI+5r4OFph+jkE2D8yjd3U/x/awMDGoGLRgePjxNO3Ga2niTKfT
 Sw51E+RXfwUMOlelmnBQLORh9jYaqnJK8/0skcsu13bDDLNn+GFRgVMLAaFiWlNkRCqC
 Jazcyc6GxQvIiuglPd/XE1aOZYeiICi7G0ZZdKstmsXuQa1oxmlMpQKT0XZXaFr8UAlN
 tJsMpDBEYmZPNaSxx08QUA6fYIFwq6oM1e6+D/F+5ikLBstN/Kthor61FjmIh1ukq6I9
 spJr8dKexusiIuMV+T1QfXsNd2CUdJCdFmGCeasB5yA57Yq6oz+CvX1/iIZriBJk0NjO
 vrBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779211255; x=1779816055; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RzE6KsJQFWWTPUhwPb8bOflHsHi42ro9MZpZRDsN5A=;
 b=a+P2LAc/BNO2k+OvrGX1LqHt2SKNTs2uwxpotd0rwQv+K0v5iB3fClo93BOvbcWC0C
 8xB8XsetHiY+xXBdfaKOUqzkjNvk2le+Q9B2d81xHNcmiLAZ4QK8/jjtYbpI+QHTuX3+
 a7uoEAwInjyy1j3v14vTxm4x/yk/7mQ/JKCHCEu9wa8OWhFAvRaN7By7RR2J2S8sfE23
 HoEAmy/U3L6wrtwmQe+A9d1kZ8rFKpRl/gFpsBdBW8aNnebiI7iiZv6Cj3P8g6qIroTC
 XX1zXWcI28nliyrg5y8UkjHKLZnjMd1tH4/s+JpLUg1W8Xw/hdWUIFyHSaDCOCzneRqU
 uAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779211255; x=1779816055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8RzE6KsJQFWWTPUhwPb8bOflHsHi42ro9MZpZRDsN5A=;
 b=P2WL+Vl4fQQtRpNvmh1VLevhF1B/NoH5gfNELdGdojdt98oC+p9IATO/xiMnQkJDaP
 M6RKu5Wuyd246jDkJwX981xa96a9eOnh9Y8m+A0dGw1kIG9sU34uXhyWCNylNrFfBXm3
 2HHHZ4h+VByfeTBSDEYA/TdwB2fPn3wppuuHx9qSbUfYHRAvV0qx84fQ0LS2A0kBYtC9
 flv5jHGX0HIpUUp0v5WeySF9gI9f2kwsSb2sNNcwQZ8qUpT60tN/sGOqrneSyJv/mgrM
 Q5JQZ62/9lxb1hSd/J0L/ygSjVEho0Z4dsfejWswyVpb/nbHyjgZ4ZPbnUgj/rERbqci
 oz+g==
X-Gm-Message-State: AOJu0Yww0XkdOGgQT0x1FWltR13qG0ylnWIF2j7ODWxf+QMsEsme6dpx
 4b42NC16b5Ct85/dZLf5WMd2RGS75j28w4n/4kD8MU106mraBfM49qQboDRjaghULNhhy7RUmCh
 gqe06hI2EowHCmimhHLdaVhpyh+2Z5e/Mx6/z9S9PuYIeTpXHFYXfP44Jow==
X-Gm-Gg: Acq92OFmNEQe4be+i+xOmjMZqJqWN7blgLobAnRQbBdE9heko2xH/b2gi8M4SMzrpMq
 uVhXUM96eMT7dmJyPgF7P4cpBXV6x5YsBcg5xnlN5oJKgFaNhIXZluOn69laiCr8AtElX+aY3qU
 tnq77SiJ359JEbQsiah/7P7vgP+qGkScbqhof65K68KsYyRehqbKLnWNfRB5/w8sM9GCN5CjyhC
 /i7muP58kxmPhg746GBPiDqp3Fx5NewkVs/BLqoDen1Dxvp2PbXfFV7bbQQLvCFdbB+mJwA+V5c
 8XSfPMQ=
X-Received: by 2002:a05:6820:1519:b0:696:1cbd:27b2 with SMTP id
 006d021491bc7-69c9437c730mr12434157eaf.29.1779211255463; Tue, 19 May 2026
 10:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260519171926.98099-1-philmd@linaro.org>
In-Reply-To: <20260519171926.98099-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Tue, 19 May 2026 19:20:43 +0200
X-Gm-Features: AVHnY4LJsMFYWm4hBsWX8RFpz7RInZmbYtZg8PgqCgYi1ria-dnptWGG-DcmU6Y
Message-ID: <CAPMQPEJ4qx_WZ7iOTs7q8f=fSjD+tc588kczKms95Tf1VGQ8wA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Correct scripts/coverity-model.c path
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-oo1-xc32.google.com
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

On Tue, 19 May 2026 at 19:19, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Commit e804f892b90 ("coverity-scan: list components, move model
> to scripts/coverity-scan") moved the file but forgot to update
> the MAINTAINERS entry.
>

Reported-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92b875ddfc1..73b7ebf1d7e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3260,7 +3260,7 @@ F: util/qemu-option.c
>  Coverity model
>  M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
> -F: scripts/coverity-model.c
> +F: scripts/coverity-scan/model.c
>
>  Coverity Scan integration
>  M: Peter Maydell <peter.maydell@linaro.org>
> --
> 2.53.0
>

