Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1EFC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24u0-0003oP-FR; Thu, 03 Sep 2026 06:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24ty-0003lG-V8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24tx-0006sQ-8F
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHGQF3782424
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RO2EfpG4mTE1iadWqUmeTkOisJSC3FV4nL89VzJtdF8=; b=nEZtjmnqETDEs4KW
 oC34tSIoifp9zcIka1J8KZHlhIkcA9oOPnYPJaUrUnaDNQf98Vi0QgJEhlG2F+Z5
 /z84JCgsdyT9TwpHsrWU4maUPm8JgijOkL8fs4voSh7UOECN02739Zj6ymYkx53p
 hvh90SVicb7Nv4mAVfkG0ntKhSMt2EscNFg1LXwtZPg4rny6F3UYJs078EKvVWUB
 kq+znNc/Yhy897nOhRXL/yLK95CXGZcp6pvxbYvfNy6yge/uAVtmJU97YV1UwHTV
 BVuxYx1yxR2bNJgNsp46/Yc5M2trJ6FLRnwK1djisqlm50CxeGJsNk86qYWwZr4v
 c1bZzw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5pdrg0f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:42:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93903622880so159383585a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432156; x=1789036956; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RO2EfpG4mTE1iadWqUmeTkOisJSC3FV4nL89VzJtdF8=;
 b=K4XTt/K1Cd7yHxotvJqv5Xx4iOOV7ArCqsip2/Fb5u3pJjFQ1hjXdVJPRqoOxATl/K
 tLbov2jVGabpeLf6b+EKNgZv0yENgZZokOXZVSm8lMX4u6uJurWEyEuEqfFQ+uy2Jbvs
 hSKZfm7kxKc3Ljof8mMaM1Zn3NvNe49qbnSPVeH0Ic7R+PFIPr5UsuSlznNyE8MorE/m
 uT/rkEAKWiSUbXD7ac4beqorU+X1QG1DSNBTXoqogXfJmt9UVoOVzdfrmoRiZv+so2F/
 Q7/+yLVLZw++bpKSoWORkKv9eU5j3DMQMYrn9uY+hxf+A1+4S9T+TKxsm6ZqDgaVOATV
 1fSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432156; x=1789036956;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RO2EfpG4mTE1iadWqUmeTkOisJSC3FV4nL89VzJtdF8=;
 b=kf3+sp+z3LnxDFM0fSUE558TjhkHFdQQ6olb/Z1LggTadUvg1g3cp1mVSriA5qzMpK
 rRcmsy8UKKIjJVeq9j8XeLIXlr9HPALpCDwUxC3CqOUUyadjg4CAR07yOc4glO9gbyIK
 ledyS1LIIoz2wGgD1dWnvoJSds1fLd2x+IeCtyhqLchrGAVDquOkRvFReP+IISdeLtMO
 oBnuK/p1nV2f+Kp8scbPHJgTU+YtA6LPmVenTBUHH7HoMTlg6rUe3ybqrqymrkl2IsSJ
 XqOjFQ/AvTBeuIly9YsUcVJOTEOau7y196N2piIsDcWCPk8+6E6/nWN1emCKjqjEQCqg
 4q0A==
X-Gm-Message-State: AFuF++nYYWa6gEhzl1e4UFGF/UDTej/NNxRUDd2Uilr3b4/MnX5A1TU2
 stGYMBeygA2wNGOiowVpZ8JmNHKGIK81MNTpsFP69+3ybKkt6YVzwkjdnKNfRwgXICdjA/CUkvi
 FIS3Ux4OVefq7QBzqSA/SvQfHDEJ8u4E5XQho8Rs2L87sOWztJvnaaosyAC92XEfcBw==
X-Gm-Gg: AYBFou24ZlBjFk1qic7tXPXLFiYRYHbdyRKbBHleyFIV2COUgocH+E9K+7g3D2kIWF+
 tJzO/4DMgvHkaZ3WAxf6cEHHmXGRPZ5j/dsyLfzAaR/Wz87Hz7elQ4COu2cAsHptIxrr3FLpM+B
 f6Sdpb5fE3f7LKFA6ZqCGCtC8LXVY2JRfOwNh7fMTHLFtKtc29ZZWcrsLF91ZvKuaGEEWGHdwFv
 V9VtM7Zgp2WNkoK6Ezx4GZA/CA+9fa8ZFyXBF1xOA6NhQgH66jEgm/HjR5n9JKkYdLpS6099b7E
 If7/SLBuV4YLbvyHSiuD6USqCqK90AIlJxHUky0PpKbags9LlrsZ53z3kAfjCrPBaIxdw2C0z1F
 RtkU1vxGEvM8EgqdVG6DpcDlwlQYf1I+5BMtdAwTT
X-Received: by 2002:a05:620a:a70e:b0:934:b798:c245 with SMTP id
 af79cd13be357-9396e07a2bdmr446354685a.16.1788432155633; 
 Thu, 03 Sep 2026 03:42:35 -0700 (PDT)
X-Received: by 2002:a05:620a:a70e:b0:934:b798:c245 with SMTP id
 af79cd13be357-9396e07a2bdmr446352685a.16.1788432155115; 
 Thu, 03 Sep 2026 03:42:35 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5e589bsm56835855e9.13.2026.09.03.03.42.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:42:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/51] system/cpus: Constify various CPUState arguments
Date: Thu,  3 Sep 2026 12:39:08 +0200
Message-ID: <20260903103936.62355-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX+mKynu2VemHh
 adxEkJIUoAPaYjVr3hJeCF1oxR3UQXW9SjZ5GCfeP9Ca9CabniCRQPwF6rGPU1AmlnCfxZaENaT
 SKfvbszVI1HXC7GMRggjWP3/ALDFrv8=
X-Proofpoint-ORIG-GUID: iKYWwzY0keFhLyE0owMOGWGqq_LRNLay
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX60vFA4KykfjG
 f9IL9IMCXbtGARR0iMibNxhqSL6wBzzQjsUO4M0KnVNcfnKainIJY1dnNozWam+aoeSx3CV4E3/
 3QH6YR8FmrTp8Wy/5Z/1KMosyveGp0Qj9/QxHacFEGNfOsqlIkAt6ElePjzuCYF17acd0Aak4o4
 ++Sm3IEWG686kq90GZ5RbkL+iTy9mLz+mpTS05rNMTGiZXLudd1rSXpnz7yuGGf8OlbUjQ8u4f8
 eGLkirnEvItqiUiNB0CQQEuKDIGgr2fn+D4I49OvhViCESWQml+Avfasg92yNCAVmAQKgFt5hx2
 z1Yaqv/kon9MJTI7BOYi/lT76lJ9ahld5vXQywyexkizovdMyeMbjiM2yYXTEgtTMzucnaOBuud
 +sHcBc4xQNCpyqfAea1z1licONbBu8TxqB/L1xJ29fBeA4jmEEyp62OJc7lJZbtREOEchw9DE6S
 G/ifsyV4hrCzK/DNzNg==
X-Authority-Analysis: v=2.4 cv=RsL16imK c=1 sm=1 tr=0 ts=6a994f1c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xPOHbBPGvMiCLs31fh8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iKYWwzY0keFhLyE0owMOGWGqq_LRNLay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
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

Mark the CPUState structure const when it is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260901095229.72018-6-philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 4 ++--
 include/system/cpus.h | 4 ++--
 system/cpus.c         | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 18970ea39f5..328e30045ce 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -900,7 +900,7 @@ void qemu_cpu_kick(CPUState *cpu);
  * Returns: %true if run state is not running or if artificially stopped;
  * %false otherwise.
  */
-bool cpu_is_stopped(CPUState *cpu);
+bool cpu_is_stopped(const CPUState *cpu);
 
 /**
  * do_run_on_cpu:
@@ -1007,7 +1007,7 @@ void cpu_interrupt(CPUState *cpu, int mask);
  *
  * Checks if any of interrupts in @mask are pending on @cpu.
  */
-static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
+static inline bool cpu_test_interrupt(const CPUState *cpu, int mask)
 {
     return qatomic_load_acquire(&cpu->interrupt_request) & mask;
 }
diff --git a/include/system/cpus.h b/include/system/cpus.h
index 508444ccf1c..bf36b823769 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -13,10 +13,10 @@ const AccelOpsClass *cpus_get_accel(void);
 #define VCPU_THREAD_NAME_SIZE 16
 
 void cpus_kick_thread(CPUState *cpu);
-bool cpu_work_list_empty(CPUState *cpu);
+bool cpu_work_list_empty(const CPUState *cpu);
 bool cpu_thread_is_idle(CPUState *cpu);
 bool all_cpu_threads_idle(void);
-bool cpu_can_run(CPUState *cpu);
+bool cpu_can_run(const CPUState *cpu);
 void qemu_process_cpu_events_common(CPUState *cpu);
 void cpu_thread_signal_created(CPUState *cpu);
 void cpu_thread_signal_destroyed(CPUState *cpu);
diff --git a/system/cpus.c b/system/cpus.c
index f37e215c586..e11a5aab6a6 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -69,12 +69,12 @@ static QemuMutex bql;
  */
 static const AccelOpsClass *cpus_accel;
 
-bool cpu_is_stopped(CPUState *cpu)
+bool cpu_is_stopped(const CPUState *cpu)
 {
     return cpu->stopped || !runstate_is_running();
 }
 
-bool cpu_work_list_empty(CPUState *cpu)
+bool cpu_work_list_empty(const CPUState *cpu)
 {
     return QSIMPLEQ_EMPTY_ATOMIC(&cpu->work_list);
 }
@@ -271,7 +271,7 @@ void cpu_interrupt(CPUState *cpu, int mask)
     cpus_accel->handle_interrupt(cpu, mask);
 }
 
-bool cpu_can_run(CPUState *cpu)
+bool cpu_can_run(const CPUState *cpu)
 {
     if (cpu->stop) {
         return false;
-- 
2.53.0


