Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B4AC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySis-0007ol-Fd; Mon, 24 Aug 2026 07:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySie-0007Za-Re
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:20:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySid-0006DK-9n
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:20:00 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99CdB2082997
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J2rUL5dnRfopAxRp6y8OcNqck/aSQMf0xVr1iUn+iFc=; b=bDe6C4ePFwR41eEm
 pDTm55KAgANfLUXKPDOe1fxBTHtMePbdIWSrJ3PTB9OZ1PB5x72jiC5/wZSmvmH3
 /WNkMrBW6zA6/s9O1hqEtfPoM8qFVOvrMQw+5ynR8NQd5alHO6S+2jrhwPg3lmu1
 2SwFNvGVIeel+TICBX63wdfelV9pt5YMUJmQkXA05rfQ+t/S6iJpdiA/1nbD1uJR
 UrmXizRbO3HcU6beT3feDcbyPBICFlogdpvT9jljwlgTDPZ4Ir3zuCzpOUmjJ2b0
 VUhBB66WFrcLp5si+I6wHFuujkRD18FGgmoAR3+FG7eBgTus+HPaHr4AYm0VlzDJ
 BClVjg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hbth0fd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:19:47 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-73760a7cd83so3255275137.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570387; x=1788175187; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J2rUL5dnRfopAxRp6y8OcNqck/aSQMf0xVr1iUn+iFc=;
 b=FAjcxkeYhGTzVK+SgOKEnFIOCahoNzGpG/2uLOcK6rTAc8ZS+8jqANnoV7mk5XXIVj
 xgTl39+v3rFuK2hMr/tYeHTRK07AHoEACFMuS64mnopcKRINyRR7Dh7phERIfPmngK7r
 e0aPrJXvK/MZeD/Bj4+9Cza+vDfCb+kqbCQn2zE5wymoxFEerZhr4GYdWZJWrWW4YCNr
 vbrfTm0vLER7Vr+E7fbDCxdjVd6VwhXbQGB6ZUWoCoqnlhPAFa7okXZBtKHAq6zQvsHf
 heWSRJaVVjvOeNmS65WHiiSHPZyr+AVM47MucZakyUN8BX3AVlFKha/tvgFlJgNcCVCD
 hJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570387; x=1788175187;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J2rUL5dnRfopAxRp6y8OcNqck/aSQMf0xVr1iUn+iFc=;
 b=Z1L5Wn2pzUO63ybP2EP4zNUeHQmYcpdIpkDtmWw7EgDypSV0GshdAU+FZQ6H4GaXee
 rhKCEk9NSyQ57uGOZ02kz13GDor5BtHWf2DWmqa9ysfjWwpC9KKrdTXcfrDRyGEvBGmE
 KbIJTBOgtEk1kQrgCltaW7xHNZwoGGMUhZfbfEeV6icDCUeC9nOeMDcVuQC78RA7lI5I
 lvunJEvBoO6x0TMsJNmJN/G8iWPgsWkRexwx+rsGdRA0oXfypZKrIBSYJdwUe1PPJXZs
 JCAl/HxW/739X22In1vlNpyPwIbozXa3A+uoEKTq55CbFbK5CaRFKv3LuE0dEieD6kGJ
 4Wgw==
X-Gm-Message-State: AFuF++k1dqalhMT2PSvjNdfZ52psLN0KgHIj6mS94GCVQQwS6nXJF88R
 HJJGkLRoErLzRuw2JcctZgQt4prOWB6RK9NZGVoc8L7br5lbjrpHL0oNJSsYY51dk9zFVVd0ibl
 fINPm2YB8Le38TQjuwKX1bU8osi1QcM1lx7i7LCVZBupzNawBoIf+CzcnSwKNRzyAwQ==
X-Gm-Gg: AR+sD10x4xLr/n06sTU7k8Nw7ddU5T/VVo8mrVvhn3kVZFwhpY89V16I5afjtttPEe6
 vlZSn/o/fRJemXttrODuKsaBjLT2l1porNIHLmUfFl2FWSJTL1vJGNhWVbIDDDBo0cpWZGsxjn4
 KYShuogbt4U+wPEnJ53ikUEs3MlhzTdqRacmrjvFA+ALnt3VA78GFiWyHSHZi8ZgSyY8oGRamId
 udF/YNqn8xoaye+RBFPe7RX4GlqQg3CnjFYdOgkJ+Jv4piXr87H0Z+tUJrGsUhqQP4ZpjjyjuWz
 kvZKhtxN3KbZIiB8GltmpF8/sw4gzThc9x3v0senZFdZ40f9+PPKOXPK+wZc524wlgOb2Vdj7uR
 PvmgUCc5yGh9aUfCLyXGSFmQcI2pYY3+WM8X+7V6ijwrwZ73FPQ==
X-Received: by 2002:a05:6102:570f:b0:77e:eeab:769 with SMTP id
 ada2fe7eead31-77eeeab1417mr1194118137.10.1787570386767; 
 Mon, 24 Aug 2026 04:19:46 -0700 (PDT)
X-Received: by 2002:a05:6102:570f:b0:77e:eeab:769 with SMTP id
 ada2fe7eead31-77eeeab1417mr1194090137.10.1787570386397; 
 Mon, 24 Aug 2026 04:19:46 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e00129fsm9817576a12.1.2026.08.24.04.19.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:19:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v4 14/20] target/riscv: Constify @iprio argument in
 riscv_cpu_pending_to_irq()
Date: Mon, 24 Aug 2026 13:17:03 +0200
Message-ID: <20260824111711.26297-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfXwT1c/yzC1PKI
 OuVMVSFJF28UXZzKkQjogQN55ouOYa1tbcg4DgA1mT48HidRvpqAo0C2e7Xelm8X0/8taaKNRLJ
 LBhURLeIegkBHSKsTon6piWKZ76jMowGfRrzLm1K2niIRKSnROlBm6nT2ttiq17q+L1ei6QBiVY
 eqj7DiNp+uJsEtabt1v6HiM+UsfsISnpblawm49myDk89xB5GC+GKJy/O5t0VmK77zW2hgqbytJ
 UVjae3enKQz0LCwesKKlZFqFjNe7ogfzTYwH2lK3+7GwLg+wRL97YP/FAL4MHhDgq/nHHh62Wg4
 +4dtYD1Hmu/qygYrADxFfMCceyTBHX7yBvfeWdkAexMUlAGp4y9VvgYYm7pePae04Ede2cWijrY
 VEYhwRQd1NKWtnBSdwAngcUZb6EpXVVx50VVkMx+lj0jkPJep6nS+qfOaAMVt6hJX6Tph4ylQoj
 ta2kBCj9qUr3cb0lc9Q==
X-Authority-Analysis: v=2.4 cv=JL0LdcKb c=1 sm=1 tr=0 ts=6a8c28d3 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX+buiMMI9CRwh
 AvDD50pMUkB9/P2/HUUOXnby8QM5l0Se1qJ+Raf9JN9sZ8fzk/xsTUF6mKBa8xM97+iuyxoFhIj
 1kH9Woj3Lz8vwMt53+dpGs/b1Wf7XI0=
X-Proofpoint-GUID: 9_mWMub8f0Ja3KHCFkeFsetEDHESdqB4
X-Proofpoint-ORIG-GUID: 9_mWMub8f0Ja3KHCFkeFsetEDHESdqB4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240094
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

@iprio[] is an array only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 376cff656fa..bb4c8563554 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -642,7 +642,7 @@ int riscv_cpu_sirq_pending(CPURISCVState *env);
 int riscv_cpu_vsirq_pending(CPURISCVState *env);
 int riscv_cpu_pending_to_irq(CPURISCVState *env,
                              int extirq, unsigned int extirq_def_prio,
-                             uint64_t pending, uint8_t *iprio);
+                             uint64_t pending, const uint8_t *iprio);
 
 
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7bf098319f8..858fbf865fd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -866,7 +866,7 @@ uint8_t riscv_cpu_default_priority(int irq)
 
 int riscv_cpu_pending_to_irq(CPURISCVState *env,
                              int extirq, unsigned int extirq_def_prio,
-                             uint64_t pending, uint8_t *iprio)
+                             uint64_t pending, const uint8_t *iprio)
 {
     int irq, best_irq = RISCV_EXCP_NONE;
     unsigned int prio, best_prio = UINT_MAX;
-- 
2.53.0


