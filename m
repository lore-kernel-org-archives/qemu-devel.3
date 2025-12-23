Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651E5E6FE51
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 22:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYAqW-0005XY-DI; Tue, 23 Dec 2025 17:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vYAqT-0005W1-KT
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 17:27:09 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vYAqR-0007NM-TH
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 17:27:09 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a110548cdeso75875815ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 14:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766528826; x=1767133626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jBQO1Wn5o0tb2+FAZqnUEHdgyZgxt4AJ1DumNER1BHI=;
 b=XfBW9rQ80cu1PgBIFx54dCg/Mp55rnUJF992xqypCTbVtcvKL/rySSOanQXo7+MIeL
 O5VkU72xq/Aep6mlu5aZ7+JHCCLixcEkdXS7q6uw/16b559tov6jTKqZifkjmXN9YPda
 /lwVTboNNMdZ399PH14ZQimH+6W7cwjb/vNGkTw5opsoSyuAAEvokc0BL3koAdg/4kzM
 HVSgtXx8SxM/ih5fg/oZorC+Ctz0NPqrQvppEixXGaP7JRV0dWq/u3OTIr8ISGeami0H
 a0C7kJWR3MA75vhvfQlLLwlzYXfp0nua2nKYGaagh80sZ/iv2/mRxhUGqUIaTAGn5p72
 mbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766528826; x=1767133626;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBQO1Wn5o0tb2+FAZqnUEHdgyZgxt4AJ1DumNER1BHI=;
 b=RzBNEIlzFQ2In9TnulHbr21c4/L+S/3NhYhu3p54nCvlwUa07luEJexx0hsabY4m5G
 YKqt2XawQ/EddFkc4n5TByPgYHM0bOoLwKVp261NZWxiTWkbCVArqAJuhYk3dkt7Q0wK
 JCUQcvGsNwgUscRbMp2sZZtUETPP2Z1SnZfXb7P6RvsFPpkRVdnkofhQVe/A9CwHjsBS
 LOjrOAvok2rSJ6MrFhtUsBxhY/gZz+v5Gsh66tHW3yjBCvYzj1gLqyOhWMztU41Nmppj
 B58DXnraiLNkBgoPBF8q1J5bhlPSRTpp5xU1ZB9Jvux07PBAeVgu47pAHOaQgtzNi7En
 Wh4A==
X-Gm-Message-State: AOJu0YyYgmHkhoOSQw44HTtyGy81ITSDARqqnJ+OT6swLl5GkVFKSpv6
 n5/30MBQbsLPtrH7xyRk11lBmWiVMZqIOIdNEnmuscNgK0MLf/Y3Rbql3s+Fw9jRcvPbimga0bE
 xoVqr
X-Gm-Gg: AY/fxX6PbgZC4tPpl7QjfTgT+SwqkXZpb3tlilSE2sVAAtoPc3RcTrBFUNbXAzidxn6
 e6DzRHD12AaXmKPhl0VAzxUSmY1SyBhvOXg1UO7YO6miKH2YsFub7cBGQmGHSFrvkk+G1IcyeIC
 A5yrAIdWUMz0yoOItU+rZ2XRXtDz4MHplcldMDTiJuGAeZE0pBPaLbH5o6ecS+R4ebOWhnd4I06
 QK4TpucsdyGRZdqnnxbom1RAXqcdbrz+gcXTLnDKv0lpDphlwGvvpXEUTSb8fkO2eARslbPt7Qc
 O/N4M1cTq6vzcSkisQtD4nd3ZEcsR4dMmP6QmtMRjgTwsj1GwvcU49Mb7YijF6YL8Ndcr6RXGvf
 lEZxK3QrvGwgr1AKJfxVZQ/y7YsQJT8S9tYPEfyABjuj1/Ihbr1+zNuaUBRjUpYvgdBbJKaIB4o
 BLYI2kP52nXC/As0/i
X-Google-Smtp-Source: AGHT+IGj+3kVenhyap2+XdBLRVNS+MWPW2IBBdZyQ+O3opeZ98oNucyuOtn+CPPoWUy3BpMch4YpqA==
X-Received: by 2002:a05:7023:903:b0:119:e569:fbb2 with SMTP id
 a92af1059eb24-12172300472mr19012141c88.33.1766528825740; 
 Tue, 23 Dec 2025 14:27:05 -0800 (PST)
Received: from gromero0.. ([179.93.129.179]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1217243bbe3sm62803123c88.0.2025.12.23.14.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 14:27:05 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 0/4] system/physmem: Enhance the Address Space API
Date: Tue, 23 Dec 2025 19:26:45 -0300
Message-Id: <20251223222649.187935-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x634.google.com
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

The proposal in v2 was to allocate all defined address spaces
(CPUAddressSpace structs) statically, modifying the Address Space (AS)
API by renaming cpu_address_space_init() to cpu_address_space_add() and
by introducing a new cpu_address_space_init() meant to be used to set
the total number of address spaces in a CPU (instead of setting the
cpu->num_ases invariant directly, as we currently do).

However, Phil said that what he actually had in mind was to set
cpu->num_ases automatically in the CPUClass, hence without the need to
set cpu->num_ases using any AS API function, burying the details of
initializing cpu->num_ases within the CPUClass. This way, the
initialization of the ASes is reduced to the simple and unique use of
cpu_address_space_init().

This version (v3) is essentially based on what Phil proposed in the v2
review, but I removed the re-setting of cs->num_ases to 1 in
x86_cpu_realizefn(), avoiding changes to num_ases beyond the CPUClass
instantiation.

First, it will become inconsistent as new ASes are added. Second, it
risks causing confusion about the new AS API semantics, which require
using cpu_address_space_init on demand, as ASes are required by the
target, without modifying num_ases elsewhere in the code beyond CPUClass
instantiation.

I hope that now we have a strong candidate to be merged that enhances
the current situation, allowing adding new address spaces in the target
quite easily.

CI results:
https://gitlab.com/gusbromero/qemu/-/pipelines/2228868887

v1:
https://mail.gnu.org/archive/html/qemu-devel/2025-11/msg04406.html

v2:
https://mail.gnu.org/archive/html/qemu-devel/2025-12/msg02298.html


Cheers,
Gustavo

Gustavo Romero (3):
  target/arm: Initialize AS 0 first
  target/i386: Add a _MAX sentinel to X86ASIdx enum
  target/arm: Add a _MAX sentinel to ARMASIdx enum

Philippe Mathieu-Daudé (1):
  cpus: Define total number of address spaces in CPUClass

 hw/core/cpu-common.c      |  2 +-
 hw/core/cpu-system.c      |  6 ------
 include/hw/core/cpu.h     |  3 +++
 system/cpus.c             |  7 ++++---
 system/physmem.c          | 22 ++++++++++++++++------
 target/arm/cpu.c          |  5 +++--
 target/arm/cpu.h          |  2 ++
 target/i386/cpu.c         |  1 +
 target/i386/cpu.h         |  2 ++
 target/i386/kvm/kvm-cpu.c |  1 -
 10 files changed, 32 insertions(+), 19 deletions(-)

-- 
2.34.1


