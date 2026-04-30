Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB15FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIIsq-0005p1-K2; Thu, 30 Apr 2026 00:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIIsp-0005nY-Cx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:20:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIIsn-0001db-HI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:20:15 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbKJq2855822
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ITV3XFZr1YqC7EA6I0pAap
 LgFGypIr5+E8bzyniOPpg=; b=gzDCtYStSjLt2l1bN2LVfQ6LBdJGxSX2HtWsYX
 ssqmmoaW3ARN6EC1xgBZEAb6IXpizI+4aaNMyQLD33PVZVwJVUAFhKoDJ4LR4Q9m
 GMkcJgFqWCtN9RDGSu7adv0EUrSlKraVjkaMSyh9JKO8YXcS2JwVdnejBQ+gZWXj
 XsSR1oT5CABxIImr2jP8fBVnWP1SPTXyN5HnphFp+NfQDxUFvNL+vgt7cp+R0Iif
 GSz7qwS5FVzvLnUTeeWA5XeR7Enx6anx2KIxIAdI1WVr5rVFCPWm7XLD/JPYV44T
 u9PdDfodexnMrJqX7XzIKWYiCPL3sPQi253JwGum1A3bAmnw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dukrp2kqh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:33 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c8de02a4dso2343006c88.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 20:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777521393; x=1778126193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ITV3XFZr1YqC7EA6I0pAapLgFGypIr5+E8bzyniOPpg=;
 b=hsZshbVh/k1ClelDr+6DayUZVvq5Jp9M1YayPcz86Vp096vZMcyMueYByhUE6pAt7i
 lo4V7cj8gqOSfMOr3vQLxWkJPYodkbOre9RPab6hNyQGYli9GpTGpfk5/Phf86aUcWiY
 yw9+qnHYIuhTys2LBvguaQCONnigVgSsMvm4izEpzgP5AO2wlClc4qaYB4/+C1WJ+5Jg
 8uvY2JOByaGYPBO8iPKBq2uRe1dNejEMkacY3MzKc0/xorYGcc4oBcpgQWXeIVPWDIDz
 XX2n7mWuTUQ5RFzG4kaqa0hZQViejBU3IrPTPJDesg5pzrysXwpTkJB5dY7MoYT0ZBrW
 LC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777521393; x=1778126193;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITV3XFZr1YqC7EA6I0pAapLgFGypIr5+E8bzyniOPpg=;
 b=F8Ma0Gvv5nRQ+/XF3WDG8AJztjicxwhIwiNjnoYT6CF7uMhaEXJy7z+nnQS1IScO5a
 mWZe9nNg6coRJMUleSVRJoXCYmsAYx2Zejc/DIVST1JCXi2XqWPWlD/GXKpCcOcUAydB
 RNfI2JLUSuyY0d13dhtJOpv+yV2IUev143qBmbgJ28zu0YidXmwPprX/5YDu4QlpTcn9
 xjO8Wga6UmjIu22v2H9n0V2QPNVm8jc1SjhoYAlh6NVGEg1CMTypuv3HsSFd0so0Mji6
 PWTHZM89Rw0cb0cf3tIuEI2pYxKkGeV3GH4JCh7xiWPwHC4kEuXq2tRpObOfehDNY0xd
 QxEA==
X-Gm-Message-State: AOJu0YxoiLIkXnc9JbheOaWp2dfsdaOKbEVO7PLnLdVWKFQYF2Jenuir
 sI2J12SVzHb+Y/6m0LymGthwsXKxwTMPPbH5xR3j98ZRx/RPRzDyIcGndyx/CvEXCuxGO7VPbUy
 deACZEpw4IWHibattkurBEZSqfTJkMryplSuWUW5MKU2NuUlJKzfXI0UTtG1xYGbvUMsa
X-Gm-Gg: AeBDiesnqWJTMgmFuaaKoIWkxhwWrvmbWimCiETTp1K7UgHxpkeRQEzH5/lOTHt8irG
 SlQJzMchEP+9ZEdy+9O8lWPBtPV7r3+x4qRv4vWgJzKhwJ0zNj4mvG/VnM4EhLofKsvqKWNy/M7
 DZUzz2uAz6mXwGEWqXYxaGkjEUw/0O5p0CX9KOtDlKdAtl4xxB7Oof6ivXLMZO/b/qp7DGZRAef
 BA4Dy3El0h6wACL310Xksdai74TptWQ0oh7etlzPf8KP7wVbhQGdeYS7KlwtU6Pzf3OCAyQzkio
 dXAMpexCt6I9ET64DpnyOvU7XM5bmYbf04t/YfkFHeMOW3BdCyIJY0N1kAqBZevanG/UL9mOyP9
 CY5IF9TcpcfzlVnRaZGb/hWslQ9YsMF88cFcTemT4gb5eCitXylHZh5Jk/Fc7bhbtgYgodM9l5U
 oVaUQPtfBogvSb+2Qq
X-Received: by 2002:a05:7022:ea2a:b0:12d:de3e:cc00 with SMTP id
 a92af1059eb24-12dead2491cmr637273c88.39.1777521392815; 
 Wed, 29 Apr 2026 20:56:32 -0700 (PDT)
X-Received: by 2002:a05:7022:ea2a:b0:12d:de3e:cc00 with SMTP id
 a92af1059eb24-12dead2491cmr637258c88.39.1777521392274; 
 Wed, 29 Apr 2026 20:56:32 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de32173acsm7159443c88.5.2026.04.29.20.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 20:56:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/7] single-binary: deduplicate target_info()
Date: Wed, 29 Apr 2026 20:56:19 -0700
Message-ID: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 20Z9BPD2ldmE2XnYPBmpNZIlSa2OvZi5
X-Proofpoint-GUID: 20Z9BPD2ldmE2XnYPBmpNZIlSa2OvZi5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzNiBTYWx0ZWRfX7WgR+by9FuPj
 nhLi733XC0zYyd/LJaf+JoLbtClYIP7uGhfn54IaEtcz631OduiDlGsfVIapdAddGGNfGv31HHy
 lOWJB9Hqm2d5zNawZejHlItP8kE6rywyW9wfYNjABEcluI2Y0j2nJ0TivtzQ6PvmXWCpi9CgAXR
 rugaIHwPQ/cGOYSibAdzXi6WhUiMJnA7ME8+vdopGh7kCiDV+0Y+EziES6whuhPsNd7NV7OWG4u
 KBA/NfWIQ7WkuNX1iKxHCCN1I+4zZ3+NJdWo/uWN2cX10jy5/WqbPMsHwyZJrSeos75zkF8O5Fg
 8I0+5THmFicw/069B5C3i/KMuTvq1T+gIfiKAAlKyabMFLgHdtP1HbTIavtYfgD4LdCGHrRq64P
 YhoE7jUwHgSJnKbQKDzqktlha8divvEzZ5laexvK2m521hjNeeh41Jl76GrK5zmzkkNHjNolQbA
 kSpWfhJKs/fFQL9izwQ==
X-Authority-Analysis: v=2.4 cv=WoQb99fv c=1 sm=1 tr=0 ts=69f2d2f2 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=vL9XZpDnxUCI8HPV7P4A:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300036
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

v2
--

- fix header guards
- introduce new module init step (MODULE_INIT_TARGET_INFO)
- as a consequence of item above, we need to register TYPE_OBJECT before startup
- fix xtensa core type registration using type_init instead of static ctor

Pierrick Bouvier (7):
  target-info: extract target_info() definition in target-info-init.h
  target-info: introduce TargetInfo in QOM
  qom/object: register OBJECT and INTERFACE QOM types before main
  target/xtensa/core: register types using type_init
  system/vl: register target info types first in qom
  target-info-qom: detect target from QOM
  target-info: replace target_info() in system-mode

 configs/targets/aarch64-softmmu.c |  6 +--
 configs/targets/arm-softmmu.c     |  6 +--
 include/qemu/module.h             |  1 +
 include/qemu/target-info-init.h   | 73 +++++++++++++++++++++++++++++++
 include/qemu/target-info-qom.h    | 30 +++++++++++++
 qom/object.c                      |  4 +-
 system/vl.c                       |  5 +++
 target-info-qom.c                 | 35 +++++++++++++++
 target-info-stub.c                |  6 +--
 target/xtensa/overlay_tool.h      |  5 ++-
 10 files changed, 154 insertions(+), 17 deletions(-)
 create mode 100644 include/qemu/target-info-init.h
 create mode 100644 include/qemu/target-info-qom.h

-- 
2.43.0


