Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDC6C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24vk-0000p9-Ac; Thu, 03 Sep 2026 06:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24vi-0000el-1u
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24vg-00076s-Aj
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHAtT935180
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 geJzwEBHBK+t1Jv8sVUgFO70Oj6wqINaQuajPVPregs=; b=V5tCV6AVhhOpX99/
 pwNErAjTHL5XsO9mjA3BdNDuOC39GzYeGMGRaX9DLGvB7qDcV7BFZ3eqAlYJ17mJ
 wteBiZbA4v7F6foHR0/cXi3chhU5K7b0seWcYVNPbmX4fbhOn4S300qePD9rpGfb
 Jrq14l7janMw8BZBY7/PB6s/4TwgLG3XwQ4iu6H0o3FUQRypJPJSJKLhnsj2JRh5
 dCtWY8ekZMNo0Ha3YVql6pliodlQ0pYDl/bctp0VDqtE8h5h7wFG90KslnlxdFU2
 t1YnolLX4dOAV5BboHfactdFUwrj81r2iJE0u/Leo3QY18qTa+5pPmGjTtIZZnxh
 1r3Gzg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gerdnbvk9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:44:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9390ca1a9abso355478085a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432262; x=1789037062; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=geJzwEBHBK+t1Jv8sVUgFO70Oj6wqINaQuajPVPregs=;
 b=IWY+z2MzXXC+503/RT8SwRyf/wOwTDgFYI8v99Fq/C002naClyjf7WCWLEEIeyXSm6
 Q1HboGRHzjjvd3adswtjzastqz1BG0bCFaIGSssO31+tXJgB/Vnj+mFrrl/4Qmq1tJpG
 DajUupNBhwLbo2EyeY6mVXwas4TPAq+5kIAXbKDklzTXFenvLKiexID2G9m5gHJg+8qb
 JBCAZvPuSePXHuam3svoZnAjYo/ErBvX+vzTe5N3GEDABGuvOuKQ0R2Bhh0t6LU8X3hJ
 Mtd2S1HlSVt45jHrmkqIL/xBsK7HVu362BngW1RqOpXBLjapkOvGD+JWxYLWgIgGQ/Y2
 2FaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432262; x=1789037062;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=geJzwEBHBK+t1Jv8sVUgFO70Oj6wqINaQuajPVPregs=;
 b=f85DCNuoJe58U1OI0AbacinqsNFM8bc4AJu6Ta15RRlLwkBqFnhLLdwz1zWBYOKKOP
 Ec5OIDvP10R8HB7jOPz27A6nbun6y6CroA1lbYdIQ4SRXE6IpEyZTv5Y8NTVE62YyS/D
 ZlpVUTpZ+PZvZdeMaVYzRU09v7e2uHBWizA+bkkR1gGIjuPxWqxyJUhWlBFKq6Mycnyj
 /eQAFK4WAA9jNem3nALWy/hNqYXJRSFGBckGFdoU6owMkpMfEYMCaHNbkz76PF0qmaxc
 T6YYzMLY1kakHy33vM5BATSf9UjbVCKwe2/M7y6aXcQl8il7B992OW5A8xIkKstHFmTy
 r4PA==
X-Gm-Message-State: AFuF++m56s/FbQnww7p1ZOJ3FcK5XNMhBSEKMpDzn4Z4QoyvebDTjKKN
 xYvpjiWPLuvpN7bxrHxLNRoqwQV/vZLV0xEwd5eK3UJnND2wznqB7DQQFjcIz6h8tN/mUBPzKKA
 6nP4ygmqur0NJrMi/CAtq8QH0xicJaTCRa4T0hM/rkd0eJWATnS2GDIh3qYs5X11F7w==
X-Gm-Gg: AYBFou1ZJzkTNa5lA8QBdau3yA9ZkHZZo6bxPGyOJz++TG7cdpRKjtkpLnSGTRV1B6I
 AcBVZ1Gdgz7EhJge6MZxz8/X5T/Z6bTdOVlLrvJ6nGCdY8eS7Avgil9jTJpHdsj7kKrs7O4ThNJ
 BnT4qFsengO8DhzYbl95PUXuxuLwHHJabY/VTHdxk5/DVk4ya2GnvGPyO4PtRQung3Q1xv1XvDc
 aUnrVWK7dknsBxVEckD418V9/dzJw9zxpKXOYOhLLFdwTTs/4kwG3o5qQuWr9l1IGKGhzuTzU+t
 7a5V3Db6B5p1DQWtd0lw5WXTuGJOGi+UegQE9Grv4AqhDSD6R+Edr0fUYawAn3hMczFRw1tXvAX
 E3ymv4iwb86hiCvip+DCgkzSfXOHzQ4t5t+lmO4CQ
X-Received: by 2002:a05:620a:8399:b0:936:9f46:cec8 with SMTP id
 af79cd13be357-93960f29cb6mr1287797585a.20.1788432261815; 
 Thu, 03 Sep 2026 03:44:21 -0700 (PDT)
X-Received: by 2002:a05:620a:8399:b0:936:9f46:cec8 with SMTP id
 af79cd13be357-93960f29cb6mr1287794885a.20.1788432261391; 
 Thu, 03 Sep 2026 03:44:21 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm242537555e9.0.2026.09.03.03.44.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:44:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/51] system: query machines using TYPE_MACHINE
Date: Thu,  3 Sep 2026 12:39:22 +0200
Message-ID: <20260903103936.62355-39-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YcmNIQRf c=1 sm=1 tr=0 ts=6a994f86 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=r4SdTxa7mPobecY91-8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX+/LFiio28vwl
 wxwjli/QiObiBgCrBh6ML8hXYDLTvGznwNdNQqEoFJfERQFP0KXySChyjAhYmGdLENDLWg2aV+M
 fU3ParPCROCkAog7pjTEJCJH4HHvpdI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX3ys8QJ/uAJcF
 LPHWb8J8eCT+7vHICPcEBMn9F8XzlOXfhbxvuePOYBmiBrA+4ssn2i+zhdCoJl7D++GlpXhObXV
 HfCR3qtjJUQz5Q6nZyW+/l/pnV8dr7SMYcLd03aNDnv7DxE3KpjToWBjgDFcUP+Z85Veb3LDbIh
 HsAXwF8UO8kRQ6c7DIYlGWMZbjt7fypniHFNgNKW8L7cbYytUepL/UPmqEiOPA88Q4qMgBmiCNr
 dAmPePrX0HjCsdrWTs8M/R//ZfMgLEQ3dQ5KW8Njfs/TF44sCMK3oBPAVIGDvlfCvOkgqGUT/K0
 GnTmze4caHe9lTOuKtcTmUWR99wf/AAoZwolPAHaevrjb0U+qGQ7rGSGJydrxDM3CSxvlXlWxkI
 sAhWliiTIk/DCgV48A1elIhc/haTmIQxawU4wKhDYwyMe9e/CPhfZ3FIau28xpH6aX93h8RZaI8
 caVPMk/T6CA4IhzWv8w==
X-Proofpoint-GUID: jcj4N9Xy5OrwD24s97t7R4KoYW3_kzoh
X-Proofpoint-ORIG-GUID: jcj4N9Xy5OrwD24s97t7R4KoYW3_kzoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

We drop the target_machine_typename() we introduced previously, and
revert to using TYPE_MACHINE. From there, we'll make sure only the right
types are registered at startup time.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260901202043.26532-4-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/machine-qmp-cmds.c | 2 +-
 monitor/qemu-config-qmp.c  | 2 +-
 system/vl.c                | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 1aa5f262298..543dd3201b5 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -99,7 +99,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
     GSList *el, *machines;
     MachineInfoList *mach_list = NULL;
 
-    machines = object_class_get_list(target_machine_typename(), false);
+    machines = object_class_get_list(TYPE_MACHINE, false);
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
         const char *default_cpu_type = machine_class_default_cpu_type(mc);
diff --git a/monitor/qemu-config-qmp.c b/monitor/qemu-config-qmp.c
index 29801023564..a680c9feca5 100644
--- a/monitor/qemu-config-qmp.c
+++ b/monitor/qemu-config-qmp.c
@@ -129,7 +129,7 @@ static CommandLineParameterInfoList *query_all_machine_properties(void)
     ObjectProperty *prop;
     bool is_new;
 
-    machines = object_class_get_list(target_machine_typename(), false);
+    machines = object_class_get_list(TYPE_MACHINE, false);
     assert(machines);
 
     /* Loop over all machine classes */
diff --git a/system/vl.c b/system/vl.c
index eded498fa7e..1b22a358d23 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1570,7 +1570,7 @@ static void machine_help_func(const QDict *qdict)
     GSList *el;
     const char *type = qdict_get_try_str(qdict, "type");
 
-    machines = object_class_get_list(target_machine_typename(), false);
+    machines = object_class_get_list(TYPE_MACHINE, false);
     if (type) {
         ObjectClass *machine_class = OBJECT_CLASS(find_machine(type, machines));
         if (machine_class) {
@@ -1682,8 +1682,7 @@ static MachineClass *select_machine(QDict *qdict, Error **errp)
 {
     ERRP_GUARD();
     const char *machine_type = qdict_get_try_str(qdict, "type");
-    g_autoptr(GSList) machines = object_class_get_list(target_machine_typename(),
-                                                       false);
+    g_autoptr(GSList) machines = object_class_get_list(TYPE_MACHINE, false);
     MachineClass *machine_class = NULL;
 
     if (machine_type) {
-- 
2.53.0


