Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E064CC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjFw9-0007Ox-LB; Mon, 13 Jul 2026 08:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wjB1F-00030m-3h
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:24:03 -0400
Received: from mail-pz2-x01.google.com ([2607:f8b0:4864:3b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wjB1D-0000Xj-5t
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:24:00 -0400
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-caf5fee4196so260354a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 00:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783927438; x=1784532238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vjU1tHH91CMx72VYa6DswxUTivHn+PJH2Yjz6MHUXUo=;
 b=AyNYERRtLOuNKsuxOgz5gMdImBG44qTrFaDgvkPS0rVTcAQjdLbHzKKemUo+P2gDSD
 prhFxRdfXZat1fbo3iBIsVp6IebzV7PockmE6qJwo/5RUBYP3zT/+FicIysnRAR1GexP
 k4eXj17ZkfzVYsU0L9BzMC5wVeYfFfXBdeCcJ4jbn0FdzD9VXKdtBL5eUVepTFPFCgUU
 difCHeX+HCHVWZPClwgFz94nqV2OjjNrMlMmkdC/qNqLqlr7uF9l/WZ9smpbk+2zxhj9
 3Buze41CG6AB3TFAqFYjmWeP+FfeM18Ie+9U6+qMC2mkxclKxq8bJeg97D2sShz/Bq8+
 FXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783927438; x=1784532238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vjU1tHH91CMx72VYa6DswxUTivHn+PJH2Yjz6MHUXUo=;
 b=dBs8n+FB17KHhGjISl0FcrlC9jqmoqNqcOTB6MgrDnfsPMWNepGcZPpCBD2SC7PPsN
 eje2AaRYVzoLdyYauEUfDm0CNjaRQ4xvDpVNW8+tutirIC0mc+tGxOqTUbZyKvIDxWfT
 hTz3ZGqOcB2m0weq689FMWV0W47BZJHVzM65HkB+oz1PUwnE7hOLIP+IPT3DvHj2GpFc
 NASVbjbDIpeDKss7MflJLuHMdcAUT1NOJf1eW28O2Gi0DunItEMizcTzSfQ1bNHyikLO
 +v4Kat5a1/SB7pLUv1SctKm7CAzVw8Vv7diI4FdU+gh3QMWnF9S0ogC3Bw/6oLHmcfKe
 l7ig==
X-Gm-Message-State: AOJu0Yyt6SSIG2PqBLcp+rO9YUqZUwJV/7ek5uCoINOST4i7dsyQ5Inh
 5K+QghQGHtt/lLivayjftA9D05tEbMSjrVzMuy5KrxDtkB5JM8qqsOmEq3FUcsHLp6jD2/wI04k
 =
X-Gm-Gg: AfdE7cnzJghKzEojOZ+o3yjaQbwETpwOlbfcayaa+SKOlFVs0wfzATtzlNfputiA8uJ
 actQCb6J6ronnH92jLZ2XXIBo6nAebkGohFhl/kbyMjS5MdspruyMNIBiJdqfxxjOD8bl81+FSW
 IdCUZC134P1Ju5zHheBCwu/Ofj5P8UewTx58TWtpcxzJIwz5HZ1kuZeaq0LxGDsvCvk+G88qv4I
 hEULe3JMjhXNT1iEVX3SK10al8vVNubhaBMTk4e/EHTybDn4ZBBx7TO7tjE5UdkRLiORPi9OrZv
 PT2Kd9U6hstiKWXSpX9q2oj4j80fFaO9HOeK0QUm88sGP0rdrzaXf7B5kpHrQkg1O22GDop5WAN
 IfXg6ajMzp/r0Oe1eN1eqLgIwrRM0FYVruVHh2w1EzyqhRa3ZzCHDqXeMsNMeo6lY/rpeN30r06
 XcLGSr2PxxfOLUJoXADBIB+DF2zH86BWbaIQTXI/K5Q0SziSRrFgQUPKmJTiCxGtVMwp9zOtang
 YAxExW1U/oScMFOPrXIXUqOqxDbFRk5UMC1I+0=
X-Received: by 2002:a05:6a00:850:b0:848:732b:6b1c with SMTP id
 d2e1a72fcca58-8488970e4ffmr7648794b3a.60.1783927437631; 
 Mon, 13 Jul 2026 00:23:57 -0700 (PDT)
Received: from VM-210-252-ubuntu.. ([14.22.11.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8480da8bab0sm12070765b3a.8.2026.07.13.00.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 00:23:57 -0700 (PDT)
From: jianghaotian.sunday@gmail.com
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org, mst@redhat.com, linux-cxl@vger.kernel.org,
 qemu-stable@nongnu.org, Haotian Jiang <jianghaotian.sunday@gmail.com>
Subject: [PATCH 0/1] hw/cxl: fix OOB access in cxl_doe_cdat_rsp via
 entry_handle
Date: Mon, 13 Jul 2026 15:23:35 +0800
Message-Id: <20260713072336.623604-1-jianghaotian.sunday@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::1;
 envelope-from=jianghaotian.sunday@gmail.com; helo=mail-pz2-x01.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 Jul 2026 08:39:03 -0400
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

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

This issue was found by Tencent Security Yunding Lab during CXL
emulation security research, and reported by Haotian Jiang
<jianghaotian.sunday@gmail.com>.

cxl_doe_cdat_rsp() in hw/mem/cxl_type3.c:280-282 (Type3) and
hw/pci-bridge/cxl_upstream.c:160-162 (USP) takes
ent = req->entry_handle (uint16_t, fully guest-controlled, 0..0xFFFF)
and directly indexes cdat->entry[ent] without checking
ent < cdat->entry_len. For a default cxl-type3 with one volatile
memory region, entry_len = 7, so any entry_handle >= 7 reads past
the CDATEntry array into host heap.

The OOB-read base/length is then used in
memcpy(read_mbox + offset, base, len) at cxl_type3.c:298-299, leaking
host heap memory to the guest via PCI_EXP_DOE_RD_DATA_MBOX, and
potentially overflowing the 1 MiB read_mbox heap buffer when the OOB
length field is large.

Per QEMU's security policy (docs/system/security.rst), CXL is
classified as non-virtualization use case, so this is reported as a
normal bug rather than through the security process.

A qtest-based PoC (poc.py) is available for reproduction. Under ASAN
it reports SEGV in cxl_doe_cdat_rsp at cxl_type3.c:281.

Haotian Jiang (1):
  hw/cxl: fix OOB access in cxl_doe_cdat_rsp via entry_handle

 hw/mem/cxl_type3.c           | 3 +++
 hw/pci-bridge/cxl_upstream.c | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.34.1

