Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAB8CD1296
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCyq-0004qb-Up; Tue, 09 Apr 2024 11:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruCyb-0004Wx-HU
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 11:01:36 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruCyW-0006Lv-O9
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 11:01:32 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e47843cc7so2996318a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712674886; x=1713279686; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P063UMJd2C/v4cS4tMFljvoGqVMnrkZzyxZow1N1X3s=;
 b=GALx88qDPIW4FCMc5uL2UMiOEzrpRNJNJ9GJXdXz9hiiuAW3jCLRU6me0twnM79eCf
 QUaiL4ZU5z7yu0e9kjlv49vzPCJPCVH0Wkvc9u04WM5P/R1RxrYJGUZ7A8Eni1bHpH+2
 Igli37K2e3cedS6zIuT+06AQsib8OHmymTtlXIkAwBLPHwxGkG9dhn70xpBQ68q+wv7x
 Fzx/ZOwnTcPk5nlrhVzOnT34Li1bgi3aZ/FZhxE1yMkuhNsVe2ohBGJG714BGnfykBRx
 Nopd/AlAHW0YTuaOjcJR310tIvOLDqCk/4a+j8S5keslOTOta1NH0t4Tt5ijqcXb1jkh
 vWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712674886; x=1713279686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P063UMJd2C/v4cS4tMFljvoGqVMnrkZzyxZow1N1X3s=;
 b=s9m0j72U/l/OupawCzsEYeb9iEt5dYOQ+ZmCmM4gNjz9iqOx39ybXwHpSft4A0fr5R
 TUSqzzASCslcxsQ57/L5mGmwwBKZyHcqaY97kZhxGup8Xc0oOkkmEnA5geDKI/AU/wpY
 gaEIg36TjbSYL3Nuz/xUHXKRLIGI48Onx4envOb3SF3pBc+FZYsqQA9DeCQV9lB/nON9
 pC3ODL+FlI5KK/kFJdOUv6gPyhwxJ47QclDYvqYFZAOOS7KlkopfhEX4BF3TsFK75Qbq
 DowYSwGGJqhB4vO0g9i23x3KNpPkDdavIJ1sQ6Y9hePvO77lJFfOEUM7q8sEiXH/0q9Q
 kCfQ==
X-Gm-Message-State: AOJu0YwKFI3PDaZaWg1iHMqqkyAc2ZgG7QOj0FKMlDwwqJRFvPSaBxvj
 FUv//omYMFwWJHWcjEbgsmOjHkNzQEs+e8Z23t0DksS7yYLptUvCyqS3aZlQfvR6wW8PkUaw6KR
 xfgPoS1fhefsHa/NCfHtznUU/VYGqBuzalv5EJQ==
X-Google-Smtp-Source: AGHT+IFE7IAGXiBGPfTHxC9fGkpZDC+/mxNBSbBSqFgx0/JFXhdDL2rdvQWnH2ailKqeR4WEqdVOu3Bw1MzoEGcjWWs=
X-Received: by 2002:a50:9e84:0:b0:56e:2b02:6140 with SMTP id
 a4-20020a509e84000000b0056e2b026140mr7779385edf.23.1712674886062; Tue, 09 Apr
 2024 08:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240409145524.27913-1-philmd@linaro.org>
In-Reply-To: <20240409145524.27913-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 16:01:14 +0100
Message-ID: <CAFEAcA-p_QzsrE2QO4u5-jA-gQGZ-F8KXKnKdg8Pek=e2BqcSA@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 v2] hw/sd/sdhci: Do not update TRNMOD when Command
 Inhibit (DAT) is set
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Bin Meng <bin.meng@windriver.com>, Mauro Matteo Cascella <mcascell@redhat.com>,
 qemu-stable@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Chuhong Yuan <hslester96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 9 Apr 2024 at 15:55, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Per "SD Host Controller Standard Specification Version 3.00":
>
>   * 2.2.5 Transfer Mode Register (Offset 00Ch)
>
>     Writes to this register shall be ignored when the Command
>     Inhibit (DAT) in the Present State register is 1.
>
> Do not update the TRNMOD register when Command Inhibit (DAT)
> bit is set to avoid the present-status register going out of
> sync, leading to malicious guest using DMA mode and overflowing
> the FIFO buffer:
>
>   $ cat << EOF | qemu-system-i386 \
>                      -display none -nodefaults \
>                      -machine accel=3Dqtest -m 512M \
>                      -device sdhci-pci,sd-spec-version=3D3 \
>                      -device sd-card,drive=3Dmydrive \
>                      -drive if=3Dnone,index=3D0,file=3Dnull-co://,format=
=3Draw,id=3Dmydrive -nographic \
>                      -qtest stdio
>   outl 0xcf8 0x80001013
>   outl 0xcfc 0x91
>   outl 0xcf8 0x80001001
>   outl 0xcfc 0x06000000
>   write 0x9100002c 0x1 0x05
>   write 0x91000058 0x1 0x16
>   write 0x91000005 0x1 0x04
>   write 0x91000028 0x1 0x08
>   write 0x16 0x1 0x21
>   write 0x19 0x1 0x20
>   write 0x9100000c 0x1 0x01
>   write 0x9100000e 0x1 0x20
>   write 0x9100000f 0x1 0x00
>   write 0x9100000c 0x1 0x00
>   write 0x91000020 0x1 0x00
>   EOF
>
> Stack trace (part):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D89993=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address
> 0x615000029900 at pc 0x55d5f885700d bp 0x7ffc1e1e9470 sp 0x7ffc1e1e9468
> WRITE of size 1 at 0x615000029900 thread T0
>     #0 0x55d5f885700c in sdhci_write_dataport hw/sd/sdhci.c:564:39
>     #1 0x55d5f8849150 in sdhci_write hw/sd/sdhci.c:1223:13
>     #2 0x55d5fa01db63 in memory_region_write_accessor system/memory.c:497=
:5
>     #3 0x55d5fa01d245 in access_with_adjusted_size system/memory.c:573:18
>     #4 0x55d5fa01b1a9 in memory_region_dispatch_write system/memory.c:152=
1:16
>     #5 0x55d5fa09f5c9 in flatview_write_continue system/physmem.c:2711:23
>     #6 0x55d5fa08f78b in flatview_write system/physmem.c:2753:12
>     #7 0x55d5fa08f258 in address_space_write system/physmem.c:2860:18
>     ...
> 0x615000029900 is located 0 bytes to the right of 512-byte region
> [0x615000029700,0x615000029900) allocated by thread T0 here:
>     #0 0x55d5f7237b27 in __interceptor_calloc
>     #1 0x7f9e36dd4c50 in g_malloc0
>     #2 0x55d5f88672f7 in sdhci_pci_realize hw/sd/sdhci-pci.c:36:5
>     #3 0x55d5f844b582 in pci_qdev_realize hw/pci/pci.c:2092:9
>     #4 0x55d5fa2ee74b in device_set_realized hw/core/qdev.c:510:13
>     #5 0x55d5fa325bfb in property_set_bool qom/object.c:2358:5
>     #6 0x55d5fa31ea45 in object_property_set qom/object.c:1472:5
>     #7 0x55d5fa332509 in object_property_set_qobject om/qom-qobject.c:28:=
10
>     #8 0x55d5fa31f6ed in object_property_set_bool qom/object.c:1541:15
>     #9 0x55d5fa2e2948 in qdev_realize hw/core/qdev.c:292:12
>     #10 0x55d5f8eed3f1 in qdev_device_add_from_qdict system/qdev-monitor.=
c:719:10
>     #11 0x55d5f8eef7ff in qdev_device_add system/qdev-monitor.c:738:11
>     #12 0x55d5f8f211f0 in device_init_func system/vl.c:1200:11
>     #13 0x55d5fad0877d in qemu_opts_foreach util/qemu-option.c:1135:14
>     #14 0x55d5f8f0df9c in qemu_create_cli_devices system/vl.c:2638:5
>     #15 0x55d5f8f0db24 in qmp_x_exit_preconfig system/vl.c:2706:5
>     #16 0x55d5f8f14dc0 in qemu_init system/vl.c:3737:9
>     ...
> SUMMARY: AddressSanitizer: heap-buffer-overflow hw/sd/sdhci.c:564:39
> in sdhci_write_dataport
>
> Add assertions to ensure the fifo_buffer[] is not overflowed by
> malicious accesses to the Buffer Data Port register.
>
> Fixes: CVE-2024-3447
> Cc: qemu-stable@nongnu.org
> Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
> Buglink: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=3D58813
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Reported-by: Chuhong Yuan <hslester96@gmail.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Peter, since it is your patch, can I replace the Suggested-by your
> S-o-b tag?

Sure, you can have my Signed-off-by or Reviewed-by tag, whichever
you prefer.

thanks
-- PMM

