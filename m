Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5824C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtokZ-0003ab-1F; Tue, 11 Aug 2026 11:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtokW-0003Yy-OZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:50:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtojY-0001tf-FZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:50:42 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDWXmT1914347
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yK3vNt1t/PS+GzsEVTsPCWTVujnrwF/VrOO9PtMQReQ=; b=VZeWk0cpZimDgZ9C
 Bdd88hxXu5zFiGDum2X6kYjpQgIdmm4TFSe6sJvNdi1lNO2YXZR5r2KjR16BxGzd
 eHFOXqoiG5l3Y2JiKS/o+jTvFNBw5JUyYrCWDi6Fzpi2MEzvOVDnM47qj50aPHdr
 vSpQ4ga5HyfVwg04BnAbqgMKGkSQe5wgtY6rnTc5olyjX8etRS/IbKR0J8FYaFzZ
 aLQXYoqtorOjED9PG9oMZB+wFeZpYR8GnRCtz3uAYERoyizACatEvoo6pcytueFC
 H8XrRirK0QM+VN/2w/E1uFmRtXwSKVvyYqTdKU+RVEOvQQC8yN7hemyABikmv+pz
 LJ5jPA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049brryk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:49:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso1117451cf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786463382; x=1787068182; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yK3vNt1t/PS+GzsEVTsPCWTVujnrwF/VrOO9PtMQReQ=;
 b=W0vkM7oRQKSR05bDReqX2ESIfkAX4rEidNfCi0OStq7wQEWY+9q0SDJ/K3SCWT/558
 Yww+h/lJ3Pmi/1TNMu6zbD7jHAtLcMGDRZVKu1QcJPhU68yCHyEsBGNsFBtJzhuH7XOt
 O9PP1R2QVJUJYdt1KxY0NSyGLwjCPjBWNmCTj9u8z+odRlWswjWnhZS/OdPsZsGU21bL
 8Ua1iPs5XkEhhhc8iOOJJYZYXGNfvcGhMVELzeN7EVlKrHutw4rb+g+e0HA6IKEVgmT1
 sF35MYi9KI6Jd0zw2gDkTMkOFqHosBOe5TkeyPiO+Vj7UT3c/wUr+CWg4jhdeCDIglaH
 nTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463382; x=1787068182;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yK3vNt1t/PS+GzsEVTsPCWTVujnrwF/VrOO9PtMQReQ=;
 b=cAbRMnUV87qauZUEJi+YyP9nftKGX+v8WFlTCF9VATncqUOHmEqHDdSCdOdowDaoCO
 lSiQeHLBeEbeAV+aiU7JT21g74/sGgQFXtqzji8r+5ZISETPOgbg58tWdcW2bG1IBvmP
 2wz3PzX5+jsw2RY2aoTMijF3VFYUtdOK33VvwAPgXq419HmXBqb29dgP39/Lo7VSmMS0
 hQEIfKUHOp5jpdIEDet3qTW0afz5GyQmMnTXOa8wLg3RWfSqkb2xZRHNKr1VB+uyogNi
 LkL/1YPMhyPfZPmZNGbiIykw9ocs8BXj3dC16u50yJZvLar63ZGaYIExNo79LfiBdD8I
 YiNQ==
X-Gm-Message-State: AOJu0YxHI+HRhWmBnzMw7ZnySyR9Cm27fPSHM0qQAKCrecbSoUE1Pf5k
 rIUo5JF1qkiUmj6/Fr4oAIBStSyNivsEpMhZGTb+VfLPHxiggWPADGjT1KeffaX+T62YA7nvu6b
 8ypp/XoeVkfBiLY6UeNHBnEZ5R2dYvu0a9BQj/4h5MGp0OxenOsPFdj/bNkmrPW2UpA==
X-Gm-Gg: AR+sD10zyGh9k7S1JiaBY8JhiDBjr0NyQdUPu7uXKBA+0IIpko06annh8uMFCjCGO2I
 1navck9+3/f4fEtCqWYWt4g6gk5WVC5MntiX7diFsM2OLt3HZAlNS2E5isKEDd4SO7cyBX/+vxq
 mbE9XRa2OSNtHHhdER6Lp2mJo5zreK7e0WIAcItgRK6h4IZWJ48AK221Kw9nVenY6SNALpC9DE2
 1wKWj8eowT1LYZzUjlQ1vUq0UnqgQpo7PZXRNZz/i8Ksn4XV1dS56iBi/ix6zkDt9piSOjcje6K
 bQAzXHYjBLbnTPLbors9Hp1WZa0Fy7JOtWq8Y1s4gESEsv9soRiEbxZJiu0dDLj8AiuCQ8fG2ps
 o7u7LnC0a8ilfXRpMX4SGk84ssRD8ABtUN6vaCiyATA==
X-Received: by 2002:ac8:5887:0:b0:51b:ef2c:7bf0 with SMTP id
 d75a77b69052e-52d5860de3emr39039251cf.35.1786463381750; 
 Tue, 11 Aug 2026 08:49:41 -0700 (PDT)
X-Received: by 2002:ac8:5887:0:b0:51b:ef2c:7bf0 with SMTP id
 d75a77b69052e-52d5860de3emr39038711cf.35.1786463381344; 
 Tue, 11 Aug 2026 08:49:41 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997abebacfsm948305e9.10.2026.08.11.08.49.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 08:49:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 1/7] hw/nmi: Use object_child_foreach_recursive() in
 nmi_children()
Date: Tue, 11 Aug 2026 17:49:24 +0200
Message-ID: <20260811154930.13915-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811154930.13915-1-philmd@oss.qualcomm.com>
References: <20260811154930.13915-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o_OEJUJ6NGTzggeBJyT7_2G9ptb4L8ld
X-Authority-Analysis: v=2.4 cv=ENg2FVZC c=1 sm=1 tr=0 ts=6a7b4496 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=jmNSRpmTyL3U9imlh2kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: o_OEJUJ6NGTzggeBJyT7_2G9ptb4L8ld
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfXxJ1yIXwQmEey
 iemdC72DyMI27xQ4WTIK7UhkrYJkG3KYTlJhSDaYBBmhogxPlbpdgOa4E6rGOOI0THolxqFkHUv
 Ne/AbYJA58wJclkejMPVaoqn3fa6nxukfWdCVkpQMz0eioD7zW4pem/9vN30gjITNBHThjCkaOC
 dPfcXRea/6sN6f+PX3vHAVz8G9Dnrb6Ykv1oJXNkGmR4lNXUWVS32eJ6sCeJ60PI//5/zbEhoKf
 K/oOXxHKJCKtD2TgX52JHdc3FHD/TOOXfqA4m30+QB0OLGu/4Tl0bqvEu6DJJYhZz870hNwhGCG
 yCQJhgXElVTHXVLu+i5ISyXaOdLEzmxX6CfSigKyEO+7kIY9kUZwPNq3RDBtl4dQh059s61Cj7m
 k0FVxVB3f0tDZoFBIUMWp13phhYoH9Xuskh144xvZYuwWeIR7qmNcK8D401GxG/9V0x9UmneMma
 40oOkwVNqkN/mYlvC7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfX97Bz83mq7mbN
 umMrwYzHoj6K5PGMlkRMij5hdV55Q/vy2W1gHFKNZfEASEtBgUL+RIZZKjuNu/dQP2lfmCqSu+R
 BNamWrDRQua5sp/4aGWV0NTvVNSPGiE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110132
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Replace object_child_foreach() and recursion by a single
object_child_foreach_recursive() call.
Propagate the returned value so callers can check it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/nmi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index 4b447e126ba..22724046575 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -31,8 +31,6 @@ struct do_nmi_s {
     bool handled;
 };
 
-static void nmi_children(Object *o, struct do_nmi_s *ns);
-
 static int do_nmi(Object *o, void *opaque)
 {
     struct do_nmi_s *ns = opaque;
@@ -47,14 +45,13 @@ static int do_nmi(Object *o, void *opaque)
             return -1;
         }
     }
-    nmi_children(o, ns);
 
     return 0;
 }
 
-static void nmi_children(Object *o, struct do_nmi_s *ns)
+static int nmi_children(Object *o, struct do_nmi_s *ns)
 {
-    object_child_foreach(o, do_nmi, ns);
+    return object_child_foreach_recursive(o, do_nmi, ns);
 }
 
 void nmi_monitor_handle(int cpu_index, Error **errp)
@@ -65,10 +62,9 @@ void nmi_monitor_handle(int cpu_index, Error **errp)
         .handled = false
     };
 
-    nmi_children(object_get_root(), &ns);
-    if (ns.handled) {
+    if (nmi_children(object_get_root(), &ns)) {
         error_propagate(errp, ns.err);
-    } else {
+    } else if (!ns.handled) {
         error_setg(errp, "machine does not provide NMIs");
     }
 }
-- 
2.53.0


