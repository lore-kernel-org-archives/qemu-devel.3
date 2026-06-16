Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F34ECD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYkG-0004M4-5E; Tue, 16 Jun 2026 14:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkE-0004LU-9E
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkC-0000OC-D4
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOjI0382369
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fxfLTChBy/p
 fbYYSTZ+abAt119xAxfMeUe9ozAwk6YU=; b=mlhwj4qjliij8Kqpi7w8RujwMPT
 1s0ncSOf5Ijzu2oxj6NAQxi2sOFuzSyk6/Rnzx6BTKx4poo/I1tS/sBafV12z/t5
 JLXjj9ojDkMbQ/UKjkg7utL7EkptRKYY2Esh2BDxSUQ5+KBJwXE7f3SR/DpMM4FE
 VR42B3GnUtfATBMnuNnE++7wgnpu3IX97jPEimM+S9M8lFPuL2RzuZEdciP5Xb+N
 eXlx3840e84svOGPaSdPqhkBqWDFAoUVWWip33LedJSOXdfazsefAoFo1lDQLLdx
 u8vE/ozz7YCRQHAzv1wkYwlSRsuafFQJHTZVzc9h+IBpaPEDgOaSYjEdczw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu4dkjfjp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c69f08f527so8120655ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635357; x=1782240157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxfLTChBy/pfbYYSTZ+abAt119xAxfMeUe9ozAwk6YU=;
 b=XhtFWc09vNgE6Rbk5rgUIWq5u8q0puaM/KcbtMoUgsXtonMYJwaP2R7fGUld/c4rTK
 Lbw2cTmoHdN5mdE4CaYq4WxVkb4cJ5vmyjyLbdvY1LGn1r6GdZU6zth2KRE5vvh2OtCS
 6inWyUK7Ede6NNIun/c72UK3AhmYN4FZcLHo+15yo6v6HQE9UPhUC/b8UsfJm3rODnmV
 bHfoqbR44OH4Ki6u8ERmQsGZ7X2HKd9haDO0YmikoCBs+vBUr8bbciCrG1oLWc4c5ot+
 cZ7sfiHASAPKPObpWWKR5xzhYakecON7jKbuJmdwhnnTprQUWeiq1Kiq+eSJlla1vrXR
 MhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635357; x=1782240157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fxfLTChBy/pfbYYSTZ+abAt119xAxfMeUe9ozAwk6YU=;
 b=gZzWVAq3sK6uZixvuuMMkqeCK2j31JyXryphx+FLfIAoPMk9lSBokIAb+j2CYXM2q8
 32gLqxGm/1Q4gGawgu2S864eFkzWRTtV2uu2p/RCHGWrQAWTqieX8pfPEtD60ELrWQYW
 2km/8aKwfgwPgmlSJZYvJ4w6olF+cVeXzkI6wcjPTE5PoZscRmWQ4WUj3DmG0PCxjQXY
 gGAqqxCObm79M1m32qIHQHR7Gk8TZzJ5GMLzEf5I5z+otwtBb9HDbsa77+a6qUjJ3ItU
 RojJysgZTdcZWKN0wTIUTGWCmKpLYGKhzijie7Bn42UBR8iLdHrjUE9U1IZOH8gNCySj
 PeAA==
X-Gm-Message-State: AOJu0Yx2FLbnspU9WfeaP3+Vps1NAbEIHZS5gA9XWzq/CFA06xX+8px4
 vq6jPHboaf85kaoIOoABTXFcHxfxHImYh2F+Lo5WxeYpM6ZpFF3aBS7JDbJtu1wylm97/zYOEQv
 shViQ0I81MNXJ+9HouEEKuPUP/V/Z461I1wzjdsyVAm5lv/uMv8MKVtl1v2gOWXxJ5/gN
X-Gm-Gg: Acq92OFN3HQxdNBa/fODAPEgW/zW16m5+jJaHm7pzmWp1bBi7AsjTay8VqmdobR3ksh
 IS2yHPsPYnSGqnojfs9TsR7lBPJwt69t3QD/x+lO3HRoquD5AaUMhYBx94UpF6p4J2eR7WbkTs9
 WisvqmTNWofmEwsvpqcni32n4qrnjTDljxy7APzzUT4Azuh/CyAja21icpnckssj3962F62DrDU
 ffeZK/GhPFq4F7Va1Ubn3gWMD9g4Plscemlbg1FdJHxCJL0HpBVp1lj+hoF3KJ4dh7u4xA8VAIS
 n7qz/3vAnU1+IcDCNSF3sJ/WLqPvgB10JXHNThKIHI79a9g0OpQgUqB8ILmDfJzkkeM9hU9O1i7
 QyMfLl35U1k6x+VrAStLSy29gxoAqjmF4nmwYCMAuEHuS79ir8P9kfjm3QqlcHZasL/3cbuH88j
 MVZ2jx8Cc=
X-Received: by 2002:a05:6a21:180a:b0:3b3:bf7f:efeb with SMTP id
 adf61e73a8af0-3b8b7ff1ce5mr486375637.45.1781635357360; 
 Tue, 16 Jun 2026 11:42:37 -0700 (PDT)
X-Received: by 2002:a05:6a21:180a:b0:3b3:bf7f:efeb with SMTP id
 adf61e73a8af0-3b8b7ff1ce5mr486355637.45.1781635356923; 
 Tue, 16 Jun 2026 11:42:36 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 01/26] plugins: bump version
Date: Tue, 16 Jun 2026 11:42:05 -0700
Message-ID: <20260616184230.303038-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ld65siiEZK05nLh1bkwW5ZcweAUtXRwe
X-Proofpoint-ORIG-GUID: Ld65siiEZK05nLh1bkwW5ZcweAUtXRwe
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a31991e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=A7FZhrvmqJkW37y3txMA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX3fFajGu05vA/
 uotKWofPzPT24nK2gAkQvm78kKZnnr9sYc4IzTagSRLmtpOiQBs+ihpDiaAvOaMZeGUrLacR1xh
 cmginOX2abCnuFBQGlCiUbcId1sGqNwWcJbmxm5sAMn/lsAQYmCTNWv8t0FCbVZgDGqOhcGjRoi
 //vhkRGxWOhusi4X3EN8Wb7zD3ESwAShA7kP85fP+uoyoGn848ukuLciWV/ri5SW0FTCTO4iRoW
 vJghY2o8hdTB0fL55M+63vF+da2sJ135YLBvIKP7MUjdJwQ3SpDGaG2TifcziPlapjNpwc4PlOe
 snYS9J3ZKkVsjLBcr6+zK5XEYmi4SiIHF2qILfKu5M1hx7BBzHsuyAkPQtkFCHim0u0UXti/6uo
 X/bD9v1f/BcqEU+8Lgzw/Aa4J5fdGdjEknpscjJWeOUepLxE2vUGOL0019Jx04uabl6T7VvkzRZ
 riHRzA+zN8y/yD6yDEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX1Kyuc7uWn3co
 1zJflR012ZRKMYtehWj9LMVtMzNwfqZUN6vz7xAAWYV9EgfO73BEiZrH6ycT4Wn6FpTusp7rK5/
 EIc83d9gYVze8VPOnZ9wxIoTHW2zU9s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160190
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

Next commits will be breaking changes, so bump min version and version
accordingly.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 6 +++++-
 plugins/plugin.h              | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 4eb1d2cd85c..435a14f5a00 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -80,11 +80,15 @@ typedef uint64_t qemu_plugin_id_t;
  * - added disconinuity callback API (for interrupts, exceptions, host calls)
  * - added syscall filter callback API, which allows skipping syscalls and
  *   setting custom syscall return values
+ *
+ * version 7:
+ * - add userdata to all plugin callbacks, allowing maintenance of state
+ *   externally, and easing interfacing with other languages.
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 6
+#define QEMU_PLUGIN_VERSION 7
 
 /**
  * struct qemu_info_t - system information for plugins
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 6fbc443b96c..9179da43851 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -16,7 +16,7 @@
 #include "qemu/queue.h"
 #include "qemu/qht.h"
 
-#define QEMU_PLUGIN_MIN_VERSION 2
+#define QEMU_PLUGIN_MIN_VERSION 7
 
 /* global state */
 struct qemu_plugin_state {
-- 
2.47.3


