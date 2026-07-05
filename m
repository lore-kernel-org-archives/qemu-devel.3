Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9906BC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUrV-0006Hb-FG; Sun, 05 Jul 2026 17:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUrT-0006BM-RS
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUrS-000098-2v
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:51 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665HigXs2326959
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sCNdzsLH3Q0jMX4rCMKs72ytygkMCsUMvV9SlnS9aVI=; b=jeOb0nJJnNPAl1/0
 eCpBRvw9KHm7r1ZXBaIs9pm2XPmYG3oXmd7PRJvZzVSqp8LA46BlfP9N+TKQ4IlX
 HTgNL/qSV88ig3Wn3EFFcm7tMiJtE0Cd0VWOsfJeGLOtPlvNRo8NFjc6+z6Z1jmI
 8D6oMr68tfVShOXNnB50ukc0g0RAdx2dBn9m9j3XBUulSssjH50Lwre1LlpPRPGG
 0y52KqIiNsOunCpRK65C3oL6+YnAJJ+qYKEtz6sw7nZYTItBIl+bXQwRWM4ulvkQ
 Jf+/HxwIEgB4qlQLKiTsZJlmrnaQ8+7j2aZekPYyidCMUmQ8xhDUaq3tGfRSNyb/
 TFuOlw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgutrb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:58:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ea24a2db9so123787185a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288728; x=1783893528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sCNdzsLH3Q0jMX4rCMKs72ytygkMCsUMvV9SlnS9aVI=;
 b=ALw0wuk7M37nzCAS4cVh7dIczs9guhqU9Tc3SIs9HHQged9DTLkFjbqLE8vwvTHboG
 9SQLWidFGkh3v5Kjy2JX6SbhjJYtyI89FWvopzy25n7Pi27mojU2xgrM3tBPxomrZi+c
 xbcdDHgWS5KnR107u9cmQHVpE20XUA4Zl6MEntLGLQH25JGbIv5hTWotsdrbv51w/a5s
 9vCMFgVoviX7z35rJ4OyUrMJmwL8bqqhrLviXYEnATeqfy3tm3j8st+xOG9cXRy+IRFR
 PqtdrIXtq4F7G3QRx2mWAPP9LSp8wn/YdLGaCZTOBAAo772AceDfisLzd+p+65yCLnQr
 AlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288728; x=1783893528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sCNdzsLH3Q0jMX4rCMKs72ytygkMCsUMvV9SlnS9aVI=;
 b=OJWzFKYbku3SKRIkXD2/r3VPmeZkrCFQDcb5k6+n2+LmM3ce8pk/Z1rsAvzbUmkwpJ
 tx6h2WsdrgAarRL+TizoN1ph5G9Kn7t1F+d7uueC6EO+VNauwePKIumRLuFt2lfTOsBW
 R3xNwaC59Q0X97KbFpZovTzF3WQ6zsxVFh9cvCPRJdsw4/70QNEYUc9MrQT7AXQGu9ms
 +dAcyMRtrnqVPYJLiCQxT2jC7I3RpMbvyYCJpg3vTJp9Tvgoa6IigWszVaJjXwAGY5Xh
 UVgnfm5rbZ/r09pLWHwR6nsHXevqaviZyMotrji3ZtmeS4dXseHE802JzFKckX5fLXzF
 f3Cg==
X-Gm-Message-State: AOJu0YwMeKC7QE2nYIly6NMLK0zYfESV1OEQBP8FqNNDCUgTyYnvTf7v
 oIZE7+ftJntYpv46/pC5q4ieUt53yBBs/yVvjUBp8Rr2eiUVs6OHaFEas8spv0WRLsgenCQQoJ6
 +0wofJ5/mmP+w5xPGRK7Z+EK2BgPL7kKrmiw4+8UB6PP/T52IXKpwJyOwLX2nNpZX9g==
X-Gm-Gg: AfdE7cnyxlRI4S1BgsGzw4TME8YYb2R9QxLodw3Eop7VLHO7C/3gbHyo2xC5ckMbZKH
 J+u4UXbmdv+jWP+1tzJ3yymSugth3ZqhcBEpP3y6PxWcZl11PLmqG/dkeTq+kjLwcDy3sq6SgSV
 yjHju8r/YtYW0EKcwxLIrARrPK3MozPeD0AQaTrwa8QFBnzK8qpgjazQpT35M6nI5zG8PvEar8I
 lrpuXVtYQCgOF8Z0T4ay8cbrTeiZRtUvt0NZK3XdZAJHF8yXCde85xqMZoEI0hxxljqaQS3OejE
 bfLIYLIHbikIyM+lXXxorNpvqjr845DJqzTAkZJNatCJ/+ISm1u8VIGws5vIUk8CMLyidHN9pke
 unKsvmnNBKbCJhq1BZr2XItPtqrI0bYu9xtNQYzwmjRLAsFkOrLCq7w==
X-Received: by 2002:a05:620a:700d:b0:92e:64af:3e59 with SMTP id
 af79cd13be357-92e9a512f0fmr1202597685a.67.1783288727635; 
 Sun, 05 Jul 2026 14:58:47 -0700 (PDT)
X-Received: by 2002:a05:620a:700d:b0:92e:64af:3e59 with SMTP id
 af79cd13be357-92e9a512f0fmr1202595285a.67.1783288727164; 
 Sun, 05 Jul 2026 14:58:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f28sm313048175e9.9.2026.07.05.14.58.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:58:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 10/32] accel/kvm: Simplify kvm_init() w.r.t.
 TARGET_KVM_HAVE_GUEST_DEBUG
Date: Sun,  5 Jul 2026 23:57:06 +0200
Message-ID: <20260705215729.62196-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4ad398 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6V-ij_voEnMy1CCV-fGlT6ENNSCO57D4
X-Proofpoint-GUID: 6V-ij_voEnMy1CCV-fGlT6ENNSCO57D4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX7CO8U9QCz97j
 l/zernPGa+WqSLdqDH2SVJHZk7gWVx5TucpdcjBSSYfvzRJVCeZi38UCohQ0kzmjbp4JQ07GRr8
 S5cDEXxPSJGtdWgbtFfjx6aoWHBclQE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX0MNYtLzLPfoi
 6DcGcg6kuG11pue0E1gTbtm2IivbSNFiYMYII8V601f/9iW3TZ9spDH/jzDqEtCrzbOa5eufBr0
 SeyUg7K7YVJziLo+KwxVBvbHObbLqozdv4bu05g3dYa9KW14bFk8f//Ng7RUCVtirQkd6/pCP9i
 6hXscrUacPYp2w9kEATfH0RqRysEcipHZK1eS6YeXLqe67IY3ZPEl7DqJZbPAK7rgIAiy6cCKRF
 bv+XcMJPe8I9xUkiOKrV6c2j4MKu18z+S7N5uR31AOAUqaaI9b1TF1ygw6JDrJQBjeatxemK+0w
 e+dPU7DKz5uMxSPxZtZRLQCZUUTEFMq/SJOzRpGsukgfgpusHLTOWHct4cRlvDft4nutP1yQteP
 yqPk0yqWeZTBAiR28WGw9uTQCpw76SUzIxEL0vTnd/7zbaJn7hlIa3UUo0gVLmTRYwVa7Qf/kMg
 CjZiQMiC45+3T9QFYdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050237
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

Simplify #ifdef'ry using TARGET_KVM_HAVE_GUEST_DEBUG in kvm_init().
No need to zero-initialize kvm_sstep_flags again.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5d55cb45cf7..304467704ee 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3040,21 +3040,18 @@ static int kvm_init(AccelState *as, MachineState *ms)
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     kvm_has_guest_debug =
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
-#endif
 
-    kvm_sstep_flags = 0;
     if (kvm_has_guest_debug) {
         kvm_sstep_flags = SSTEP_ENABLE;
 
-#if defined TARGET_KVM_HAVE_GUEST_DEBUG
         int guest_debug_flags =
             kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG2);
 
         if (guest_debug_flags & KVM_GUESTDBG_BLOCKIRQ) {
             kvm_sstep_flags |= SSTEP_NOIRQ;
         }
-#endif
     }
+#endif
 
     kvm_state = s;
 
-- 
2.53.0


