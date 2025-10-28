Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C33CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkte-0003qt-9e; Tue, 28 Oct 2025 10:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDktc-0003qR-Ud
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:42:01 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDktS-0004Kq-R1
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:41:59 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-63f533fbff7so3230829d50.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761662505; x=1762267305; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iyKdWtJR72+snAX3FSL8Q/xq5Z9KLMJkUmvySwtMib4=;
 b=yiPJKeiRPn8We9E1WIRyRx5tSrjhq8hdwpBb2PtCijOwsdPvZmdrHCk6K4slbvtX2G
 L1SOzUdCwJgnp2bO6+F8n/jr2H3MSoE4/JBnTDSRoi6bZRyA3+A8tkd38vNi0ezXZ8wJ
 oPCAxiArPUY+DukEYR5KqPPeJVP1EdioNSXffKSGHUxDYGZN2Evr2ZVVM2AQoogVb71J
 94exRFXQ+bFQ3jkVsilWdbkGsRKwtTo2Ie8eOT/N+k4bYTrhrVP/DTrm6c18YQUT9xbH
 od3G2Vd7WM+e6KlcCLVJyOXFdbcSIRsC8NrbbW+G6Kqz4zCncECgNnBudzxZ4alFJGZS
 XQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761662505; x=1762267305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iyKdWtJR72+snAX3FSL8Q/xq5Z9KLMJkUmvySwtMib4=;
 b=ZHjYimcfXb5+jbr0cv3zMQjaeue8zF2Zy/0kKQv6y9vodtp8pb71N9Foqr/R6MDP5j
 lVuxKpXlo2wLXwr+K1A2ub9/HDHKJmUllPkvRiraW8+IXhUu2ifaaDDqCTf0yi2JSxy1
 77EXjrdvq3GQFy78d68a6LMLalRX5HCTmu3q4Oeun29In88f5hkpoU0RBi5srQMc/2V6
 yuz2/peJXi6a1Uy3jw+jbh3U9ap/alTDreMYYnLgP8Mr+KzI+IfxrDU5cow/Mqdvem4v
 BdewSSYaRyjf5Dor+5PgyZ333OuIFEFOorN7y1rk5ydy+Mcsr+3A8mCzaboHHZzWxBAL
 jazw==
X-Gm-Message-State: AOJu0Yzcb6Q5fWCbzS6prc9tP8RqbahGI9dWIwnAh5cRozD83VmAptpw
 +hD2A8ipx7t2BQzUvgR1paXM6medAl4O+jxqFs0qHYvst+ppWiAjp9C0dsBDK1rtKCRZQvYRoVw
 nQA2RVLNck08OeXF2sKzpF8cmtiTZ9wkMIKsJMcZTog==
X-Gm-Gg: ASbGncvGbG2gl4rtuTjFxops4zJY+HZjHdt8KA+Nw4OZ9sbztlIdeMzZG478Ey4Z44D
 qndtiXwW+KxKaM5mtyUbtyLpvRZnhqPz14DiY+1251JJYrdvYWJ+PtlwR8Fln8Kmekd0u+3KkSJ
 RY1BAerE1fl/hms/thLcHT55tKE/SnRIeVgEMmpGNOwJ2ZDhiLtuICt0yLPqKeAMEzopHmaCtjp
 pfzn4f7KSagXsxDSFe8GpiqY3/lqzd7SsCv0p4oBtQGdIrVblaMUvxe2aewLWbp5zu/hhOn
X-Google-Smtp-Source: AGHT+IGkbmNFb1Rha/4Nz4C+7L+BbIDopIj1HMt7ZG55RmNyXD0eno33viIVPklTmu0OkFPEVga2kwU2bFEnOSqQFnk=
X-Received: by 2002:a05:690e:1a98:b0:63c:f5a6:f2e2 with SMTP id
 956f58d0204a3-63f6ba47172mr2671427d50.68.1761662503902; Tue, 28 Oct 2025
 07:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-21-richard.henderson@linaro.org>
 <CAFEAcA-tVBn3g185gzs2uOCnYLeqWN_zwfeQ0DccLf0n8BN5PQ@mail.gmail.com>
 <686b4a77-cf53-45e8-9b75-2b8dd9c4a67f@linaro.org>
In-Reply-To: <686b4a77-cf53-45e8-9b75-2b8dd9c4a67f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 14:41:31 +0000
X-Gm-Features: AWmQ_bksQFuwuUmpf-dz6pDXgRpkcwgxaKEk4Q7_QQnndZXOkQXzzUZ-C8IiAro
Message-ID: <CAFEAcA_gczP+RbKUx_p28AWN=s279rPLYaZCXjy0Bpr0NqPnPw@mail.gmail.com>
Subject: Re: [PATCH v2 20/37] target/arm: Consolidate definitions of PAR
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Tue, 28 Oct 2025 at 14:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/20/25 15:31, Peter Maydell wrote:
> > On Tue, 14 Oct 2025 at 21:11, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Create a function define_par_register which handles the 3
> >> distinct cases for PAR.  It is easier to understand with
> >> the definitions all in one place.
> >>
> >> Make the aarch64 to be the primary definition, when present,
> >> rather than being an alias of the 64-bit non-secure aa32 reg.
> >
> > Doesn't that break tcg-to-tcg migration across this commit?
>
> I don't know... possibly?
> I guess we have a test for this somewhere, but it needs setup?

I don't have a test specifically -- I tend to use one
of my usual lying-around "boot linux" setups that has
a qcow2 disk file, and then connect the monitor and
use 'savevm foo' to save, and then check that -loadvm foo
with the new QEMU works.

thanks
-- PMM

