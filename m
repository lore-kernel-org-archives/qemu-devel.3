Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08011606A330
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fbpZ7NCi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i4CfUw5G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaAN-00051P-Qr; Wed, 21 Oct 2026 13:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJaAK-00050z-HH
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 13:31:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJaAH-0004Iq-5b
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 13:31:52 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU8D73727378
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 17:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=/faf1fcGkZifVtX4KwiyLLetYAcWAj3S+gI
 NU5wxAXs=; b=fbpZ7NCi0uTBcrpKMOUMGBg1HzrmjPBPbHEGsevAxIeXr0Et29c
 oOEugChMQ+eGtOQ5AUTI9uDI2/NrDZYYybIF2VNrvBIugD4v4g/xmRkUJWAkL88z
 hnydUyIM58WSf233riytTkOYNf1mv8rOSgFfbMNkCpZG0AavTvoSHy7kUZYT7wMO
 A/JbOutBFJlpSRsUbHRgPNZLLzPi9CUGiBzP/L5ljsnb2aUxvlB1XsHMEHOUWPVQ
 TOZSgMFLZtRKQNNWm+13uGYgMGO7NjNBBr5c0zxugrJWQWH/RX+vK6pn8Q1KXWAV
 hXRbpnrH4qcNDm3nzPkne1LS3Q4/Uz+SOeg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy7ac9h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 17:31:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f32050e72so317116485a.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792603904; x=1793208704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/faf1fcGkZifVtX4KwiyLLetYAcWAj3S+gINU5wxAXs=;
 b=i4CfUw5G9KGyTBam7RoI5ZBNGUUzkcoFvUvOteOZYWhoavofD+bAeJjt5sYLHHDI7m
 tibJawtmfrTcj7WF1aPNDE7rTobv/xCrlGAijs12d9HcSq0weM+YBVbqpopp58ks1Te8
 E0gl8AQDRPvHLXlNqCWTB3SU0MqTKBDJOvY3vUZSg/4VsKQSoVp0mzjFELL4rH47dUVT
 pKhO0KX+nr54voKoLq11vFlwcz9K1fD2AcMr7nnIucnPjyZ8fm0hmtcI/OzcIFOdHks1
 ST2uHaVlHRY7OvkyYUXC5Hkv+JUOXtOYgwc0zvCU7GARvAlT1iDLagUfpfAnXVfNhaxv
 ymkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792603904; x=1793208704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/faf1fcGkZifVtX4KwiyLLetYAcWAj3S+gINU5wxAXs=;
 b=Ta2OxU7pp4cR/ls5hY7DS2+ECnQkU5mwFcwR+ydWgoHqJRC4mGOKGhiRGW6LD+2iHh
 mvkE1AqmGkG80J4aNktSIJT7YBJxHy5wJPo/4AVbHW86TM29n28LV3IZB1ej8+b/MDaP
 8dZzoGVCPWBo2VAvogyiuU9qNWcGCPF1Cg2GoCXlP6tFwBwYGhed7v5yN2rh3XZJa7u4
 0032I8boZS2F8bLKVXgJuFCdM36m8rYLxKIgwALyItL3qLlvn9qOUletgCt+iQBy74OD
 LFGgdVpTU+ioN3DXVMzMwhxdMjrUJDL7k0MKmOvu6Pi4wie7p8oRfzFf5DN8A+5Zd/ww
 dGVw==
X-Gm-Message-State: AFq9FYJ3NoA7ixBGr9164p29pnyKrAaeYtgnuZhHOzo0foXlq2CEAw++
 vJJLalgDnN/Rwj7o+PuMETp5ZeQb1bUh3FM1+HDtv+uPLFM4Zt+3aqKvczxuT6LwUDvJIWFMf4i
 GWYThoHIYi6UEuMADc7jOrcq1wGNgSES5kkPU+CDhJ8GO70zDz6IZGoJfXM0P/Jb9BQ==
X-Gm-Gg: AYBFou1MuMgw09TU8ZgW6yOdj2PEl5fvBq659H7MgLSMuzWos24XtZG8B2UFNM2QK7H
 A0luGSvnlOKFf/pJYSVxwP8Ve8Y4FisWuf5E6/BPQfKO8kiq1KfzEzdCQpV/xHoVrzY/7wDpaRQ
 Ar9y46o/+26BOiIqIq4YCr5LRqLWYgkkt4O/aeIn2KjH+BPb61ydb8OVnzqXjLYT9ZphLHUxRRn
 40pXI9yb8ldLc4Rqxx3GMihWushrkcbHyrUQUM71Jiv1K7niK0sc1lyhlLvswOAjK7htnsF95E8
 z4aF/RJvsGgUmLu2fhsDOR4hW1/rxSnlPd7N19ij6ogbsvOjtlQCRihuWdHqrQuDPTw2res6f1G
 HM+Ds2beWVcLc1W/4ov6bgAtVtdEjxE1r6k8HZBt11DChMWqw45LFQBwwJb80wtoH1KoRDzS4VQ
 ==
X-Received: by 2002:a05:620a:4586:b0:93e:942f:b8a6 with SMTP id
 af79cd13be357-93f57f7da12mr566696085a.59.1792603904092; 
 Wed, 21 Oct 2026 10:31:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4586:b0:93e:942f:b8a6 with SMTP id
 af79cd13be357-93f57f7da12mr566691285a.59.1792603903383; 
 Wed, 21 Oct 2026 10:31:43 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f56c6e030sm308435985a.1.2026.10.21.10.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:31:42 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 armbru@redhat.com, philmd@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] target/riscv/cpu.c: duct tape fix for QMP + RV profiles
 introspection
Date: Wed, 21 Oct 2026 14:31:38 -0300
Message-ID: <20261021173138.2388231-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QRFXREbrk5hS_44Vywg0k1hchzUuBi9l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2OSBTYWx0ZWRfX2GIgU5+TnG/x
 3N6cazcbPIxUaMxHnXLEAoRedoJS1GPVJa5aVR/EzQ14XrAJVr3R56QXZpkzgPVmJliFUejKqYu
 lYNft2SlhA7bUVw/X6EzjAZrnhPylk5RN55e/boFGpVvIaDbvwMG/U2939lKgt8bDvmL0nX0eTR
 fkyEEEl/KP9HBQBHG02fXhnkwXQkrG4LNy+BOBaHAWDqRWg3wIH/6Q7CwtSeT5n+/Gf4DiP5UWl
 uHFw7hEhr/qDopMdW/JTgbks833a/hx11Rc+w+BmPpoljxXB/u7q9Fv4gJunpYgLriQIu0lYH9r
 Y7qm0tHHC2fldEJdkm77vNcayfQ9etCb7CPS2G+If1P+MzG9zgpisYVSH+CwSSt4Wl0wMreegaZ
 98mnv8ajOwoVT7ms9pbH0RoHtiuG4nuQX5Rv3tiZYhBz4k/cxNn1VJK6jRo/XkJn7AIRlWZkHpw
 NL67SEbwQZBUT6cIgTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2OSBTYWx0ZWRfXzKhre8zLimmk
 gV9XnDNI8P2+zPKLcjScdwbyVMdAQ4ucfClHldMX5ay1kpqjnKvyskttmWo9DpqWCMW7TpAKT26
 SEun1ITtBg/TC58q6sOX2nklUphBB2g=
X-Proofpoint-ORIG-GUID: QRFXREbrk5hS_44Vywg0k1hchzUuBi9l
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad8f701 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=ZiMIAIO6AAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=R_5PQWnzNJfoGkejWzcA:9
 a=PEH46H7Ffwr30OY-TuGO:22 a=KohFQSMcaiS2QNUyYz07:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Maruks reported in [1] a problem with QMP introspection with
qemu-system-riscv64 that happens after querying a profile CPU.  QEMU
crashes hitting an abort during satp_mode logic that, somehow, is being
triggered via profile code.

For every profile CPU that goes through init we're setting an 'enabled'
flag in the static RISCVProfile object.  This sounded like an okay idea
back when profiles were introduced, but now we've realized that QMP will
querying CPUs without exiting the QEMU process while also going multiple
times through cpu_init() and friends.  The result is that we're in a
situation where we have runtime information being stored in static arrays
that persists between CPU definitions being introspected.

A proper fix is to get rid of profile->enabled and turn profiles into
cpu->cfg flags like we do with every other extension.  Unfortunately
we've been using profile->enabled for lots of things and a redesign
would be in order, one which I'm not comfortable doing right now - we're
too close to the QEMU 11.2 code freeze for such a change.

For now let's silver tape a fix in cpu_init() to reset profile->enabled
for all available profiles.  We'll do a proper redesign in the next
release cycle.

[1] https://lore.kernel.org/qemu-devel/87ld7rmdi6.fsf@pond.sub.org/

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08a4d14ea1..46b74302db 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1550,6 +1550,25 @@ static void riscv_cpu_init(Object *obj)
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
+    /*
+     * The way we're handling profiles does not cope well with QMP
+     * instropection.  We have a static array that stores RISCVCPUProfiles
+     * objs that hold runtime state for the lifetime of the QEMU process.
+     * Thus setting profile->enabled once, e.g. when instropecting a
+     * profile CPU, will leave the flag set for subsequent intropections.
+     *
+     * For now, clear all 'enabled' flags to avoid misleading QMP w.r.t
+     * profiles being set.
+     *
+     * FIXME: a better long term solution is to remove profile->enabled
+     * and just use regular cpu->cfg flags, avoiding static variables
+     * storing dynamic state.  This will help us not only with QMP but
+     * also single-binary support.
+     */
+    for (int i = 0; riscv_profiles[i] != NULL; i++) {
+        riscv_profiles[i]->enabled = false;
+    }
+
     if (mcc->def->profile) {
         mcc->def->profile->enabled = true;
     }
-- 
2.43.0


