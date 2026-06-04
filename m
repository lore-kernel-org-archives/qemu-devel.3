Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E39BCD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 05:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV0Mo-0001SM-Ce; Thu, 04 Jun 2026 01:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wV0Mm-0001Rz-Te
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 01:11:40 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wV0Ml-0003Jc-9H
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 01:11:40 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36b95eb4bb4so162188a91.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 22:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780549897; x=1781154697; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+m/9dX6TLqcMPJvw6bLKgc/kWEgjUSzJPkKB/LBRd14=;
 b=N/gn/sncLPX1WnHRKIiT4NPk+6H0Z4BvIoi2ttAqWFCulmkktbi0rxUcxZiQvODQ5W
 /4vnsd50ctG6ZgNo/Qq/yzhC9Xn7tvF3LcJC3vq+FpQagO3j0La8xYfPrSrCTDcfQAS+
 6Yv+pMR9yF81RoPhSFwL0AZOEqN9zOraD7YXG9AK28A3dWp/Hj/sCme+7yiGGY9/ankJ
 ZLwAITRKLDGbANNzwohiSjNplhgNG+AK9gTNUdP2oBVKeX8LqZcyJlaIQppbLoQyz2N7
 9lrYquequOWs6e+VQ10KEs9q+x2f+ZSGfWn0OP8+A5nq4K9ltUm1xiXMAqTMukhVa0Sq
 kKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780549897; x=1781154697;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+m/9dX6TLqcMPJvw6bLKgc/kWEgjUSzJPkKB/LBRd14=;
 b=GfAvRzWpYe0xeCVNRc2LgbgcKHqshdKJCEABscjzt2i/tkTVUEENuD/56kETC1YGso
 +RCxIvz0EQqyd2R9rezhFOI3SNHU3UlXYcnu8TQF/aoXzjyzX9u3l4W31VfTExvPaZkP
 zZImLdYcQtuifP+IA2ewJCWkrxrDbmObWp6wE0S4qPOxybQJmB7h2Weo17dHjD1WfFZ9
 2aN1ulsDvWUlTIeZQ9L/EodaTM6d/zJUREFgiXGOUCRcFj9DmRT+gwcVCsllnG1arQYj
 Xgf0GX0ZX4L+hKR7JNzdvbXwXd+BOCY8/lJX3BrQC2sN+sjQzunGGTmHwMN6mucLPmme
 ZySg==
X-Gm-Message-State: AOJu0YyyMVZSTeZKEZvDaTPPzdmYvTqRrOHHC5BkVjuWijkwqsBWWVxB
 xOUVE03igNQTA3t/AQaNQONYbB0/fxcOri7cSjnlZ1hRTpLu/J1b1/eU
X-Gm-Gg: Acq92OF5vak8Jdjn8TDLLSRKM4fWRoh0yiGsjIOuMSQX9SRzzYjVrRMaJUrrS0Vc0vc
 aHO7OOx4xj5xNXz/PdV6x+is4unI9GNTW/sazweOsn9Up0WfqlrofDCqvKHcaamuch7nwwJb2Lj
 IqWZNKmP9dWp1TY5P3pk5xKh6pXtoDvmP7n+vAHm9jyVd2Hd4wiqBWx9kaAABIneBEEv4Iu7SMc
 AsvmZP5yWs7nFJUYWxez9tLRwtRCPpHYEXwVYcrOm1Kjzo0JMBU2poc2a4Jdt0o93lXTq8or8Lt
 A+gkBfZmqIcYC2W0f2UYxz1i1mviIXXLHZJEBNxQnWR0aPlkj+e1sPEhN7WCZaQ5YXoaUdpFyND
 3AzluqxPRNaaoyikEOsK5r4HXlzvZ36G4TTRNcoF2tfN6YmzaU2G3+mN/Dt/BPe8rq/cP6q1J0w
 rzVbn9iuLW2RENT2AyAaCXQbFAVe2lOwVmSDYxMg==
X-Received: by 2002:a17:90b:3a90:b0:36d:dd4a:1e59 with SMTP id
 98e67ed59e1d1-36e3294e2e3mr6517875a91.23.1780549897196; 
 Wed, 03 Jun 2026 22:11:37 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0a505fsm3867290a12.20.2026.06.03.22.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 22:11:36 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] hw/ufs: avoid double unref of wrapped scsi-hd
To: qemu-devel@nongnu.org, physicalmtea@gmail.com
Cc: jeuk20.kim@samsung.com, qemu-stable@nongnu.org, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com
In-Reply-To: <178019129273.471607.15668084929091826093@gmail.com>
References: <178019129273.471607.15668084929091826093@gmail.com>
Date: Thu, 04 Jun 2026 14:11:19 +0900
Message-Id: <178054987989.10425.12764844047195713236.b4-review@b4>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102f.google.com
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

On Sun, 31 May 2026 09:34:52 +0800, Jia Jia <physicalmtea@gmail.com> wrote:

Thanks for fixing the bug. The hw/ufs/lu.c change looks good to me.

One issue is in the new qtest. acpi-eject removes the UFS PCI device, but
qos-test may reuse the same QEMU instance for the next test when the command
line is unchanged. This makes the following UFS test run after the device has
already been ejected.

I can reproduce it with:

  QTEST_QEMU_BINARY=./build/qemu-system-x86_64 \
    build/tests/qtest/qos-test \
    -p /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/ufs/ufs-tests

acpi-eject passes, then init fails.

>
> diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
> index f677896db0..0ae03c3433 100644
> --- a/tests/qtest/ufs-test.c
> +++ b/tests/qtest/ufs-test.c
> @@ -1426,6 +1439,9 @@ static void ufs_register_nodes(void)
>          g_test_message("Skipping ufs io tests for ppc64");
>          return;
>      }
> +    if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
> +        qos_add_test("acpi-eject", "ufs", ufstest_acpi_eject, NULL);

I think acpi-eject should be isolated, e.g. by registering it as a subprocess:

  QOSGraphTestOptions acpi_eject_test_opts = { .subprocess = true };

  qos_add_test("acpi-eject", "ufs", ufstest_acpi_eject,
               &acpi_eject_test_opts);

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

