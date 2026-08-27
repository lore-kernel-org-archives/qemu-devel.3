Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA1FC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziG9-0007ZX-RC; Thu, 27 Aug 2026 18:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG8-0007Yx-Ie
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG7-0003aU-2j
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:44 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLlEL795064
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yBasRKZLoUgUCra8VLFgHZNRrhUZ0qHuH1I/Q2k/dnw=; b=csVJv59YGuLro781
 RKl5N6r6sfiDvQYOmZhfq4scMy73MiDA9X1QK/xobRtccL5c+kOOo8ch8Xbw0x2R
 WfZ1zVj3Lca6RZEDDZ1rw954RR7sJIga1450wAjNXxhzprHAI6v5+B0tERcPN/+6
 jq43gLW1pJ3Ww1Wj292o3h8Twwh9cZ9SpuKfNGTOQKB0PN8D2zVNTbnxtHgPVH+M
 iRtFP+dkAp18d3vC8Paf4+Coy5EzY+6nfdeWopH1aK7wz+rY3FAryicYr7hONOVC
 GuAFstgsyQNCkuMKYF72Ct0tZNWYfKSyGJZecauh6HlAYMAwGBSCeIVHJg6nxiSW
 umQOcw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjm7t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-85321e37104so477672b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868451; x=1788473251; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yBasRKZLoUgUCra8VLFgHZNRrhUZ0qHuH1I/Q2k/dnw=;
 b=SnyfQmxhssf4vy4gBdX+soS2O5dY/parRyS3BzlxKDP/xmNPty3vB3vkNdFg0ENoLZ
 eQHIwLXsb5cdUZt2Wz8XTAYiILcxLJaO+vWeyLUotgtspZP3MWifhAD/HMK950LL9rrW
 r3nswDkrbfRON6I4YjX4U9CsP4ZixpazwyG7lhABDCY9eei+rmNbOMGs5eABfeGof6Ft
 Rlum6SlDNXgA3eFyFDJeM7jsjrzUQGlo4uvZfiNyC6Qo46XcmqEyReIy7rOwPlCN06sO
 D4QNWrn6GCMIuwrrlnsdQEZsOQFyhZiiRUqtxl4pq6DzL9+ZW9rofVLvF28KxQeYOuLZ
 V9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868451; x=1788473251;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yBasRKZLoUgUCra8VLFgHZNRrhUZ0qHuH1I/Q2k/dnw=;
 b=mM6u6so7S3sj2UQoSiVOqpf28iWg5NkkgBgDTfJOqNTzJGVniZ37LtYlUm0lLdi8KK
 ZkG9KQH+EG9l5o1Ahrx+nRIs3a2be0N/L0I6KEKSWhS4Ou9SzY8gO5+BXl91uMBonmiv
 3yJw5ZninY0Ifq9hxMCGgOuNJhRtfGL5s+a3lAgnIYwzTf9dEjlUdBMGA8m1/eBsvQpt
 6IUNILz1gADuE8X0nX12t+ZeynPQJJ0KUM8Y5hg3qdsK/h8GDGJI1/IvZt/QOWPulcsX
 NZUA0N5IlrjTrhA9pa5CP3i8oWSH0kF+XaI1MRsfyJAJ/Xi4x2DKw0geO/K4QvchxtyG
 t73w==
X-Gm-Message-State: AFuF++lo0B+YVqJIlDd8WDJl6fzsh4k5dolTmbF8zLnbapoac4sz7Brc
 gnWzNx7NvRVG5KY/CC5dh8n+PSaTxF60ROz2kKhGIVn0iZeF3yNvVKOrL5NblvZUTRtaNGlJRgh
 mBEYNlVlpFad7jlhY5Rrvi25gFx11J8+VfUSFNnjw4Z26q7akZPWzBPo2OtibyAJkYg==
X-Gm-Gg: AR+sD13klvudULc1vV96yT+oP2kZo3dC3XJtCkVIhNjDshcUCqk+7gSMa1dwQyuFa3q
 uzj8pG0quG4HPvKrn6nvDBdgDYl63xXH04Uf6uxew1Vhv25B4spFmWhbb/KR2F/YEx2Q24FfQsh
 KQyIxX917vNq4dJ7zMXS0Lqf4Huhc6oyMg6q8sxEpqrfRxkpQORnPq4YnbG4+aGvMnfWj5O4j8v
 EkhVSv0fCvZivjm2SwocRVGPlWLi6JlaLrVMLqWDOF/7TYGr8fYUoV3sYo1dmIBfS2Z8ynx6lkP
 4CL3T/UXKRIIMPX6PwusgsQ6Big3+mCgXaWLpVvMjg4mGQopaHMLeeXfmgg/QNNp6vaBYUucMPO
 uORy8hDvfPfz4WaTXn0C06jZYK9T1HeMLr4DadGcfeaB7edcjKA1FV55+g6w=
X-Received: by 2002:a05:6a00:3ccd:b0:847:8b11:5966 with SMTP id
 d2e1a72fcca58-85627dbfa0bmr4367811b3a.1.1787868451139; 
 Thu, 27 Aug 2026 15:07:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:3ccd:b0:847:8b11:5966 with SMTP id
 d2e1a72fcca58-85627dbfa0bmr4367742b3a.1.1787868450775; 
 Thu, 27 Aug 2026 15:07:30 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v8 031/105] tests/tcg/meson.build: use full path for QEMU
 binary
Date: Thu, 27 Aug 2026 22:05:25 +0000
Message-ID: <20260827220641.84885-32-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX7sa9UHhIZX6u
 5c4vB9soZc4qRfKN5+s0k3RnH6LOfLdbdu6uTX+VIjkSNqCt0GAwkTXQr5LEbss9bed2Ru10DnO
 2ShPA3/YBo/NRVMJt5InnGFUJoiDRKQ=
X-Proofpoint-GUID: YUv9ES1RPVkUvks9SfzSQo0fT2Tz1T8x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX2WEulDBfm0sp
 mPCFDBAos9CB58OLBRCmuuDw/APD2LEj+tycdzzGh9R2YkBEi3g+oqX53bkda2ZTEoL/qMJRdH7
 X+zFPltjDkh8eqQdEHdyKSYZMT6ssI2oz/FOBT1ZWrJ+Enf9D5x6ZRXJ/ZGYeByAZJk5cXm/5l/
 IpN9J9idLfJ1apm7oay7PfODvtxFG0ej7DW/oG+i/CyqlA+lHqY+iFbtLQKkUNlk1hOWpd+oABh
 IE0+beMazVj+XMfZpC2jL434zv8lyZ+f2C5yviHCUI7C3X9ompWlYGHMrvqPVwg0nDZxxtZTBkB
 Z4HCSj00MxXpsjF1gt4ybQfUfxbKO34aBqum0+A97zgMaO59CLB8uFaEarfDBEBl/KNvAM0DH6+
 cx/TBNHC31yScJjD7sislaAb1EXUTZCQH6P88s86DHUIwy0S5L5TlvbhEP5oRaqH1gLpbih4fqq
 ebM6QwWsHAyzUpg3Buw==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b524 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=wOKWSiVmv2u3Qo4ObykA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: YUv9ES1RPVkUvks9SfzSQo0fT2Tz1T8x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

On MacOS, meson does not find qemu binary. Use full path to fix it.
Also, add qemu binary as dependency for the test, to ensure it's built
automatically.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ea17a947628..fe382638297 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -323,12 +323,13 @@ foreach target, plan: tcg_tests
       endif
 
       exe = built_tests[exe_name]
-      cmd = [qemu, qemu_args, exe]
+      test_depends += qemu
+      cmd = [qemu.full_path(), qemu_args, exe]
 
       if 'gdb_test' in setup
         cmd = [prog_gdb_test,
                '--gdb', gdb,
-               '--qemu', qemu,
+               '--qemu', qemu.full_path(),
                '--qargs', ' '.join(qemu_args),
                '--bin', exe,
                setup['gdb_test'],
-- 
2.43.0


