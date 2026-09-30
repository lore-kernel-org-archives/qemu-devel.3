Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0EBCA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBySE-00022s-LB; Wed, 30 Sep 2026 13:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByRn-0001pn-Nf
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:50:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByRl-0001Wg-Rc
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:50:27 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHfCdJ643969
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3ITDVxMKQyrvO/cJ01b1Bv1m3X4CEZI3TJHmNI/NA9U=; b=eT4e0g3F9F2/lnef
 Gay76jl0OWK+Mb6RtFekfmi+U4/fOsnjfLfjL2bconqtQtAjJ8xtN+HCwPo2EQ9Y
 Stbyd5kV0jnib8g4aDt7+kG1KLMz+pHDdUJjN1/0lKxPqcVLPGlm3X9EFNt0vXjT
 oMSNSF7Jkw+oD727t0cLH+qA2a7wuixdOZd08vdvkt/gVzsp041Jx+5Pn7C/nYSH
 bpvsDO930ovFAWNk8Vo6hwE43E1Vr9kquyQgiUkHao18kbXK3pqCrO6aBU+wgSNo
 SeEnrqI4YJEQ4yUIjVxKUJ/3b1A4cdgTEpDT7lVV8Z7fgmF2w7DQP9uNo39iB+EM
 Lc9WuA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h14n20uwd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:50:24 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7989d8ef4a6so892897137.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790624; x=1791395424; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3ITDVxMKQyrvO/cJ01b1Bv1m3X4CEZI3TJHmNI/NA9U=;
 b=KZey0DFFLmtJS0BhIP9uYDHiXLKVOthaoIl2XEiu8otgPYuOZYNs6TdzAgB/nGI2Vs
 N8DpH7Ncphz4cQ0LXt8qtQjX8ljirQVKYE8Uchwf+R3kyP4LLm0kTGH5PrPnYZCZoEXl
 H46eHK3OLX+fOO87u7cQ6B4bFqlOUMdbkPSSlfnjI+VqgnUdoCH7GyiDIJRQ4M160rsl
 rKRfm0dV++bMS1MzCQmx60L+8gUwbYdzapo2M/Z7uLq9PnVHS5axPERkgtjXgSyKbUPq
 ET5cQz9byon30bhu6J/pLZgaC3vFgMoAh6e26uieQWfQY80JJ6N0/IYMWqwySBkHnOr5
 PBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790624; x=1791395424;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3ITDVxMKQyrvO/cJ01b1Bv1m3X4CEZI3TJHmNI/NA9U=;
 b=puE9FRnTQcaxNxjzW+HtbPmC7Ryd7JCxNUUDqJneiYywMvErmde49tEK6B7HDCfQMQ
 3oRBOujmC72AW4HYiMmTeqvOyneuFdoG4qI5Y8BFB+/a4s7Q5BARm+PYmHDw1X8DY+Jc
 +Eu8RtVVMcECL7jgx0GNUk9SMOezctFLAOPFcWsLuE7ZNU46lrayZ66usjnlqrJsV8uY
 /myP9GsecUtcxh4enPAHVwQAC8Brbkfw2zGHGZosLKlrrbiWyKUx9+36KpwZ6utsJXs5
 B8wNCUvSW4f1QVbmMp31OM5zhusH8CHhz6LXMVAOkHdothRuiPGUEi/Zl8k3aDJsiE4A
 MryA==
X-Gm-Message-State: AFq9FYLkc/pdNMjAMOHXWu9z512AwARisgjrV6bZ0tlI+8FVpb78sHwO
 VMxmW51Vm1opmpFIH3Rp7dHKxtPgQUDiHYwZ9v2kVGQTuIKZdT+zEgU8Cv5mYJQfwUdYYMKv9Tn
 t4Xx9sbxcGyTHzjaUYD9XzY4/uCl7qH1XGOiFlfSQIfoanT5JAlkp3LKMUbs24cSrsg==
X-Gm-Gg: AYBFou2TS+lm5BgXnvWBmWxUCp6lY4/14hIZZ7E77znbkTmQ3RS1+CI9wT08QGvGwlK
 FIEuUd0ofhrLu4dpLU/KJw96xlNY5dvk0ALPauMWIOO1TBVXydw4ZHepUDXv/pHHt3JmLImRfkw
 TCH4mjXbCESrwT/lV92IvuoSC4Dr/TAM1vVQnyI1mM7kU0VQjhpna5b0IxTP0Sq7/1Wa+X2+tlD
 5luTLgs1CLm2YBtki80Kwik/oHXqW1zymtykaPthWveXH/40jtfm/AGRUqZcKtUvfekwE3yw4BE
 rGQKZAwy8ec9PmGSxZBJmqsC74PZyKm7OFpdQm8bA0FIOJj076jnvXeVNc79kHPrSkD+XtuCKWw
 /H4yWA3plGVNgcwhJRglvKK0MZMF5JrXkdz9PWQoy
X-Received: by 2002:a05:6102:54a7:b0:7af:4843:5ec9 with SMTP id
 ada2fe7eead31-7be724b9384mr554128137.8.1790790624118; 
 Wed, 30 Sep 2026 10:50:24 -0700 (PDT)
X-Received: by 2002:a05:6102:54a7:b0:7af:4843:5ec9 with SMTP id
 ada2fe7eead31-7be724b9384mr554116137.8.1790790623690; 
 Wed, 30 Sep 2026 10:50:23 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01ef9b9e3sm5652445e9.2.2026.09.30.10.50.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:50:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 5/9] target/i386: Split APIC polling from
 x86_cpu_exec_halt()
Date: Wed, 30 Sep 2026 19:49:41 +0200
Message-ID: <20260930174946.82195-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930174946.82195-1-philmd@oss.qualcomm.com>
References: <20260930174946.82195-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6abd4be0 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=h7OMh5kjI76PbTVxvEwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX4S48SCQy+C6B
 qaw+dVn+KEBnoVbxpA4RXQ/8YD13oS9Z9pyZRmCD0M7SFm0Cu8nQL1mg/aDCHkZhgRAUKhe9KaW
 Ag35L0Hj63BAb0zWJx+h0zj9/CSYPeQ=
X-Proofpoint-GUID: 7_OF-3tzS8v5TARROijnDsE-ItZ8EfVJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX11Mxs2xQs0H5
 bZ9hEy5ps68oNeWNTjlmnrMwvnr+6h4VYEUPTc7k1IkLK2HzRiPnjmJE4ZF7/OLlIuY/7rraHSy
 chaRZh6sRMbAlpmKmj8VtAM6opEJbkecVo0OQSI8apFQ2PTVl5QkMBi+IuCNHVgi/9gbfz63yPj
 4tk+TqEN0G/A5lyz1gf7zGjpvE1FXbA+6edi//wqtQd++FEY7Ag+DRb/OYHpaWKTfqyIHEGsc2z
 TXKLvrbDvjjvbZSQ6zd+KqYm/mFCXH7wYNo4yNTuaFAENSkHn9GI2Bvj9iiqO7Guq5H0bjn+2KM
 oAbrZAujU7Ibb1SoKBt+z1EJYN/VMAReOpwyXNcuGY5kk+uUlHfOqda8qChMY8x6ndi4c9cVo1I
 ELx2C8tcisnvzSsLHxv5/bQvEWC0ZolgI+xJmEzf/kdecgrhsdL56TQ5vqnVxIhJVpkqHY5k1eG
 4ve3gSdphtVl3efRorg==
X-Proofpoint-ORIG-GUID: 7_OF-3tzS8v5TARROijnDsE-ItZ8EfVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Move APIC polling into x86_cpu_poll_during_halt() while
keeping the remaining halt handling in x86_cpu_exec_halt().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/helper-tcg.h        |  1 +
 target/i386/tcg/system/seg_helper.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index f4b2ff740d5..58e8ca0bc1b 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -37,6 +37,7 @@
  */
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
+void x86_cpu_poll_during_halt(CPUState *cpu);
 bool x86_cpu_exec_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 8c7856be81e..9ce608a0bb7 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -128,10 +128,9 @@ void x86_cpu_do_interrupt(CPUState *cs)
     }
 }
 
-bool x86_cpu_exec_halt(CPUState *cpu)
+void x86_cpu_poll_during_halt(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
 
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_POLL)) {
         bql_lock();
@@ -139,6 +138,14 @@ bool x86_cpu_exec_halt(CPUState *cpu)
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         bql_unlock();
     }
+}
+
+bool x86_cpu_exec_halt(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    x86_cpu_poll_during_halt(cpu);
 
     if (!cpu_has_work(cpu)) {
         return false;
-- 
2.55.0


