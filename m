Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBA0C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXImG-0006oo-Mz; Thu, 03 Jul 2025 08:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXImC-0006oR-4k
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:10:52 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIm5-0006ZG-Mq
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:10:50 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e84207a8aa3so3636728276.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751544643; x=1752149443; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PCGbWJOS0jGRiok+1xhNSwncYMtLsdIPlPdk31B/dK4=;
 b=kf1bpzypTtTWKcaL14psiveY5oeicO9rhgT2ayD96eeIwMrjUzqFSR7fSbz0D/fkut
 df7EXi9+9n2rG8Qw/B5eRaSI6qKvn/Om34BWwVKVdJ527rkLtAZHu+Fa1dxpyWvZViUe
 PSt2ffq0ByB/sw57CcEiVstfIyGK/Q145Iz/uKIscoTadoZ2uGQCxm+is5IiWkV8cEbf
 tnPi5Yr8u4hlbDUgzJyuX0tCDZSg2IJNWz/yQFrHDFQWQg4/QgM4fmM3dFkior1fp3yU
 SX49HIURubW8oex64rYAaPCSqqn+GAVaum8iISi8aXEulYkK7Mm81LK0J4ITPWajhb3S
 22ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751544643; x=1752149443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PCGbWJOS0jGRiok+1xhNSwncYMtLsdIPlPdk31B/dK4=;
 b=Xt+OBOpG5VukBHnbHbFB61G9lPNXOWsWHm8Ncwdi34FP8INEBdjMuX18EVTtxnHiX6
 /RFHxGXwhT+2kx6FVAalFT8gYJ1HLCRDHWjOJ/oywqT0c4vrfrr+QCilEXSPDf0N8HuX
 hRmZsrZj5b2oUQgv6Wi+faQrfq9UpP/RZ9hZ00JyozML4Q6bLUKQ1sL0MYbGkmdkTcKt
 1iSXYtrhYuGrln8OxI9stpfnA3A9IYGNC7CbsMB2RhctbGw0UtuItnC2Qbskb5/02Ao0
 od+PZStexasirMmXsgOc8AW/d7e/wigGhbitpO1r3k1rMuAxal2VxaMFE5cRg6YkrfAS
 L4hQ==
X-Gm-Message-State: AOJu0YxpitGtdMeOjS8A2MvGDw2MCbwO33GLrCU5nk+FAt9a67Z1z970
 WTMQgKmZj3l2mRXF5EKiW15IVeZ4dOhRECVjvyP0z/KPpErRpcv8O4oDBcMGQEMkG/Sy5aNJ0IX
 CAytLt9t2wn8yF9RN20qEghGzSliI572JQ1AalXR2aQ==
X-Gm-Gg: ASbGncspRGQVs6P8tZGXRLdL3MAlwOpDKie8i7TZRHb20RCGToheKnKbpmzCKhXZNsd
 DlcgsLfvWaHJNALjb778NjqrxH1/iFRw5RmQgki1ocdiSK664fKTkLbz3nGdy1viVGl9Es175lV
 SpXOy+PeO7kyyfhZs5ItoaT4AOIqYgPj9tAl9Sgb5qnxfLIC1KVM1tKOc=
X-Google-Smtp-Source: AGHT+IE8Qk8EM1cqu5NoLqhDTOEk/vMOdQTGziA9OLU9KVAMsQESd2BgsfY8r7jvwodI3sZIGnmswN4RINckhMxC4io=
X-Received: by 2002:a05:690c:3392:b0:712:d824:9202 with SMTP id
 00721157ae682-7164d2ca160mr86715517b3.9.1751544643277; Thu, 03 Jul 2025
 05:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-65-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-65-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:10:31 +0100
X-Gm-Features: Ac12FXxn29-7GS67rHLHpxg0Lc73VaGOkIxB0JMPVbnEMcBPYZpj6yL0MyjLOBo
Message-ID: <CAFEAcA-qSoH3Fu8__TFh8ZJA5oDqpgyn7NfOBdUpTeLMM_ff3A@mail.gmail.com>
Subject: Re: [PATCH v3 64/97] target/arm: Move scale by esz into
 helper_sve_while*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Change the API to pass element count rather than bit count.
> This will be helpful later for predicate as counter.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

