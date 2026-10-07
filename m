Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82388CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEazA-0007Wl-F2; Wed, 07 Oct 2026 19:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEaz8-0007Vv-Hl
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:23:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEaz6-0001Kt-IK
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:23:42 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LuQMk357266
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 23:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ObMfnOJuDidMXepi55UE5gqU883aBjdNNd5XS0/nhNM=; b=E1xx7kfV/0SXD0/H
 HX48wj7b5kWqeTYSDOqWulJP8e5tbV6As9gjpCUesHK8SJJRDAOsr1IAldVKoFic
 rTZ4bdjFVbv2MZZNi86TL5Tcsivyg83lUxBVyYhc81QDMzIveX0RZFgeSHpEJIfU
 TQ5FV9PB7KLOxTgLv2u3lPTRchwDduR0tFsD85+M9rR/WEqw/H/2a/vmhLh3LM0y
 6sUl0rmlYMZxGVaZ4ORof8qVNaWVyRpcoKCF3sgJwI4WhtTbhWai6A5M+YD0j+L4
 VFSZJtf0eEe6YDkPtF8WpLELvdTkpKSWJZ5Um2c3kIEvATJnrSHkHLHl3pR9YOmt
 f1vmYg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe508k9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 23:23:39 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9195c59ac8cso111870466d6.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 16:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791415418; x=1792020218; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ObMfnOJuDidMXepi55UE5gqU883aBjdNNd5XS0/nhNM=;
 b=K1SFlCqFfhEkGnmr0jemwiZwaXrSLkQo0BZ080khY1hS6dhuQ9gNRKMaDhgWdY++Ve
 roVTxlTV5H/dIBEiiSteEKGNMgQ5FBJ2RfD36UXeoKYu8P6j2cl7mjCrg9x5VZ+HnGEf
 ATYLHGrni/42LxoUCZ1XipecioeDAx7BWaiVHQt5FhhT0otrrpvwlQUhqFSMJhpg+yLE
 BIH41DkL9OD44F8XdwR9aEpo/KNzx4RdLq63U7SCphB6GL0idXFnAVSRvnI6MvzViEbm
 m40z46O/gaIAPKyQF1wVPWaktNm39cu6YH6S/MDRk1quH0M/+OMRM8W89p7hkQ5XLP1v
 LJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791415418; x=1792020218;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ObMfnOJuDidMXepi55UE5gqU883aBjdNNd5XS0/nhNM=;
 b=aAy4OD2zXESAhQzSzA+piOXGs/Z+zi3xAZewMEJSDeUTsFVhHY9VGsmRIePQUWxKvQ
 17o8vkE4hFc+zEtJksFRywqOY6wH6t0PwIRG59UmlnVpcTbHwFyfXLm7yniY+L6G1Qvw
 Y75/t/n3JIRzKM2iNmEOX+l8VRVxv62cvpcHx3cvkhj8boK7xsvnJFva3W5REsDPthWO
 oWs3BhIYrU1UPPoUYd/PNr6tnP2S+xgLY9sobZn0tNwad59j+KluKwoAU5CY5IirU8pO
 sqWyMeJMxx8dvY/U23r1WQoAE/76zaysKwfKDpRyADEJ9guKEU6iHDDV+7H7DjzSwrFX
 V30Q==
X-Gm-Message-State: AFuF++l3FUxBnc8WEz6YBUUA35tKVJkSCY41SeC18X1tnvuP4Xt070i0
 IMhEPptXeOFYnqn+uaje0S56E/uu4cthgDChCbAGmvOAFFcdIKoEIa23FK3T7ZcTMo4m5ykwjSA
 icc3zN/8/qL3LOtjusv4XzPiJLuWHTz/hFRabpXJE3Nna70q4i2OR1ppzZ5NK7fTXnT/I
X-Gm-Gg: AYBFou0f3KYjj9J+JOPeUU8ELBryOk1Xt0o2IeWES227AvvWi/qaGs7WGcFokMo2I7I
 wSjxDG/E3NeQJseD4dVttJdnQ2a1wOxu+4PqxlEag2qJB0/a5YydARgK+TxSHSCakIOoeRqMMmw
 Bjqoi4YVccotdztAv+VYBvBvTYWMP8z71Jqb4zFmG6ziamWOxgWe6VyCmXtXvqwTFKxBOmLmaGt
 CUVTwBdRKdPLDYIg3jpNKtUDd53OGTDYsRcz+G/dVQsNkDLWf/dGCug1H4HolGk7MEinVkWnBaa
 ZueavaOeXX0//v+HW1Z8/bNRI9/wB05FatTdfsJ3AE+nynfcqCDz+Q/jtpcE2ya2qCa1A4qAdrd
 UFnUAn72OncVD+z+fdvJ72ToQV0HAxXzXYdORSfU+
X-Received: by 2002:a05:620a:4387:b0:93c:61ec:d17d with SMTP id
 af79cd13be357-93e9b719462mr706264285a.14.1791415417826; 
 Wed, 07 Oct 2026 16:23:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4387:b0:93c:61ec:d17d with SMTP id
 af79cd13be357-93e9b719462mr706260285a.14.1791415417266; 
 Wed, 07 Oct 2026 16:23:37 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d10272sm7701766f8f.21.2026.10.07.16.23.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 16:23:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-ppc@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 01/10] target/sparc/gdbstub: Replace gdb_get_regl() by
 gdb_get_reg64()
Date: Thu,  8 Oct 2026 01:23:16 +0200
Message-ID: <20261007232326.66240-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007232326.66240-1-philmd@oss.qualcomm.com>
References: <20261007232326.66240-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mYqtJ_Bap1KQ0vU4rEp1f1C4BASxQ5kh
X-Authority-Analysis: v=2.4 cv=E4dYNqdl c=1 sm=1 tr=0 ts=6ac6d47b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=w09PLXUz9niZDqu385oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX0b9ph7ObsQ57
 21yS63LVo+3e7EcYNzpkn91Z2NZm1QAdQea9OwdILW/7jRoT7kC6rlP8/F9bXRsk7mtyVBEYA6y
 oPUs223y7m6zNRGo3OQ+gzSGxeNKQRo=
X-Proofpoint-GUID: mYqtJ_Bap1KQ0vU4rEp1f1C4BASxQ5kh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX+sCQzg5pGuwD
 s2AXURG6GvDJfhes7WFIhMAUVU/D0DiaFTQpVWyR7mc3lR0AxneZVA+nGEKck6HqotLoaqUFvmb
 Yxr4tVLiItnj9UppGl7Gzoy+CuQKkP76S13zofImaIeH16OErAeC1OkHrEKn0LGi3rYi/7LIuwy
 QmNVWUBlmvubeTtNJcHz588A7Z94C3WHRmh8r+OVno2EuKpoQtOKQX20b5JW/PxT/t3DRNO0Om4
 D0lWwc/o1y7ROzHirB+BZ3SYkcoXVMD57z7LvAje1ez/jqp4zThg+nFIn+HFdNcJrAla0976Zn+
 Fy45QHXmphfprHpyaivs/4lmKd8/tGDg7Vt8e743kYKAnMJfG4sjzacxu169X6tvTeFsb+RTcWx
 SdPm7pCIQsGsORnEkUr7ZfPLEZEEWHMkdQ0I0lkyaKXie3iJ3DIONkbca/YjcsUrpvXmJf3jy6u
 KWiTegImAuqaqceYxxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The gdb_get_regl() calls in sparc_cp0_gdb_read_register()
are guarded within:

  #if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
  /* 32-bit */
  #else
  /* 64-bit */
  #endif

Since the #else branch is only compiled for 64-bit targets
where gdb_get_regl() forwards to gdb_get_reg64(), we can
call the latter directly, dropping the use of the deprecated
helper. Assert the invariant at build time to be safe.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/sparc/gdbstub.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 2874ce1b350..d3ccf533839 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -106,22 +106,23 @@ static int sparc_cp0_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         return gdb_get_rega(mem_buf, 0); /* csr */
     }
 #else
+    QEMU_BUILD_BUG_ON(TARGET_LONG_BITS != 64);
     switch (n) {
     case 0:
-        return gdb_get_regl(mem_buf, env->pc);
+        return gdb_get_reg64(mem_buf, env->pc);
     case 1:
-        return gdb_get_regl(mem_buf, env->npc);
+        return gdb_get_reg64(mem_buf, env->npc);
     case 2:
-        return gdb_get_regl(mem_buf, (cpu_get_ccr(env) << 32) |
+        return gdb_get_reg64(mem_buf, (cpu_get_ccr(env) << 32) |
                                      ((env->asi & 0xff) << 24) |
                                      ((env->pstate & 0xfff) << 8) |
                                      cpu_get_cwp64(env));
     case 3:
-        return gdb_get_regl(mem_buf, cpu_get_fsr(env));
+        return gdb_get_reg64(mem_buf, cpu_get_fsr(env));
     case 4:
-        return gdb_get_regl(mem_buf, env->fprs);
+        return gdb_get_reg64(mem_buf, env->fprs);
     case 5:
-        return gdb_get_regl(mem_buf, env->y);
+        return gdb_get_reg64(mem_buf, env->y);
     }
 #endif
     return 0;
-- 
2.55.0


