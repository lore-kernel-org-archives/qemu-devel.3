Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B140BCE7A8C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 09:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJphL-0005lR-O2; Fri, 14 Nov 2025 04:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vJpgf-00046C-DF
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 04:01:47 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vJpgd-0007Fa-1G
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 04:01:44 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so1480610b3a.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 01:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763110900; x=1763715700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aOIjL8C9OOmtemENp3TG+rbFd0PLCLljD/zmUltGU0Y=;
 b=aAKVGcOEKmO6q1HYWve6Ts69XDRfn8PPoJOswmkebdQigIVcXFms20vZO1hxS3whyn
 CdrBKvHXmMMCkiiVE32tJ0l6pMF1SfAEgOoLtGMVA9k4HhuFg+nkCAFsL2x6mQLWUcSU
 IKOlUcHkw1+TzWUrXVEbTFIXCStAeRqbAdaq87yI1fhPIG1KDAH0P8K00BfrexJ0cgRG
 9yIZirllp9WXyzyYpZhbA3NwOiEIfkLAajtS6hRTdczbB9II6S2Yo6GlB50CdwgTBlLf
 htQaPqqTcYyROdWA5POvQPUjiEl0a1O3st0l4FaRFgmBhpwujKGm+EM1RFK05GFfV0Zi
 nrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763110900; x=1763715700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOIjL8C9OOmtemENp3TG+rbFd0PLCLljD/zmUltGU0Y=;
 b=SIJ3+UApJeaD15wxouCHci/z2z/UMt2UtTaLWNToBrUi/50JtWZkDIIUjpmC9zeiWu
 UvTxfpo0GkoiBjv5ddsOoF1l5xoJ2Beu0ydXz2AklEmwmp51Yuv2xv5lbj2Mwgs1IKeF
 hdYOA2OYuupezz44ZbBpQUG6jjE4mlLlBrJeyxifLE3l4OrtgcbGUnA95ULgS4fo1vCo
 g2mNNeKo/tLarfTiL4bE+4sUyuf7qsTIbzYMSWxuphyVY3BMaNF1o6KgVy4XTuWUca8D
 F+qZpEDExsR5h5NnrjU2lvm1IdCPQ41J7+dnJ/+uzLFDER12p5Iz3j2TZyohoYml9+hw
 mzog==
X-Gm-Message-State: AOJu0YzjzsgCMNoZyCsqBpjrSahTNWr3NBls9WfNMLSrpHFQqV0/zsNG
 4wRylg8NMZhCnEELClxxFQLfMqXI0+o+2c+ATCO3dPNIqZH0emg/kJTDHXNiY+pleyBIR+n7kVo
 r98HdbZcn+V7vpg6NX+6e8qjLb3FCGdArvgwE8lDSoNVLT2j9+mxumnhj4bD9ObMBHkWGh9fMZr
 rbritlFOaUBOEroNF7qWzIbHUlWGSamyGPTDKj2TVA1NA=
X-Gm-Gg: ASbGncuMci0BGpHPzfGAE+Zvt9qjyiFBxvmoSOPoGwGR1bYmDCFFwaFDDhf/avaAZ2W
 qbnOgIZHIAIRe0lZulxFHoyP95zVfmqbYfFFfgYhkQnD8jOuusRMqSBjq/n7qi/u0oxxulj8ues
 d804rgXTpy0KPag5qbDII02bceWDGg1KrsIp2X1ivQ3IyVqDYtfuEJbF+8VHII5hYpqO/Gt0d+e
 EWqc3dJPFZIgu7P+dm8AlxdNY9tHj+4O+EkdbwFxKM8daUK3REbLHvq/tvPXvfRI3RdpCJIzdq3
 NB8Xs//KEOcyphKzypcCQ23Q3Z1GNx0+tFtp2ZwoGlVDa4uANYV8/owdSEag2JvsjKRW2+15Yiv
 lv05eGiAFCDRzzyYxhCVzfY5ycmHCCfXqKhhCGBKxYpgC0PEsxBZKL2uGaDrJcc1zJypWJrdgfy
 aioj4c8altzA3aDrBtZ/QmbSjHJXC4LDbx9lF9Lg==
X-Google-Smtp-Source: AGHT+IF17clP1lk7mojI0bpGCHfOLcUWwRy2m2R3GE9XqqKBlSYY8gl5a9SjROdYGJJZcKrRdQvTLA==
X-Received: by 2002:a05:7022:639d:b0:11a:547b:9b9f with SMTP id
 a92af1059eb24-11b4120f623mr873433c88.37.1763110899557; 
 Fri, 14 Nov 2025 01:01:39 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b06088625sm8049254c88.8.2025.11.14.01.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 01:01:39 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 0/2] Set MISA.[C|X] based on the selected extensions
Date: Fri, 14 Nov 2025 17:01:31 +0800
Message-ID: <20251114090134.1125646-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42f.google.com
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

From: Frank Chang <frank.chang@sifive.com>

MISA.C and MISA.X should be set when the following extensions are
selected:

MISA.C:
  * Zca and not F.
  * Zca, Zcf and F (but not D) is specified (RV32 only).
  * Zca, Zcf and Zcd if D is specified (RV32 only).
  * Zca, Zcd if D is specified (RV64 only)

MISA.X:
  * When there are any non-standard extensions enabled.

This patchset sets MISA.[C|X] bits based on the selected extensions.

Frank Chang (2):
  target/riscv: Update MISA.C for Zc* extensions
  target/riscv: Update MISA.X for non-standard extensions

 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 46 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

--
2.43.0


