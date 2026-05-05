Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3309CD343B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 22:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOZB-0006Oz-HZ; Tue, 05 May 2026 18:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOZ9-0006OO-N3
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:48:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOZ8-00069q-2O
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:48:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645EL5Xt152202
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 22:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tSmPencAU5o
 10CcjukLavzqfOdGbkNhhQxdywYnluD8=; b=n06kKgnPmjWFsrH+f1AhvmjD6/H
 yjD0JLNejEtDHfFI59wZv7kISGSFat1IVDrB7zarbrfXM8eELrnOzKKEtuaOegct
 uj/mqUDMEZS8Hd9ccvF2gefkLQvCglx+xr0oYUzH0djZ/HBZ/87JaGlHdE0pXj9X
 7wDijBa+DuR0xcC6oIZzIbkFI0hlVTCA/77tSaHo5vbqK3hlvCmKzhKbGk7FAK/S
 zLAeQjDBA4malfljId1cTwgoNTrtUfdu1pUDgBR0cOksayOk3ymGyhbquL/3PWtQ
 rvQMkGFRZZKLZ41wSUtaAI5HJKgv16aIjMGcUmkv14Njg97t0cryQnwXtew==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyj809x8g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 22:48:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ee34588671so5847459eec.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778021312; x=1778626112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSmPencAU5o10CcjukLavzqfOdGbkNhhQxdywYnluD8=;
 b=FxaEjcIgeLI+rM0Hm9PwXQI9/S0gWfzTdrNdPj7JBNBCGEahlR2EUulAhQ5+EGIvur
 jHgxlpybRs5k/YXDYsSEXx3bCeA/Uesp2eHZa3pHjxn1/0gYNvY25l2DyhJHS/R/iDvp
 G32wCIN9uV2sioyl+mko0EU1ITksPnSXD2sBV0X5ujHqJNiaDFtyDta2PthKXtfS3MHK
 j5iBmuePnzpzB/eBqbIVeKNzkjnzvmdw+mrvjHxA4iDOctDVHXuiD6ujxuHD76h55r9Q
 xFSa3vIYIa7WiFAyecJ8/Xq7Zr9GHEjQzSZjC2IDAELdSnlQX4HCfDedE2guwnmCdajR
 d8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778021312; x=1778626112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tSmPencAU5o10CcjukLavzqfOdGbkNhhQxdywYnluD8=;
 b=Y40+m6yZmjbaQ2E73i30ooASE3I4tpp0ENFiNqEfdoPhowVH9S74VkrmPRlp5yfasE
 dkMKBKO7n7Sv+E3p//FfDGe6+GHj/rfrBfVOsJ5lA9srROyUsd4jJVaoNFGXQ5uJk7pt
 5E43BKD/qzizlJpiXgoVAyHuDmiKFMiZRcUzvmpdRV2PbJRQNzRbrC0jnLoPhJrqFDJd
 bM2PGi+t0SC4NeEtf8yQQlAS5PXJLPOhRftXvfaBL2iPCsZZJhLz65MHXBoFPioGR/zY
 re2m4dxZOfmaespbAjBBMhCKCsCSC9RZl5vVsu4FQ16IWWAvzC6aU/tF4nimUZsPg4ut
 tRVg==
X-Gm-Message-State: AOJu0YzoEWw398Cjep+XkRZj2iaQOdkgt008fWhFLyzJn3fNPPwTETUU
 XXjjYAmQKNDDAMdaHinmhn002fVWDAY8ftwdggtkb/4EnNPrw0YiQlRggW7BAM6y9ZntV/fyXxW
 giG2l3j64NUMsG1e4VCd5DYRrorFfTqMra5UyrACFM/jASBofQbCEqa2TkfLEmDSXAWuR
X-Gm-Gg: AeBDies9vGR+Gh6l/zLdrFih9wbPyqrYlhOsqbzlSWvWY9RuxKkxZO4SMzfv1yzV8j+
 SaknUMTike14AJl0YGnpj6MaRRVFYiglf4atWaKhC6YK6T3G/36SSeICfYK+h6cjK2An2HBjzOx
 sqNYktlO/pU39MN/zf3sVNVdg0W/Znnsx8TlvGTCp4P7eDLIqw4hRlYf04skSh018gwvdNdJr9E
 8Ox1c18ItNOO9Q2h4aeX5tH94mlcFxe6qpD1RZGj2/cx4r+3htulRoHXWGUkl06T0AKM0xGgSt+
 OtdLEF4bXwfX99ldpddDXMl3A2UUK9ncod9xuBrvsB/YNQH/fKYXXEN9deSS5ewKdPinKDuT4b6
 sc19pisAUbJXYNE9AlyYXbQcsdfJGWEqeCSN3FltsFnb2bkg5Cp3g96SSwNeJaTTLEVmVWsfqZg
 0E9RTaIoVt6KvoKxbm
X-Received: by 2002:a05:7301:fa0d:b0:2d9:2b54:ea9c with SMTP id
 5a478bee46e88-2f549f7c312mr658855eec.18.1778021311712; 
 Tue, 05 May 2026 15:48:31 -0700 (PDT)
X-Received: by 2002:a05:7301:fa0d:b0:2d9:2b54:ea9c with SMTP id
 5a478bee46e88-2f549f7c312mr658830eec.18.1778021311039; 
 Tue, 05 May 2026 15:48:31 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56d4cf2fdsm898953eec.8.2026.05.05.15.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:48:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 2/6] qom/object: register OBJECT and INTERFACE QOM types
 before main
Date: Tue,  5 May 2026 15:48:22 -0700
Message-ID: <20260505224826.2698753-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XvnK/1F9 c=1 sm=1 tr=0 ts=69fa73c0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=VDdTCajPACCFXhBZtZ0A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: TUOxzSlVbzge6tsIqnPMGFvwQ-bAHws7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyMiBTYWx0ZWRfX/7mhO0ALR/Ju
 9S116oyh0SivE5W7R44RNmSX83QGhfEjkQiOGtuTOgBibBfm+1jH2UAJyyklByw87b1F1GMLxIv
 fB+G3wqJJ2W6vbZL/ioisNgB6P03/RnbFwOnYlJ6xMg2krlBBB+cpiMBHvjBZFaADsQrqrYz95H
 kLjlsEmje3hSAoyURq51v02t3NCUxBDcGAyUa0MnZOkyrAS+3YehO9AzprO7qVmVJ7Cgq/SBk5+
 D4Csllcs0pG9QcUI64DorbIIe1UD158Xe9jZCioXz00O/tmZuGAFpeBGljewTnY6d8VnnXfqME4
 EnmZ7vIB7rMefA5j8nTne4gE/RqDHBgJ8HsfPWwoGSqo5bk83E/XJtDFdJlNWUnM+3drd1cxJBw
 dIFs12KGWuFVFplgGI/9PMbQlfillapE3NrLACTjjVsCNlimVGHAPN3iaCsE/CfAxW+v4++BfdR
 T/ZvMvWJHepsr3tY2GA==
X-Proofpoint-GUID: TUOxzSlVbzge6tsIqnPMGFvwQ-bAHws7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050222
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Those types are special, as they are the base of all other QOM types. In
next commit, we'll introduce an extra step in module initialization for
target-info-* types.

However, those types depend on TYPE_OBJECT, which is only registered
at MODULE_INIT_QOM step.

To avoid having to introduce another step, and modify all code calling
module_call_init(MODULE_INIT_QOM), we simply register those base types
directly in the static constructor, before anything else.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 qom/object.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index f981e270440..a5d268d0722 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2839,7 +2839,7 @@ static void object_class_init(ObjectClass *klass, const void *data)
                                   NULL);
 }
 
-static void register_types(void)
+static void __attribute__((constructor)) register_types(void)
 {
     static const TypeInfo interface_info = {
         .name = TYPE_INTERFACE,
@@ -2857,5 +2857,3 @@ static void register_types(void)
     type_interface = type_register_internal(&interface_info);
     type_register_internal(&object_info);
 }
-
-type_init(register_types)
-- 
2.43.0


