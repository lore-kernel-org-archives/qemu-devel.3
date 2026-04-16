Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE719F8E486
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVLY-0007kN-Ej; Thu, 16 Apr 2026 18:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron1esau@gmail.com>)
 id 1wDSzh-0001yz-SN
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 16:07:21 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aaron1esau@gmail.com>)
 id 1wDSzg-0000HH-Bx
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 16:07:21 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbc5ba0661so690393a34.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776370038; x=1776974838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j7mlXGy8qysJsZPsO+SOC7y9kJmSkxb+XFBhcSDDpG8=;
 b=NAL6Y2iXfd7qyY92+5HQiT7gqd7keVDXOUbK5RjHpmbN889GEoiFfP/fEds98St07D
 rxFe8lfbOlDfy1XTErVV7pXIC2itlAtLZnEUgtynkCVvfMh1cajm1l5BWh8NKdBOvhLo
 +mEAGeheagHyvAO3RSLue0RHY39FhKAuhUp7hAYaOe37uaS7z9UdnCY6cT64EhwIEAKw
 vNG/nf2qDk5XK1qFnzWZ1dbz6beZIMUnR8MBmfZiumrUuHk8kExitsGrCdXiUA+DkJao
 MuVpDv1T5QtmSS3ZdDNyVwnLJgIsTJ6/Yl4sw/jOr0TyKQorgI2bkvgr54w9Q/6MSRty
 IPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776370038; x=1776974838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7mlXGy8qysJsZPsO+SOC7y9kJmSkxb+XFBhcSDDpG8=;
 b=kKi5ceeQmCqpOEeNuF58SfTtpBBpSiMt9OtesLpf2DMIM1G10RXrA+8sPSnx27vl5i
 4r3t6Ft1HDTfVsV2f6fASoQ5d48EkjsOa8MHcBjDFsMjCFhTy3KT62SGwll5ABpR+IlA
 faKP/AmBJnzsN09iHORetO/rNkJnE0Vw2pXDyHPZLu85Ngvj9o/l0RVIZBfVaWA0Co/R
 gks9GIY1M+W3TzIksz/JEj3uixInzUgBxD/LRqn1lZkPbJQNC7scYm4FNcssfMaQmSZL
 JkgVZAn1Ws9z5sK5kjC0vfuw944kGtQIyxK8GmTjl51Z2EF0nGtNqYz7LjFdMU/UpQ2M
 tK3A==
X-Gm-Message-State: AOJu0Yy95Mjv4G6t6Bm6f/x8D7zleV8h+C5qwfCLOlK05vh268WYLfun
 wZIgPy9/8odNGDwFn0NWgRu0bntw9jK3t0VPoRGfTKamjAswSpiUsx5/0FYDROEu
X-Gm-Gg: AeBDieu7sc+nlztHHEHxo4RWngBeobwGVtn5wSiZeNLWVnxkPMOWoz83dIMWMEztmkb
 jRu2zdTQZUfDtAr/ZTD/oOsJDRnXI6ikwNfQ6Mhg4ZgjNL9H7HK3Q/bQPht6KUUnIzx+tejesy5
 hQT5LQaqqxSkh2PE0Rq2EsFMdsdvDeL4xhFOrlqW4OsUh7SH8eW3DByp3jlbFt+Bzke7T5EbP9J
 ieOyl9v/wryeNSDHeR3EJSyuFqtPV2onYOKDp0hM6Z78inyA63HB/Vsm1RCRnLCMA+cNATEkzH3
 o4lsPlVpJAPqNaInXe0CtRbKhRzRU6iHSLxOKeyfJi/1D01INcPMp0ytBgA06MF49OicEYVq2I1
 2AFhi9Oj/Mm21SZs3rOkeFfeXu475o8RVO4WCEYk299a/wWJlF00lXMphHIJyzPvf0ZsHxpBobB
 OGO8TRIMFpgJEVhfCxvq4S0wQvAm6l+80S4A2iNwt54hmtuixuNd4btJeg/3q/v1+Vrkqgm7ZM1
 uIZQTDLK0W3feEYTebY7mQLa0rBn/RzDng=
X-Received: by 2002:a05:6830:4413:b0:7d7:ea6e:322b with SMTP id
 46e09a7af769-7dc94c24f8bmr17215a34.0.1776370038055; 
 Thu, 16 Apr 2026 13:07:18 -0700 (PDT)
Received: from localhost ([136.49.184.116]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc90c634fesm607962a34.20.2026.04.16.13.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 13:07:17 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
X-Google-Original-From: Aaron Esau <git@aaronesau.com>
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, jic23@kernel.org, berrange@redhat.com,
 Aaron Esau <git@aaronesau.com>
Subject: [PATCH 0/2] hw/cxl: Fix two OOB access bugs in CXL mailbox commands
Date: Thu, 16 Apr 2026 15:07:00 -0500
Message-ID: <20260416200702.2374709-1-git@aaronesau.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=aaron1esau@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Apr 2026 18:38:01 -0400
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

Two fixes for CXL Type-3 device emulation in hw/cxl/cxl-mailbox-utils.c:

Patch 1: cmd_logs_get_log() performs pointer arithmetic on a struct
array using a byte offset, reading past the end of cel_log. Fix the
memmove to use byte-based pointer arithmetic (cast to uint8_t *).

Patch 2: cmd_features_set_feature() is missing bounds checks on six
Set Feature handlers (soft_ppr, hard_ppr, cacheline_sparing,
row_sparing, bank_sparing, rank_sparing). A guest-controlled offset
and payload length can overflow the small write-attribute structs
into adjacent CXLType3Dev fields. Add the same bounds check already
present in the patrol_scrub and ecs cases.

Aaron Esau (2):
  hw/cxl: fix OOB read in Get Log command due to incorrect pointer
    arithmetic
  hw/cxl: add missing bounds checks in Set Feature for PPR and sparing

 hw/cxl/cxl-mailbox-utils.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

-- 
2.53.0


