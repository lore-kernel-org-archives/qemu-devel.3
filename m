Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2877CC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 09:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFVyT-0003Uc-Ba; Fri, 07 Jun 2024 05:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sFVyS-0003US-Cj
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 05:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sFVyP-00089k-NK
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 05:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717752805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=calqEVGxeOTZzIdKLDZjMqxID+dap78B5HHLPBqdEI4=;
 b=iWbFBNGya2iMaNMutOuTs4BeX2vCZdz/tiNp1bp8HIt3bbbtn6wttVJHx9Bl92XVIpZb9X
 CZBGFuhRUklC/uUI1pCOx2PFiYAsKjB46Ce6FHqUhANB4oOk5LOIq3F5rJst7njV3lRct9
 89HXKqTgl/A81wawj6dAbf68Qb6/NSY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-FWo2ruk1PVyPpPTVHNdFfg-1; Fri, 07 Jun 2024 05:33:22 -0400
X-MC-Unique: FWo2ruk1PVyPpPTVHNdFfg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2eaa6f40e15so17110441fa.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 02:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717752800; x=1718357600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=calqEVGxeOTZzIdKLDZjMqxID+dap78B5HHLPBqdEI4=;
 b=PsyASUN7gfvtF3NtPfTQv8BQaGoptQHL7VWEH3uGcsc3F/CUmX1k5E9TC2RjLPoKQm
 JKvmAnT8PkW4uZ44Cr74wknwMFEkjEFzbs6foLfdNbTHE5PNH7cVDHcUmzcAW6C3PAx9
 8ZFgM5KSRREOu99idtjcVPRbL4Wmr8HUcBl3U0Gd4QhzEivzt48mJ1xQVYKsJ5H94wHV
 iYInIUUy3oGU3PDE5SvlqQ6qUMLHVMIcgQ7AQXEmcSbUKr66XQqi2INE6exdceurjYWG
 nbAdcqMG3MQ8/70PIhZdefrorOjZGeLmwXS+HF7cwEvafi320AFRuUX5srKKKa5Kts1N
 ViAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLnURUCAXF65scF39rgziHXPyi6kKaw8v6nqQP1YAcN2P3+6Oq88TbT1Z+lHMwG4LgKmsBuNQ8chLJ66iAb9wCMLIaSgg=
X-Gm-Message-State: AOJu0Yy6ZLWqJSxwqfkKwU1GRyLYwGQNiAkMq5/tttqEeGGhdk8yRU7D
 NZHZlaG7BCiwkJesBycVK5KUOnZedlpa8N8u85X7VsbZIBDMvylF+SXC3oz/RpX+FWkda9/HgI0
 lOYaVl3Zpewwb3778HpawIQ6Ei3Q33rVzgScPoxZohqr748WSyeYJ
X-Received: by 2002:ac2:5de7:0:b0:52b:9c55:4dbe with SMTP id
 2adb3069b0e04-52bb9f84eacmr1609107e87.37.1717752800471; 
 Fri, 07 Jun 2024 02:33:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHssPT/X8c1d18OcMcNeOeKj8nrrvzxShuiJrA0Rz91ihIAj34p3CgBzqwQbi6RofPLvFYZSg==
X-Received: by 2002:ac2:5de7:0:b0:52b:9c55:4dbe with SMTP id
 2adb3069b0e04-52bb9f84eacmr1609080e87.37.1717752799857; 
 Fri, 07 Jun 2024 02:33:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:d5af:1ef7:424d:1c87:7d25])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8072b010sm218049366b.214.2024.06.07.02.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 02:33:19 -0700 (PDT)
Date: Fri, 7 Jun 2024 05:33:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Andrea Righi <andrea.righi@canonical.com>
Subject: Re: [PATCH v2 3/3] tests/acpi: pc: update golden masters for DSDT
Message-ID: <20240607053103-mutt-send-email-mst@kernel.org>
References: <20240607085903.1349513-1-ribalda@chromium.org>
 <20240607085903.1349513-3-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607085903.1349513-3-ribalda@chromium.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jun 07, 2024 at 08:58:58AM +0000, Ricardo Ribalda wrote:
> --- /tmp/asl-87N0O2.dsl	2024-06-07 07:20:54.081576394 +0000
> +++ /tmp/asl-4Q0YO2.dsl	2024-06-07 07:20:54.077576397 +0000
> @@ -1,30 +1,30 @@
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20230628 (64-bit version)
>   * Copyright (c) 2000 - 2023 Intel Corporation
>   *
>   * Disassembling to symbolic ASL+ operators
>   *
> - * Disassembly of tests/data/acpi/pc/DSDT, Fri Jun  7 07:20:54 2024
> + * Disassembly of /tmp/aml-NF1YO2, Fri Jun  7 07:20:54 2024
>   *
>   * Original Table Header:
>   *     Signature        "DSDT"
> - *     Length           0x00001AAE (6830)
> + *     Length           0x0000214F (8527)
>   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> - *     Checksum         0x0B
> + *     Checksum         0x59
>   *     OEM ID           "BOCHS "
>   *     OEM Table ID     "BXPC    "
>   *     OEM Revision     0x00000001 (1)
>   *     Compiler ID      "BXPC"
>   *     Compiler Version 0x00000001 (1)
>   */
>  DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
>  {
>      Scope (\)
>      {
>          OperationRegion (DBG, SystemIO, 0x0402, One)
>          Field (DBG, ByteAcc, NoLock, Preserve)
>          {
>              DBGB,   8
>          }
>

trim this part when you post in the future.

 
> @@ -168,102 +168,1058 @@
>                          ""
>                      }
>                  Local2 = AIDX (DerefOf (Arg4 [Zero]), DerefOf (Arg4 [One]
>                      ))
>                  Local0 [Zero] = Local2
>                  Return (Local0)
>              }
>          }
>      }
> 
>      Scope (_SB)
>      {
>          Scope (PCI0)
>          {
>              Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
>              {
> -                Local0 = Package (0x80){}
> -                Local1 = Zero
> -                While ((Local1 < 0x80))
> +                Return (Package (0x80)
>                  {
> -                    Local2 = (Local1 >> 0x02)
> -                    Local3 = ((Local1 + Local2) & 0x03)
> -                    If ((Local3 == Zero))
> -                    {
> -                        Local4 = Package (0x04)
> -                            {
> -                                Zero,
> -                                Zero,
> -                                LNKD,
> -                                Zero
> -                            }
> -                    }
> +                    Package (0x04)
> +                    {
> +                        0xFFFF,
> +                        Zero,
> +                        LNKD,
> +                        Zero
> +                    },
> 
> -                    If ((Local3 == One))
> +                    Package (0x04)
>                      {
> -                        If ((Local1 == 0x04))
> -                        {
> -                            Local4 = Package (0x04)
> -                                {
> -                                    Zero,
> -                                    Zero,
> -                                    LNKS,
> -                                    Zero
> -                                }
> -                        }
> -                        Else
> -                        {
> -                            Local4 = Package (0x04)
> -                                {
> -                                    Zero,
> -                                    Zero,
> -                                    LNKA,
> -                                    Zero
> -                                }
> -                        }
> -                    }
> +                        0xFFFF,
> +                        One,
> +                        LNKA,
> +                        Zero
> +                    },
> 
> -                    If ((Local3 == 0x02))
> +                    Package (0x04)
>                      {
> -                        Local4 = Package (0x04)
> -                            {
> -                                Zero,
> -                                Zero,
> -                                LNKB,
> -                                Zero
> -                            }
> -                    }
> +                        0xFFFF,
> +                        0x02,
> +                        LNKB,
> +                        Zero
> +                    },
> 
> -                    If ((Local3 == 0x03))
> +                    Package (0x04)
>                      {
> -                        Local4 = Package (0x04)
> -                            {
> -                                Zero,
> -                                Zero,
> -                                LNKC,
> -                                Zero
> -                            }
> -                    }
> +                        0xFFFF,
> +                        0x03,
> +                        LNKC,
> +                        Zero
> +                    },
> 
> -                    Local4 [Zero] = ((Local2 << 0x10) | 0xFFFF)
> -                    Local4 [One] = (Local1 & 0x03)
> -                    Local0 [Local1] = Local4
> -                    Local1++
> -                }
> +                    Package (0x04)
> +                    {
> +                        0x0001FFFF,
> +                        Zero,
> +                        LNKS,
> +                        Zero
> +                    },
> 
> -                Return (Local0)
> +                    Package (0x04)
> +                    {
> +                        0x0001FFFF,
> +                        One,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0001FFFF,
> +                        0x02,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0001FFFF,
> +                        0x03,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0002FFFF,
> +                        Zero,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0002FFFF,
> +                        One,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0002FFFF,
> +                        0x02,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0002FFFF,
> +                        0x03,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0003FFFF,
> +                        Zero,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0003FFFF,
> +                        One,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0003FFFF,
> +                        0x02,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0003FFFF,
> +                        0x03,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0004FFFF,
> +                        Zero,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0004FFFF,
> +                        One,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0004FFFF,
> +                        0x02,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0004FFFF,
> +                        0x03,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0005FFFF,
> +                        Zero,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0005FFFF,
> +                        One,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0005FFFF,
> +                        0x02,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0005FFFF,
> +                        0x03,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0006FFFF,
> +                        Zero,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0006FFFF,
> +                        One,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0006FFFF,
> +                        0x02,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0006FFFF,
> +                        0x03,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0007FFFF,
> +                        Zero,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0007FFFF,
> +                        One,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0007FFFF,
> +                        0x02,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0007FFFF,
> +                        0x03,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0008FFFF,
> +                        Zero,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0008FFFF,
> +                        One,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0008FFFF,
> +                        0x02,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0008FFFF,
> +                        0x03,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0009FFFF,
> +                        Zero,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0009FFFF,
> +                        One,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0009FFFF,
> +                        0x02,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0009FFFF,
> +                        0x03,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000AFFFF,
> +                        Zero,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000AFFFF,
> +                        One,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000AFFFF,
> +                        0x02,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000AFFFF,
> +                        0x03,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000BFFFF,
> +                        Zero,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000BFFFF,
> +                        One,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000BFFFF,
> +                        0x02,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000BFFFF,
> +                        0x03,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000CFFFF,
> +                        Zero,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000CFFFF,
> +                        One,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000CFFFF,
> +                        0x02,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000CFFFF,
> +                        0x03,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000DFFFF,
> +                        Zero,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000DFFFF,
> +                        One,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000DFFFF,
> +                        0x02,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000DFFFF,
> +                        0x03,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000EFFFF,
> +                        Zero,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000EFFFF,
> +                        One,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000EFFFF,
> +                        0x02,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000EFFFF,
> +                        0x03,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000FFFFF,
> +                        Zero,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000FFFFF,
> +                        One,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000FFFFF,
> +                        0x02,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x000FFFFF,
> +                        0x03,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0010FFFF,
> +                        Zero,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0010FFFF,
> +                        One,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0010FFFF,
> +                        0x02,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0010FFFF,
> +                        0x03,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0011FFFF,
> +                        Zero,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0011FFFF,
> +                        One,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0011FFFF,
> +                        0x02,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0011FFFF,
> +                        0x03,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0012FFFF,
> +                        Zero,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0012FFFF,
> +                        One,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0012FFFF,
> +                        0x02,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0012FFFF,
> +                        0x03,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0013FFFF,
> +                        Zero,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0013FFFF,
> +                        One,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0013FFFF,
> +                        0x02,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0013FFFF,
> +                        0x03,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0014FFFF,
> +                        Zero,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0014FFFF,
> +                        One,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0014FFFF,
> +                        0x02,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0014FFFF,
> +                        0x03,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0015FFFF,
> +                        Zero,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0015FFFF,
> +                        One,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0015FFFF,
> +                        0x02,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0015FFFF,
> +                        0x03,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0016FFFF,
> +                        Zero,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0016FFFF,
> +                        One,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0016FFFF,
> +                        0x02,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0016FFFF,
> +                        0x03,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0017FFFF,
> +                        Zero,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0017FFFF,
> +                        One,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0017FFFF,
> +                        0x02,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0017FFFF,
> +                        0x03,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0018FFFF,
> +                        Zero,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0018FFFF,
> +                        One,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0018FFFF,
> +                        0x02,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0018FFFF,
> +                        0x03,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0019FFFF,
> +                        Zero,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0019FFFF,
> +                        One,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0019FFFF,
> +                        0x02,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x0019FFFF,
> +                        0x03,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001AFFFF,
> +                        Zero,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001AFFFF,
> +                        One,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001AFFFF,
> +                        0x02,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001AFFFF,
> +                        0x03,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001BFFFF,
> +                        Zero,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001BFFFF,
> +                        One,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001BFFFF,
> +                        0x02,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001BFFFF,
> +                        0x03,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001CFFFF,
> +                        Zero,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001CFFFF,
> +                        One,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001CFFFF,
> +                        0x02,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001CFFFF,
> +                        0x03,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001DFFFF,
> +                        Zero,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001DFFFF,
> +                        One,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001DFFFF,
> +                        0x02,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001DFFFF,
> +                        0x03,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001EFFFF,
> +                        Zero,
> +                        LNKB,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001EFFFF,
> +                        One,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001EFFFF,
> +                        0x02,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001EFFFF,
> +                        0x03,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001FFFFF,
> +                        Zero,
> +                        LNKC,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001FFFFF,
> +                        One,
> +                        LNKD,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001FFFFF,
> +                        0x02,
> +                        LNKA,
> +                        Zero
> +                    },
> +
> +                    Package (0x04)
> +                    {
> +                        0x001FFFFF,
> +                        0x03,
> +                        LNKB,
> +                        Zero
> +                    }


Too much detail, include two-three examples, and then
just put in ....



> +                })
>              }
>          }
> 
>          Method (IQST, 1, NotSerialized)
>          {
>              If ((0x80 & Arg0))
>              {
>                  Return (0x09)
>              }
> 
>              Return (0x0B)
>          }
> 
>          Method (IQCR, 1, Serialized)
>          {
>              Name (PRR0, ResourceTemplate ()
> **
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  tests/data/acpi/pc/DSDT                     | Bin 6830 -> 8527 bytes
>  tests/data/acpi/pc/DSDT.acpierst            | Bin 6741 -> 8438 bytes
>  tests/data/acpi/pc/DSDT.acpihmat            | Bin 8155 -> 9852 bytes
>  tests/data/acpi/pc/DSDT.bridge              | Bin 13701 -> 15398 bytes
>  tests/data/acpi/pc/DSDT.cphp                | Bin 7294 -> 8991 bytes
>  tests/data/acpi/pc/DSDT.dimmpxm             | Bin 8484 -> 10181 bytes
>  tests/data/acpi/pc/DSDT.hpbridge            | Bin 6781 -> 8478 bytes
>  tests/data/acpi/pc/DSDT.hpbrroot            | Bin 3337 -> 5034 bytes
>  tests/data/acpi/pc/DSDT.ipmikcs             | Bin 6902 -> 8599 bytes
>  tests/data/acpi/pc/DSDT.memhp               | Bin 8189 -> 9886 bytes
>  tests/data/acpi/pc/DSDT.nohpet              | Bin 6688 -> 8385 bytes
>  tests/data/acpi/pc/DSDT.numamem             | Bin 6836 -> 8533 bytes
>  tests/data/acpi/pc/DSDT.roothp              | Bin 10623 -> 12320 bytes
>  tests/data/acpi/q35/DSDT.cxl                | Bin 9714 -> 13148 bytes
>  tests/data/acpi/q35/DSDT.viot               | Bin 9464 -> 14615 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  16 files changed, 1 deletion(-)
> 
> diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/pc/DSDT
> index c93ad6b7f83a168a1833d7dba1112dd2ab8a431f..92225236e717b2e522a2ee00492fb0ded418dc7b 100644
> GIT binary patch
> delta 1914
> zcmY+_OK#gR6a`RPmVc7`lmCBo0R=kA0^&G>phg?inPg;S4auBYNk<(QD7uD@yN<4c
> zy?hjfcW1ixyAY2k+COjp9<$Ts^z`+EF^%V6*~i2_e7|0f*U|ay@$TW%^#1Mo`0dI3
> zn4Dj;_cBj&=gj%b=aUK74P4)vvhbg03BoakCc>R5`)T1^!}!jnPQHb~LHJI37!A>y
> z%vW&(sU}jzaFu*D&L&2x7?mobZ(=zz+mvQpLeuzW9BqasMx}}9n{pS6^`=sdOGu>}

...

-- 
MST


