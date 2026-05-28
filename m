Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD64CCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wST8l-0002mj-OI; Thu, 28 May 2026 01:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7k-0001te-S2
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7g-0003oR-FF
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:40 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKleOX124445
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=r6Q9uqmouqU
 0KUQoADLBFN1QJBO+6mV0Bq/R1Vjkl9s=; b=GPJEk3EZDZhf4wSsETYxwDY4fiV
 H4ZrlmhvgFOMOYc3Z6p5H0HqeVkDg1gUKVZX38NjyO3jPUHrxyqxKyKG9dSXw4GH
 iCQrYXaqzILxiA8+cUuQwxEjUaiCJcc3mM4vcduSTT3KNzlQGuqaX+1zM/4xg8lB
 iMyqlU0QHjC2b3SB0zYf6X04jOFRSfD8dxd5kmeCucSrRmNppe2y7raaUESmXl2M
 sL7kRlbMCckbYPptA9furejhkc7tc8ob7mz4dCgYFY+L7I2QWS4K2TgdXIIkpajb
 6uWJBXVq77yUYg4sWuiMj3hHyEQpFDq7of0Rlz6NTUhCVRiNWHbHd1h3srw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yahd9f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304d8613efbso247586eec.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779945444; x=1780550244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6Q9uqmouqU0KUQoADLBFN1QJBO+6mV0Bq/R1Vjkl9s=;
 b=cnK61sofQM1CbeW/uicOhcESK6vpR+h5NL/72nRzVcNNH3qCKt/RCQPVGiSXnHH84X
 CK6xfpM7pWNfk0k+M3mkQbNb2l0to4eWrzI+yIueCckCHJs4/wgEMCi3THLPXOy54P4r
 E675dpyJvIDvFClSjvaT/6Zr5DOP2EfofwYN5nWqI6LbeoFab04nfra2TA1XMshNBTXm
 JOgdLyWARM94T7cKr+GOpWCGaJJEOGQX7m5z3Ui401jhqwCq8EoLpM6sNirzN2xJz0Z/
 wPPmAWxBT0pXzOHE1gPFDnRGi9KEZ/UcO2b1v8esusQqYBNIvGVyfR113oR3iUWmJLF4
 uAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779945444; x=1780550244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r6Q9uqmouqU0KUQoADLBFN1QJBO+6mV0Bq/R1Vjkl9s=;
 b=N+GrDiOfaMSWSWjYdupf1UauwIGK7D3G8El2T/xniD9uBLzOMGDOdXsNFwtfJZZDFY
 EZwMKcpgQ7rDUf4Uok7Ykyq9w4YhcI4MMmb6pzhxknKT4hUVx1AqOBxUSoL3u35qQDc6
 48eiN0LOlREYseneDLaOkVcL1jgNcHeLxHRIsiCCbDPDr6YCfBulqufdF9tuYYGq4SJY
 H6bEHMgcfnsX4mfmZJkoJYQLjsjElMuesHV3ohTBrU2ObbLUUN914CQQ9JIpscH6PbGC
 CIcTUc7HlS0NnPP6lV7LSERuTKv9cih8+njj81Yst7lednzSOuW7uv/uWJsWN842hdTg
 L+3Q==
X-Gm-Message-State: AOJu0YxCfwQlVnL/vYmBnlTZZSgvZWTWLEbT2iD91YX5aOg0GEoJa7jo
 hsX9hOTd+ioZCB/BXm9hyR1d+IZMB/AdXD33m1diSEEIEq4bqVA626bSQauG1Rqm5A7eVQTfxmN
 oxgVWkRuK4yHJKLqB+enY4hkZopCili4Hxqt5cAnzLEnmi3rdWttDJXMowg4fA2D7RcyJ
X-Gm-Gg: Acq92OG7/otfKn2+wF5ZwYVgXsgcGE9QguOvL6ZGut0P6IXqUi6zJwQwjt7onqP8fyi
 Fj/CsrNlnIIzWAowNM8UJb2Rtu0WDsJKOrr7hatTFVNjWDFX2gWOg92kKZLrnOgsaCl38V7c04M
 cTySqmKjoR5lkGfh+FO7O0OsbBBlna9pusQs+LVorPxY/n/2GCzpt4i+MraDgj4ldrQKtGTYKjx
 IKRnZk8mTvVgYVrV9wWTYb+x/P7if6+dFAyMFDZr2V8OfUo2Jh68kpWANV+/W+G5geM2xioP7ld
 C5aY7XEfZ5Xr+FrOrjVERi3a2clV7MEC7wnrqwVHJqLhbd1lEPYFggiUBK2UZ624223jpfan370
 JpDqqgk70eAFlI+g4ojssCvRTWompuAZ+a8Wq9BpoGst92J2ldkFFcrM3uaTjR245O34vmWXXy2
 AmaOYZgWGdqLSMghjn
X-Received: by 2002:a05:7300:8b14:b0:304:8361:a87e with SMTP id
 5a478bee46e88-3048361afcdmr7602076eec.33.1779945444236; 
 Wed, 27 May 2026 22:17:24 -0700 (PDT)
X-Received: by 2002:a05:7300:8b14:b0:304:8361:a87e with SMTP id
 5a478bee46e88-3048361afcdmr7602055eec.33.1779945443698; 
 Wed, 27 May 2026 22:17:23 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304b984d9b5sm4094607eec.7.2026.05.27.22.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:17:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Rolnik <mrolnik@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Xu <peterx@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 09/10] target/microblaze: rename helper unaligned_access to
 microblaze_unaligned_access
Date: Thu, 28 May 2026 05:16:41 +0000
Message-ID: <20260528051642.115721-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QJu2flgmBpqAEDPa0G9BtELZwq2UaQG2
X-Proofpoint-GUID: QJu2flgmBpqAEDPa0G9BtELZwq2UaQG2
X-Authority-Analysis: v=2.4 cv=E/r9Y6dl c=1 sm=1 tr=0 ts=6a17cfe4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=NETCEBYecQgaRV2tlM8A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA0OSBTYWx0ZWRfX+n3SkofMpwVw
 XUs7QEM+m3jCdDoz779eY5p7qTNChUPzw8EA+oOklElpQbaZmCLbojoOe3nU+t2i9YHqRchKXmu
 BJ/DiSG5Qz4sVYevqfeCQGYTwwIh1vWS3XoBtNTmUea3Lk+F9ilcdFQ422kKu9Z2RLktJKUtPjs
 2VyY+aV7tgMVKp8210HnY7cZaVsViUCZ4h3TSeY85sFIol50BsvvniFOu5TPxHp7kCkCInw1N9C
 8m6IlL7JK9nd5bK9x9T7H3F9wS8DcpGJDpdW6+KPYsVltzz8E/sk9BLdO/9Hd0BJEOd0m59j7NI
 QiDX9HptWMsPfjj07feTEWv4jn1a7FKHLyKfFjX5UQZY8C6Xn/8RmEtdpO/gMtkBkbOTTp/Dn6K
 r1d+0J2GigT8bNZ2MgWituTTPCysqfWMhZiwle2FvA0h8syCTOSqAxasWIK6wvuU9iULBTGxtaU
 WvTymDd1QNM+RJJdP3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280049
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Solves conflict with aarch64 unaligned_access.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/microblaze/helper.c    | 2 +-
 target/microblaze/helper.h    | 2 +-
 target/microblaze/translate.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index f81c4f625b5..3434ea47e8c 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -69,7 +69,7 @@ void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 
 #ifndef CONFIG_USER_ONLY
 
-void HELPER(unaligned_access)(CPUMBState *env, uint64_t addr)
+void HELPER(microblaze_unaligned_access)(CPUMBState *env, uint64_t addr)
 {
     mb_unaligned_access_internal(env_cpu(env), addr, GETPC());
 }
diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 01eba592b26..1429c1727ef 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -27,7 +27,7 @@ DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
-DEF_HELPER_FLAGS_2(unaligned_access, TCG_CALL_NO_WG, noreturn, env, i64)
+DEF_HELPER_FLAGS_2(microblaze_unaligned_access, TCG_CALL_NO_WG, noreturn, env, i64)
 DEF_HELPER_FLAGS_2(lbuea, TCG_CALL_NO_WG, i32, env, i64)
 DEF_HELPER_FLAGS_2(lhuea_be, TCG_CALL_NO_WG, i32, env, i64)
 DEF_HELPER_FLAGS_2(lhuea_le, TCG_CALL_NO_WG, i32, env, i64)
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 74b5420ed24..a93f14d6e09 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -692,7 +692,7 @@ static void gen_alignment_check_ea(DisasContext *dc, TCGv_i64 ea, int rb,
         record_unaligned_ess(dc, rd, size, store);
 
         tcg_gen_brcondi_i64(TCG_COND_TSTEQ, ea, (1 << size) - 1, over);
-        gen_helper_unaligned_access(tcg_env, ea);
+        gen_helper_microblaze_unaligned_access(tcg_env, ea);
         gen_set_label(over);
     }
 }
-- 
2.47.3


