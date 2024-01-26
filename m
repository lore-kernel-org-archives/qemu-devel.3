Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39164C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 11:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTKaM-0001Em-Pc; Fri, 26 Jan 2024 06:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTKaL-0001C1-H1
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 06:41:25 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTKaJ-00040X-Rz
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 06:41:25 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40ee6ff0c7dso2341255e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 03:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706269281; x=1706874081; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=smsoF7YI3d5cbf4R4RpQPesf7hMZC9hmlPQLc3Rlsus=;
 b=QjHcb1d8guduzezdwcEFlZhLXaYZFffaEu6XqwNh9MWe00MaQGq1FVtuQa7RgdCIpi
 4WkC+XIWi8/KSo4LJyum3SiF6xuyLH1gn3oc80N9YMGUPIFIuvyqMjVJmpKMC73vbPWE
 GPjrjHWifsls59t1zXf3svyl6jbI5OpRYa42heZt0xsKE2PBuLBJxyt7JNCtLXZLdG5O
 qbSW9MnOHybBnxh5Vbt8ZeJBjBVNu9Esrrwlvijk/MNOQt2h0RXejyEqKWhZMNXeA45n
 +ByEVMIAfmPwgVsaqLJQAfCDZ1L/jXOIAl0fMChf2RGMd+O4DWMvF353CR7oHWeNdoGm
 leFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706269281; x=1706874081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=smsoF7YI3d5cbf4R4RpQPesf7hMZC9hmlPQLc3Rlsus=;
 b=hTAc4t2w9YA4FragPZ3zYzIjXzb616Y/G1J7UHQCyNlwcieeR9WEDB1HeXxx8lXnSh
 jw+F5KUrq6w6GA+5H70PVkoP+9Rtk7PA0bqlgmHtzOsX5qLd5fYSeM4ZFedwIRa0eueT
 H44k5CMGZj/BiV1n536Vstig3gT/x616b4PWfkT2VrhtMXEltIk53It1iY+GAWG0ljD/
 6eAo2Dn92bSTbY/zBqIjqj78g/eZ20MXsw12nPMfe46sZeX6fFlgoR4r+5cRk5YQSHfI
 7bpntz8EjL3AzuTBMOaC2TWPifP5wkrkN6dXjwYZWujbMM35wJscyxqMM6Z9unpLStu1
 ENzQ==
X-Gm-Message-State: AOJu0YwtwTgr+jx7Mq8JUofm89eLo9/DJYNdC9GWMsEK9RhueOrCNx/m
 jKQs2ynOQYd2ag7WE49IMPEUDybYcEQNU6M3YiS/ixa5CLA1fRE6eJw3+xeZlMPzDDLbEQObQRM
 qO15bjn979Y0QxRdSDH72353Mz21hW+gDVlOFeA==
X-Google-Smtp-Source: AGHT+IFr6drvGpZQur6Q2sI20rzB38ahWfp3Lxx9sdbBlnsq2o0dYQhe74N0era3ClC2EWJfLgwDz+ac+9+2Sw1c9OE=
X-Received: by 2002:a05:600c:354e:b0:40e:c71f:a92a with SMTP id
 i14-20020a05600c354e00b0040ec71fa92amr581460wmq.79.1706269280646; Fri, 26 Jan
 2024 03:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20240125151931.83494-1-rayhan.faizel@gmail.com>
In-Reply-To: <20240125151931.83494-1-rayhan.faizel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 11:41:09 +0000
Message-ID: <CAFEAcA8vVP0ccBzLNguT4SJqVZL8a2CvPQTa6CZJqw=GH=8o0Q@mail.gmail.com>
Subject: Re: [PATCH v4] hw/char/imx_serial: Implement receive FIFO and ageing
 timer for imx serial.
To: Rayhan Faizel <rayhan.faizel@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:i.MX31 (kzm)" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

On Thu, 25 Jan 2024 at 15:22, Rayhan Faizel <rayhan.faizel@gmail.com> wrote:
>
> This patch implements a 32 half word FIFO as per imx serial device
> specifications. If a non empty FIFO is below the trigger level, an ageing
> timer will tick for a duration of 8 characters. On expiry, AGTIM will be set
> triggering an interrupt. AGTIM timer resets when there is activity in
> the receive FIFO.
>
> Otherwise, RRDY is set when trigger level is
> exceeded. The receive trigger level is 8 in newer kernel versions and 1 in
> older ones.
>
> This change will break migration compatibility.
>
> [Changes in v4]
>
> - Correct handling of fifo overflow including ORE and OVRRUN flag setting.
> - Correct behaviour of empty FIFO popping.
> - Remove unnecessary RRDYEN check in can_receive.
> - In ageing timer restart function, use flag checks instead of directly
>   checking FIFO levels.
> - Further fixes to code formatting.
>
> [Changes in v3]
>
> - Caught more whitespace changes that went overlooked
> - Moved fifo and timer initialization to realize
>
> [Changes in v2]
>
> As per Peter Maydell's suggestions,
>
> - Use generic FIFO32 implementation in place of handmade impl.
> - Moved timer_init to serial init and use timer_del in reset
> - Removed stray whitespaces
> - Increment VMSTATE version
>
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>

Thanks for this respin -- I've applied it to target-arm.next,
so it will get into upstream git by next week.

-- PMM

