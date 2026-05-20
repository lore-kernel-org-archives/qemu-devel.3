Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912EBCD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPaXT-0007Hq-B1; Wed, 20 May 2026 02:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wPaXQ-0007As-2b
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:36:16 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wPaXO-0006On-CM
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:36:15 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-36974221f93so2285843a91.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 23:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779258972; x=1779863772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UW+pK9HCxAWMvpalKV3h3jKuh3bdEpBVro6k1AMySCw=;
 b=H7Qs5ZBuRmONsZKO8noGI7fYl03ppUCpQrvubuDUYxYQR5ZaVkPPyjKgjtxporQCCI
 meX4IE5QhqqeAx3Y1IFC4pEi22iWDH8niJLyiYZPTd6EWe9vw3aHs2W0RGBOtxYtR9kK
 jv7mgdp+tESb5Tt3qaiy9k5tG1Doy7MnZpfHATHl8dR639WyqD3SoYclDk8j68fw2LMR
 VlKHM1SHEwuMd/9XSzOBY93SJ6Je4HeTiLEmYmlByLWtQAdfvauOQ09fOiqQyk9T5Sj4
 N7duKMsqRGsxuaOx2AvFbmJOgRIh/n5XQr2pBWXCu0vu4GRe5eAyN8m7SQNqrh0g+IC9
 cCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779258972; x=1779863772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UW+pK9HCxAWMvpalKV3h3jKuh3bdEpBVro6k1AMySCw=;
 b=FfAr62R/jg8qtrdk2IlsPnD2zAm/gSSS0wG/p6VaPT8b2X9Em5/nViFaqkSAoV+7LD
 Ax9WiQjXtKNPh2F/AnkOPEiqG801qQb/xbJHHuw3sReUmaJ4Rzj8z1GQXsVuox3E6KIa
 e8MOBsE4pKpQGJN+2RsClrmp3hJIRSSEtGusjxm8h9nl7MvH+gcpnF8Hzg8iVsemnSRh
 T/vc5Tmep8ygJld7F6Jk3Y+uCsYKXG/Pc9XaiXh7D3fQ0jngH0jXu/2+ZcQf+jE6kZAo
 cSURonCXscQJqP8VwWD5GgacDwNX/QpV94lTyBKaiUq2nJhs7X8KSSnSaqNYWBBapVss
 IqsQ==
X-Gm-Message-State: AOJu0YwjZOBzL1H+YHYGx2R9G/sPXar0rS88liE0n2AxYp4rHbGGOFpO
 d5Zexx0Ir1uLizDi5Z84YOaHG+Etj+7Y/TwrQsHWUolb5aLencHTZV03Po+pJcfYe1BPTPZc1oJ
 LG7lb6Qsnnz7FF4ycVjsnTltkZHcOzn6R5JDwhtidv5jRGvMjsM5pgbzqzvOxc0jB7M9YKcrSw4
 vp7z/J28cowt/+IAvr46SPvqjPlCL4vJJPBBTkcJorKequGw==
X-Gm-Gg: Acq92OHrpuP6kgYiCnJVAhM41M2dtjD4eHLmyTm0KIIR4AF2Qalqk+bnFWYDpyYVXvf
 herE1lrebAhd9QV6liRrvme8YSatws+jZ7mec9dSzy7e2pdEI2H+uT/4YobnjBa3twQ/kcJtV/K
 eO+9b/QhLT9hPmnDciOSAt8tphEB5VDNg2zzibkFGO305BJgekxPQw/h5VNGXSV1JXyoigZZlIU
 UIsbVNWRAya0LRe1MM6VCyJce7DFUUwIQUC5Sznj1NKruy8ORR1c/d6mY3Z/Wnno7hlwgkclzPK
 fgu6Umt++3fqLxbQtperQ7BrjVx1IcTkxAiVRFu5tC1QK3Z7v3OmJBEy2WMKvISFJmVSIWyf+Bl
 fVnewKixbsW9OY99hGX4Ox2GiDywWqzRSh0OkLy07DfIJMngmZcBGUxL5fBJUuDomlcKK7nHnKf
 i3Bf840qta5BDDsdFAsbxDKw2uaP+/fjgyOBZB/o45JJcOyatG64tryZW0i6bqGw==
X-Received: by 2002:a17:90b:56cb:b0:366:132:fda6 with SMTP id
 98e67ed59e1d1-36951a022eemr21991268a91.11.1779258972148; 
 Tue, 19 May 2026 23:36:12 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36959ca0fa5sm8364342a91.3.2026.05.19.23.36.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 23:36:11 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v5 0/2] target/riscv: Fix PMP address alignment
Date: Wed, 20 May 2026 14:36:04 +0800
Message-ID: <20260520063606.36600-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x1032.google.com
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

This series fixes PMP address alignment to comply with the RISC-V
specification WARL (Write-Any, Read-Legal) semantics.

When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
value is smaller than the PMP granularity, it needs to be aligned
to the PMP granularity.

Chagnes in v5:
- Use uint64_t for granule, in preparation for upcoming single-binary work:
  https://lore.kernel.org/qemu-devel/20260515180437.23620-1-anjo@rev.ng/

Changes in v4:
- Rebase riscv-to-apply.next

Changes in v3:
- Use ROUND_UP() macro for NAPOT address alignment

Changes in v2:
- Fixed commit message grammar ("it needs to be aligned")
- Use ROUND_DOWN() macro for TOR address alignment to improve
  code readability

Jay Chang (2):
  target/riscv: Align pmp size to pmp-granularity
  target/riscv: Improve PMP address alignment readability

 target/riscv/pmp.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

-- 
2.48.1


