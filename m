Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026D3C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHqS-0003Fv-27; Thu, 02 Jul 2026 09:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHqN-00039d-L5
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHqL-0008Gx-8k
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:43 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D10Bu407398
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8QFb68tx3dy
 EOm7tiIaGTUBW5sTnQl5Pov2SskUA4+o=; b=KukNCspXE/6D2Xdx4t3K3JH8B/t
 QXECkXxElC1qYSxst1KIK/w9xHWxS/NRZx6A/VOxnM1qbLN4jd8jB/covlM2usdS
 bD2S/F/qt/+9HqNXhUBiPrmRYm+RqtS8FatI/XpVdOXDB+syDg3L8Cp9KXPRp085
 8seVhAqXPS/NqldbyeUBzRqYMSjQKPo6wW5JlvC5/FYjnH6OiMgM4d4t3s4p1ILJ
 Z9s5se7/aMc5vRwWE0KaVr7sedihK/XCQ50lQo8dS3hsGBuKtnRo1NkmmiiwexIs
 j30WbI7+A7soFtpKBdLcDdv/LbY/rMBtt0I6qwhA025m/FzDAsJn/PQs43Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98j12t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:52:29 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-73858d44c8aso406160137.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000348; x=1783605148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QFb68tx3dyEOm7tiIaGTUBW5sTnQl5Pov2SskUA4+o=;
 b=Fsqhx2l5CPZSkLC7T2+f0xNXNUu9JIPEubWBidMy4Yw+RUQoEF42ulosWhi4m4o9YL
 287sVOBo2kXpssijRUQbBx4x5PnP5L5sAfFXr8vFyjnqMq36ViiGdqPGeIiAPjl1WHgw
 PTu16WaY+CAjSMpDWokRqEq4QXAN6ivyfqtngmo03lQ3bfAM56KIXvyMov5+n2iOHQFx
 PELYrlDyzx8+GvlffC0sbJ3b2L/sKbr7hJ4Tm0YdPVrBbxtY33cC7AIE2c7YrFz4OQhM
 7vBj+/mT/p/YNUk/MUeFNq4rO5yqC8lJZOlvuodNQA82Sij/j4SLF9dQETuQoJFsCzvO
 Sjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000348; x=1783605148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8QFb68tx3dyEOm7tiIaGTUBW5sTnQl5Pov2SskUA4+o=;
 b=CdBpPg96jxS3ERNBLncJDs55nvHSrZw4villWGcpdqtKLU/jnTOHKSXrHmGXVq/wAj
 Xtp4eZvFKC9zrg00J8Tv2wRloUcb+n4UJ/sSvQp/MOTjm6VlMnacEwBYzlIJr7bQFTYN
 Aa+3IUwwX0iQtrRvRD5imA1qXDZnfOdXLjUvuBUqYxYBHngEuBvDer2dHxlgHoJ88nKW
 UX8btHppoVI7iHiju7GgVpo9M8Kvt1C72MxbvquXusTsPW/EfJs79gdqESypPETqfI0b
 iU4M2WgMPMl2Bvqc8UDLmLulAAqZ43gtuUeoChk9kSZ6HztV+hdO5QFDJI0vIAXaEACK
 9H6g==
X-Gm-Message-State: AOJu0Yy/rf0Vv/PWmVtErsJMkstdmOst+Zb0cdZAuge51ddWDJc90dSU
 0aHy/21RxJLSgwEwVNTedPZDq5O8X3mq0bJ5Iz4fXKS8AtFc4f8Q2rRsM0OkiKV/JlRflUWVoK/
 2VmmdYoK5mwS1nEVcczpOp4uWwGWvj+DhOPD46DRK+wPo4fA8EuEzUBQA1hbyJyjkXQ==
X-Gm-Gg: AfdE7cmBsX5x2PpvhTUmjpV9yXaRpMLLZBrOXSDoeRJjyUbYcJ88BBVGtclNPDQCzHM
 7VvECR5FexGaQylN/KQ6+pEkzHCC2d8q1Q7NwzV2MGEhwwZvCV8RDcwQdmskZcr38Yf+pvx8oxW
 rmPKok7phy026EuibFYR7jnCpUqHzUKGIs/HIOPRZFTZQn5dXY6mFrETPf6IeCtqPQil0Fr8vzM
 wTaw/xLLneb8fjX1A3uTfH8/8KKhWnpBdJq/oJgeni7dpeATWP1oH4xxRTRaFNqAuZFchDSNgGt
 wQ4L+SSFuUP8g06YY9aKeX+T0kb2s+k2G5JTJZ3mIm1/2zdRJMzGzfWxZETP8HZ26ShrJVVJWf7
 5670FZDICvXszwH73B6UkyYDQ+TmhryKGPxarQfQLyNbJ8w==
X-Received: by 2002:a05:6102:80aa:b0:739:d787:be8 with SMTP id
 ada2fe7eead31-73da7bd49femr2752494137.9.1783000348477; 
 Thu, 02 Jul 2026 06:52:28 -0700 (PDT)
X-Received: by 2002:a05:6102:80aa:b0:739:d787:be8 with SMTP id
 ada2fe7eead31-73da7bd49femr2752477137.9.1783000348007; 
 Thu, 02 Jul 2026 06:52:28 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:52:27 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 21/24] target/riscv/tcg: remove unused
 riscv_cpu_get_geilen()
Date: Thu,  2 Jul 2026 10:51:23 -0300
Message-ID: <20260702135128.1188021-22-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Q0YQo2EJaM6i-51u_e_JuObb1ELlxyv9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX28OF05FN2RD5
 t/zNSTg69d0yFfsIFKUZGhUUm4WXPb4u4F3YBAPYRkzz/Dss8KHGeseHmduiZYHVHt7pC6GDWFZ
 Gm6d9cmCcUGq6AAUwKG3AjRtEjXwHxfgdbfH5z99HmEHq3EGmsSUjdDAXVzOPyBtW7gp/MKU25P
 Fo9K3FXhZoXfNane5u7dTVGtp6bL9qnJRUWAo1x3abb7BcCn3WY3xV44qTNHnBssGxNcE3wudZ0
 IRqZEHDkONlrB51GA1lWfT4HgtRLzh6qUPyRqEo9Lfbo6lYfZVp2RSJ6CKHno299ygARt1lNB7L
 h78v28kE+Spc1FKQ/xFe1OrowKJ/W6pVfZvRvjWY37+WAuhGBQEyTdxu4wZH5nB/1CFs5NzZKz3
 bOakZ2ytD+TQhFT/WAXBUrV5u/DnB6Q2v97qyFJw+neM4sesXFN7UGj8INCcGlhHMwlH64tHGzg
 zFQYNsxTceR+celv0fQ==
X-Proofpoint-GUID: Q0YQo2EJaM6i-51u_e_JuObb1ELlxyv9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX8jg05vUnfm3I
 B0RHqn3foSdrJI2mPlY9Qdx2JSI2YRYchjJfSjZPOUNZAQ3D7Zia3rglCbL6ux86B0h9qWo+vo0
 15GHKHrNfvtPVK/vo3OSCc1rj0fV6cg=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a466d1d cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=RAzYwbtmKzlmVY_wXjwA:9 a=gYDTvv6II1OnSo0itH1n:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

No one uses it.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h            | 1 -
 target/riscv/tcg/cpu_helper.c | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d6c5d6c1db..7618110412 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -646,7 +646,6 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
 
 
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
-uint8_t riscv_cpu_get_geilen(CPURISCVState *env);
 void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 7a1ea53ae7..6b39152ee2 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -526,15 +526,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
 }
 
-uint8_t riscv_cpu_get_geilen(CPURISCVState *env)
-{
-    if (!riscv_has_ext(env, RVH)) {
-        return 0;
-    }
-
-    return env->geilen;
-}
-
 void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
 {
     if (!riscv_has_ext(env, RVH)) {
-- 
2.43.0


