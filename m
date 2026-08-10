Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1D6C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtXgn-0003vV-3X; Mon, 10 Aug 2026 17:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXgl-0003ud-HK
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:37:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXgj-00082J-Vv
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:37:43 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALXCXN2772929
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EkHAG1isir9zwagZcGqjNbfgPjAbo4jbzh7Lag2tGpI=; b=AVOicCP76ZIHvGHF
 0SD1EXMFat1X0j4K7CXMTgVF6Ui6venThmsnGSACJLB2ZGDvn5XKJjZO9f/wJIOT
 Img8D/fpLKX6I1FLS+bxIPfbmr15EOoRg382JeIVYNmwm2q5Atq73k/OGxO014XK
 JbqW7vRW7V6Isp1KL8AJ/x1/Rc1xhSjjl0S516CFM8+Qiur0MAHRnEEc2n+5dYL9
 wYsMRlHBRYdm0jxmnfLLMZXKni7qiMzUZCmFnpdy2EHVNEzf4m4xpF7uyY0YA8Zo
 iZLIR3i7Vq0020JCyH+aBFn5yILsIPHeon1E3rBNQvYjRqt6WObfBO7uhNhhpAEQ
 RUHq5Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjv145x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:37:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so43697461cf.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786397860; x=1787002660; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EkHAG1isir9zwagZcGqjNbfgPjAbo4jbzh7Lag2tGpI=;
 b=RB6npKLHilnl1CsjhAR4kK0LWc4NbKwj3l9gpqdpgJlx6L9Lsb6CihnqQVd7OVmCVp
 cDMmycFxg3xa+SRnAIDr38zMgEG/U3yueWw06AGI7EYwIH/HOgvpA4gpayqz0yyZ1MM6
 BMb+I37bqXxIzMvSZYi+7QyPc5bp6K1Uaa5SfnDO4vo7ZU7N5OpDLTRRz89p6xlZGJS2
 go9DFUzhuoznS2sucWmrF89t61GZE6avuv0gGJ31HJ+vPziYMlCh+BSSvinhP9Nqr8I5
 eSo+hCQ3X9FkpwJ/rKaJ1uUHoT5ZJtXvrh3N1WccxHVHpDqbT5JRI3o2xrgfQUSHBE7s
 tLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786397860; x=1787002660;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EkHAG1isir9zwagZcGqjNbfgPjAbo4jbzh7Lag2tGpI=;
 b=GxhCSnnuxiE3RcZwN4POr4NipksvLa2KEJHJGIeUApWhad4BThgdHznd47txVOjLn4
 iMEEW0BFAP9Ccfc/CVBip01ZqM9qAhqUGtaUXZiLL0Bx+qcTEgl/6mv2NKtE2SN2OsGQ
 Mg8zJw2SWknpxC8SVItHfusykAawCDiSY6FIiHpZxPkxNM8Ce99Tw835wu9L//19n6aX
 Sc1sYRq+P7vhQnBdB4dwADCHK6m7UJV6ytJ10uA6M5+R32gYhgjHaDS1LAWh5/K2g1ax
 bkT14tiBKBdqfaLRcKGwPLku0b1RCU10ZkM8PEdWWBE+C2S/3WIAhGQB95R635y7Zbbs
 39/Q==
X-Gm-Message-State: AOJu0YzJTmHpCIbzsBgWTmADA92EZnvZmDeKukhQZDml3M6Le4ko4vob
 oS+OQujrrEUKzFoTdgbAAswW9YSjWil8cupKW3E0TPQyAyLXSA9aZaIB5QmZEFwHdxV/daknuKu
 24zwy79RVmtkG3pC9O4qBoghDszgkO3ZDyQGe/+1Gsq8OXYk6tz/OX6B01DO8l7DNjA==
X-Gm-Gg: AR+sD13ZJoyX0I3jGZ8BgGCswator4RkfTyw2B9sQIJjYvGUFTBulNREjcajowB5wKK
 XtQM811y+cuzke6O0JtxOxdhzaH9oLd3leV8CglYGH1moA67ZbOYjsexW2d8tlzDGdDERM0E33X
 r8xjLxxzBaQoqGGzDlLysvgsfZ2W4mqPpneXG8Jjmk7OPB8Iiae8FsZBmJJWDo7hDNHOBv4U51U
 8duMi+odmq8Yw/vDmWYreoDIIxwOPgxvcQnk5L9W4Feu3Z6wxbUuH7qlJ+w7Gaw/lnQeSF0hWiB
 SnUK/u5VIbUSeCmIYJPnxlNtXIZGvEWlAAsR8Gy3+Fu6bC+56hqzZ/NsSFOnqG7vVJkvSUqAJLu
 8pD71tij/0rIvg8/b+IqRwGVk/NlQ+w2Bi+GBbrQzgO4ymzA=
X-Received: by 2002:ac8:7d0f:0:b0:51e:47a4:4851 with SMTP id
 d75a77b69052e-52d0b003eafmr329799771cf.8.1786397860493; 
 Mon, 10 Aug 2026 14:37:40 -0700 (PDT)
X-Received: by 2002:ac8:7d0f:0:b0:51e:47a4:4851 with SMTP id
 d75a77b69052e-52d0b003eafmr329799401cf.8.1786397860108; 
 Mon, 10 Aug 2026 14:37:40 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997415e45dsm19021665e9.14.2026.08.10.14.37.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Aug 2026 14:37:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <minyard@acm.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org
Subject: [PATCH 2/4] hw/nmi: Introduce nmi_cpu_handler() for vcpu-specific
 delivery
Date: Mon, 10 Aug 2026 23:37:20 +0200
Message-ID: <20260810213723.58467-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810213723.58467-1-philmd@oss.qualcomm.com>
References: <20260810213723.58467-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4MiBTYWx0ZWRfX0VojyTF+j9o9
 vu5eSr7s0AcKfF1y1k8C5K/qTbKTFYo794HgK0rJlXnsVLrxpuii/mZhJ+dHr7QI5HoqBlwtg/0
 yA3ZJylvVq6gm2hEcGRJ+AaxB8dDttXSmYfUdqFW2SVNzDXoVjMioWFBIoXFYtPFS9XDckmVsb4
 wsL1YMqHfuj3ggiBKjcC514B1s3O5v1D4zkqPi6YuezZ2IFcgo2fLVzpXUn9QPf6dic7wK+eK1u
 KfHcxMCWA14npqERl9y5OcW08m/jmnIDPTTiCojo3k+NHU1wbfBmeb04TOivA+skyIRv4dmuXXr
 +bDKHS+gpmci2cwjW9/uWeb7bYWvqWxb6S/qWeLI9J5jN9/k3U2fom2QelhJ6tM4fiA71sg65Yy
 75O20/LAJMQt7GCgP+IS1oRBJWnOceXDBUDvqiUetagQ3ep664nbFRg/iUFYfIAftxF33WuIjSw
 W/C5n87cIckZvnHjUWA==
X-Proofpoint-ORIG-GUID: 1WqYkmXaqmgysFtVAtVP-BjRsMK69Xjk
X-Authority-Analysis: v=2.4 cv=KLtqylFo c=1 sm=1 tr=0 ts=6a7a44a5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=xoifrTKpydK2y5XimCYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 1WqYkmXaqmgysFtVAtVP-BjRsMK69Xjk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4MiBTYWx0ZWRfXxDUkHCZmrP9K
 QpisbH47Wtien+K2WFGRZt+UlFU/A+zR21Kpf5mhoGBhK9Kj3HG4Rng1Yi8V39OCZJIBPynqBBl
 2k/24Bw82d8wmcCQ+Eo8Bx1qHA20p9s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100182
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

No need to have handlers check for existing CPU index,
lookup the CPUState once in the core do_nmi() code and
pass along.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/nmi.h |  1 +
 hw/core/nmi.c         | 29 +++++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/hw/core/nmi.h b/include/hw/core/nmi.h
index 6136290f4fe..2f554d58b7f 100644
--- a/include/hw/core/nmi.h
+++ b/include/hw/core/nmi.h
@@ -38,6 +38,7 @@ struct NMIClass {
     InterfaceClass parent_class;
 
     void (*nmi_monitor_handler)(NMIState *n, int cpu_index, Error **errp);
+    void (*nmi_cpu_handler)(NMIState *ns, CPUState *cs);
 };
 
 /**
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index 67213631c04..fb623fd00be 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -43,13 +43,30 @@ static int do_nmi(Object *o, void *opaque)
         NMIClass *nc = NMI_GET_CLASS(n);
 
         ns->handled = true;
-        if (ns->cpu_index == -1) {
-            /* Any vCPU is OK, take the first one */
-            ns->cpu_index = first_cpu->cpu_index;
+
+        /* Generic handler */
+        if (nc->nmi_monitor_handler) {
+            nc->nmi_monitor_handler(n, ns->cpu_index, &ns->err);
+            if (ns->err) {
+                return -1;
+            }
         }
-        nc->nmi_monitor_handler(n, ns->cpu_index, &ns->err);
-        if (ns->err) {
-            return -1;
+        /* Per vCPU handler */
+        if (nc->nmi_cpu_handler) {
+            CPUState *cs;
+
+            if (ns->cpu_index >= 0) {
+                /* Specific vCPU requested */
+                cs = qemu_get_cpu(ns->cpu_index);
+            } else {
+                /* Any vCPU is OK, take the first one */
+                cs = first_cpu;
+            }
+            if (!cs) {
+                error_setg(&ns->err, "CPU %d does not exist", ns->cpu_index);
+                return -1;
+            }
+            nc->nmi_cpu_handler(n, cs);
         }
     }
     nmi_children(o, ns);
-- 
2.53.0


