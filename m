Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307B0C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mmG-0002cN-Rz; Wed, 02 Sep 2026 11:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1mmD-0002WM-7R
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:21:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1mm9-0000Ff-Nf
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:21:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682Ecrck1675942
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 15:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +YPNLAnu1HEAYVb+feaZUL0eZ0sSfOiNmPRQjU24rs8=; b=E0R1wYBZw7yRHNTj
 z0iYW4nAYBxbStmxtH5NOl2iDX9zxcP7M+8ocutI2+iae7gXi0scsAFvMvi3hxY1
 lkr3VK1IX1AystE393oHZnC1K1vc+HxWC+lUolRLAS56FwAf0yxyyPHqCC3oX43F
 seSBprsV2vGVJegxae83m4ftHbdDzRZo+NYLfTywSKSRtlxrlm4hQ9VsExw1eQqc
 cbxCJvOk8mE2Flcqi2yzxmoi4wBpfkLEC1ot9wiD7qix2CKW98gUXAtGO6pWF7Wc
 EJcCfvpi/a4+LakL+J+qHiTdAObnAKZ8h8p8q77YmgYifdR0+qaTHVksOGEHktMT
 WlM5Vw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdr58m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 15:21:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93915f50a5cso513181985a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788362480; x=1788967280; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+YPNLAnu1HEAYVb+feaZUL0eZ0sSfOiNmPRQjU24rs8=;
 b=hXL/ShQnX4Va95LXlgzVW8gm7PBlQcQerRJywYJnbtbAiyWJAu2gQnOhBAJIcbhghX
 X4NwwFU61O+LwqZxDKJeY/seuYDdVIGXWTfG51+70V+O4YJnJYtipt/FTidmytAWG0Eh
 +Moc7LN1+Y1jD+JmM8MokohqNI83mT9Otsedpl0EKbwRGVwb71zFMiyfmHQ3w8nFDkEe
 aW8gab9SOeA9DEplzphRocQRPEqdv/M2s2R5Au27xYu2WT6h3QYXjrUJ1w+tBbZe9iTZ
 2FS+MQmK+PzpOo8CSUxOgx7bMBlJK7oA0SYmFdpQqWYES6MJfI8J66ZJC9Xbu0/r0+tS
 2hDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788362480; x=1788967280;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+YPNLAnu1HEAYVb+feaZUL0eZ0sSfOiNmPRQjU24rs8=;
 b=sktqgSOmVyrgYVlzbShO0PyYAELT5S16l/p0ark3lGaCQ/sSzDHn5pF4nW3eeI4fHq
 7uWmEcxMez2rwTdNRiFZhCxXr20QeMveUYWcZI1Y5hu/awXus0/D41rWewK0lQs23nn6
 rRR96vOfKFP0pR63h5A0dw1Oh4dZWKF+VGY9ZWCjtO3fU4GZPAID78UCLTxKQ8sH1ueF
 kn5OcReqICUtJuxNqaxEsvT0yzfAvRUgtXdAUqehlOG9hq4WmCJ7zIU8gzbDGwA0e26N
 TEWCu39b+PQTTwPlGM25vcp1kz0oW1n2mIDvEWW1rxaiaNFLPDeAZmrkEoTnW8EO5/B2
 oUIA==
X-Gm-Message-State: AFuF++k5JYHHg2cUYiXFah1WaEzab7NRX6YM0nowC6Ju/Fby73Mh6o42
 HEdwEodfQfHGRHVmh9TjVnJlnX6uSGDmzixHZbgdPtgGyjqr/LhNk8ODfQLLRJ+xrO3HCjEJy/E
 saCh7Dij0W5d4mE8VJquKxI6Hms4LTOOjLdoXg0ogrptOV3gjO2WJfKOIapyt0U3pFw==
X-Gm-Gg: AR+sD11PmS0LRDI2HO0zkXKPbNUKna8RAm3LvXCUhp/NZBX/UqyHcX17mZGtVKHI/AX
 Tn2BtAeXUvBHODpuA4djlQcHzmyf9FnCkTpk9Ow1ZHCfSLrpChW1sSot+VaygEiVKMdGbtuyF75
 3xiNpIPccbxHctobs0mS8te6R/PZKup6K+5okiQE3EgQ1+QEHayQdpBFC9vDjnfMhx7UrQSg01i
 neZLSsGVaU22wvXgQKw7FCgC1svSVb4gQu+Q8/tyQP8XNpEDOeFSkWcmHaf2MJHmwOQRlATDn1D
 VQA3N/MOLc+nN87aJ2FXzpPNT2j4BMjilv1xJ22MZY+fuPvqakInN5AiomqBVUbeoznF9dm5Doy
 iaIPxTTXf6zKn4LWu/x1EcxfRx1tYBgfWgRJWKboo
X-Received: by 2002:a05:620a:4553:b0:939:3f4f:7254 with SMTP id
 af79cd13be357-93965bfbc2fmr430856485a.14.1788362479977; 
 Wed, 02 Sep 2026 08:21:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4553:b0:939:3f4f:7254 with SMTP id
 af79cd13be357-93965bfbc2fmr430843185a.14.1788362479299; 
 Wed, 02 Sep 2026 08:21:19 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce591f846sm26874605e9.1.2026.09.02.08.21.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Sep 2026 08:21:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 04/11] accel/tcg: Document cpu_exec_interrupt() callback
 contract
Date: Wed,  2 Sep 2026 17:20:35 +0200
Message-ID: <20260902152044.31291-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902152044.31291-1-philmd@oss.qualcomm.com>
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a983ef0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=SWPfrzv3WwVL6hwBn9sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: LxgrlK6cToqcq-1XE3RD3hEganaCBx0k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzNSBTYWx0ZWRfXzeCengirvBCN
 noklULrWe1g88DhDuw6e7KSrgJMIXwXS01M3QYhxnzPzxy+idwKgXIC9LHEYE0BAmAL45Eid8Vd
 dtixzraRKsab8uqXNUNwkt2dn90r9rBVdTk/cJjTJEx03svw4O49eHGzwKCwSzDvkHAc0OqfpWI
 dKfpWGCALsX7UTR+IZDcCaz1yN6HKVyAUQdTl4qP4iL+kaY/eR/a9aMorGdupjF1Zt5MSzj68Li
 ofNUMqGhlHHWJV0mU5oh5u8uhHbeU5qElvZpXeuwvKAbiQ/F+l0tRAn2k1NqZPkP2Pu191g5sKh
 SHn1cbq9FSeuLClw1JaCHp54p7O+aKlgO95BNpBeTNlmxEm8RLtKAY94OQ+WbFfKr5KwtoLAIRK
 QiGzwl1Kr05sokR0Q2GRIk6JiGFzC9IsJ1T2dRElPRGr9rPEnWWM3t1OEqvqBA7MibuDl/1+jPp
 whDv1yLBzFJ0/1oa6Bw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzNSBTYWx0ZWRfX0rL02MbrcASu
 XciDVPhO8FoRj7RTcTCAY2h+XhX89lircAxm3CI/7w3EcTyqU+x0H7EjO8LcChfMgyP444wgZEe
 N9MzohEJdM/h/ZMiqYYfbAXUPVoeyQw=
X-Proofpoint-ORIG-GUID: LxgrlK6cToqcq-1XE3RD3hEganaCBx0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020135
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

Expand docstring to clarify that @interrupt_request is a bitmask,
the handler is called with BQL held, and document the return value
semantics. Fix typo in arm_cpu_exec_interrupt() documentation
(s/inrerrupt/interrupt).

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h | 15 ++++++++++++++-
 target/arm/internals.h      |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index ded7cc700df..87850402203 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -171,8 +171,21 @@ struct TCGCPUOps {
 #else
     /** @do_interrupt: Callback for interrupt handling.  */
     void (*do_interrupt)(CPUState *cpu);
-    /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
+
+    /**
+     * @cpu_exec_interrupt: Callback for processing target-specific interrupts
+     * @cpu: cpu context
+     * @interrupt_request: Bitmask of pending interrupts
+     *
+     * Called from cpu_handle_interrupt() with the BQL held. Process the
+     * pending interrupt according to the target specific @interrupt_request
+     * masking rules.
+     *
+     * Returns: %true if an interrupt was processed and the next TB should
+     * be restarted, %false to continue normal execution.
+     */
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
+
     /** @cpu_exec_reset: Callback for reset in cpu_exec.  */
     void (*cpu_exec_reset)(CPUState *cpu);
     /**
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1775835ad50..551a6b4a872 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1248,7 +1248,7 @@ static inline const char *aarch32_mode_name(uint32_t psr)
 }
 
 /**
- * arm_cpu_exec_interrupt(): Implementation of the cpu_exec_inrerrupt hook.
+ * arm_cpu_exec_interrupt(): Implementation of the cpu_exec_interrupt hook.
  */
 bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 
-- 
2.53.0


