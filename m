Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68725FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 23:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHs7k-00033t-Bi; Tue, 28 Apr 2026 19:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHs7h-00033Z-G4
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:45:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHs7f-0000S7-RB
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:45:49 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SFsXOt862964
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=5BaNj8Eb+F4Hno5h4JHtD+
 AE6cnoKER1wp5WkGh/1j8=; b=o9pwOT2gLGfzfL3iWMpO8MOBt42F5/36ndV+lr
 sEu0R8vQ7oBHKMI0wuoJUsfwWsFAb4SFPgkeZHi79KfAWvozzOTbHjV0JZCBPv+Q
 Ibihfn8r6FI49/eTbp/KBfcX+n/WTiAj1+3di2Yhfj6p59npIf1WGgE8xvH/yNFE
 ms5Xva6i9VTL8T+XL2DUaIw4UgknhAbRoAKKwRbgVtf5vHdn4eWgQvOTS9r1lzVe
 97dPMC+XLaY2fbhhW61/6o3RzBbmX/FjDOhmKwmKW2loNmncX1CNgfBClkXYzPdj
 u98p+eHkpaBzwyaoBoAIc07G5nb6pJ5xXtfEm5OA81ecRppA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtry0kdrt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:45:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so14794448eec.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 16:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777419944; x=1778024744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5BaNj8Eb+F4Hno5h4JHtD+AE6cnoKER1wp5WkGh/1j8=;
 b=iqQwUHW2++R5jowgkVXqW7Y8gKdsnhmRZyvLW50xzoXyB58IUsNPU6cLDHSRsT+Qvm
 viEjSBCcgdLrgKxWRsLa1dvZbspyo9yExhLw4IdioWQX7+5hWRrRpGvW5iOdhyH/REzc
 nkteUuHhoCOKKGIiaRpbolLoZ3siWGR155lpel/EgYj7zCzVm1jjxVoa3NsMSwssEIsU
 51LU1Vyry03cgl2IJ5VNq9vYN+Xt9zj3xy5/uQja470TMoNi9CQTBsn0c/2gpeTMQoTT
 sZhB/SWqivlQXe/IyTrBWxZyy/1h5mpbqF6d0dbnuB4DvIfiP3MTbOoRhRoxL1VFS22c
 5faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777419944; x=1778024744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BaNj8Eb+F4Hno5h4JHtD+AE6cnoKER1wp5WkGh/1j8=;
 b=UoBgUSdPpCNEjIGZRjDiff2Z8NS/hO6/dk2D1J/qXlq8knAV+ZzrX8q88GE8YtRKWh
 R1hanWBRHr+aNcAmczOnJDmLkBFFzO5mCP+4LEv+dRT3s6BH0OXZ7/azIPYH3nEglxfd
 SK7wI/D2J+RlyLRMDfZ+Yky4BcHRC4iyi+hFKzb5JM7Y06st4UArq8nw5PU71CT38zkH
 daXJWuUjUkWcGJN1N93y0t9sisrN1TWHTMD98/ZuE1V//v76VaRy0K2VLH6Svco7s0Hw
 UyWnJP+WoYDYZzLKLIOwO6UbwwL34/3xIjzAgsNfOnLCDMjy/YZ3/fU+u2cU1iq699dv
 JQ+g==
X-Gm-Message-State: AOJu0YzrU3WVSXLGAoGWfcV0qjDPZe9gHGAFBBvzgpyZa7SveOQ9rsUS
 Afc9viMcarP2bQPUWCIRu9TRq3afDxxLIWQjls2mlYTF6DP++QSsYMoZ1sbdED9+c8uc5SO/+a2
 RaI1Ptw87QRz+8iHZA3od4wB9q/3AvdyyQHNT8AdocLvp2mkOl4bSu1XKzWqtStctzA==
X-Gm-Gg: AeBDieu5PeM5NCve02ZrPA03/e4Ui7XsnJ+wBpvSqtKgBRuGIMrDdsL05u7stfK9u78
 uZY/k9S8L7O/4rKX3ApV9lgkGqdtXpG2gtuUyRXH/q44zE13vQZKTTonZ0r2hRlJrIKOJh6uzZG
 x1kFZ3PbUO6JO2hPaG6P8wX5hCRKlchM/LQOvwmR+CnJWn/Z1K/Elmkw+E600t+ZWwDTj6CE1y3
 e6sxtLkCjF0fDVv4H0ZwHwFcdO4lNNi0DUmwh8BJDtalLQkujXU+1wApbHGgfUge1omF/zj0Cjr
 CPUohg38AEp+HuO1zgTbR73koJfimtGkF/zS/UsGQ+WfLhsjsJ4v/Jb+FER/SzEH0ccUEf6/aog
 Gjg/d7XKayH7a9uW+2jXrltK6ECepSYB6v7G5Nuvt6OX/g0ysUiqyzPb4UV1LlSFGBYf6FBI3a6
 cfUS9H34kgMBgbR7uE
X-Received: by 2002:a05:7300:6c24:b0:2dd:5641:f01 with SMTP id
 5a478bee46e88-2ed198bf5aamr788810eec.28.1777419943590; 
 Tue, 28 Apr 2026 16:45:43 -0700 (PDT)
X-Received: by 2002:a05:7300:6c24:b0:2dd:5641:f01 with SMTP id
 5a478bee46e88-2ed198bf5aamr788792eec.28.1777419943003; 
 Tue, 28 Apr 2026 16:45:43 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8ddaasm345300eec.7.2026.04.28.16.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 16:45:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/6] single-binary: deduplicate target_info()
Date: Tue, 28 Apr 2026 16:45:13 -0700
Message-ID: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KuJ9H2WN c=1 sm=1 tr=0 ts=69f146a9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=vL9XZpDnxUCI8HPV7P4A:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: XvEA5JBgpzlHesP_bcMPuVJO-EoA82En
X-Proofpoint-ORIG-GUID: XvEA5JBgpzlHesP_bcMPuVJO-EoA82En
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDIzNCBTYWx0ZWRfX54oDLLKVLpgY
 39CQNQMz1zgfWen43SSXzAibqRoBr66eY4gYM3zKFy7/4bxPZyqTZdYPhdwcdHpI86EYJyu+ZBB
 pdVoI7o3VKQHD63XBz5BWAsMuq+xkQ0SAmaCmNXwVMAehnID+sehiCSNv5PL+rEpZLfXTNg2/ru
 7RZTxn2VIK5oCd6pVOvRT7ZhdXi+oitdJPFmHfdgXN5KhiDRFzVCdwCpRhArPTMDVnRS4ZDDiPs
 6NQvPcr5Ek38i/3ud9H0qpXyskvKOJRdnteSeLdBBZ0/FUh3bSsC6I0m1T6OmDHGx4dS5GFcagj
 W4wFCkz2LRN/Z+NCHbv6NuBZ7f9eXycr1umh3Q/L6fz4/YQdQo5CBlKhPzPenLpo7VfLdJ4wDvu
 EVWct00Coi3zcwoeQuqZktFAGT74GaBabGqkfpjA2qxB9DfvYcyl9skJiOO46RWlVOYgECZQxo+
 /n+5aEYR/C7DohtV6AQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280234
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

We are getting close to be able to link several targets in a single QEMU system
binary, and the last obstacle on the road is to embed several TargetInfo in the
same binary. The end result of this series is to have a single definition for
target_info symbol.

This series adds TargetInfo types in QOM, and retrieve them dynamically(). At
the moment, we don't deal yet with multiple TargetInfo selection, but install
all that is needed to be able to do it easily.

Because TargetInfo data is set through class_init, it creates an issue at
startup, where we may try to instantiate additional (unrelated) types just to
retrieve the list of "target-info-X" types. Those other types class_init may be
using target information, to add target specific properties for instance.
This issue has been fixed by adding a new object_class_get_list_by_name_prefix
that does not force instantiation of all QOM types, but only those matching a
specific pattern. This way, we first initialize and retrieve target-info types
before others.

An alternative would be to leave all this out of QOM, and use startup
initializer to add them in a single list. However, because all the single-binary
work has been using QOM where possible, it would be really sad to not use it for
this final step. Comments are welcome!

Finally, sticking to our promise not create a special "single-binary
configuration", the goal is to use the *exact* same codepath for normal binaries
also. It means that even for existing system binaries, the goal will be to use
QOM to retrieve current target, even if there is only one.

Pierrick Bouvier (6):
  target-info: extract target_info() definition in target-info-init.h
  target-info: introduce TargetInfo in QOM
  system/vl: initialize QOM first
  qom/object: add object_class_get_list_by_name_prefix
  target-info-qom: detect target from QOM
  target-info: replace target_info() in system-mode

 configs/targets/aarch64-softmmu.c |  6 +--
 configs/targets/arm-softmmu.c     |  6 +--
 include/qemu/target-info-init.h   | 63 +++++++++++++++++++++++++++++++
 include/qemu/target-info-qom.h    | 25 ++++++++++++
 include/qom/object.h              | 13 +++++++
 qom/object.c                      | 40 ++++++++++++++++++++
 system/runstate.c                 |  1 -
 system/vl.c                       |  5 +++
 target-info-qom.c                 | 32 ++++++++++++++++
 target-info-stub.c                |  6 +--
 10 files changed, 184 insertions(+), 13 deletions(-)
 create mode 100644 include/qemu/target-info-init.h
 create mode 100644 include/qemu/target-info-qom.h

-- 
2.43.0


