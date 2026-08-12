Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55AFC5DF65
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGK7-0006Zi-Ka; Wed, 12 Aug 2026 17:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGK6-0006ZW-5w
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:17:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGK3-0007jg-RA
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:17:17 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2QrZ246262
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=g21U2AvR+fV56XJQnRX6MG
 QUvY39VHlamAyjZjF2RCM=; b=cZUGveaIFqcjVkpKANvEH8GlVC9gIdYGKkKm9B
 Yp/IiK/y8ylE439XJwP0ZE+SJb4JrpApZgICpsM8r0rOcXM6Rtl5qMscVKY+s9ky
 +id/FJ+7tXLNAnqeKR3vdliHdhtUyKrYgJ9jR+o6tf7PY7VnKsVe+NMRlZH+rL6C
 T3Wa5wKUGsdu+N33WbcoXYqZtqELfVJ6Urvi4Lyva235yj7iGPartRfPY7iMgvbS
 athnNX49LFlkHCfDiTlnF9qZjjBaY6WvDaAsRgTSsWDz9GPO2lQw5/Tb7BW5a6nA
 x1W+3AvjcRTdIkQkkdrFEj2ELUOfezZXxT8uU57xyyPZBHDQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0uts1ekv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:17:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso13898321cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569432; x=1787174232; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g21U2AvR+fV56XJQnRX6MGQUvY39VHlamAyjZjF2RCM=;
 b=A9FyO2UyXGpSAHucUAcegBpkMEhBgdXFzq64GAH58AOQANA21rB4iq94svt++2K/bR
 8hVrTM4UgOY0XC5MVmRQsU5YbGiRK03rfzlsk7XlYYyn7sbDv0XJ910hZO/Eac6jM0as
 +xUlrs/UBP4P0zWCiJMRzO8r9VENbi/7AeVr8+IKLRh9XdVPjXc+WeB7A1l8iMbKwZoX
 ykXFUhT3Xy18nYu958LbzcARen0Z5M9KPSlsZil8Jl37QfIhHt7S6kJdNVYA5/cB6f+G
 4lH9MWFyNNw1+mkruBcwDWKzlc32W3MXuJMGy4k/8yvK4CJb9rXkEGBNzu9F9N3icBU/
 UQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569432; x=1787174232;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g21U2AvR+fV56XJQnRX6MGQUvY39VHlamAyjZjF2RCM=;
 b=oJgfD7YVAAPcsuHbms0zo1cwI1z/gu0z2/sUmdP4ohMZGi1mUkhbXamYP2xX6wRP/S
 TDl152ULO4aH5w3csmG6myyuA7FraX34f8996iXEvY/vsg2/1bQJ0LmU/3OxHf6yxjAJ
 Vc9bcnyU02HhNr0bZGEnQ1r0LaHU2SS7e+biUQugdGziF6wfZpI+ptBzWaMHv0/8r+Pt
 TpIdpJThVkTqBOK3O1eA6Uyrrlx2V8JbZsHtzlyMEC6XPBpogzXCxg4j/Y/wQ/e3aeB7
 fDKt1cYUyitfMO6rBMi6qUwkmYOplApe6iUkhdV6aN792qGaSUtGxjD8Lb3qUXSF+wdh
 LFgQ==
X-Gm-Message-State: AOJu0YxOU3+Q5jhQ8l1sOVZUU7Yb833McDOGRo4WxfuJqeUjLkJY4iWA
 2Gnceu5PGhKtipXVDwbzLntmL6dbm7iVgJVVq0mi1MNdrXgKW77SAbYjgBJt6GvGmcHy8PHQwdJ
 odGCW3yfap3NBo3nGejE0+N47Vy3YUbGTgBYf2l/eVViHQcO3efQ6zdBXCLEteOJhvA==
X-Gm-Gg: AR+sD108swSd3pzIeMNc98rWsIt/w+kHxNe4pS9Ik1pA2LbKV56QZUsIRS+r+58DBY4
 lN5Ch+mWbgNl7Z7L8sRstghsyTzPQoXeOQSk7jT5030e4PoPph92ywuBd8+RAkIi9svAqbzOx9s
 0PraNFM2R7DTLefvbILEfkgZuXgEs0pBiXbxgdliJACVlJvjUS6tBCBBpirby101zg1csAcG3jI
 plM3PA9as7qyRVqravXktkTSansdDEIIgPdT9Fx68U9hemMnrVDe2Nne+hHsRUQW33ZS/hMWOdk
 JLX0Vs8nsYnb0ev/043zefmT9LHqWsS0GHD+2W3NJ/mxwAhqhr0mueHG3ufyetGrSUQcOkgGZXI
 dasGiLQIEKeo9Uk6DlDkaMHZzQAuGopg2oVe1c3HVSQ==
X-Received: by 2002:a05:622a:1b18:b0:519:e91a:f4bb with SMTP id
 d75a77b69052e-52d73d4d055mr12712941cf.31.1786569432046; 
 Wed, 12 Aug 2026 14:17:12 -0700 (PDT)
X-Received: by 2002:a05:622a:1b18:b0:519:e91a:f4bb with SMTP id
 d75a77b69052e-52d73d4d055mr12711771cf.31.1786569431148; 
 Wed, 12 Aug 2026 14:17:11 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b03e70sm16415025e9.3.2026.08.12.14.17.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:17:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 00/23] monitor: Reduce headers included in
 'monitor/monitor.h'
Date: Wed, 12 Aug 2026 23:16:44 +0200
Message-ID: <20260812211708.92824-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rj8oEId6lV7kKRiiiHVMPy-a8Fc4MF7G
X-Authority-Analysis: v=2.4 cv=aPDAb79m c=1 sm=1 tr=0 ts=6a7ce2d9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=PunLHkGzCN5nvCqCOncA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: rj8oEId6lV7kKRiiiHVMPy-a8Fc4MF7G
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfXz3MkOcb8aKDk
 6dP7HthgWvL/z/wzzqe2wix4DOlCyubkown/ah8hw6vc3PMRtrLCRJjCBYiyYnlCW0puNFXniku
 scvwNRLTBKm4Z8SMh9qXUBkfJagM1Ag=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX2MExEZ7pNRSM
 YE1554q3aP4Hdqp4/v+sOQW/w1AjtB0GE7uaiEA5+aUv2tvMuk9jwqqYsLjeaCoUvB790ecVn+k
 5TMNjSLqnsaC64poEd1TBjByEczy8oUICJBBSfaF6vRDWIVNkerRFtcyJYX1zYe+UAEEEy+vP+H
 FNqyOfvl1EKWGHiNHzpmxeVjt8cEJkjBFh/s1HL0/CVhiO9Zwo4TYreZ4TCu6X1H8rsqyhrTcN3
 dYOAV+YX0jCgFZ9U0TqXku5C0+V3pQGadsdDW5AQmWahJlAOEGIr92+GSFnGL8eHaDpMrxD2Dwq
 F1s514quqays0ooZEwcIKJAr6fY5AwNNJ7Vmj88cF2heVf3X87UMy2v2mEYVukJkdw6+dbn1k0j
 9TUyosxWg6oVU1FjK2NZGvPzsKk4eYBkrhNtKaHHSsd/QyuWMOETOQ7FhRroMoC0aDns/1Iy8gA
 +czDchH2v2cZkQ9HHUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Missing review: 2, 11, 17+

Since v2:
- Fixed net/vhost-vdpa (new patch)
- Use QOM-cast macros (bonus)

Since v1:
- extract QMP inject_nmi/memsave/pmemsave out of cpus.c
  (first 12 patches left unchanged).

Another HMP cleanup series to help Marc-André with his
'Make HMP optional' series [*].

We could also remove "exec/hwaddr.h" by moving gpa2hva()
declaration elsewhere, and "qapi/qapi-types-misc.h" by
moving monitor_fdset_add_fd() out to some "monitor/fdset.h"
header.

[*] 20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com
Based-on: <20260812121232.71958-1-philmd@oss.qualcomm.com>

Philippe Mathieu-Daudé (23):
  hexagon: Remove unnecessary 'monitor/monitor.h' header
  net/vhost-vdpa: Include missing 'qemu/iov.h' header
  tests/unit: Include 'qemu/main-loop.h' header in test-util-sockets.c
  qapi/qmp-dispatch: Include 'qemu/aio-wait.h' and 'monitor/monitor.h'
  qapi/qmp-registry: Remove unnecessary 'monitor/monitor.h' header
  migration/hmp-cmds: Include 'block/block-global-state.h' header
  monitor: Include missing 'qemu/aio-wait.h' header
  monitor: Include missing 'qemu/lockable.h' header
  monitor: Include missing 'qemu/coroutine-core.h' header
  monitor: Reduce inclusion of 'qapi/qapi-emit-events.h' header
  monitor: Remove unnecessary 'block/block.h' header
  system: Remove unnecessary 'monitor/monitor.h' header
  system/dirtylimit: Extract HMP code to dirtylimit-hmp-cmds.c
  system: Move qmp_inject_nmi() to hw/core/machine-qmp-cmds.c
  system: Extract QMP memsave/pmemsave commands to physmem-qmp-cmds.c
  system: Move runstate-related code from cpus.c to runstate.c
  monitor: Rename MonitorQMP @mon -> @qmon
  monitor: Rename MonitorHMP @mon -> @hmon
  monitor: Better express monitor_read()'s opaque arg is of Monitor type
  monitor: Use QOM MONITOR() macro to access MonitorQMP->parent_obj
  monitor: Use QOM MONITOR() macro to access MonitorHMP->parent_obj
  monitor: Replace container_of(MonitorHMP, parent_obj) -> MONITOR_HMP()
  monitor/hmp: Remove unnecessary 'monitor/monitor.h' header

 MAINTAINERS                      |   2 +
 include/hw/hexagon/hexagon_tlb.h |   2 +-
 include/monitor/hmp.h            |   1 -
 include/monitor/monitor.h        |   7 +-
 include/qapi/qmp-registry.h      |   1 -
 monitor/monitor-internal.h       |   7 +-
 target/hexagon/hex_mmu.h         |   3 +-
 hw/core/machine-qmp-cmds.c       |   6 +
 migration/migration-hmp-cmds.c   |   5 +-
 monitor/fds.c                    |   1 +
 monitor/hmp-cmds.c               |  10 +-
 monitor/hmp.c                    | 164 ++++++++++---------
 monitor/monitor.c                |   2 +
 monitor/qmp-cmds-control.c       |  18 +--
 monitor/qmp-cmds.c               |  13 +-
 monitor/qmp.c                    | 270 ++++++++++++++++---------------
 net/vhost-vdpa.c                 |   1 +
 qapi/qmp-dispatch.c              |   2 +
 system/cpus.c                    | 247 ----------------------------
 system/device_tree.c             |   1 -
 system/dirtylimit-hmp-cmds.c     |  74 +++++++++
 system/dirtylimit.c              |  60 -------
 system/physmem-qmp-cmds.c        | 107 ++++++++++++
 system/physmem.c                 |   2 -
 system/runstate.c                | 154 ++++++++++++++++++
 tests/unit/test-util-sockets.c   |   1 +
 ui/ui-hmp-cmds.c                 |   6 +-
 system/meson.build               |   2 +
 28 files changed, 617 insertions(+), 552 deletions(-)
 create mode 100644 system/dirtylimit-hmp-cmds.c
 create mode 100644 system/physmem-qmp-cmds.c

-- 
2.53.0


