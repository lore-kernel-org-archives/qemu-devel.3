Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C71C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHh8I-0006xx-VC; Thu, 13 Jun 2024 05:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHh8G-0006qI-L2
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:52:37 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHh8D-0002Ud-LN
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:52:36 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ebd95f136bso8548071fa.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 02:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718272351; x=1718877151; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aLogVWHAGRbH0gsjEVsGMBY9pF7extElnz5kVcP2ry0=;
 b=KR2NUao0HlhHA5tG+zBao21WXp2V+p0U5gbbqmBUDv/ur7dNNFqAXhRIBm0g/DCP7d
 hNcVErBolhaf4jVHdiRlUwTVhpRS9ibi70otJhIQhx5mQxAB/EJXMppGFhmaXnadh/Zo
 B4ypwSNAeGvkOZbrZ//nBlqquJ1PlvLRz0A0kdce7eRCB8DMnNcsCI+mrRZL4tGUQjWx
 nTh6jc1kK+ZeQnPaRAHax1u/PhlcGbBOvyF5MI74JgkpqGlsyrKBbyOcGuxdX7ILmoBS
 ooCKWcnJ+qf3I8Q3qeTtwm/b305lh0Qiqa5UAVk0IvTocYis+agJaIWomF6J/KRE3RSw
 o7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718272351; x=1718877151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aLogVWHAGRbH0gsjEVsGMBY9pF7extElnz5kVcP2ry0=;
 b=P0Il9/yN1ndbbYtZCT+xY+FBq5h88Dmcrcr6ua2Bh6sTgONJ1gz7CkVTKx+h+YHUmp
 g3j/8jzJ8dXdf6WVz9UksQyloldssu9uU8WHnnjqPSLezWBDlUsI1Q7tgj9GZZp4DeUG
 TKzsf48VjIpbwHUNgZ3fkBzqhSCVIP9/pbTPB50Dsl+sHhJCVrnHpRmNPYsopT7hdIiD
 vw08p3xTU8W2BRV7PteBNkS595+c0tAi0ZWAR3PsPuE+kKRhvfpGCP+WVryPKn156Zvm
 vvot9VSiS+Jey6msCTKmRqs367ILCedxm437FK1zmeMhRaqmQKRh83rZFHyR7zFC4zQa
 8cWA==
X-Gm-Message-State: AOJu0Yw1eO5JGfQstUJ8II+o0RVqD+3cNtOJt0isrRp2Mc8ywStx87BW
 jL4k9n+DIt22CIRFcqNbka0C9PH2JWWVr0Jp4nDT3K19vxDaWAfVgveAqIySeKcvBNNfpa3m19A
 aw3BXJCic6DBR03RiGA4vNWDVGzbTajSO5YsgZg==
X-Google-Smtp-Source: AGHT+IEJOZAGM7AxkDTXtjs/DdB5fNEBUIeQ1dETRGezPEIcKZFuoW0t7r7galVwGyP3isRuLhliDtJNHWD4FBb1rR8=
X-Received: by 2002:a2e:850c:0:b0:2eb:e580:7ac7 with SMTP id
 38308e7fff4ca-2ebfca6023emr25131191fa.43.1718272350888; Thu, 13 Jun 2024
 02:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240612081416.29704-1-jim.shu@sifive.com>
 <20240612081416.29704-3-jim.shu@sifive.com>
 <ZmqEzUPsJwFs7w4+@ethan84-VirtualBox>
In-Reply-To: <ZmqEzUPsJwFs7w4+@ethan84-VirtualBox>
From: Jim Shu <jim.shu@sifive.com>
Date: Thu, 13 Jun 2024 17:52:18 +0800
Message-ID: <CALw707q1oSVZhq3kYEkbDvgZFV_bydN6EGgFpScbyE=6SSD9Yw@mail.gmail.com>
Subject: Re: [RFC PATCH 02/16] accel/tcg: memory access from CPU will pass
 access_type to IOMMU
To: Ethan Chen <ethan84@andestech.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, 
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=jim.shu@sifive.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Ethan,

Yes, this mechanism could handle such situations.

The important part is that the translate() function of
IOMMUMemoryRegion only returns the correct permission of the section
related to CPU access type.
For example, if wgChecker only permits RO permission, it will return
"downstream_as" with RO perm or "blocked_io_as" with WO perm.
(depending on CPU access type).

When the CPU access type is different from the previous one, it will
get TLB miss due to mismatched permissions.
Then, it will try to translate again, find the section of another
access type, and fill into iotlb. (also kick out the previous iotlb
entry).

This mechanism has poor performance if alternatively doing read/write
access from CPU to IOMMUMemoryRegion with RO/WO perm due to TLB miss.
I think it is the limitation that CPUTLBEntry doesn't support having
different sections of each permission. At least this mechanism has the
correct behavior.

Thanks,
Jim



On Thu, Jun 13, 2024 at 1:34=E2=80=AFPM Ethan Chen <ethan84@andestech.com> =
wrote:
>
> On Wed, Jun 12, 2024 at 04:14:02PM +0800, Jim Shu wrote:
> > [EXTERNAL MAIL]
> >
> > It is the preparation patch for upcoming RISC-V wgChecker device.
> >
> > Since RISC-V wgChecker could permit access in RO/WO permission, the
> > IOMMUMemoryRegion could return different section for read & write
> > access. The memory access from CPU should also pass the access_type to
> > IOMMU translate function so that IOMMU could return the correct section
> > of specified access_type.
> >
>
> Hi Jim,
>
> Does this method take into account the situation where the CPU access typ=
e is
> different from the access type when creating iotlb? I think the section
> might be wrong in this situation.
>
> Thanks,
> Ethan
> >
> >

