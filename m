Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7480606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BXR2AoFh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XVu3/6cz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT64G-0005TI-Dn; Mon, 16 Nov 2026 18:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT64D-0005FZ-Jt
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:53 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT64B-0003OH-KQ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:53 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfQ2f1573494
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1yHjGJ2OU6DQjw6mhFlAoRn+/gW3YDkwI2/Lb0lhBxw=; b=BXR2AoFh3x62KVQi
 dzItzNOKYXDv2TLHKdWFwXv0U+YoHDsqcEDV1iFbYiYh6aOnvRPrfzu1uZcCOxNw
 xWZh4vx0dc9OF3vFOgBOn0uXZhF7TCMNqHQiKA+A5d0CMG+Fd3u8AQUflU7Vl5Md
 vjfnBkPmSpJXakgsZ0+jG3ZbkiFHQ+QSufW8jLTq6DH6QdsRgOIs+wk5OhH2eSUa
 HI+ygXt9B+SL9QW4TRR3CK1wMRSJC4uw9wJF96LaAupfDxSW5f4Hgs9clT0n6/3P
 e0u9hUU9hNJvRf2slTSKx2ltx3XPGaa7B2sli4ubv/1GqqHnCeBZ6oQOMgPYwohc
 BJTVWQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqgk04q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-94970ad532bso332785485a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871489; x=1795476289; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1yHjGJ2OU6DQjw6mhFlAoRn+/gW3YDkwI2/Lb0lhBxw=;
 b=XVu3/6cz7qF3nYgMmjLhwa5w95jUczeO1yqS+zvui45sxqMrveShlvzcXwWKv4yBt/
 hPMZzBnKPJPYHtmUdmjaHIL2VG3JOzH56Gb7dFj0P+NjIax1v0JbxIx8sFWLO+nUK3aT
 BPbXZunJ+GT3Sl8yNX4hjCCciq4ox+GthMhwcr28JFpSRVusLNTwxK3x4vE1eswOsJAT
 NDOGEORtS7+k2/80Qm/yjfJpFDKbR0HLP4DevUyXlTZc/Icw+t7S9h1Qds2r2gANUP4x
 Qqji1m3GhowzZHStA6DkNV3s9/bQ5pZAUaNhCr2Vbhioql3DDuZZMXvQ6NWD0QDZnCTl
 z1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871489; x=1795476289;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1yHjGJ2OU6DQjw6mhFlAoRn+/gW3YDkwI2/Lb0lhBxw=;
 b=R/qMQiyCVfJ2tis/u6Y/d6uHExJpzl0jJHUD3vUvGE7sB9idTFv/360PhN0qck74Xz
 CcsIGg7HeFqE1F6/O7/40Vc2PwtoTMVm5gLJ1XveQ8C3IcFpuZVVgNiqHklrJwI+1wgN
 ZaUyArhWmMYtZMcn4b4m+pDUujRb9pbPeK901JHArw6x5ewExe/V+QqgPeAJ/vSYynMi
 qwzFGJRCcJ7GLuN1fmHOlGjEqckYVGFyMPQvizjoU/fFhB+RxZ8PjKYYvl0zIUTjy9i9
 EjY3EBQQ3dCsbNU771/16zwVWJRoURhP/cCIfuluh5eZpPb5vgim+O6uEc8tnH04gXLK
 22wA==
X-Gm-Message-State: APuU4Z9MJYLWtBF+vEAX8Kmh/eQl70gzfOtQ1ITFX6f+0zsoMqsdvsEl
 uYez+MxiLcgOpuozQV6EAgIuHIMtgKfwKJxWJjzC4gXY6JWkH1dvNdLV5V2euzBqkZzanTzBYmo
 CHVVfWuafdY88YJv/5mA/iwkgaSdZ9sz3a36PJbP09wLXD7iII1dYhutpuJL5TGMGBg==
X-Gm-Gg: AYBFou1lHLL9KTi0IxO3YEwpjf6SO8mXu35j3xfJNJl46pbuZF7f8lcDR282coIsuCC
 SPN2TNr9RE6NfQbiVKA/X/VhwWCg+oMvmyHYCPe/EI9fSOvi2atQ09IWl45PuSl3E6sKeK9hSEr
 x41HHErr63HHuqq2XYA9OqVz79L0v8WWsGkKcNnWD7OxDrrhH4aSaTRtbE8tNZkyrSOAAyaIQH2
 +PCvlCAMmjA3/hTO8Zwmgc3TnPQ414rvFNPBOVBOFsWbt71fZgbQzJAq3nAR+cgiA5VvPErM8Jg
 vxupgtpsSJWWsAgSTQGCKEf11PI5pV140rFfvWtR1QRm+W5Jht/CmKIc6VqLoa69lmWi2aHfQqF
 yGwxf4Ck+2ssIem7oxoTNT4D/dY0io9CM7FUoq2rwjgV4vdDKDkAc2XhwUeOQhHl1j7wZOVYRn6
 Z8DpuPalIyTfDTnw==
X-Received: by 2002:a05:620a:880b:b0:93c:6417:f9c8 with SMTP id
 af79cd13be357-9494bbdd1f1mr2057735585a.29.1794871489101; 
 Mon, 16 Nov 2026 15:24:49 -0800 (PST)
X-Received: by 2002:a05:620a:880b:b0:93c:6417:f9c8 with SMTP id
 af79cd13be357-9494bbdd1f1mr2057732685a.29.1794871488655; 
 Mon, 16 Nov 2026 15:24:48 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c6451sm26213548f8f.45.2026.11.16.15.24.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:24:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/22] qga: fix uname() return value check in guest-get-osinfo
Date: Tue, 17 Nov 2026 00:23:22 +0100
Message-ID: <20261116232335.31593-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXyXh2PEEgPktY
 UXjaB3WcQofuudiBzUpTBryv8dNsNWHwNvgIAqJIi1PokidzEVBp6qLD5zZOG3WjZ1JYARz9jPw
 r4uuT56GATLL9vKTSlZjEzrViY/xEXo=
X-Authority-Analysis: v=2.4 cv=epRKXYpX c=1 sm=1 tr=0 ts=6afb90c2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=x4Tn9eRuAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ZX6WzTYzfb5601Eun88A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=NBNoG_gAMsMl4eXmfJ8P:22
X-Proofpoint-ORIG-GUID: qW3J0NTaI1gV-O2Ff4Yby-t8gCIm125s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX8PymhoehjBxY
 TizNzJG4VHfieZWZ75Beided2AXHNT3kNZtR8C8p9O33CNHq0KJBoaJAs+Vgnzh2O0oCI2vGnRI
 +6CWvyzR+nGLAp5ONUz3JTtWh576OcZqcaM7sEFpokzjYtBRdTY4lFCGyS1g3tprS4ll1tu4zlq
 bxptrcuFLahYKeXz95RAC0iqT9JsHWraE21j02Oyek4ak+5xKIlaxzfwHm4vjDAWUZaABwO9jZg
 M6lJzTafEM24+i3dURY03g6bCeXEbrNySf6pVBgWzXgfHNaEPVRbYO5q+MT6eu6u5HvdEybO82s
 l6cvOHIdrD6cNn0SqQlbjfa3OXltq4llGIfqyD+VkxSWEb4kxSYu9UWHbmBzi/G6j/OCyfoTE00
 xuDQ2TciPkgP6YBrijqojQJp/OxzJY331P3qT32MPqoyvYqzxTn9xKQgWOESYKgzGFWvBL5d7uK
 EAtbpGWwGHf/6PndhjA==
X-Proofpoint-GUID: qW3J0NTaI1gV-O2Ff4Yby-t8gCIm125s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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

From: Brad Smith <brad@comstyle.com>

POSIX only specifies that uname() returns a non-negative value on
success. Solaris returns 1, so guest-get-osinfo treated every
successful call as a failure and reported a stale errno.

Check for a negative return value instead, as linux-user/uname.c
already does.

Signed-off-by: Brad Smith <brad@comstyle.com>
Reviewed-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <auUjFweAHtj1YSFt@humpty.home.comstyle.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 qga/commands-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index ae53eb356965..39e772b3ff32 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1336,7 +1336,7 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
 
     info = g_new0(GuestOSInfo, 1);
 
-    if (uname(&kinfo) != 0) {
+    if (uname(&kinfo) < 0) {
         error_setg_errno(errp, errno, "uname failed");
     } else {
         info->kernel_version = g_strdup(kinfo.version);
-- 
2.55.0


