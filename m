Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532BEC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 14:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmZnG-0002eY-P9; Mon, 24 Feb 2025 09:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmZn5-0002ct-WD
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 09:50:40 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmZn4-00004x-6F
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 09:50:39 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6f74b78df93so41516847b3.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 06:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740408636; x=1741013436; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uu5oNS2JKnrgWHXrn/qW+ymrVqvPr5X4vAD602abwkA=;
 b=pcRKLp4WumSMnM6ZwMOMXaNF0x+v1Iv2WIferquNiViVJPe98pN2Q/C+nz86sKyr3k
 GCdCNaps6cflHbyRwdhv+6IK5uSCCaqd5REQyALGp5nLh4o8k41hBg4FzFw+xmsN2JPr
 b1gXYSe6uBGaoagx4Hk+jxX5ubSaceMewLX/Cad7dZGxs8qDOSEHGR32Bd+u3ttWi+Et
 9wiPDKSgx+eXDyzMRpW/ZARFOw0zksWnO5rrYz35HDNIiorik9eQyDhCnPEwf6RGqKCR
 f/ZOorm74j4+KbLUjIxCmThYjEsdHLcfDhAYsowmG/s+9XhtLVeoYoLlOUo/39tnhtcw
 GSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740408636; x=1741013436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uu5oNS2JKnrgWHXrn/qW+ymrVqvPr5X4vAD602abwkA=;
 b=fKh5IRtVxXf8np7sENZZFhaBGD7zht8Hy+EQlcKKyBABMavb5RzzEFJCjlVuTIBnvd
 SLLHNIUNaxYVMEK/7+Wqbu4D7apxQ64hqy6mxrx/RWzIsZiUfGo0uiVqWySjg40CUllS
 X8ybiugOgi+5xELMqi0TWggy94GF/oqPfh2uS0BhEesLDm8N1bdEqqBXhy7ue3ASJV6b
 RnqsTqLGxpPNwN8yh5GuyeB8IPenX/qPm2EQENkvTpLvR5QOqBFmlRYd9bVPriXYuLhB
 Pc7wF7tZd+fallokl4FtmkPg5dkHVZFawyDhMEk/GDnhtVA3mZEUN4ENFBFiZa9iIgtc
 sqIw==
X-Gm-Message-State: AOJu0YyZnUi4l4qUSY4tnkVITPmC8o7l2KRjGeoBws66qCg4aAPaLlUc
 OjaYAsbTKqfkFKvvzFxHf+tMYxusX5PaZ/2ElJDr9lUNLNPWT/DrkyPw5xXr8phY9eWck5ygaMD
 xga0UQAAglsToENr+8TOTtzCOkzG1HXEXQ4wFvyQmj6d/N34Z
X-Gm-Gg: ASbGncsxCHp224Mnzrxwdv2WBBqSVJQ53dVlCPcSAq/uEoALC8BSwxpC1bJJKZoXsj8
 3Z2Vjwcixh64NpfHRGoD5XT+DtKAYPxzsN3bqx8LZLxblhJf8AHbx4LPSlUS8nvtxS4uaBmW8D2
 ERN0buXdOK
X-Google-Smtp-Source: AGHT+IHTUQDDCPipf3/W1vOhZ0dXSZee/LQrbwCNMlSg3jZdyXHuxV9Oh9v5wnowL6k4QPiyuEYs7eoBLCcUzXNKnk8=
X-Received: by 2002:a05:690c:586:b0:6ee:66d2:e738 with SMTP id
 00721157ae682-6fbcc1f0fbemr117779047b3.2.1740408636638; Mon, 24 Feb 2025
 06:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
In-Reply-To: <20250206151214.2947842-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Feb 2025 14:50:25 +0000
X-Gm-Features: AWEUYZl1grBQnWxaEfp2Y5fhnFgUURqk_wYRnHTS_gPhrSm-QmN-zPpZ7zOKIPU
Message-ID: <CAFEAcA-=C5Ymir4O+gzkmzDabGr_uokS6PbfU_dZYtb8hvb2=g@mail.gmail.com>
Subject: Re: [PATCH 0/6] hw: Centralize handling, improve error messages for
 -machine dumpdtb
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jia Liu <proljc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Thu, 6 Feb 2025 at 15:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> We originally implemented '-machine dumpdtb' in a fairly ad-hoc way:
> every machine using FDT is supposed to call qemu_fdt_dumpdtb() once
> it has finished creating and modifying the DTB; if the user passed in
> the machine option then qemu_fdt_dumpdtb() will write the FDT to a
> file and then exit QEMU.
>
> Somewhat later we implemented the QMP and HMP dumpdtb commands; for
> these to work we had to make all the FDT-using machines set
> MachineState::fdt to point to the FDT blob.
>
> This means we can clean up the handling of the -machine option, so we
> can implement it in one place in machine.c.  The benefit of this is:
>  * boards only need to do one thing, not two
>  * we can have better error messages for the "user asked us to
>    dump the DTB but this board doesn't have one" case

> Peter Maydell (6):
>   monitor/hmp-cmds.c: Clean up hmp_dumpdtb printf
>   hw/openrisc: Support monitor dumpdtb command
>   hw/mips/boston: Check for error return from boston_fdt_filter()
>   hw/mips/boston: Support dumpdtb monitor commands
>   hw: Centralize handling of -machine dumpdtb option
>   hw/core/machine.c: Make -machine dumpdtb=file.dtb with no DTB an error

Since these have all been reviewed, I'm going to take them
via target-arm.next, unless anybody wants to propose taking
them via a different route.

thanks
-- PMM

