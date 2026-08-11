Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F20C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrJm-0007kg-1S; Tue, 11 Aug 2026 14:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrJQ-0007Ig-P4
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:34:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrJO-0002X5-B2
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:34:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGObgC1094508
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0idV0Y0FQ0rdA79Ll+RTIzajE1tmGZqrGlMbn9c++Vw=; b=Tz8u2WDkxr3uN8qi
 GOewG40Oie4BM6+9iR35R94uCboF6wDBSnuSWEgNXPufnIVQKs7VIlWCngHlw7Sn
 qkJMhwIWzEYDtpHXWnNmSFlD+52LHtguiZ6XCrs6J3ra2vVKSQQzsSTXpRTddr+F
 qOzqbc6gg54YpQmBG9TziC2Ztz7d4xuR0RYL1zCspg9PWwzqi2zY119SKilC1rsq
 i0HO6uXiFqd/niT1Kbfhv0mrgI9f+Sz6NYVrs8SK4TfhWqhlAZjJj1Wf4MTNgtux
 m4oo78gd6DktIPw0k/9W4t3lgU+/90XGdapiHwRauRR6OOgRwaEoWtbYz+42ZyLz
 ibf7lA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049gsj77-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:34:43 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f08560ea44so1248406d6.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786473283; x=1787078083; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0idV0Y0FQ0rdA79Ll+RTIzajE1tmGZqrGlMbn9c++Vw=;
 b=LXwkbEOrrIBBsSlJdwSKio1jYFR/RfQzP9w70xIQO17TJuPkjJvgT2JbvGp6ZbRYZK
 HmFRwlsWnJde7FdzP0N7HbfH3Dh7fkUHAPOoeyPcWYgzhweYoTVo9zjsDfgFqdthQdFI
 8ULCOMORI06yySJ6kxVpI0RCY7783T3mEUnxvKH6JXgJQ6RK13EKnunIWeB6ju0n3k3Y
 m4O7jmSJlPjjzm4uZiPbJczLfinBJUct3e5s6ECdwuIvtPy53Gpr7Oof8RU2qx0PDC4C
 UocxG4xTQ3cHFJ2xLMpZxJUDXj7cb/aCJDMD4oc4NNk65s8lEqsL8yvUnHLMQow9ZYZo
 c8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786473283; x=1787078083;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0idV0Y0FQ0rdA79Ll+RTIzajE1tmGZqrGlMbn9c++Vw=;
 b=nZds0pMPol1Om2HpQQMdxPM320hwBrQzzOgoHq7Vi6Zmb05L8f7EFoBaih1zct7QIq
 j03eRnRwk5Bv9mvlYYALnNH6V1uzficYh29rqG6d3vvdMxuHUEv+yE1/wKhukUkLWOgs
 bRCiI0VmoiovYV05RgOS1QVf4wth519FaXWhCwbk1rXsFnRy4G5ybp1NZckXxm0+l4s+
 jODBaB6j19LCV6geU/WJyvMAu0xF7FXPSy92kuFjNVKEkBmBweIUgULVLxM6A2U34wjp
 iN/2fluIbtLyr5ioXRPwswAi69pvRMjo438n9FasgTi/qpi1u2u7tbJwyuAtOGWP5QMO
 0D/Q==
X-Gm-Message-State: AOJu0YzSu2KllTachI7QsgBr3n2JoWvyF0xsuLi6/t1cqXhmHVr3qgmk
 E0fbUXdIW/1GKjPQpjvgxyG1XtCrZitQmgyB0AVDr0f7nWXAbQLJFXmgJME91yxt3B3li5xwl4c
 W/G9RtRWDRmjaFUOoHgV57ZFR/pbNyuDTk+unEr/7hvbvqwYv9t6OUAACIH6cmH39uw==
X-Gm-Gg: AR+sD12dyj2z+KXSSqPP/IdimTuJriTm+XsMahqKA5PY+MapDo8aYzpJ/ECjwcBWUzq
 +2S6/LbYDjR0WUCx6NMVPI8rMbiPHdHCYO3X51cnOaAgdhM4XB0oHY8r3k/NPsHcUb9xL38ryQO
 V3CM943CbtkLztjriC+sUNTQ1mCvJNBpNR6PDwqDtvH14IX8gn2yk76cb+T0+OM/4G1+0cnzkJf
 JFcEc5bk92Pg8k/AKM7e3OGFr6eQTf1//AizUamKZvol3Zp3EuC0b/tmPxZTwkdQ45e4RYapls3
 KcgBQRAYr9WRJ0c2ngpdxrnA7nUGrbt27YakOJajVPySLgXyBbUyrWEIG7dhl10PkP/4NMXY7P5
 haK+/I5aFbLZ+VdNSoPcC0Gt2g22X64mBb17q2MCH5w==
X-Received: by 2002:a05:622a:5517:b0:51b:f640:2a4f with SMTP id
 d75a77b69052e-52d584a8c47mr53649851cf.4.1786473282746; 
 Tue, 11 Aug 2026 11:34:42 -0700 (PDT)
X-Received: by 2002:a05:622a:5517:b0:51b:f640:2a4f with SMTP id
 d75a77b69052e-52d584a8c47mr53649221cf.4.1786473282237; 
 Tue, 11 Aug 2026 11:34:42 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5ecbasm299929f8f.28.2026.08.11.11.34.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 11:34:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 4/8] hw/cpu: Rename cpu_common_realizefn() ->
 cpu_exec_realize()
Date: Tue, 11 Aug 2026 20:34:06 +0200
Message-ID: <20260811183410.22428-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811183410.22428-1-philmd@oss.qualcomm.com>
References: <20260811183410.22428-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX6wBt5o3WVLX9
 3CPotTjukOMHsUJyaJOszseI23JoGsfQUPVnwLXGvqtmwkZV83Rsxt2dldJ6MnU31v5GzwJMwHW
 JDOlcRTI82dgKORZ8His3dj4Bf++pS8=
X-Proofpoint-ORIG-GUID: Dbk4Zd_VXCSSCAsGtGsHiH7CO4GhdNJ0
X-Proofpoint-GUID: Dbk4Zd_VXCSSCAsGtGsHiH7CO4GhdNJ0
X-Authority-Analysis: v=2.4 cv=cvarVV4i c=1 sm=1 tr=0 ts=6a7b6b43 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_LLhLsGey2oFb-bfptwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX79B6xSyn6uUf
 V+i5Scm7TAX9S5V3JuDQRduvGYhF+z7TNP8iXJZA83uHpT0bLfzJo+KlV9kPR6Z6+Hb4x4C/lpZ
 qdaiZ8dbeZTj6kHyrDmdFaWr6CMM4rGTEl5nLTNWdmg3oKMn57lzTUtuQBkuHhhuzDP2EPIsaL/
 Y1q0ENbEP/mJFCxKUcVYEKeIB47q6IC4Y4Ix/wTH+fA67nUWTul/oTiyQwIeL0DCoPfFvKyjp4S
 Gs7Awm5GtfrAptPeNeH3Oj4i366KhqnDIVVwjySgKMHgzK9D3w/kJBK48PR5cecex26oSquAyH/
 vzJo14d6r2WRqeOq8/6E2lPOeVqpFMrc0UUAp5OwlB49GeKnkWE3Sq6TSC8tH4QFAXM/16PdgIZ
 LfD0tROAiwqbT59dJzwMAnb3T544lWF1EH1PHsjqKFrWykWbEB4TJ/ES7cITTDZbLYGVxSQCiEB
 Q7D83wpyLkFYmL6NtSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155
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

Keep cpu_common_*() pattern for publicly exposed common methods
used by target code. Use cpu_exec_*() pattern for internal ones,
mostly to distinct between system / user mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/cpu-common.c      | 4 ++--
 target/i386/kvm/kvm-cpu.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 17d76580930..33e349d4402 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -246,7 +246,7 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
     return true;
 }
 
-static void cpu_common_realizefn(DeviceState *dev, Error **errp)
+static void cpu_exec_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
     Object *machine = qdev_get_machine();
@@ -379,7 +379,7 @@ static void cpu_common_class_init(ObjectClass *klass, const void *data)
     k->gdb_read_register = cpu_common_gdb_read_register;
     k->gdb_write_register = cpu_common_gdb_write_register;
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
-    dc->realize = cpu_common_realizefn;
+    dc->realize = cpu_exec_realize;
     dc->unrealize = cpu_common_unrealizefn;
     rc->phases.hold = cpu_common_reset_hold;
     rc->phases.exit = cpu_common_reset_exit;
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index c34d9f15c7e..e164cef2036 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -63,7 +63,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      *          host_cpu_realizefn()
      *          kvm_set_guest_phys_bits()
      *   check/update ucode_rev, phys_bits, guest_phys_bits, mwait
-     *   cpu_common_realizefn() (via xcc->parent_realize)
+     *   cpu_exec_realize() (via xcc->parent_realize)
      */
     if (xcc->max_features) {
         if (enable_cpu_pm) {
-- 
2.53.0


