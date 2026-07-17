Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2AEC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfXf-0000f1-03; Fri, 17 Jul 2026 06:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wkfXT-0000Yo-M5
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:11:28 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wkfXE-0007Dp-W2
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:11:14 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38115bbb83dso600557a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784283071; x=1784887871; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3D4LB4UMCIVeq5/1+G8tKmsQHEW4amZ6BXQzFNtTap4=;
 b=pF6RLUuHtUHVYnoe69ExCM7y2oKlXddcMt41/6zeflEvJWljGMz9Gp9eXiyr2tPxkD
 +awueafu7TmRISUsWlsvlfMXhJcLkGaZZMQ7rsmkEqN7K/nG0RV31Hc2jLJeF+prEVHd
 pHUw5XCKvEtnnh2QWHZW4FE5LhUWbGx6AtCBMx2WpYIx9v2JsuU1w+PSo1iP6bV8gQod
 dk3fn8tL8sa0KUOXPePy+1HA9ZQJLd/JXsraGeJash6/cpjUy1RCY1BSYYVlxd+oa9Zb
 H3oS+owmOtyEGmNucLWs0sivnddeY5p0+VU+2dCTAaf/+/DE/N8pcrx+Qg4Hz0pyoI8+
 U+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784283071; x=1784887871;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3D4LB4UMCIVeq5/1+G8tKmsQHEW4amZ6BXQzFNtTap4=;
 b=YLAzLJpAXLBQdeGsT+0gqcztfMKUrnWnl3DjS0PWaCbaey/9/FS731W+cUrSD61bCb
 lwqo54hGfgbbDOBLiytoU4E94p0nIggs9f+zCgjtg9QTX1kstfqRTXskAVSEIhMN96Z1
 SAkb2P7yHojlciQGDpd84VxfdMadPxN23uUzPzJvEpMlDWcHTSvGR7TS1C13RxjmnOas
 p9AoIgCp9T1m8rhhBxYbaQqcruPMpsZtJZKbjsiB9LBfJPvzS5uYUcYWZOQxRjCwpXGo
 TIDrBqbP4yqCdI8ngbWg0fDuVlzwddXNvJ8y27bOjyFH5PFbubWeDWUns34BG/WqRCGR
 w5ug==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQId1GrqFj7QWDmNjpr01Dp0Sg6Ihlojegzt7zK75jUIuqxDf+jnDVDk1NbpqT+GMzLdh0EhFAvvvs@nongnu.org
X-Gm-Message-State: AOJu0YxuwBsEt6V058HVLW720mrbwb/xQWyAdi3eMct2f1r7rc78LNzy
 Uuh9zV3OQsbiY+zzpH4GaFpP6vRyEwpPZg3DcmXSW3BQ6pltE6uINatt
X-Gm-Gg: AfdE7cloucom2vBc5KhjPCeiNNih0/CsL+LnE40+mt1AJp3+kPiKNxAgwwVdLE77+Da
 81QX/BTep3CJgV3MwafYh8trerrf4Y5JVZ/8WJOEz+CFeZY9n26jnPKSOa73LVDpDyKOfXaFocI
 j42jYnWGKbDDkION9AASzQEtiuAe41qs8o2wFCeseQK/z+H9apaVtuyU0I5R/ngFbP1XeI8XBqA
 OEhZ2JSjotWPEPJpsSo0cMQSrNfq7hQIt7hSjkCTavFCtpfoOUsUjWWnSGYDaS7uy1EUqdVO/rQ
 vQoAbb53ewyloKRZoE53C6A2842QNpYTlJySRM5EY4ZkNTBT4PSmJRJ7dx21Ozj+ODNfOgbVhL9
 8l5B6f6WYm2WU1C5I/odzw0F4T4C/526SR6vebvkjFyZTA53sPfO3XRhEUDdMzaxjG1X4RiZJkg
 SE3PHfOW5Z0wHUXumJP7L13QwBPaaY
X-Received: by 2002:a17:90b:5547:b0:38e:549:9e04 with SMTP id
 98e67ed59e1d1-38e4b441371mr1396585a91.1.1784283071381; 
 Fri, 17 Jul 2026 03:11:11 -0700 (PDT)
Received: from DESKTOP-JUS09M1.tail12b54b.ts.net ([38.34.7.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a20b037sm5885396eec.27.2026.07.17.03.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 03:11:10 -0700 (PDT)
From: Junze Cao <caojunze424@gmail.com>
To: Jack Wang <163wangjack@gmail.com>
Cc: Junze Cao <caojunze424@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [RFC PATCH 1/2] hw/misc/k230_rmu: add Kendryte K230 Reset
 Management Unit model
Date: Fri, 17 Jul 2026 18:11:00 +0800
Message-ID: <20260717101101.1288002-1-caojunze424@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709031237.21284-2-163wangjack@gmail.com>
References: <20260709031237.21284-1-163wangjack@gmail.com>
 <20260709031237.21284-2-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=caojunze424@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Wang,

Thanks for working on the K230 RMU model.

I reviewed this series against the K230 TRM and the upstream Linux
reset-k230 driver. The series builds and the supplied qtest passes, but
I found several issues that should be addressed in v2.

1. The RMU currently acknowledges reset requests without actually
resetting the target devices. Please connect at least the existing K230
watchdog devices and add a qtest which verifies that their state is
reset through the RMU.

2. The register reset state does not match the TRM. Please initialize
each modelled register with its documented reset value and update the
reset-value test accordingly.

3. Some register access permissions and reset types are incorrect. In
particular, some upper SW_DONE reset lines cannot be changed, reserved
bits are writable, and CPU1 is treated as self-clearing even though it
requires separate assert and deassert operations.

4. Patch 1 adds k230-rmu-test while the K230 machine still uses the
unimplemented RMU stub. K230_RMU is enabled and wired only by patch 2,
so patch 1 cannot pass its own test when checked out independently.
Please reorder the changes, move the test to patch 2, or squash the two
patches.

5. The new source, header and qtest files should be added to the K230
section in MAINTAINERS. Please address the checkpatch errors and
warnings before sending v2 as well.

6. Please consider modelling the reset timing registers. At minimum,
their reset values and writable fields should be represented. Real-time
delays may remain simplified if the zero-latency behavior is documented
and preserves guest-visible ordering.

7. Please add coverage for the corrected reset values, CPU1
transitions, upper SW_DONE fields, reserved bits, and reset propagation
to the watchdogs.

Regards,
Junze Cao

