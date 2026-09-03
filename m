Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A72C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24tQ-0001cW-N3; Thu, 03 Sep 2026 06:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24tF-0001O7-Ut
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24tE-0006mI-DL
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:53 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHKOl055433
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WCN81CZzwMk7AOciJnUEDqrfGM35rVyGbmBye/Wi1XM=; b=I2kFSdE75aKuBoY/
 jxzkWcRkJPndesAjwEr1XQFu69/9Ir3FDcjkQMrjhzqTgrt/9vv0TmeE9T6+IGH3
 NU8tzcyIXlT5cQHSm9haUP06BJa7qKn3QqQ7CfqMQxtGyMybvBnWe5hbxA3RKllg
 WUd6gQK1ox0RwP5a5O0Kp5t6cQ4SEyENn2zQLImUKjPe0SHizt2ke34P1z+STqkp
 PYf+49vjWXlHdrWkmn+ABbj8QzwV5iKXoiLEcIuLfee1LlaCdMJrHO8axmiHWev7
 IfZK4fGUIayD7kbrFnPxwDS4lpTWGOg/y5YnLKUWYEVrAaeZkNmtBVJ3K2r+fSLe
 q2xYEg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdvgrg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:41:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so153862285a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432110; x=1789036910; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WCN81CZzwMk7AOciJnUEDqrfGM35rVyGbmBye/Wi1XM=;
 b=VtSPoxKjZqYLt2EtO65wOIeQhUamhxbCmPqeSN9pSJxlwXJtwfX+Zyn1KpCyCDYBSN
 +A8H82TZwfec/u5lExA2n8CWQwjkSRn6CGJFmHhGrvcSeEi24SOXZyEAFy8E7FrTWYG3
 oSU1Jr4C2GG6AoXB4kL5DM7kTp1H6m1mYe5pPMMvVsFXjPVOdjD4LwwW+JxmK4S5fWiQ
 9L/fQQagiGru6ebYl7itkgGHc2yQxnAh1SlHCU/dpz0ucCh0SgiDxkLL/NyhHQLAq1td
 TFsjmgfu6QmadGbz2bgG63m2H5/PaI6N/Tljj3Dv15nfYoepaXIbTmASJ0yOQmdjf0vf
 vXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432110; x=1789036910;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WCN81CZzwMk7AOciJnUEDqrfGM35rVyGbmBye/Wi1XM=;
 b=Bmdi0BSuUDm3bxEQpWCfWsP30US/SqlZD4nDUc1f65FCS+wI9tkfxX9dxboN0a5ICY
 +QkbNDG+Z21Dm+WsjthF06JgZh8raVU9Wwr7S+Mll4/FMQARwfgSQT4h56MMYtKxFKOk
 Bl6ELU2G3+IyO2TvQYZb+2JzYr9JyvX5drNuz3lYa+lzTB8v92/DswS53+H4UM7kIEIH
 qMb+gf0HV82ZKum1IKUSQ2zlACvR52NU8E0o29TGXbGHOOr/uceGcioRFTOvqYHwuppq
 0omud3Gp1W8M2leUK6KzbZCxEt7r1jj+8HMdbCexJh+js5eFW9H/gb0yRT/whc+/c+Ai
 pP+A==
X-Gm-Message-State: AFuF++nd+3v6tr76Rzsd1dd/fKgGGKABOhjjyoehSsD+VD6YIib6AkT8
 pj2vgtV1sxlCJk0HSP3tw4IjPslfFOe1zjjkPJBvdY0BS9K7cv/ALJSnuBE8q5W4wWSA8b8QMMe
 OtEgyuUqN8P+mKPXiTWCGtCLq9T5lDRngdVPt5nEiLuatL+sSmWGgu0N1SecSuQ7RMg==
X-Gm-Gg: AYBFou3MrP+Ui3gdWJrBmKJOnmMdcgIxQ+f4GNUsMgFsfu626GZ8mID+5qIZEVbQ00G
 XLtfUYN/gmrVbrZqHoQ8ZE4tS9Y+bo5LophT6zBUnzF8epL4jVECkLVtJL9eaOOdzoFf+uMUX+e
 VP79CZnqZojsAuiDmDM4Usd6EeMNOLoiUzU9TTyea39uX0mPLVnf9VCwwNOh0FmlmMH9nhNdLHi
 mLEBTDdUyKTr1q4QEFHsv3YxvDswnAh4nNoGtWMDrW0y5hfsdoTUB/79DYqCTc1TXE/bF6UfaKw
 awnGXdNy8LNimzndt+1+gItc20sEsfPrzYfJ7nmGTOWgiiVuXhw9pgePO2LYVc7UCwVWeAJR5Fs
 Ne/tuOS+wJCM7SynsB+C/S2bDipDxTV9tvrbtp6rc
X-Received: by 2002:a05:620a:1a20:b0:939:72cb:baee with SMTP id
 af79cd13be357-93972cbbc65mr212878285a.37.1788432109989; 
 Thu, 03 Sep 2026 03:41:49 -0700 (PDT)
X-Received: by 2002:a05:620a:1a20:b0:939:72cb:baee with SMTP id
 af79cd13be357-93972cbbc65mr212874385a.37.1788432109483; 
 Thu, 03 Sep 2026 03:41:49 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e80798sm12284003f8f.13.2026.09.03.03.41.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:41:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/51] accel/tcg: Restrict EXCP_HALTED handling to system
 emulation
Date: Thu,  3 Sep 2026 12:39:02 +0200
Message-ID: <20260903103936.62355-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a994eee cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=-hA0-U2ujmm1-e6JBJcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: emcWzRgbHP80xdAy5F-lWLwfvvvroyEY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX16CEWTUrVQ9K
 pmB99v/uGAMb5s0KC8zCFaX8Fw00+1nR2P5kxCvlGXJb12oiCZEERySe15qGqdb2pAL2uNrqLA6
 c6Io0aQApHcwenfexk8qbmQ5ajb5Ig1OvXBmPqta4rAFB9ezlq1loV1KSBNtDmMoRuUnmo8o40N
 /DXinFylEzcHev9bKfy52aDpeA5PnFRLuiQ9zYpQfwZ38QLnrfVMfBsZBNCXN95PyU6E5E0irtc
 3zurH8NS6iKwSgW8H2WYPfNKJR/aManF7gusxek2OV5IUZi0UKk0HY0fDO7vX0wFrcjs3DnuWEa
 LjxxquE+PE+cIX9vjuZkmTOscaqBVqREmsq/sgZWIMKy8MN+9dWSZu9sWqZgP3HLjNZUKlVPLmw
 deRyn4puwgVdan21aAHQwyULU3WL+lJtDvJlAToha5p+nq8TY6sEARr8rNFg8+OV6uXZ6r58H5R
 ByXH+638YXw3z8Xthmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX3HWL6nLbumW9
 gk1asXdWfkp753aekgjkRz2JkacS8mHNGtGHZHDaat8pdqdSSUiuhlZFRMZuGuRcgR9hVp0kEBT
 UdOVeSNWVAQDfkw9kcIKfdFOnV0uM2U=
X-Proofpoint-ORIG-GUID: emcWzRgbHP80xdAy5F-lWLwfvvvroyEY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

EXCP_HALTED is defined and documented in "exec/cpu-common.h" as:

 #define EXCP_HALTED 0x10003 /* cpu is halted (waiting for external event) */

Since vCPUs can not be halted in user-mode emulation, guard the
whole block within !CONFIG_USER_ONLY section. No logic changes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260819145649.23439-3-philmd@oss.qualcomm.com>
---
 accel/tcg/cpu-exec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 53d90c400d5..69207301d1d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -653,9 +653,9 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
     qemu_spin_unlock(&tb_next->jmp_lock);
 }
 
+#ifndef CONFIG_USER_ONLY
 static inline bool cpu_handle_halt(CPUState *cpu)
 {
-#ifndef CONFIG_USER_ONLY
     if (cpu->halted) {
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
         bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
@@ -666,10 +666,10 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 
         cpu->halted = 0;
     }
-#endif /* !CONFIG_USER_ONLY */
 
     return false;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static inline void cpu_handle_debug_exception(CPUState *cpu)
 {
@@ -1027,9 +1027,11 @@ int cpu_exec(CPUState *cpu)
     /* replay_interrupt may need current_cpu */
     current_cpu = cpu;
 
+#ifndef CONFIG_USER_ONLY
     if (cpu_handle_halt(cpu)) {
         return EXCP_HALTED;
     }
+#endif
 
     RCU_READ_LOCK_GUARD();
     cpu_exec_enter(cpu);
-- 
2.53.0


