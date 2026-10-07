Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8F1CA600A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWew-0003th-FV; Wed, 07 Oct 2026 14:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWeu-0003t3-UF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:46:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWet-0002em-5t
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:46:32 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697IBGRi991680
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 18:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8OcbWnsp8Ld0UXoBADn0DXlWk8r+SFsHL2lPrbal8jQ=; b=GIpuIE/1c2CAw0Tj
 wd/01rn+AQwr7x/tvCAbYswF0T7k+9X3Hy5A8P2OP0ePEs5YPtvKkBfb//pDYbBx
 l2S8A6BQuYxVBR9NexTMaWU2Tny2GGmL2m4K061CwR/gtzAifcwkLV6cb5Xycsot
 9BjfWt71FgG8HcsTwsKvOB8+ji5Zq+upFs0yLUVmee+Y1YoXV493dNVb40EiIOHr
 50zOm7pxOpHp3mKte1uitAcrmIHCOPkAbsE3rz3pcb7idGyAzEp18gtEsWR8PUtX
 kMh8IBX5kK4N/dWAtff/IBp9BZYUO4Pzi519+4Kv0lp3DWm81w+32gLe7RdwDDmV
 Ffs0eQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5gvrtrgk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 18:46:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-351758f3a53so363633eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791398789; x=1792003589; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8OcbWnsp8Ld0UXoBADn0DXlWk8r+SFsHL2lPrbal8jQ=;
 b=JXNc2/IbFKF2w8JabX0clNuGEa8eMcbm7LUsHns2zxQBZ+aViQ+8DOUh2KIAsSvcLD
 UVn5rhjlx5XZ9LTBPttTzFjdnUcUZ2/TuRvCY6b3mp4I4vLWoD4SvxUZaZUG5Spe0eGT
 S4ysEHaQWi0GVx/Bc7XsqoUnH4if0QRo7MG5scOmW6XniM8qB23mqFoZlYHBENCGLTRR
 tOL7YCD10Fl0fCQZTsalLs6Y5cx0xxzA1oeTuEC9VuQAR6aceoz+TwtVjwESY4LkLhwh
 7eUDuBbgj9TaUYI62D9o/QTvLW0Iwos8cnD0YprKV/4ta6s8vl9nQjkERdMFgnwya6aB
 Tg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791398789; x=1792003589;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8OcbWnsp8Ld0UXoBADn0DXlWk8r+SFsHL2lPrbal8jQ=;
 b=pGkkyDXM6X0BkedgrgWZicVrIfXqBDnzzH7Dz+RtQAqm3NGPGI1zpg+DGMqRUpYBZk
 NJTskEV2TCv90RE/D49AT2MEeOqSpkf2HuxCO8haq7LzjlX7z/QVK+tnodZFUl2Bx6EM
 ML26wfCRThPcIcIPScPJGVszplMPSoaKD531WVUUdP91Gry5IQFSQYmjbhuhzrTRthmc
 7juekT0wtM3lwvH8zyDqoVAMWAW1zQHGRVjE42VjNcYl6PVaa4jwu/VWOqvT1uAM5LfG
 eOf2XCAlRQ5EuCd7Iao9EA6rEmW8UpQX4c6mAmu+GZ7mL4gHheK3A36Rh3p54BTrG0KD
 Nsqw==
X-Gm-Message-State: AFq9FYK1XDXW9y7MZJ/h75PyZ1RoFA9xdFg9w8f7i3Njxup4ruX1IXee
 mSnPTxuuqe2pUWNERIZjpi0R8DgCjD4NTSqgTZeXsY/OJCD+2kMPibzw1zSVPBkK92FY7WNy6oP
 vza5F6BXfM15SUnT0G/LLD4yTwqiyec/lZYP+SSB9Kl9YyXbzoLIBafI6OS7xmC/wYg==
X-Gm-Gg: AYBFou39UvjZO82BtSGaGS+zqXgv1K7BlSB0VtuGHXGdFiroQ1ZMaYCGljJnr6aWBHp
 pVX8bxCZlITk2W+1H9puZCQpOw2IES5UMyuVAnzg8LLZ7BJ3GSgjJBT2FN99AC8zCebh7LhWXwE
 TRG3ATSWJWSBxzLkOCvQFCqP8j7dseR67Xp97yy5eEpwHfHpdkJo/VhKtGmOc0wEmq3N3XvP5h+
 n8YHJ8NCK8VUtc7K5EQb9i6eXsd5Mv3IVaBzuH1zrVvkODhK5KZ5Iv0JQXdDPy1BOPU7JsVO/Q0
 0DIRxDtZSEAlKNdf3FFCOjvjgFGvyV87OS7OeN3/KrfH5Jr0R0RF9jeQm/AkfLSdkTS8zGWIjsj
 zFMcibF2xT4rouyrnrfpQjflHYwOon1kYnAop36qub/Djd2VhG3O/En2GaVnW
X-Received: by 2002:a05:7300:fb83:b0:351:4866:255c with SMTP id
 5a478bee46e88-3515de846a8mr4959938eec.32.1791398788893; 
 Wed, 07 Oct 2026 11:46:28 -0700 (PDT)
X-Received: by 2002:a05:7300:fb83:b0:351:4866:255c with SMTP id
 5a478bee46e88-3515de846a8mr4959840eec.32.1791398787755; 
 Wed, 07 Oct 2026 11:46:27 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515af3ad13sm8295910eec.14.2026.10.07.11.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:46:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 1/3] meson.build: export TARGET_ARCH_VARIANT in target
 config
Date: Wed,  7 Oct 2026 18:46:10 +0000
Message-ID: <20261007184612.24073-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007184612.24073-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261007184612.24073-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W66txhWk c=1 sm=1 tr=0 ts=6ac69386 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=gua6CS0tsYA4MX_G184A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 6_rE_YbTPNmIbuKTZkuGjCbyevORgGCe
X-Proofpoint-GUID: 6_rE_YbTPNmIbuKTZkuGjCbyevORgGCe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX4wo/Zgt19lQp
 RQUqE7WJB7r+lBHGJS6Eqs0zEVfkzCtnEIo/QV0SSwdWuDB8PQjqcx7T253eWUGMZAf6ZwlE/iV
 /elqD+UsfSRBo1uitSx9P92b23UWh92MOvC6c5tDWIqcPbEY2ICPcGRc1fLuHUH7dPZtYsgcv6k
 TmwQEUCqGwf/bSjYOykDBbedwR/WXqoIU2pZSSaOdMQCrFaH+R0i8kprodw1brkWrl96i6iCoMz
 k+IYpuneBGthB5vEK94YVXQROKC/bPVP1ylZZG4dj66ic41oiY6YPcG8OEBe8Dpsrj7wDCaA+1F
 jWO8HstMW5vjp89vAsuvc/vz+utuKUm6g90dAsL2heNuEIGTye5wKF5jLF/xyGmDGhgjeb5g87f
 zyKdwwvkjR4gsvbRQ9Kn9wP9u0W/Tyzt8hlfkr2qG/zF8UoU76n983X/bzjP/AGiHWe10A/BumW
 Ry9Hpjo5FwkbizPTmQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX4OpZ2d8QcPb6
 XMMuHF2dlNd6K9QwzY2hJqWNBTUKjYu2KlBUkFHAYLWry+mz3PfvqHLcYsiTQZRtwvDCPNPCuAy
 hx3oljHCQEPHLUPpNiNMEqoXzehv+18=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070074
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

For now, TARGET_ARCH only contains 32 vs 64 bit arch. The variants,
based on endianness, are accessible through TARGET_NAME. However,
TARGET_NAME is a string, and thus can't be concatenated to generate code
and retrieve matching SYS_EMU_TARGET enum entry.
Thus, export this information in TARGET_ARCH_VARIANT as an unquoted
identifier.

There is one more subtlety, user binaries have extra targets that are
not present in SYS_EMU_TARGET, like armeb.
Thus, for user binaries, simply export TARGET_ARCH.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Suggested-by: Yonggang Luo <luoyonggang@gmail.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 828100de816..48da6cf3e6b 100644
--- a/meson.build
+++ b/meson.build
@@ -3288,7 +3288,14 @@ default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
 actual_target_dirs = []
 fdt_required = []
 foreach target : target_dirs
-  config_target = { 'TARGET_NAME': target.split('-')[0] }
+  target_name = target.split('-')[0]
+  config_target = { 'TARGET_NAME': target_name }
+  if target.endswith('linux-user')
+    config_target += { 'TARGET_ARCH_VARIANT': 'TARGET_ARCH' }
+  else
+    config_target += { 'TARGET_ARCH_VARIANT': target_name.to_upper() }
+  endif
+
   if target.endswith('linux-user')
     if host_os != 'linux'
       if default_targets
@@ -3372,7 +3379,7 @@ foreach target : target_dirs
       # do nothing
     elif ignored.contains(k)
       # do nothing
-    elif k == 'TARGET_ARCH'
+    elif k == 'TARGET_ARCH' or k == 'TARGET_ARCH_VARIANT'
       config_target_data.set(k, v.to_upper())
     elif k == 'TARGET_BASE_ARCH'
       # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
-- 
2.43.0


