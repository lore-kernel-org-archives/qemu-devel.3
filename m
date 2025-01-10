Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9828DE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 15:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHIN-0001c8-T7; Fri, 10 Jan 2025 10:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tWHGb-0007n0-OX
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:49:45 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tWHGa-0001e1-0e
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:49:45 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d647d5df90so3441203a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 07:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736524181; x=1737128981; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8SGU3dm929TVLGtNe5xapiGpX/+UNFGGDu8sfaDssmk=;
 b=U6HSTN37YDqz5Tp/fUKZR+8CtZoZvVVzsCpsxFV14qtO/cqL5I6RIQSFQ29NvtOAyv
 FTO9ChDRJJBvTjzdm9kgIRiVzDjtVGkqgAH2PD17YvOtM34/VMH7l/R2HUYO75BvJGAn
 HAdOnPkXr1b5Hdwz0roaPnsvrZ6DGj56exyCdcRkChTD9fovqSu4UTqIM3jvWreQqsbZ
 bPya//HjK4qWtMiE1UEDNA093hM+s/z/5pjGmhMhXPdnRLrDGSpzmM3RDxqWxutXCmUM
 XFL4LEoJ++zU4nPszwNEjGnFzyghv4Ckflzt/8kWxS2ht4tvZE8UvzmrgwISaWBK12LN
 /17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524181; x=1737128981;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8SGU3dm929TVLGtNe5xapiGpX/+UNFGGDu8sfaDssmk=;
 b=iqsIpOWy/Dd+K4aZspMwaYkAIzf9q5V38F4P4OSH++FsartOjcLHRiG04rosLNChSp
 UZnyjzNiw8y/IPff5EJOEwuW3BpGhDjfMtcZ/UOaraSQOPMCRtnMl9sUmbk5CL1L4eMk
 RQEhZkXUnCeaiGw5o0U1j0cCd15rEyIhzNrbeYb/sJHiyzKVffuqrsWO5cwg9P9CIr9P
 5ihEZVYuKCtrz6cvFxGfEcljy1Bi1BXIO1ffUgNbYl4aapT64xyiAhcaEVWHWjimSwss
 N5rYw1pWNN6/aJJwsP32A9F0d/mTnkcnxMXOez2nnOy26S7rTV7A8yXgWxydtENo/hYi
 Ncjw==
X-Gm-Message-State: AOJu0YwICUxmC0zaSc7vlrMFqsDuvKiUbdCbBRQMNv2gxD3qB5TYJUOj
 8L2E0UNWlzZU+N5FJOS3wCIVae8LulMBHbfohJ7TohaeQgWsBQ8ur+nMnXMbH7UUzR7WudQST8u
 MAuzAtwle6ilg9/PXvFSSHRm2dIFX4g==
X-Gm-Gg: ASbGnctqBLjZVqBFojJTPL9IVLm5dxEGItHEFpoVk5dBGqpdznqXJ9ZMUfNhKN7FyOR
 FIMTvpo5LnK77RXJ0q5VQUX2XtG8Gz+XLDwZd
X-Google-Smtp-Source: AGHT+IFfvqF1tpphQjt6grZ65k6mdRP/qT3zc9kc3vfggrZPVGRdDHyPh5wfT8StM3X7hu2wVLBYXj7OhxOiu1LjMso=
X-Received: by 2002:a05:6402:358c:b0:5d0:d84c:abb3 with SMTP id
 4fb4d7f45d1cf-5d972e4c9a7mr9794474a12.26.1736524180930; Fri, 10 Jan 2025
 07:49:40 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 10 Jan 2025 10:49:28 -0500
X-Gm-Features: AbW1kvb8TC7QevnW-tWWvtTDVaGvyFvcRKhtsQ1yqnDeyYxV-UwdeVF-zt8AHDk
Message-ID: <CAJSP0QX3uAdcznuT1-oh+xtNGwxACC2E+DiCttpjBHmpA3W3+g@mail.gmail.com>
Subject: linux-user maintainership
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <Laurent@vivier.eu>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Richard,
I asked Laurent about his availability to send linux-user pull
requests. He mentioned that he has little time at the moment and that
you've helped in the past.

Would you be willing to add yourself to the MAINTAINERS file and
officially send the linux-user pull requests for the foreseeable
future?

Thank you,
Stefan

