Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F35C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgry9-0002hV-Ar; Mon, 06 Jul 2026 18:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxs-00026f-RT
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxr-00076X-9u
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:00 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDsiq1495400
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MnRkpxQE3Vw
 Kcg/g36v33mQh3rkbuIPYwao2cxo5LOc=; b=axHPoWLcUhWvC1qbnkaVq/wCOWj
 c7vG9/Va3rJPH56R/PoNINJCI/Bio93vqIyMpmj0j6tMH5kACCWeEtCPD+fUo60d
 e20WkYsoRW81AB7IndcJG54IYVfDMsr2M1KQWmVWkSQzHoRdUzpEQwA22YX1Crp8
 YAukYEirgVTD7+IhFIGF8DMr6ozGQpAbNsRRxflyOqqq39yUO57zTS8X3b/KJ23Z
 dro8sgCau+0EWZ9f2wECkUhCH1XArdC0B60fVYMJDM6F7aQzMUwSeVBDR8d8UcuJ
 4s+cAUXX0ipVyws6W++SOEa+FLrR+GKImOAQRn8LMatBrdSLLeOOWSONB1A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8bgsd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88fc985a65so5918448a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377537; x=1783982337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MnRkpxQE3VwKcg/g36v33mQh3rkbuIPYwao2cxo5LOc=;
 b=frsbI9lLn3bTrvaTwrc4TRnMqiQzV2Zun6XIgek9L707Tc0GtsFhB9w5P/kLhjmNG0
 aRnENRx5CiGENQE2HsZTF0HXzuZ5IXvsZu943bhs6zHXHjGtWlVtsBJLyi3eff+0Wjxy
 qqJfHcBL1yLrzMj7bwCiXWQ64U3hqUgbnitKghgmkTqwfP75mIn7zbiBGuNdC+9VdloR
 8UAZSplpiMPdQlLoT5E2DGBz2eb6eOea+uaBOKpUHVeBEQfMFznhoMYi2OuzdKXU5rlo
 JfrNaig9XgdFpJI5eqZzW8rWFuTIiq/6bpw0Q8kZj/IOvCFrAKDgGq23WFPnopBtJj/k
 dTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377537; x=1783982337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MnRkpxQE3VwKcg/g36v33mQh3rkbuIPYwao2cxo5LOc=;
 b=qJQ6uPuke38qlXmAR1JgPcLCsXJuEnnNw74Dtr5s7ypbgd8ggsS02dQ/XEfnWirGCp
 GTC5a9UbRddGXPyotEHQ3kwklBMuX6hmhT0N7we4xHniyAUpkSYlCkGrKgzRCJGCmBfN
 H22vo3k4ef0Ay3KLEDZrvQAMrP0wg29g065y2ETTwAFhNvHmiZQHyv3Wt6ZVYpcPKvb8
 xGuFomXdfiGs+bjiYBaR23PlK/zX9umJqdSRzRdzTN3gYeEPNeFdx33wg26KlkAuW9Ei
 ZDtssYGdPKeh4we+0rsgyVh9hRvcOJk6blRYSmnBFC/Z/1yIch9oZc9bxgh8IvTwHFEE
 KWVw==
X-Gm-Message-State: AOJu0YwX6GfBcZLVjCFJcYwuNyh4IVP95+p9SzlnmnEHgdbwyDHbagsx
 Ut9WcI6A0XJ7ogsI5I0t8/iSSNq2/R5QHfq4EF6JBlRwZcCCe33Qh6ZL1yJeSmsCm8BKID9stF4
 if9Hp9bPSnLp5oVOIka7ssRpIFtVSrYBvJonDSbqEsVGBGVTi6foi3mLZ5OsYAZ4eqg==
X-Gm-Gg: AfdE7cl0gvPQrnYqG2nK7fz0m1WS4DgR/7WcVvgHefKbdSOc+NSPt6mSlQ4fQKUJ+AV
 AaJ5zUrvR/s9NQfiqViwgg+6NF2u0l+51d1eWmyjFtc9IlkIzZg16pJXgNgG3Q0n3BAIfwpfdlu
 h/TmxhQv5DzkR45PW01H2tJzM2RV6WMYVmJLJIqXTiODSnW7UQ9A5Rs0U83UV3aqpF2LgR5Vq8h
 0Pz7LmtO8Oi38zaahTOqvypkF4bzCw42tonXnmIyBEOOrNe1ApeuMOEHdlAiynjNsq0NURlCNqB
 hcmuCgAQ5h+KMdr5b5fQ5E3Z7gAgFGB/xOxUCg4KCCvYxb7pyeofN+wFOvXvtwGDBMmj9XwXQWA
 Rxp3oHlZAobEW49Wns8fcRfEkjwHno5DhAPJRm2SB+B0W7KOoKG1AoxF5apvTl4YLU95qj+bTHD
 cNOK65gw==
X-Received: by 2002:a05:6a21:4d8b:b0:3bf:6c08:fb81 with SMTP id
 adf61e73a8af0-3c08ef5f0dfmr2908874637.49.1783377536856; 
 Mon, 06 Jul 2026 15:38:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d8b:b0:3bf:6c08:fb81 with SMTP id
 adf61e73a8af0-3c08ef5f0dfmr2908841637.49.1783377536392; 
 Mon, 06 Jul 2026 15:38:56 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 66/91] plugins/api.c: identify or1k pc register and mark it
 as read only
Date: Mon,  6 Jul 2026 15:33:18 -0700
Message-ID: <20260706223343.988769-67-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX7BAQtkeADSfu
 WYxz7CuHahoJ17FD10PTRIKy2FZB0f23+KlFiUfNPJcdFkzk2xvrVDAUKFKUTuGZu3Aq5VePOc5
 GHYeNJY1km79pP9SSj+hKbS4qCn/wdw=
X-Proofpoint-GUID: I3Lt9P1s-ip0P4gpKfV_uJgoG8UYGIex
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4c2e81 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=qpq-EKoDnDwZV1OHMCMA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: I3Lt9P1s-ip0P4gpKfV_uJgoG8UYGIex
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX2T9EdT7FvWSd
 mcqqtVYgXfQV9mZ/tLaOUqFJQImd+y0PQ81e7pF7NubOwHtRALNRL/x4VVDhHyCgRCXqVaj6yLl
 OWJrMoTdC2vrK+0mwopeg5Lgv/OnoyhzEsDShnpHgZ/KrdAKj5FldJ7QOhkbJgRhU2MCPWREEbw
 DDkHQx9Mm0gRKoPGbYIZ7BdVlV2vRXu1W/u7E6mNC/y8s7r2uMxE1xgMCVUQuZ7Z1Bqgk+0ITGU
 GHTfb/6G6fLBXN9o0ikjNFIZpx0qaMVXPHU7RK/JvQdjqf6qE4x2esEREP0nvHC5c3eEwCevaeg
 S0LajbeseRG1/kHtpn7P+rPH7TcCFHLY3ZkGn7SkQy6NGfaAJVQ5lS6IBS1BN7eIaqlYZTntZhH
 TxS5FURhD1Uk4c2IVIlazdZrioZ3UMMsXEl632CrAID0K9f0WuKtoYyhU7ahQNlwBdLEUjHSrF7
 0HqHe586NEt4uydkGTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060228
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

plugin registers.c check if at least one register is read-only, which
was missing for target or1k.

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
2.47.3


