Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F09C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylY0-0004HN-Dh; Tue, 25 Aug 2026 03:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wylXy-0004GO-N9
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:26:14 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wylXx-0001ED-2j
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:26:14 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8485b358552so1762151b3a.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 00:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787642771; x=1788247571; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=41vrC4Yj29c2G8CtpLKN0/veKnq17aQLpSmyUEQInh8=;
 b=jpT3Hsj0s8UqSqaEg8lQ3h4eFjbSiCuBx9Vfm/+o+Ba3tr6yVIELSncVgs/143dFKU
 aDcuKsrVkEnuZufRUCPaAy0njqnFQ0M3FPcLM58+WCHZbVDxScaRK0GSTEgr+MVc0UNF
 1CK/xgwcbbf8zIXa0FgbbFk28pcaVydQOxvBK/O8hghr/1Zlu9HHebZZTvzCNN+mLI1/
 /QsGxeJKryfyET04ihRa0iEOIK6emQ7L97NH4atmMFjjvvxLAUDML1RY/V9cnZJKOAHu
 XdqmGBm7swH+P6GLVR1er7Y4VAVx5GkL13WNQ2/aCVfWpgBz5lWuBaUJvN8hjiMF0Z/G
 kdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787642771; x=1788247571;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=41vrC4Yj29c2G8CtpLKN0/veKnq17aQLpSmyUEQInh8=;
 b=GAQpXo11yj2M+y6ZEcAWcxbfSgI7Rn1CoYJ+E4ZEQYmUvOzzS03uXtJxUa/+qOd36A
 74sO6C0IjH3StFU0g6+u9XbQU/b/wSfDorlMFlYURHF97oG+hG2e8R376tnOUM4d7IW0
 sGh5f8u4PHfeWDsFOVvAgrJKY9S/n2rpTlIjPg0rVCrSgb/jg+O923oW6D7zSZokD831
 KKFK3UnqKd33Fpu8hmBSpaJRS6nl5OMnsw/73VVYam2sH+ciuKiVlOAJ/v4uXV1qHfgf
 6k+0K+OpkofL/MfbFFjQ21H1v1ufkfq1WV5Jyr6hmXpm9v8RMtwasctIA/Bm3lIQshkD
 msmA==
X-Gm-Message-State: AFuF++nNEVz5I+JUrYEbOx5eZrTyI+YFe91iNFlMczyuEeTlyvKp+5Su
 c7K5SUgb0sr2/Vsecih/AGPSKjwyerYVGwUr9ngyxn2uJOB8j7veozME
X-Gm-Gg: AR+sD10PR6S8furhymspjY4bg60oo0OnqgEuke6zRR+JiC4GSMCpgm4c7pMhFe6QtOJ
 llZB1LzQ4tlNzHxEsNRmztq/wcDxbBvAwr92E76ZYBaQmcmJZsdt3n8ER1Q3BznmhkHs0ETyOgO
 x1oTHx0q7Mj+6Ir7fIEImXKqgkXgNi4dfE2xYhxnS258cYPmKDoUZOMJ0kkDn9dRL1Zh6SF+l/S
 GLMOJSEUepOJHUOf+ZXKeAM3e2WaOHai1nRj5/ehJ4aSf1z5h/3bps0f4SPsD44efB1Jiz9Cxfq
 wiEoa3WkA0+DxuVFPYZ5CUD046qor6XTs40nVyPX+iMCrgnAayYnnz4tRispdpq+TSdMpZxwkeB
 QTEuY/Ff45Ev7gPksOPYWm7xZeMS2tfOgItpz8eZwH04ZFygxJ8l32BfF1D48CwwkdcPlsmshd5
 o82zY2CgffjdTlZO8+csJ6RGY1iCuwn8a+05di6YajzMLtEV/aK+oKNojlkfN9r75ioJiLswk/u
 wy1onYo
X-Received: by 2002:a05:6a00:139d:b0:852:38ff:b4b6 with SMTP id
 d2e1a72fcca58-85239000a70mr13113615b3a.17.1787642771502; 
 Tue, 25 Aug 2026 00:26:11 -0700 (PDT)
Received: from smtpclient.apple ([117.55.237.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520eed2293sm2569378b3a.2.2026.08.25.00.26.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Aug 2026 00:26:11 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3 5/5] hw/arm: Add Axiado Ax3005 EVB
From: Jack Wang <163wangjack@gmail.com>
In-Reply-To: <20260825021155.2475879-6-kchiu@axiado.com>
Date: Tue, 25 Aug 2026 15:25:54 +0800
Cc: qemu-devel@nongnu.org,
 peter.maydell@linaro.org,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A3F8951-FEC0-448F-B2B0-44AF0AE9777F@gmail.com>
References: <20260825021155.2475879-6-kchiu@axiado.com>
To: kchiu@axiado.com
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=163wangjack@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


Hi Kuan-Jui

In patch 4, the AX3005 DRAM MemoryRegion is created with a fixed size of =
2 GiB, as defined by AX3005_DRAM_SIZE. However, this patch passes =
machine->ram_size to the kernel loader:

> +    ax3005_binfo.ram_size =3D machine->ram_size;

This allows the value supplied through the -m option to differ from the =
size of the actual DRAM MemoryRegion.

I am not sure whether the machine is intended to support configurable =
RAM or only a fixed 2 GiB configuration, but the current implementation =
makes the machine configuration and the physical memory map
inconsistent.

I checked the configured memory size with:

for ram in 1G 3G; do echo "QMP case: -m $ram"; printf '%s\n' =
'{"execute":"qmp_capabilities"}' =
'{"execute":"query-memory-size-summary"}' '{"execute":"quit"}' | =
"$QEMU_BIN" -M ax3005-evb -m "$ram" -display none -serial none -qmp =
stdio -S | rg 'base-memory'; done

I then checked the actual memory map with:

for ram in 1G 3G; do echo "MemoryRegion case: -m $ram"; printf 'info =
mtree -f\nquit\n' | "$QEMU_BIN" -M ax3005-evb -m "$ram" -display none =
-serial none -monitor stdio -S | rg '\(prio 0, ram\): dram'; done

Therefore, the actual DRAM remains fixed at 2 GiB, while =
machine->ram_size and the value passed to arm_load_kernel() can report 1 =
GiB or 3 GiB.(QEMU_BIN points to the newly built qemu-system-aarch64 =
binary.)

Best regards : )
JW..

