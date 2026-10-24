Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205E7606A327
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p82yfksV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CCcZedcG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgM-00044E-No; Sat, 24 Oct 2026 13:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfgA-00040E-2y
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg8-0008Jn-Bx
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF0dFW1357141
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=A7Fl7eiw/7o
 i9e9O/NVYtI0xIj7GJ1JzRrV5k9U3jL8=; b=p82yfksVuEnsdw4+TSGtjs+tlZJ
 DqtEfnlJjjrFoo2pJy0PnlAzegSuKmhrtBKnJdjNsZhLhzdVp9vYwKWBCe0OZBmR
 gV2niA656iVLPDP5mOtKRg8VMiR3OH163EHQpvYdiF4tOvMWWaqp+rB6rOCfHZ7J
 W4F88vv1vJU0C/V2ZgKDaO7J/3OSE/UvZIF3tNN7IEJt2wESkLBogEe+iVKOSVGB
 bp/J6zcb4Q2kilT2lL0rnYeOdOmaWOfEupmDuxFF8ct7ZWQgXzfaxkzNvvsWxhcC
 9ms8WJMahL+FjKV6zysRuueulrdBhCjVw9Z1QsqRZsYcQgtUWbqT6FPdSvA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehhc7q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:10 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd66551e02cso1988173a12.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863430; x=1793468230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A7Fl7eiw/7oi9e9O/NVYtI0xIj7GJ1JzRrV5k9U3jL8=;
 b=CCcZedcGUjVpaaGtf0txHDdVwrgEy6hS2IX3djVwatGsmPyv+tt0hGhrlI940YVE+o
 NLN0hVSLkdpzB5Lq1IBujFaXa79pnkhv6x8DPYsG9AZLUZC8N7cGSortjMVOJsgoVquL
 BFN7RXO4JXnXQi3UPoGQ5+k811VNZRIEermusxKYrt8D++RE4WqgLhaMUTpN/11C2TbG
 MuSHH/T2FAgQTbHyJeb0fJIeA5+KiO+SmEBCssor5dSi7HfQ6UuqQymNZMYpvKIdNyk3
 dzyCH9NUb92vsOSKJ8xYdnAinrg8zaUD60E29ZxbC3+S0w5CjJbz+Sfc2SirK8PGHZ4O
 8a6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863430; x=1793468230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A7Fl7eiw/7oi9e9O/NVYtI0xIj7GJ1JzRrV5k9U3jL8=;
 b=duRioqpbNek38RQWWxyL1mhxaIOchCtngaJIj6CgwilQoxZh9AbkrHjqXojMq0Mlhd
 19IUbupjDFqfWkO/h52Lb3Ky+cGRe5baaS0/CshMkkuzumamLauKPrN7oZ4mgciygnCa
 GUAF9FNd29Q6/0hmaUEBCIy/zspNz14g3NhFnLhpPaADI+BK9i8iZR+YiCg0Xm9xOUpD
 G/X6hjhgkkfjMGUotKKWZ+QWIQQa2xLb5ZG9cUF8YvJRgu2oIvP+zT+bnRj4te7pSJV7
 jsgy/mHPD7YYv9zlCLWL0tW0zXJLdtvzdBWv1YVX8qUYRxFN/cQZvQ6l1QOUTo0qmNJz
 E3Ng==
X-Gm-Message-State: AFq9FYISFxvPfhMdyYJbU2Rg6Hr4xhHyAzNIpA66mYGNtFFWlgwYKkvi
 eisNLmFk1fgnMdBGbo0IjY/2rx5V5Dm/nww172ArOAQOhDWBFcUxfZX/QnazPhvcWcK6yQSO6cI
 HQfi7i8jxUQnIxU0t34HAVCpqP6BSGZUMOJYy4Y7DzfC3Wrx5dJRnh6HtXZBJ88d22g==
X-Gm-Gg: AYBFou2pmfYNdywRRdA6vbldQzhkIszh4aolM3KrChbFhfljPraJ4XaCA/4+1kNieRJ
 Ri/2FG/6eo9tN8svzt8ucAv8Ozt4biBINH2WLXzzaxmNBFz19OKOaUfYdjPlh/c+CtBV6VsndIt
 JbkZP0c8SB24FEaDMU5CJodLL5+FARIr/UGlIjKnFM6ugMC6aTKyQkxWFV5HXYZrg/4rXFOgz+T
 W2ntO0RtRttWjA/aWhniuTdcQKVr3VYKfLdVytnqj0tzwLph6eEsCa3gOHHsZsaEUeybguICsWM
 IUsJuzucip6Ph5ygMc0vdXJoKcI+4RlXUKMb6E7TvGP5S81pc1XBotrIza/rYjyEsrjtBy/F033
 t3FBJmHMwcWq2JO409vez0WCuEAvjPDw2LxBJieR+M4BGalAbK5FykUP+hmrmsR4=
X-Received: by 2002:a17:90b:1652:b0:3ac:9c37:9430 with SMTP id
 98e67ed59e1d1-3adead50e26mr2594792a91.21.1792863430236; 
 Sat, 24 Oct 2026 10:37:10 -0700 (PDT)
X-Received: by 2002:a17:90b:1652:b0:3ac:9c37:9430 with SMTP id
 98e67ed59e1d1-3adead50e26mr2594780a91.21.1792863429834; 
 Sat, 24 Oct 2026 10:37:09 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 15/20] hw/riscv/virt: restrict scope of virt_is_acpi_enabled to
 this file
Date: Sat, 24 Oct 2026 17:36:44 +0000
Message-ID: <20261024173649.7405-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfXxTqZ0gvhrfmG
 PCpJqgHYJULpe9myH1ted8U6FrAuOPM74Go9VQlxEKASv8a8f0VEVyDzevwuY2istOXvWbGsWOA
 rGQbLBzYTY++J7IG8hmdGgzbso9jopM=
X-Proofpoint-ORIG-GUID: m7KlVdL9duFUdw7HKb00ll6YPHD9iJxs
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6adcecc6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=1naKx9kII0DkZoFY_HMA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX/tKdXmXABlW4
 VAIYr+F2OJexzXlbDa1HYbtbclAKATaLvOD7D8eB4RNzogIgsELYJ85ObjHg+vQn0WLtUYMPYG9
 WU/CtPMftcxzTh1a/kkABcdS54CtIUtk4mky9QhFI4pMtcDCGktZH/t3yg5TwxvLqLyl/nAayFl
 SkW12a07njS45XKQWzrve3KjS83S1nf1dxJy3XA86VhK/6Ra+gfnc7UJppke6lekkwrIVChsWVb
 pXTQ8WKzGVNUXoMU7Y4UWsWOBDzwSX4+1uTEL69d1oGEn6/h8qYCGBGM6z6GQUh/LyoHExwD5S+
 a0IqxUqaIwuOPY1Dasid5CloPIfDioX/GN599RmQrG+pn4fKuLaKM7KSHogpvZ5/uxURTe2jf+P
 fF1KcvDjvY3lSp5Z9se9+KDONQJjxv4CmIkX3Q/WjrBIvJLltwrOe6C4HqFu5lTzspBb38a6XPh
 qfonVzJ31SUuKnBKqKw==
X-Proofpoint-GUID: m7KlVdL9duFUdw7HKb00ll6YPHD9iJxs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This removes conflict with the same function from target/arm. To the
opposite of arm target, there is no external caller for this function.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Link: https://lore.kernel.org/qemu-devel/20261024061616.27381-5-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/riscv/virt.c         | 10 +++++-----
 include/hw/riscv/virt.h |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 894cdd97976..2c6f983f83f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -72,6 +72,11 @@ static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
     return riscv_is_kvm_aia_aplic_imsic(msimode);
 }
 
+static bool virt_is_acpi_enabled(RISCVVirtState *s)
+{
+    return s->acpi != ON_OFF_AUTO_OFF;
+}
+
 static bool virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
 {
     bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
@@ -1067,11 +1072,6 @@ static void virt_set_iommu_sys(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
 }
 
-bool virt_is_acpi_enabled(RISCVVirtState *s)
-{
-    return s->acpi != ON_OFF_AUTO_OFF;
-}
-
 static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e516898f9ad..16d86edfcfc 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -121,7 +121,6 @@ enum {
 #define VIRT_PLIC_SIZE(__num_context) \
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
-bool virt_is_acpi_enabled(RISCVVirtState *s);
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
 void virt_acpi_setup(RISCVVirtState *vms);
 
-- 
2.43.0


