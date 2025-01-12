Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989A5E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 23:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX79X-0003yQ-Dz; Sun, 12 Jan 2025 18:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX79R-0003xz-QC
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 18:13:51 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX79Q-0003Tv-7P
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 18:13:49 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso3179396f8f.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 15:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736723626; x=1737328426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q1BZuJ/3m/XEdW/VfGC3pXpwHIJtrElJlYbu+OJQj4Y=;
 b=JxqtrhBaiysti9bXafYlXRfH0BjzfnQITJFHmB08h59PuzaOfZqWS2J92sdIEK9OaR
 AGZmk5vK5EDVO9pQT0CQllyso77rBALzfteArZ8/26se8BImLRsBIIm/lmGWLmz/dsQU
 OmcRfiiVMnmeCwGKCZGJ7eFcXG+8NCybOgFcx0NSZhb8YXhTEhqLPgEi7APCQ0YTZIU2
 V50CD5fRd/uk88UMH9FTufYVJGuKP94wwFOctRUYBrj6hl4ctqhKthFfD/dYNhszY7c1
 QBCo8KjOc8OsgmbjV1dxdmMDfSz+x/B/2MXpUY6Qe/pPdxAUSCDDPd4XZBcqREuX55Cf
 X10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736723626; x=1737328426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q1BZuJ/3m/XEdW/VfGC3pXpwHIJtrElJlYbu+OJQj4Y=;
 b=IiFpY6EAeQRIL044heetOPIsRgsJMq8u28qOGdRHC2lMI7+pS+ghYaRGcKlrhZo0Ak
 MslBJRGvZTs/l0CvDFsctJwbj1zfaT70Ng7FVkk/6Tbra+Oz2EMtwoSOiJMS0VXGKFzE
 IIRDXyQb7ZM7lQTteibN9h6yAVPDN0gshW5T2Vb0ruhlk+1EKxU6nJc11z5/4fI/MXPI
 H7KImU6bHM+XfXkVzaoRW6vy2RmCxWtEGCwdR6B6cIAuyIfzXMG+0ovyYolYG9ptFwZ9
 YajzihS2KcvWF88TjurlCjHclJtQ3Cf+HQgxXBpQCXmzHJ7MUDtxnq3zczQGBhUj6xCh
 yeoA==
X-Gm-Message-State: AOJu0YyjC0pMEAIXlEdN4DUaLwHbizlHRacYgd/b0vZWEoVvrrxDn8LA
 FyNhJuhTd7NaQYt1hbjlYlSNkhXUnOy+As3rAHpQYGpo3h7aPEvCMxchZGtAzR8S/7hFNoACj0z
 46No=
X-Gm-Gg: ASbGncuJk2FkYt2oGp1K/JFe1HWjeAyHMxKQ2y+ZlhEuyN2b1Ni+J3DOx+KFkNwgUSt
 9gt0DLwuuqgPPqMePElAwsh0HQ3a45edPCwHWQsKD9glSCadn02tlC9NsSbOYgHY34j2Gwf1Vgi
 uUv6lBTzMeB8Dplmp6AOUfp7e5eXuB0aLao66EkPZTxlSJuKOGqOtxtjgPInxzHteSpybsikpth
 yCa7fdr0cDdBlUWpD8RFA9gkttbRyPilvomW4lu1gcDosMMUGCZUJhnXm8mgQ8nb2j0kgfU5ZXA
 eUyjPBUOdeIpDASmlCg0nDKTF3kKoOo=
X-Google-Smtp-Source: AGHT+IH2ptvawcohnb/6MklZRBJiyUSiD223cNAo1GSPhVP3xZF+K6tz6xv+iQ/wsCxRb6uBV/NwyQ==
X-Received: by 2002:a05:6000:481e:b0:386:37af:dd9a with SMTP id
 ffacd0b85a97d-38a872f534dmr17772354f8f.35.1736723625957; 
 Sun, 12 Jan 2025 15:13:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c76esm10455112f8f.47.2025.01.12.15.13.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 15:13:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/riscv/virt: Remove unnecessary use of &first_cpu
Date: Mon, 13 Jan 2025 00:13:42 +0100
Message-ID: <20250112231344.34632-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Pass RISCVCPU to kvm_riscv_get_timebase_frequency(),
then access the first vCPU via Virt::Array::Hart[]
rather than the &first_cpu global, which is going to
be removed as part of the heterogeneous emulation
effort.

Philippe Mathieu-Daudé (2):
  target/riscv: Have kvm_riscv_get_timebase_frequency() take RISCVCPU
    cpu
  hw/riscv/virt: Remove unnecessary use of &first_cpu

 target/riscv/kvm/kvm_riscv.h | 4 +++-
 hw/riscv/virt.c              | 2 +-
 target/riscv/kvm/kvm-cpu.c   | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.47.1


