Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDDAC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8oT-0006M5-VD; Wed, 12 Aug 2026 09:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8kO-0003Kr-74
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8kL-0006Lf-5o
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:11:54 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4trQ3620451
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=eChqknH/ijcMq0OlRHooD5
 eGMdnK3UqGJPAUyhGOuyE=; b=NUk5zZKd6dms40O9XSUh6aQykaD7dff7oA5HI8
 fireKfeJwhE94LLU9kwYKqLes0btyvfMKnUIqUuSSIwcYwe+VukiZ87qpClDTAuf
 aRql3KQNmGX6yU3edPhHLiahrDdXB9rEM5T8MonIQyJF6BHRMUNVawSsuW5tMJKI
 5ODIoj+oi9xQ6RRtYneW5rH2PxDWhvlas4IpLNbYwg7Lbqxs/CPhGCeztufjrzpe
 EYSTbArkSOYOh3qET4QzyW6XOSTp5Xr+Tz9KnDLp/5ebRmpDt8l2MrMYuaDnLUIM
 mZTP3ibIVpruEE7lRWojlmflUftAvdJa06K5SPtYg4+d7c0g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj2sy3s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:11:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52827090cc5so11736411cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540311; x=1787145111; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eChqknH/ijcMq0OlRHooD5eGMdnK3UqGJPAUyhGOuyE=;
 b=Hi94wWhu9FDiNGAa5qtbFZJEQXHYbcCZq9i3kkv/hK+Df6d2nhg1VJhmm4jcJchBLU
 ZXXUjFahEfJCk7yK5PrZeEyNmlVpNftf+WkLAw9A8nGglGwgZ3Nnvy0qsOuYkFRVd51x
 Gr3RSC1Gu6KgSEYlXv/iGgrR1L8s5nyQyefIEToY3bxjXfbXtCD6peFEajHP1eBZpr4k
 n+eMFJ0FOoTFpGxX056Hl7rI7r4FljT3DETRP7I96LINc+rx1KHq5JOoJleu7rpnU0d6
 WNpVmSMuTZZ6u3ngyPmZ/vSVEv0M1Y4J9mrhHcBvPqvTBDuRZPP/aNiAJDiOs8UPF4qg
 Xemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540311; x=1787145111;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eChqknH/ijcMq0OlRHooD5eGMdnK3UqGJPAUyhGOuyE=;
 b=LTb7eDxqLhCYJr8HHBOKcECKiOmW6zswzaWAUCEfFn3CPpRi6suVPfB0s3GP1bMxRH
 6KOca3gIlhiirt3DX+rQDPKaSS+EuIRjXECFfb+bfEb8IOBN3wbxesO7LJ1QkhqOFSjT
 Vqt0n2O+DusWHXxgn/vA9RgIXqs2EoB0s7qp2wMjcM0n5TIwmxaFzZw/uXgGKVFaSXWC
 nPowoUb74yskkybXTX49kgbbgoMmc5m39bWRLXZJ91xINJVK+daF4sjx9x5hFHVR/VE7
 sfIXhC8RG62QHM7jdGFWmHTWh6dPVgzqFuyQTcS2sTJmZGe9wJ/Z7PLRD3q5O9TAdlDy
 K1Hw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrRfTa5v44/Kvr58hqiPLa+UfeRCVQnPG9VO3awFq3Nl1VEDmCU51TakYdJzQlk23dUqpFi46dQZWP@nongnu.org
X-Gm-Message-State: AOJu0Yz3z33i7GXYorad6Z7XNVM1AUaLDFoQxBkgY8WAW98tl4V4eZIS
 KDArGgeqQkax8C8UNoGxbZR0TFmBnpdbS2QtepUY/Dy+sbP9F0PdswIOPi82tUqKWfYH2VC4Xy3
 cNs16qaWVsEBhhCXFRLqXay4PoCA6CRS2MUMkLHUCSdSQoDhdXkFQ+41BO9XF9gRr8A==
X-Gm-Gg: AR+sD13wsb82HaIMvvYhp82TSbjNrZ6ickpB8pQs7O4ixSRpBMo4NwbsW/n8/k+ihwp
 6UAJ6QhHd8gXZ0d3kBdIRgZsIkvaN6D0V+UoT5cK7GuPwaX4dmqMUIbGM+xIZrijwjp8CRK6BKJ
 vs20NkvqwxupdxHg2H3d/NEPyIOqaNcb7koACvu7OnlkrVbv1sVJ/MjvuxCZ7JhfmjE1qCfnpdB
 UIvUB3tAbRBK75Gyw7vg5ywAP5V3Q99Qz367BQDFQEaUBlDngkcWgoe6uWBtPY/YCNsr77r7ak4
 Qh/RVGtxSKnkH+fb5jEqpFXlmziz64z3wniKORKd6J/i0XJ8XE0SaAUj8HSJfsQFmJ7O4fPDOof
 HceS7wOX5QPlSuVXbBVDq6EaFVHbuC4igZg2O6UXDNg==
X-Received: by 2002:a05:622a:5989:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-52d603668acmr70744371cf.22.1786540310743; 
 Wed, 12 Aug 2026 06:11:50 -0700 (PDT)
X-Received: by 2002:a05:622a:5989:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-52d603668acmr70743731cf.22.1786540310330; 
 Wed, 12 Aug 2026 06:11:50 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c9944ecsm49530455e9.14.2026.08.12.06.11.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:11:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 00/16] monitor: Reduce headers included in
 'monitor/monitor.h'
Date: Wed, 12 Aug 2026 15:11:31 +0200
Message-ID: <20260812131147.83188-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a8EAM0SF c=1 sm=1 tr=0 ts=6a7c7117 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=d4O54NvR4bFj0fUtpZoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 0ErtwKltd8otek2kpY3HH56FuBorhIx6
X-Proofpoint-GUID: 0ErtwKltd8otek2kpY3HH56FuBorhIx6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX5galFF6kXY0v
 1ZCak9ipt4M09M6hc5AF4FuYUj8Qb+Vck6iRTA/O4r5kKj3N+o0xyRMM+k9M9BGanAjgSuLfxeC
 /HTDFad3W5ClqDTQN/9cub8YptUS1ps=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX6rFDP+VQhPq3
 ptMCUbSxNIeLR/c4VfQrYlr8hJLbdSzz+oZinVfsmeSFHv3S9jmhWc04QGYmMBI6UDH6ORtHRvS
 1oMOCBtrCP/eH/TJIZhGJPsNsQDDFCCBiKCVkRO8r28CGxoIlgU04CG6eKym+rymbzc6ePOwUQ3
 sR9e00xLCduMXpuw34I96A2Cs1uCvLsbezyfqmXE1OnQf4RKlWzlN3idllF56+4aOKROZx4LgYS
 mYDJUTP2JnTGXeyH5ceZMaDPeUaMYByDZRVY351tLq7SNf/2vSPIm5EHreBgGklfNV66BnKTQhK
 J7zd70cmm2nst4F/5XQdtG51aCznAPp3cSlWkwzbIt8QGrpNSA0cp5tZP87ycRKqRM2TDaD6t9A
 IMjwStHz5BYF23ZeLno6KBCCRvIZN73EgKNXrLPNpr2543DWldKwoW9m9+hpAY1BeOivjKCOfMI
 9LztnOSSvtSJOG30oQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Since v1:
- extract QMP inject_nmi/memsave/pmemsave out of cpus.c
  (first 12 patches left unchanged).

Another HMP cleanup series to help [1] Marc-André with his
'Make HMP optional' series [2].

We could also remove "exec/hwaddr.h" by moving gpa2hva()
declaration elsewhere, and "qapi/qapi-types-misc.h" by
moving monitor_fdset_add_fd() out to some "monitor/fdset.h"
header.

[1] I expect his work to trivially rebase ;)
[2] 20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com
Based-on: <20260812121232.71958-1-philmd@oss.qualcomm.com>

Philippe Mathieu-Daudé (16):
  hexagon: Remove unnecessary 'monitor/monitor.h' header
  tests/unit: Include 'qemu/main-loop.h' header in test-util-sockets.c
  qapi/qmp-dispatch: Include 'qemu/aio-wait.h' and 'monitor/monitor.h'
  qapi/qmp-registry: Remove unnecessary 'monitor/monitor.h' header
  migration/hmp-cmds: Include 'block/block-global-state.h' header
  monitor: Include missing 'qemu/aio-wait.h' header
  monitor: Include missing 'qemu/lockable.h' header
  monitor: Include missing 'qemu/coroutine-core.h' header
  monitor: Reduce inclusion of 'qapi/qapi-emit-events.h' header
  monitor: Remove unnecessary 'block/block.h' header
  monitor/hmp: Remove unnecessary 'monitor/monitor.h' header
  system: Remove unnecessary 'monitor/monitor.h' header
  system/dirtylimit: Extract HMP code to dirtylimit-hmp-cmds.c
  system: Move qmp_inject_nmi() to hw/core/machine-qmp-cmds.c
  system: Extract QMP memsave/pmemsave commands to physmem-qmp-cmds.c
  system: Move runstate-related code from cpus.c to runstate.c

 include/hw/hexagon/hexagon_tlb.h |   2 +-
 include/monitor/hmp.h            |   1 -
 include/monitor/monitor.h        |   3 +-
 include/qapi/qmp-registry.h      |   1 -
 monitor/monitor-internal.h       |   1 +
 target/hexagon/hex_mmu.h         |   3 +-
 hw/core/machine-qmp-cmds.c       |   6 +
 migration/migration-hmp-cmds.c   |   1 +
 monitor/fds.c                    |   1 +
 monitor/monitor.c                |   2 +
 monitor/qmp.c                    |   3 +-
 qapi/qmp-dispatch.c              |   2 +
 system/cpus.c                    | 247 -------------------------------
 system/device_tree.c             |   1 -
 system/dirtylimit-hmp-cmds.c     |  74 +++++++++
 system/dirtylimit.c              |  60 --------
 system/physmem-qmp-cmds.c        | 107 +++++++++++++
 system/physmem.c                 |   2 -
 system/runstate.c                | 154 +++++++++++++++++++
 tests/unit/test-util-sockets.c   |   1 +
 system/meson.build               |   2 +
 21 files changed, 357 insertions(+), 317 deletions(-)
 create mode 100644 system/dirtylimit-hmp-cmds.c
 create mode 100644 system/physmem-qmp-cmds.c

-- 
2.53.0


