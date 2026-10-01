Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EFBCA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxY-0007yL-UW; Thu, 01 Oct 2026 13:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxN-0007x1-FI
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxL-0001jp-8Y
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:32 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Ft0V42687211
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zInHoVcfvFlFF+x4FTwVMsG5eRweFEKGs0/exjtadIQ=; b=X3gQAQf2zmieuIRf
 +eiuaPmtsajumjzxCvcTCSB+iWF0QN5CbaAEaRyx/UtBSuHIOsi3KfWdGHJhbL3a
 T1X8c6BejA68yNStX8o7svAKGSRouqnkEQaRakbmgHMQINyEpO0ixBnUkbvK6YjP
 NJwV0CPFtbBAtCyxZsFlSZJJoyBprMknzdJkL/tWTkbqPV+m0j8IXgyFBEfHv9nC
 I42XtMKkDAtZRyEnn1fvPIxVzipoKlkQI4fdImpjinX6ZNZkzcmzikf7xXYFphg/
 ivQ4TUJEh5hCghriGqDwOroHRzMUwKwVGF1Pp5wZSk+UyM3lRWTroqPNCf6PDA3v
 gHMNzg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9a8nrr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:30 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-147be78cd56so4447743c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877149; x=1791481949; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zInHoVcfvFlFF+x4FTwVMsG5eRweFEKGs0/exjtadIQ=;
 b=H8pNn/wtnTVi1+INFzHo+PCSUyhQ7/vUVrTg3if9Slk0jo22c8JP/Ks2L9Q75dorkc
 Mi2DOXxpbi3MbanrQEGwB7cveuUZgUrlC6rhYzsRfejrcTpjrWaTEsp6UwW9vqnVhOsU
 t9yNNoE3WLuUgRZyUGIy3q3zCExmmXlzU9kvyqOYyIjPq/ex/zGWGCFnWVu4D6Zm77mf
 h64jBDneo/s0kIpZAMDUoDL6jnT9avJrTi3mMqk68rRRpbY2vBPn6vzU5vQ7TBNRalpI
 w/3wc9e1zbbelpwEHvBZFLgphRQGiP2B86nn3sY2qta4BktUkybZXkjkzDnyJaV/cZfw
 rAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877149; x=1791481949;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zInHoVcfvFlFF+x4FTwVMsG5eRweFEKGs0/exjtadIQ=;
 b=ZQWFQoMdkgoeoHzNhW99iuNzt2xiTQQZkwoxfEXuCyAdIzxel58h59+826gPhCnayo
 3zsrTVv4dYRLAL12q/9fug/z5SiKeX/RZjjZpIONQCBh1NBHioyGs5L8kNRYP0jmDrG/
 YFUcKyrsSsrvzL0R7ex1esHZpClJ75esTY/RatnfBBAjWO1F7gUP0G8hVCKEIYJc2dxD
 eZ6zS/KISrOmj6Skp+dNtIbDp6FxKDB2VMVY3Z0KaC5oeEwY5PJ3Wij1mO3bvWlgr27e
 XFiUJ5EIxpH7hvGZlfQuDIxDAJdxWrICUfEvMBQf/WVWYg0AI1qjVDJwJLHDD6mjaMYA
 OZGw==
X-Gm-Message-State: AFuF++lbiz4pf9Ge9CAMQA9ygHGZJpoT/EI/QGqVDd0xFJUri3/cPHPB
 7gOhLvMnEStoWOpgDoLn1OBugmC4LegRZk2cXHmiESIpJhgHhCeo+cuNOHHBbpuqY1WHu5wWBXs
 vnX2Bbt0WMpMqxEnhWk56DI72VwHiIQlvlq6Xh/IgdQ+ZT8xrQbbUs7XPGdUqdrStCQ==
X-Gm-Gg: AYBFou2r7SZRdQS3V7JEKvz9+p181jLHYKbhp8vRs0ytIhaBsYEI/JlR7IkxEYtaznq
 bhOuIf/6PUHpkXNvQwn9wNqqy31WmBMrGosK9JI/LRPBaJt4V8JZhjAKZzlqWeJxHFoujxWAxbt
 t6VOzXJc7tWdZGQDk2BiGkmuWnfZtpuRMGsU8znHP0A42fCTsHbC3G5Pk/PZ3LOhdjZKdsVJJSL
 NeUBi5X13b+n63WAd7KUBRulsuwFNDik4OFntoDHYiywsC3GKhIZfWXpwkdDKsihSW/3/+7GsZ7
 wt16PllzssL3YXAOu5xaSogHOPeNCXy/I3QUrr2Dgvsejn3QKJ1oZyvLyI3QWOcfKoVuthC1Fhe
 /XJlXEnp7d8Lzbebj+9sVnD5ayiIzmU3rYxDh0NEPdO9F2vypEDebrBNYxTeA
X-Received: by 2002:a05:701a:c951:b0:14d:c23e:c931 with SMTP id
 a92af1059eb24-14dc23ec9ebmr5204896c88.10.1790877149015; 
 Thu, 01 Oct 2026 10:52:29 -0700 (PDT)
X-Received: by 2002:a05:701a:c951:b0:14d:c23e:c931 with SMTP id
 a92af1059eb24-14dc23ec9ebmr5204827c88.10.1790877147951; 
 Thu, 01 Oct 2026 10:52:27 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 08/27] tests/tcg/mips64*/meson.build: remove unused cc_feat
Date: Thu,  1 Oct 2026 17:51:44 +0000
Message-ID: <20261001175203.8673-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX9YNiqtszjEso
 XLxclNaVeBs1phsWotqgLJCEgI3+sQ4GdU0rlE/8Hhz6hqOwa0Bt6i+Jp/GdRFYzrCb9dBYOxNo
 M12fsl3v7srAQCFJBGxilisKKG7BJ4w=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abe9dde cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9k7arhYmT5PAGqctRaAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: MXS1_6j6rjqPmtfohqqYfpp87LLYAzO7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX4agRFwemJWXR
 fmoxK+4uJ1xaxdI/pLWDaNDIvPi+spYjtlu8SmNC0EACU+LvmQJd9TLTNzpFxRFTyvhyd2F3aRg
 fw7vxtsqb+b49Oe9vVGjnriJKAcDKyb5MLhy7wIO4Shsu1t4ok/jX/wpIT1X4HgLwsrlsY2lhKt
 172ooWJeBhhyq2un7T0xp3Z5Tc6FZNlKDHEUORAahEdUSqbNOzAI03iEb9pRV9d519JtSsGK3my
 px1GrBICslWfRquKlkRAKetAgOPoy5yGJrcxqE0lCmStU4J57+ooVM2cU3o6aMysBNylz6uXJqm
 ZC9o5relDO9pXkHyN6j2vEU6JUrXrJZHh0QsUV/+U/b5lU6wToOvs4tvPKRX5r8f9XL8MUfY1+G
 RVxCB2SfzfTH3PaYrdYoM0GQJ7MQ5A2iX/ReetdUMnUwFRpAwHVH+fsfP81nX7IrZX06R9FcB+o
 bK7n1Sr9fat8O3GtUUQ==
X-Proofpoint-GUID: MXS1_6j6rjqPmtfohqqYfpp87LLYAzO7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

mips64 has no cc_feat defined, and it was a wrong copy from a previous
architecture (cc_feat defined for a previous arch was used).

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-9-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/meson.build   | 1 -
 tests/tcg/mips64el/meson.build | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index a324a16d671..f08d1182576 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -16,7 +16,6 @@ if 'qemu-mips64' in emulators
     'mips64-linux-user': {
       'cc': 'mips64-linux-gnuabi64-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mips64',
       'gdb_arch': 'mips64',
       'qemu': emulators['qemu-mips64'],
diff --git a/tests/tcg/mips64el/meson.build b/tests/tcg/mips64el/meson.build
index 2aafbba750d..d74c7de9b7a 100644
--- a/tests/tcg/mips64el/meson.build
+++ b/tests/tcg/mips64el/meson.build
@@ -3,7 +3,6 @@ if 'qemu-mips64el' in emulators
     'mips64el-linux-user': {
       'cc': 'mips64el-linux-gnuabi64-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mips64el',
       'gdb_arch': 'mips64el',
       'qemu': emulators['qemu-mips64el'],
-- 
2.43.0


