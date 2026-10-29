Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4E606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZTmoivkn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YCQG2teN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUEC-0003QD-Vm; Thu, 29 Oct 2026 13:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBb-0007Cd-E5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBY-0003hO-Lw
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:10 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGCxjP3872933
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xchSFkoLT7wQreEItSdHtwnzmQxPcqqOKW9v2LldNaY=; b=ZTmoivknOkwELyS+
 veBHNoOVrKdlvMHm/yMU9ffbT88dmB5nbv5HJINDOXpKkqqxcyyyFshfLFMJ6Eol
 rXEZp/MCg589KuEXw3v6MXxb1xzqp1HaR3tsGAO+v+fvz5RHgvTmqQzl7DXlundz
 6LcMkFRxxOdrlIkUw1kLB2ToJiljPEkK/r84EMliNUs7rieixLmUosHiyK5fZCW0
 h/S0zcx6qnhuGcpdII2by+0fCsVQ3GTupJXG6NkK93/3fFGMYQ+SCmJDjN1LZzNh
 70OwRYmVWyRdKHfCVXZg4OuZmZ1VEqOfKgG+XuBnsaLW6RAcGcWWhrhc9Jp25rfv
 Bx9Cdg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76217tv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:44:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f5844e383so375687785a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793295891; x=1793900691; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xchSFkoLT7wQreEItSdHtwnzmQxPcqqOKW9v2LldNaY=;
 b=YCQG2teN4cgEc8J8wY60HapuqP+0NR/VEHeNX5ghvsHSjqKk/kPkE3K1mlbR9O3gd0
 qdai5gVuiHQAtMWcr/PMt9ClNaUOqKWnHht5MvJm8mrNRG0AzuuXEKHLyIT2TREOFbQW
 +U3IMOxlh3OVVun8OHl2/PI0jj0RYlYUslK/WNQ3WdGuhK+6gFcQ93AREsLGGAOTENDG
 78akKcE5E2KBUiotl2VohnLU2OsDzQB3EBQ98NmlXV3ZKT4Mmgopf0WYjY/rVq9JIacS
 JxmMAddlhxVsMmUMNs3UW3R1r/IYxR7fmsjMB7WUEFAxqJryCtvxfg5v5aDLxAvF5yEm
 i9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295891; x=1793900691;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xchSFkoLT7wQreEItSdHtwnzmQxPcqqOKW9v2LldNaY=;
 b=yVjLP1Q3QyLGnT9+cDkYcSQmXz+4Nf0I/RK6W0J/0bod6EI0E0PvtPqAiHtkMlUYHp
 /BUaoR9ALohP4gGKE7d97VGwegNJvDwvoqIW4rF4RdesDM+FnRwFuO4pnDUvbTT5HxhS
 msdpWP+Cwomx728mULdQCea8/4mj9L4aB+8y1oBjS+pfrTjsqxFaHcbJHDeSn979vBD5
 heg4l2oabnjXn2Fpg5ljeN9g/NSpugbAOHc+WpD9HzAHffXnWorRNNHqdJ/2gpgQY8bW
 m5t0jpvwv7v+K9BF+hAckPwufTn1T4h8Jfm9y8ERpdaGfswOmUF95BUGW/j3kdueuJ+O
 Sipw==
X-Gm-Message-State: AFq9FYKuP6gDnzwMxGF4SQfiZCJCUJFjIlOCsYSwRLCq8Z51dhdoQ3ie
 I+O2zXXSJfY05X6gZxDCgFHLtiP3TcLHtqecOxZnCU2f8h/OF6c8q8ZcuVCy66egUInfISb647N
 OR8xoh4OlvszRTV4q7xsZnLUJ7trcVMzPZyzyKMxm+BvPNa45Atr4BFFvrwjGza1Vh5W1
X-Gm-Gg: AYBFou1meayO1p5BcjuL1smcia8xnnHY1BEUsL37de4HIlLU2GhDphBdsG/68spABNj
 sogSVuMZuvXOzjlOineVeGyFvpTGLPT86o5UbiCfDFpfRTUC0xc9J26snokR1YDlZ4FL2XswmNw
 ZJfHIbZ8IyV0OLGGvGYsRatAj6WVhun5ypNN9k0ygbYrtlvcSHei8EGWqQ1J3ZVsHJHTojJDj71
 b5DI3no0S0lik/NtdfRaS1uzbvBOQBJ19iIZZzaQXv+jyXBIHjQGRiCd/NX3B1bRrg+DeRkya0P
 19db1xg9iIeZlOu076XDW5lvT9YOGTYv35kRevPDB05qEnn17qNVlipUXuIiQHSMjSUbwgT5+NT
 KQK8gW2nT0Nai01Dngcble6iLickXXE1jljvzFSPvGqH53M/lhQ3cbyS9QoE4dJEofpEsAOvwKe
 Ql+scwbVK89TR34aW+yD5xCIedypkRAg==
X-Received: by 2002:a05:620a:63c6:b0:93e:746e:235c with SMTP id
 af79cd13be357-94408a26905mr907434785a.15.1793295891054; 
 Thu, 29 Oct 2026 10:44:51 -0700 (PDT)
X-Received: by 2002:a05:620a:63c6:b0:93e:746e:235c with SMTP id
 af79cd13be357-94408a26905mr907431185a.15.1793295890613; 
 Thu, 29 Oct 2026 10:44:50 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe770502fsm3870795e9.3.2026.10.29.10.44.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:44:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 02/12] meson: Add the tcg_tests_cross_cc/cflags options for
 mips32r6el
Date: Thu, 29 Oct 2026 18:44:23 +0100
Message-ID: <20261029174434.27985-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029174434.27985-1-philmd@oss.qualcomm.com>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sPPDpZiVJ6cSA8pXMdeXzBNC3qyNnJua
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX8re4Ku3VND64
 mBFKMhzwh1rp29TZ81DZZagVw8I6edh2wu2XkX1xVhF1jf9ILjLyStp5BvpaHZ1tiqIjh4RUuR3
 Vn7Lei0xkovZgW/noghJF15eRpRvp/rC/BTuPVHM8oAmfCVBkfMMo2+rrMscZNNzUm3TqCCWvEn
 ac+5d2PkFlclb2kz2pkdMGDhA9EKxcpoinYchLN+QGq0R64fz5adDTCmy96lPZJusFCIuLyuYor
 9+NDfJZNY0f4d3kB6OISTV2MasGyfQciWJF7F9iYMhRR50/UBflu//17w+1+b47axiCUpaNAeRc
 M+k55qFerEFlQCG2RFHxf4F4Bv1VuNZP+wboxxSV3qQ8hi4PPcKl9wpJTx5OlvGNuw7hmRuiwaQ
 hPAGyFn8GmKbiFteHi8rUNrY7PEuluivqgLRESll86UZ7mURseg8uY3bEjoI2AMZQAamC78iwxI
 20zPt9fggGetFv61cgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXyidL+Tq0OvOq
 8cUDqQ94De3UTUlW8zsMar3XhG9CgnwST0oi0fLdG2rgnu9sm3khVLWGSwkXEtYOrVnpp0T+LK+
 aFX7RZIAHYFrTcSdXS+evN7+Bu73Ggo=
X-Authority-Analysis: v=2.4 cv=Kv3YSmWN c=1 sm=1 tr=0 ts=6ae38614 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ClBwLX5JVu_AAdhY8JwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: sPPDpZiVJ6cSA8pXMdeXzBNC3qyNnJua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add meson tcg_tests_cross_cc/cflags options for mips32r6el,
similarly of the previous mips32r5el commit c7b1a7bc9d33
("tests/tcg/mipsel/mips32r5el: add msa tests"). This allows
compiling TCG tests for the mips32r6el-linux-user targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 meson_options.txt             | 4 ++++
 scripts/meson-buildoptions.sh | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/meson_options.txt b/meson_options.txt
index 895c6e63c28a..9ae8e44ab54e 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -461,6 +461,10 @@ option('tcg_tests_cross_cc_mips32r5el', type: 'string',
        description: 'cc for mips32r5el tcg tests')
 option('tcg_tests_cross_cflags_mips32r5el', type: 'string',
        description: 'cflags for mips32r5el tcg tests')
+option('tcg_tests_cross_cc_mips32r6el', type: 'string',
+       description: 'cc for mips32r6el tcg tests')
+option('tcg_tests_cross_cflags_mips32r6el', type: 'string',
+       description: 'cflags for mips32r6el tcg tests')
 option('tcg_tests_cross_cc_or1k', type: 'string',
        description: 'cc for or1k tcg tests')
 option('tcg_tests_cross_cflags_or1k', type: 'string',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 14990966d31d..0f8b56bd7f8c 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -539,6 +539,7 @@ _meson_option_parse() {
     --tcg-tests-cross-cc-m68k=*) quote_sh "-Dtcg_tests_cross_cc_m68k=$2" ;;
     --tcg-tests-cross-cc-mips=*) quote_sh "-Dtcg_tests_cross_cc_mips=$2" ;;
     --tcg-tests-cross-cc-mips32r5el=*) quote_sh "-Dtcg_tests_cross_cc_mips32r5el=$2" ;;
+    --tcg-tests-cross-cc-mips32r6el=*) quote_sh "-Dtcg_tests_cross_cc_mips32r6el=$2" ;;
     --tcg-tests-cross-cc-mips64=*) quote_sh "-Dtcg_tests_cross_cc_mips64=$2" ;;
     --tcg-tests-cross-cc-mips64el=*) quote_sh "-Dtcg_tests_cross_cc_mips64el=$2" ;;
     --tcg-tests-cross-cc-mips64r6=*) quote_sh "-Dtcg_tests_cross_cc_mips64r6=$2" ;;
@@ -566,6 +567,7 @@ _meson_option_parse() {
     --tcg-tests-cross-cflags-m68k=*) quote_sh "-Dtcg_tests_cross_cflags_m68k=$2" ;;
     --tcg-tests-cross-cflags-mips=*) quote_sh "-Dtcg_tests_cross_cflags_mips=$2" ;;
     --tcg-tests-cross-cflags-mips32r5el=*) quote_sh "-Dtcg_tests_cross_cflags_mips32r5el=$2" ;;
+    --tcg-tests-cross-cflags-mips32r6el=*) quote_sh "-Dtcg_tests_cross_cflags_mips32r6el=$2" ;;
     --tcg-tests-cross-cflags-mips64=*) quote_sh "-Dtcg_tests_cross_cflags_mips64=$2" ;;
     --tcg-tests-cross-cflags-mips64el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64el=$2" ;;
     --tcg-tests-cross-cflags-mips64r6=*) quote_sh "-Dtcg_tests_cross_cflags_mips64r6=$2" ;;
-- 
2.55.0


