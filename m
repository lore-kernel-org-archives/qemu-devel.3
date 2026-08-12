Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F0DC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGL0-0007Mn-2B; Wed, 12 Aug 2026 17:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGKu-00076A-9v
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGKr-0007mK-1W
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:07 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2clK301219
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FfDt809OwGUecLKGIu73SG0kKCLQ3D0RaHEA1CNLFys=; b=EWWBRVqLH3oV6nTf
 5163OhuLZfcrQF5pyoWIab4ulfbHi/N8Xazq7WLRiz4Kac9FigGn3f2fAU2YbNGI
 zNNi4sM4AoXnzMZBnMOjSav+tY1KuHBz4Iv7rx6wZPzmd9rOhwz1Mfn8oVBrNT+J
 zlTJPtWMuLqSnI5fRS3tPepZIaw1HaRAoTzTOFelBYUu0vWfSlPMySxEMUr1iaHE
 YBXhpqXPc60DmR9O7GdgJ7ntIUyK/SO5pfY446dgpXeI82CGqy0+0+cT02AqMif2
 CE6Vyf7b8NXFPZ+yOkseV8GUI/M8CD7uJKiFZ26Zu8vsRMiKhUg8Md7XK184+5Bu
 8NeZmg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0pmytx8m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:17:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso23929521cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569478; x=1787174278; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FfDt809OwGUecLKGIu73SG0kKCLQ3D0RaHEA1CNLFys=;
 b=LAUzJJvAwQUcymMohPye9G7yWck5lnqo0+L3fxzwSHz5IRNXcaPvKYE5Q8fR2BTXG3
 PGL6DmxT0lZak1I9Tb/rJdXuSH8ZDjadT3rf2tzo4SHmDRroWZjCD9lIRd+q4xgiVuDf
 +/hnUdMu0i2S5fFwNfSO8DxKTjh/4oju1Hpbp2eqD84R049jwMcSnAGxWFc6q6wN6tdR
 9yF+GeMabSXnufgaYS5cWhVHCInTKXrB6oe5WkM3UdgkKF3hWXHHYxbRf3nBhOzMNn0a
 QQsG/vCl2dSOhyc5AT2nybI5TFYJYlw131hsu6Qo8mAZntD9DJVZa9NQwGSdb8lUt22C
 NUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569478; x=1787174278;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FfDt809OwGUecLKGIu73SG0kKCLQ3D0RaHEA1CNLFys=;
 b=G1NxvNtTwXssBQxlQB35FQwGzZFWkdmvDpBHelJHdpNV95FJAQ9EdarHz7xOeeDHvB
 as+2cBkkBkI3MlBgK9dpmeWvx0iQguiuinpaoGEyJML/ibmKIRDAkmAsJDLyZg+laj2v
 SM16ChejNcRu+S85uiAPqm8kbsGwrW0t7BAKE5snk9+Z1HqkspWGH/TfZ6AqXePRu9KK
 woB5zlaML6pGsQ8AR8BsiP8xRB+Oec0UeyO0F5Btf8WFuYuZjA6kB4g+JDI4ETCXbU5v
 FQnjFPA5AzWUrfLFMnu9xB+oWX2yPzMkdzd4rUjMpLiKZIRDOlPQWWSmXRRw/pCo1sEl
 FQ0Q==
X-Gm-Message-State: AOJu0Yx9Cdsr011pbWwjvke0JhcHNENCGBWNDt0EfQuSXDaDJ5/rppS5
 KAfP98FqSgQTjYKmg37S1S5V/p1XTmALL1NsFBGuVNz2I7HjED6DHMVJeMyACAO2Ffhqgh+uFRJ
 u7ikYjC7H+maL9FNkQ+L0aMvDVZ2Dgq3aLrLhEFcjweb46ZSY7PjBEIPYTptETUM8vg==
X-Gm-Gg: AR+sD11lMgs0ddaCDKeUJRbpcQLokvODJLk9fw/cla52IRZw4iTJJxmdLsvx8Q75t9r
 MwPWgbN8+sFZjoYoyK0M47FPG8XVMEcYz4TU3kzECdxP3wnrKL/Sq1Cqx5pukJHSVicp1CYF9Cr
 1UfRCUxAKHNMuaVOqcCo2jaOE65kIEeiKFgAXzvISZb22IZJOqKfyUW3eFxwvDa4E3SSFK0azcu
 DSnKD9Lkdx8wcHy/J1J/vM7+HrXwkJJZ3DbEKaNDOi7kqFft8sc3LdqG+h46EYqxIDsk2e8mYGh
 FrjUnwBDsWRd+cLr+x0EnhyqQSyG+XtTa61itSGyBz0mf3Hj6ncAIZx4DyluasKF3pNh1gXDFYL
 pXFV0L04HlRgeaO6AxmWzEeW4mDssb8CdyIXM+MckTg==
X-Received: by 2002:ac8:5805:0:b0:51c:ace:de6a with SMTP id
 d75a77b69052e-52d73c724c3mr12153391cf.18.1786569477981; 
 Wed, 12 Aug 2026 14:17:57 -0700 (PDT)
X-Received: by 2002:ac8:5805:0:b0:51c:ace:de6a with SMTP id
 d75a77b69052e-52d73c724c3mr12152731cf.18.1786569477445; 
 Wed, 12 Aug 2026 14:17:57 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981d85953sm8762185e9.0.2026.08.12.14.17.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:17:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 06/23] migration/hmp-cmds: Include
 'block/block-global-state.h' header
Date: Wed, 12 Aug 2026 23:16:50 +0200
Message-ID: <20260812211708.92824-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfXyeqgYe8OytDT
 sa3RHNzXE+JnM/rCeupnTkwLkinA2zYXQdieIgdLz8sANNUZW/S7XFVOSgVeqef9Ozl04UxbdTc
 1JDnAL8ZvTM37oYpGOSY7tkPJGhbWKA=
X-Proofpoint-ORIG-GUID: iC1ac-2Ol-FQm_bXVuoER2oaL3d0dXct
X-Authority-Analysis: v=2.4 cv=C/fZDwP+ c=1 sm=1 tr=0 ts=6a7ce306 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: iC1ac-2Ol-FQm_bXVuoER2oaL3d0dXct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX9Y5YmKDeaZGX
 5szQYEQ60gQxHbu53iEBLNU4S76cEwP0uRb5qV8s6HXVuR/Zxlkf8+kV+rEdslQpwyGBG8/QKI1
 4ZNfsURjwUnirV8/YGydrxcwhCa8y9rqkkxwd5BLb3GA3ZNvihF1Wnt/Wca3yOakZ41N8fJbRjt
 MM8b5OKZHi9Au51DNTu3Q6N6vyVEB5YneHQqSNL80vKgjXSIP82WCPQXfuNN7P3uZBKoaudw3/Q
 PyRDtjMFG+nxnRy4dsTNI2rX3x1JB0yby4pSZvPFFcRGL4uw3PzYYtz002KtxSqO2tjSEa3nr8e
 XhF8v0GubdO13VK9pTY25yXpD0hxdYmwD8YkELE83OgOX6hVjVX0+dp9Bh19g9wqM01Dh3TtsqW
 loZGd01iPLtiZPnHBZjUQB51kLQUAZ0F22gfp5uWYoKsysgJk6BgT82qkI2ku2hf0Tli9wxGbyd
 9w71tlCjygaLjKuzmPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
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
---
 migration/migration-hmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index b04fc4489f4..351512942af 100644
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


