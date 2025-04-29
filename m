Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87592C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9n2j-00067u-Ri; Tue, 29 Apr 2025 11:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9n2d-0005x5-VR
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:38:42 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9n2a-0007TE-Qg
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:38:39 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2295d78b433so66794545ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745941111; x=1746545911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4X/o6Ng7YOgKtbY26XYwqfmdSIW4HxnxW6HOaZhTIs=;
 b=Yy+nccdJpzhZ2qAuBdXDV1LJvEZ/k7zk7NWXzuqCQNzLJ1yIv/Iv/gLVzjn8EPZqNy
 olbASEua2OMy26BjQl4CaoHWHkkgTPfsXUZ8nYKGk5Gt8JeU1x1xs9m9NfvPIp9chZkj
 AReYlPYvKVcEymzCnI+Ws08PaFlyjz/QPqZiTWYzoNODThPRgai1QilIWrJAT+aziAUj
 i4mA+W6qnn0F/NH9NPexyqfdVUfA3kw049JUcdRiRog2xxMAGC06+A8NTH2cHglItC9p
 x7RnwmkKzwgwlKrZBWNxLDXp1M1p0QTvLrVmQSLV4f/K5Pb7fpWKm45vUkZIXDBI/vV2
 /ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745941111; x=1746545911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/4X/o6Ng7YOgKtbY26XYwqfmdSIW4HxnxW6HOaZhTIs=;
 b=ALrsK1rUWfbGtJKh49vUx2HYyx2sgw6/8PWn5p+anqyEOe6l8mEPDIFdFheD0pgorA
 aEHKCZnvHxx3ik5sYFYB4ylK1VK1l+uKP24PHSBiIXEduh2H2YgUP1LWL43MkYjDnYM6
 kkVKZDW+L5kZr/k2gQ2ekApQYC8gPYHg5q6TuR1+DqJ0NFvBMfvfHBVlsi09Oa8dY0WG
 9ds3if6INF4V15M5TbcpdudSM1ltGMGI/WlEw8Whdyxp6qtOUBFFG3AhpfLyOpIyfKTu
 oxlZNoUJQIGI7/UmyQfMl3TDmMHZi9pu0kYlTIwrONLmXnZhZ3/LCsVZrxOhHvCN8fiC
 O2Dw==
X-Gm-Message-State: AOJu0YwbZBsReDkioHjaynjID1G5Ac96kDgSh7Rgb/H2y3qxN1x+GIgb
 i+mGjUeJq6tt1iV4PjGXlxUNRrCMR3+SGwEjPT33kq2IUZw1BIk=
X-Gm-Gg: ASbGncuVX6/z/4T4vDtlZeoTUk8WhMG/pqGIgJo8kbXyrhb911Bt9DMk3EudUHKSVre
 APqFXO+2JbK3aVldEOe2Lh+n8FMhSo5ahRyhH+eHFlvX+e7Nm1JGMTZ1ubFMRGC3s5YK4PNtotp
 SYiRnbnW1jaElZ5cDqS1Al0mt68W660Ias0z2DkpgfZIuVRqW6IEqfx+j/Ej1k514mBsU0b1w/T
 ghl6UYI5iPGQVo4WtewMYxjfNNa8RPqMn8baPAb7/d4V9FFuYSF/WjT8K+Fb6j1pZSwzkxNFoNK
 x2ix/pxSad0GjVY5Q4nRKd89ufSX4oiFl+zTFh62EQN5mlZqYblUZiLqMuIDh2g=
X-Google-Smtp-Source: AGHT+IHp89QaRn7u9gMiQsKnI3R7ms3twm7Ep2r3aUkyIzML/K9oq/asuFvp6sWkRM6H00kZ30NxRw==
X-Received: by 2002:a17:903:1a05:b0:21f:3e2d:7d42 with SMTP id
 d9443c01a7336-22dc6a08d51mr210827455ad.23.1745941111335; 
 Tue, 29 Apr 2025 08:38:31 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.182.191])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db51025aesm103905365ad.188.2025.04.29.08.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 08:38:31 -0700 (PDT)
Message-ID: <7b0186ad-5ced-4d4c-841d-477a9e186f0b@gmail.com>
Date: Tue, 29 Apr 2025 23:38:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] vfio/igd: Only emulate GGC register when x-igd-gms is
 set
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <C.Koehne@beckhoff.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
 <20250428161004.35613-9-tomitamoeko@gmail.com>
 <806ee35261d6e032b5b06bffa419f941dc3a8a4e.camel@beckhoff.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <806ee35261d6e032b5b06bffa419f941dc3a8a4e.camel@beckhoff.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
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

On 2025/4/29 14:28, Corvin Köhne wrote:
> On Tue, 2025-04-29 at 00:10 +0800, Tomita Moeko wrote:
>> ﻿CAUTION: External Email!!
>> x-igd-gms is used for overriding DSM region size in GGC register in
>> both config space and MMIO BAR0, by default host value is used.
>> There is no need to emulate it in default case.
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>>
> 
> Is the GGC register writeable after UEFI or is it locked? If it's writable, I'm
> wondering what might happen if the guest writes to the GGC register to increase
> DSM region size.
> 

The document says its is read-only mirror to the Graphics Control register
in Host bridge (00:00.0). In guest, the register being mirrored does not
exist, and GCC seems to be a scratch register that only used by software.
GOP driver setup DSM according to the value emulated by QEMU, this can be
confirmed with intel_gtt tool in intel-gpu-tools. 

Setting GMS to 128MB do solves the strange issue that screen flickers on
4k60Hz display when host value is 64MB. Since the GOP driver is closed-
source, I am unable to explain this, but it works. 

Memory view of IGD passthrough looks like below. The emulated GGC register
is responsible for the size of Guest DSM region, there is no impact to the
host side.

       IGD Addr Space                 Host Addr Space         Guest Addr Space
       +-------------+                +-------------+         +-------------+
       |             |                |             |         |             |
       |             |                |             |         |             |
       |             |                +-------------+         +-------------+
       |             |                | Data Stolen |         | Data Stolen |
       |             |                |   (Guest)   |         |   (Guest)   |
       |             |  +------------>+-------------+<------->+-------------+<--Guest BDSM
       |             |  | Passthrough |             | EPT     |             |   Emulated by QEMU
DSMSIZE+-------------+  | with IOMMU  |             | Mapping |             |   Programmed by guest FW
       |             |  |             |             |         |             |
       |             |  |             |             |         |             |
      0+-------------+--+             |             |         |             |
                        |             +-------------+         |             |
                        |             | Data Stolen |         +-------------+
                        |             |   (Host)    |
                        +------------>+-------------+<--Host BDSM
                          Non-        |             |   "real" one in HW
                          Passthrough |             |   Programmed by host FW
                                      +-------------+
Thanks,
Moeko

