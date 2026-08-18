Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EB0C5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPUY-0000jo-7H; Tue, 18 Aug 2026 15:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUW-0000VR-5A
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUU-0007cL-8j
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:55 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH9WH1454263
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vYUY9THMbxSlphfGLkaiGZe14aV8VRcyYJacd8Y/OVk=; b=UoAzHIPxg270xjYL
 evoJKuHzdr4lQUwPsJM8oB6ySYb19H+qPTNy0TBzrRLNPhS1dDari2sLSexngOyI
 x0uU84cRDufoaGXpQFj3PXsHAsRn89b1LVn7KteciID4+byckC5ct3cVWH2Dt1nr
 hPCCUz2bFsUEm8ADg0+hsrwXRsCzybq/+5WebSpvezyGhhnQOZSGXy2OsAWGBuFZ
 fwZLS+nD7XbPqH8r9dHutOo8+4GMYAgnH6eSiK1WKQEmTUFB8Uv/HJRYT4NcW1ZO
 rcvszNQHEhNxvSwDUGJG6eKBMG35y7piqk4+t8+uRXIcnxsffSihuxjxjgEBh3xz
 OqjwQw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qxj1v10-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so436294a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081322; x=1787686122; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vYUY9THMbxSlphfGLkaiGZe14aV8VRcyYJacd8Y/OVk=;
 b=DVGDnaMfFCRN+WIUuvDCA+PPNIABa4wEovs0/Ouf/1hXlnHxhUtSv4/NbzGy73KnsS
 e1W0mqtrhP21Cug3N4UBDqyVcFjuLBPYTnA0bFayYopNoPcic5SbyvgY8q/caakdvpC6
 7mecutdT9kzPF+OHWJgV7h/JbsZRae5Bj8xxjL88E185VFqWN0LjBWYUzUrv+pot5MKu
 ZLEbCVXNFedl5k4ZLa5QQRDqs4DL++kUk7NjsmQWrOcVFhltFv+CyfWB24xU7a6be+Lu
 Id2ogiy0HJuqpej6psQPu8mW7znR2egWQU7xNUTkNqnTrNbmsaznkzsKKlL6v/uyYf1g
 mDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081322; x=1787686122;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vYUY9THMbxSlphfGLkaiGZe14aV8VRcyYJacd8Y/OVk=;
 b=neOJM3Vam0Y3kiz8KM5DJ5pogZdLAJqRNFHl+MJOoiyveRH92XFKQTsmrkzIg4E7xU
 G0a6n/xralQWfrj/QCU3PGu0XyJ0FS80WPESotemtrdcoMrDX6+ZDnLHCY9Dx2IlgeIs
 bZt0b42ZvaEv7JGFvvEKxN8jA2rBawHPgf4abl6dc6TO4tyhqayqoEE7QEl3XIV/ktDx
 TUUj4clEVh+kfjZDI9++lHaxnUzFfitxp87tUBHFQaRqstp3ZxZ+aTGGWLm52p2Fm3Da
 xburI/5hQOdYf+E5/9Umi9VWPtSKTnf3GHAQboMGZh2WnVhvy0oCCqmf+N7SNEWHZSJW
 gTyg==
X-Gm-Message-State: AOJu0YxqMju8O5Yd7IXQM9eSC1S1YcSuaiaMTBW7qbiZzJBGWdQW1xh6
 y+GuxAGxbliRPDMbmSK8IGHVJ/O5mVWID2kmy9ZoUUiGIEMOFhd74j4mxe5wXBPC455HYIqLowI
 QT+cHiu6vZ2A5ZAC/6zyUW5bfXEi6RrHnqcrsVOzz6767Je/1oBh+EmoEEpw95S+8mw==
X-Gm-Gg: AR+sD12K6Xvve/I6kdK0dfi3AU9+U76snCaKCIyEh2ADlmhX4DtAeJMrj34p1tlqocL
 Y13+NI0t83jIpWxD7qGkh/IJbg0Qiyop98fXmMvNR9DM3ShnJsiEyrDbF50UyFElp26SAPVm3PX
 NCOzGLf3CHsZWezdWSSWKn5t+zq1we8laaqdeglDvX3qxvcMPCFHswMTq0GrrbygMZuHLcy0iZN
 MKZxCfKRbNtk2K9ftpFnP6oaj1JDdWFTpf6mBEcNZFqt9XfTvIN/WR9XgCu0UlwAkpSHEGBin8g
 G3p4wHyPVtwnHwICVbm9ZM8hELhofXNiXLV88tKRNvYfWbLYIgwtxOnq51HUTnwVSiwfB6/49T3
 wRZj3C2iZpY/e1UurOBdAER/DviqCRmQ5cM7Wva0qlsmp1ZOnrAUoxHZNDaU=
X-Received: by 2002:a17:90b:4b86:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-3957b0fd540mr208960a91.2.1787081321952; 
 Tue, 18 Aug 2026 12:28:41 -0700 (PDT)
X-Received: by 2002:a17:90b:4b86:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-3957b0fd540mr208897a91.2.1787081321555; 
 Tue, 18 Aug 2026 12:28:41 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 072/104] plugins/api.c: identify or1k pc register and mark
 it as read only
Date: Tue, 18 Aug 2026 19:22:36 +0000
Message-ID: <20260818192309.22169-73-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX/QOdo8MHEMgZ
 pskG500REc1I0t30txhUKakIRK+1zVjtdU9QXQsQWMlc+xa0FwNsl1Ba52R6cBHjwqZBXA8Zqpo
 rBP18903NEdHBdpwwSqdT59Jz5VVeT0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXxl1RPAy0+sc9
 FtwOsKEiH5SlqM7sIsj3hOGS5Gv4uzj6R8gVejswXZXmhP5oLtGs8fGuo2xF7fAVfnmNi181zYq
 WgjtjdFCXS/Z8MpZI1gFMGhR12VyxK5Q56K9/AJGIEy6YFAcwhKGYR9BBVFlo7q1eqK0u0lOn4z
 f9gCIO5/Uk0KXbd5Zi+3HIpyQGpV/yT0BnKR3UAbjBG9qPUMxJCE+eAirw2yOC5Iaqts3S4Mc+F
 IWLyLaDaLIvbLMgigMHfKt/Nfu8+cLlyNnz7fqMiya2O/dy2tICj3HTG7n6SmjalmDCDZj3wDr+
 vrW7iwAflkFbOLrx3eMrnbKi2513nx/sg0J8ZlczYI9Y5QQStbmK0hZJN+J476jxhcmBfocedlM
 5e+C7S8f6fzrLwar4xSOyy9q5bQHwPsuc3DRaAkZQ+O7ONamdCL1q9zsYtmExDgsuz3MbFBQeYA
 4DgHsAWNevG96w6+ajg==
X-Proofpoint-ORIG-GUID: z3gTkD2pCk4QJAPjZUXXQ55xTggJCelh
X-Proofpoint-GUID: z3gTkD2pCk4QJAPjZUXXQ55xTggJCelh
X-Authority-Analysis: v=2.4 cv=bvB8wkai c=1 sm=1 tr=0 ts=6a84b26a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=qpq-EKoDnDwZV1OHMCMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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

plugin registers.c checks if at least one register is read-only, which
was missing for target or1k.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 plugins/api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/api.c b/plugins/api.c
index eb982f9aad7..3520c96f411 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -425,6 +425,7 @@ static const char rip_str[] = "rip"; /* x86_64-specific name for PC */
 static const char pswa_str[] = "pswa"; /* s390x-specific name for PC */
 static const char iaoq_str[] = "iaoq"; /* HP/PA-specific name for PC */
 static const char rpc_str[] = "rpc"; /* microblaze-specific name for PC */
+static const char ppc_str[] = "ppc"; /* or1k-specific name for PC */
 static GArray *create_register_handles(GArray *gdbstub_regs)
 {
     GArray *find_data = g_array_new(true, true,
@@ -449,6 +450,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
             || g_strcmp0(desc.name, pswa_str) == 0
             || g_strcmp0(desc.name, iaoq_str) == 0
             || g_strcmp0(desc.name, rpc_str) == 0
+            || g_strcmp0(desc.name, ppc_str) == 0
            ) {
             desc.is_readonly = true;
             plugin_ro_bit = 1;
-- 
2.43.0


