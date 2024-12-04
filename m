Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6731EE7716C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 02:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIfLH-0000yI-K2; Tue, 03 Dec 2024 21:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIfL7-0000xg-Lt; Tue, 03 Dec 2024 21:42:13 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIfL3-0008CD-Ok; Tue, 03 Dec 2024 21:42:07 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-85bc5d0509bso623545241.1; 
 Tue, 03 Dec 2024 18:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733280124; x=1733884924; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ive4thOFfTGKeTe697+r0WelOthpL92EuPDcQ/8kBtI=;
 b=WjM3mnpFxrxQvlol007YwXV/jKUryEoIv3L5Ev33AX7vSYqi5CGgN07HwUbeQU3lLb
 DxyCvc0rswfIUdA1JdncoKHtcO4/qSaNAS4Vir6SRrZdR9WKsgBAfCV4lEEYNWTNooD5
 DlfRRCxwzXeKKl3+rRKdSf33YSaDlSO108S0sNwrnay2jnt3GTlUA9qzEgFqlwgoVA0T
 XZn+bDZdQSIcph5DvhA8iTIceVmObzg95nIrAeZxxMBa4oEda0rH4VREYiVR65psCJLZ
 2dzFdAHniMVOt/VxmaxgY4hE3hMlzQNIEszjcIlpy5UgtHeiPuAmLNWCqOgeNfuMfTEs
 v2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733280124; x=1733884924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ive4thOFfTGKeTe697+r0WelOthpL92EuPDcQ/8kBtI=;
 b=AQXD+aOgcs3YNmHuQglauFMCi2VFkHF24yc1VWUf89vq080+P0PuZSPHXLAWFwr9jM
 /67Eby/3yxVCJ28RKa/7v01Pxv+1eols5AgeVFx0z5wF9rwUZ/uMsBtOhLRGXxasu19L
 uAg8KoUKeZWdH7jhKslBKKFNL3yVLYOe3e/le/Is20Dn58vAHUnEoOdrmj8NXaR/vNqx
 ulC8r53+awyF0PCLqzN47gLRZi4sKRDumQduw2XOeTnU56aBnoZV3SUlHG2FAwwWfack
 vOb38YLv6wSTGd//OFKbwLB/87vpimJNlWtAmNHgIROJltSxuSU4CeJdnzENub1OlG3C
 S8ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR5x8MvjtOHEf8gRM/sfx2sbbNWkupgOveSNG3QELPO50aLZ0VAVA31TFSqsCfcOR0XOKmWenXjtoP@nongnu.org
X-Gm-Message-State: AOJu0YxQXzTtEq4ozl7ob//QFH6RZK9yfGk3BPemr/Ee3K4LKMVP0C0C
 GZm7a4aOrWCsGuNms/nwVfIWac6RyFEw9SrPe7pWApuOTojTjipt1PjF2pLNkQyaAqqCogweDt1
 Y+nspkZ+geFIld9MnDOM6Uw392ZQ=
X-Gm-Gg: ASbGnctNPfPV9Uqy3cGI4obVTI/478JiuhEQigVtFqLWSTG9Zq/+AYc+MMeDBJuy4D6
 Vhx7WfeM4pLrJX7lvb1ed6GuEJapDKSAC
X-Google-Smtp-Source: AGHT+IHeFGE3j4QYrG6cXqaq2Hf6ZosCbiQJ7NEcB3csv5sxdgFLPkz4ZFp1UpFoWBD6W3XZ+oGjIdrbw7Gqc+PfoIU=
X-Received: by 2002:a05:6102:3753:b0:4ad:4b64:530b with SMTP id
 ada2fe7eead31-4af971f8e6amr7530990137.3.1733280124070; Tue, 03 Dec 2024
 18:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20241203200828.47311-1-philmd@linaro.org>
In-Reply-To: <20241203200828.47311-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Dec 2024 11:41:38 +0900
Message-ID: <CAKmqyKPsYhaccN4+XoZgc5H_YyL=M5FJE57N3vsjywRfyNALBg@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/riscv: Include missing headers in
 '*internals.h'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Wed, Dec 4, 2024 at 5:09=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> 2 trivial RISC-V oriented patches extracted from a bigger
> series which refactor include/exec/ headers.
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   target/riscv: Include missing headers in 'vector_internals.h'
>   target/riscv: Include missing headers in 'internals.h'

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/internals.h        | 3 +++
>  target/riscv/vector_internals.h | 1 +
>  2 files changed, 4 insertions(+)
>
> --
> 2.45.2
>
>

