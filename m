Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B981BC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4PWd-0000wq-TH; Wed, 09 Sep 2026 17:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4PWc-0000wU-9h
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:08:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4PWa-0000Vp-Ku
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:08:09 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689JI6na2363657
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 21:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rsVgFCfA8/6
 VrdcTgI54XidQGha/ag0fLThsBSj5BQc=; b=AUZtL2DavxkxGIix4C0ZuI+rG7a
 x6n+8g3JaiF3JN9IBWxaPyeTka6WKHBAuHRlo8W3A0uQHRirEZHQ+EZELmf8X/DJ
 nMTit6wuxTStdfXmRs//pZM5GSPmx/enuHm9OtPkN+1Yr2omu9LRb6Pf8TQDLnpL
 i5YER+LVj0v0fgG+C3D6eJSvctnSZDrA2kXmUz0bpnUycrA4EHzB09S2zDxHw0Ce
 fQ7S1mMdXKeJlo4sz6dhKIWlBeOF6wCj0jp9twosDnepDbXZAcWrItRuXzU+4mIu
 jRnOAwD+/Ly/ZjBgbLgERKblad3/AQp+XqjJtBZdKL5Nn92G8s0haUUFxdQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydrmkg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 21:08:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93903982af1so1294125585a.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 14:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788988086; x=1789592886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rsVgFCfA8/6VrdcTgI54XidQGha/ag0fLThsBSj5BQc=;
 b=cVaQDF4wzAzwfhcB5YMWbbdxL5ViNdHVZPhLahBsCXGrFPNIfCiuNGpIWz7m/jmIpN
 tHU1cN9recyP3HHpKkVvCo5N7mPI9E0/sjNAfRFDxjHtDOev/Hf2YylH36Qmuah4pzL8
 qTfEdd4/GwUJMuHGDg2nN4YjKgY7UAioQjVfww38mZupRiajLk/uYl27QNcs6rbKrq/A
 F4h+0RUpeFAMmaEvVSpyTvUS9a+zPSVLQcaDiNEM/+amgQDJwGL2RCoLIfUHsxS/UhZm
 BuEXBxgmzuS9apsts850F9xyCb7Z25WJUYGdyWEl1GHDa9aINzZZcyAH8D4oGVeIGJrY
 Qv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788988086; x=1789592886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rsVgFCfA8/6VrdcTgI54XidQGha/ag0fLThsBSj5BQc=;
 b=etrUeqg2litzcosWxMByTcAqPMxiV53FQ77xSET4ej6yL//Bqfh59I7OpQIHqCTDpR
 evDG0036HUh6QfMmHDx4R49bIZQszguTPF/ek95oc5MUjF76yl32XqeO5cPlNFr+qQb8
 xNbTdrm7rygLB9bLkk38U8xlr+i/ONoh6oBlgBwJpjxJ5esgmX0SDTz3dcXfxZPZLw+h
 s1oFfhAzqzus8W3vs6a/crHAgHh7zX3Usp17d2PM+rThxKPUJ++kUAOwi9Bg1VHAf6/T
 zm88Ebx5tXTYgLtzx1p2Bdc3xw8sBRWVs5DN064/AmreEP/8J0yzgYntiHSJzPq6UZdW
 /pZw==
X-Gm-Message-State: AFuF++kKb+PU8FDfEkMdsNeDH2KcE13aLc28kP14U7dvESrfyMH7vuTA
 jNMJbNhB3gVRYRBJ1LWEnXg/gop+ZNofsfwrM0uZPE382AhbajqBE+v/qxwWJK6bgAfpcXUW52t
 cT13o0ytmlmUtb2xxyZqcVsWhgWpDw751x3b93laXMCuoDUxDKHdjDsvoOfw0s60/nw==
X-Gm-Gg: AYBFou24dcKcDFidy88hpN7tZ2H1lPJXrBhciJv7pgWpV/myYZoWY3dJBQAMZIbh8qJ
 x72NK7SoT7owLUWCW//GiQeBMpjMgMoXEcBJFlTmf3BSExpNfnc48ZD9Wdr1yIAo4mROTr5CW8S
 JDxKFdvOgtvt/pxeyTkSwsGR9UAwyYXQEn01pB39BC50fkUiKkAFvpDcVVbahVJV09Y4HzbbJhb
 V80yKvprOZ4YkMYPoFWbKMHYqMaQiVBCp4G7yhox9LfV+6T/Wvh1cfKDi+8yJhTjhqoF54igqrn
 omhkl7YqmUTU8tx2qouFxUt5GbmMG10oiF4DT1yvrhXfOZAMlP51qpLoS/LmNs9oyv3eHCxxK+4
 3ianWJPRfPJ7WRxsTpLNGUW0Qrmoy+uZ1Q0mN
X-Received: by 2002:a05:620a:1a06:b0:930:f35d:41ba with SMTP id
 af79cd13be357-939807284bdmr3996662185a.36.1788988085768; 
 Wed, 09 Sep 2026 14:08:05 -0700 (PDT)
X-Received: by 2002:a05:620a:1a06:b0:930:f35d:41ba with SMTP id
 af79cd13be357-939807284bdmr3996655985a.36.1788988085262; 
 Wed, 09 Sep 2026 14:08:05 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040646d59sm151811336d6.8.2026.09.09.14.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 14:08:03 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v11 1/5] target/riscv/cpu.c: remove 'bare' condition for
 .profile
Date: Wed,  9 Sep 2026 18:07:51 -0300
Message-ID: <20260909210756.1767711-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909210756.1767711-1-daniel.barboza@oss.qualcomm.com>
References: <20260909210756.1767711-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IfsSymqa c=1 sm=1 tr=0 ts=6aa1cab6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=FRSEYCzRAAAA:8 a=GhL2bEVCvcqOW28JNKkA:9
 a=IoWCM6iH3mJn3m4BftBB:22 a=xVlTc564ipvMDusKsbsT:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: IhIDCRU3J4aAMYGY2mb9zVsRaNb9HNIk
X-Proofpoint-ORIG-GUID: IhIDCRU3J4aAMYGY2mb9zVsRaNb9HNIk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIzNyBTYWx0ZWRfX4tWNZxW8wepU
 TTlciVsi+CDGoPDWnzRN69t8x4bTuqHvNr8/ce0JV9MqHnULNrLodc7+3Zjcjqm1dhT3VDkBpPY
 5+i8h+jQEqtHMWY8+mmHG3Z6Hfupcmg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIzNyBTYWx0ZWRfXwTkyjpFpI38m
 RLHuDPJh+7rMClyEfzHZhjV4xhyp6IhlfcGDaDkIzZbcSSUoKUm3SZ7vYUf0ec0cNxuz+8o0AO5
 CWAkjatRIOAvAhdHnh3dPH9vkxwFEG/HMoEPE/R0Xm78l0gKrjBx2t3Zl5G2GT8rwR37QnCKSXP
 bcat9xpLBF6FCjSZ3Rsfe9BASO2lQGCDTVnxhwszMg104DItNgZbxoPFLZvyRNDmjOJmjYVZado
 iPJDFfYFqkJ1HFRkoNzX2aRsyKg/GAX2OWllY8uSxGyRIL/owtud4hh9SgyV9MXrh0TPi2d67eJ
 6fsb+CHs06NrYiEyOH/QinifX4sRfDBaqMe3KGxG2P5/foO6oQobLUMxGCuHjASePS1+QbLL6oU
 HMZM6J3Nup1LuJ413KMdlcq0mgyGksDuNafuXo18jUbKVg4W961LClvZRQ4pjIoqfu2jhLAqwvT
 R10ImQkw0wTJg3yTqhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609090237
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

We want to configure other CPU types to use profiles as an alternative
to adding every profile extension explicitly, i.e. a profile is nothing
more than an extension bundle.

This means that a vendor CPU can set .profile=rva23s64 while having the
same handling as any other vendor CPU. Same thing with all other CPU
types.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c71986da61..773aeba8da 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3103,7 +3103,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def->bare |= def->bare;
         if (def->profile) {
             assert(profile_extends(def->profile, mcc->def->profile));
-            assert(mcc->def->bare);
             mcc->def->profile = def->profile;
         }
         if (def->misa_mxl_max) {
-- 
2.43.0


