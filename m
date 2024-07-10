Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD109C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 01:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRMBZ-0000Pw-F7; Tue, 09 Jul 2024 21:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRMBX-0000J5-Qw; Tue, 09 Jul 2024 21:31:55 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRMBS-0001NJ-VF; Tue, 09 Jul 2024 21:31:55 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4f2ec49e067so1977294e0c.1; 
 Tue, 09 Jul 2024 18:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720575109; x=1721179909; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wV+TO4+b9lnpg/Wg9YRKPKI5Rqu4BqPFcIU5j9kK+BA=;
 b=iYuo8nIBngECM2WSVY3yDSYUMCQYiAt8yn0Nm+9tvXIaqOMP6argj/AmV140Ta88fU
 AILnimQkEoQMRkhYHTaAv8vCrkvkOveeEy/txxZLIAe8TVf6BWl7Qeh0buuB2CH0Wzul
 yF1jDSkQ+R1HHS/UW/kC4gD93nVTVmqYverQD7kw2xM6kr7Pc+0ov7RWVmSPl9fHyNp3
 ndQEIK90FvWUAPzRnB67RxveNAivXqvJMeehr1e7gjZOWYXCsSHEl/E0LuKsS06AYF8C
 XkvfI0Q9FC2D9hBHii/dJRz644Mutk+UiF9t9CS/xLpEG6uRWYGcRo5fE+InaXhzTGfu
 YADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720575109; x=1721179909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wV+TO4+b9lnpg/Wg9YRKPKI5Rqu4BqPFcIU5j9kK+BA=;
 b=bIA1nFJGV89genzvtiBApHEYB+8tYI/TyjbKsGrxo++mXGWx6S0roL509B3EJ/9D4Y
 jytby3BjVozXbdQzPEz9cgrwPBJyyrYX85jPPEQ8isbkBhmK0jMnBJcgymfDSzr9wtsg
 JSfxS7ogFfjNrQc4Zmgth383an8hrOFfy6+raCLci9I5YpFOeAy9y1UYtkqWiE27LRsH
 g5emATf9ORFJPJC6uCqY/8N3xhS+3Ly4hDriQ2LwcgU0I/1NUp+AKgUwDpVUzwHA/5b1
 Gbu1hV2D0EYziyCqDjd7wE2s3/mHLfEhtN9Hnb5qUyHinMFlJ5GcGcTn+/3RyZDWQejA
 4/oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVU6kbYajcp0GMMSQKp6hY2rLUu3ddlQDEDcfyRyl8vlfMghQiiDG8UOnhd9K1Q9bdkyb2M9QJPjYJbKKHeUFSvg5hhEg=
X-Gm-Message-State: AOJu0Yx76g4wjp1YszL7Z/QgHS0htdjJJwdPbuspqRWAJZ+UH/I5PAD2
 RcujOy+mAYLMzGeBpHPOhAXl1IpGVVlgD0PxhKChRbShw7DufnfhS4ziK0UkS1adc5CYTk6Kx6f
 JhrQeCNrov9yAUXnjoBN3G8j0dSE=
X-Google-Smtp-Source: AGHT+IGe8XzIdP4+Dyj/MvWXqUi9aYBlOBYtNhVikG7rmduX0AR6/zD6ZMWUeCoKdwhVhxVNZCeaKnNkDpKlqVwCS7s=
X-Received: by 2002:ac5:c3c6:0:b0:4ef:58d4:70f5 with SMTP id
 71dfb90a1353d-4f33f15fea9mr3829328e0c.2.1720575108963; Tue, 09 Jul 2024
 18:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240708131645.1345-1-zhiwei_liu@linux.alibaba.com>
 <20240708131645.1345-8-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240708131645.1345-8-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Jul 2024 11:31:22 +1000
Message-ID: <CAKmqyKNOE2J95o0CRxDnxV-G4gmogaF-MoDsU7v+TF1hZ49brg@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] tests/avocado: Add an avocado test for riscv64
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, richard.henderson@linaro.org, philmd@linaro.org, 
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jul 8, 2024 at 11:22=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> To regularly test booting Linux with rv32 on QEMU RV64,
> we have added a test to boot_linux_console.py to retrieve
> cpuinfo and verify if it shows 'rv32' when using RV64 to
> boot rv32 CPUs.
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Something is wrong here, it should only be an Ack

Alistair

