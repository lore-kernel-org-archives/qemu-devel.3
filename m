Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE2DC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7zu-0006ED-Q1; Wed, 12 Aug 2026 08:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7zk-00068e-SA
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:23:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7zi-0001gC-10
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:23:44 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB48XE3319906
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=j38FxBtf+OXJ2VMzeFHrVk
 +G36hQVcIl3NxeaICWQzk=; b=D8HTut+c8nT8ASDck1cp8t1Gw3zmy0gUX2qhKQ
 NOOHJHmyDfUOwTzlmxidHnzpeKquhIh+wgC6YZCun96zNJ5NhQoWaSoBzMTtFtpM
 A7SyIz5GITUYApuw0cxs/6pkxaWILPLRBb/d7bJ+p6qVWuDmeKXMa8nwbac8LQr8
 tBDTnCjJ9gHbE456E3oO3QB7876QH4OvpDGxQrkVa4Hr8g3axkAOn+tC/FEhEeRk
 mazQy0vYoH4k6sFO0j2jDw0M7EVm6HvESpeOGwOn0llW4uMW3A9+x4aN1oErcP9I
 c1PAgTpGzfyy1LPMbq4r5a7EIjL6eYorj4RDh8W3jQ+dSUwQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0pmyrgju-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:23:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso16402221cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537415; x=1787142215; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j38FxBtf+OXJ2VMzeFHrVk+G36hQVcIl3NxeaICWQzk=;
 b=BnI8jy/NUtpLEvFbYAqJzs02MsQuY7sOVNx3bN0NWRStwbVxE0Kru5baDnilNTT3oa
 P13rHPBN6WcJ9dSvHmUWlyGVdWSim5t+PhD2EmT0c5zMcQgaXnHJ8HEy2yMHGpNCMnuq
 gCYekF9PrHQ7ykPnrpGcLKVnYlGN9wzYy1B35iZEPDOuFTHAnqeQMisVWSrCrTJ/8N7G
 KIP2e960tQ3ZJ3iKjOsZLBh9u8bBfQmlCJk1yUnEE7dF0XuTbvjP8guiHsrIuJDcvcl4
 Y7qTJ/JU0ba6LWRUr3xEYTUwOaiVNEYqLHoTb1tdSFWVZ8meSv5jSSNqDaoW+3f/Mna8
 6DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537415; x=1787142215;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j38FxBtf+OXJ2VMzeFHrVk+G36hQVcIl3NxeaICWQzk=;
 b=k/Xy3x8JpRY5L8YgYT8AiIfmcrEGn3EHfG6oRkXdXoH1DW8YONOldBQeJ/Uket1XR6
 7Lar9PUWmZtr+QE0TiaSHBKAAs/19ZfxLb+sWG80XM6DEfy94ljcJ8unAVWJ56X1ZKQT
 tlLJpWf7Dk3xjjqAFxgiiPKlaQLLx0eA7PfNZUqdlApnJCnkHGh1Gw7K8fNyfi4cbZQe
 3MIb49KpDG7gQMFaw/4UtGFeY22fhaNWmhemSU0pERC76Y/k+rRpQfB6EWStp7kFu9Ha
 BQpoykX0R9bpALnpz7xHghrr+++5mbV+Ld8oIuD1rFN06bkd5XgOKiG2/m1hSRazdKDn
 5tDw==
X-Gm-Message-State: AOJu0YxzUBcGEwVz697k62qLNh2SKyck9FyaCwS4ceAxrFS1jp6JMgay
 LwWt4lNghfO/VOVpJaWfLxGD4cqjUJqkF6+Vr/hWWDXTthNK11wY4ZJM4BcWriCuuRxnP4kDnbB
 MpfJbas4e0olbHw1MHw31XwrbOPYXfopnkmN5Av1+K46mW25sqvDDo+TdIhrV2OnaNQ==
X-Gm-Gg: AR+sD10UcVYYoyXF2fRyzx3kJkp3rNH4a4nYX/F/InNfHq+1V3p6RaUqjPaAL73iOuR
 akDWvdc1dutpKE03qNoO47gKTV7t6vN6tJOlMbFgjBGjeXjyplPQZgAmXm0f5OZOYitahr8SrPX
 Vsj+tBxI/57WK6D41JMmVow8pU7v7IArESR2VfCtfc/DMcszQMD85fDJWwGShTjOHvRXzyznfTH
 /SvP2OkgCW/uXtWzvwKEyipnMlz4A5znn3oLSuMeYUPl62TTuJ3TlAtY7fbfKdFnL/WmSYriYml
 zXRpJH1cIlpMRcuc1lpb1I8h1doxZD4HeTWHuKgugvd34jch1LDDYKhbOh1WdgyXcGMNMenMypo
 3XSoTTRl4KIS2UBYzecoeqHxTpdbJdH6fUcHBQlN4wg==
X-Received: by 2002:a05:622a:5916:b0:51c:a2ea:64d3 with SMTP id
 d75a77b69052e-52d6482dd01mr36685631cf.35.1786537415400; 
 Wed, 12 Aug 2026 05:23:35 -0700 (PDT)
X-Received: by 2002:a05:622a:5916:b0:51c:a2ea:64d3 with SMTP id
 d75a77b69052e-52d6482dd01mr36685161cf.35.1786537414996; 
 Wed, 12 Aug 2026 05:23:34 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aaa5d04sm65973015e9.2.2026.08.12.05.23.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:23:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 00/14] monitor: Reduce headers included in 'monitor/monitor.h'
Date: Wed, 12 Aug 2026 14:23:17 +0200
Message-ID: <20260812122332.72975-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfXwwvy0LuM4ouL
 BmcSLestMXrQGplud2l+JZ86Hg+t/7XimjW0uq1QEPOiMBq6QEQr6XhEuDusi5zNlHH2eojFy8r
 JaiXJpYvZtwypEuuRdkHrgRB/thl7Ww=
X-Proofpoint-ORIG-GUID: 5gDEnBf8A2rvZBpokWph6mkGA8205YJB
X-Authority-Analysis: v=2.4 cv=C/fZDwP+ c=1 sm=1 tr=0 ts=6a7c65c8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=d4O54NvR4bFj0fUtpZoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 5gDEnBf8A2rvZBpokWph6mkGA8205YJB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX3UMJ3IsNM/vV
 /uh4AOlG6LLMWGxqDAHpsP/bIlhfPDDSaE09eIW61LmNTDdOmyjHjFS7q8caOlC/VWYy/WwT8Af
 IWtOj26U2juMDYjvzdqZWIzWZUPEvIMnTXv46tDVuzKjAp5387/xojSTXBOCDp/W0EAobujGBaS
 Uj58azuG+uswyIvg93248R+ee1+WTJ19WkB4rR9i2d+KATcDWZu6H6dUtQlZOlDAOVi6tifUXIT
 qdfV17aYpqZ2+vqdJ0khljDEy8mXN8VqLDfk9apKMSlA+D4rn0zIsO3KsgAMxhfZqpaCtdKOpeD
 6gUWuyz/TgCHSgl5hoOSePu0DyboXsa0UVA92y7TP1B4L+9n9fzhZakLPVX6IOCKNvbDFz5d4wE
 WSlgicPtm0rL4BUJS3v5wTLePDMHwumUqBmAbUsM57VofFRytThEFHyQFTwBspi0gg6NuiptvZV
 ckYPEH5W0Ci0z7PvzSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120100
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

Another HMP cleanup series to help [1] Marc-André with his
'Make HMP optional' series [2].

We could also remove "exec/hwaddr.h" by moving gpa2hva()
declaration elsewhere, and "qapi/qapi-types-misc.h" by
moving monitor_fdset_add_fd() out to some "monitor/fdset.h"
header.

[1] I expect his work to trivially rebase ;)
[2] 20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com
Based-on: <20260812121232.71958-1-philmd@oss.qualcomm.com>

Philippe Mathieu-Daudé (14):
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
  system: Move runstate-related code from cpus.c to runstate.c
  system/dirtylimit: Extract HMP code to dirtylimit-hmp-cmds.c

 include/hw/hexagon/hexagon_tlb.h |   2 +-
 include/monitor/hmp.h            |   1 -
 include/monitor/monitor.h        |   3 +-
 include/qapi/qmp-registry.h      |   1 -
 monitor/monitor-internal.h       |   1 +
 target/hexagon/hex_mmu.h         |   3 +-
 migration/migration-hmp-cmds.c   |   1 +
 monitor/fds.c                    |   1 +
 monitor/monitor.c                |   2 +
 monitor/qmp.c                    |   3 +-
 qapi/qmp-dispatch.c              |   2 +
 system/cpus.c                    | 146 ------------------------------
 system/device_tree.c             |   1 -
 system/dirtylimit-hmp-cmds.c     |  74 ++++++++++++++++
 system/dirtylimit.c              |  60 -------------
 system/physmem.c                 |   2 -
 system/runstate.c                | 148 +++++++++++++++++++++++++++++++
 tests/unit/test-util-sockets.c   |   1 +
 system/meson.build               |   1 +
 19 files changed, 237 insertions(+), 216 deletions(-)
 create mode 100644 system/dirtylimit-hmp-cmds.c

-- 
2.53.0


