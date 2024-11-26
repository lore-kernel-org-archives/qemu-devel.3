Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E3AD3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvPM-00076t-S7; Tue, 26 Nov 2024 08:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFvPK-00073i-8Z
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:15:10 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFvPI-0003Gu-8d
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:15:09 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5ceca0ec4e7so6822772a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732626906; x=1733231706; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4l0CJj8RvJAvRigw/HDAj1EXsBOQZdxFcnAHit473Jk=;
 b=NnDTsphTous07yAUyvqJm3dmHHqmHLVYz1851ba02fFvQGA3ZyMnXEULZUlid9+dRe
 qlYhj+91x9cq4oqHuTZxksScC/AtLIkBjnhdRD5f0I5XMWVfGCxWNGcszLU4BDEl/ORB
 bcvnlzp5lwcWpI+AmKS7MKVfahGOZih/HS/ljn9o0BNBZRRoFM6HgUV6+TAmNcsUlQjh
 qOSPU7VrUgEgYg37NpjihsaCkQoAJWhFb6gHtOd3/FHP6AW5brPagI9ASDVR7y+X8kBq
 LutjMxAQLxtquI43Mm2VabsH34LyLw86FZF6RfbDNWhSF3jup2JRKx1Bh09Ex716iMYi
 jdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732626906; x=1733231706;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4l0CJj8RvJAvRigw/HDAj1EXsBOQZdxFcnAHit473Jk=;
 b=Ei34WdOIsEoa4ax+SXO3esVKc5ZPUs1NnAOsGFI1vdRrxukozBABzCF8YLo+p8pRXJ
 jqLP4K4bV6ThdPS7ih34NN6p6Y3OnfVoAB6hF/3zQcDc/Bnh6TTZuZ2FrnCovcI7OzUN
 aMSP7H6vFDkUNyC5tdHVs4XMP1N2xz9XSO0Y2Y1zYmXuEMAVy465hm7NMMchACXkEGne
 M1zV3z/bvziDwYE7id9OKzosgM01L9r9yJNV3Y93e5tejpDEcVdTTq8kEF/+ekMYFwaT
 ZcgprJX/rhXT0SgWWdXS9gXynOw6EyvX41L4GYFvNNjuCPGjF15lypFeUncc+GwWyH0Z
 WKiw==
X-Gm-Message-State: AOJu0Yx+6S9gi7KD7ClDFNHSdbhI37KqWwSmHxoKZiRc2+8ZabVjsUKP
 CCzfoxUaTYsxZY39d5NMCgnxN9VNiCw7f54PhWtZjXFCQ7rxBlAN9VSRGbvFny3QHXupgQOoCcR
 T3RcKKPyojXQ5RfINcgGzVVNJYb4SH+NcbFD7bMd0cqLScV4S
X-Gm-Gg: ASbGncuy5VWquQCUEAy2ki1QwaulD88t5ghGQeO9hp6CL49xRf8x9DgFhWJwfJ3FCBM
 71u1f7Dq1/C3oE3AnahtxeoKHYwstdMdx
X-Google-Smtp-Source: AGHT+IG/y2hfmwCneajRZ504p4S5veBMQ9DOHb3pMS7oxE+Ys8n3VseEfGZKPJZJfvFnIPAlb/yFKx9jkRqLeDSnTh8=
X-Received: by 2002:a05:6402:502:b0:5d0:214b:9343 with SMTP id
 4fb4d7f45d1cf-5d0214b962amr12203229a12.4.1732626905696; Tue, 26 Nov 2024
 05:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20241126084928.252067-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20241126084928.252067-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2024 13:14:54 +0000
Message-ID: <CAFEAcA_SkZ+ew8AAVpBHuw-9YW4S5wFbB0Vqx+dBzXf97JGDGw@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: bump default memory size to 2GB
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-arm@nongnu.org, Mathieu Poirier <mathieu.poirier@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 26 Nov 2024 at 08:49, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> We are working on adding RME support to SBSA Reference Platform.
> When RME is enabled then RMM (Realm Managment Monitor) takes 1072MB of
> memory for own use. Which ends with firmware panic on 1GB machine.

Reasonable change, but isn't it also a bug in the RMM that it
grabs 1GB of RAM regardless of how much RAM the machine
actually has?

thanks
-- PMM

