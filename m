Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07567C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whALZ-00057v-An; Tue, 07 Jul 2026 14:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whALC-0004kj-Ko
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whALA-0006Mt-BS
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTMst011774
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KVatRpgtO+1UI6qqTMISE+yuOb932Sbn64LG4a5K1mU=; b=NkNAftmQVjySSgfN
 yCLC6dyXen+TTID5hJEs5Tj4rzmDn3dXstvkjCX/rhScx3A91jS2SmrffpH/v6VS
 YNRLWiZePORIIOxMSxSor42oPz6uov7+kJ3oZK6S9WvrvSc7WozfeXUY+C6bsSWI
 tO5oRZfq+2em6xRW/PdxzwS38b98PD9iiJwlgm7ojD8sJHhRAd677LSSrwVlkalw
 MEPykvjavc6pUSOU/qn+IMwAzKuvWnTbxDjsnjsgd+9JqpRD9Rjf5j1It7r0tWhd
 dHTliysnjeaRkHcixelW9I55C6niyDXjXbVsBOAK6s5OA2aOJd9OVKD+i4KpWBXI
 usBibw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vdjawuq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:16:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c01ff996dso60149311cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448174; x=1784052974; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KVatRpgtO+1UI6qqTMISE+yuOb932Sbn64LG4a5K1mU=;
 b=Eih1XKuufPjPwzafbzP+AKt4ajbu4RfJO+F3ptfnlE9W/sEHmFN/mYT2uNxzt8QxgM
 E44wYCVjdlVRduWhD+8rzso283hYEudz6TV7Wo5oBZ5Su8ICXhxc40eV2aHHRqFz6U/0
 DcptWi32Tvib4NwhYpFZUArCr50NTiaF8rniRlhHbrs/kJ+hSbwy11hilFPdAFfPPWl2
 BWwtLMNoUv66fd3yl/d4rgTUlbkocfLWazD3QnXl+flAj/4yBOt5RMRCwqUpLA+i+Hsx
 kY6/+5gF0SfOdSXBZ2xjqDXfIxbXFYKTOLaQcYumIIsjEsErEfbpUot7maEFNK5f3lbZ
 EG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448174; x=1784052974;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KVatRpgtO+1UI6qqTMISE+yuOb932Sbn64LG4a5K1mU=;
 b=Czsun7G3u79k2SgZ8JF7PuqxzQ6lxGal4Xh7NAmZCjF7KSq/wTHWqTmqo1UxyflOF2
 KPDvrIvDR+t9TP6aMLDi4ol9I/nb5BrI/TSuaOWEBiocKUB3V2MiTMrnyWw09kUlXdUZ
 ebdet/tSqTZX7UABSfykebnodvYZTDGF/Zl6HmAfrQgfWOh2rYgj/SrBacDDuN+CzsDm
 YXWGepGny+nstJyk5iQvJLHqwmKkk9pQgTR4z8CxBW5PlkJkGReF9lJp1mOPmA+1ll95
 PYacEIx4+aNiy2EiOMr3VGUV7sM5/gZRz6TPp3fF2ngdto/wN7jeBYg6wICclOk6VdBp
 j+4g==
X-Gm-Message-State: AOJu0Yx4LpUrRQeN5qFmgOKQCK0+HYgKpfoRKAWddozRF7yYaaBAk0EU
 Q1xUJg9PRHZirmZZDGqj4MGCM29O35HSamC1oAbUSU/8vXlyysb/9xCy8ET/F5iG1jZGktwMlyG
 ZNt+4PZYxZx1gC2+LdguUWXAz0DJdNfEAEPQGNOiliB9z0u+mhZzH0ULa2cbZQq4ZCA==
X-Gm-Gg: AfdE7cl44CNqzG9h+ZqBxQff+gviqDs8bua+RV9pC+816PvM0490nsjaQK8Phsadel9
 YNjcCujk3FRIojPZqgDP3/EOFW+fY9T4MdiLng+uc0YKhl+tdKpQ/V90kCuXzEIZLPvh8BtMZ8v
 nWb8SrUEFTA61LOuSrfIV+/Kji4Ovd619xQBZmGRA336D5RnWSx4rfBfqIUrpe4F4lbssXsvpJs
 3zaD1iSpp/JxOOPj6B6O79pgmY7kd21I84IUP284t94idB9xeC0rfjV7U3GKIOlTVbZ85M5szue
 ZQpV42+wLAxbZTUlmfQSEYu+l/TrbiYOEnAu3E3bAFx2Ss/x36a0wXU6hIw+4Dm1cvML0biNPca
 ZNlWL/SG4uLLj8XlgZqXrCgI2w1AMmgUSspyKoXQRPPmN498jS31iiGIUJXc9NOTCJsZb
X-Received: by 2002:a05:622a:1194:b0:51c:c97:f3b0 with SMTP id
 d75a77b69052e-51c748af0e3mr65755991cf.63.1783448174291; 
 Tue, 07 Jul 2026 11:16:14 -0700 (PDT)
X-Received: by 2002:a05:622a:1194:b0:51c:c97:f3b0 with SMTP id
 d75a77b69052e-51c748af0e3mr65755241cf.63.1783448173445; 
 Tue, 07 Jul 2026 11:16:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f5b811sm116852395e9.13.2026.07.07.11.16.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:16:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/23] target/mips: add Octeon ZUC COP2 helpers
Date: Tue,  7 Jul 2026 20:15:11 +0200
Message-ID: <20260707181529.60191-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7cz39RX c=1 sm=1 tr=0 ts=6a4d426f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=AUozeWMskNeGgjpE_QQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 9YGQfATDgSjP5t0w2eBPtOEHOmi_8uvE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX1CotLLDsK2ya
 3A5mmiRVR5wAFxCqgGnlxRxX8RGZl3lV9PHtzfDrExkkMgHfDoIoyDzQMfJR3jax6n4SeASC46b
 ROaNlUcAYHeOScaTuCsTRqgVoEze3e0vuFI7YIjZ/Zn6nL3Js1EezvkDcPL/wXrnciJ9yF9AGGQ
 8l1bSgbsAmDVQJrkxlyhnMnikxFk7+OyCUqLATmOh29Wjs4uVcRLyRvCjmD75uGZt3J/Z7gFoVS
 iNl1+5KFB5hog/xC4GtLk1XT1mqUqxf8DXWHzZfqbXeEzMyoQNTcf3TQae63q7oDeAeP4nRBnsq
 fEV8JZqCP0IY1OgPLdXcnZcj3cAS/0HRMYZEt3iPXsGmXItsJAnlqJl3p4cqlELUOsbL+tGZRLC
 0ZZfo4Dsnp9k7LlPOQax+GwSAuHY3VNG+wKoWO+Cuc+Y0GusuVExwmObZ/Q5KUj4Fy9/XCH8ciN
 Iwb0o0lz+j+JrVYUIsw==
X-Proofpoint-ORIG-GUID: 9YGQfATDgSjP5t0w2eBPtOEHOmi_8uvE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX4kxxFRaO7CSx
 sbShBql6DLao7HrJryb0cFD6QLBT68fudARIFxKNf5t5Ye726lS8Qh2hwQmjk45suKf5yKbEAFE
 LeyiDnduSMhY/P/C5/ka3fY8rT1o7eA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070179
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

From: James Hilliard <james.hilliard1@gmail.com>

Add the Octeon ZUC START and MORE helper operations and model the shared
state window used by the hardware interface. This covers the keystream
and MAC engine state, including the save-and-restore view that overlaps
the HSH/SHA3 bank.

Keep the LFSR words in the architectural HSH DAT input registers and the
runtime MAC/FSM/result state in the documented HASHIV window. The third
MAC lookahead word is generated on demand instead of being kept in a
non-architectural shadow slot.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-6-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/helper.h            |   2 +
 target/mips/tcg/octeon_crypto.c | 338 ++++++++++++++++++++++++++++++++
 2 files changed, 340 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index b887e05199a..292336ec629 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -48,6 +48,8 @@ DEF_HELPER_2(octeon_cp2_mt_gfm_xor0_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
 DEF_HELPER_1(octeon_cp2_mt_sha3_startop, void, env)
+DEF_HELPER_2(octeon_cp2_mt_zuc_start, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_zuc_more, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index cf718d64829..548269b9b8f 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -241,6 +241,344 @@ static void octeon_sha3_permute(MIPSOcteonCryptoState *crypto)
     }
 }
 
+static uint32_t octeon_crypto_hi32(uint64_t value)
+{
+    return value >> 32;
+}
+
+static uint32_t octeon_crypto_lo32(uint64_t value)
+{
+    return value;
+}
+
+static const uint8_t octeon_zuc_s0[256] = {
+    0x3e, 0x72, 0x5b, 0x47, 0xca, 0xe0, 0x00, 0x33,
+    0x04, 0xd1, 0x54, 0x98, 0x09, 0xb9, 0x6d, 0xcb,
+    0x7b, 0x1b, 0xf9, 0x32, 0xaf, 0x9d, 0x6a, 0xa5,
+    0xb8, 0x2d, 0xfc, 0x1d, 0x08, 0x53, 0x03, 0x90,
+    0x4d, 0x4e, 0x84, 0x99, 0xe4, 0xce, 0xd9, 0x91,
+    0xdd, 0xb6, 0x85, 0x48, 0x8b, 0x29, 0x6e, 0xac,
+    0xcd, 0xc1, 0xf8, 0x1e, 0x73, 0x43, 0x69, 0xc6,
+    0xb5, 0xbd, 0xfd, 0x39, 0x63, 0x20, 0xd4, 0x38,
+    0x76, 0x7d, 0xb2, 0xa7, 0xcf, 0xed, 0x57, 0xc5,
+    0xf3, 0x2c, 0xbb, 0x14, 0x21, 0x06, 0x55, 0x9b,
+    0xe3, 0xef, 0x5e, 0x31, 0x4f, 0x7f, 0x5a, 0xa4,
+    0x0d, 0x82, 0x51, 0x49, 0x5f, 0xba, 0x58, 0x1c,
+    0x4a, 0x16, 0xd5, 0x17, 0xa8, 0x92, 0x24, 0x1f,
+    0x8c, 0xff, 0xd8, 0xae, 0x2e, 0x01, 0xd3, 0xad,
+    0x3b, 0x4b, 0xda, 0x46, 0xeb, 0xc9, 0xde, 0x9a,
+    0x8f, 0x87, 0xd7, 0x3a, 0x80, 0x6f, 0x2f, 0xc8,
+    0xb1, 0xb4, 0x37, 0xf7, 0x0a, 0x22, 0x13, 0x28,
+    0x7c, 0xcc, 0x3c, 0x89, 0xc7, 0xc3, 0x96, 0x56,
+    0x07, 0xbf, 0x7e, 0xf0, 0x0b, 0x2b, 0x97, 0x52,
+    0x35, 0x41, 0x79, 0x61, 0xa6, 0x4c, 0x10, 0xfe,
+    0xbc, 0x26, 0x95, 0x88, 0x8a, 0xb0, 0xa3, 0xfb,
+    0xc0, 0x18, 0x94, 0xf2, 0xe1, 0xe5, 0xe9, 0x5d,
+    0xd0, 0xdc, 0x11, 0x66, 0x64, 0x5c, 0xec, 0x59,
+    0x42, 0x75, 0x12, 0xf5, 0x74, 0x9c, 0xaa, 0x23,
+    0x0e, 0x86, 0xab, 0xbe, 0x2a, 0x02, 0xe7, 0x67,
+    0xe6, 0x44, 0xa2, 0x6c, 0xc2, 0x93, 0x9f, 0xf1,
+    0xf6, 0xfa, 0x36, 0xd2, 0x50, 0x68, 0x9e, 0x62,
+    0x71, 0x15, 0x3d, 0xd6, 0x40, 0xc4, 0xe2, 0x0f,
+    0x8e, 0x83, 0x77, 0x6b, 0x25, 0x05, 0x3f, 0x0c,
+    0x30, 0xea, 0x70, 0xb7, 0xa1, 0xe8, 0xa9, 0x65,
+    0x8d, 0x27, 0x1a, 0xdb, 0x81, 0xb3, 0xa0, 0xf4,
+    0x45, 0x7a, 0x19, 0xdf, 0xee, 0x78, 0x34, 0x60,
+};
+
+static const uint8_t octeon_zuc_s1[256] = {
+    0x55, 0xc2, 0x63, 0x71, 0x3b, 0xc8, 0x47, 0x86,
+    0x9f, 0x3c, 0xda, 0x5b, 0x29, 0xaa, 0xfd, 0x77,
+    0x8c, 0xc5, 0x94, 0x0c, 0xa6, 0x1a, 0x13, 0x00,
+    0xe3, 0xa8, 0x16, 0x72, 0x40, 0xf9, 0xf8, 0x42,
+    0x44, 0x26, 0x68, 0x96, 0x81, 0xd9, 0x45, 0x3e,
+    0x10, 0x76, 0xc6, 0xa7, 0x8b, 0x39, 0x43, 0xe1,
+    0x3a, 0xb5, 0x56, 0x2a, 0xc0, 0x6d, 0xb3, 0x05,
+    0x22, 0x66, 0xbf, 0xdc, 0x0b, 0xfa, 0x62, 0x48,
+    0xdd, 0x20, 0x11, 0x06, 0x36, 0xc9, 0xc1, 0xcf,
+    0xf6, 0x27, 0x52, 0xbb, 0x69, 0xf5, 0xd4, 0x87,
+    0x7f, 0x84, 0x4c, 0xd2, 0x9c, 0x57, 0xa4, 0xbc,
+    0x4f, 0x9a, 0xdf, 0xfe, 0xd6, 0x8d, 0x7a, 0xeb,
+    0x2b, 0x53, 0xd8, 0x5c, 0xa1, 0x14, 0x17, 0xfb,
+    0x23, 0xd5, 0x7d, 0x30, 0x67, 0x73, 0x08, 0x09,
+    0xee, 0xb7, 0x70, 0x3f, 0x61, 0xb2, 0x19, 0x8e,
+    0x4e, 0xe5, 0x4b, 0x93, 0x8f, 0x5d, 0xdb, 0xa9,
+    0xad, 0xf1, 0xae, 0x2e, 0xcb, 0x0d, 0xfc, 0xf4,
+    0x2d, 0x46, 0x6e, 0x1d, 0x97, 0xe8, 0xd1, 0xe9,
+    0x4d, 0x37, 0xa5, 0x75, 0x5e, 0x83, 0x9e, 0xab,
+    0x82, 0x9d, 0xb9, 0x1c, 0xe0, 0xcd, 0x49, 0x89,
+    0x01, 0xb6, 0xbd, 0x58, 0x24, 0xa2, 0x5f, 0x38,
+    0x78, 0x99, 0x15, 0x90, 0x50, 0xb8, 0x95, 0xe4,
+    0xd0, 0x91, 0xc7, 0xce, 0xed, 0x0f, 0xb4, 0x6f,
+    0xa0, 0xcc, 0xf0, 0x02, 0x4a, 0x79, 0xc3, 0xde,
+    0xa3, 0xef, 0xea, 0x51, 0xe6, 0x6b, 0x18, 0xec,
+    0x1b, 0x2c, 0x80, 0xf7, 0x74, 0xe7, 0xff, 0x21,
+    0x5a, 0x6a, 0x54, 0x1e, 0x41, 0x31, 0x92, 0x35,
+    0xc4, 0x33, 0x07, 0x0a, 0xba, 0x7e, 0x0e, 0x34,
+    0x88, 0xb1, 0x98, 0x7c, 0xf3, 0x3d, 0x60, 0x6c,
+    0x7b, 0xca, 0xd3, 0x1f, 0x32, 0x65, 0x04, 0x28,
+    0x64, 0xbe, 0x85, 0x9b, 0x2f, 0x59, 0x8a, 0xd7,
+    0xb0, 0x25, 0xac, 0xaf, 0x12, 0x03, 0xe2, 0xf2,
+};
+
+static uint32_t octeon_zuc_addm(uint32_t a, uint32_t b)
+{
+    uint32_t c = a + b;
+
+    c = (c & 0x7fffffffU) + (c >> 31);
+    return c ? c : 0x7fffffffU;
+}
+
+static uint32_t octeon_zuc_mul_by_pow2(uint32_t v, unsigned int shift)
+{
+    return ((v << shift) | (v >> (31 - shift))) & 0x7fffffffU;
+}
+
+static uint32_t octeon_zuc_make_u32(uint8_t a, uint8_t b, uint8_t c, uint8_t d)
+{
+    return ((uint32_t)a << 24) | ((uint32_t)b << 16) |
+           ((uint32_t)c << 8) | d;
+}
+
+static uint64_t octeon_zuc_pack_pair(uint32_t hi, uint32_t lo)
+{
+    return ((uint64_t)hi << 32) | lo;
+}
+
+static uint32_t octeon_zuc_lfsr(const MIPSOcteonCryptoState *crypto,
+                                unsigned int index)
+{
+    uint64_t pair = crypto->hsh_dat[index / 2];
+
+    return index & 1 ? octeon_crypto_lo32(pair) : octeon_crypto_hi32(pair);
+}
+
+static void octeon_zuc_set_lfsr(MIPSOcteonCryptoState *crypto,
+                                unsigned int index, uint32_t value)
+{
+    uint32_t hi = octeon_crypto_hi32(crypto->hsh_dat[index / 2]);
+    uint32_t lo = octeon_crypto_lo32(crypto->hsh_dat[index / 2]);
+
+    value &= 0x7fffffffU;
+    if (index & 1) {
+        lo = value;
+    } else {
+        hi = value;
+    }
+    crypto->hsh_dat[index / 2] = octeon_zuc_pack_pair(hi, lo);
+}
+
+static uint32_t octeon_zuc_fsm(const MIPSOcteonCryptoState *crypto,
+                               unsigned int index)
+{
+    g_assert(index < 2);
+    return crypto->hsh_iv[1 + index];
+}
+
+static void octeon_zuc_set_fsm(MIPSOcteonCryptoState *crypto,
+                               unsigned int index, uint32_t value)
+{
+    g_assert(index < 2);
+    crypto->hsh_iv[1 + index] = value;
+}
+
+static uint32_t octeon_zuc_window(const MIPSOcteonCryptoState *crypto,
+                                  unsigned int index)
+{
+    uint64_t pair = crypto->hsh_iv[0];
+
+    switch (index) {
+    case 0:
+        return octeon_crypto_hi32(pair);
+    case 1:
+        return octeon_crypto_lo32(pair);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void octeon_zuc_set_window_pair(MIPSOcteonCryptoState *crypto,
+                                       uint32_t hi, uint32_t lo)
+{
+    crypto->hsh_iv[0] = octeon_zuc_pack_pair(hi, lo);
+}
+
+static uint32_t octeon_zuc_tresult(const MIPSOcteonCryptoState *crypto)
+{
+    return crypto->hsh_iv[3];
+}
+
+static void octeon_zuc_set_tresult(MIPSOcteonCryptoState *crypto,
+                                   uint32_t value)
+{
+    crypto->hsh_iv[3] = value;
+}
+
+static void octeon_zuc_bit_reorganization(const MIPSOcteonCryptoState *crypto,
+                                          uint32_t x[4])
+{
+    x[0] = ((octeon_zuc_lfsr(crypto, 15) & 0x7fff8000U) << 1) |
+            (octeon_zuc_lfsr(crypto, 14) & 0xffffU);
+    x[1] = ((octeon_zuc_lfsr(crypto, 11) & 0xffffU) << 16) |
+            (octeon_zuc_lfsr(crypto, 9) >> 15);
+    x[2] = ((octeon_zuc_lfsr(crypto, 7) & 0xffffU) << 16) |
+            (octeon_zuc_lfsr(crypto, 5) >> 15);
+    x[3] = ((octeon_zuc_lfsr(crypto, 2) & 0xffffU) << 16) |
+            (octeon_zuc_lfsr(crypto, 0) >> 15);
+}
+
+static uint32_t octeon_zuc_l1(uint32_t x)
+{
+    return x ^ rol32(x, 2) ^ rol32(x, 10) ^ rol32(x, 18) ^ rol32(x, 24);
+}
+
+static uint32_t octeon_zuc_l2(uint32_t x)
+{
+    return x ^ rol32(x, 8) ^ rol32(x, 14) ^ rol32(x, 22) ^ rol32(x, 30);
+}
+
+static uint32_t octeon_zuc_f(MIPSOcteonCryptoState *crypto, const uint32_t x[4])
+{
+    uint32_t fsm0 = octeon_zuc_fsm(crypto, 0);
+    uint32_t fsm1 = octeon_zuc_fsm(crypto, 1);
+    uint32_t w = (x[0] ^ fsm0) + fsm1;
+    uint32_t w1 = fsm0 + x[1];
+    uint32_t w2 = fsm1 ^ x[2];
+    uint32_t u = octeon_zuc_l1((w1 << 16) | (w2 >> 16));
+    uint32_t v = octeon_zuc_l2((w2 << 16) | (w1 >> 16));
+
+    octeon_zuc_set_fsm(crypto, 0,
+                       octeon_zuc_make_u32(octeon_zuc_s0[u >> 24],
+                                           octeon_zuc_s1[(uint8_t)(u >> 16)],
+                                           octeon_zuc_s0[(uint8_t)(u >> 8)],
+                                           octeon_zuc_s1[(uint8_t)u]));
+    octeon_zuc_set_fsm(crypto, 1,
+                       octeon_zuc_make_u32(octeon_zuc_s0[v >> 24],
+                                           octeon_zuc_s1[(uint8_t)(v >> 16)],
+                                           octeon_zuc_s0[(uint8_t)(v >> 8)],
+                                           octeon_zuc_s1[(uint8_t)v]));
+    return w;
+}
+
+static void octeon_zuc_lfsr_step(MIPSOcteonCryptoState *crypto,
+                                 bool init_mode, uint32_t u)
+{
+    uint32_t lfsr[16];
+    uint32_t f;
+
+    for (int i = 0; i < 16; i++) {
+        lfsr[i] = octeon_zuc_lfsr(crypto, i);
+    }
+
+    f = lfsr[0];
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(lfsr[0], 8));
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(lfsr[4], 20));
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(lfsr[10], 21));
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(lfsr[13], 17));
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(lfsr[15], 15));
+    if (init_mode) {
+        f = octeon_zuc_addm(f, u);
+    }
+
+    for (int i = 0; i < 15; i++) {
+        octeon_zuc_set_lfsr(crypto, i, lfsr[i + 1]);
+    }
+    octeon_zuc_set_lfsr(crypto, 15, f);
+}
+
+static uint32_t octeon_zuc_generate_word(MIPSOcteonCryptoState *crypto)
+{
+    uint32_t x[4];
+    uint32_t z;
+
+    octeon_zuc_bit_reorganization(crypto, x);
+    z = octeon_zuc_f(crypto, x) ^ x[3];
+    octeon_zuc_lfsr_step(crypto, false, 0);
+    return z;
+}
+
+static void octeon_zuc_fill_window_pair(MIPSOcteonCryptoState *crypto)
+{
+    uint32_t z0 = octeon_zuc_generate_word(crypto);
+    uint32_t z1 = octeon_zuc_generate_word(crypto);
+
+    octeon_zuc_set_window_pair(crypto, z0, z1);
+}
+
+static uint32_t
+octeon_zuc_window_word(const MIPSOcteonCryptoState *crypto, unsigned int bit,
+                       uint32_t z2)
+{
+    if (bit == 0) {
+        return octeon_zuc_window(crypto, 0);
+    }
+    if (bit < 32) {
+        return (octeon_zuc_window(crypto, 0) << bit) |
+               (octeon_zuc_window(crypto, 1) >> (32 - bit));
+    }
+    if (bit == 32) {
+        return octeon_zuc_window(crypto, 1);
+    }
+    return (octeon_zuc_window(crypto, 1) << (bit - 32)) |
+           (z2 >> (64 - bit));
+}
+
+static void octeon_zuc_advance_window(MIPSOcteonCryptoState *crypto,
+                                      uint32_t z2)
+{
+    uint32_t z3 = octeon_zuc_generate_word(crypto);
+
+    octeon_zuc_set_window_pair(crypto, z2, z3);
+}
+
+static void octeon_zuc_start(MIPSOcteonCryptoState *crypto, uint64_t data)
+{
+    uint32_t x[4];
+
+    for (int i = 0; i < 14; i++) {
+        octeon_zuc_set_lfsr(crypto, i, octeon_zuc_lfsr(crypto, i));
+    }
+    octeon_zuc_set_lfsr(crypto, 14, data >> 32);
+    octeon_zuc_set_lfsr(crypto, 15, data);
+    octeon_zuc_set_fsm(crypto, 0, 0);
+    octeon_zuc_set_fsm(crypto, 1, 0);
+    octeon_zuc_set_tresult(crypto, 0);
+
+    for (int i = 0; i < 32; i++) {
+        octeon_zuc_bit_reorganization(crypto, x);
+        octeon_zuc_lfsr_step(crypto, true, octeon_zuc_f(crypto, x) >> 1);
+    }
+
+    octeon_zuc_bit_reorganization(crypto, x);
+    (void)octeon_zuc_f(crypto, x);
+    octeon_zuc_lfsr_step(crypto, false, 0);
+    octeon_zuc_fill_window_pair(crypto);
+}
+
+static void octeon_zuc_more(MIPSOcteonCryptoState *crypto, uint64_t data)
+{
+    uint32_t t = octeon_zuc_tresult(crypto);
+    uint32_t z2 = octeon_zuc_generate_word(crypto);
+
+    for (unsigned int bit = 0; bit < 64; bit++) {
+        if ((data >> (63 - bit)) & 1) {
+            t ^= octeon_zuc_window_word(crypto, bit, z2);
+        }
+    }
+    octeon_zuc_set_tresult(crypto, t);
+    octeon_zuc_advance_window(crypto, z2);
+}
+
+void helper_octeon_cp2_mt_zuc_start(CPUMIPSState *env, uint64_t value)
+{
+    octeon_zuc_start(&env->octeon_crypto, value);
+}
+
+void helper_octeon_cp2_mt_zuc_more(CPUMIPSState *env, uint64_t value)
+{
+    octeon_zuc_more(&env->octeon_crypto, value);
+}
+
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
-- 
2.53.0


