Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B81FC44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMwF-0005ij-Oz; Mon, 13 Jul 2026 16:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwD-0005hQ-K4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwB-0006Qi-VA
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:37 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9QcM2256804
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LTrzTFdhnWg
 nel7SJyOcI5W7KPgZREsyRW5niRBi9o8=; b=ksx/g0yN0IiCF9LvZutEC7fQxC0
 y+OlydMBN6BAnF0mGYpLOtfGre8P0UrjwngQ54rnOWLT1f7CdCLfsRLdxX+DoSMO
 XqKireTTJiIUJ3FPM6+rWg4Qjiu/Di5st0JgCsbHxRvyA2splmv/FYv1G18SMIrD
 /qMIRFun7UUrdKfYMy74IW7WkcfzdqJbEBlcTEu1/0moGxqeha4Kdq+J5LEkXvBi
 ERMwkvbdHyc/NWzU8QqJw0Vq61nCEeSqneC+k+r7o+wIPxBg1aOwe9/wvDP7as5T
 Mx6kMfcOXlJUm1gat5h8kxKBX9H9M7v6Fff2wWKZuAVArptE9EmpUpJu9tw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9tdws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e04a53a7aso1237252a91.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973254; x=1784578054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LTrzTFdhnWgnel7SJyOcI5W7KPgZREsyRW5niRBi9o8=;
 b=SpmLfw5gF91e9c6S1llGHm7z5uM6j4GD7N6qUj3WrE5CVNrAx6UecmWeDjRKtEm9TI
 BxyqRMzj29OqknJ8btmLR+YcqyRZQRwCsOVjLZEvxthE2LAkSIIieZRkxvWUz3Qg5n2h
 FaazqvP6/GGGKVJVGSCCEG7u13Y36fS2j0Vd5BdF1M5XW4sEiKwUyx+UEf0MXuSnTv9t
 Vk9h9vAQtPAUtXxvYjwlV8LlyxpnYv8hkYFJ0yM00IbUCR/B61i0Oc5AmjBLnyODkmlT
 REh978yJBHYSG+Btj5/Ne0xqBE4KKOdWZuMbpwxZme2Y7TUIJYMpCmRvEEZS2vJhUY77
 pKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973254; x=1784578054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LTrzTFdhnWgnel7SJyOcI5W7KPgZREsyRW5niRBi9o8=;
 b=kW/pdmeEEWEoEjYdhweeKIEJos6duZ+cs6M6QBlKi5rS/AKlwJyuCwRSuA3tTfXm4f
 tyQ9MM9xk0EPJG2XkaTVI+0dM7iUfN6uqN6hh5A9Wo9zysIekosBt8bSnT3FTkhRZLJ6
 TrHiB9yIHUr7JLzT/6ZDgirVhyT7cRkqa4i5eR4Rggh9gD8FuG5C9RpurybEUx1y03j/
 hYhVFUNZ06R+8YC/Jz0VQF6pmrO5yU5SL0g7r3U72gKaqfsY5fOXKJVBcFQJrXwv1cjA
 EMf7qLPpmHRkB28Ie2BpvNEbQH0ATYe1sAuH2wRgELUB4Z06/Bi6fHYi3iTy36GRyCjT
 TLWg==
X-Gm-Message-State: AOJu0YyfdajtVgnCdSQ+9u0RuSDlADepgGLJg4sIlCvjoauaQV75CMd/
 d5MGCfF4SgKRTN1dQ3VuH911s9J78M27TAkMaM1YAFLNNxjkcYeCXCMmgVcOb+BwbWssuDgth5A
 uPF4VmNnfGSLu1GGpLUZEVVHCkOYLFRbwO9hceWkZbLp03Y/K4w0z+/G5CHtJ0rQPVPWl
X-Gm-Gg: AfdE7cmHa5NVlOMS1gKtsVWi6SZT6wcPLkSzkBVefK+W0BvnWqVlrdrNfPwKPMiBOE1
 5HP3kFHVgl260gIdSKO+ok6NUSHHlS3J3b8W/WTNbCtSbULBtPxCFjt7WVGd0VgRc6v9lY1GQDZ
 e3tn52xBMVQcnZJpQe4ZAJDNuPV/90YYzLhaUFPCuMjDo9aDCPdGNRxWmYz4EFnWeTkjLWOOANb
 6Y62TFM64Xzi7rDvt7g36AktiXW03VXBEl02SjSdL2+Gr+nfyj1pfA/KWz8nQDJV/FPMDdmr/Z7
 vFK2nlklkMU4Psnc43+7X2xJEr4gInjcHL77aOd1k+kqQbduc20fVD4B8yPw+BPTph2wnKMFkUk
 /ViJuItoTV2rKoLt/ozo7vgEZd2d3SeMDPs3tZvoj4IMRCMozJ06TdwXolkH2RlrRkX5E3OHVXQ
 ==
X-Received: by 2002:a17:90b:1c91:b0:380:534f:58c2 with SMTP id
 98e67ed59e1d1-38dc7b81c27mr8988482a91.30.1783973254041; 
 Mon, 13 Jul 2026 13:07:34 -0700 (PDT)
X-Received: by 2002:a17:90b:1c91:b0:380:534f:58c2 with SMTP id
 98e67ed59e1d1-38dc7b81c27mr8988468a91.30.1783973253632; 
 Mon, 13 Jul 2026 13:07:33 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:33 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 06/14] semihosting: add APIs for chardev-aware guest fd routing
Date: Mon, 13 Jul 2026 13:07:14 -0700
Message-Id: <726a21863495a931183c24519cec26026eb01b14.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfXx0POqa/TBicR
 Q23gEVXY2nDwOkBB/oSiT1ogZ9WafXeYSMSgPTEctFUOUqmlYrD6dCfpVcjIMx7/C10lCWRDlBi
 8FCNQyNy3mDaYzNzU+F4pmEBHOgvuRgCAKMEp0tEzxZVBQ3eHBV8W7C8dq6TcW5JP0SEP2SRFxY
 haxCz3U9XEim5o5o1ay75PumCtJuw9p4DArsWM43ZI+fLA6G8Z7Jfa68sswKcrnNK21HMSW/lrd
 hU+Ilgprs3YFV84VYxn4SMOgnL27z39ZZOyTXXlbpFBwGWAQyZDhlEQ2SARxDRChu9EUTNRUDBB
 YeKe/RiqtwrH/vEodD7jJkGz1t7zj5l6SJ+z7Z2kolMe1+Ix+oxuuZWf9TF89C5H2loA/dVFhXq
 jgLQ6DXK9TdfLW5PDA8kBsgFBX4+QaJSJJMBPfHfuXtRuW84FIpIM/kA/Ee2r8oDWU3UZmtYigc
 d8z44mSQZnp8G275JMQ==
X-Proofpoint-ORIG-GUID: xWPhXvkzcFkFJMcZ_oZxO8aUt786EZFw
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a554586 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=4trHgkiC9q-UxXHgwkcA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: xWPhXvkzcFkFJMcZ_oZxO8aUt786EZFw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX7m9Iu+i6ohXs
 HeW7EWukq9DTs+VKvaqyGhq3a6cRfHPCCk35D9UVEwK17o/qfFW7g3OTEKYjLmHZW4p6A2eIO0F
 jWMH1tXTZhGnEGnei2sq7bokkqiSMFo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130208
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

Add qemu_semihosting_console_has_chardev() to query whether the
semihosting console is backed by a chardev, and console_guestfd()
to initialize a guest file descriptor as GuestFDConsole.

These APIs enable callers to route semihosting I/O through a chardev
rather than directly to host stdio.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 include/semihosting/console.h | 9 +++++++++
 include/semihosting/guestfd.h | 9 +++++++++
 semihosting/console.c         | 5 +++++
 semihosting/guestfd.c         | 8 ++++++++
 4 files changed, 31 insertions(+)

diff --git a/include/semihosting/console.h b/include/semihosting/console.h
index 1c12e178ee3..d5f149e2088 100644
--- a/include/semihosting/console.h
+++ b/include/semihosting/console.h
@@ -54,4 +54,13 @@ void qemu_semihosting_console_block_until_ready(CPUState *cs);
  */
 bool qemu_semihosting_console_ready(void);
 
+/**
+ * qemu_semihosting_console_has_chardev:
+ *
+ * Return true if the semihosting console is backed by a chardev.
+ * When true, console I/O goes through the chardev rather than
+ * host stdio.
+ */
+bool qemu_semihosting_console_has_chardev(void);
+
 #endif /* SEMIHOST_CONSOLE_H */
diff --git a/include/semihosting/guestfd.h b/include/semihosting/guestfd.h
index a7ea1041ea0..76ca0fcf1a7 100644
--- a/include/semihosting/guestfd.h
+++ b/include/semihosting/guestfd.h
@@ -70,6 +70,15 @@ GuestFD *get_guestfd(int guestfd);
  */
 void associate_guestfd(int guestfd, int hostfd);
 
+/**
+ * console_guestfd:
+ * @guestfd: GuestFD index
+ *
+ * Initialize the GuestFD for @guestfd to GuestFDConsole.
+ * I/O will be routed through the semihosting console chardev.
+ */
+void console_guestfd(int guestfd);
+
 /**
  * staticfile_guestfd:
  * @guestfd: GuestFD index
diff --git a/semihosting/console.c b/semihosting/console.c
index 91e5d50d502..9d786833564 100644
--- a/semihosting/console.c
+++ b/semihosting/console.c
@@ -108,6 +108,11 @@ int qemu_semihosting_console_read(CPUState *cs, void *buf, int len)
     return ret;
 }
 
+bool qemu_semihosting_console_has_chardev(void)
+{
+    return console.chr != NULL;
+}
+
 int qemu_semihosting_console_write(void *buf, int len)
 {
     if (console.chr) {
diff --git a/semihosting/guestfd.c b/semihosting/guestfd.c
index e8f236c690c..8b5770bab0d 100644
--- a/semihosting/guestfd.c
+++ b/semihosting/guestfd.c
@@ -117,6 +117,14 @@ void associate_guestfd(int guestfd, int hostfd)
     gf->hostfd = hostfd;
 }
 
+void console_guestfd(int guestfd)
+{
+    GuestFD *gf = do_get_guestfd(guestfd);
+
+    assert(gf);
+    gf->type = GuestFDConsole;
+}
+
 void staticfile_guestfd(int guestfd, const uint8_t *data, size_t len)
 {
     GuestFD *gf = do_get_guestfd(guestfd);
-- 
2.37.2


