Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BB7C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegZl-0005m2-8m; Tue, 30 Jun 2026 18:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegXd-0002v4-0Z
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegXb-0003ut-H3
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:52 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDguO2920150
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xl6Yv6lxkZ3eY3NoScDQIgt89IBP8oIZC7MwT2nJFyg=; b=CpZD0+92OR5VAu7m
 zyysf+XiOdoGEZKwoXjdOBl4nuxnxCUMWULglr2CwSygrv8PdTJBUKxVshhGWRqM
 eHQ/WgDrz+1t1XJMqFzG5sxmxtpToX1tyY+5+8o3vIqAKMJZ8fvPujUnUb5pKgoZ
 fPq825cpnFPeJveZ1+KsXp8G56tV+DelNokv98SzpbImnxLVg88BFrbgB9QIObSL
 QYDHhZIyRHfc6m4UYaQRrG0om4SNjhScH0Nfd/zUlU5S600PEg/wnYuMSG1htbE3
 2DIH5wJYEVXY6xmRW7KclKweT72o59lMQQG892Y20cDn4jn3EfHV76Gy/OyyV1eF
 HHdLEA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvw8ue8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:36 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9692731af28so1829175241.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856956; x=1783461756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xl6Yv6lxkZ3eY3NoScDQIgt89IBP8oIZC7MwT2nJFyg=;
 b=L4APdCv69RYepFdGlWW03iLqqxBtrQr/uNWeMxSVKjkmDjvtREI87AJUoECkkC8mRV
 4RUjJq8mUxk7MSSii5Ii8mIB4JpXBDIXvs15kr7DiYCLCUwQI2swUlUdqakibhi1JvSQ
 KSad4K6D5inWoDjo1ySa9P/oC8FclJQkauP5Z4FF2bZbIOMwvXpkeaWJ0w5ux64Wr+vI
 AE3jpOwisItBZm5tzHOW+50qr9eZ37dqYHwnBf3glYYd/DhbEE9TXwxhpjhqWLCCvW4z
 rM4Tq0n77u63mTQH1cIXgXDTqGHIxqfQMePsjFS0gZ+pDgfR9RPr8VxvNap917Wb26Iy
 e4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856956; x=1783461756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xl6Yv6lxkZ3eY3NoScDQIgt89IBP8oIZC7MwT2nJFyg=;
 b=m5/n9CyqtEppckQRYcg6CTaqULkfCOyfXUEe00RoDVCFmtMV3RSA/A4INytpuSDuzl
 QFQW/D1cMMvud1omhh7jpf3PAQwaGJ3FzQ5i1ZJgtXJAylBiYRXPg/Rajum+viq7sPZo
 8USJrG+32WISJLrK/RUicuqmC/utpjT7I9xNltPMM7fQOtx8nxWCPgS2DT3FDf2gW1D4
 KAbwXSnuUQQAKBtKeAqSKB0H4xVSCA8zCvBDxi/xcCVL5Wb2NaWnr3Tl9Ff6ZbGewNFM
 /hNFKvsD3H4mVujNlWqvqncJVkcupXMPHFhaZirOWCJPc0bGMj6s6ee6nP+fwtx77Erz
 qFqw==
X-Gm-Message-State: AOJu0YyUFZkqQOIxluaZXv6ng1AXa7LSyEwuCV8KRqbXRc22dq6YbRtc
 Znt5y4CgdtLvF+f0DSbW4p+bKDTLFG5iWhzzc9GXXm0ptA+JLyIRrHd6H9LqnoC26NMLCWIm4fg
 mS4zA/UIii80r4Tq/hx76e/kIAOzAD1/2f6Xby+Kf0TzByIfYwVJsCVyi1/5qKBrMPA==
X-Gm-Gg: AfdE7cmp6WX4m17+Ry4ASVE8zf4Qd/n/FipYV3TbgDNXtkM4KzeTG7QhKQfNJ03il+T
 EilNfM9S5B5VlS3l9rli0fiFAeC+5duMQEDk76I36CYskx2uApNU5tc4rRWyyys43JoplzruGxO
 o67mCl0iSxD4zY9OuX60ZkXu+oC/rJjJOQMNrF8LK1iJbzjKiKF9yiFUxTZr4G49xpdYmSQDDL/
 Nw2uJe7GZUwoL3DuI8MCpgRADUtGTYYsSiMEMJVhsgDHVqicxE0ztzV8b+85ecHIl96hCYnpUpb
 9AV+I8g8J/Hrm9jdSirNXa9n+oMH8FnwlI1MJkcwO8RxhnOx/s795QvSFAfDkWZF4PWwiHSkY+0
 a0M2KQqq3TCorWETwWDuunMwDgy7d62S+o3NkFNC57nLku7vX5VFamd4Ne36cIDSQzyiT
X-Received: by 2002:a05:6102:5805:b0:738:be73:55e0 with SMTP id
 ada2fe7eead31-73a366f6f09mr2355953137.12.1782856955681; 
 Tue, 30 Jun 2026 15:02:35 -0700 (PDT)
X-Received: by 2002:a05:6102:5805:b0:738:be73:55e0 with SMTP id
 ada2fe7eead31-73a366f6f09mr2355905137.12.1782856955182; 
 Tue, 30 Jun 2026 15:02:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4d2bc5sm25355745e9.5.2026.06.30.15.02.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:02:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 12/33] gdbstub: Make default replay_mode value explicit in
 stubs
Date: Wed,  1 Jul 2026 00:00:39 +0200
Message-ID: <20260630220100.1289-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9pOyqXTVNvP4WVF7IeUsSCPaDAEV0NnA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX0krJBgOGiK/F
 S98jlQgoYs9eVGJE5oUhszUrcMYPBrczNvvkjTO9VzaeFdgHTuYOExFJ4wM19CrTZpahGB/xw0s
 r6RAVg8gyMWA/dofiXj/U0kudVLiQyw=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a443cfc cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=K_Z9TnmIjj84_yaIjkMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: 9pOyqXTVNvP4WVF7IeUsSCPaDAEV0NnA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX6Cg5LAUPlrzi
 rYgG5Jtpq0pKd9u8NDj7NtgjRaX6lsSgfkEUgjj1KaVyXGEsXqzA3vs3a9cIrHfp89qEYXr7E1n
 vwXF4JZzEJntdA5EB0z5Y5aAvKHU1XzfgsCSMbEXELEE7rhMeQKQh8+E92WTlvbmvnf8XsZvJyH
 X467s1d9ovZPRaVSfOD87+UEqXH4XKTT+KK1IqPAYoJbkfOzAf+hwjwbqJeVD19vfmZv6gv1BGX
 pLTEWp995TJmSKsXRp9Ka4M5J9UdOgilVk9vD84nrJlncQdMw4G4+zbKpLUAfFMgZcXaOy4e3F5
 jumPeicmxmwsraePZFjFHQX7UdCS8lNiGThTGqU/4CfasjRWmr09n6N8VnIWG+e1vmdPdds2OVi
 cuNPzVUiWSoBwBfNLp1WWyFxTpzVQ9xLWqOjYVovP00XwTZIHp3UU8Q6YeU3Oluqb02sgSW2kce
 tY6JeB5ECCALFy+qcoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300214
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Make explicit @replay_mode is stubbed as REPLAY_MODE_NONE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


