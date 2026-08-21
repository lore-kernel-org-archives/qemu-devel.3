Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC89FC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMqm-0005kb-BB; Fri, 21 Aug 2026 06:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMqk-0005ca-9Q
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:51:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMqi-0003ki-Er
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:51:49 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9Lmk51474486
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GkfJ0DUVwjpw7Jql39GIYw8AYSod2OF3xVsMsf7lww4=; b=NX5SNCYfLCCIeXfR
 kT5m/LvpiJoTFUH7Yc0A5CV+QO+VWhgPAEOOmmOppIkyoLZpLBVHP/aGfnkppQKP
 RDF1AYgSkQHqzlAZh4l7fT9vpx99ubFZfGkRZuNrYPGWwzjYY4axRxMiBKK5ukXT
 pX70lCVHV4lmVcIJzpaJs3emslXvd2JKpB11uYh4t3tCTYgIrmKAlJDKIuKclmkM
 n6Qg0Qe7OQqZxoUNMUWjjd8h2lQM1WqMcNgtqJEB5RMTCW0DWY4EwWdjNVNFnwPA
 Yitgd4E0eNGcERyepNE6JiAGxLxSjgl+fLZ7AzQ55Ylc+HGSc6Zt3kUDrVZJQmdn
 iSuOnw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fbw9bf5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:51:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91931144870so102432185a.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787309506; x=1787914306; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GkfJ0DUVwjpw7Jql39GIYw8AYSod2OF3xVsMsf7lww4=;
 b=Z1mvddq9KQOMY3ckcetSxe1ibtNnA/jd3Ejdg00WONlddwxWHn66OX6hcjXP5Kdtqr
 oibjujRKhvw6fM25JHWUrQQLMVdvdTq/TG1s8d84fSqfJgnlXnumKojsW4IavB8to6pT
 rb7KiVZthu1+QW3FaasBQLFDMUQwCo0GygcmL7W1GgeWcsjkNHnQsF4dmaQK9fCqXFj8
 trsWw9wYVVGDB55vVTuvJiypvHRRGQYC6YRzIEcLA8JeW9/vvM8ZS9CBQ6ucFGBuYq4p
 SSJkwM7s2+1/5XO4Gvnjto+AbnGGlTc+XRIYWl3lUE4sL8W6YyQ0HYRrpmUwaVM/4D39
 S4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787309506; x=1787914306;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GkfJ0DUVwjpw7Jql39GIYw8AYSod2OF3xVsMsf7lww4=;
 b=IUYZTlBCx7Lf66BHSBR1LoujSAcatwVIjM5vfEBpkEsHr4LZaYQ22T71x99gQV80+t
 l4yRzM+zhDnIFXtz5hNM6xVvFOD3xIt792GFW2yk62Z7NgP/4QSqs5Tu1VnFm+IaslQP
 VtMYEGjkfc7ksTY6V4LieqvNBwiGE0kaiMJdX/NbghhHYB2lQ8u7DLNPB5Fb+WMchgz4
 Vi/8/+fQoYyaxiTYnI2NyE7q5jMUgI/XoBwO7wLSskJjwwR2xKrTP0dJuYGS4Iv51AN/
 pwVwTjh4s31OpRO72jz6R3ovVU5cfdfEHwxV478nlEWlGr/d1k4/0mrkg0WxW8aPCjp6
 JM1Q==
X-Gm-Message-State: AOJu0Ywoc8sEcHdWmZHnIvWgBI1drmxoAjVhjQFh1IoSSf/ywK9oogf2
 /pa+Qr+dqcvDwtWEc2Ur18tuyrIxiaGl2XQIA48ic+gCmolUPfnD/HaFDqhCremeRtrJNeyToYd
 1fS4gj7Y6ZhjBYGi/30co+ua4UqoAOS6wl12XaN5UCA9dgZyWQ+qb6Trk37nLbYvygHyn
X-Gm-Gg: AR+sD11dBEMYq4KYxAx4RFk3o8fJ8hP2yCqjfg61JcgVUZVDPxm7YWW3kq4UNfNlFTR
 pqJhDzw7MAunDsX9JbwAGetx74QcBTy7mvmo+Qudic8claluedlBU1ioIBljPlQMyH8FndaUqUD
 n0V80Xhz443PVg4D4VQ46hgaVcLOFC/lVkzP9Tj1EJwLLbf88pfM9JIf9DsASqAOAxKYnhu+jqO
 26/2+InITxQOhKwsMlINxIaREbWLgp2vv3UukDkgUhXVup64Z54Z6vwT/YT2SKzg/ZCpe/2j40E
 La/mNourhJw43tPC4bneIn0s/dC3Ha9yzW90WzTQRSKAwM/QQtZbbM/zgLsfcxvXKBCAhj1kquo
 kYyGMRLamjCovS6uRNCLgT81ypM4SDOxUf1MTW8ki5g==
X-Received: by 2002:a05:620a:3714:b0:92e:71bb:d1c0 with SMTP id
 af79cd13be357-9373949dc47mr410248585a.15.1787309506020; 
 Fri, 21 Aug 2026 03:51:46 -0700 (PDT)
X-Received: by 2002:a05:620a:3714:b0:92e:71bb:d1c0 with SMTP id
 af79cd13be357-9373949dc47mr410245885a.15.1787309505611; 
 Fri, 21 Aug 2026 03:51:45 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b9b3eeb1sm13262095e9.2.2026.08.21.03.51.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Aug 2026 03:51:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v3 13/15] target/sparc: Constify CPUSPARCState for various
 cpu_*() getters
Date: Fri, 21 Aug 2026 12:49:47 +0200
Message-ID: <20260821104950.32108-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821104950.32108-1-philmd@oss.qualcomm.com>
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfXwwPMHDTfVXxl
 tZSFB88kP8C0Ap5NZ9x40tpTJo/helof08MW058oo/fDAi1OO/eB+qkCY1AV+KIdyHX8LenwlRv
 D9ci1unYsazHiCtuRivpOlXNq4SxjY4=
X-Proofpoint-ORIG-GUID: 6YHdHvpDTDIDldymywI_7pj7VPYMeC2A
X-Authority-Analysis: v=2.4 cv=L9AtheT8 c=1 sm=1 tr=0 ts=6a882dc3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX7pezcQnA7t/9
 300wUTkvyiXXGNgpMMuHY9RE0QBqhL3GXyJuZuEC738zeZM0ykovdJoR3ZLa8F8YRMQ8o0v0uto
 HzmoJu6sbxFlcuOltJqU67T5cTyr+sdLOHd/pZhZu1Cc6wK9TbjXHA0P3c/rEARxT4LSr3JeRGE
 DlZ10jTsgEVn8ThQmAkcyI8k5nD9qd4kVZptQarmcbaKe7hkoGoT+9/j+j1MWASq6XXt6VYdiYE
 MguAs5L94Z/KeOj3A2xjy/YMfmLWs573Yd5aEdxjz6TbXXM7QVasvvpbD0VDUubypfS5Evqzyna
 gvH2ljqOQEd/4hUvwsNvXKKjrfjjKxHVU+GgOZQHK0fou0jXycT2aT2tTwbA+/m1WuYrjIv/JlS
 7Kzsz27pO0GhflJ9cCK2oF2ekeJ3D4YVZAA86mVESej4IlKrpQ9xJ/1z0VJuiE0kYiLnMuuKdf2
 OcowFD42AqWrtWX2ygw==
X-Proofpoint-GUID: 6YHdHvpDTDIDldymywI_7pj7VPYMeC2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210081
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

Add the const qualifier to CPUSPARCState when
the argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/sparc/cpu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 5f583ed9de2..31a16c2af03 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -680,28 +680,28 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
 #endif
 
 #if defined (TARGET_SPARC64)
-static inline int cpu_has_hypervisor(CPUSPARCState *env1)
+static inline int cpu_has_hypervisor(const CPUSPARCState *env1)
 {
     return env1->def.features & CPU_FEATURE_HYPV;
 }
 
-static inline int cpu_hypervisor_mode(CPUSPARCState *env1)
+static inline int cpu_hypervisor_mode(const CPUSPARCState *env1)
 {
     return cpu_has_hypervisor(env1) && (env1->hpstate & HS_PRIV);
 }
 
-static inline int cpu_supervisor_mode(CPUSPARCState *env1)
+static inline int cpu_supervisor_mode(const CPUSPARCState *env1)
 {
     return env1->pstate & PS_PRIV;
 }
 #else
-static inline int cpu_supervisor_mode(CPUSPARCState *env1)
+static inline int cpu_supervisor_mode(const CPUSPARCState *env1)
 {
     return env1->psrs;
 }
 #endif
 
-static inline int cpu_interrupts_enabled(CPUSPARCState *env1)
+static inline int cpu_interrupts_enabled(const CPUSPARCState *env1)
 {
 #if !defined (TARGET_SPARC64)
     if (env1->psret != 0)
@@ -715,7 +715,7 @@ static inline int cpu_interrupts_enabled(CPUSPARCState *env1)
     return 0;
 }
 
-static inline int cpu_pil_allowed(CPUSPARCState *env1, int pil)
+static inline int cpu_pil_allowed(const CPUSPARCState *env1, int pil)
 {
 #if !defined(TARGET_SPARC64)
     /* level 15 is non-maskable on sparc v8 */
-- 
2.53.0


