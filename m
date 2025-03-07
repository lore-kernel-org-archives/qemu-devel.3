Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC81C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd5L-0002QC-KN; Fri, 07 Mar 2025 14:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd5J-0002PK-NL
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:10:13 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd5H-0005sf-VQ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:10:13 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-219f8263ae0so44754265ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374610; x=1741979410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8fmW+9iS3PmT2XAAZO5m9vMY0XGD6LHO6SASf0iJxOY=;
 b=RYPIaWGIURZJC4+QxcU1lSQb25c1yx9DRU89u5feJ1uPkH1F80Yu90gSjqhl0sIFa6
 FgFaNx9csZbeITWRYzDKhStkykPx108ka1NsQ8L9b9v5x33ngcdpy4xZukIB8TaXBgw8
 TqznI89RpKBxgRnu4hBzT4r/3PEbnQxTEZNtNS5VLqPe/+xGOc6vLQkv+zNXOVbWQ1cV
 8A5FrmyMIOhyBxZD0oYAPxaxdGcZdjZgJemvIj1z7nGROBXaR7B/8MrOLvuOkv0AEXWo
 9+NaLT0R6P7lb4n9ki1M5qF+uam1j3DEjMNq/KnC2W8IweeDg1N31tLkTDv1CHkwBUWU
 wGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374610; x=1741979410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8fmW+9iS3PmT2XAAZO5m9vMY0XGD6LHO6SASf0iJxOY=;
 b=NY0g/2UDEBS+UAoWB0FtFXCPZ0rr7uS8to0Bek96vlkZpr9i1TIX1W20kEaTKsAGu8
 6L3+9T7nXjANTrRFaupxmnfKuw77/nDvteCOTs/hU710vvnBOaiixD7uQcR5vCk78CUK
 Tdp8BK7w8MOzMUhF8yFez8up/H/dmGyqoIkutVPhRscFhtfAEa9RLxtt9I8qUEDUO8Dm
 laecSnntKW/nuf4cTq1Y71HXtMtiNJpX0EHGbhi4OJgcuEH4OSm7LwPiw5PVTMmza8Ki
 S3TK0HMSHNs75YByXmKeT7sgaUhgqCk9Ptg7g/UlUIRku6B7k4RATIj3WOH4slh349C/
 3tZg==
X-Gm-Message-State: AOJu0YzWBOwaZH9F/9AG3bEvu6UOE/iI7/0OHTRPaRSQx1QM0dnJOBtA
 CpGuItB7Cz+Uuzc+PEqZPjSKP29v/pVaghScek8LgoX5E61e+lqJPiuJImUc+Ek4o1VKUj3OkgY
 w
X-Gm-Gg: ASbGncs8lN2qj8HKOSq3dYwRUsnWUfLYQz/NVO4CYtt2Rt0r9eSDtY31wZ+dVmHm5Nx
 eHaJRaBLEGnrsCXYNZY+XCCOvEY3CTZjm/KHwO3OLHGW0Khyz61KJpzZC1ZjV/zBdKB8H5Jy+Um
 /Ga7hIBs0XmGwByV7F5MZduqlVLIMsjCaEPXu0zZh6xk17kOJpMRymcQ26bkTYC2imxQ8dakZZ+
 9h/h39Q2oeF3kyLeqdNVBPitVjwF6PKLngmtxOhtut1hY7iTa3TgawardhmYr3Xu3mscZrOBVT+
 9D4L3oSgy7Ad69pjK0Oe4VS7kZbm5L/By+P4LaRzljul
X-Google-Smtp-Source: AGHT+IECxrDCFtIdTWnSb1B3IJubkBg7Oin2BPr4sIgfjEKC9LVYl+fNe3gSQDbgmFBFaHBFR75q4Q==
X-Received: by 2002:a17:902:da81:b0:224:c46:d167 with SMTP id
 d9443c01a7336-22428887604mr58984615ad.16.1741374610024; 
 Fri, 07 Mar 2025 11:10:10 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b2da32c6sm1449895b3a.149.2025.03.07.11.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:10:09 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v2 0/7] hw/hyperv: remove duplication compilation units
Date: Fri,  7 Mar 2025 11:09:56 -0800
Message-Id: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Work towards having a single binary, by removing duplicated object files.

hw/hyperv/hyperv.c was excluded at this time, because it depends on target
dependent symbols:
- from system/kvm.h
    - kvm_check_extension
    - kvm_vm_ioctl
- from exec/cpu-all.h | memory_ldst_phys.h.inc
    - ldq_phys

v2
- remove osdep from header
- use hardcoded buffer size for syndbg, assuming page size is always 4Kb.

Pierrick Bouvier (7):
  hw/hyperv/hv-balloon-stub: common compilation unit
  hw/hyperv/hyperv.h: header cleanup
  hw/hyperv/vmbus: common compilation unit
  hw/hyperv/hyperv-proto: move SYNDBG definition from target/i386
  hw/hyperv/syndbg: common compilation unit
  hw/hyperv/balloon: common balloon compilation units
  hw/hyperv/hyperv_testdev: common compilation unit

 include/hw/hyperv/hyperv-proto.h | 12 ++++++++
 include/hw/hyperv/hyperv.h       |  3 +-
 target/i386/kvm/hyperv-proto.h   | 12 --------
 hw/hyperv/syndbg.c               | 10 +++++--
 hw/hyperv/vmbus.c                | 50 ++++++++++++++++----------------
 hw/hyperv/meson.build            |  9 +++---
 6 files changed, 51 insertions(+), 45 deletions(-)

-- 
2.39.5


