Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76490C5DF8E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMqP-0005OY-Oa; Fri, 21 Aug 2026 06:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMqJ-0005GH-Oz
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:51:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMqE-0003Ye-IA
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:51:21 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9M1m01895875
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fvBIYCS8kU8+XY5bs75QoBPYP88ZzMJVKYNZ4wSfBZ8=; b=g7svsw/KSjwiHKS8
 71wgdAnqBdl2eEXGpYMwxn9HR5xBfsf1pJ8CzLnWuUMth/KKSiWufMqPm6ifggSF
 W2OpjZGximW5TcP6QPYTqi4NBKI8m7JZm6C6lzfP0xA76b9TMtsLuc1LZtB0GoBV
 +0bmNsBH+ZvG2fgW8IN+MMDVqohKoDpAL71j7gq541X6Z+epkH46/TGGbvlhXnmb
 mPkJPPSWL/oqLYgJSxGlgef3WuEwbYg6yPHGhqUNwhqBMB1m8nJYpVFM3hBxMrw2
 ZN1BrgJgKnno+WNpjb2bMcwQ4/37OatSqFCnlD/SFYx+WnGKGu+ozVPSdaDVRc28
 yqiOQw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdn9771-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:51:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c083f1818so9024011cf.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787309467; x=1787914267; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fvBIYCS8kU8+XY5bs75QoBPYP88ZzMJVKYNZ4wSfBZ8=;
 b=P/kgIcbRxzKbEikyIza1hXpzo4yW0mgnSxrCHKzBetm6mgNF/3nf6ctyEDqI9FL5wi
 l8Iip6SNAXpqsNv5hc2RCgrTyiEVy7Cz8huP197+fwQBb5DfIEHX35P7cqSnY5AkRbh6
 jPOVQ6rXbv95TFSSeh6F9oMUGdzDZd63SgPLMBaZdjy+ZINVQVmX7TFtHHuAnOvuhB8b
 Y2+ik32HzarvwesgD/fOMPgBWgSRs9nCpibFRAEjwgyWDr8SkLxQculJQtodxLkOb89c
 TlgkdGMul13n4T+ROygumzcpB1DUT9VzaYVeq+tIRca/GeYiTr6OFfwCaZQI+mgVGELx
 u4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787309467; x=1787914267;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fvBIYCS8kU8+XY5bs75QoBPYP88ZzMJVKYNZ4wSfBZ8=;
 b=jBtAu8NxzfO76Wf3Y7TGn/WjFD4Gqu76CeVjvURAB+eGkqxpiKMs+7qYNyOi6FSxf+
 vwtzloMHCcWCCHJTw7sURTJsfUTIKPWrU1lGRrxyHL6cz8JVAocT0DBuuIJ7h3LJJYk2
 FPp3qliwtDjReKBdm6FaZBwv2/RC99Jx7osJEzFtPe8KF2v0v6ol3evCITI0/kUN9Tqh
 ax9R5Y1szsWrmMlkpiUOv/uoAlunl9w11YUx4p6POK9A4NoyOVvv92QdVp6qcZt5CWAw
 0wM/Wmp1jjTuNjgDaogPQh/PjRsTWQzwGhTz8Uw4bJdRmp7nIQgBZAU1KszCtuc5Ma6N
 ra/g==
X-Gm-Message-State: AOJu0Yzkmx8z83/I4C5CIM5a9vHo9aU/9Jd37TYBbRAZFK4Xh64QAkrP
 qOQx37UGI4wJoeOY6HHTpd6+Qjlrmy3QX2oCK8hkHOuiu7NYxKibs/XRUW4NZupK5MdTbe9JGn8
 Rmo8CP/3F8G58cdOZOCS1sVoTpu+qx+7M5rtx71bnDHO1tG43xt38lZ6CQUbE8yNR9hh4
X-Gm-Gg: AR+sD12txEPwrRNwt9MqJWh9LSJh7N8zuWIZnZpppTJgeL8ZigXZOPWDAWyX+UyljZ8
 GIqBa3TIGTWjAG6/0kgHs/ue/c7E/IMxnhPqWi3xq813Zz+b/p/yhwQBVZZvu1zEi+KxId6PgPE
 XZmXah+IqxgKawnAwMoluNr4XdBs4X0hJkcqEFISTUnZ2EjRUu0sHog6CWECjFapYam08e99g21
 kT6/UE+CWS7T41LL1KyDusZd8IgCrKWah4/XoBBURptcURwFMTk+3f5wfRtqY8Nv3pNSk1zPRDQ
 Q3vVYhURhIwZXF4rTv64C9Kn9zoDXdWl/g/0q+qYdmxzNKAGyffDE3PyXx0/su26vsoLZv6fYRm
 aIy3NDkQpfqm3NFGI1GcMEkvzIENQuXXyIG5sRNsFRg==
X-Received: by 2002:a05:622a:8c7:b0:52d:771a:231f with SMTP id
 d75a77b69052e-52df5739764mr48025941cf.12.1787309467065; 
 Fri, 21 Aug 2026 03:51:07 -0700 (PDT)
X-Received: by 2002:a05:622a:8c7:b0:52d:771a:231f with SMTP id
 d75a77b69052e-52df5739764mr48025591cf.12.1787309466634; 
 Fri, 21 Aug 2026 03:51:06 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499bae8bb6fsm15499405e9.0.2026.08.21.03.51.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Aug 2026 03:51:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v3 10/15] target/s390x: Constify S390CPU for cpu_has_*()
 getters
Date: Fri, 21 Aug 2026 12:49:44 +0200
Message-ID: <20260821104950.32108-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821104950.32108-1-philmd@oss.qualcomm.com>
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX2UMs4JgEYXZR
 gMlg8LozZi5XGeaybhQIzbQkvT2lpSXuaMswZZzs2XNC4f7U856ZDRPi+8vl3KgSogyp8Z9ZgvT
 Un8aSP1kgVwJkMPLpItyNSENU1ncZbcCO8VvsulLSrCmbkFUeHe0tosbFZBAqP+dB7hab76gFpo
 1dsT36T3V+JkEYxP+TBo5sWJ5OP5Pb42y76FNF0+arqWit4JYgM7MHYEWOeX3cdKec/lu4i2afl
 EuQKTkiBP5BUCn0K0ukHxcvCyPrf5JdoquRXWLC7HtW2yKRc/WqHDiweyG92V0xsv/dnjdzd6Wg
 nbyckMmeQul7ndbaZdOdrQU5CnSDs9MOaFwtxOv6VdtWt883GDuOYh6nKMI+rUyjcpiWbmzUyfB
 LEx9x0C9RpHK8IWbRsGfR4EQdhFXDKSR1L+NG1OVfhQ92347YI/1XFOF46iodr1UHkix8C00WUz
 IF0cvqBaqN8F5iz9KLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX07/xBoP6f2hu
 4fOt1NuzJGmZH6XUJy2dcZgRcaSdSEW/Fp4OK1tAW+GSdXGkAdDl8UBapw3hs3I2RbbiiRryBu8
 tDSohbUtafOVuBx3zoCRMJJwCSMS200=
X-Proofpoint-ORIG-GUID: 3X-FsKTlcGGhyZg6rcT91qJBDnp1x8fe
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=6a882d9b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=mU8mmpTTODwToQi1tsoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 3X-FsKTlcGGhyZg6rcT91qJBDnp1x8fe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Add the const qualifier to S390CPU when the argument
is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/cpu.h            |  2 +-
 target/s390x/s390x-internal.h | 12 ++++++------
 target/s390x/interrupt.c      | 22 +++++++++++-----------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index f55b79ef8ac..998bbb0d7ff 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -854,7 +854,7 @@ static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
     return 0;
 }
 #endif /* CONFIG_USER_ONLY */
-static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
+static inline uint8_t s390_cpu_get_state(const S390CPU *cpu)
 {
     return cpu->env.cpu_state;
 }
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 50782fac3ce..ca4445e6474 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -333,12 +333,12 @@ void cpu_inject_clock_comparator(S390CPU *cpu);
 void cpu_inject_cpu_timer(S390CPU *cpu);
 void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
 int cpu_inject_external_call(S390CPU *cpu, uint16_t src_cpu_addr);
-bool s390_cpu_has_io_int(S390CPU *cpu);
-bool s390_cpu_has_ext_int(S390CPU *cpu);
-bool s390_cpu_has_mcck_int(S390CPU *cpu);
-bool s390_cpu_has_int(S390CPU *cpu);
-bool s390_cpu_has_restart_int(S390CPU *cpu);
-bool s390_cpu_has_stop_int(S390CPU *cpu);
+bool s390_cpu_has_io_int(const S390CPU *cpu);
+bool s390_cpu_has_ext_int(const S390CPU *cpu);
+bool s390_cpu_has_mcck_int(const S390CPU *cpu);
+bool s390_cpu_has_int(const S390CPU *cpu);
+bool s390_cpu_has_restart_int(const S390CPU *cpu);
+bool s390_cpu_has_stop_int(const S390CPU *cpu);
 void cpu_inject_restart(S390CPU *cpu);
 void cpu_inject_stop(S390CPU *cpu);
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 1dca835c5d8..d7e3fd45e4b 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -139,10 +139,10 @@ void s390_crw_mchk(void)
     fsc->inject_crw_mchk(fs);
 }
 
-bool s390_cpu_has_mcck_int(S390CPU *cpu)
+bool s390_cpu_has_mcck_int(const S390CPU *cpu)
 {
     QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_MCHECK)) {
         return false;
@@ -157,10 +157,10 @@ bool s390_cpu_has_mcck_int(S390CPU *cpu)
     return false;
 }
 
-bool s390_cpu_has_ext_int(S390CPU *cpu)
+bool s390_cpu_has_ext_int(const S390CPU *cpu)
 {
     QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_EXT)) {
         return false;
@@ -199,10 +199,10 @@ bool s390_cpu_has_ext_int(S390CPU *cpu)
     return false;
 }
 
-bool s390_cpu_has_io_int(S390CPU *cpu)
+bool s390_cpu_has_io_int(const S390CPU *cpu)
 {
     QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_IO)) {
         return false;
@@ -211,21 +211,21 @@ bool s390_cpu_has_io_int(S390CPU *cpu)
     return qemu_s390_flic_has_io(flic, env->cregs[6]);
 }
 
-bool s390_cpu_has_restart_int(S390CPU *cpu)
+bool s390_cpu_has_restart_int(const S390CPU *cpu)
 {
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     return env->pending_int & INTERRUPT_RESTART;
 }
 
-bool s390_cpu_has_stop_int(S390CPU *cpu)
+bool s390_cpu_has_stop_int(const S390CPU *cpu)
 {
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     return env->pending_int & INTERRUPT_STOP;
 }
 
-bool s390_cpu_has_int(S390CPU *cpu)
+bool s390_cpu_has_int(const S390CPU *cpu)
 {
     if (!tcg_enabled()) {
         return false;
-- 
2.53.0


