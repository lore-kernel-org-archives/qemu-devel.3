Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5E5CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH9ji-0005sY-12; Wed, 14 Oct 2026 20:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9jg-0005sA-Cn
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9je-0002r5-Ng
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EM69fd1013191
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Ow/Wv0A58qSBDfAIEPfju1
 t/OfZpAtj9GtYhI5n+o2E=; b=UCx36UJrcn53XnduwlHHz9eoxT8K7XIM5HvXKk
 x/9P9H+M/uagOTZUE6QWBmDTc0LwSdZ4tTkH9cKuQcEhH6QvC1XEhhHBWifpJj3D
 FLNX37YbUjOwuif7RsEih+7GRUmr8csYqDV5kH/epEXsA+C4o74tb6wS0gppbz20
 lV08oQi0uOAElWTizLTOe0IOZY2KFxufZVPDHAMBN1XnLArVhS8qI+tOd7KXLx1Z
 1YY9VqMBqyQEWoN3hWM/K6hmUor6xqgbkiTMemXmne4LpEwpFMofimHegVDllclO
 RRAR1l76shOz3Zxt6va48lA1bTLSIOs12UqoGnMoyQBTMPhQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80cu1ny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35cbea41088so2323017eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792025655; x=1792630455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ow/Wv0A58qSBDfAIEPfju1t/OfZpAtj9GtYhI5n+o2E=;
 b=WlO/cSsVxBKZs2TF0LtC3rESuwlzJLQjXqGzTvk2COyHunU70mZpnYJIQllXDZ+GPb
 CEdK9V+HCCjJ9Ej9gAUoMiyHwVjm5JUhCstj9mK2IieRLvQeNIN0FMmPCwazu4zWcYeI
 BxZ1BY2Y418eNNleCPa52ypEiX+1HSS910SdKXK0EVoeTltoU4j/cUGsEruT7ZXyuHF1
 ziX/E9gMTGd6PX/aAHgqENl1HbH26q/cZiqcBopmYKWjstUGpEZMHCJORRW09cdBzSfm
 vO1jGwpm3NDtrvyZnX//xmcVTEZk4Pl7/6x5kD2YzuCo+QLT5Y4YsVc/DeX3pxDpFo/g
 GcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792025655; x=1792630455;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ow/Wv0A58qSBDfAIEPfju1t/OfZpAtj9GtYhI5n+o2E=;
 b=cBJCbD+MzZSN4ARuNQmBeiDtHiBDoSvO9FeG+pzvorHFVf+sBpEIED7yJ35He6txu2
 /FZ7lngpPUixlhmJ8exRqM6QqE6WnnCPoyy08J0NA6fZxckEoqRxFkgbyyVF3dMLBfl8
 K3pikJWwqQOwFc8hKAuQ6B5VAhYTYNlmAuNIzW6VBXI601b61uWFZxYuE4ASAHtnuH0J
 Qvj4h8RN/e80McdKSBNY5UEWiJ93FCtkU//YhW7juWPpuudfXHHU9g9svOD4HXNHHPHB
 BBFYX5pBDnc6fI6MDED9qZkvuE6zylM9NV12XBv5Aq26s3RkdT+1JIrFEHnfp0roU5o4
 ulmQ==
X-Gm-Message-State: AFq9FYI49eFnnCXHKKFk7z2zxOF1yQFLL5P/RP+0E3kGz2s40TVDgMan
 NO/XOaMKSbW8uoUY3mlImBeXHkPOfDB4hz6glq+sZOWL9UUePEHfZWpejC8DA+3nnEr1akE+1mp
 0D2sh5+PNkvPMMuZMk1IuZ8kyZUib9VOA+8ICYSKpEq3pcC0RgpFN+ZQz1GlP5iLCqw==
X-Gm-Gg: AYBFou2nhb7xZvYwwMQtvCJiogLb8LagynRnATbVNz5J0L4kGKE7yX1laZkB+svhsAR
 n6LHZXjbTAI43qpiRJlwHRE8PBJ1ywTmpyuTGhx/nCbpjnuVLDu1OG7tSvVDHzp/hVBNVkEilWq
 HxunOwVsgtnkKCmJOEQFCuobAxLfAWtSRH+uUJQv6c9w2exkbUOjmwpeEZde3nATe1513ZIisEB
 1JE8OXMxa2zWxeTTV4FZP1kVGTAYAzB/rmuvKIq0A0+ldu7Of7j62yotAwwFgZzUNXA4TUiAi+b
 HmKgtE7i4qaQzljnRvS3ObkQbtyzur2qQIDJRNIh/KTsjNNo6vj6eSSk6OZwIqP7qfFvO1keV2V
 UqvPGEJG1d17pX8BFVxGF/09dXj+umRG1XJAI517+pAJtr3lC0gOr0j0p5cWB
X-Received: by 2002:a05:7300:d209:b0:35a:47ed:c39a with SMTP id
 5a478bee46e88-35a47edc590mr14525360eec.37.1792025654732; 
 Wed, 14 Oct 2026 17:54:14 -0700 (PDT)
X-Received: by 2002:a05:7300:d209:b0:35a:47ed:c39a with SMTP id
 5a478bee46e88-35a47edc590mr14525326eec.37.1792025654076; 
 Wed, 14 Oct 2026 17:54:14 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cacb61asm60487033eec.21.2026.10.14.17.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:54:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/8] multi-target: remove qmp_query_cpu_definitions duplication
Date: Thu, 15 Oct 2026 00:53:47 +0000
Message-ID: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfX7GnNmhPTsCDF
 kRbzSDtbMZ7rqaoHRm+yOC3BSa5QHMDeQ1XVYHdpXpWBG0l5lOj3Z1VhNO2rSSz53Rmx6jaK7Gu
 r5dnkYx5RSypcg+fEFBUk3CMuynzOes=
X-Proofpoint-GUID: V0oY1lui-Gcw2v-Az2HfajhR9TCIDUg7
X-Proofpoint-ORIG-GUID: V0oY1lui-Gcw2v-Az2HfajhR9TCIDUg7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfXyDCMSd0tEsly
 AtGPfu5p+vcGhfKpP/dVgOToMIUoqElTzkovXYz8KcObQ37fefWDLsAi/wCb13zEUstutTDXo3s
 55CngL1oP8xLQ8/w7R2GIrcZg/jbtPyWkU4PcYZPMMAbQdoqUGAzgC7ZoYBd97LfGY0T7OStR9z
 1Z34PtjjNiY6mN0sjmD6Js1BNGirgqEtBXYdPbaoLWA6iTfGDHnuAXD5AlZ066ml9yc34ECAoOL
 dBISzvO6a5Xp5NH8b3V0VEnfY69az0sx9UrrIHZM9pQ2RUHfVS05+fjIioptFxO0raSnshoJslb
 Zsj+RVA17eKLeeiSvhDAIsiExqWboN28aKqmB3HfHkfIwvAEIEQjtC3yyklqSMaJE/S2jULs6l+
 ZUgGtonmpOmyFwu9NeQiULIKfI3nTqwBc90JnvW1XoV9BQWRfAsx+Zr8YNkFTlcbki7uFI6jMU6
 +BFMW5aBLXt+N8mGTMA==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6ad02437 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=wUHnoCWPEXWhlkUvxxAA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150003
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This series allows to link multiple targets that define
qmp_query_cpu_definitions. It simply replaces the duplicated definitions with
target-specific ones and a single dispatcher. We didn't use yet the dispatcher
pattern, and it's the first situation where it appears to be a good fit.

A possible alternative would be to introduce this callback directly at
target-info level, which I think is a less desirable solution, since it would
ties this API to monitor.

If the approach here is accepted, I'll extend this series with
qmp_query_cpu_model_expansion which follows the same pattern.
With this, we'll be free to link together almost all the base architectures.

Pierrick Bouvier (8):
  target/arm: rename qmp_query_cpu_definitions to
    qmp_query_arm_cpu_definitions
  target/i386: rename qmp_query_cpu_definitions to
    qmp_query_i386_cpu_definitions
  target/loongarch: rename to qmp_query_loongarch_cpu_definitions
  target/mips: rename qmp_query_cpu_definitions to
    qmp_query_mips_cpu_definitions
  target/ppc: rename qmp_query_cpu_definitions to
    qmp_query_ppc_cpu_definitions
  target/riscv: rename to qmp_query_cpu_definitions to
    qmp_query_riscv_cpu_definitions
  target/s390x: rename qmp_query_cpu_definitions to
    qmp_query_s390x_cpu_definitions
  qmp: reimplement qmp_query_cpu_definitions as a dispatcher function

 hw/core/machine-qmp-cmds.c            | 32 +++++++++++++++++++++++++++
 include/system/qmp-cpu.h              | 20 +++++++++++++++++
 stubs/meson.build                     |  6 +++++
 stubs/qmp-cpu-arm.c                   |  9 ++++++++
 stubs/qmp-cpu-i386.c                  |  9 ++++++++
 stubs/qmp-cpu-loongarch.c             |  9 ++++++++
 stubs/qmp-cpu-mips.c                  |  9 ++++++++
 stubs/qmp-cpu-ppc.c                   |  9 ++++++++
 stubs/qmp-cpu-riscv.c                 |  9 ++++++++
 stubs/qmp-cpu-s390x.c                 |  6 +++++
 stubs/qmp-cpu.c                       |  7 ------
 target/arm/arm-qmp-cmds.c             |  3 ++-
 target/i386/cpu.c                     |  3 ++-
 target/loongarch/loongarch-qmp-cmds.c |  3 ++-
 target/mips/system/mips-qmp-cmds.c    |  3 ++-
 target/ppc/ppc-qmp-cmds.c             |  3 ++-
 target/riscv/riscv-qmp-cmds.c         |  3 ++-
 target/s390x/cpu_models_system.c      |  3 ++-
 18 files changed, 132 insertions(+), 14 deletions(-)
 create mode 100644 include/system/qmp-cpu.h
 create mode 100644 stubs/qmp-cpu-arm.c
 create mode 100644 stubs/qmp-cpu-i386.c
 create mode 100644 stubs/qmp-cpu-loongarch.c
 create mode 100644 stubs/qmp-cpu-mips.c
 create mode 100644 stubs/qmp-cpu-ppc.c
 create mode 100644 stubs/qmp-cpu-riscv.c

-- 
2.43.0


