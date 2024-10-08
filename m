Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C566CEF17C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syB9n-0005fC-Od; Tue, 08 Oct 2024 10:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syB9f-0005XL-3g
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:25:39 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syB9d-00012G-Ke
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:25:38 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so241027a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728397535; x=1729002335; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KFyOI4kR/oCoxSqEZ5bt7UtRlDCHr0O31AoUd84Ktk4=;
 b=QIb7koEMw3ZBsyhKfyyncE83LgikxZTBcHTatW+qcgFy494DlImXCXCMfwTm7Hg1E+
 1Lw0Aw4+01yU1G+2qe6aTF5DsDB+rOfIJf869OlghFZbAw8BVKtnFbIoMv9e4h8LOV1S
 0SSjcBPE2g1nuDfOE7zbncoc/H5IaPbXiZ1pMksqHZ9HhoCK+jVdS8t4GBi+ITRpdV38
 aMRm6O2nJ7TsPdwU8M2LEfnJT9V6qLSbrK9gj2DtNgKXFw6HVOnVIA4LuJG6YVr4hD4q
 zt5r2QYvbaUKjoCo+gCYEW41FjKUkbJ4FKCKTpF2Xme1VS9MB0JAnRnn9ta+Y0F8+rg8
 tmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728397535; x=1729002335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KFyOI4kR/oCoxSqEZ5bt7UtRlDCHr0O31AoUd84Ktk4=;
 b=hNet7RHNsISM1V/Tote/5bJtOU/MMcEoKi44KFxEB4bHz6DQb1sNSwy5eWJkw0oGpe
 d6bD3QT3hmRdEMRZQbKVUUbJzH2SQ2pNDc1x/MCXs1ymleQx+u0mMt/cLOyoezvFYUxY
 l5P+563O0hZ/9GQYIKGNsNEG8lKflU1otD+6dG1u4PlkFJ2ktw7yIXWOsWAAwqlrfyrK
 N0wWtqyjE683yhvgXWedj9fQKuQcqyHfp+nAjPZG3tgFqLRAa+CkW10Jocla4OPunoJ8
 6Zk/fu+r4cUFhW9hjTynlAUR6SBk7d7+2iWUmwgbwbWaDXmqBpdy9WQV/us/vw/gv3eh
 /b2w==
X-Gm-Message-State: AOJu0YxbWds/y89UQ/gwXCojoTZuFn0poUR2k+Jhk168lKnKoIxbYuOn
 iKNsKYmxODxTTFEP3OchjgGwl5ot6mIEedewnol8xVYYtfhLRm7dDiJEMsfxWVgTRKoqLIPjx9R
 zA2smpcLMPZq8crQz0gchb44fIAzH+gj6qieOQw==
X-Google-Smtp-Source: AGHT+IH6vDRkL8posdyuwttmhFmsw/CjaMeEXHedCAmJUQDyqmuFFuzqUW413BB7Q7kpg2ghdilkoR5TzKy13fwkI/0=
X-Received: by 2002:a05:6402:5187:b0:5c5:cb7f:e56a with SMTP id
 4fb4d7f45d1cf-5c905cfc19emr3762017a12.1.1728397535021; Tue, 08 Oct 2024
 07:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-17-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:25:24 +0100
Message-ID: <CAFEAcA8aKThqSWLwCAEb3ec3QPtBowMfvgRn8TxN1C-kGcrdgA@mail.gmail.com>
Subject: Re: [PATCH v2 16/21] target/arm: Pass MemOp to get_phys_addr_nogpc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Zero is the safe do-nothing value for callers to use.
> Pass the value through from get_phys_addr_gpc and
> get_phys_addr_with_space_nogpc.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

