Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33516C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wls0i-0000Ag-S6; Mon, 20 Jul 2026 13:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzW-00081O-OQ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzS-0002y3-V0
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:21 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KH6cPZ2962635
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7vL7GOvmzf4
 GR2lrP8sRDhksG+QOV9mtUHkgP8VS2iY=; b=VTUwSvS6F5zf0/9qr2Z+H/aZIpG
 MWXR38btjp2IiKWOSbaQ2ALGX6v4gFILEOZQhoeNQIvIIqDxcoS64PqZpF9iRFM0
 scW8CYASkt5tpVcGVrWo9UrfkWU7R38Uycv5ELxr9djS6RCivZLX8OwRA+UuIeZM
 EdyA7E6c569Ji67jJHIy+aNsF28L6Uc4mJIGP6Fj2NuNa1mmrDpvRLVB0YlsWVtY
 +grqRY322cIw+eCFzhADqsDaX5G8eHr4nBWSXnqJo/sE8RbIjsmOmD008TYrERb6
 njRI5ynxJcKvCFkpei95+m5wFNkx3YbRgvXiy6XeRr7ai//oDmio/0MFWVQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhh5y277t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cce14a21faso65730455ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784569277; x=1785174077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7vL7GOvmzf4GR2lrP8sRDhksG+QOV9mtUHkgP8VS2iY=;
 b=L3mIpjbJ66qRYxok561vF+IRApIIc4GGk+yIdjEqpwsePecRZRm7dd6upylpwBfzR1
 aKDiVDJpKn5NN/CTrgbWlN2IhobEv28Bj1HYW7kthYBn0/K9zMyb+PojlY5DMMl0mnKr
 fEShLP8aHgjfEVzesd+9IKT249OJKf8LcY6+AQbzVAiuiM3lnca8I5zxPOixpU+6UcTH
 4RTIFEgwIFFvD6T5/eFxU1jgqscaq5N8sIS1hTDaWNWW8gp4k0pbFStxdpRCEOvnw6VS
 ZlnmbEjTt2dBd8crVIq2r+XHtr8oqW2X9VVHn2KTDs7AccZIevfUrIBiU0JiSLMkjRQo
 xwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569277; x=1785174077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7vL7GOvmzf4GR2lrP8sRDhksG+QOV9mtUHkgP8VS2iY=;
 b=aVFm4xNskmsknAt2TyBjB3m9NxvsKAO3HbH4W8qT/w2Oidu6OoKZ+QHv2I44qfM0E8
 gzvcUhlXuSc4FjJ8FoO2Kk/K68eCt2sYIszvlnVs8Ud9q2i/4EnNvbtw5lMw4K6eZFaL
 OV0se9QMLTLlZiTDlDpPZst+qSW2T7f+AalQfxz1+fUAZfe71Y1fjfOSMYB2b+8SeKCE
 LUMIATME9zBT7CkhjXCqbQ1Qly9aaBgSUVz4Sty0dWVJzjlbNS+SlfiBBzT3HfPFj8Tn
 /GeD9+CftcIok+7qGeQvx0cjpEbSxxnqov4y0RNLjML9PcyCdSlExR3y/JScLA0+DVWG
 93Og==
X-Gm-Message-State: AOJu0YydyvLhLhrEiCQT5cj2PDuVWxId0ophjprT6X02lToh11qsZKG2
 GsTnjWzN9LUpxunVXv9DDoso/tfHVIqbDDELoe2zj1Vz3dSHyOqCJMiHTN8RuCytCNOfMNK6fub
 vN/l4tCVKwM7sUjiQNgzFdObnHIPx0/C3yJF8LBzqtRkrEXDIRL0Om60hJypc1pIbAg==
X-Gm-Gg: AR+sD11UE3MhHtj1+BKXxQAYepCGyQ7KUNkLzmVzxQ1rQ3o/FrM1wCajUtdUeEM/NGs
 e4VTMxFV6WhbifiE0zwgoNoDgDhgdTSOU7FiYqpCsB5GmYvaFaiWrbfywxyAv5up2P0I2IJ/+BD
 X+8gSNo/ZIs/FFragYc81bwpp5380/WODSG8WJACKrLBA/KcAYgPJVVqDIvNwsopzITwnG7946d
 wAN+lv1ckjE8g3r0mUkxuMoDTkNF03UEITCtOcE3eNTp7b7aEkw0U+LGLEAS3X6sGGpdiOhYZEd
 e4b/4SDaWccUou1UCzgkRzSAGDZmi9YLvOV48ryKKgzOgNM77JdjkXkDUT9l4le0+H076+LpUa8
 iQ/ncApHwRGvLfo1nGiVXkLMAC2acPjsyo1W+krZfikjFWzV6s/sQTcbE9WNngZg=
X-Received: by 2002:a17:903:3810:b0:2c9:fc0d:165b with SMTP id
 d9443c01a7336-2cf1f544ef8mr200545725ad.23.1784569276823; 
 Mon, 20 Jul 2026 10:41:16 -0700 (PDT)
X-Received: by 2002:a17:903:3810:b0:2c9:fc0d:165b with SMTP id
 d9443c01a7336-2cf1f544ef8mr200545385ad.23.1784569276370; 
 Mon, 20 Jul 2026 10:41:16 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm66281257eec.21.2026.07.20.10.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:41:15 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 05/13] semihosting: add APIs for chardev-aware guest fd
 routing
Date: Mon, 20 Jul 2026 10:41:01 -0700
Message-Id: <c540d8251f2c924a883ed92040fc5ca5e02b0d44.1784568922.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX6dPeJikh+Nu3
 XCINkRrNsqNn3y7msibSQT6Q62MoUoKNdHmNDUXOzY5qhr2ML8GfuZb+M6Q4gkMOPj5EyHXWz4r
 w8ZBwq/Uek6LxHOjdEvE8/wmdg0EDZQ=
X-Proofpoint-GUID: XaJiSHFVrkUtVZHDD7-A3o65HAYwESEx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfXw6Pzkiv2e++E
 8YaYu9i/Qpk01gKt6f4yUq6AgxaJpHRwU0VzkxJKyk6egpJDVmiLHzcyLBKX8tjJuqp18gqFt6k
 PyGRcO80iw5NWrSx7KbAXMfA9ZlW0tqcf64NuhqUay467sxKhsW22ffoGgIYZvGLMXNRaE3HP9V
 EVD1ifbdklVwFey3K6l+Ld/R799U/ymlkeh2H6tjW5p/tJtESydJIfNXRbNxDQCQxW9I5ccqbw6
 dAuyIAHvVJxONzTtf2tLCJXpTXTiNDvgqzGLyjScHr8wYTlHoxob8kwsZn8eepaF2cayiW+Y3GG
 XowipdmSDhemrKtllPpGdfgg+IArnrZAZQGZ5jtVQpJvs/Trj2Vih9SHmwj9iM+JUxXbdVLFUXg
 ERUdFHMR4CNFLl6mry/FF+XkqykGhgLcnyW00qLMwHnqEXJMnQ/SD+Cy5U+Q2k16sO2Uc8XJzq5
 aWgkQmeGF3K+AUjr61Q==
X-Proofpoint-ORIG-GUID: XaJiSHFVrkUtVZHDD7-A3o65HAYwESEx
X-Authority-Analysis: v=2.4 cv=f/x4wuyM c=1 sm=1 tr=0 ts=6a5e5dbd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=4trHgkiC9q-UxXHgwkcA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200193
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

Add qemu_semihosting_console_has_chardev() to query whether the
semihosting console is backed by a chardev, and console_guestfd()
to initialize a guest file descriptor as GuestFDConsole.

These APIs enable callers to route semihosting I/O through a chardev
rather than directly to host stdio.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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


