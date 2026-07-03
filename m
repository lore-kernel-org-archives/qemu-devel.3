Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED5BC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgxe-0005kR-5n; Fri, 03 Jul 2026 12:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgxc-0005ds-B5
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:41:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgxS-0001kc-AT
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:41:52 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIa4m511014
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OJfYBFEk6cqjY+BSEvPVamiQUgD1yf8uocYVw14otOc=; b=ACPpdOzQzbCywrhE
 j/mWfybD0eyizLWOLXYF0/2fFy9+u9w7cAI+764A4j6lpH0aAsmRSay8eauNGzrW
 8Imk7cgA4x91bE8vy8r0cDWRNazGL6NCUd4Usy3nspKcD4dH/j0qPNnD38YN+Xyp
 LpDiHXVWnAAiDVe58J1tvh+gt3f47rpfvYdpADwX5ve0BtQoJT7jYg+YShAi/31/
 cawS65VFonBrm2FZjmy+E1HUF8JCPAJzuznV72/ghBmmnnGPj5Q17iBembcfJPnN
 K1iTc+vC5zcZ6QdktXImkjd5AIKCL5TqNLTfjGmITobLDLUSCKE3+fcana1kOQ3D
 2HcCAw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6a849kbp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:41:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e56b2b350so146823785a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096889; x=1783701689; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OJfYBFEk6cqjY+BSEvPVamiQUgD1yf8uocYVw14otOc=;
 b=Gj3G2Cg+XkVx84w+ijHDW6LQsuAwrPzQYVQj4pbwAUvw1UmGQS3u9YvfsNF/jZOm7l
 RuVotE35q2pppe5KjduDwLZVS7Se0Df7hcjrdhieCvVTvPsCvYLy0JuFcPfEfE5gkjqR
 RxlTNPa+U32Xzhfyg560nhPDok4GweVBbHTC+3JRmQFVTiVPT9xjL5ERmm3jK+BF8QlA
 SfnAi3QH5KJxEXD2CNVihFADu0NAWJNHrYQI5XogZYhWMFSVzumPEptRfFeaOcMTrU2N
 E3ilrYk8f03bZpomqoHH47MXYrpVSDiqKzeiBHoFeEQhupUSrPvG5ACTPgY+vVTci32p
 9rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096889; x=1783701689;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OJfYBFEk6cqjY+BSEvPVamiQUgD1yf8uocYVw14otOc=;
 b=R0bJEhZ8rLKBoBteei5qPcfs4xX3oymSuXAk5Dg5V0lyikBrT0h5wUyCnf2ejOyIUm
 ZdE8WjVA/np6QsXchHq+7xNBomwWi9BtQKXG+IBcM0SgKvlv6zADxgoRXnFFf0Q3nP0o
 V2VfMCVWY82uNqNKE+Ch6Jd4jfeM/NTDLIwULiH3L3b0yy/gkN/aJuYPFXR6FKhpDUOb
 TgnsnB4HXMxN6VQJtXDIrTZaPCM7yycApDGixjtc8TuOrXT2IbcQnLtjRoPiRERUzvRn
 u1Eg+NCootvIwqeMpKiGZTyvzxszvsWC7oLPck9nO8kgoOWGxGFR6xuFU6T+FPP02QSF
 BufA==
X-Gm-Message-State: AOJu0Yytcu9P2O2I7D3GN2jLKoG+zt+lr2YhD4rQTkBs1UUqXZxidHHA
 LZHTUFIC8eqjmQzDz864uP8C4G7neseHeCvxifUW9uJLOGrsYojO+/dzdpDJ0jiq2hmKEL8aEHt
 meOW98f4zNgGCwcjmwms6fbyp+0Yx0HuI/pmhDWjhuEjQol2xki2SnSD4SOqxKJZGow==
X-Gm-Gg: AfdE7cku3jn2ucHlMW6ntN8Csh1qoNpClS+JzUCvjEciynwE6qAya3Fg163a9tHLXCh
 X0WG6mSSsX1p0n3kP3lnQSa9GCxQilS+vxd02pSbiSPT5IuvdZscGDhbD+iPRGPNQHo/AWNYSgM
 /ecwAXGS6VrN4c1uMZSM6wXDHlCq1pBkJYc3HXnpkOjQFjy/7JHbRzF2vjqFMT51SWmTcfouaDT
 K6XsaS0WlvQzELAkB/wFEyjKD1OvJzF6zuCXYZhiaibiwIQBFAk6p27RoMaZTxgNjVHeab9xWQk
 3ii7b4rA/70SdpXw0pRCDH0fVvMDz+rFZrl7xydjQ9kbKtkdeOEJJf03/h1tWe28RddSfszCifE
 3FeLVhAIlZiGBPXy7plbm8EaogATlhyhsxm2wgCueLGZ12OHtb7vnyVQpSBl5NEzzC0FP
X-Received: by 2002:a05:620a:4544:b0:92e:78cd:13f with SMTP id
 af79cd13be357-92e9a3addf4mr29241685a.33.1783096889024; 
 Fri, 03 Jul 2026 09:41:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4544:b0:92e:78cd:13f with SMTP id
 af79cd13be357-92e9a3addf4mr29235085a.33.1783096888453; 
 Fri, 03 Jul 2026 09:41:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63172fesm250059535e9.0.2026.07.03.09.41.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:41:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 28/33] accel/tcg: Improve docstrings around
 TCGCPUOps::*watchpoint* handlers
Date: Fri,  3 Jul 2026 18:37:51 +0200
Message-ID: <20260703163757.55500-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6d3nipZgUoRCXE6XeG8U_UjhIX6VDh_j
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX9QIjRvOWhNe+
 TRRPLIyGzTShT8PkKVIy2HhHQzXO1GpNF49zWGgz7TXhtBpDUYGuwE1EgpmVcOrmhcHFkhy84lL
 PPB2CDUhNJcKD/O/8oGBxZblZgY05lw=
X-Authority-Analysis: v=2.4 cv=a6QAM0SF c=1 sm=1 tr=0 ts=6a47e63a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=oIGtIzObNEvw8K7fi1sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX9T8bGnycEiFm
 bor02uZxy+BqIolPEueibd8GelNoa4AgLRs/zc9ZGu7gXPyV4ZcyR0uBwAMsKcx1ue9HJBPNFOb
 EhlMhFIw8P2oJZP4bxBklf7i1sD2gjlYAAEA3Wb08fQ5n791iX9qrO6SzFGEmbvFlOY9fMEAZtw
 4yiRxrVecmKr8/pUcDWlBTG9EGenTdnBt04UpYGdvsfgk3beFpggwaucovrrfhm6QQrKjc5rCmc
 QQUpcFEkyRzDpcw4Hkuq9D41hCrdcp6x95Rx5eku88+OOAL6Y83eBdFh4hxQIBIPBc9VXIM1Km8
 3DIvqINJuJ9RScFJiYoFxs6HrETuKupt9X4XslT9C+NVMlulN8n1+PTjFp/JsFy+YsSUqq43vK5
 D9eRZVbXqXoEyUx9kvAmns9nXA4A95iA0yZkbA38e4zcEnj019ZYWzr2zzrqletHfUAHBCN1oeh
 6BpQTq45x4F1Wyj/PhA==
X-Proofpoint-ORIG-GUID: 6d3nipZgUoRCXE6XeG8U_UjhIX6VDh_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
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

Commit d5ee641cfc5 ("target/ppc: Implement watchpoint debug facility
for v2.07S") also implemented TCGCPUOps::debug_check_watchpoint for
PPC: make the comment generic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index f64d94b2b50..568d82cdd32 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -250,14 +250,13 @@ struct TCGCPUOps {
                                            int mmu_idx, uintptr_t retaddr);
 
     /**
-     * @adjust_watchpoint_address: hack for cpu_check_watchpoint used by ARM
+     * @adjust_watchpoint_address: hack for cpu_check_watchpoint (used by ARM)
      */
     vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
 
     /**
      * @debug_check_watchpoint: return true if the architectural
-     * watchpoint whose address has matched should really fire, used by ARM
-     * and RISC-V
+     * watchpoint whose address has matched should really fire.
      */
     bool (*debug_check_watchpoint)(CPUState *cpu, CPUWatchpoint *wp);
 
-- 
2.53.0


