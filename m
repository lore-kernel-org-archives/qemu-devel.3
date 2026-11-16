Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB02606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IfBvFtqT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BPvBwe7O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT64L-0005qq-HT; Mon, 16 Nov 2026 18:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT64J-0005kl-R7
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:59 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT64I-0003PW-4g
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:59 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfClC2589426
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ORWWxo44M1be3OVX9wPplucGF3wqThoScTPY/YVpvqA=; b=IfBvFtqTnBfiQX9Y
 5NIOql7ZtJOCMaY117XJ+kbqIelLCQQ2DoL/4o84xntdPlhtXidpb9ImnsOUn6LL
 gxykF00HDVuGppedZ7YiUNcpyAG0lA95HumWiTdkLVgxxH08TWe/xjOS0DB+DFPI
 /PiuhBYxUkH1/zPjRixEoAOfc0x8At+9VAkMLlyzxGZssXTC/lLddatNLIjM8vXy
 RFfs/CwXTTFOuyH2l7NKtI9Zn9xWo498mMxL8B7dFbBSyeinJv7Y69Sl9aJFKcBH
 neUw8nG2F3AVGAkD/8cYJFp4+U3Cpe+T4PUMj8i5X0xMpilHDy3lbfZZBRUPVFbc
 B1FzAQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2k8c0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:56 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-99859876e19so686935241.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871496; x=1795476296; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ORWWxo44M1be3OVX9wPplucGF3wqThoScTPY/YVpvqA=;
 b=BPvBwe7OL5AWV/Q/udKcpMUM35cteuSUkODlo6TQ4dDC6NtSHqkgt0kf/xfvNlIlHE
 u5oq65vwoM9E2jgj0suJ1O1YBmTxbeEyv03EIrXJZOK24ekOTV4ENp8a/vF1SmqqsJi+
 I2yXKiZ80gLALtP7yDkykb9hi/5/XfHVtVH/2aEw7e6bdIDaIPWdKTnIYEK6qvKDdmCJ
 psI8x0nATaamHxsRU2wdu0CyyEDL64HaMrXttiuNBzG+qdjVqRU9mLZ6TYL8j/BE/f2v
 kD4uURzFBSeuu4KkT08aJ9U9V3ad93BXFuZUwKtGviguzvxIahz3p2IvvVKB5ZB4V0gC
 wijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871496; x=1795476296;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ORWWxo44M1be3OVX9wPplucGF3wqThoScTPY/YVpvqA=;
 b=IvB0q+i4Gq/UKvYPkDzDvDZplZZ9+TGw5paqjXRtu8C4STWVIZl1SmQW2sdFGwKvdW
 wjcPamQiloJq97TF0/ht8diQT79uF43pn1iAYcHhYwrdDrAQc260m+GUEc0D2YjS6euA
 GPgqRkNJKiXbfkcEiXjZVMCXlITTkPh6tnkuTNff5D/6gPBUdWkz9xBeXSzLKAN0nEBq
 SOS3c4cnDKwAulsRmHesW635nCQJeoa7N7k8hIopYKvFogsBZ805mJX/LgkYryRHYnUv
 ULByq4b+wN+w2SDBorSW3G9MrdkhQFWT2i5pddfqYNXAYLpaXkgIb89hrTv1H6nKEJ7H
 nmbA==
X-Gm-Message-State: APuU4Z/vTyAJZmRIK1ToRTjBUoC9v95whYW4/Yf0Ib6GxynW3F1CiSkv
 FHJfysPvfazNOhLSOpaI4XUZPvBswhmrhevarETuVEVL2mxY9aeIfENeBebcu9/RLDYJ91ezYvA
 eWmxRTyf86dah2R5UVGxKV9VqVfOlT4q6G9Z9jjKvCN3C4qbGhneJxT/ZajZXVoqmRA==
X-Gm-Gg: AYBFou3UHR0+gLIWiidWpHIS2BIgtZ9z2mWDJJYME7Awd2IIqQv1zIZKp6nR4pPuvyv
 A5E5HsFkBszKh7/xH6mZ9TeoDvfWEM7Gfg+XgHWAUmqTwLTgAUwc8iagnvoaGKA/HS+CUYrCYl0
 Hoy3wdXvi7p2fN+M4vrs/lBvqhYy9ax2fn6T1EesKeygxKY+7RJ23nT900dDVVVFX6qSjM0KADs
 O6Fwi1u4axLmLj8hLPgizYQ1lN2mfgSJY5o1LdXVT88L5kyPCgUwLV8+NTtSAAu7Q28KSlsgD8k
 RAMY2oDsZ5pxTodBVK05wGu/oS+jJu65D8eB0Z6zmEj3TeTjzGhwXvpQQMIyvAcEBpw9lEZAePy
 4KDn1HoujmV5OetSs07uhwC6QiuUNC/wSqJxGu1E1WaCa/5j7d/mTU/6yiYUg+DjSuurxuWLROa
 P/3ogj7lBSaoQQhg==
X-Received: by 2002:a05:6102:4188:b0:7b5:4700:3a58 with SMTP id
 ada2fe7eead31-7d64d87536emr3875696137.31.1794871496182; 
 Mon, 16 Nov 2026 15:24:56 -0800 (PST)
X-Received: by 2002:a05:6102:4188:b0:7b5:4700:3a58 with SMTP id
 ada2fe7eead31-7d64d87536emr3875694137.31.1794871495660; 
 Mon, 16 Nov 2026 15:24:55 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783e9288sm23761655e9.15.2026.11.16.15.24.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:24:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/22] build: remove vestigial CONFIG_SGA
Date: Tue, 17 Nov 2026 00:23:23 +0100
Message-ID: <20261116232335.31593-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afb90c8 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=AYmAHwb26JlU27TCzWMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX162Upot/rFbR
 xFSu/ugRo0/SQLN0NFq20m8caosWPLq3vfhBqm8n+JRCW9fR0gHy4/kmHyLk2ei5Vf+pgXwnzRu
 I53MkW+wYiealML/5KQoktl07Osnw7o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX7NFbdOAXRekv
 w2GRvFtpJmbD9ZAHlyWOPaWgaYYmCyBJizWkIuiq225NB72IejLxTF4EH53DM99BCe//oRuNNMi
 YVIm9LfEdZUmQjcPI5iMnVlpKCn1NpeqxlSjxBe360BTi3kWCGetqH7xu7bey4sLJlpQcn0yCxz
 wAITtqRrzQpgA/SqIx18isJYUDkxQKSA1w/zj1qXZkhKQFfT0VFZmmuX5xGftAwzRPwoX4J6FlK
 KcRS1cEU9FboYorv3ZFzvVV8wNL2Cwj9N51hq1yUO97zlwWFkWn/w1DDRWErbgEfwqAjhLpgkC9
 gl92oGCnMjcWh7fT6KF/qzYnJ1JvEUPtXQKxXeJNlyJnnlFrM1OilYbKURkdvGOtlnaqn66nRAc
 amBqaDm/BfFt0UgC5YU7GHTY2/u9pL4bvZyVx7mvmR/X+vJlRujW0JZNJer83G3apYvDFoXImds
 bmNaUrZorcPIpp9omwA==
X-Proofpoint-GUID: s7yCi5lOy5YZTCCN_Ep2nCDnaoHEgPk3
X-Proofpoint-ORIG-GUID: s7yCi5lOy5YZTCCN_Ep2nCDnaoHEgPk3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: John Snow <jsnow@redhat.com>

This configuration knob no longer exists as CONFIG_SGA was removed
quite some time ago. Remove it from our sample config files.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20261109183605.3210043-2-jsnow@redhat.com>
Fixes: b482fb43deb3 ("hw/misc/sga: Remove the deprecated "sga" device")
Message-ID: <avId9w77otpW6B1H@redhat.com>
[PMD: Unconditionally add the test (danpb)]

Message-ID: <20261109183605.3210043-2-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 configs/devices/i386-softmmu/default.mak | 1 -
 tests/qtest/meson.build                  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index bc0479a7e0a3..b935ee613329 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -17,7 +17,6 @@
 #CONFIG_PVPANIC=n
 #CONFIG_QXL=n
 #CONFIG_SEV=n
-#CONFIG_SGA=n
 #CONFIG_TDX=n
 #CONFIG_TEST_DEVICES=n
 #CONFIG_TPM_CRB=n
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 626791d1eb48..6e2938d913ef 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -74,7 +74,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['numa-test'] : []) +                      \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['test-x86-cpuid-compat'] : []) +          \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +           \
-  (config_all_devices.has_key('CONFIG_SGA') ? ['boot-serial-test'] : []) +                  \
+  ['boot-serial-test'] + \
   (config_all_devices.has_key('CONFIG_ISA_IPMI_KCS') ? ['ipmi-kcs-test'] : []) +            \
   (host_os == 'linux' and                                                                  \
    config_all_devices.has_key('CONFIG_ISA_IPMI_BT') and
-- 
2.55.0


