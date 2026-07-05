Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17F5C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUui-0005Cu-7b; Sun, 05 Jul 2026 18:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUtx-0003yd-QL
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:01:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUtu-00016F-Rt
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:01:25 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665M0Gx12831793
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 22:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OJfYBFEk6cqjY+BSEvPVamiQUgD1yf8uocYVw14otOc=; b=HHfyc/bg+3/l3mYf
 dXgP0h2dXj3w/qujNr/Acaw6CgrlYKhR/6ONfGR3HBe8wx27JRchoO8Erq9ZZHNI
 PTwkyPEsg6LTmvoLCjX0AC2xk5IcdnUBVxWej8Sc4bMIHPlitF+EUf5dys3FMLTM
 5UBQ/egfJnupYmgrsBFesJ2xxu2AoIF6+D3bLnarWRajks2Is7KOlmB83PWNFxcl
 Tgly339/YNrZ+w1qfdG2wKWso8KjoUFnDdylGGq53F+jzzt+HjKS1RFwtbekARF/
 7APBHC+XN6NN4Ahx5fgTQq0OwZuTTD9wXfp8eJm9q990TGeyo4zKf8OE5yeHYeBf
 JsDMkA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6t8ukgc9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:01:11 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5bdaa7039d7so3323799e0c.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 15:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288871; x=1783893671; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OJfYBFEk6cqjY+BSEvPVamiQUgD1yf8uocYVw14otOc=;
 b=eAJX8CXz2lViHKS8u1aCCAJVqNWRlcBu2M0gV0wBTFByani4Y+SOGLrdXp9NHB0HML
 tSQz98gsVAXanMQv2VIN5ZHfcmmm5ykmBTHdCvD3SGya1kFTyTFDNw4mgL6duIO0lH5D
 UrHG6k5VpedVB7Y1Fyxvx1i7fk5CVt9gonMhUbfNyz5V9QpNp0PfJ1N2xNJMQ8qn58vE
 OvPmPCq7f29bKXDzfapqD5el1j9I3ypfJu0Ime3gUMeJADnY6V/EYUzJ10pMgyftXZfK
 xr+ZmOIzpptosCsVyah4LBjUpDkzmNqGT6quAwLJkZ0mjb6Ff/n3fNAqrFD9W0zqMs43
 A2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288871; x=1783893671;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OJfYBFEk6cqjY+BSEvPVamiQUgD1yf8uocYVw14otOc=;
 b=qR9vyg9l8uPG2nnoueh09BPJTOD5fr4pf6ut+M7UWTZKRueruGCZY20iEOpD92kUTV
 8AijOVTlxtf+P5oCuzgfltLrUm7lFboUqblMEKjKRnX4RD+FSdqwcuCEBnS3dXrfQmRv
 B9hrHENK/U7G8ytcZeyUWfZkyfrWoLk1tWQl2NBWCQPEKWFwsbwyNGC3rsvh3qzPQJT9
 tH+hUKlKI4YWOXbjPP8jD8GJhONihekEFN+FqzeuE0Z1ri7kWljCARtKHxwHzUV4wzsR
 fcP4HavrrO39oKJs33yCVBoyLb7rTr1hZAAE4U7J1KfNB/khK3SLcijcz7SJeFdyQoLO
 cl5Q==
X-Gm-Message-State: AOJu0Yz8AZwyY5ospf3oza+21fQK0eoepWSUcL2h4MddLOEm1G4TD3ax
 9lnMchxEpmcAeBPfj2aS8vYzPOD8kFuimuRDcmKVDqwtS/Dpo0PVwjY3uIzewJmGFbtM59du6Nn
 Pr4rpNOo2IQhzr5fRmygXI+rUvvePIFaKLwRMKEhBsFad3ltkZXemzpHu5Q6sNhH+HA==
X-Gm-Gg: AfdE7clHh3iUq5c312ivv+6qnXll3IxOLtdQCVwQUy7LTPbU9YhWy905rYO47QBvCEk
 SAXbJTiXw0oacXucf+TPTCpt5cV4tE0TqGzai7cIzdVDF2KudRCbUfit2pmndhjy6cgdvaDMDPf
 PMLcGzThI5IYq/wn3+mmvPSw+z9CcmtIuLYo7bSeJtA94DOZtgu9TzntWfSEb8hBvxsy6soMarT
 +WwGZ6LkiZQf3LrVeGVnPRRywLgZt901bld3AEECodaOCcSmJKXhgH5RgHyey/ym2qs8Srfhv6z
 8HePf6803LJjg+WR03yovpGcpZ2P1mF5KevpD/qasGUpcd4U+yY9QEnt2AKK7RfIq8JUjHkjY+u
 NRRMibV/8wcF0vF51qCdUPRE1p4h7i3pj1hBGjMsUx5p5JdPGNL5EBHXyEjoX1I5pq857
X-Received: by 2002:a05:6122:4890:b0:5bc:58d:ce4 with SMTP id
 71dfb90a1353d-5be0fed311cmr3078181e0c.0.1783288868601; 
 Sun, 05 Jul 2026 15:01:08 -0700 (PDT)
X-Received: by 2002:a05:6122:4890:b0:5bc:58d:ce4 with SMTP id
 71dfb90a1353d-5be0fed311cmr3078110e0c.0.1783288868029; 
 Sun, 05 Jul 2026 15:01:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d91bsm22561547f8f.4.2026.07.05.15.01.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 15:01:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 28/32] accel/tcg: Improve docstrings around
 TCGCPUOps::*watchpoint* handlers
Date: Sun,  5 Jul 2026 23:57:24 +0200
Message-ID: <20260705215729.62196-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: juGxcfV1beW4JLyoK9uVdzFsSxNZcmMm
X-Proofpoint-GUID: juGxcfV1beW4JLyoK9uVdzFsSxNZcmMm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfXxjjJa4m4CDev
 2uWoeQRx7orFHwZsJzX5zbeX/UIdyMzeXhMQb8hRdgp18bHFL7GtSzidwCPRmTNf305G4WlIm91
 VWJB3J/gUi10g9ckj3Q2Mp2MZnDU/+E=
X-Authority-Analysis: v=2.4 cv=MZxcfZ/f c=1 sm=1 tr=0 ts=6a4ad427 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=oIGtIzObNEvw8K7fi1sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfXxm2+Uf1lrpDL
 +3Iq4JtgqAM394Bsi4XEVV7CPjQ13/1pTR/Ct0MpzPAq3XmSpEZTUWkmMzAzr/I5/tUDqe/yGON
 az62AB1cq6UhDzR3m/e/WJN8Wh0sLGyq1Vd1tBCj4nhDEIrOF6Kdd/dN9d2g4V7ITBw3+ipydEL
 sWt/xzVpXKCHYpxNqySUF8vb/zE8996H9rJ9v3ks4Dkr8yY3FxA274kfDNReU5qEirkkpEQBwdW
 nqj45zIc5TzgfdttT0GpKtdy8iB3NCEarQHbdKsWCEkl0O4R6YnZL2zo/AZyp9EHN0YkCFTJslz
 7HXeysubVm5Y+OoAwXwbx56Ai45/5RseJbAPa+ICrv8EWObZPnxRw/08h7iG2BMn/Ol7dO9SCzX
 hbuEAI3F/MLdWOkg2iRhR7WYDYjn1BpbgPRaEePGqw4XkkW3CK26SrudTuE2YSi/RMIyv+geyGr
 BB3mC4GrO1nZItdntow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
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


