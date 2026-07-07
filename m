Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CF6C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh6Hr-0003dm-4d; Tue, 07 Jul 2026 09:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh6Hq-0003d7-0G
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:56:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh6Ho-00008g-FT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:56:33 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8XMB3741931
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 12ntz0riBx4+nic6fgWGFvlIIoRgNjt6n/klVAeq7qU=; b=fTsLOVdFOGMdH7dF
 TN/G4kyM5KTX3wdL+U7EFYP/HEFCvff2/qG40uxmQvXN4sjU5fP3gkByB9sZSq+e
 VOvcZm3lUPEEJ/m8+qGMZjZUMG6wHgkKHGQRS47deS0v2hL6+Hn+UFqiVXgpRIQu
 eF1BTgDRXovp/1E//rJMdpNX400w4P3gVLDqMNdcCk1wjjgDvClOdCaEU5ar2IeV
 6uIcyJZRuFilHX5haC8GOp38vbdKvNOmW+xekpeU2Vza3iFy+1bWOGOtFOixaiTy
 f8L6K9TAJdpKCQEakAsm1rXnfpgU4udt5R2pjranWh6jK5tYwq1x6wccFcbD3UiG
 QV3SFA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8ye0gv32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:56:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0ab07320so38593171cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783432590; x=1784037390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=12ntz0riBx4+nic6fgWGFvlIIoRgNjt6n/klVAeq7qU=;
 b=Eaj7dSICcF5QXtuV0Lqfmudz0jkbdVN6D67VUcmZLZFWKG05VJldP8usKp5lCTZMSH
 Cti1Gpf8+M1fLMjJZQTgImw+sqa8z5G6sQeOdQX2X5fllzehwGpk0uyT5LLn7pI5/nlf
 lcFBPSGhNE/wKz5WnZShKzQyEc+pwmXSneHLflzjDHqXV5HOj8trJ5qDK9TUzuU5T7M7
 sG3EQ6eJM1HOibmD8RCPCMnNHVksNElYwd1VZg6sl1UTx4ZxvVkNFeNE87CnBy+fXQyk
 ZYL74C/RfISc8sEuXVtnc5+noIiPi0rnImEuLxebTwfY+lNjPRhDVTClrOE/vBctN11E
 di1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783432590; x=1784037390;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=12ntz0riBx4+nic6fgWGFvlIIoRgNjt6n/klVAeq7qU=;
 b=YQ/fFFARYRVuNGf9B7xgxluzmylJ7zzSRbSjIJxaA91mIQLBgNW+W0z2soq+1KFVpr
 ofghlcersZGd8pAIzIogLXWyv7b6VEmvYVAAuAo4wIjs1Vx9Zk/G6Ztxw75I9/ylL/+0
 Oe/NjCRdbf4V9hKiLg93d/O7h46sHHYVROt6WsrG9U1P7mHLibLsIjWs3pEMiHaIFMob
 xH7328uLvlmNooq7x27hD5UfaG5ZrbKNNtPIBekb0cF6toGJG7UvM5EsxaUjIotwFf4L
 Mkrlo+kuXS+c7SGAXHhN+I7NX2vy3skfu10haK6CmTemjdu7ze+ZYugaJg65rD8GuRKe
 EMlg==
X-Gm-Message-State: AOJu0YxdRWh8MwJMUcewJfJR+jFsESA9K4gcvRP3W/0AIol2LrDAjPWO
 eB8nMkloSnSoIpPZa76/G+CQq/dMdHKTO3qUdshYRzX/vrpYZVTVoqwQycctl0oM/K0tQcw3EJz
 lbm7rWKWQALwCLcCGul0miVrI533gc3oph9lNNV5PpwomgrtBld+OhFoNqNg3hNZo5A==
X-Gm-Gg: AfdE7clOCfVQVnd5L1npNgOT77MY0dUTHUeFmvI2GF1QVHFeVXUzp6JufGNdAMTBUA5
 iEPX0yAzS3JD3dbkXApnnn564+g8el4l0p0FbqeM8XtST29EXCVG7Tqw1tuAeNFrtDxt6j9aWJm
 I+/eXezm1Ef705HxC6+94OPMjxEscpON1XlFYE/Kepanpf7mh6Ego+qdZbXLGsHVavLVCgTxxBo
 6VzvfXyaY3MNTCy5E50DpbKDqWF26KjjjdyN7WWOlqHioOjH2KRjq+AVp7eidRdGhx0X+3174x1
 G3hKtIZhqxppcTV4NWMVhHSemgqvJ1IQoW7X6KXJmGfbMve3cLqCHeE/tG8s64AjwbbIdt4YFun
 nqzTYznGP+TfKIS0WSRYrsD3YhnhjtW86BFO4eG4tYChEp/3ZsAEec6HxUjT0b9UgLGus
X-Received: by 2002:ac8:7c42:0:b0:51a:8c9b:649b with SMTP id
 d75a77b69052e-51c7487dfafmr56962731cf.63.1783432589996; 
 Tue, 07 Jul 2026 06:56:29 -0700 (PDT)
X-Received: by 2002:ac8:7c42:0:b0:51a:8c9b:649b with SMTP id
 d75a77b69052e-51c7487dfafmr56962021cf.63.1783432589026; 
 Tue, 07 Jul 2026 06:56:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f5b811sm90818245e9.13.2026.07.07.06.56.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:56:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 1/4] system: Select WHPX by default when no other accelerator
 is available
Date: Tue,  7 Jul 2026 15:56:15 +0200
Message-ID: <20260707135618.53561-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707135618.53561-1-philmd@oss.qualcomm.com>
References: <20260707135618.53561-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: __BGKTJgZ3sUEz98s_QwZajqJCl0jw7I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEzNiBTYWx0ZWRfX4UV2uiOFWQyy
 9VqfI124MTIJqxuiovivNrwx3ZGTdtk3CMHrJQT0cv9gxi1//znaX5urWd57v/w03IZ730nbvYE
 JhewhcBEaOUv6KuwFP9T4LgIhkxQW0Y=
X-Authority-Analysis: v=2.4 cv=SZfHsPRu c=1 sm=1 tr=0 ts=6a4d058f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=m5lraNmIkCb9aVCCOlYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: __BGKTJgZ3sUEz98s_QwZajqJCl0jw7I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEzNiBTYWx0ZWRfXz1tKfIHSNvz7
 0XwnGxTxzKS8w0g+iR37s5U6JyF78vH9dJo6SHgT5c1UyrXtP9DZTY0hAukjQUDHzNSdBQDN++P
 obq5n9+Nwee08K0Nz9LRHVR3+drlu5pM+U4H9xTlmQaeqjb5JDKlMjraQ33c4u29ONbk4F6wTP2
 hgrwwoXmTs7sr2bn0DEp8ue7gEQruFvIEIdG+wD5Aos56g+uuoyjX56PjsA7XuRAK2xOsk7WkeU
 HoEztxruoHwVFOc6kai4ALbbnz67VvjjmsoNq6O82oNbhnymBrZ+o2oQJELYDpTrDv1A/L4ltPT
 3AKnalM9tluhg07HFedMfX0X6mdH9Qrg2efKWgb/dzEoVJWEtVLPvUpRv9Qzl3rnrvw30UHTwhf
 Lz0glFriO3BkWfkLtr+iGQYlMYsmVmX9WDrbnZ8KxKDkEroOQt2XHP1zjm8idP7wmNWWVIlF3VL
 yjT3NgvT4JDC+5tk5cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070136
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

When testing with a WHPX-only binary, we get:

  qemu-system-aarch64.exe: No accelerator selected and no default accelerator available

Fix by checking for WHPX in configure_accelerators() and using
it by default when no other accelerator is available, similarly
to commit 964d2a0cf81 ("system: Select HVF by default ...").

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 system/vl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/system/vl.c b/system/vl.c
index 1d14e2e2076..4f6d1e1ca8b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2444,6 +2444,7 @@ static void configure_accelerators(const char *progname)
             bool have_tcg = accel_find("tcg");
             bool have_kvm = accel_find("kvm");
             bool have_hvf = accel_find("hvf");
+            const bool have_whpx = accel_find("whpx");
 
             if (have_tcg && have_kvm) {
                 if (g_str_has_suffix(progname, "kvm")) {
@@ -2458,6 +2459,8 @@ static void configure_accelerators(const char *progname)
                 accelerators = "tcg";
             } else if (have_hvf) {
                 accelerators = "hvf";
+            } else if (have_whpx) {
+                accelerators = "whpx";
             } else {
                 error_report("No accelerator selected and"
                              " no default accelerator available");
-- 
2.53.0


