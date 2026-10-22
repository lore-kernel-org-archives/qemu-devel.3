Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF2606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LOpPGdrm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W/Gk5VHH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nO-0001lJ-L5; Thu, 22 Oct 2026 17:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nN-0001kV-BO
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nL-0000GP-K5
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:56 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtVLC387736
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e89DOf+hia05bBat6/q1SmjgvPtQMkrFV02e53Pnd4g=; b=LOpPGdrmHSc+eteP
 Km2EluwGff5qI4lhTGeVXAWUSP4aDbVYv7ms+4QUoXfQ+uTLediSZ2Bk79OoQemI
 dkgRou0dFK3hkg0ew0R/aMhi0xUdirOYcklCE/cA4AcrlNyCQepSNRc0N87UQhmo
 lsYjtqQQlxrK/CIhDXutJVm7fOig44ZqgbIBe4XWjbTJ4kI8I7580IHY68XQDbUY
 5ANYI5zsJAcNS2+9ywGPfJDT9ZtRBwyTPZEgpyopodTwES4VeYUl1vG6QsGCkoka
 OnnbuybMgw6/ncMNgsI5ANTJ7qz9xp4y5w16EDKtIXiauwlrWPR8wz5d1vg0WGgq
 pX950Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq4rce-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab2395f104so249208a91.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706274; x=1793311074; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e89DOf+hia05bBat6/q1SmjgvPtQMkrFV02e53Pnd4g=;
 b=W/Gk5VHHFkujpwwb7gX/LVW2Z3dDP233b/beIBPxGRX21rKHRcxnNZZ53Onbu3RyyG
 pbhWGwhQ3Yt7+uKlRhb73L+YWCrG/H+5PzJxHkm/E9uhWUPBLN4Fm0e0Lbmcec5NpvJr
 5ZwXySfRJwSU4D+Jun4/PLWv+VocvwVHgqT6skiLB09xTn+RCfZ5ma0iGurj6TKL8Gr7
 8mpPXf4VIj0IR6ekf8ZXoMMKn59oHZMXd0Q1TX5GYCrcUMAjtRRd0FXOCFU8AjYE8ptC
 EFidhyVvuF1E7TrwMNoqepphe8jEsk7JxZn6B0QYZayrF5yRaDeb/C2406w4nauklKxY
 913g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706274; x=1793311074;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e89DOf+hia05bBat6/q1SmjgvPtQMkrFV02e53Pnd4g=;
 b=ZIhDsqXhMQVT2HC+MqIz75JVyRj2IFQn9EfJAzkMy0cmLIXTrKRHPApJvehR/uwYkF
 KeUXEZgiOCu/jCrSpYErzfNc+w4SWQAjDCuLWMXPKN/5F0y13cbZlzwG4KRJw9+doMa1
 9Vupp4ZncyMEu3B65QFH6LnIunlp7oVqtk61ojuST0sWvIPw1G5DMm+ahEJfSBU3YiBu
 EM6uhdPAdIPPxbSJ9p0PuMmJTUxokPVfcf5AI5GWKVzY0cCaccFnfF52NAnWFsHtRRfs
 2vawjEQVaj7czoJm1JEJomI95ezg6XtUoYq0PiMip82CrZ4tq9tf8PtMDEnKRvmLc37i
 TfiA==
X-Gm-Message-State: AFq9FYJVYIBCPCEpENXLn4y1d/DSxSX52vEMDp2l1XFUZq7oSCKjFLW0
 Okm7xLdlUhKIWN+l10JgN5elM9tEUejKeGrYmWnC7Zl+xu7nMXycW3ucQ7/1/MU8H3trYSbH/c8
 keo9mMOb0epIUpR+/kFLR+WelK6Cu9SlAYgrDnSrXMlpSbCtWpUVIlUVzuVIeX46F+Q==
X-Gm-Gg: AYBFou1W+zZMUpVix5P5hsgeYh3hz6RW4LOR7TFuBYfHW6/KLjVrokJAR9Ua/iONaU5
 HiuZ4//4gpt/FXV1+Tj67vgQZrsDIrr+MVr3GHNBHjBvNdX3J2+ujeGKcvLckAc/zGzUQTDpp+Q
 KPC9e04uSWPlITjL0ChON+P4Kal0fi/nifbk57LuwYPy3X8b0nB1/DyCD0L5MRQ8/vRzm3JiDv7
 LTGaBjW0jTi1E/A4UMIYvmL/xvxC9qK4cqSoFmP4gNdSXLwldyK67rU1q08VzS79qCmHmyt4xsE
 7EHFZbOMDJ1S/dV5AimKRL5iE1hxwIHjwkmSkoTC2GxF4SfBnpWzvNXU9jH6ZGV/J6tiQzf4h9l
 685tCMcYi1F04e3SWFA61yymq+C0QPer+2lpKLtKkV9l2YgHwMhMGNr3NfJ5J6o0=
X-Received: by 2002:a17:90b:52:b0:3a8:5fd6:cb6 with SMTP id
 98e67ed59e1d1-3adcd7fd65dmr213919a91.0.1792706273292; 
 Thu, 22 Oct 2026 14:57:53 -0700 (PDT)
X-Received: by 2002:a17:90b:52:b0:3a8:5fd6:cb6 with SMTP id
 98e67ed59e1d1-3adcd7fd65dmr213911a91.0.1792706272838; 
 Thu, 22 Oct 2026 14:57:52 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:57:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 05/27] hw/core/sysemu-cpu-ops: add get_dump_info
Date: Thu, 22 Oct 2026 14:57:24 -0700
Message-ID: <20261022215747.2479440-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fIW58ayGyxM1dRwRvmPTYcqtRV_T6tKL
X-Proofpoint-ORIG-GUID: fIW58ayGyxM1dRwRvmPTYcqtRV_T6tKL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX918mDvk5JSlI
 qfWzvgC4zJSJRy9pd42Ce8qeKMpVInic+Dt8sFMXwJb/8RdsczDREMQjqEip+FTwZlQoRSpf+Ot
 1g4ga1YTHMUvsCsaT8IcrQ8Yq8KSSw8=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada86e2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=7Qd54_oI6N-egMT3aNcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXy8i0kNm9WrxZ
 icjfwGpBhoyUCYf8EYUiWkvTdzhdq1T++nkYM+T0nflHYI9J5NK3zfiU/qUWjDikUAW7cJDORKq
 7Zcs5hBCH7rRf/B+U8+J1b/MozG+Iam1/XuSNmw1uRetxynLiCeHJ5wR/0piBPUd2zraYgrCr02
 Sy/fbSQjejrLCek4AyJ6wP6IGFf4bYzG0BTG4N/VEMcxIPCawowx/QDczIrn2hWjqDkaucm3XzQ
 ckBavtubHM329E8r4Q8ZiF2Biq9tjIwdCL215Fw03NFxLHwjI3gjBJycCrLnOCJ+d+I9MqfIaGN
 7T0+YQOry+YbUBJ38DydbY2KrRljIWvyflEPMgl5FTEXMER1ScqrKA5Y+fwIDXBxpoHFKMqYuJ4
 0vvoEeSG9nx3EW58yz3Rc4CHiRrQdmwbwZOnrNy6yKtVxXgqLCF5PQeUWaha6o9cCIIyBDQE9uP
 B6BhdFvPZKcf7TUYA7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This allows a specific cpu to declare its implementation of
get_dump_info, needed by dump.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-6-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/sysemu-cpu-ops.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index d125540262d..1d4a04ff361 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -94,6 +94,11 @@ typedef struct SysemuCPUOps {
      */
     int (*write_elf64_qemunote)(WriteCoreDumpFunction f, CPUState *cpu,
                                 DumpState *s);
+    /**
+     * @get_dump_info: fills @info with the endianness, class and architecture.
+     */
+    void (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
+                          const GuestPhysBlockList *guest_phys_blocks);
     /**
      * @internal_is_big_endian: Callback to return %true if a CPU which supports
      * runtime configurable endianness is currently big-endian.
-- 
2.47.3


