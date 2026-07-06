Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6BFC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjgA-00015H-OC; Mon, 06 Jul 2026 09:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjg2-0000eH-Nv
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjg1-0006nU-Dd
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:02 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxMII316792
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W6pxmg0IQ16jzDnIcEZehtTwwvA0mwamCMGIfnC8430=; b=p8U22raW0f4CV+TO
 uPh98T8yf8nLvhlcS49LBsXXqFZlYmw/EI5Pdqvw5cNiIkRfklPz/z736XiW488w
 e3II9yhtShG13Cv6qKHq+RItTNnN73xS704G3Jf6aY/fHy2QMuGI7FX3LxuXssoj
 Jxc9G014vGmZwhwLzJMHXrwpF7FlNd6syJgdWfLz20IuTgdCZLw4NZemkfvZTasC
 y25JACs+OpsyAgSrgsHNiDnmcUcM/ECYJK3uLHL8IQfFdLbmE/CRGqYRrXXGvC8q
 v05rgzyyN3TWlkfCKho7foefIW1yrP9d2FETIZ+8FeGNdxcUdRt27lqiOzQ/3mCY
 of5OKA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7hj5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:48:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so319267785a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345680; x=1783950480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W6pxmg0IQ16jzDnIcEZehtTwwvA0mwamCMGIfnC8430=;
 b=Mcc93YxPyrQkl0jfiquAHqmiSxnnfAfBt0Rzz/4RhO1MNlXIjvt0CViJHm+673NrsH
 /VLu+yu7JMwBDFamCs0FMPl7qT3ndvStKfL7mh3CTixy9ePx+uOz51fAtMlfP8OaBpmq
 kv8vJwDe3FoMLZ7EgkdSQ1gP5MxQML6t9iDwpKgiJcRK4gArIFaRQlJ926NuKMqPahtL
 E5o0gy6yYG8xMU6zp4UPBRal8VuI9zIX1+1iszE6FWauUiXxcavbOfX/2gndDvMirJrO
 1Bkz4DAtFd2fVcVxfFp7T2guwC6ovGaubJgl/6Us/mdYgK96UhrueMJ/3ymOXoFcoNJ0
 OIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345680; x=1783950480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W6pxmg0IQ16jzDnIcEZehtTwwvA0mwamCMGIfnC8430=;
 b=IMlS+tzZ3Ox1+aCkU3idAPupu+9e/aBIn+FCq953+nolygvd4PpQcTvKozg2eX84S9
 6mGwdWbN4ZLCYVj68QuefS/LD4HnxgVNdEUeR0BxTaQz3NKLCxZMoOb0sRPQ3qj1GbNr
 4SiOJbQIpiFolVnBgKh16lxxxpONxPq7lbutVcEIuUxLLVwdjIdlt7yQQN6L3ZP5y8hq
 HDpcrUXlqEvpei/DFLleTcry/rRktwjjhZR3UpCsR2WzExarbZykjb4/Z4hwXN6haor0
 ys8PpFxIN4Ca77km/hZM1h7eIB8stQvtFdFeEc41fwhx0VZpZmUSYToWyvMlyge9dd+z
 agXw==
X-Gm-Message-State: AOJu0YyfIBh30t2U7e81N+7soPHBsyDV6sfNPErNDd9RkJqibNZhohvv
 kj/bImwtOR7VBzTOQBRdNQyo0UF/bsKjw/0U5IylDbRKwK04BlY/fGbk8R29AvqFsAH065pq6Z5
 uYcndQg2uOUpMTth2d+1988h89dszY8w+wP/+aIe3+tmQ/2jjEXMUxA/1sb4U2oIS1A==
X-Gm-Gg: AfdE7clGITOaFHpOsZwkLwaYDGedlTXg1wtCNy6GymHQsR/66bHheMjgqa+PwwzRvR3
 fdHsZHPhoGJ8uerrtTS3zG9M5Yum8Gi8CUKV/6xEhXe2+tz88I61KaSlZ9TMIvbQfFACp1Tfkn/
 3L5j2pKAYp3huR9FZGGnhZvKzYxY8KBr7d92r7n2fVjPZkcLt6JPL10DVFDTzRaBtq0crfG/Q+n
 yN+tLeAvcs75IPlBB0sbb/DxnqGW8TdAFDBYguIfbO1Ncvj9X18/GtI9zv/G2icXk/RvIGqF8Ib
 ULzFQY6Ko+xXKv+qoXKDKN8vV92rNTY8ucoqtKXKB+gCNYVaXYo17aSS7efHIAKKT6IPNJ+UO7S
 tMVLp40FGfo5cQiSLzCQIEn+R1wRRwSuLKrceya5awr2CA0ODPAsNITkLpg==
X-Received: by 2002:a05:620a:3912:b0:915:9931:3a3e with SMTP id
 af79cd13be357-92e8b50c64cmr1706674185a.27.1783345679779; 
 Mon, 06 Jul 2026 06:47:59 -0700 (PDT)
X-Received: by 2002:a05:620a:3912:b0:915:9931:3a3e with SMTP id
 af79cd13be357-92e8b50c64cmr1706669385a.27.1783345679202; 
 Mon, 06 Jul 2026 06:47:59 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c637bc21sm667249545e9.7.2026.07.06.06.47.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:47:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/32] gdbstub: Make default replay_mode value explicit in stubs
Date: Mon,  6 Jul 2026 15:45:11 +0200
Message-ID: <20260706134527.84808-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfXyznjd+EDz/C1
 2lbBnS8cYEp28I5Kw44KfKik4KH0iqXLQgYHD4Ux0Fe7IWExCyimuipimu/nT7Hyu5C9/elQrnV
 F/BvMWzwbjS+pEevq12h3lVNjL1KYhgmvLzzT5xRsfcrMqEO9EbSK99xMfBcjwiBi+16EwOioGp
 R9j3peXhdp+jwJrEwKu+b3Cb93J9qny2y9cusRG0fHtQLxE3Zv5DDk2vzP4xD2isfy3fl4VXEqJ
 9/LX9rsHNf1vt6O6tgSdl+Um5glt1TN3VO05b0+lN5T8TZAvdNoXGfmtBih40pTPZgcw/TKeMsi
 2TOEDICUUZaafjjqXSBhI76awuI5nHj0HTTi3AnbezVfQsLi1KePYLCYMrkOQHzAH6hHs9Otcmh
 +XP08hyoSLIHcQEGGgi00BcDWa5cNPco0YqEhSZXG5ALNCZp2yVOggZlm9EBLg8rwDunojlZ+sT
 dCkpz6CNyophyHgazzQ==
X-Proofpoint-ORIG-GUID: sk2TzX9OSavan0NKI_ikS1gcORx6Hr8V
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX3Acth6oz7AwD
 r0E3MsNtjZM46LcE4+Ij1d2AR7FlS9CLdpR6C9lcTQuDxK7EuN/sZDWatxrvgNpaPkf2ZvMasgp
 /YgCL1YdnJeqSqAt9T0O+qVvmTCXjHo=
X-Proofpoint-GUID: sk2TzX9OSavan0NKI_ikS1gcORx6Hr8V
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4bb210 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060140
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Make explicit @replay_mode is stubbed as REPLAY_MODE_NONE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-16-philmd@oss.qualcomm.com>
---
 stubs/replay-mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/stubs/replay-mode.c b/stubs/replay-mode.c
index 439d97e4a87..5bc8f7d6589 100644
--- a/stubs/replay-mode.c
+++ b/stubs/replay-mode.c
@@ -1,4 +1,4 @@
 #include "qemu/osdep.h"
 #include "system/replay.h"
 
-ReplayMode replay_mode;
+ReplayMode replay_mode = REPLAY_MODE_NONE;
-- 
2.53.0


