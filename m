Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1200AC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuZze-0002Cn-Gx; Thu, 13 Aug 2026 14:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuZzb-00029I-BW
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:17:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuZzZ-00026x-Q0
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:17:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFUKvh3051346
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KExF4MwbTUUQ/1tzwHuPXSMnN5BfvbjHcIrr3pOpFSs=; b=pnUQhFoVW11HG5T/
 +qFN91c4WEKaLfjB5+LNkNFCF6vStDtgEgoh0EU3j8U0k0yi/4Z4IvkaYUhYCGXW
 ctvpTjdYAFCIO7uL++oSHHC3Ms2k+iB+SVUXxpHjfwaiTk/YGQHl+O+n7/RgBdjJ
 iGuFiqRlwn3tn6OQ4GT2IFHt82wMNMM53ScXjA0pWA+5pZ3I4z3ou+UMCvYEDw8w
 HW0Z10PC4LMkzTrHQbs81l3Fj3/M4KW5TjPMmlmH7chIn56rASSlLo3E42fzyVng
 TW5Q9f59L59gb/2tD5s8enCOZ7eJfR7bqAQhoTt9s3FSGw5JLPd/TyJDR8DlSYxU
 dS/GNQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1fg3s6n1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:17:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d8243f1bcso3713581cf.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786645034; x=1787249834; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KExF4MwbTUUQ/1tzwHuPXSMnN5BfvbjHcIrr3pOpFSs=;
 b=IU9dEtjronhpQZy00iwpzCwarz1BeaU+qeeXr4EbeObzAXn3HljG9uJZlatFap1tOb
 eQyuCCVn7yyq0n06d0Z4P9n9EjUUkuhqUEBWk/kbbOwBzRElMjv7hyUZhYJCGZPy/f3L
 Z4O3tk5dxlgJsDbaVuWudOkh+Cl6GK7ufU+86gMc84q9kqyJ4N+ByH9qt6hDwvM32Kcz
 llHnmGmySoQoTTSAmP811z65ggtyehoNk/G+23lW1tAoc1DKSpm6Z6EKR53HcCNAUdhp
 fd5RTVHNgpHroCfAJVrD4C7AQ6iuDKH0ZOyVCuUUgnxf+2MBv0PuHXvwy/M1wx74+Z6F
 +Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645034; x=1787249834;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KExF4MwbTUUQ/1tzwHuPXSMnN5BfvbjHcIrr3pOpFSs=;
 b=pxqFZGvEAyBzMyXLqK3sVtA4UXW0CnVnSCtZFBsdBK/qixVwp9o3Zm/DzshQajF9sy
 dPT62aDWrHR/kbiDfQks5ucqwRRjW6YStsvQ0HnlHqg4ydr6Atb/fvRZfxACebwOX9nF
 10D58GvDPLPTQ8mgeIvDzcoef8jH9U5ZB2ZOuwzmeKGamZ/c8/iQ6WSzchKHl0DNZB57
 ZlL88ZWoHt/fL5lcGnvz1Uu1/mlWprQpjZrelEvdycXOdygiPzotARxP2KNbW2xXtCpU
 HLr0+v2k/hgA4hlLpUp1TzSjQyPaiZQ9mDz1lOe6JYwBLCJLba95gp9LWrHS9ShUiqPi
 PB0w==
X-Gm-Message-State: AOJu0Yz2njppFEyixJALuc3DRzb3ourEtmkJmrlC20LuI+pluA3XJZRs
 UMO3uxNEODzrzaVBmHHcFox2bwTIk8Y6yNZpSxdKAey04KUx6vDJmJhAEP/RJoACDKQUKlLSlYY
 uABoYicTRCfPdu0xqIoADSEZDGHCI/PLkUFhMaovfiXnFi2aHjPfmxwQ0tsTpyxfTGw==
X-Gm-Gg: AR+sD11eKuqtMjcYOKAbrybtFesBwtqei/6aSBDz4mzrCtixY3lPZaAOoSisC16qWSN
 mJH1OVkX0GUOrtz8MrIphZC4AX0xN2JvBaAqImEWkvzIJ+W7SDbUonAi7inAgt7+Xc3s61ze8/O
 x/uaasBurqIeURXzuZMaRYZ9HjytPNp0Ms9IJc+mXjSvx7ThdZunWknSBmkPfeXWIsA9O5SzFbU
 2pc0hbz2E9DAOevGT/0i1JnscXisxeTlcjFk14q6geKw9U+7xUtoR05/Hi/7Iw9NJtrE9CPC5+c
 VCCarggtU9ezwPZjZeuy9Pk23cklY70zJDOnsGoUG/K3eI9awNXdY0Urma0Q/Ev02ubfQr4OCCz
 FrgvdDPyKc1607g+NZkXB3a4Dzn9LkOlUx0+Cbsch/g==
X-Received: by 2002:a05:622a:1a81:b0:516:35fe:5524 with SMTP id
 d75a77b69052e-52d74a3546cmr70162321cf.5.1786645033481; 
 Thu, 13 Aug 2026 11:17:13 -0700 (PDT)
X-Received: by 2002:a05:622a:1a81:b0:516:35fe:5524 with SMTP id
 d75a77b69052e-52d74a3546cmr70161411cf.5.1786645032819; 
 Thu, 13 Aug 2026 11:17:12 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d20fdsm5607615e9.1.2026.08.13.11.17.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Aug 2026 11:17:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 04/16] cpus: Rename qemu_cpu_stop() to
 qemu_cpu_ack_stop_request()
Date: Thu, 13 Aug 2026 20:16:27 +0200
Message-ID: <20260813181640.6537-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813181640.6537-1-philmd@oss.qualcomm.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NsfhtcdJ c=1 sm=1 tr=0 ts=6a7e0a2a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=oALTtu6IgWlc6orpIWcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX3Gw//Ay4pte/
 mjNYKgZR7DImEQxX8JFJOBXYeMRiepMPv8VuMxEEWiDHhxV0KRbUj9TsYkiNlmQzhDz6ScwUjUX
 hY90PgEbt+mYW2gOcnanv263CPMYyBNrs2k8vtf6x4/dV2bRqhYHrZ6k2Stt9N3gCdnGWz9A5l+
 JK6+kb19qte5izfjCY74pZiiPPWmxI5Y4xDOp/Zfo2hvzR4Ay3jAUc9F2EzeucW/Qpr1ST9n7h/
 KX+1cuzifMANPoGX0ukP9TLGzjHLuDTtbN4JrLayP2wyLfAnnz4SSSvYWrsOHoWpJWdLdX81aXy
 HUgUx2ie4mckltqDEa4ME1CMVpTI56j1qQkKLCv8Kmkw1cq0R2I51BrOv7aKRLoQrpSJ75hOMkt
 jY4alunPVHOcM5E4Zmmx1mpofa50Jb/h8fj4pWWkSw5qyAVXLzGZLDlR22z02rGcTTrNSocUxFD
 5e9KJ5OCxlgbuMM7xGQ==
X-Proofpoint-ORIG-GUID: G7f4hp2N71jB3duBmuej5QnXVcG3fYza
X-Proofpoint-GUID: G7f4hp2N71jB3duBmuej5QnXVcG3fYza
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX6YHndxvTYFYJ
 NMArpsSsjZKcKy6Bq6pEDh1fVJDsv6m0baYGDRGEsb7LsolVqgdaNaMa2nMfS2S08lZFivL3Tgg
 nUnv71ur4N3Rl0n7i8LSZxQoeY7RYVg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130132
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

Stopping a vCPU is not a simple state transition: an asynchronous
request (CPUState::stop flag) is acknowledged (CPUState::stopped
flag). Use a better name to clarify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 system/cpus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index 1a6fd286a81..f69558c760c 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -382,7 +382,8 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     do_run_on_cpu(cpu, func, data, &bql);
 }
 
-static void qemu_cpu_stop(CPUState *cpu, bool exit)
+/* Must be called by the owning thread */
+static void qemu_cpu_ack_stop_request(CPUState *cpu, bool exit)
 {
     g_assert(qemu_cpu_is_self(cpu));
     cpu->stop = false;
@@ -397,7 +398,7 @@ void qemu_process_cpu_events_common(CPUState *cpu)
 {
     qatomic_set_mb(&cpu->thread_kicked, false);
     if (cpu->stop) {
-        qemu_cpu_stop(cpu, false);
+        qemu_cpu_ack_stop_request(cpu, false);
     }
     process_queued_cpu_work(cpu);
 }
@@ -555,7 +556,7 @@ void cpu_thread_signal_destroyed(CPUState *cpu)
 void cpu_pause(CPUState *cpu)
 {
     if (qemu_cpu_is_self(cpu)) {
-        qemu_cpu_stop(cpu, true);
+        qemu_cpu_ack_stop_request(cpu, true);
     } else {
         cpu->stop = true;
         cpu_exit(cpu);
-- 
2.53.0


