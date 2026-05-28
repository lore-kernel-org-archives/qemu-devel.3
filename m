Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8AFCD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wST7V-0001jL-3j; Thu, 28 May 2026 01:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7N-0001g1-05
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7J-0003b5-8F
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:16 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKliRr2931477
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pUXCyHJRsjb
 wimqvrgesToHDduCIQ67SQJqg4nfGx3k=; b=hnDMgBC8Rbq02fy3lDqzLYzghJ8
 kkGfgq66plrFxSsSjX16843Qzxw4CN5zPMtzeUTQhShNvRaOL/goxI07kAWY76xV
 abcvL7M65R8mE05jg+bOU17Z6qyRnljZnGOK+gdsmB7DOkrfVBIh7wjzD2adPa+6
 +rsvgr0/0DheW8Oigbpr+vyonhDJGqBqCi6QB6vorltGjMkdy+bQekp918w1/aEL
 2/KE/0i4YutZxJoGQvmnHXtK0EXQo9EXFm3ZCU5bTsZ3ppBnG+hqAE4Xt5hbRhlG
 DX8bJIoDvW+Uwobx8YR1gI0ryejwzXSxYqzAG4m5rs8GiOmxYgNOy6Plh/A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yahdbu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304627c66ddso5363835eec.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779945431; x=1780550231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUXCyHJRsjbwimqvrgesToHDduCIQ67SQJqg4nfGx3k=;
 b=VkWobf8QYcnEJK3AGARyB8wGimwCYvXlTdg5c9aqDuCaGP+Kjx7P1udo/oSUB00PfI
 9altdBtJy+tedjfwMesaSXBk+mVW78TKa2Dwh2UHOlkgWyZJt/qUtetUiRgJbr9ZHK5S
 jHoq7oXZyNsRDZKm2Pm67Pu++EKi4UNbkKKa7acPDUAzMMstZ2LJGc4OA6oVOqwQlPCc
 kXAic8ZB6+lvAfOVSIOfgCd9Pu0DeHmg7PpMlZ6+9xi+PwXR3ePYUUzrAN+F68eYs9ny
 sVIwSP3lYhJB5OHs74itEKUzBZlRVTLGzkgi2AsPWV23LD4lJaffUJh2ffq5AzxZP91U
 sAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779945431; x=1780550231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pUXCyHJRsjbwimqvrgesToHDduCIQ67SQJqg4nfGx3k=;
 b=iP3FCBk1MfWLAqweePIOuU4LbWLsoKKSQ1jMyxZ7Y/jyFbs2vJFjivPW9YYtZf8Suc
 oo4+o2FuPNvMWW7PadPtLIvW81tokrLFBFupZ/ZJPLQNti7rEVg8AzwUGF0D17Rc8uRJ
 +LEGq/R+5zDbbYbdf2JyhyDClZ0d+mbZTxFmGM0Mwvkbw4+qp0396a42sG5+MBoIp32X
 WVNjJeJqO97vFmH8LpNcm9PBeq5BIDq4CifNRkOjNZ8LQJ8v9HJfOlzY6sYCed7dnGxM
 ptgJDI3uInTo0S4+F3ipj/W3+HfhNdIvQHbM/cFe4dqoaYnbC2IWyCen5uwimgw6h7ir
 9zkw==
X-Gm-Message-State: AOJu0YyMvUXNFciiOI1IbQOX3CCsrYAIhDJ+gFb8oPx/Wb6rJvMwgQPu
 rUxG67HILVQIEwVbNm45bn3e+KBfI4o0dkW1g1uEa2yePGu9WqPSyqGDIDhfuufYn6EW7DLwIpM
 WvFaZzTCfTCTelZwu3AWyieoqn7dlbAsCnqTTzQ5w2u3y1kJlB/IZsRKGnOoLXIiYCRmw
X-Gm-Gg: Acq92OHGlrl/PS8m+blN8XVjgXF7W9AeBX6nltVNZOFRBISmda1CGMWxQy0sSL9G0Pq
 Zc9pTE2L0jqis7CzwOwM2EDH+/RP5dexvKC6qejygC9cgE7zLRm2mZPIZFLA4EF4aFvaUjJxfNI
 M+V5UzQ8I8nQRDGCYMj2cmIF2u/s8TGyFK5eZRXbXzPf08zKCIpto9LOHcPrAQntLwvC7883v8O
 5tqQY+vbsCuA50DlCcxpslUo1suA/JjV6EDnl+iGvCxIAOCazCxw3nMTReuTNZPi2/iqSWHitNp
 jfWeIg1MOHAFNaj3H8TjJeg9mrzKmnN01QV598ByaQsK6dT1AY9CfiwX05+eF3Hrcnx2OUXAcVV
 A96BkxWV2kqviXKZ2akdCpu0YCpqo9hPeeHV+ZLqLmsO/s69uJ1ZrqV6s34zfvD7ucvVlvKWLRS
 QiNv+mcOvJhB4s46j0
X-Received: by 2002:a05:7300:cd85:b0:2d9:ad46:4a92 with SMTP id
 5a478bee46e88-3044905ce1emr10510275eec.13.1779945431115; 
 Wed, 27 May 2026 22:17:11 -0700 (PDT)
X-Received: by 2002:a05:7300:cd85:b0:2d9:ad46:4a92 with SMTP id
 5a478bee46e88-3044905ce1emr10510233eec.13.1779945430617; 
 Wed, 27 May 2026 22:17:10 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304b984d9b5sm4094607eec.7.2026.05.27.22.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:17:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Rolnik <mrolnik@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Xu <peterx@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 01/10] target/arm/meson: move kvm-stub to arm_stubs_ss
Date: Thu, 28 May 2026 05:16:33 +0000
Message-ID: <20260528051642.115721-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kLDnG36mDM733F0Ejxfn8Icl5Sr82fUq
X-Proofpoint-ORIG-GUID: kLDnG36mDM733F0Ejxfn8Icl5Sr82fUq
X-Authority-Analysis: v=2.4 cv=CaE4Irrl c=1 sm=1 tr=0 ts=6a17cfd8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=rLAB-7AxZL2Av_YYLNYA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA0OSBTYWx0ZWRfX1imJ5YBNHGCR
 C0EPfEUHFXOCRInaGLXxYv9YZ9hJuBTUtBeuLjt+cV/tMN31kn0NsUZ73sn+xG5y8LHQj4HECpJ
 cYm5yUQYtF0rnGtx4tE+wtvw74tFDWEkV7D3nM94h+TdVbyNfsyksghMQl6SNOxZmDfl8XYd2v5
 AenwQXoTD//Xp7qj/YP8rV/zYnrLfBFIYQ1AS4DLGoe2nMjmhdAdmiyJUVrLhv+E2N+Ji4CYaYo
 gaTB+Oy1XW6ATprK03Qwsm84DSKEprgtM4ZdB/nq8M78uzUO8WidT1Jm9x/XvZEA0iCZSa2HOn1
 9r5BVhmjNDMI+ZskrB5NBJi3hEgi5ta9S+pu47H4IKrJuOIFSL8zPR1snZxEqiAiEiVCcbwvQbP
 ATczFlia0INVOURVg5hKb7ra1x6DxOXkPZpK+CcDExugOIp/FkDIVuxn0aj62ax9qlDk2s86uqj
 czlb5rPY9uaLDEqBIfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280049
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This eliminates symbol conflicts for kvm symbols on linux-aarch64 host.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 9408131d178..4412fde065f 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -35,7 +35,10 @@ arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss.add(files('cpu.c'))
-arm_stubs_ss.add(files('cpu32-stubs.c'))
+arm_stubs_ss.add(files(
+  'cpu32-stubs.c',
+  'kvm-stub.c'
+))
 arm_user_ss.add(files(
   'el2-stubs.c',
   'cpregs-omap-stub.c',
@@ -44,7 +47,6 @@ arm_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		        if_true: files('common-semi-target.c'))
 
 arm_common_system_ss.add(files('cpu.c'))
-arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 arm_common_system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		                 if_true: files('common-semi-target.c'))
 arm_common_system_ss.add(files(
-- 
2.47.3


