Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD92C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuo6I-0006c0-T5; Fri, 14 Aug 2026 05:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wuo6C-0006a1-3n
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 05:21:12 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wuo68-0001D9-63
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 05:21:11 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2d319b84213so1516575ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 02:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786699266; x=1787304066; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Jk04pDwNI+XbQPIptlMVKxZ1+rUDm09s/pVnGWhN38M=;
 b=Th22qsKa2168rGcuQFldErMhFtKRLaIpuQxQ95UxKrdlY9iNSqkBJor4Hiftn8mM/h
 /7ihOzOmzL3snRUkIIfSajV6Ny7l3oTTylddNAhZ4IYO/F6AKuljXQbEANpoMfDBy71O
 2bAvX3E7J5JAsznTxCEQqw9kg2Z80Nj7jyEmUYuo2MaxhTu5xvHtYb+JwiejDNyvWJYM
 J7dsshp4Rg18Ya/HyUs9DgNeMfGIH9HtV6VyBJfVy3OytMzb/UxPqr3vOsjRgDQQPuEa
 oyHagoGcK2EWcBGE+jJihQEghTR2ITbOQHMLdVzhT/hCfUX8TgQjS7QXBfSmb3jPJdnj
 YPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786699266; x=1787304066;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jk04pDwNI+XbQPIptlMVKxZ1+rUDm09s/pVnGWhN38M=;
 b=bLaRkbLtzvv+T3wqfV37kA4gs46tfoUUC2nfsTYxsxN47r2cnUss4D0M/AHpOOmavn
 dLlKnuAq5xaSzvV03qqp8AUU7Si+wGhM0svrt03Jvw/SYrtKCQ7SOY4M6sF/06tOKcCk
 WkQ7ohN3HeYYE/yRL8T28bufdTMhIY4GOC/PFro+wLk4Ofh8GpPNGNGqTRK8BKa6IiJo
 IZLD8rig2H1uMpL1OLLCPbw7qAc7neh5G8vDlZV+PC7hzk3xSAJky0Q8dazIuB5F4izX
 zZxUtW9Bd9xDoPzOSWmFVHNo8QK5qu1msjpR5TncJe/2AzJcQ3N+kQvxVpfpAbceMKuN
 VgFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpQfFG+L0D1VYS7A5yQsqeNURYjuer+iRCmWGEy28395voUgbiRpafccftCnnbqnD7EOFSMovAK/Zw@nongnu.org
X-Gm-Message-State: AOJu0YwJCkC5olgJB+ZdoI7qLIzeNwR/4M/hMfYeleRtoJE+DRCKiID2
 udwMZ6N1h19vdPeokXxNJ/6phYyjJK6oU9ez1rzgy/ja5SHZ3yFAnq/y
X-Gm-Gg: AR+sD13mkMHdl0K+YkHE1c5fHM/waE+czXd+vlH7mlqTP9U/38LDeJXdHCN1i3mZ9Q8
 AwCnPfMo5VXY4XU/LFDG/d1x3DgQOjhMMCRCGDaeodobEfCnFzJxkT6Yh1aFQwkQYR+wnfE3EX5
 AzMkcfAWqi5KXGESCB9BtwahDMgc6aMGDmN1y20BXucnPIpz/PXvjEKm23enKY7MtaRGwH23wuQ
 b+pcATJfVY51hfr6CLsjTNbnR6lq2cazFIG88s71EW6q3UKeF6Iou1P//g5Xt7fhf/jpMvc8vsR
 te6XmRWq6cw9s1hnoPjeEXT85gXjOB4G1/sEaYhabEh3XJ716gBlwAx41XetgTkhQ78YZdBfKim
 n2uOuP3r/o/iN+x2rqKvw0DT6kP5cDk0bLwWpNfY6cnpH0ksKRWc8W2r3AD+s8IFppXvLg49v3T
 +jYGEcdYpBnN5rqDvkB6kJ8SnJDFqT/Hq5Q1HpSp2Q9kZZiQW/rTMAeKdqWLgcMB+6Tfay
X-Received: by 2002:a17:902:f651:b0:2d0:2741:f31b with SMTP id
 d9443c01a7336-2d3b0edea85mr38433165ad.4.1786699266285; 
 Fri, 14 Aug 2026 02:21:06 -0700 (PDT)
Received: from [127.0.0.1] ([38.34.7.236]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320d5bd9fd3sm2317005eec.4.2026.08.14.02.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 02:21:05 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] hw/gpio: add K230 GPIO controller model
From: Junze Cao <caojunze424@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: guochun wang <guochun.wang@foxmail.com>, qemu-devel@nongnu.org, 
 chao.liu@processmission.com, pbonzini@redhat.com, farosas@suse.de, 
 lvivier@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
In-Reply-To: <CAEUhbmWjR3cc4jkdBAqpXcmt9z3ExHWsPzCthX7d+G1wgqTbTQ@mail.gmail.com>
References: <tencent_EF996EEB2215272639C89FAE1491CEF43908@qq.com>
 <be7afd5c-55dd-4af1-b828-9a2f401e3bfc@smtp-relay.sendinblue.com>
 <CAEUhbmWjR3cc4jkdBAqpXcmt9z3ExHWsPzCthX7d+G1wgqTbTQ@mail.gmail.com>
Date: Fri, 14 Aug 2026 17:20:59 +0800
Message-Id: <178669925995.92831.6332189576763663701.b4-reply@b4>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=caojunze424@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 2026-08-14 15:26:41+08:00, Bin Meng wrote:
> On Mon, Aug 10, 2026 at 4:02 AM guochun wang <guochun.wang@foxmail.com> wrote:
> 
> > Implement a K230 SoC APB GPIO controller model for QEMU, derived from
> > the Synopsys DesignWare APB GPIO (the Linux gpio-k230 driver is based
> > on gpio-dwapb.c and shares the same register layout), with a
> > Canaan-specific compatible ("canaan,k230-apb-gpio") and hardlock
> > integration. The model is capable of running the Linux gpio-k230 driver
> > and driving external input/output lines. Behaviour follows the K230
> > Technical Reference Manual v0.3.1.
> 
> Please split the k230_gpio model into 2 separate models:
> 
> - One is generic Synopsys DesignWare GPIO IP model
> - Optional Canann K230 specific wrapper glue model to the dw-gpio IP
> (if the generic Synopsys DesignWare GPIO IP model, or plus some unimp
> region, is good enough to make the software happy, no need to create
> this one)

Hi Bin Meng,

Thanks for the detailed review.
Regarding the suggestion to abstract this into a generic Synopsys DesignWare APB GPIO model, I have a question: do you know of any other QEMU SoCs that use this IP and would benefit from a shared model?
If there is no immediate second user, I wonder whether it might be premature to generalize now, especially while we still need to complete the K230-specific behavior.

Thanks,
Junze Cao

