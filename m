Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13126C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YS-0001Jh-HW; Fri, 28 Aug 2026 19:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YB-0000eJ-Po
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YA-0005oJ-4b
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:55 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTJlR014614
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZCpMWf/PCYT
 /7u5x3+tgQAIpfRLxx1b2hq7Zeyiep+M=; b=nvd3zXmtuBlggH+3/sLznm+MRFV
 zlQOpbe2aLJWskYCFkDGE1FqaJLTQRsb6npseMA4B4kEzo3KxEQX6WnC6xRIrIdY
 VtOP6EuZsIeJGKAU9vw9MhQqpn7q/++yegEykIBeS9CJEKQcwBl/5NeITTODQXOP
 uxjdJ2nSdWXUgSgrBu9OYg7tMhOFnVTUtko95Ehuvu+Kky3RhX1wfznFhAp/t+v2
 W1PvoJvk6lSnghBj5ftHfzFX6OgfgspwDv4+GyKwXQ1+X/cfbBOW/8pRXI0An2hR
 8dAK6cd8cD12RBzXp27yd8+0AgqxS9R/1mFcPv+kiAPHqiyhbii8azkSiEA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbgvfgf4s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3968dfff779so535406a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957992; x=1788562792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZCpMWf/PCYT/7u5x3+tgQAIpfRLxx1b2hq7Zeyiep+M=;
 b=DS9hK9Q5Zhm2rXdi4B2+WwiYBvOjX6QEOc9DA+8r/v6mS1Ldx2+h5RQzL7vuT24Fvv
 Y4NYH7j8euRp3c8PBQRB/mKxn95tfpGa6wTlCtSFw4ggpwtxBNsNCaWQKPhFs4UKnbMO
 lnEuvFbVUfe5nY7LXhBPcO4wArQ0xKqaj/Nv9W8Vem09cT+6n2O7wKokmQP81sMnBEjj
 uW9kokbuMukSs185z8eLfLZqFuqfaLLEdKY6NoJ7Yx3Bq1LTZNraOx57afFFK829hewX
 CNxMsXVxv/ZoeTDxdGg2VLjKHs2/L/axEV21jtlY0gqEKzceDhiPZjJi5+cNV86vwB/0
 dsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957992; x=1788562792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZCpMWf/PCYT/7u5x3+tgQAIpfRLxx1b2hq7Zeyiep+M=;
 b=UoFTt2FwpFNQkWLZFhvN6OHVtk+XeIaofwfUpE9Zh6f8eM0qHdPy+bmGu1mP9KSptf
 4oOFbZOyBFeqW5sElSsX6Aem9o/GNjYwqbtLSxIqkyeoifMAD4EHiZn3UoexWXOL/toZ
 3qEDPqNRn5eHgy70c3yytsCIO0Uf9N4PpsJ9/qqL7S0hApCilgA0vlg/5KkuDQPTcvdY
 NYpJOEoPuVHRuVnWqiEocy+HC+nNyv/aYycqocL4CFfKXfhE3i1m27WjoKAW1aDdNISn
 QIb6Wk0TJJwAi3E7Hz1q8GEEQcrCcmLfKE3a6GVtIu5OXV9cXvY+DtPGOAg5VMQ9saio
 jH0Q==
X-Gm-Message-State: AFuF++lEt/USA6jJ8i2pMjnMygOniv/pHySU6d1gi0ROHdOjcm0N/6EI
 /VTj3BHEivm6gptH0S7Lp6ckab5bragjSE3URNZrXVgPYWM2wlI9qgBsJwQyl8yglndWxqdnr3t
 dvSs55jCBtYBDjOkdt6RvbD00HaSK4nTDeQXVCgUvRmfGO4URj/QRiUuxyVtPV3Vr3w==
X-Gm-Gg: AYBFou0WN574wJJighhWHcAhJfhsNUPd/LI+pzCgGW70ebKCAee0yaCgtaLTuPJ7/0/
 nrzVcoCZs1HhdpgF0ghvCyR2qt0ze3r+wK1mgEeyxPajm8ZcnxUEL2LNODndcSU4VUUAvhk6ytH
 VJSr5G2Qz4dlQsuXLz769LSo66BGk0f8+9VuFcMXHg63uOVK0RUDL7Mw2optYteZmbj50Qi2r8d
 eXm2ciWA3xf96jeUWLTHrbTeabXHEQSaG9nEg1pkVPuXEamCQMQMTEHsArznxNl49JZ71ZLpvpD
 H3CprMY3eqHgZS4beOGdtRwFOkaUR7QE+fr9wrBcbYcMkwNRQMN/9gVXKiaWwxOkCyjNlLdkFAS
 kp2iAc2Lj6HxJqKrVgaivuX1AFiRSQYpb9zuGDn1bdj8Sj2EKbLWoOB1aFpc=
X-Received: by 2002:a17:90b:2790:b0:396:7c01:553f with SMTP id
 98e67ed59e1d1-3969bc967c7mr21966422a91.21.1787957992037; 
 Fri, 28 Aug 2026 15:59:52 -0700 (PDT)
X-Received: by 2002:a17:90b:2790:b0:396:7c01:553f with SMTP id
 98e67ed59e1d1-3969bc967c7mr21966394a91.21.1787957991604; 
 Fri, 28 Aug 2026 15:59:51 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 35/47] meson: build single binary for arm+aarch64 targets
Date: Fri, 28 Aug 2026 22:58:49 +0000
Message-ID: <20260828225901.367438-36-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX34R9VPQ7LKtW
 Y6uQnu02MmxYCFQb6samD5VMNboxHxOIIdY90GSpO8YNZ2ykznkC+hVlhspe+sYxZpiP2W397l2
 yq9nbn/cT1oCmK2oriJfShe9wNtKcLugMasJTEWJ5dvCNUTR/MXd/ptJQ/YbR01cV2/Ztis5fKy
 iqovyRJt7nL2j1MeC7/6nPZogBhlAnCUcDrCmlbYd0EYgva+fzYpk0sqCP4IYjCSCRYbDTqHbBx
 RQiSeEfjcMLm3L4nUX4kLK894Sscy5wOAIKieP3DWpyoDCSQT1lfiHZm54FvJE/Cl9HP32FsOCe
 D2eqAZ+BG2P490lCSGcqP/jPWHck3h8IFLQGCspLq9UHozVJPbmBQbAmqRig4OBHPWLQuaDCqv2
 /jXpVpgnIAf2epj3rTkM0PTPmvLfCMi/tFj9fF7wHdEaUZ+DMmKZNZEaa6mDjCdfm/Ux97X+sCy
 Ney+ylvcqbr8g7JrYTg==
X-Proofpoint-ORIG-GUID: uzqKMPMDaY6mFk_JZdZEDopYnCUN8O8E
X-Authority-Analysis: v=2.4 cv=UcthjqSN c=1 sm=1 tr=0 ts=6a9212e9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Y0GkpZkJ-W3Whwe0E0UA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX/VntS/ZU0SqR
 Y53Lxp2pEvnQPVcohZ1H+NaP0HQelXiMgOHKV/8bekOXDpproHqEoPYe7bV8FLeYXenN/ic1Yh1
 TwkjDy2vRfbT1EYaTjvQpAEnVPV2ycQ=
X-Proofpoint-GUID: uzqKMPMDaY6mFk_JZdZEDopYnCUN8O8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

Build with: ninja -C build qemu-system
This is not built by default.

All available *-softmmu targets are aggregated, ./configure
--target-list can be used to restrict which targets are included.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/meson.build b/meson.build
index 8023da4a147..9cf441382d3 100644
--- a/meson.build
+++ b/meson.build
@@ -4250,6 +4250,16 @@ if host_os == 'darwin'
 endif
 
 traceable = []
+single_binary_libs = []
+single_binary_deps = []
+single_binary_crates = []
+single_binary_available = false
+
+single_binary_supported_targets = [
+  'aarch64-softmmu',
+  'arm-softmmu',
+]
+
 emulators = {}
 foreach target : target_dirs
   config_target = config_target_mak[target]
@@ -4402,6 +4412,13 @@ foreach target : target_dirs
                  build_by_default: false)
 
   if target.endswith('-softmmu')
+    if target in single_binary_supported_targets
+      single_binary_libs += lib
+      single_binary_deps += arch_deps
+      single_binary_deps += target_stubs
+      single_binary_crates += main_rs
+      single_binary_available = true
+    endif
     execs = [{
       'name': 'qemu-system-' + target_name,
       'win_subsystem': 'console',
@@ -4483,6 +4500,33 @@ foreach target : target_dirs
   endforeach
 endforeach
 
+single_binary_objects = []
+foreach lib: single_binary_libs
+  single_binary_objects += lib.extract_all_objects(recursive: true)
+endforeach
+
+single_binary_link_args = emulator_link_args
+single_binary_link_args += enable_modules ? ['@block.syms', '@qemu.syms'] : []
+
+if single_binary_available
+  executable('qemu-system',
+             sources: [single_binary_crates, files('system/main.c')],
+             dependencies: single_binary_deps,
+             objects: single_binary_objects,
+             link_depends: [block_syms, qemu_syms],
+             link_args: single_binary_link_args,
+             build_by_default: false)
+else
+  error_str = f'''qemu-system only support targets:
+@single_binary_supported_targets@
+
+use ./configure --target-list= to choose at least one of them'''
+  t = custom_target(command: ['sh', '-c', 'echo "' + error_str + '" && exit 1'],
+                    output: 'none',
+                    build_by_default: false)
+  alias_target('qemu-system', t)
+endif
+
 # Other build targets
 
 if get_option('plugins')
-- 
2.43.0


