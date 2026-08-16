Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BF4C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcDQ-0007T9-Mf; Sun, 16 Aug 2026 10:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcDO-0007EX-GF
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:51:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcDM-0001ux-NH
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:51:58 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlFg03161996
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GVQp0WhfFXU+ygcEhNe5GMz+qhcmsuVKmHyMJwd4KbQ=; b=mikLTeMaYJP7/fZY
 +qKRmHMY+iVyq0nLjRsnzLWoXOS2IeFCbNHMVL/IDHOauI4tvhM/WShLsabTmEDg
 l/YwyDiXVSb1+7BqT/+V9wbAIQBb6Oz/wnct4RuC/v5CICefyBPrPpQ9YgSEAfff
 9WnpSUU6ipWQ1IGq4C07Oe1ik4KOg9kX2gLpwrGqx9A7o7oXqTM+CiHUEgqMtWDb
 juhrqfbyZIShNuRE9tvomCHnyeXKAAmegMi8j05ZYy5v+oItgioecVcP3KUx8ajd
 7Xvi68kzgBDXPgzEsspqHSXaMn0nRbi46JbopPzgV0qL/5EMH3wry7AG98ncWn9A
 RBCZhw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2hd7uga6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:51:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso29900541cf.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891914; x=1787496714; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GVQp0WhfFXU+ygcEhNe5GMz+qhcmsuVKmHyMJwd4KbQ=;
 b=d8o1eNOLIAhJ6OdXJWAsyvOTTrC/B/FXl60kSiG9gDr8gPENk3U6zMGczJs+ZA+j1l
 kxFJw9DF5b1y5WUzsjBCz7h7IXiq2rZz0FLgrnFoKhBl6TjSjmId5yZUqxmiEqbhOYBg
 XE4l9IKxxrw9U0IJj7pgXM6Q//llCSX7Q4UrLNKyLbT5Yv/RhvI76DCiwb0YJn5HxWMr
 HC59NIdfC1yIH4+SOSHEPMqQMJHT/FjVo7mrE7PaIavAYt9LAiaxAoSL8CfCz8lW4Vlt
 5mlUZrtRZ8QM6NpLZV60qvOdP0lIR1PUAK/SIdBDJ7p4axjRq8gChFa0ZJRLScwLtOYT
 jnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891914; x=1787496714;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GVQp0WhfFXU+ygcEhNe5GMz+qhcmsuVKmHyMJwd4KbQ=;
 b=CLqLGIPY25UXFDvY5xMTbJPGPxm4nQBP2UC4n2Bkfaen8CI+pNo/LtOjfUqS9blwGz
 yMoTzL8yE1l7PfR1WlFyBzQVO71sBiOedrNyzFghWrwa56Lj8offDxfPakYgUs2nhg3m
 CUxd4ikuBi7ViUJArGa5aVf2pouFqpf0f31+0Izz+zSXcuyQCMwdecKFeHnrspA/qVRZ
 LT+KR3Yyvn+bsUxpOfTPR+XCUufxWfOBbFQySRVCJFxX0y6GI33nCfFsHdjg4Gt2C1eE
 EoLg8UoxelyO9SkmUyo/KP4AVxXNGzqNtKqhxRhAYwyc4JLr+HcfW9XMnhXkYsQTc5iZ
 ABtQ==
X-Gm-Message-State: AOJu0YweHob0osp/gJ2d0NXzh2HfCRwCI8g+57MH5yaUqbJjjfcMflw1
 t8ILGMwzxpfSQjQfmnVCtLOEtfS00BgdiTYCSXVj/RFUB7MEJV6DTqu1lW/GVpD5VIHxDuT7oBy
 DsUK2b5kFXCIq7lc87cyg4WoW+LdTh+np+eiDWplf/4GJkgGLx421r1wnHYOEhTjmfg==
X-Gm-Gg: AR+sD10pHvGeO0Pfli3rL1TYAJ1exaF5yON5KQZunn7oTNXeMGpNyTg/RkTFqGnHuRi
 diSWIFy3RoFgnzZYLgKPsIifjVnH9P6v5ctSt7dhNV/JyC/gyNKzZe1BRKYDOznzF7gOmLX6I7i
 xvTsDpO5t6ns7mf/Y46/nFrfUvyqw3/qDFNOZdlw3ihFDa9pf3NTT2kxwOo5p9FnCgRpjv1Yn/e
 GXkKoO60HOX6K7DQl181V2235mggqElXBEbSKmQfJqMKGVjCfa/+mLWXIQTUoiICIVZ3Fxj9U6D
 BOOIwY25KH/gjN2S7eiCABAEMXlnZYQyr27XUYTHMD7ncAsNVkd5QX3VKy8Vq8b8fXP1TbR2UX1
 TzHXGNjKGgAPvLgVKAnl7WhJyKuJLlJE5MDMkuAsx1A==
X-Received: by 2002:a05:622a:4d43:b0:528:17d9:2d99 with SMTP id
 d75a77b69052e-52d85529386mr249299301cf.43.1786891914159; 
 Sun, 16 Aug 2026 07:51:54 -0700 (PDT)
X-Received: by 2002:a05:622a:4d43:b0:528:17d9:2d99 with SMTP id
 d75a77b69052e-52d85529386mr249298951cf.43.1786891913753; 
 Sun, 16 Aug 2026 07:51:53 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996176b95sm41106215e9.10.2026.08.16.07.51.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:51:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 41/56] migration/hmp-cmds: Include 'block/block-global-state.h'
 header
Date: Sun, 16 Aug 2026 16:45:40 +0200
Message-ID: <20260816144556.69009-42-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXwFB/eK3qOP5Q
 U3DRtCkd+nvyc0okWw/Cj79SfxG2WvQe7qkGSvsYZGWAvwIiNtMH89d0CvCAFpJP4gjHMKLkSf8
 oRTxqwxsgXuoFN0JVl42/HnY0ODERYtNMeK/RozF2w/QDFHb8ilL3LJmgRHqXtAgyUNLpJES+FZ
 1bC0JjfQdEG1Xxq8nQaiFGAbj8J4y+zj5qawKMmhvX6IbLpy0ARHbzTkUOPE15MKWd8yjrJowHP
 5K3zR7RYr8AUSwk9hlP40x3yeD2kXdo1VE1GoJ5EgYcv8uBbK7HODBjT6jRONijnU/1qvFLD+i4
 km5UjyXQtW+vRJcfZ3xUftyaNm+KUgf17tmcQGxS8WXKhW1zWjmtwNlPS6ldXNqJWgPOLYuterQ
 CRIwMr0OFyVOklZwUVbw655ttdawN+5VwRtv6S19RaelKKWtmK9gvmyay/44VBXrC06VHnLKPz/
 tnsyCEr1RxkrdjlNNDA==
X-Proofpoint-GUID: 8juRw-wcg413ElrihQJDPBAXAEuXVNyG
X-Authority-Analysis: v=2.4 cv=Ja2Ma0KV c=1 sm=1 tr=0 ts=6a81ce8b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=3WJfbomfAAAA:8 a=tlxghdvPRZsVr19qFskA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-ORIG-GUID: 8juRw-wcg413ElrihQJDPBAXAEuXVNyG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXx6rlSN3Hag9M
 yvjbNTRIapNHiB119cwKNUjKebGtEx48KP7Kb7CLwWvPxMrvwlAg4AOWxCUPKiAbKvjE6b+YNkz
 rHwA//UaLbBLMWffjBIbpyeomRv7iFQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

migration-hmp-cmds.c uses types / methods declared in
"block/block-global-state.h".  Include the latter otherwise
we get when refactoring unrelated headers:

  ../migration/migration-hmp-cmds.c:911:5: error: use of undeclared identifier 'BdrvNextIterator'
    911 |     BdrvNextIterator it;
        |     ^
  ../migration/migration-hmp-cmds.c:918:15: error: call to undeclared function 'bdrv_first'
    918 |     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
        |               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-Id: <20260812211708.92824-7-philmd@oss.qualcomm.com>
---
 migration/migration-hmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index b5eb27467cd..ad68fa23aa4 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "block/qapi.h"
+#include "block/block-global-state.h"
 #include "migration/snapshot.h"
 #include "monitor/hmp.h"
 #include "monitor/hmp-completion.h"
-- 
2.53.0


