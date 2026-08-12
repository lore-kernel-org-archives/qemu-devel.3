Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472D1C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7pC-0006vY-ML; Wed, 12 Aug 2026 08:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7p8-0006vC-6p
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:12:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7p6-0007Rg-Eo
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:12:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4SNJ3963406
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S9gC3BqAKixHIMRuSDxvDO89+yIQbs1B8Bz34DWZvWE=; b=gDGIz5+gRuaKXFLu
 CgbjuSBzZlf9Nq/WTwODYc1Z6e2o8GB6B6UgxadVyGoNrZIXkrQCPOZMKB2Vg42K
 x96vV3HtkuGJ8vXz7HcmexFy3vCgH5Sp8FSIjopU2R00s+BXg2/JlYDLF1LaSGPh
 l/yN3dV9YQg+rZEJn3lfPd7XeTutF8+qpY8NX61OAdD8OQE6zqtI5JHY5ns1ChS1
 2fjW4U73PHL6Nv1VQ0S7U8zZyVuvUuKTwHUbTa+P59A6BsHZLEsPR7I8FLE7tM0f
 AMsnyQj4BSOOKGb2ZKi+yJu9K639YZrbcIFM+M0u124iihVORwB5FYBJLbMjwNSk
 3hq5uQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nucgpba-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:12:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52cd0374265so17265631cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786536762; x=1787141562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S9gC3BqAKixHIMRuSDxvDO89+yIQbs1B8Bz34DWZvWE=;
 b=hSlKFScQt2yiXz6IPAOqE7Gbio16ktGDAGE4IAFHMQsxUdacH7I+sROrNVrZRTGsrO
 n8KN7KVinOj+Qj/l1G1LeuNj3Oi2tB3Z/ssXS0KQ9Tb5sp6fkBvTlPI0FSzgBursHzDr
 xwdoDoNelRHHqTwdD+gSL9z6GWRSXMg0NbjMCSUp+n0Wc5JaVGj48FPzH/bO/RdyntHb
 FU4gLOu2xFxhwK5qAzqJcEndb8xHiIFhjgH7SjbGcokAuU56mNZYLtgZgWGtyMZSnzsF
 n2vrL9XZzzja3IU4WUph3dwdDQq8XvhOiz0Li4elykW/K3SfCqLyzQ13ZsHmy+2jjKeH
 blAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536762; x=1787141562;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S9gC3BqAKixHIMRuSDxvDO89+yIQbs1B8Bz34DWZvWE=;
 b=crbXBEhH7TVmYLTB0fkH99pA7i7IpnxDLSviItTKEuGAxjPKaPJwsfupNCDRWKotML
 JcCZ287ExdqzMar6toBS9TFURDjX/npn0kE5VJ3k8i4MyjE4w9GfhnvZuewEh1+hUp/D
 jtzIMm03pdIj6eoY8vPuJfQEx8QUgX+42j0JfLjQZJQvl1xJ05V2YMdnhtFfA/R/FINS
 /dqltoE9EqdNBVPzCBOKWcIYC29kGw0AwLcfBpsBaiaHdiAV/50VQXyIxUoh2zWICohW
 PpJTqtKaVe/DbzSht8VzDALJ1uPCz1/miGyn39Bgp7SdpDGBbfk8z3kne4g7kfF3ncQ1
 8aiA==
X-Gm-Message-State: AOJu0Yy0X8mQa3GtaIR4QYA0wURQVUEgKAXcebEXOvb0idrhqxDo/HDq
 sj2kaIhSO6owlMK9H83NVle5tyPcub1gJr+r/E7bMl7turzRdH60s3MtI41q2Rxewgs/gtgcyM+
 DB/+QhZ2uUFzjG0r9MVXHxH//UVbYMNa5f0Z/UyvcZMETEPc4Oj0QzxhLRn5kcNiNnQ==
X-Gm-Gg: AR+sD11FijMs2uiomWPUZ8mUxhfMOZDctwrTLNQhVW2SP+bf+S49WF1JkwGIwHcaLsh
 y3uxD7PCYeGu9cDfhS5368cL1uIRRS2xCdVqS6gVeURp5REHtvNxGRp5JJQO0FNt1Vq9Y3Z8GaW
 fX50jw3ErTK16EOEQyNRHxAHrCds+W9+/hzJtIFXwZ+hj2y+554EDm7FCVCuM2+sp4BBspe3vcr
 AzS8IRKLkTzWKK0ZxZ9RdwYXM908jnqmtKdouokrPF6XAyZF2M8n+Eh46qHO7N+94A/pUyErv2+
 X02JO46V+Z9ptNDgxeRsUPRN5wMiNogx478tH1AJN0PBJRAhUx9D4v26L4kJRurbwmo1CNPKQtz
 8ptiP54Gqu6tX5f6yiZ8PhhqDqvoyAsji5m8ULqharg==
X-Received: by 2002:a05:622a:4818:b0:50b:48e3:47a7 with SMTP id
 d75a77b69052e-52d647074f5mr38476021cf.18.1786536762141; 
 Wed, 12 Aug 2026 05:12:42 -0700 (PDT)
X-Received: by 2002:a05:622a:4818:b0:50b:48e3:47a7 with SMTP id
 d75a77b69052e-52d647074f5mr38475341cf.18.1786536761643; 
 Wed, 12 Aug 2026 05:12:41 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997b237ab6sm36456285e9.0.2026.08.12.05.12.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:12:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/7] hw/nmi: Use object_child_foreach_recursive() in
 nmi_children()
Date: Wed, 12 Aug 2026 14:12:26 +0200
Message-ID: <20260812121232.71958-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812121232.71958-1-philmd@oss.qualcomm.com>
References: <20260812121232.71958-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gaCKtlVZXlW3UTecUOuRiqOcMkwUVrPj
X-Proofpoint-ORIG-GUID: gaCKtlVZXlW3UTecUOuRiqOcMkwUVrPj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfXyajaCrYx5qja
 Tf4+eiFH+xTysNv3iaVzMSsFMUkxYzEsLDxtLp2VEylVC0/JTdgWmpZ+HQm+Lbvp9DxxejfYk7W
 XjUEAXvVKcjyctuH0S8wKVKC3oflhpL6OEIVBgsvlQuaVD5crP5+tULCWUl5xeQu4WQxwcXl4Sn
 7moCC+EuFuSTI4+TCEadsb8VdgeZAPRNb0hrCo0fgQj7peiJqp451P4PrZlIlr3BC/wGi/T7vFx
 MvOxrn3rQ2JIgM/r6DnhO70sx4NanFnubEKv0IrSYUiO/h/sc65s4bt8H2NpZwkIaRCNSz0TG0b
 fglLIgA20MW0969KZw8eB1Gy02P1tuSLATsZxMjDFt16akryE+fXlICCJmywDVKv63Wney/7/bQ
 UbRbwwmP+k3jV2cPJ5TupPxN6UYGNPLMZB6l27p13fH79obs77nC6TX0prWJFCEjKJcWrEPAL4V
 ZZdNmRAwUf1h8CysRsg==
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a7c633b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=jmNSRpmTyL3U9imlh2kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfXyeaUKdkoQOv4
 SuXqTaKS/P18lz/OB1mRK7h0MpiNwql8lY1+Oo+YYlXV7LvXr9xt59JwjXfoOKpLmGAluRDlOX6
 MtIX7yoSU8TYXxa1JfkYEjuOblRd8AI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120099
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Replace object_child_foreach() and recursion by a single
object_child_foreach_recursive() call.
Propagate the returned value so callers can check it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


