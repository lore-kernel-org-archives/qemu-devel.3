Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A13C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziSU-0007qT-Bz; Thu, 27 Aug 2026 18:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSG-0006Qa-Om
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSE-0007Qh-EP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:16 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLnEL1358721
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vYUY9THMbxSlphfGLkaiGZe14aV8VRcyYJacd8Y/OVk=; b=peNt+W0vhsxOV8oE
 XX7JNEfnBafkMdLdSgzVdfPKh0Q8SMPNeDizLIsEb4W/nIMShRHN/ScWXzP+Y6Iz
 U/ATfM30n13ODAKo9RK0f/+wHClozQe+A5dx3R+BgLmiFZfCw0QW6lV4Ua8kXxep
 8mhr5wMXYPbD21vIEc40Nv8cCEKp2Fcw7QGvD6JyYhLTf6WUAMlH8h+ydrEkbMVw
 YSzcdDzsqlLnvy/6Jhs+4VZVYAi7NkMZYyj4tf2TmyXj1QcymSrO7dnlMcyGc1FN
 yJ+gkHgEsYZ2Gl65nj1Ed/ZB+Mw6ThGqD913pqHhBxfeSMNIkyVV6eHAIi8/soM5
 FqFFLg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgvaaa5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:20:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d63c16fc5bso6748185ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869202; x=1788474002; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vYUY9THMbxSlphfGLkaiGZe14aV8VRcyYJacd8Y/OVk=;
 b=B79PoYVSSmbl0y+l+t3TyJ1BGAVF0HnEVUXiUmuBRLxVoedPAsFCuRVtIUa+k4jSri
 rAI5Ftz5h8QShYCtWjurwzQdFKdBagOykSqWbsymFxnOXQdvWnyTjtPKAu2GytFFJ6wP
 A91ZayVP1FqGNy6l2Azk5jpZsqZg6rUpC4tmRfpgYaL1DyEXpXcl5MAG+4e89KxGTbH0
 k0gqCikN/7iH0iwRTggXcwhgktYztckJbHtbECFzHhVUwODsHiY78bsShEXwTIl/qOpp
 EHnnmDtWbJUwd9YytcSQr+RJ1p5bhxhljOnmDndp/thwwXsJP5Y4lnWzr1kum9DzCmwF
 e7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869202; x=1788474002;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vYUY9THMbxSlphfGLkaiGZe14aV8VRcyYJacd8Y/OVk=;
 b=HAcrXiuOTEAZfZDWx+wkui+gUKwFhuvxIYmHXackeHTDoNWGDSAsmppRsb6Y7HA4Sb
 abjDGhxLx8ZOqeFyFEDhzYGmzK4ScUCvWMN6xRbF49u8W3Ju+Xq7rHeUiWzHY9i2hRkU
 mxmRE9nvMRplOxrQgiIWOQsn8LOGft+JkGbwTA+JJPrhsZfjTZpfmhcwQH7hZ07CO8At
 HskkpsN9yhfJihf5iVHhWYm1v0T85sNcRvluCSASWUiQz6IfdHyQhNy7GcMQAANXCIrP
 aPsZOlHJYHCNgvGzm2aq5oHngVyaru8BfUw6kPKQGJWcIPtpcnSrpwVZ0WuiFOYHiBoA
 pbAg==
X-Gm-Message-State: AFuF++mDf7rk0k2Y4TE845MneiIhfclb2U8wGOAs+dWaF7DJLKTyAul/
 73wplG29wQF2eBq1/LgwL5y+MZJTfhPgeH7uDU3uzIl6ntVsUIlse3aSHfJ/xh224cQQE7MKQCI
 JwA0Z7pBd6t3vWCPea2bCpTE4EYuZoq5Use4BJIM8snM95gOHdeF/pCtjdKPqttw9MA==
X-Gm-Gg: AR+sD13OCWY1dX+7iNUlizPLaYixQHrtckizdp1InuZPKwfsbFyRgM4l3Vybv1eA2QV
 rBR5swRrAYF2hucVQ2dmBG4pKVOWDrc0OO1zDsWl8K1flZsfyCuuXuFBXp2M4wWAQc/N13wt6xB
 eMsZk56MG99ywDEBF6awKeygvE6ZqJMxpprknR/dVnC7YjHoSOpEwgeIfGUyT3igDSYrdvb7MLK
 2e6qL6NVZFWgVJorOPH2UhAsBtsXPcqyV27A9W8BX/nkoJjPdlZBYX6r6CoDmSsMHs93bytrdiM
 v37eqJip6pqylljpHqNrHI8c25feKPCfgTG3hXA0uv1eJktdcTtjWbU/iW6PD2MDTDej4c1HH6Y
 uEJgeEDCD+jw2X1NEMj89aymNWmOoZqPLO73AFNd6ooN4diSAodTA51MbeL4=
X-Received: by 2002:a17:90a:fc4e:b0:395:5eec:b932 with SMTP id
 98e67ed59e1d1-396d0f8fdbemr4750591a91.11.1787869202106; 
 Thu, 27 Aug 2026 15:20:02 -0700 (PDT)
X-Received: by 2002:a17:90a:fc4e:b0:395:5eec:b932 with SMTP id
 98e67ed59e1d1-396d0f8fdbemr4750509a91.11.1787869201689; 
 Thu, 27 Aug 2026 15:20:01 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:20:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 072/105] plugins/api.c: identify or1k pc register and mark
 it as read only
Date: Thu, 27 Aug 2026 22:14:33 +0000
Message-ID: <20260827221506.91574-73-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: luHhrWAovw5WnYdhcDWomPPWAWhA-z40
X-Proofpoint-GUID: luHhrWAovw5WnYdhcDWomPPWAWhA-z40
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a90b812 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=qpq-EKoDnDwZV1OHMCMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX9ts/Y0aWJrmP
 WA2PYpT2i+aVzzsS3egJIAc/EiQ+5EcRAMOyvZoFEj4SEF/lu5KhpBY6ooU5B42UmCLzj9WkTPW
 CiZFr2c+lsKZRtV2FMJhy82URnxTT6J4jZsy+0BN12BJJIxzP+BfgtrUfpGPB1mMcOqyOfd+Auu
 p1eP3u+Mwxch+FZ8tDx6b96of5hA+p0+0EzQTVYr8+E9XE7LhObGMQ89bbmw3saQimB6ycUIIzf
 6AU4OZo4iEMD0c5iBKmrOruOCTtRlxVLOQKN8RhD5mtDG2tfd921g4xz+Oeo7YqZUZ09GWyiCdM
 +2PUX+H4qD+zg0U3bcj6cSm97gOeSxqg/CdwsQYOicsXqLXI0kNyL3tP4zlQrND4VQgI8ie6y2v
 B3v0iezUQzsL7tsVcSFpmOaaFMepOGCQmKCyPs2AgDS8ezex3CUhBZ0R/K1NkvAbZ2/rK1uMfYg
 yrjhyw0JxhVKUtnOljA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXy97RQ2vdyfn3
 U5HFRDj6R94ia5vzszO8pMzkuBNtQfCDTRenp72opFIH7XS7xr3K0pVa+BGdWV9G8DkFs/a3P7Z
 GzKwZ3INfXjSxPUUZGlTUe4/AT+EPk4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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


