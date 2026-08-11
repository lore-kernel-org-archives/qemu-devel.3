Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A9EC5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtk83-00087T-1x; Tue, 11 Aug 2026 06:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk80-00085p-PV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:54:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk7z-00007G-75
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:54:40 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BALjkj4177502
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yK3vNt1t/PS+GzsEVTsPCWTVujnrwF/VrOO9PtMQReQ=; b=WMm92utuCQs6vSSS
 npY9dB02zLwb6WrVaOEjbJVOCeI1HrU1v/lCbXHrXR3v1JtrZX4GlTPugMEKrvdb
 GInvrcoybnlCphWyE/01wyAJMZHtff1gizjpEuS+oPvD2GJDPpMSRfn5rdBy4vck
 yTE/aOgtXgfqda1GbkFUvGkM3xuG8rI4JduaiIQ2E0o+ysDTlk9JBKvIL5DC4QFU
 PKeYs803HpEy947AWnu51ctCqJqbJrz8PVvSF+n0DUt2XrPOXCpLC17wz+zB79fO
 ysjh3/w7Tw0vyzNVqC1pdqXmvn/gq+Om13RYIIr2Sdn0pwqsMxGiDvRVLeIW7VwT
 VG5yaw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyvcr9f3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:54:37 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8b0a08d2so5661631cf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786445677; x=1787050477; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yK3vNt1t/PS+GzsEVTsPCWTVujnrwF/VrOO9PtMQReQ=;
 b=ABmEHeQZLy3nKb2Ptqx/NGlUOqbE6f0icxY+RsUMDWqwWkiNnk7nHbJ3JBkviGSkY4
 oNrCjRPuUoaFAttnTUJBSy3+4cG7LTaulrz9U+D3vTj2KxU6iHkOXSbSasSjxYaurctQ
 fQN6qJyHPkKnqAp2/WOOSo+dF6rLCbtmJBONkZVMGzdMKvx3Q/AVN9n/+8QvO9uYhluv
 GbZnWLINqCxl/jKGdT7P63UVDQL3/L0wcQl1AK/HSOE/7t2RWLiFf3v2LoRgq/lWHMWJ
 suGxQy8qR06l95aZea9Iu+jwPapTf0iNP0D0VDjVH1+MNFPRWEbQZRzWc0lBLvg56QcQ
 dAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786445677; x=1787050477;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yK3vNt1t/PS+GzsEVTsPCWTVujnrwF/VrOO9PtMQReQ=;
 b=hp9fD0cYr5IEHiuRUE/p2MhCKa5hLMYD+zCvsDnOFbEPEkWEe4Cdu+hGGZeLE4CTx3
 vh9Q0SnhetjB0Uc9Bf4r6yjJYKyqfmlJKwGZgr2nMWKkUrd2+nvuZ/3413D8JcoE+NtQ
 txskOTYpAnyi3/CWCDUPsbAOXaaWs+f0Ss4ovPYotME2unPbLX09Nx9wvOZFqbT31GuO
 /jXn50XRR8G8ZlRvqb/coMXM8Vm0owzMAXXyDKYPbNHhmW4in1BmWnX7a0wgFqS48Ft8
 utr9fRjuoGa9qhgk3yDj/+2jlEaFblr92nQ6Mx7gYQyh3vodi+KXxCEq1t31veK92rlh
 ezFQ==
X-Gm-Message-State: AOJu0Yw4dpRjT+gouVOE4ZSdb7Tuw5WCu+x1j9nCbqZbWnJ2zbGwoioG
 LC2XbsyzxjQ0Z7qAnzhLZ9ll4ZUT0R+eIrcKkNHKOTNex0v3ua0kHCdtcxEoacTq7O80jC6yj5L
 gtU/EhrAC6VjUHniEWCf0vwnvyt353DPtHk+O5/V/DsHbbNvNNmroALvruNG0n1tROQ==
X-Gm-Gg: AR+sD12ONgg3VkI1zgo8ashgv0tijtjiPnu0qB+a2b1T6IfNc95JbuF2OP+GfGN0bn5
 C+t912k/xhBajp4Usfm6c8AUmVgAWQcdsNz9yTUy4blAueFK4Sw3NsyLsjMMspWqc9jf+yCNE0z
 h1epVw/kVXYV5Bj7hpeIJkr5hBFrvW4QAxAVBFtjFK+CiE21/ZN4PiXooqIJn9Urv+N9+Jq8xBH
 Xa1OgiFfPRIDM9EBYRsjoLsec1cwPJJG+6DGFcHvT7dxo8c8UdzyltZRC0MGrfMmI0vDlfbXAsX
 KG4bKv2P7Qiu72AY9S0xUK6AWzlStjk0Shx77szFYutLgv8jeqsWWWeREGo/1HyObaSip5euULc
 M/QWobZw6lY0Gcb9MIatWZXGukhBDA95Cu38BGJK/qM4focA=
X-Received: by 2002:ac8:5d16:0:b0:51c:22c5:daee with SMTP id
 d75a77b69052e-52d5864d5d4mr16457871cf.29.1786445676939; 
 Tue, 11 Aug 2026 03:54:36 -0700 (PDT)
X-Received: by 2002:ac8:5d16:0:b0:51c:22c5:daee with SMTP id
 d75a77b69052e-52d5864d5d4mr16457471cf.29.1786445676372; 
 Tue, 11 Aug 2026 03:54:36 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49974146933sm68688195e9.10.2026.08.11.03.54.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 03:54:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <minyard@acm.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 1/7] hw/nmi: Use object_child_foreach_recursive() in
 nmi_children()
Date: Tue, 11 Aug 2026 12:54:19 +0200
Message-ID: <20260811105425.7429-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811105425.7429-1-philmd@oss.qualcomm.com>
References: <20260811105425.7429-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX0lyASTwkeBjq
 kVeYDKi0a+Fq8+8FLZ6Gp8m38YukWJgXGhJXsqpdWkU2tezM7gSA4JbGjQaY4ogvFjmmm6jDdi0
 aXcOCUKpTLGALvH+pAAPi4wJomrs0CAuIn9Phs1gkjWvmTnCN41xT4Aed5OiiuDlvgQQEGbsdfC
 Rd9xAVLJWTm/7Rqs4FEOtf/hk51nOj+w6p5BdsBAL8Wg+8XvX9qxyJ2176Tt3RlESO/oMLwRWVD
 oRxrenORdPsiUhUfL4PRJZGImIv2QQS5tmUYGka5J5bsV6RtpADE5/1uA5AnZRIxk0wNUFGxMDn
 R9dJP4Lfy0kHELplyzxdIhf1ttPt6Fpk0H3VZj28FZeWkciZXRjNJkDKIrs59vOhWs7MeLOnkAq
 w8g+ILLHUacVqnDp8bEPRK4Xd1KMdjQ9ylDS16oFs0ZfcawDPVkUyGrarmh5lAgTGJVia8wSXGi
 Wkl30KOZ8D+bWFmnvcw==
X-Authority-Analysis: v=2.4 cv=e/A2j6p/ c=1 sm=1 tr=0 ts=6a7aff6d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=jmNSRpmTyL3U9imlh2kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Sy40deXzm4ho5TpyIC-6n3jVd1sXWgvd
X-Proofpoint-ORIG-GUID: Sy40deXzm4ho5TpyIC-6n3jVd1sXWgvd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX4BSRW5wS0ZfP
 rYOvPSf7nAr9vprw9zgEBdfpUN3QB1AEIM3JAZwNJEHkQvqB3TNgxi143te1LlAYsfyvq6Zugvm
 ISM/3OF0HM/jOUypVpkLgMgGGvTxSUM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110090
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


