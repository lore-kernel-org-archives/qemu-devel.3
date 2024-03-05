Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2380C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV0a-0000mb-S3; Tue, 05 Mar 2024 08:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhV0W-0000mM-FZ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:39:00 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhV0V-0003Hy-14
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:39:00 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-565d1656c12so10063605a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709645937; x=1710250737; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fU9PHk2pIf+KsWH/egAKI1bXCce8nbZLlO1v00TPkPA=;
 b=iinuImxBjMXq9Dw49vYKqXaX+VUXN3D3PO4y4eVUI5YEPS+wTh5qZ2vNCq1CpMOC7O
 7vZUySOgAO/i6Ch/hF8263zcwVBjvA1SRURtaDIEpnxhiCcMeyw/afZShkTrhC1LjOEc
 n/eBayEMH258Oya00u4UH/961arK2pZ6vRc2Enw5S5f24lvBgiHS0qStTlCRuUVQBeQf
 kv+IrfktSXLYimo3eUbn3IBdl5bT6301xPjEdcH9pPb7JQ7bst/y30DXV+Vzg2mIH7Kd
 E3ZXgOX/iUXFu0ZV/5V4z96FkJVpOkw17oRz+b8ZPIlBXvwEcq+RsRaMkecktqEKp2I2
 VONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709645937; x=1710250737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fU9PHk2pIf+KsWH/egAKI1bXCce8nbZLlO1v00TPkPA=;
 b=l66Q4vpCT2IKSw2DFMG9xwkNzdu4nVUequEDAfcWjzI7uUm8tAjrheCw9iB9Kb2C7O
 TLofNA7dttyAvvBtU2XRsOQKYqYFNYtPTHLOtSpNqK23FMPwLG1Upspwk8BJGpabP0HM
 wNKRwKZyo4155CFL+RQGYBweqxguacNCJe/dPX8ZBWbfaygTlBOrVXJ02Pg5+SNPyY2j
 LvYdX4Cbduy6gfzzPzuKLbQKDw529qTl4pyghsfFw734lTGkNdEIjiekXe7SUEsKvrZF
 hPMERPs2nVmjLycVFHUGOlbeCBU9YWZKhdRVNZJXsRa1GbV6nxsy0CB7joETi+AQKRDW
 zwzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9zip/plz0/xEXEpOv5daxmj8td7EPRfaDh0nbkdMHLPStGZeDkRRdV1yf4vzdI4Ft7nbsIA7L/QQ/8aj0U1jrDtx8DOI=
X-Gm-Message-State: AOJu0YxQj0snqeRdidyD1eNOWWHKRYcwrMG9tMn9wocL5f69a8mTv06Y
 vK32xNOO5YQZpBevAU64rIOmXaRYsAEtO8MKw4+Q7BOFnR2Nlp2wXV711UUU7rA6AQPqcP5HWhP
 B2gwrmOiYBzLD1vcWkC4f1ebZzUu35B8WmZPRgA==
X-Google-Smtp-Source: AGHT+IEwm6CWL0zwGVUEIqiM4JwyLAjHDCGOjGwtBDxsri+SkBtkFiaiiH6uUp+5kX6+RSJJFAx0neW2WgM64CWbebk=
X-Received: by 2002:a50:8e05:0:b0:566:85aa:e63e with SMTP id
 5-20020a508e05000000b0056685aae63emr2606500edw.9.1709645936925; Tue, 05 Mar
 2024 05:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
 <20240305-elf2dmp-v2-13-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-13-86ff2163ad32@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 13:38:46 +0000
Message-ID: <CAFEAcA9or3wfwokpNRorFDZbNGNFz9mx4_9F1athf+mcz4cpKQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] contrib/elf2dmp: Clamp QEMU note to file size
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 5 Mar 2024 at 07:37, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> This fixes crashes with truncated dumps.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2202
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

