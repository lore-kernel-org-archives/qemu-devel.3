Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4417EC41513
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 13:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDUv-0000kf-4s; Thu, 06 Jun 2024 09:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sFDUs-0000jq-FR
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:49:42 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sFDUq-0008Qa-Ql
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:49:42 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-704090c1204so42097b3a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 06:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717681779; x=1718286579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4GwHELgpxIqKZ/PYFP24eEDYOsXK8aKkcIpnhsQ5cR4=;
 b=IMfmTj+RqomBzyU0zIkQuhNx8fpbDP+hv08C/4PdkU+R1F9+RGtuBp0kCKMEjPksWm
 9qNJFYAdfkaBAYEzMl/aQhTIVJ9cTFgFB3A1TVX8WqQyXGc3xLHwrtEYsRz/TMPI+6CD
 gg5TubPPMwmOU2w8vOVE/xBt+jMiXo+McLFDbpoqzUDARkOq93i96wl9+3YsFjj0HhXR
 pAf2U7bu0LN0U/D2O6EV5z8TwNlQHUlNmcfSF1r+YR5dircBFBwUN18AC7oVC1Ajfx59
 6a+AMC61L5qi3Pa9vijrcYsy55WkQIpLTv1l8mt1MqwiCu83oqJZvEA5gogFDu9iwenK
 P4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681779; x=1718286579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4GwHELgpxIqKZ/PYFP24eEDYOsXK8aKkcIpnhsQ5cR4=;
 b=W0Sr4d3BN5HU1ZrOjG9icO6160AVzBAU1GKRmjGb46P+byPxCuX9Cg2wxLt14DfS9+
 oYE7dz6iE1diAFZbY905plZQUw/TqvilspA8pwWId5YsV9azQFgo6Zbo7FtkUQQPZt9d
 vZn0ny5NcXF7hH4BcIL6rh8GYwguMU6YB3r02Y/XNl0eb0VJAbh+SpopRhexRXaKgo9y
 6hgnYrqVBrOH4lDhVG2dESaE/FhiBhW4AmOWsU0gOYEOojAbGgKvDk5IJpeJoU+63FSz
 VZp5F/esm0vItBc6gRg8uWsVYJrfBe26n6SWusdhA8wjogLdAmfLkuzW8KfBA0Dm5tce
 X5ag==
X-Gm-Message-State: AOJu0YzvSJwX1bX5JfBCBlrKmwjqm9ZlQhnERcpczOruGVDGHqF72YNx
 3oULZ+GBJt1CQC9+PzHxviblExHc4V2mlRCXRCDcBj6HqDUgyymuoj9Bgv0JboYmO1p09MfdS3s
 GRaX2/8m6DIhPzpr4Pvv7z9shFAG9nAe9TfSBJPEkcMvu9Wt2VMBzwgkd8RtWHDZlfCxgt3+K+B
 /ikBMd8fBb1RNb4hYPOn56cCzG6NUST9K05gU=
X-Google-Smtp-Source: AGHT+IFRAqv5EDY+fqT1U2PeGIh3OEUaJ9Hnmywuo8iLP8+R0KZpSbCWIxCAemtwDvumeyeTbcNmIQ==
X-Received: by 2002:a05:6a00:4397:b0:702:5e48:99c8 with SMTP id
 d2e1a72fcca58-703e599a58amr6459205b3a.16.1717681778819; 
 Thu, 06 Jun 2024 06:49:38 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd50bc86sm1150919b3a.175.2024.06.06.06.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:49:38 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH v4 0/6] target/riscv: Support RISC-V privilege 1.13 spec
Date: Thu,  6 Jun 2024 21:54:48 +0800
Message-Id: <20240606135454.119186-1-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x42f.google.com
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

Based on the change log for the RISC-V privilege 1.13 spec, add the
support for ss1p13.

base-commit: 7a2356147f3a5faebf95dba4140247ec6e5607b1

* Reorder commits

[v3]
* Correct the mstateen0 for P1P13 in commit message
* Refactor commit by splitting to two commits

[v2]
* Check HEDELEGH by hmode32 instead of any32
* Remove unnecessary code
* Refine calling functions

[v1]

Ref:https://github.com/riscv/riscv-isa-manual/blob/a7d93c9/src/priv-preface.adoc?plain=1#L40-L72

Lists what to do without clarification or document format.
* Redefined misa.MXL to be read-only, making MXLEN a constant.(Skip, implementation ignored)
* Added the constraint that SXLEN≥UXLEN.(Skip, implementation ignored)
* Defined the misa.V field to reflect that the V extension has been implemented.(Skip, existed) 
* Defined the RV32-only medelegh and hedelegh CSRs.(Done in these patches)
* Defined the misaligned atomicity granule PMA, superseding the proposed Zam extension..(Skip, implementation ignored)
* Allocated interrupt 13 for Sscofpmf LCOFI interrupt.(Skip, existed) 
* Defined hardware error and software check exception codes.(Done in these patches)
* Specified synchronization requirements when changing the PBMTE fields in menvcfg and henvcfg.(Skip, implementation ignored)
* Incorporated Svade and Svadu extension specifications.(Skip, existed) 

Fea.Wang (5):
  target/riscv: Define macros and variables for ss1p13
  target/riscv: Add 'P1P13' bit in SMSTATEEN0
  target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
  target/riscv: Reserve exception codes for sw-check and hw-err
  target/riscv: Support the version for ss1p13

Jim Shu (1):
  target/riscv: Reuse the conversion function of priv_spec

 target/riscv/cpu.c         |  8 ++++++--
 target/riscv/cpu.h         |  5 ++++-
 target/riscv/cpu_bits.h    |  5 +++++
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/csr.c         | 39 ++++++++++++++++++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c | 17 ++++++++---------
 6 files changed, 63 insertions(+), 12 deletions(-)

-- 
2.34.1


