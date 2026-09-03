Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CF1C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24wj-0003he-OP; Thu, 03 Sep 2026 06:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24wh-0003Wz-Sf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:45:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24wg-0007Pl-3m
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:45:27 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHDQa212469
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Dj3OXid++Iqy/cyluFGTJnkN7KIeTKozIJoG2tmGEKk=; b=ZP0ZMZ+aVhKP0aG5
 Fk/iSNO1ut+UW/w294cOQLvJLdOEiCtxs1Fm9/8CH0VsjCuRVuvuEDJg65rWzHvZ
 fAHay99uU5Il0JYoZKKqdztnxwSXztJrZDFJ2QttvSQgnnByfNc99Cp65GsezS2x
 0pyXlZZl81yaDUvEmVOMLdifPs3VA5F7v/x0y3OZD3D1FyXcJ1xQ1P+2VCI6aomd
 0m2EHIlVv8G4XGjxoJDK4PJbB/yoYQUQq+MPgnvb+yk1ts3Q73KFp6DWFGAOVFSb
 9ecoVtYIE6J4/c/oZ6laTmFDGkGezXV0gAA1mwFOFSNoeIX8spUxMhEiLt2Wf7zP
 iApGyQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1pyhg64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:45:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e52306621so322965185a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432323; x=1789037123; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dj3OXid++Iqy/cyluFGTJnkN7KIeTKozIJoG2tmGEKk=;
 b=aBp0sxwNB+TNCh8VAaRNlcNDIpdSVZiV+I87kVdvfAk6FqAwk538LCfAxDWhcxVQdu
 1wWWfGoaKAOuWrGPeDvWBcqXvxC4og4yIM0pQSZ9oj/VWH0MNKmCy57FCJK0+r/Eh8wZ
 vFuTnK9gi7RkPlZ0PHLTH51xQ41/vXUq0dDYlzdsLrgsCTedOsM95QLHCGPn/a1/e04B
 zzHWELOERYDENEzPg9D/qBMRXa3qtf+PME9ahQvlDTwK/IQsA/z8Gf1juEHSeq9EtNCh
 dK9DXmGbDT1z9bJA/LvdQC/YgbsMorFA+9RL+GZXf33VA69vPevw28XqzJPCAvx5GMtg
 Og2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432323; x=1789037123;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dj3OXid++Iqy/cyluFGTJnkN7KIeTKozIJoG2tmGEKk=;
 b=TwIVv+FB6VacKxYZgVQfPDQYNYnp9GwalvHFYyRpatEHhuqvBCcMSdJvX0TcBySie5
 T5ZHtM6b/eX8sG9Monb6SPy7bteJvEqyDDN52KiE/D7Slw6+kF8ed/pnhwDE9WxDeSZH
 AsuCj2jTF3waDYUTuPvuwi0QIzD+HkwHOEzHj+CO/0KtNmrH9Zd3DeGs2vyU7GFVWPMk
 3xlG5Q831inc+yUMx81UH47UYfB8zIKR5ZYW4W4owg92z2HiueSY8p1Cae230qwqPQwu
 yN2Z/bCEoo/YaH0DLsUI90A1OQ6bl60E57GP40h6ilEEPKkiikFIHDM3FwmSv8vYCPzX
 Hdjg==
X-Gm-Message-State: AFuF++npI97j0QL/DayAfAWJPHxIhiHHPxm75ufY5WkFD3sp8WH6tyCn
 7Cq6ld7kTSJ4lZSWPZ2QIaU+MZm07WYDwSzZRYkmvvAPh4r80MBs8KVrN5i+j1hD2cqn/SEV+MO
 D4+vrnekj2MwDnwoBzQ0khbFPWx3J7lWU6ff13AOHJWNESKO5cNXMWvwDjPexgsF5MA==
X-Gm-Gg: AYBFou3LrR766P2bhfBKNcCqX7RPY2whVtBlNbD7jf4gf7QvSvEuRO3KhHCvxw/tmi1
 eMKp27TiWRUkP2cPwnzT4ogm70VlRR+UXLoVnELZ+YvB6u1e6lj3v6SXxmgWA5zqQXRdEjFFLnU
 bjhIHcHoir5QYRJkkp8E+e29uabJsUWZ0CavOGkz4Wvp1t68IzkCAqu6cZivoXRzro5lvfmTtcr
 Xj9xyZWhPiFYMITddxlxQqpVetnVaGKVXXy5sRlabSwDN8H4uCV/PWVtpZTFWlDORaN5kPbv5pZ
 Enx2AiDeYmEWdauADlYgXYvOX4DtSP9I9H0nNYjlHdvN8JM17FRbtcJ8XYDvrLyi3ZgmHj38ucN
 ihSZafK6y+jo2ZPkk1nspC6TB/h/llSdLppnFbyCo
X-Received: by 2002:a05:620a:8084:b0:939:191c:cac7 with SMTP id
 af79cd13be357-93972cbb0c3mr304146185a.13.1788432323536; 
 Thu, 03 Sep 2026 03:45:23 -0700 (PDT)
X-Received: by 2002:a05:620a:8084:b0:939:191c:cac7 with SMTP id
 af79cd13be357-93972cbb0c3mr304143485a.13.1788432323108; 
 Thu, 03 Sep 2026 03:45:23 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eeabbfsm12286085f8f.31.2026.09.03.03.45.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:45:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 46/51] hw/riscv: remove DEFINE_MACHINE_{RISCV32,RISCV64}
Date: Thu,  3 Sep 2026 12:39:30 +0200
Message-ID: <20260903103936.62355-47-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX7LoRAeRMFOjl
 nQAPA0+oPyM1r1KFNiOs6ryMW4bN8gu1bQuEdTJhcLQIP48hW9U2B6hjVP7qYqOCDpi369fnMpv
 h3FvcGwQSm2CZrNUEdlh2UV9tLLaaszpwnLGlFf7XaOxGJ03EVh+A+ju4q0Vq4UwM4M/QkjRrJW
 GEODt+IrWGre/+V+sPWGJA8Gf3AaF9Dc5gWhmJd6yR+3PRn95IUONhqdQh1/lfLfiVTHcFkBmSX
 JIuCJwV3y+tHZNAGfJ2dx2GgCPcmnHiURmSahye5akyVPbuWBuiwQAsNoa1ptMAGUyGZOfv5wSb
 h2oIG2DfiK6tCTQeGcY4kjg4mNpy3CjlIha0nWKo5dxDtOE0eNQ1LEL6osZbHEksOBh/k+F2Elt
 Df27CDYCCkFdGSQgc0lMay1k1R5isNAQ4hX5yhOPClCzKYfKL8hJnbStHmKi+UOsld/WKehlm5z
 RkJOiPKdWvpJeIFf8Tw==
X-Proofpoint-ORIG-GUID: ztBI3xiaZPn6WioGu0GSGjy3eKyRQbni
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXxEMbjfLwDw1/
 vDMAgjXO4We8m1o1AK7nHLNYcPmyAgyfdBc1T80rsdG0PtWcxSfnRi1YXZb8vcK5DBLiJH510h3
 qur+TP0bJ3DLZxCw7dRwS6w6TgbpDaM=
X-Proofpoint-GUID: ztBI3xiaZPn6WioGu0GSGjy3eKyRQbni
X-Authority-Analysis: v=2.4 cv=DMO/JSNb c=1 sm=1 tr=0 ts=6a994fc4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=r4SdTxa7mPobecY91-8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260901202043.26532-14-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/riscv/machines-qom.h | 17 -----------------
 hw/riscv/boston-aia.c           |  2 +-
 hw/riscv/microblaze-v-generic.c |  2 +-
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
index e5f45b32e69..79d212eeb7d 100644
--- a/include/hw/riscv/machines-qom.h
+++ b/include/hw/riscv/machines-qom.h
@@ -11,21 +11,4 @@
 
 #include "hw/core/boards.h"
 
-/*
- * Helper macros for defining machines available in qemu-system-riscv32,
- * qemu-system-riscv64, or both.
- */
-
-#define DEFINE_MACHINE_RISCV32(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            NULL)
-
-#define DEFINE_MACHINE_RISCV64(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            NULL)
-
-#define DEFINE_MACHINE_RISCV32_64(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            NULL)
-
 #endif
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 965d0f5699e..30eff10bc5f 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -474,4 +474,4 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->default_cpu_type = TYPE_RISCV_CPU_MIPS_P8700;
 }
 
-DEFINE_MACHINE_RISCV64("boston-aia", boston_mach_class_init)
+DEFINE_MACHINE("boston-aia", boston_mach_class_init)
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index d33ac39a68c..503e8e08992 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -187,4 +187,4 @@ static void mb_v_generic_machine_init(MachineClass *mc)
     mc->default_cpus = 1;
 }
 
-DEFINE_MACHINE_RISCV32_64("amd-microblaze-v-generic", mb_v_generic_machine_init)
+DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init)
-- 
2.53.0


