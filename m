Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1D2E94100
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNGn-0000VH-7X; Mon, 29 Dec 2025 19:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNEw-0006VV-66
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:05:31 -0500
Received: from p-east2-cluster1-host7-snip4-10.eps.apple.com ([57.103.76.73]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNEt-00040S-W2
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:05:29 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 404DB18000AE; Tue, 30 Dec 2025 00:05:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=usn+5WRKOGJaDLoRmA1S0SGx2PVU5yWwDmjw2JCpvZ4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LtMhUkxPjCDtbZfrIRlP3JbCiSwp/mCt7aJq+nV3d9Khmz9d4WWnxAL0EV80vQp8bnOxRfro8lAd1ALWnPu0rccikLQNshKIexHh+CMTbOz5lWYD5rIpV6B/Judf/xHWnEG57PcV20SAhEpYFlCS9zYVWSL9dydvEGw1H0bhhKZ7wDH2gWpDZmYokRjSQvxoUdWfBeeubEzlXO932sNpA+I1U7S/7N4x7V3xW7772SY1KIsUu8vZSW3WkhWxC2nTVa0VAIEl83YEIvB5Mhu1MtCrHu98XG95ck5QrkOAL1B4/9O25gFohQHj1H0NIX2N48kp13aneV7a0g5J7+UBEQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 C617F180011D; Tue, 30 Dec 2025 00:05:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 13/28] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Tue, 30 Dec 2025 01:03:45 +0100
Message-ID: <20251230000401.72124-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=ALPFdfBd c=1 sm=1 tr=0 ts=69531743 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=2psWIPzlEfUqwKpUe20A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfXw0kwNhFF1Bwm
 uGVFj4kHgySE3X7pM9OTeev8tuOI32P0ASJU5QVeqsPY9iBbUKyd5yhKxIfhAp+aAQ7gle00Er8
 CphhQ8seJVNInh+sl7jaER2DXaecFfgWNG75NERyWH59S1t/AS31jgpUwY98LNpUiqY8NGhRJ4c
 93y9PVOMkXpl6fZrqiP6T+iecukD/PPlIySnl6byjQDBYMkemSWWDukdnRKbmG9TtlFfx2qzUk5
 euawayzRvlY9loBYKysYAf14wUCR02GmAubnUfSalv3Ripdb6MB1Prh+sxf0vf4YO2mkDOoo6Mn
 ZE6GX6l6Q2zrtXR36C3
X-Proofpoint-ORIG-GUID: Tr8MzgkXe4zC4kedLeTjnVnn-gUxxkun
X-Proofpoint-GUID: Tr8MzgkXe4zC4kedLeTjnVnn-gUxxkun
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 clxscore=1030
 malwarescore=0 spamscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAABpdqSAX4k4lM/hKzdh1u9lP6mGNY+asBdSkjeDRl4x3Bn7Ttah5Q/wBijqHl+FJL8Q+MvbEPI9rnzS6CzDrHASUDjEVOK75aPDxhVBsV0g3u78T/dOUXEirQrnjjohv6jO/YNC3YQins1DfbmvNjQmcfW/oX4XU5GCzmIIhYNvUPrrr5ZONALE5ogeod+NXqpmhwno5wdwBIKxw2m4K7HX5Hi1sXUD4Stu8DYIce3nBnxzaFw3HjfNAjLjOzs3C9vxeSaoLRFGkYrZ8dVFIsH+EzwwTo2WJQwID1v6Ww4wRNG7grSUmSQ2vgkDroxRCQVJtEyfZUyR5ca4XgUc3xB7GIGwIPxqoMr0kFDOL7JI6NjdBQ0qBvNXiHdvFc/LQCwci3cxRtFwaTcd9B6i9x8/nHaKlk314UMDxcWfHFwKsg7i4a4Hg1a4PmzCNKQ3rajBgSN1MMVncWxrk6r+y3mlNOw/D9sSOceGrszWjzeCIUX2cEtRusgNu4b9w8ScZLXB2P0SntmINKm0lJ5CkVTBAaM/QYZGUno4nIySM8sKzLMFdY3qN65AhYqtkY5FdGsf/cpYcoY6DQDnnpCIqamrt6DQyOi/FkNPisgIL6BpQYeY21ApwjaRNK33Cn6vY6VJn2kL343xrmU/RNN0NRCldoPp4BMI9tJ4ddb+dejjK2VDsCAfu0Gm+Ms/f3jDTtgGn9cGDq3naVhB8T93Av21wnP143kgueYK/glK/H3kIPwADkdYBX/RRMH10m1dzSVrIuHSKRNFMuc3pT/mqSYU59obL8c/9aoBCRBgF6BXnJX0e9fInUR5oC+cxwqB+Bkw4NTPMuhUxHfH84SSDJtk0fu+avRzfSLYc2vgUDJeDbMbC7HmSy28XdB6j2rMEmRAVtNVxw1xHxSou8O8jnxxnm0X/0WnFwfLV7RS5gQ+xTUfeyW75YkPn4qytUDYCYeP9SD
Received-SPF: pass client-ip=57.103.76.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c58344cb61..c0610815d9 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -119,7 +119,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 8f171d1397..b86fe9db6e 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,4 +20,7 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+
+/* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
+#define WHPX_INTERCEPT_DEBUG_TRAPS 1
 #endif
-- 
2.50.1 (Apple Git-155)


