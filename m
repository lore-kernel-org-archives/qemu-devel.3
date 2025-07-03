Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97962C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJ2f-0000Uy-EX; Thu, 03 Jul 2025 08:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJ2b-0000UX-B1
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:27:49 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJ2V-0005AX-FB
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:27:49 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-70e4043c5b7so54657127b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751545662; x=1752150462; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iE5wuarQLFP1KfubjkovK94cVecmZJbOkHOEdG/1ai8=;
 b=U+sHHlysKoU8Yy2hvDiLdsatZAfqrdXv86rGE+5cQwiwLxyR9gelQ2XaVkXc3/jQrv
 Hr/TnoXI1XNeHMHAai4VTiQVjBbHp6n/YTBZN8UTFbkBH/G2FF6h/WQzIhnG5XQ4RuEg
 DbmItL9UGugdZdEWRtL4hLqrZiwZekGYPXEYpwB8fhGN2umjfB3MwTZYwmm0V8btv/QM
 emSsmyp/Hweo32e9gim10CRaH5pMu3MjlhmjHhXaRLtjN5YGfK5+Xq7mYGIsX+YC138X
 zHUHnS96VYQnvapt131pL20mEHdtTn+qX3bWEDRfKERrvlLrWb1+q0x2XcvheF6uHhaW
 3q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751545662; x=1752150462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iE5wuarQLFP1KfubjkovK94cVecmZJbOkHOEdG/1ai8=;
 b=GbXFmHUSHYt8DDtQHiWtNmOMOahe8WcFhw9WRLhnaLOB1+QBeoiHNu7waZgiF7WS/i
 7NOyi0nKoe46BdqX/uh2PJz6l7yHZGiXOZCcAOAUvn0joWFhGIOrkQQ2t21eExw4ZqNN
 qDsGQgdlFfy3L4oUWVeoNFBmsM1SgUx6XoI1nb0rwEhMPDJGJ8UNRZNcvHMNLNuTCIfx
 a0pIiuFEgJb7yC1wKPyf3Xq+0BOmZcKI4uRnzgCq4sxzq4G5+VpbMOetHv2WVr6TooXA
 D2pH6iVOWuLUhSt9Mk6Qv4TqqpLnEmppWwtTY3ToEPa6qzhhvLTES2XgMwDgOOo6vtwW
 oCFA==
X-Gm-Message-State: AOJu0YzpP2Xgl+UZ/wezKTxRlT0/v7xsCFVY8TE8Lufn8vKM1D/vBtk/
 eBT3VWtp6alSERwgjgr/kBtlQjykjiXK/QpdRN3cZ/YN4sxefZgZ/asHVctV/BMZdxy/ZeN5Pap
 mIdqDEKY6FdHfDdM7e/VleXvvuw1P0Cbcs9zg+WcudJVERglegk6e
X-Gm-Gg: ASbGncubK20Jh2Pk1UEXB0PSNPzjpF8UGKfr058VdvVtvdYoWSQx1cLyxTjiI4duuMS
 v3fpqp3Y83dar/Tvzru/uvHfXbKbUvuQb2Z8zC90R5YC/imKu2I7qtPR+J+lZABKXcltB8gHsys
 XtdZMOH16kY7ELiHWnUyUR1ttMP+tsABl7auFTq3GQvMJR
X-Google-Smtp-Source: AGHT+IGpAGrxoWW0iXkIEc6IYDwF7hh/BeoJULn4Wno1e5ngaIQi8UoUZyo3c2RQE2kOf7wRZ/zP4XKSZSeIrTNRYiI=
X-Received: by 2002:a05:690c:d0d:b0:714:349:583d with SMTP id
 00721157ae682-7164d26db98mr86068187b3.8.1751545661880; Thu, 03 Jul 2025
 05:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-78-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-78-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:27:30 +0100
X-Gm-Features: Ac12FXxatI4Y05L27pD0n-G0ffr3wpI23n1hOPcOeRJ8Xp-DrOTAfHKl7Eggi6I
Message-ID: <CAFEAcA_reGV-388woU+-_PoUD2PBLGiXpU5BE93b6MbCERpHtg@mail.gmail.com>
Subject: Re: [PATCH v3 77/97] target/arm: Implement DUPQ for SME2p1/SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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
>  target/arm/tcg/translate-sve.c | 21 +++++++++++++++++++++
>  target/arm/tcg/sve.decode      |  6 ++++++
>  2 files changed, 27 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

