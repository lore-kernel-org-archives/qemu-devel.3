Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0FAFF8875
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 23:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHs7m-00034t-PN; Tue, 28 Apr 2026 19:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHs7j-00033u-VF
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:45:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHs7g-0000Wg-Me
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:45:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SFsSDK3705208
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LsL3qFK0TTs
 O90MrVjLKZu9RMd/XbvH8wgAkqAmFIQU=; b=PatKOCkRgjKsqH6Cjwbd6+OFMUf
 604GQcWziOj4UYnwDlG72Sb6vjdCae7NkTRk4JMzKR+icmTAOghf6O5AAuzu0DPU
 sTYYIGnvjPUr68G59MXv0ORDEwLyDv6wWiDEne5DJzQCERVk/BwhEunwlWZXitLP
 a5neMeKgcY59lmHxB4UzKX5MgbnOuYTahhrJUoiNzmskGkQsdP2qCzTtfBMTtSsF
 W5HlsRBIyPR7zidOtzFHPz8o6vBIno5pQs3qf1vFV32Pe0X1PZMG3HwrQZFYPAfb
 +MTiQ0k3wgvv1g7nmtqKuC/hbETKfZvW7hccQJ7EtTf6Hejb14F7xXBr5kA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttxhasw2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:45:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b81ff82e3cso215890eec.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 16:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777419946; x=1778024746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsL3qFK0TTsO90MrVjLKZu9RMd/XbvH8wgAkqAmFIQU=;
 b=XJlplHmiyJ0UKpD5UQyocGd6hDZi34m5N2ySHnU7XwDbVvFKdihXPwApapErfeIX3S
 C89XqhR+G5AbyXAMjDJ/sWrErj+L2a1yCWHlr1zzv92ML+4VXaWvS6I4QNUr2hdVl8AC
 EitsKD9RyiOJYKSncUOGplbAhhxGgLU6ZloR2AVeiHZJJUJE5wPJFD8AWVFgygtdzjZk
 dtvyZMFWPzUAcfDwwZ7Tqt8q/XMIKymEgzYjUcFfgnIXXbF8I9rh7VsTReaoo1SKtwIM
 jktD5kcJWFbaE/uHvLwqtwBKnVZS01At2cHQphefuITR3trmeL5yeOObzo/j4+hH13ur
 X3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777419946; x=1778024746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LsL3qFK0TTsO90MrVjLKZu9RMd/XbvH8wgAkqAmFIQU=;
 b=eSSp3tOlJd7Nj1V3LCn6prUUrRAak0tuF0t9KxT7lx3Ace6C9hWqwtf/pSXbmfY6JO
 8c0I85y61wDykhVLDBtr8RIZ9dp0eujHAkiqcSQgBBgDu4H6sWOvQvxVYPLsNu7lFA44
 6liR5j5WyGqELCB2967UZXM0EpOrrig9I9LuGaJpKk7FRNkmqsRRa9RxnsU6/FSPyuGM
 FVqkUYoLVv9reguBvfz1Eb2KLYyEUtQ9t5esevzNXjaVHSKnMyovbai/Pts2MQPBhGON
 pjqh9HQtw4/kCaB6ze681RYpxQE4HF8u0xZV6hhHw8ZN64i08T9gq+qdfpZye96qmOz6
 LpDg==
X-Gm-Message-State: AOJu0YwMX/CbZh+HYgak9anwwKabLAWJ8Jnb5FKsvkYRQ+zevxuj/bko
 h9q/X0oDZXDwQhmzKqnashQ/REw8U04aIYq3xWCRuC3KQ3Mft8tGiez9RKM1xnWvS7As4W1+08m
 aVzR2vkJKuquLA0IQxWcFP6uwc428ehQPnGsA726dfRYSoN4p6OkMpT+Pj4CE5aJ9D457
X-Gm-Gg: AeBDietYeLd+EUn/ffbcCy4V7f8CFwavJiNZbMEYroxvqZTF6QoSXxIQhIcsyIWHuN7
 dOAwi2K/0DLFRWOLatmZMe23+0+jgGisDK4b6GQ4RejPNWFzNavwTx2L6iTo60LncopVp/B3vVZ
 R5t70Ne7mgsLlorlQvTQs5cW/hTv7H8YKun1kDu+Mj0fd2jXHg69T+VxuLOjfpam5Z/Oaq3NX3H
 /1KUbBn5D9aly5kWH12OwMLfOQ+3KJP8kzkyrDo2pT8t/f+ttphBwMcQ46k6Mtf/0o0N3RWBwyC
 QebxEx39dwTxt0KismiLCspRlV0BBu6/Y6B9cmGPgDRiPtA2qqZ3VK6UfbBHELg/FCNvnSgUtjx
 /cwxlOyckp710pvJnSmcYsKPvm9EpAjcYTmjiMSct0NZepAM2Pi160QmVwc88E12xST8pjeYxKo
 lS99n2xBvKBuTsv2nG
X-Received: by 2002:a05:7022:220c:b0:12c:87f2:90af with SMTP id
 a92af1059eb24-12de2d24382mr440838c88.12.1777419946461; 
 Tue, 28 Apr 2026 16:45:46 -0700 (PDT)
X-Received: by 2002:a05:7022:220c:b0:12c:87f2:90af with SMTP id
 a92af1059eb24-12de2d24382mr440816c88.12.1777419945904; 
 Tue, 28 Apr 2026 16:45:45 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8ddaasm345300eec.7.2026.04.28.16.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 16:45:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/6] system/vl: initialize QOM first
Date: Tue, 28 Apr 2026 16:45:16 -0700
Message-ID: <20260428234519.1812371-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDIzNCBTYWx0ZWRfXz+AFli4s7th6
 4bDN9S3KMcLozJsWg0cnmkMGOnyAzAb4SalVWRWnJDykGJZlhSwzulhNjNDKZ7iceI336kTrxWk
 z6mE3hZT3B3s88U9T0K5exbsJCxPJzkW+rDeLbcTGKW38bzvOLuwETaS1YOSyze1JnQfNVnK/4e
 RUHrpkgYu8WlpV5vIzXakxOtg97em5gEDiu+J3TTh1FS/RTbFKI+fYTTUIReMC509jf64UfrIe7
 y3X6QqQePjviOn4seOkS8BNQKrfFB3Mzm4k3HAG2T3ULH0R6D8KbR1GT/+4CQwQEZ8Ifwj7rDlG
 2YceTuHQMnd/WDkgQTKK4w/8LkxmKSKuixo1xb+R4ZegPSRMtyXyr4lmnIk9qgiEJIkGzQQki4T
 6wc+43ffK01UZCDGUSr6LCiIv9+CkPJPiNUyTMLyNqdo2syEZdS6UPPQTUsjK5lCPDpmwJRGIFS
 7q2L0LFlfT4vN8//70w==
X-Authority-Analysis: v=2.4 cv=Uu5T8ewB c=1 sm=1 tr=0 ts=69f146ab cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=WACn5GGRyUfZdUhJ3iwA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: gj2fBImN8CY8cVw9FVwlO9mX7gbIOFdj
X-Proofpoint-GUID: gj2fBImN8CY8cVw9FVwlO9mX7gbIOFdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280234
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

We will introduce detection of target from QOM, so we need to make sure
QOM is initialized first.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 system/runstate.c | 1 -
 system/vl.c       | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index 770253b467b..c8e92f8a603 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -981,7 +981,6 @@ void qemu_init_subsystems(void)
 
     atexit(qemu_run_exit_notifiers);
 
-    module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_MIGRATION);
 
     runstate_init();
diff --git a/system/vl.c b/system/vl.c
index 0e1fc217b4f..b4a5ea6f857 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2889,6 +2889,9 @@ void qemu_init(int argc, char **argv)
     os_setup_limits();
 
     module_init_info(qemu_modinfo);
+    /* We need to initialize QOM first to detect target */
+    module_call_init(MODULE_INIT_QOM);
+
     module_allow_arch(target_name());
 
     qemu_init_subsystems();
-- 
2.43.0


