Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3E8C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4ge-0001Fw-0Z; Fri, 10 Jul 2026 02:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gc-0001Ex-Rg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4ga-00062P-Tb
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:10 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mtIS3721337
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B4xOslOXt+KodCQiS1iEhVVx8EtA/KKEKO+WOnwX/L0=; b=crKBUkdGIJVaPHAh
 IGR9YQT77F/qpuPUWZ3rtZl5kzPgVWtK8IhRZXFBmoYeIrpbHgyANPHWuufWvhmi
 fuSz9Q7WaDTELl/KwedvJB5m2/5GMm6E5i/+ffUWtw0Kj6s8DKTzNnpG2W8Xguz+
 pQRNHC027L6vfZ6ql3P/V4XU1PUB+c0XqzjK0AdDzOZVlhpQp7KfqGhMKQcf8bbG
 jUk/Rc35fYWTpBpio+fujOgdzcWyYbu9gmGHm6tzUfzlJ6eh3B8YfpGxN8IGymMS
 728oYuVKRxW6a88sUJjORxG3TWGuGVFyUXEmEh07amP1mkLek40CXF/Q1sp7Xiil
 iMVBrQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajwt9pe1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:07 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so1199246a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664767; x=1784269567; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B4xOslOXt+KodCQiS1iEhVVx8EtA/KKEKO+WOnwX/L0=;
 b=AKcS5MQNAVqp4zsC9gtc3zjSmAEDaDyNWr1h4ojtwKm9ybsr2Ne6EfDYKoSJARTtZR
 JbCAss82xIt12neZyMNi3LC0Wc33Lz1D88w6dRSzCDU9wlbNs9fox6toKQ+1b4GLu4BA
 iKrpid3pS2YKGcsk5sOg4/CUVE0NmlR18TFn8IDg7VWjSafZ6sTyY0q1f8YxjeVYCbJB
 H26fsuaLuR2FQTL3M/XU9bIvhaSvsqy2SabEDft7USVudAhpS3/WnPSIDsaFxUw012TF
 np/AhXm6/BOGRG+ApmE+AyUz9qrIxjdWLnS1IOSV7qHYuOirn0o6V+g9MpBv+QdQSUU2
 +LIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664767; x=1784269567;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B4xOslOXt+KodCQiS1iEhVVx8EtA/KKEKO+WOnwX/L0=;
 b=HfiM7Q5L+YWyc6X7qZa7Vc6RHGkDlBRjaE23FePNoz0qkXx8S2ZkvZ9ZImtR6aenfG
 97lvcDsTo/1aWd6BtWwStgHui9Ti00ul+zQviJDYTPN3st5/RhhY0iY66QMEI94kBy5/
 I7MR6C7Ye0tYGEo9mYx9W7PbEdKGB7WRA+12x/0iy7c2t88jRXBJfSyH4/X3+b4W+V8l
 9brW0uW4D3V1MoaTENuK70G0SH2GR90x/q/sguY2zKvfSMUbiwxrwLdv+NMkx86YxLS0
 abMMDUt+NDEvV2/e1Aj9xaJenDYNKPdeouqXd2+CdiGz48/2kjJ+vLOHzwda3CGjgJyS
 v+fQ==
X-Gm-Message-State: AOJu0Yxn7O1KdU6Xl0zPflQcPv9C7tfrmwj6awKohMcS6AkweVoxBNEn
 Ut7xSDxReAWNM7K6PXOqkHZueEoYEDMZBO/D3iYRW5tMsosckbSMTp8OhQg0PbKw8rVpQcIu7u0
 8tQyZUnuCCTyHPkH6ZlyuVyslXr+0l+l7ZPBZ7AXQU5bqzWqPjBSlQGE3l73xgV/BPg==
X-Gm-Gg: AfdE7clmaF1F3lUaQt6FWomqJQnSn8jw8GqJOrLlFrRM+xGsDWhGd4/VDNO1FPTRgk3
 dMvWEOi7KKgI7eGB8NWgt8QQk7ZVjk6PoTxvGHmVsaCnU9Vwa1tSjaurd0h33Nw6YvbzdOAY2Wb
 9uPaYL3pUm7YRThIgYGh79oRqsPLFZgg1tWNf2EifWqfl2QKE2yDvkOrpj3VGZxquomCnkslK5U
 i/z37gXpW2uW/IbyiHKvxSZfYYVmPMP8XRa45SL1fCcgm5wL/effF8genVD20Jtyb9775/D7D+g
 2Z3AKhzrFGdxmnUs0AiqosRD7KWdFqr/+8sDM2tlLi/+37of1ZKwCgeOvxcIPJNEpZxtNeSc0qR
 ihr9nn3Xh/Ul3cXDut5nK1HSrovjXv5nBPOF2GsfuHEqkBJ5L7Cup3RXN+ztw6J9IbEODQBmuF1
 ZySVYIKQ==
X-Received: by 2002:a05:6a21:6b01:b0:3bf:edfb:62f0 with SMTP id
 adf61e73a8af0-3c0bcf28099mr12404596637.55.1783664766844; 
 Thu, 09 Jul 2026 23:26:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b01:b0:3bf:edfb:62f0 with SMTP id
 adf61e73a8af0-3c0bcf28099mr12404561637.55.1783664766406; 
 Thu, 09 Jul 2026 23:26:06 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:26:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 69/97] plugins/api.c: identify or1k pc register and mark it
 as read only
Date: Thu,  9 Jul 2026 23:19:47 -0700
Message-ID: <20260710062016.1818125-70-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XOYAjwhE c=1 sm=1 tr=0 ts=6a50907f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=qpq-EKoDnDwZV1OHMCMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 8WMGxwlSJvzgeezVR2HrQ6z-bXNgpOz7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX6DHy8jJcxZ9H
 s5YdeMKXScTtza84U4SFQlLv+dn851lVWYiXlWyRpstiM+fqM0HLsgKt1HxH846Lk2ZQWfOkvWt
 c5CLk1nlYkKrgEzRgXJGfeGMrnUBPkY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfXyWldIMpsCGcG
 LWeI2rbQw/RIiQZZstv2DSiM0ai62KYVLSub3PZTUfUBmPMjnXByrH5vs03OcdSqW8HNOY8+oY1
 BSmpr2Pj5r5PfL7WUHiv2S6uJ21lfv2uKZR0usH4tkakruuWag8bm7FEjRGuPbPsUw578S6uN8J
 SAdjPaVYYmKFTKl2Y5kK2R3oLwkVpx23NwiFU2SmflQlqK9bK1j5MVKB+ZYhFh9tLbAT4R/88yb
 g+XRWpHOHiw9qaI76hoEg3BSEmYUbE5cgCRSW2xMhWtsi3LPcK+1CWGkN9F1suRR3AE/yBCcSHC
 ntj4cUHWb7Y0BvVqPQS4vQPjhi56nXogcGMHpocVlBnm52h/TmqJifNzRbKbIuXGKGLHU2GoyYU
 mjwAVZTtiTit9PeyzMQcnBNxaNVLdw+W/KzgZGptfXfFvU2Ck3/nU237athIRtbwB2pnevb0CxT
 Fj/BKepqxJYIyBtsGNg==
X-Proofpoint-ORIG-GUID: 8WMGxwlSJvzgeezVR2HrQ6z-bXNgpOz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
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


