Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646F606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b8ydOHOu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T6vNuSYV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMWNN-0001ER-Ud; Thu, 29 Oct 2026 16:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMWNL-0001Dy-N4
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:05:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMWNI-0002ci-8A
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:05:27 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjeF81659629
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 20:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E5nbeU7q3nBGRGLb612Bo7uq2ca6up1rt5Lu2LlRg8A=; b=b8ydOHOuC+DXBw7E
 8N91tab2LgIktk4Wrms4+iSHrE90lprybRlFmNxcPRDjB1bSWczL2kihG+ZbtnTD
 9N6xE++NkALvYN3TqGBHNjXs1ImjqLc+KWvOzBTWXxI68Pyau5dcig1K6r8sDaOf
 NRo5IBNrB39/E7zul4ieg/yEGkL9dvENG8cqWPZrn62yMmh16bO65e3b0KIDBtx3
 liBXXB69MNUrLDLbnzTjP2LujPpeya6KBjNOP4iwrxUwQC9CqWnWLPPhl0Dmth2s
 I59yhGH1So86VjUAbKmYFyEdjMvJLkoi30iKBPr6I6UzCLRDiYfDmd7fR7TGjR5j
 YNicLQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmaunhfjb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 20:05:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91256a7b7b3so227176d6.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 13:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793304320; x=1793909120; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E5nbeU7q3nBGRGLb612Bo7uq2ca6up1rt5Lu2LlRg8A=;
 b=T6vNuSYVMSpdsrlBxVAp/zGJyn4Q8VN5cbJjvtrRNrKt69pK9Bnte7LzpsQhD1MFpO
 GndFurKylnbN7tAUlchbqmsi2RmVebMtOMHzk56qV/JRUiflD2hPck8XZ6nW7hsjZ2Rd
 Wq8dMP77dNtZz6UMAlk6ep9LlV0Iu5h7BdmH7lW1++GMdPtxZYwe3Xe8tAViQBnerAFe
 NJvgDFF9CH+8/Y9A7g2ilzELygSvHJsxPJq9kRMVkCQ0xEMNglxG6fWkZPPRL6jx2Y6f
 6IpdverMgeYiI2LmL5Zz6Ezo8SzNMqh7/iaCzDcroame6V69iAQCsX4SN9QeJLdaZl1h
 19Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793304320; x=1793909120;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E5nbeU7q3nBGRGLb612Bo7uq2ca6up1rt5Lu2LlRg8A=;
 b=nhC2ArdzwZg5mCmNTeY3z4iLtsyMOBCaLoIaUkPMVfE9DRhjQ6LycWKmjXMX8IllcZ
 4cXxYjcuHVcFzqT429BxC7wxhh27RbsjDinViFTI4oy95IiWlVQTkJ2qXhGQ9z0pzVT3
 hTYao/cgN+DuvURZgSbHPKCh0Ktvnc6p/DtSesHJCIeNm4Kxo6VfirhIpZupPQckAqnG
 Bsac/BqZKYfLQ75uROfQI/C4fxYk27q41x2voCml5MpSeGblkU5sHK131SuekQfZzzgu
 85fchy1djJ+jI3FKg0fKMVfcTOP/2L8eEmEdpC0/JXMuHK0MkToubs/vgLkhjlOyLcjD
 uw3w==
X-Gm-Message-State: AFq9FYLAqjzpk3r9dg0As086ljw+bvgFPgBeAl/nfTi8Wn1W5puQlFwy
 w6ggiD7NIOenPeMj/ed9CwSpT22os1JgfeHtTTXKayukMfo+Wt09a/Cn1Qi56Iks9zrQervuylS
 RzoLwe4935eqKqW7j00PFPeos6o4XMXFFULQOk3dQT7cjZTFuc/u1vRz0Dg==
X-Gm-Gg: AYBFou2ckxKu/HnK84ofhXMRFrtf+m9NLRdcZ6PjNVnnnbDVi5Crz7uL1h/qeIrm7Ek
 0rvnrn5t5TebdARpvkiHy1bUKmqzMvyWhoXyQSnE5EzX3zZo7tdMfxAcYlJJCLF0zgoM5+Ympa+
 8fkS1gjR0H6HbGDZTYvAcVws2CZiFwZJSQcaJQrCTeux1yCcBds7vt46uvOlP+Glg8n1tgbMYeD
 ZEAmPgzCPiu15R7EPGmBtiB4U2h6JXPeeCCJ9E4DU5bxtq9JZHrFJFA2bDOvUkqNESOBWxtqvWJ
 1BjKrwksVeLBZXV7+NBH0hK4qyRuQrIrzvEkZYEmRO2/OiVzQBJsO79gwQwpkYFr1ZCsk6XvkFq
 2srvKkZjS0ijiph479rckGhVGMTi42f2Sdzce1VfuGAoBLjxTqLo844t69P5ynip36SWk48F2
X-Received: by 2002:a05:620a:8806:b0:93e:4d74:68fd with SMTP id
 af79cd13be357-944217b2aeamr44240985a.65.1793304319965; 
 Thu, 29 Oct 2026 13:05:19 -0700 (PDT)
X-Received: by 2002:a05:620a:8806:b0:93e:4d74:68fd with SMTP id
 af79cd13be357-944217b2aeamr44233385a.65.1793304319157; 
 Thu, 29 Oct 2026 13:05:19 -0700 (PDT)
Received: from [10.111.141.177] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04723sm97081895e9.5.2026.10.29.13.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 13:05:18 -0700 (PDT)
Message-ID: <1b750750-bc6f-4dba-b68e-7845323b779f@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 21:05:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] tests/tcg/mips64el: Add bare-metal harness for
 R5900 system tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fredrik Noring <fredrik.noring@gmail.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-5-philmd@oss.qualcomm.com> <auOPHGG6lAEIlGr-@aerith>
 <2f0355b9-fcdf-4ab2-88c4-8e16a06a67b4@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2f0355b9-fcdf-4ab2-88c4-8e16a06a67b4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hN1gxsD9uuyncQCLEPYQ2hpsYo42sqDd
X-Proofpoint-GUID: hN1gxsD9uuyncQCLEPYQ2hpsYo42sqDd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX91zaXZoWmKKa
 NyO91K7ZkS5dtD6STeHn0jiW34bgm9uiTKmpD6VvvWxFaTkn7I6Ct6+wolpNUucF07fOFYn/l2o
 Q7Zf23cN/XFddwq48CIlqktHAO0rpp6ypgM7zVQbfUNQ9hZbMrflvmOAlZVJfAZxc4wawQw9nYK
 2yKNxAiUcaBbFo4x8JpBapetXbNIFb7BQbnYKTpmqsxQAF2v0+anF5JadQdl2hJa81NpSsjiSsD
 u+rw3NDHzHNEiwQo5k03Onob0fzsJXsU8VycJwkWu2N9NgFGe1tminiL7G827EH1KLf7tZU49Dx
 mKB/H6KDGkgR6UxSsyUVNdu+R3jPg8ONmS7MzudQPdNvRAkOXY+vKUut21bAa25f/6Za6mHdk/F
 bv7BgIQMsqPvxKg43H27X+LODVXX23Z7MoZdQEDu4xZ184KZV3I3+wzrW2141sJe7Ew18wroA4z
 V5X0uti2rEgffFdrMRg==
X-Authority-Analysis: v=2.4 cv=It2L47/g c=1 sm=1 tr=0 ts=6ae3a701 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=GrnPlP4MAAAA:20 a=VwQbUJbxAAAA:8 a=BcPKCTjPAAAA:8 a=NEAV23lmAAAA:8
 a=rf04l5cdAAAA:20 a=7mOBRU54AAAA:8 a=QocWeGxWX385ma3SHS4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=MNXww67FyIVnWKX2fotq:22
 a=wa9RWnbW_A1YIeRBVszw:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfXz/+hfdePAjxi
 NsldNGFGT7gqTVhmfcFsJZ2JIEdqR4InqXiuxweJ+GN/VByElTtI7+UACghXJ2D1gBMiG+pU9YM
 LVsOIWZDRx7AssEYB41LImM0KHz7Kpo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290079
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey Fredrik!

On 2026-10-29 20:18, Pierrick Bouvier wrote:
> On 10/29/2026 10:23 AM, Fredrik Noring wrote:
>> Hi Philippe, Maciej,
>>
>> [ Maciej, a post [*] from you in 2021 is referenced in the following. ]
>>
>> On 28 October 2026, Philippe Mathieu-Daudé wrote:
>>> There is no libc for the R5900, so its tests can not run in user
>>> mode [*].
>>
> 
> I think that Philippe meant "there is no *prebuilt* libc for the r5900".
> 
>> Both Glibc and Musl are available for the R5900.[1][2] In fact, we also
>> compile Gentoo for it. I believe the -mfix-r5900 option is used for the
>> official Gentoo MIPS downloads.[3]
>>
> 
> If precompiled glibc or musl with companion toolchain are available from
> a .tar, yes it could be used.

For now I deliberately kept user-mode emulation out, focusing on system
emulation which is less invasive.

I got user-emulation working but this add another QEMU binary and last
time Laurent as linux-user maintainer was not motivated to add a new
binary / target for 2 users :/

I have these changes on top of what I posted so far this week, but
building a r5900 cross-compiler on a x86 container running on an
aarch64 host takes age...:

-- >8 --
diff --git a/meson_options.txt b/meson_options.txt
index c9247e9de1..a48f2fcb7c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -461,6 +461,10 @@ option('tcg_tests_cross_cc_mips32r5el', type: 'string',
         description: 'cc for mips32r5el tcg tests')
  option('tcg_tests_cross_cflags_mips32r5el', type: 'string',
         description: 'cflags for mips32r5el tcg tests')
+option('tcg_tests_cross_cc_mipsr5900el', type: 'string',
+       description: 'cc for mipsr5900el tcg tests')
+option('tcg_tests_cross_cflags_mipsr5900el', type: 'string',
+       description: 'cflags for mipsr5900el tcg tests')
  option('tcg_tests_cross_cc_or1k', type: 'string',
         description: 'cc for or1k tcg tests')
  option('tcg_tests_cross_cflags_or1k', type: 'string',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 064e1429a4..69f203fa74 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -539,6 +539,7 @@ _meson_option_parse() {
      --tcg-tests-cross-cc-m68k=*) quote_sh 
"-Dtcg_tests_cross_cc_m68k=$2" ;;
      --tcg-tests-cross-cc-mips=*) quote_sh 
"-Dtcg_tests_cross_cc_mips=$2" ;;
      --tcg-tests-cross-cc-mips32r5el=*) quote_sh 
"-Dtcg_tests_cross_cc_mips32r5el=$2" ;;
+    --tcg-tests-cross-cc-mipsr5900el=*) quote_sh 
"-Dtcg_tests_cross_cc_mipsr5900el=$2" ;;
      --tcg-tests-cross-cc-mips64=*) quote_sh 
"-Dtcg_tests_cross_cc_mips64=$2" ;;
      --tcg-tests-cross-cc-mips64el=*) quote_sh 
"-Dtcg_tests_cross_cc_mips64el=$2" ;;
      --tcg-tests-cross-cc-mips64r6=*) quote_sh 
"-Dtcg_tests_cross_cc_mips64r6=$2" ;;
@@ -565,6 +566,7 @@ _meson_option_parse() {
      --tcg-tests-cross-cflags-m68k=*) quote_sh 
"-Dtcg_tests_cross_cflags_m68k=$2" ;;
      --tcg-tests-cross-cflags-mips=*) quote_sh 
"-Dtcg_tests_cross_cflags_mips=$2" ;;
      --tcg-tests-cross-cflags-mips32r5el=*) quote_sh 
"-Dtcg_tests_cross_cflags_mips32r5el=$2" ;;
+    --tcg-tests-cross-cflags-mipsr5900el=*) quote_sh 
"-Dtcg_tests_cross_cflags_mipsr5900el=$2" ;;
      --tcg-tests-cross-cflags-mips64=*) quote_sh 
"-Dtcg_tests_cross_cflags_mips64=$2" ;;
      --tcg-tests-cross-cflags-mips64el=*) quote_sh 
"-Dtcg_tests_cross_cflags_mips64el=$2" ;;
      --tcg-tests-cross-cflags-mips64r6=*) quote_sh 
"-Dtcg_tests_cross_cflags_mips64r6=$2" ;;
diff --git a/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker 
b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker
new file mode 100644
index 0000000000..f46c5a54b6
--- /dev/null
+++ b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker
@@ -0,0 +1,40 @@
+#
+# Docker mipsel (R5900) cross-compiler target
+#
+# The compiler is built with Gentoo crossdev because the regular Debian 
MIPS
+# toolchains do not provide the R5900-specific instruction set.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+FROM docker.io/gentoo/stage3:latest
+
+RUN emerge-webrsync --quiet
+
+RUN mkdir -p /usr/local/portage-crossdev/{profiles,metadata} && \
+    printf '%s\n' crossdev > 
/usr/local/portage-crossdev/profiles/repo_name && \
+    printf '%s\n' 'masters = gentoo' > 
/usr/local/portage-crossdev/metadata/layout.conf && \
+    chown -R portage:portage /usr/local/portage-crossdev && \
+    mkdir -p /etc/portage/repos.conf && \
+    printf '%s\n' \
+        '[crossdev]' \
+        'location = /usr/local/portage-crossdev' \
+        'priority = 10' \
+        'masters = gentoo' \
+        'auto-sync = no' \
+        > /etc/portage/repos.conf/crossdev.conf
+
+RUN emerge -qv \
+        dev-vcs/git \
+        '>=dev-libs/glib-2.0' \
+        sys-devel/crossdev \
+        sys-libs/zlib \
+        dev-lang/python
+
+RUN crossdev -s4 -t mipsr5900el-unknown-linux-gnu
+
+ENV QEMU_CONFIGURE_OPTS="--cross-prefix=mipsr5900el-unknown-linux-gnu-"
+
+ARG USER
+ARG UID
+RUN if [ "${USER}" ]; then \
+  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/docker/dockerfiles/ubuntu2404-arm64-ps2dev.docker 
b/tests/docker/dockerfiles/ubuntu2404-arm64-ps2dev.docker
new file mode 100644
index 0000000000..8f2e9f2bd7
--- /dev/null
+++ b/tests/docker/dockerfiles/ubuntu2404-arm64-ps2dev.docker
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+FROM docker.io/library/ubuntu:24.04
+
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt-get install -y 
--no-install-recommends \
+        ca-certificates \
+        bash \
+        make \
+        binutils \
+        file \
+        python3 \
+        libmpc3 && \
+    rm -rf /var/lib/apt/lists/*
+
+RUN python3 -c 'import urllib.request; 
urllib.request.urlretrieve("https://github.com/ps2dev/ps2dev/releases/download/v2.0.0/ps2dev-ubuntu-24.04-arm.tar.gz", 
"/tmp/ps2dev.tar.gz")' && \
+    tar -xzf /tmp/ps2dev.tar.gz -C /usr/local && \
+    test -d /usr/local/ps2dev && \
+    rm -f /tmp/ps2dev.tar.gz
+
+ENV PS2DEV=/usr/local/ps2dev \
+    PS2SDK=/usr/local/ps2dev/ps2sdk \
+    GSKIT=/usr/local/ps2dev/gsKit \
+ 
PATH=/usr/local/ps2dev/bin:/usr/local/ps2dev/ee/bin:/usr/local/ps2dev/iop/bin:/usr/local/ps2dev/dvp/bin:/usr/local/ps2dev/ps2sdk/bin:$PATH
+
+RUN command -v mips64r5900el-ps2-elf-gcc && \
+    test "$(mips64r5900el-ps2-elf-gcc -dumpmachine)" = 
mips64r5900el-ps2-elf && \
+    mips64r5900el-ps2-elf-gcc --version && \
+    printf 'int test;\n' | mips64r5900el-ps2-elf-gcc \
+        -march=r5900 -mabi=eabi -mgp32 -mno-abicalls -ffreestanding 
-nostdlib \
+        -x c -c -o /tmp/r5900-assembler-check.o - && \
+    file /tmp/r5900-assembler-check.o && \
+    rm -f /tmp/r5900-assembler-check.o
+
+ARG USER
+ARG UID
+RUN if [ "${USER}" ]; then \
+        id "${USER}" 2>/dev/null || \
+        useradd -u "${UID}" -U "${USER}" 2>/dev/null || \
+        useradd -U "${USER}"; \
+    fi
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 2164f143ea..5f640d13e8 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -1,3 +1,5 @@
+subdir('system')
+
  tests = []

  tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/mips/system/boot.S b/tests/tcg/mips/system/boot.S
new file mode 100644
index 0000000000..ab5b799059
--- /dev/null
+++ b/tests/tcg/mips/system/boot.S
@@ -0,0 +1,32 @@
+/*
+ * Minimal R5900 bare-metal entry point.
+ *
+ * The MIPS UHI semihosting ABI uses $25 for the operation and $4 for its
+ * argument.  UHI_exit is selected by executing sdbbp with code 1 while
+ * semihosting is enabled in QEMU.
+ */
+
+       .set noreorder
+       .set noat
+
+       .section .text.boot, "ax", @progbits
+       .align 2
+       .globl _start
+       .ent _start
+_start:
+       /* Keep the stack away from the image loaded at address zero. */
+       lui     $sp, 0x0100
+
+       jal     test_main
+        nop
+
+       move    $a0, $v0
+       li      $t9, 1                  /* UHI_exit */
+       /* sdbbp 1 (SPECIAL2, code 1); the PS2Dev assembler lacks the 
mnemonic. */
+       .word   0x7000007f
+        nop
+
+1:
+       b       1b
+        nop
+       .end _start
diff --git a/tests/tcg/mips/system/meson.build 
b/tests/tcg/mips/system/meson.build
new file mode 100644
index 0000000000..d7b51711ec
--- /dev/null
+++ b/tests/tcg/mips/system/meson.build
@@ -0,0 +1,76 @@
+tests = []
+
+ps2_cc = find_program('mips64r5900el-ps2-elf-gcc', required: false)
+
+qemu_name = ''
+if 'qemu-system-mips64el' in emulators
+  qemu_name = 'qemu-system-mips64el'
+elif 'qemu-system-mipsel' in emulators
+  qemu_name = 'qemu-system-mipsel'
+endif
+
+if qemu_name != '' and (ps2_cc.found() or docker_supported)
+  qemu = emulators[qemu_name]
+  boot = files('boot.S')[0]
+  linker = files('linker.ld')[0]
+  smoke = files('r5900-smoke.c')[0]
+  runner = files('run-test.py')[0]
+
+  cflags = [
+    '-march=r5900',
+    '-mabi=eabi',
+    '-mgp32',
+    '-mno-abicalls',
+    '-mno-gpopt',
+    '-mno-extern-sdata',
+    '-fno-pic',
+    '-fno-builtin',
+    '-fno-stack-protector',
+    '-ffreestanding',
+    '-nostdlib',
+    '-nodefaultlibs',
+    '-nostartfiles',
+    '-Wl,--build-id=none',
+    '-Wl,-m,elf32lr5900',
+    '-Wl,-T', linker,
+  ]
+
+  elf_depends = []
+  if not ps2_cc.found()
+    dockerfile = 
files('../../../docker/dockerfiles/ubuntu2404-arm64-ps2dev.docker')
+    image = custom_target('image-ubuntu2404-arm64-ps2dev',
+                          command: [docker_wrapper, 'build', '-f', 
dockerfile,
+                                    '-t', 'qemu/ubuntu2404-arm64-ps2dev',
+                                    '--platform', 'linux/arm64',
+                                    '--add-current-user'],
+                          build_by_default: false,
+                          console: true,
+                          output: 
'no_output_image-ubuntu2404-arm64-ps2dev')
+
+    mount = meson.project_source_root()
+    mount = mount + ':' + mount
+    here = meson.project_build_root()
+    ps2_cc = [docker_wrapper, 'run', '--run-as-current-user', '--',
+              '--security-opt', 'label=disable',
+              '--platform', 'linux/arm64',
+              '-w', here, '-v', here + ':' + here, '-v', mount,
+              'qemu/ubuntu2404-arm64-ps2dev',
+              'mips64r5900el-ps2-elf-gcc']
+    elf_depends += image
+  endif
+
+  elf = custom_target('mipsel-ps2-r5900-smoke',
+                      input: [smoke, boot],
+                      output: 'mipsel-ps2-r5900-smoke.elf',
+                      command: [ps2_cc, '@INPUT@', '-o', '@OUTPUT@',
+                                '-Wall', '-Werror', '-O0', '-g', cflags],
+                      depend_files: [linker, dockerfile],
+                      depends: elf_depends,
+                      build_by_default: false)
+
+  test('mipsel-ps2-r5900-smoke', python,
+       args: [runner, '--qemu', qemu.full_path(), '--elf', elf],
+       depends: [elf, qemu],
+       timeout: 120,
+       suite: ['tcg', 'tcg-' + qemu_name.replace('qemu-system-', '') + 
'-softmmu'])
+endif
diff --git a/tests/tcg/mips/system/run-test.py 
b/tests/tcg/mips/system/run-test.py
new file mode 100644
index 0000000000..912b6bb01b
--- /dev/null
+++ b/tests/tcg/mips/system/run-test.py
@@ -0,0 +1,30 @@
+#!/usr/bin/env python3
+"""Run a MIPS bare-metal ELF and propagate its UHI exit status."""
+
+import argparse
+import subprocess
+
+
+def main():
+    parser = argparse.ArgumentParser()
+    parser.add_argument('--qemu', required=True)
+    parser.add_argument('--elf', required=True)
+    args = parser.parse_args()
+
+    command = [
+        args.qemu,
+        '-M', 'none',
+        '-m', '16M',
+        '-cpu', 'R5900',
+        '-display', 'none',
+        '-device', f'loader,file={args.elf},cpu-num=0',
+        '-semihosting-config', 'enable=on,target=native',
+    ]
+
+    # Inherit stdout/stderr so diagnostics remain visible when the test
+    # fails.  UHI_exit makes QEMU's process status the test result.
+    return subprocess.run(command, check=False).returncode
+
+
+if __name__ == '__main__':
+    raise SystemExit(main())
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index c80a3716f5..0d3c44b643 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -6,6 +6,10 @@ tests += {
    '../mips64/octeon-insns.c': {
      'qemu_args': ['-cpu', 'Octeon68XX'],
    },
+  '../mips64/tx79-insns.c': {
+    'qemu_args': ['-cpu', 'R5900'],
+    'cflags': '-march=mips64r2',
+  },
  }
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 3ac4711748..e69aff6211 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -215,3 +215,38 @@ if 'qemu-mipsel' in emulators
      }
    }
  endif
+
+tests = []
+
+tests_mips_r5900 = [
+  '../mips/user/isa/r5900/test_r5900_div1.c',
+  '../mips/user/isa/r5900/test_r5900_divu1.c',
+  '../mips/user/isa/r5900/test_r5900_madd.c',
+  '../mips/user/isa/r5900/test_r5900_maddu.c',
+  '../mips/user/isa/r5900/test_r5900_mflohi1.c',
+  '../mips/user/isa/r5900/test_r5900_mtlohi1.c',
+  '../mips/user/isa/r5900/test_r5900_mult.c',
+  '../mips/user/isa/r5900/test_r5900_multu.c',
+]
+
+foreach src: tests_mips_r5900
+  tests += {
+    src: {
+      'cflags': ['-mabi=32', '-march=r5900'],
+      'qemu_args': ['-cpu', 'R5900'],
+    }
+  }
+endforeach
+
+if 'qemu-mipsel' in emulators
+  tcg_tests += {
+    'mipsr5900el-linux-user': {
+      'cc': 'mipsr5900el-unknown-linux-gnu-gcc',
+      'cc_dockerfile': 'gentoo-mipsr5900el-cross',
+      'folder': 'mipsel',
+      'gdb_arch': 'mipsel',
+      'qemu': emulators['qemu-mipsel'],
+      'tests': tests,
+    }
+  }
+endif
---

>> As for QEMU, I maintain my own fork with R5900 user mode support since
>> 2020, based on QEMU v5.2, as well as a corresponding Gentoo package,[4][5]
>> because later versions of QEMU became unfixable and unusable for R5900
>> user mode emulation.
>>
>> A proper QEMU R5900 user mode must emulate the FPU like the Linux kernel
>> does, which is why QEMU 5.2 remains the latest usable version of QEMU for
>> the R5900.
>>
>> It’s worth mentioning that there are discussions on introducing additional
>> FPU modes for the R5900 and Linux, which would allow use of FPU hardware,
>> despite its noncompliance with IEEE 754.[6][7]
>>
>>> [*] https://lore.kernel.org/qemu-devel/alpine.DEB.2.21.2103172243160.21463@angie.orcam.me.uk/
>>>
>>> Inspired-by: Maciej W. Rozycki <macro@orcam.me.uk>
>>
>> Fredrik
>>
>> [1] https://github.com/frno7/gentoo-mipsr5900el
>> [2] https://github.com/frno7/gentoo-mipsr5900el/blob/d84d04b2fd9d47d5cce9c1c0884026cc37d008cf/scripts/install-crossdev#L16-L17
>> [3] https://www.gentoo.org/downloads/mips/
>> [4] https://github.com/frno7/qemu
>> [5] https://github.com/frno7/gentoo.overlay/tree/main/app-emulation/qemu-mipsr5900el
>> [6] https://github.com/frno7/linux/wiki/R5900-floating-point-unit-(FPU)
>> [7] https://github.com/frno7/linux/issues/3
> 


