Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE05BC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5do-00033M-C8; Tue, 07 Jul 2026 09:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5cu-0002Jw-Pt
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5cs-0000Wm-Qe
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:16 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8ego3606093
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7CJzoPzk74/pvrilYYplLMhXNiWOBcfod8Al1ERLNeA=; b=GfsfvP5usi9L/sW+
 MYwDD3K9ne0tVCLtpAQhyq33dSfeRIkGl2dtilxdNpxw67M/mKrXzes0Sts27Wa3
 0+bu5GsbqvBgxJA+yOyaI1/FxB2OTdBGrpzX1mAu3AFSaWHGaP48QTjGHJ7nF6yi
 Lxg0SlRC4c7rYJfuoYZsr2mZPJvABUossghdVVCVXb7ExB00Kurpjki70wadFsyu
 GgRxlZ5LUozTrDR4ezr0NGQmcE4xIyvcQis5gO8vHX0x6MrZZp4NnLVrI0lJmXTb
 YiO1YhfrOVO7kHkXUspWsmtDXII7fh1UEx9st2PIJiYPvUAnGxI6m/FvogbSJye2
 W0+ydA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8j4hd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:14:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d137a68so98709131cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430052; x=1784034852; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7CJzoPzk74/pvrilYYplLMhXNiWOBcfod8Al1ERLNeA=;
 b=ATYz9g9rzq/UUcfYQ2jiGUxDz6PJj1Jz3E5S5Ay1l6O0habDhckz/SYg5YJTgGXeFf
 iH5s11atSsRvqHTsYbybOUw42CBk8WWpXyHprO+cWcAgQAASKB/UgIGbdkTzn5Qx1vZZ
 mbQyb7sHtE8D+EJZHZdwYrjRE+eFIAaSpLVnDMKA9zdIwFPPQ2eXnURhHnwDNsXs6oIL
 es5H1CZ/zvPQaP0mu8X92yvpz+tW/MBViKvVKbFYKKSoi5xNamXHVhIs0g8R9fJttz4F
 sABqtvrOI23dhYFfs7dw6pR+bhQhUlVN+n36UT1CuzzZDsq8xug38fkO1NVAuckJJ8i7
 ycPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430052; x=1784034852;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7CJzoPzk74/pvrilYYplLMhXNiWOBcfod8Al1ERLNeA=;
 b=kOYKQqC3Tq0lPkZfkRe/nbd7ugClhG94Xo+Pb4fftpV92apFx0PbeN2ldOowlaXkf4
 YPMePukqWPCID8TFnjlPl8sotMhbvRPWuST/Sq2K/1LpGw0/uhtpD6XnkiSULU9tCyTX
 HNc2v6PtEla0hMUTfk+cNELfOsF+G+P7J7uo9r8NEAzPjBVlhWliHC2E79dvVt33NuEH
 t53blQ70VGd7T1a25rBcQO9WU4HvCSkt0LT2vtMcmJlC0os1KKX+nkvL9anBQSYVcCxb
 51gcTeUGqRCVEY/NsgAxVOCPbV5G+/WmcBL/9wBWqDVoEEnEqnmjj7yk7YdVk3wsgtHd
 apew==
X-Gm-Message-State: AOJu0YwnSIYHwCAWlVYIk+jd+jshlbI4f2tvjxUkOUsPs4GhIdU1PLuR
 yxEPg3cjdBcOHsDfg7AqhA6JrxIMoxAI6s0+CjEfWIYLn4xcK3Wysn1tTbBTVv3Am+oLw/0N+CM
 Q4d71fRapQ4k9XHiPs3o0BqXq1hku1BRp+39bfzfj6+8CbCEHRhH5daaiHO4BTahIQw==
X-Gm-Gg: AfdE7cmFx/Pwy+pAND6r0bHm2yDMKjhusfuN6v0sQEw+33X2D0Kcyls1VjZGW3mIslt
 i/ERKmWGxjpZU26SI094NR392foDHOcLh6ngATdW1uFNLNs1Spku9945oxCt5EcFFBZi6ZHgx2G
 rBsJWzQVWXC1TgzfcHz4WaFUNhJ5NKcXAVnfSxT1lL01fiSimmCEbIh5TMwpaS6JaZhdjmUB/ib
 dGlTedMTsMtISOxGWd7XQkiIYXCAon3MFUYkK0yt5DIQ9iVjkDPO4rE17uA17q+uv2/wikblFe9
 +jyNWqZpVrVVqVinT4RhrVAZXP5i9J3ZiV7CHoCfjhJ4gXr6AOcsTGEPtXIqTBR1PWROleOQ+YG
 Oi6srMyt6MefQ3rF9RYAoD/aFkaOMuvKKEgpHLJJ4NSXQs+BhexCnD86bY66h5rVCkvp5
X-Received: by 2002:ac8:5810:0:b0:517:57f5:e21a with SMTP id
 d75a77b69052e-51c7487d524mr53329921cf.41.1783430052212; 
 Tue, 07 Jul 2026 06:14:12 -0700 (PDT)
X-Received: by 2002:ac8:5810:0:b0:517:57f5:e21a with SMTP id
 d75a77b69052e-51c7487d524mr53329451cf.41.1783430051594; 
 Tue, 07 Jul 2026 06:14:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ada091e6sm136212766b.51.2026.07.07.06.14.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:14:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/32] utils/module: fix memleak in module_load()
Date: Tue,  7 Jul 2026 15:12:05 +0200
Message-ID: <20260707131223.51505-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX0rRSy4rVWbID
 U6OjooZFU+rkNxTZRZGamffQT0plnXeQjZnrPG7CiXTlV3DwiLv5LM3w9zw3Upuv01z3H/gV4lp
 kgdBUE7deI7ehCbOyplo12bIIAzCMl3OTScrJCaMl+ruYVVaDFkbhLA0NgiP+MsJfgYcv7V8T4a
 JNwqWKRrbPvEdtngtivO7XNFrV5mV9+yu9bUiCrxI7+EjLRpvEeZu8BRc14HKWvWV1+KWjQeg/h
 4BwDzobDwEvI9SwQu+acndyvw3XWGfHaPnl/mKFJSjjZdGrdqmWOa4XuOmbJYqtbPZ7aoUS+v0/
 aSr7Z8NIMFBvuZ6fI7W6xZLIeZLozTWCVC1BV/DEIk+f8Bm8S96wCSiUbiiVw4OlX9TB9t6zVow
 /db157MlrNCQEdDHlQjn7a0Fu7sZ61/BQv4sjoDYsKS+aoMN9qqpemAosDTsiqzHC6rn7B9LOpj
 iSdjRl92cEVxEG75ozw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX5qrbs0lVPsod
 Pszv99KqHq0uNP6M5SZkA3JLVYqwvQumX7qv0qt50LFf5IKEUtMmkyXAubKLlhZnlTqopTmNjQy
 HdBUpK9ubmwpyNZW8LZZ4fWPm3J5FRo=
X-Proofpoint-GUID: xdVsvubajjwmohnU9TPzTD1oAo-0FSYn
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4cfba5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EWWzKEDAAAAA:8 a=HH5vDtPzAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=-5jC-c37tY_-YBIg6F4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22 a=8ZwbcxVZO41N_bDMix7v:22
 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-ORIG-GUID: xdVsvubajjwmohnU9TPzTD1oAo-0FSYn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070129
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

From: Dmitry Frolov <frolov@swemel.ru>

Memory for version_dir, allocated by g_strdup, is not freed

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260630110601.736019-1-frolov@swemel.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 util/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/module.c b/util/module.c
index 09dc43f51eb..8f8e6994f11 100644
--- a/util/module.c
+++ b/util/module.c
@@ -203,7 +203,7 @@ int module_load(const char *prefix, const char *name, Error **errp)
 {
     int rv = -1;
 #ifdef CONFIG_MODULE_UPGRADES
-    char *version_dir;
+    g_autofree char *version_dir = NULL;
 #endif
     const char *search_dir;
     char *dirs[5];
-- 
2.53.0


