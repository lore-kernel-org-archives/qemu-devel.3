Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29282606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MCkrI7uz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C94wvQuf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI1c-00031n-QF; Fri, 23 Oct 2026 12:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI1S-0002FL-FD
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:21:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI1Q-00033D-7T
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:21:38 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5xla2109294
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k5TUrT7aocWpW3v8fq3cGIu0S7N3wPDqhm4F1tDApd8=; b=MCkrI7uzDXpHRCI2
 DQU7PDo8tqoEMs8UjxhhMjPrGNqj7cjXot/5l2qQoXXfMXF1C+vKX67/TI0YZD9M
 O8CfGXnjzkUtAR4U1fglxtK3yB24j+nm9TXbz0v5pQPDlCg1HuNFQvwdhBJAOuin
 xDJtmpP8EXpveevj9e3YWz370mhv0o6jEnd0VztqjdVEaGOhgtn+eVgp3phQ7gLX
 l+2cv/AgbH2+nUb+mVrFUhxE3+6c1XIX1fPaG18M5WLxKk0VTlqVDjp3Hyh25E26
 GQbPlu3j55yAVC8HWi+0iagj2lA7WKr1OshBh88NQZHyxrKEHeQYNAPrxYSrlHda
 i0rmqg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms4gxw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:21:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f568dee56so218438485a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772492; x=1793377292; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k5TUrT7aocWpW3v8fq3cGIu0S7N3wPDqhm4F1tDApd8=;
 b=C94wvQufWK7joNO353XS9h5/chJYDHbAF584G4JrN5pZF8CT9wgEjotDppuiam16Ju
 39FjkDQJZac53D6WKuqhPmJ2LN4YbMsO9LkEzMrKoy16I40SxJ2LJqGMmZaDrG0jrMGn
 yFK9Xnzpn5YCA8o+07otomn3KghkgKY+tHTkZVcQ28G1bov4NC+ti2SAvUj/CzTu0+Gc
 OIa1DQ0ZEVmxyOx7IWsFeiNWMY9IWEy+w6O9kmHY4rb7EcumuS24eDHFA5BfayqAilgp
 z3AL9lP6R+rk8tz7GkHcvRE5cbQ7gZQkG6OEdeJR5+Lj/5eIS/6/hwTXMRqagbGW2Ibe
 D56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772492; x=1793377292;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k5TUrT7aocWpW3v8fq3cGIu0S7N3wPDqhm4F1tDApd8=;
 b=CEEzv64d85u5o5ivdKaR2Adi1tl17SzPrNRrAzXAAfM6cGRn4ewbpqpIUoFhuGOH7f
 u0bBb9vu3RdsLl7NIaILt3v4/I0L0fl9yd0PQd1f+7ca9KB2BUuUnw2m7Bddk2S/dBY0
 77h3AAHyYCo7UgklZ1z0xr0sOYMdfVWFWcZxm9qvQ65btHpfssG/taOLZWG8k8U4m4JC
 FmAZHzJ0ZG/2AI7njAabzrfuVXXWexMJbU3AMeSC69div2ZOnYB87aKJsx+tuqWOjF5M
 uoB03nzFm70l6Rd4AnrGUBhXdpzALRArbzR9qnTfm3WPeMHPkZJeG2aQhOHLA8Hi+JZS
 94kw==
X-Gm-Message-State: AFq9FYLOfmarqnC5NdqHw55TZ1F+h39bmBblJ7ChYDYdW5dGh4e+CHfa
 4czL3TwYZ+pHEC3BdMFfTIo5eIFPmTOBgrmhQZHPGttuRNPUXtosP8xq3UCNpzoW1Q5BsrByeYJ
 TXljfoN9uiAWjlJ5+2f4be0hxQxpyA9ZTpfpuu2cZ/5ceoA/yW7S04aeeNu9L6eMfbC3D
X-Gm-Gg: AYBFou1F1LJoIYk973S+x8zCQ9VbW2AuoAv8fSazVx1+bjBo0uiM+9uGiXkgfy95ZjC
 g/Zv07++LiKPr/HuzYQSzQnSsWn6lBAlGIGygIL5FY3Eq9+/l8tsImp0Drfc1q/ebz94VaEI+PD
 cj8TSLlR3O34K34nqZhSqLnmh8Us/8IeMxG8P4sXunWpXnVB4qaujQjzVkqLPNnIfjUAHphJUYr
 pOz1zcJCsTUqW38iillF9WQoyET8o/D05RItBKDxWfKLEyHHDSztyOHTpSuvNdSRit/rV5skamU
 +yulsE9TMbB467iKJGmc5m7knj1Ecn96G13nWUiHmMGV1IxgjsE3+2UNKXRiTrcm3FpSTZRABxz
 QrjHzuVMGOwYqrUqAMIh8TULjN+dDaHcvKAYleoL+
X-Received: by 2002:a05:620a:470f:b0:93f:3829:8492 with SMTP id
 af79cd13be357-93f6fa11031mr475363285a.78.1792772492268; 
 Fri, 23 Oct 2026 09:21:32 -0700 (PDT)
X-Received: by 2002:a05:620a:470f:b0:93f:3829:8492 with SMTP id
 af79cd13be357-93f6fa11031mr475358685a.78.1792772491741; 
 Fri, 23 Oct 2026 09:21:31 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2b061ceb7sm14315195e9.6.2026.10.23.09.21.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:21:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 66/83] target/m68k: define and call helpers using HELPER macro
Date: Fri, 23 Oct 2026 18:13:14 +0200
Message-ID: <20261023161332.60153-67-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX6SxlcK7nBBQ5
 fEAPHntXnJZfqO0BhtXUtAmUF1V1IKrTSsAB7XedcP9Cflgv12v+XivD+nr38UbisOo8VrnjFvl
 w5mKGgjzktAJ4Wkh1HvFAoS1VS7bGsAK5q6lGyorGGTVcFB6xmQSyqAYlxGVhX5Ih2KKfw5g9a5
 jnHIYiAcgpCQWdoEZ0BYhArzTSpQLnmd9eSyjc8pklioHBp6EBBMX14m3G5s3zwBsN2iFvE1XfX
 4mDq2Cdwg5ATP79IjdFMhkGU9/YUV9hIVJ/FAklPl7epMOV6KsIsups7tAmhcVc0O1T7BjtDZHv
 2Oq6Q2OEPZ75NjK4JpCheXjkpbYp9JAGvxoAl2iu1YnWEPjC+omEBWFWodTXKUGi0hV9fZdKuam
 nrln6bel54COeFI+Ym6J4zKZRYXiALCtnxh37Nm3MssNKtirV4QN9x/tE4cHHN5aMFbCe8pxcww
 yh2hP1jFTQ5BwlACXwA==
X-Proofpoint-GUID: 9obkkN0z7_L0ZpbRET-8TvHK-QTGgJrd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX5J94EZd19ye2
 XEmx0/bowcERfZB8H+ggAz5pvgTeUeclOku2xz1Q/XqKWJBf2Rw6wsOYTAFMSV+zALWPEJwuYJJ
 tdG+N6wpFL8DfSsOPUj7fMYRMiGMdw8=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb898d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=Wv-XcSyDAywttTPMHZIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 9obkkN0z7_L0ZpbRET-8TvHK-QTGgJrd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230064
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20261019212046.149572-8-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/m68k/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index c9db8a1b39d..3ab64b9f760 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -1036,7 +1036,7 @@ uint64_t HELPER(bfffo_mem)(CPUM68KState *env, uint32_t addr,
     uint64_t data = bf_load(env, d.addr, d.blen, ra);
     uint64_t mask = -1ull << (64 - d.len) >> d.bofs;
     uint64_t n = (data & mask) << d.bofs;
-    uint32_t ffo = helper_bfffo_reg(n >> 32, ofs, d.len);
+    uint32_t ffo = HELPER(bfffo_reg)(n >> 32, ofs, d.len);
 
     /*
      * Return FFO in the low word and N in the high word.
-- 
2.55.0


