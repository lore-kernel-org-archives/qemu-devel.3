Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C94C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 11:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umA7U-0007K4-N0; Wed, 13 Aug 2025 07:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1umA7S-0007JI-4M
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 07:58:14 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1umA7N-000385-Kn
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 07:58:13 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76bc5e68d96so5883543b3a.3
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1755086284; x=1755691084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DdhYsP/TsnadyLdS0/3dTidJD7nO3g952mgLkI/We1c=;
 b=ClmQaE5cPqSARR586yPalDVNMwZDw9BKob3vcLyocb6Ins6aCM8K+F9PuvwPTSDRbc
 9xWzlT08Tp9CORc+YxVKKLgzlxh3wgLEIVWdNcVyIzyZyW0hxp2B+komqku2/w7lph4k
 ys5V8j2v4+iPthiEyqjThqJ4bw1DrWa4Drv2CO0eB2Uphl/EmYb6YIwDZCIPqBDL9juT
 moHJLNN13jdMLeztE687wApSChEUzTfYeNpQyp3jn9NnaiTRb/0H6xTbdIzHWmx7axkX
 rRzQ3knviAiMlYWGFZ//x/SIii9NTSgwyUpAuwTNBoXD2nxaN9sN9dpY0PDIHoN5iNjZ
 jniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755086284; x=1755691084;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DdhYsP/TsnadyLdS0/3dTidJD7nO3g952mgLkI/We1c=;
 b=Fsn0sno5jsN+QUyTomlQlLHYvRlGHoUxfG9VXf7+8CL0A8DSps8x+GznuSMvB8AV8d
 vvuaUYJxRHhSLj+kWETHJri2ouMLL+drbK293B+9A6AQZ+pKs2uQE2rcin1e96E4dt0h
 H5sQi66KqerdvjuF+JiKLAGk/tCU2qqlncxR3izyMVIRuOvy+ezzd38QTj9E8UEtDzNK
 iHfmWGXr/ssKlhiqbuQFx2Y1lNudcBPGNBrzChlz6f46eXHiE5YbCEhlYrmnNXdkcOv1
 1T+y3usWBTm/L5A4ZvpJnAMjpay4u2fRuM7qWnNqXy7Lvf2iNQANfqSc+WWTulx8v2/e
 CDxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg1uGzH+ZkhzRbMGxgmIgvOMwUFMVb1GYtxEBUhcwQnElZeUeDjUruHL7pBQdIYG1ftL5lQ5yIw+DK@nongnu.org
X-Gm-Message-State: AOJu0Yzfg6BnP3amVLfSs0U6siTvZwt0EQHG4q+8nTIAlHrx4TH37w50
 yLGkTmMJiT//5kYvHjJCArkARx92LJtkuvosTS6ux8+hiCxhhXErBXODHiMfAwx1QMdkkDT6ClM
 xVoX8
X-Gm-Gg: ASbGncuFpULyO3yL1XyBQ6c7l2MbvXwxycc4+QDbwYdk3oTv/EydLoSc8w2aIEKGlew
 lKa+fU7wAzmMqETaWddwGN0FMQNaoAMRMOtoBJzVfTcfkR44U7rHGSgoLxDBJ69/54dhHq56aSd
 9iUs9asi1oTjukewwkx+FLi34JNVEEkpmrdl662RYqPbDjvH5GTptspWlo9Ij04/SfOgzgY3bcc
 CDUZgt5wONlhCBgeFyFeeRFHI5ftpQABEARxGPL2+VAA2oI78qMfhl/yZItddjIiSM61xRlQgup
 DpXnzgA0CpI3C63TlsdSVjFUPf8ZJXoFuYmn2vVNskO7R/GE68J5gontuMQpN2XBnnF2AW+gTjV
 2nJWTg7BTUKZw3AnO75P62k+ZjGwLcdRjn0/pJOCI9ZaVZUeY
X-Google-Smtp-Source: AGHT+IHGyIsAK55gD5EtQroZLCVqbiETdyTLxqzSaQJOxiDzz8BaPg+QxiSIRnslMyqJkVoFTMeuSw==
X-Received: by 2002:a05:6a20:748e:b0:23d:58e9:347a with SMTP id
 adf61e73a8af0-240a8b0c458mr4752875637.26.1755086283932; 
 Wed, 13 Aug 2025 04:58:03 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.127.110])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3232553e4a2sm3128a91.4.2025.08.13.04.58.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 04:58:03 -0700 (PDT)
Message-ID: <d4251660-c05b-42e4-8838-e25b5ee39e0a@ventanamicro.com>
Date: Wed, 13 Aug 2025 08:58:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: riscv-iommu: Update status of kernel support
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250813055225.410620-1-joel@jms.id.au>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250813055225.410620-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
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

Hi Joel!


Thanks for this update. Any help keeping the docs updated is dearly appreciated.

A few comments:

On 8/13/25 2:52 AM, Joel Stanley wrote:
> The iommu Linux kernel support is now upstream. VFIO is still
> downstream at this stage.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> Daniel, the wording might require some massaging but I thought it was
> best that we update the status of the kernel support. I ran some boot
> tests with v6.17-rc1 and the examples seemed to work.
> 
>   docs/specs/riscv-iommu.rst | 35 +++++++++++++----------------------
>   1 file changed, 13 insertions(+), 22 deletions(-)
> 
> diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
> index 991d376fdc24..19a0ecdbe4c1 100644
> --- a/docs/specs/riscv-iommu.rst
> +++ b/docs/specs/riscv-iommu.rst
> @@ -30,15 +30,15 @@ This will add a RISC-V IOMMU PCI device in the board following any additional
>   PCI parameters (like PCI bus address).  The behavior of the RISC-V IOMMU is
>   defined by the spec but its operation is OS dependent.
>   
> -As of this writing the existing Linux kernel support `linux-v8`_, not yet merged,
> -does not have support for features like VFIO passthrough.  The IOMMU emulation
> -was tested using a public Ventana Micro Systems kernel repository in
> -`ventana-linux`_.  This kernel is based on `linux-v8`_ with additional patches that
> -enable features like KVM VFIO passthrough with irqbypass.  Until the kernel support
> -is feature complete feel free to use the kernel available in the Ventana Micro Systems
> -mirror.
> -
> -The current Linux kernel support will use the IOMMU device to create IOMMU groups
> +Linux kernel iommu support was merged in v6.13. Qemu IOMMU emulation can be


Nit: s/Qemu/QEMU


> +used with mainline kernels for simple IOMMU PCIe support.
> +
> +As of v6.17, it does not have support for features like VFIO passthrough.
> +There is a `VFIO` RFC series that is not yet merged. The public Ventana Micro

The VFIO ref link is wrong and it'll break the docs build:

[3006/3007] Generating docs/QEMU manual with a custom command
FAILED: docs/docs.stamp
/usr/bin/env CONFDIR=etc/qemu /home/danielhb/work/qemu/build/pyvenv/bin/sphinx-build -q -W -Dkerneldoc_werror=1 -j auto -Dversion=10.0.93 -Drelease= -Ddepfile=docs/docs.d -Ddepfile_stamp=docs/docs.stamp -b html -d /home/danielhb/work/qemu/build/docs/manual.p /home/danielhb/work/qemu/docs /home/danielhb/work/qemu/build/docs/manual
/home/danielhb/work/qemu/docs/specs/riscv-iommu.rst:36: WARNING: 'any' reference target not found: VFIO [ref.any]
ninja: build stopped: subcommand failed.


You missed a '_' after `VFIO` (yeah, rst is annoying):

  As of v6.17, it does not have support for features like VFIO passthrough.
-There is a `VFIO` RFC series that is not yet merged. The public Ventana Micro
+There is a `VFIO`_ RFC series that is not yet merged. The public Ventana Micro
  Systems kernel repository in `ventana-linux`_ can be used for testing the VFIO
  functions.


With the build fix feel free to send a v2 with:


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


Cheers,

Daniel

> +Systems kernel repository in `ventana-linux`_ can be used for testing the VFIO
> +functions.
> +
> +The v6.13+ Linux kernel support uses the IOMMU device to create IOMMU groups
>   with any eligible cards available in the system, regardless of factors such as the
>   order in which the devices are added in the command line.
>   
> @@ -49,7 +49,7 @@ IOMMU kernel driver behaves:
>   
>     $ qemu-system-riscv64 \
>           -M virt,aia=aplic-imsic,aia-guests=5 \
> -        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
> +        -device riscv-iommu-pci,addr=1.0 \
>           -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
>           -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
>           (...)
> @@ -58,21 +58,11 @@ IOMMU kernel driver behaves:
>           -M virt,aia=aplic-imsic,aia-guests=5 \
>           -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
>           -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
> -        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
> +        -device riscv-iommu-pci,addr=3.0 \
>           (...)
>   
>   Both will create iommu groups for the two e1000e cards.
>   
> -Another thing to notice on `linux-v8`_ and `ventana-linux`_ is that the kernel driver
> -considers an IOMMU identified as a Rivos device, i.e. it uses Rivos vendor ID.  To
> -use the riscv-iommu-pci device with the existing kernel support we need to emulate
> -a Rivos PCI IOMMU by setting 'vendor-id' and 'device-id':
> -
> -.. code-block:: bash
> -
> -  $ qemu-system-riscv64 -M virt	\
> -     -device riscv-iommu-pci,vendor-id=0x1efd,device-id=0xedf1 (...)
> -
>   Several options are available to control the capabilities of the device, namely:
>   
>   - "bus": the bus that the IOMMU device uses
> @@ -84,6 +74,7 @@ Several options are available to control the capabilities of the device, namely:
>   - "g-stage": enable g-stage support
>   - "hpm-counters": number of hardware performance counters available. Maximum value is 31.
>     Default value is 31. Use 0 (zero) to disable HPM support
> +- "vendor-id"/"device-id": pci device ID. Defaults to 1b36:0014 (Redhat)
>   
>   riscv-iommu-sys device
>   ----------------------
> @@ -111,6 +102,6 @@ riscv-iommu options:
>   
>   .. _iommu1.0.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0.0/riscv-iommu.pdf
>   
> -.. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@rivosinc.com/
> +.. _VFIO: https://lore.kernel.org/linux-riscv/20241114161845.502027-17-ajones@ventanamicro.com/
>   
>   .. _ventana-linux: https://github.com/ventanamicro/linux/tree/dev-upstream


