Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F828CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ3Nv-0001sR-5d; Mon, 15 Jun 2026 05:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ3Nq-0001q6-3h
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:13:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ3Nn-0000IW-CK
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:13:28 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6KA2H3692537
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 09:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MF2aozQ8nBaPhoD/R1S5ChTpTVtPNvgch2k7hu45wMU=; b=HQ4JlZ+9iI5Pg8gm
 5OExKe8ys/F/dP7MuxCzdbLqKeA9uVUWbRX/KBfWG/KuBcDVHLrlJjK7jmDRdkyj
 c4OeHQDvet/PAnPzGK2T8foJ9FOrw9OBkE2WGtjgUe+BRHTv/Erj3lzc4BgSPRef
 6rwYzHf3u4ksAB+QYwldlejdoPnQ3NPU6bERbGNtqH8SeDxn2xV6ZSDpw9oQg7ad
 sOqs6RxZ+wTL4agvPmBQ5VNEzPwZYkdWN80siVlKL+OJ1pSgwdMqb5DmUARReFGy
 E9VZ4fn8ryd4Jk2EVvuU+vRU1MHKsYDfFH2/zwoTMar+j/AIspZ6ydBr1N6BaNdl
 tvmY7w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryk6ehkd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 09:13:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9159c4b210aso512667985a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 02:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781514806; x=1782119606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MF2aozQ8nBaPhoD/R1S5ChTpTVtPNvgch2k7hu45wMU=;
 b=ZQ2hTcuWA4mppg8DFI7gBNYduH/hybO4MGWF1uukPoPlvG6PlxOu312bwz1pCvJORT
 10eE14DyBO+EArUjLBDh5INDjLNyKcimBXKUOqJND9I4NUW6rWeFY5V/79s93DIj1a/U
 lkmMs49RhW/bqiwTXp0Etp4QJs7T3X/Makh7xhFI0N3qzrmVGeKcaZYGbq/WGxu44m8m
 6jT0BG9Tve1gd09SruJzBgdRi/l69FEknsCgcOjsjFZ/hGXSoP2jeJGNMg8YYMpxSFuv
 hE6P46abWECGENxp0Js4OqEBG23FSy1zsqQ/zJo1ON1hZ9UrBnk6M3RW/Qa/T7muVSJ3
 faPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781514806; x=1782119606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MF2aozQ8nBaPhoD/R1S5ChTpTVtPNvgch2k7hu45wMU=;
 b=IrJaF7nkzldnkJy8rPfy6Mbc4FEr5aPC+FNWx+Kl9jdPfKDPj1Wh790XuzRQggXXPl
 hV9EDfYPJEhApP6qZ6qB9K57leN1a2ZFpbL3Jn7mYtY3gSflp6QH1Zt1xghlrb2JSGvY
 IXnVIMoxPnwMtCH4Jmvl8P8n42xKGHfWB5Upo4x3douobX0g03NgU1ltPtaZxsZ2aykl
 2mbdRlINQfK0WaePQ5+1e2G/jLAXTiJrw8tVC+fd+Sso/pzCnHFxaPwVWGUXUyKE4vMA
 lX64/Sl2GRIHWg1shubsNu95yBjwDbJveWyEM1FSz0oi9vdMezjfzqZaZQBkRCEJ8yzj
 1lyQ==
X-Gm-Message-State: AOJu0YybKUv0VR49MsaX+WaZZJlzxcUg29QfClKgrFN3AJNSJUYfwKtu
 kE9zzgD56n4ePeHGsALLzLSs8KMbcKkDlAbe59H3RrcI5fn1EWEjkKGrpR71IeIqai7dMVTqg3d
 w++LWr4uwdjtoGVq7OfJpYWXf4AD/HdpjMrsL9XSfKN8t7Hg2q61/m9sTq3m7QZ7uqA==
X-Gm-Gg: Acq92OHMviw0RBpHxluU3MbivbA7+MVdbQqN+4d3gAjoja5Jg0xa9WBBU8kGP8WceVe
 G3876EURuCV2yXnumqeSJnyhtN3c0z2ESzRTBegCZVF0aT6pocndoyojaf8RSVSAupURex/qbwG
 j0tKf1QIL7xX70INkREnuNa5xgFVnvP3E2XTA7/4mshJfh75nPIRqngvITmMTDtCv3R09OO/uic
 2OM2EayKnpjZsLwNP/FQAQYWZujx/651qzop+P8XRdqcBXGrUIXE6aXzENYVCoDgiraQTgG67Bx
 a7N9WpDv3kafLX1pW66tTIE/RLgSkIB1jN0zaEZ7H5NdherKo4ALCPRh+4GU7SOIagpW30p2OOv
 iGy3ZC2NK0WQbOE79O5N9BTfxIVGK0QXjJzrCvOMli4kxu1bKpG3tzlxTPhNpJ1cTWzZaL04EbC
 17noM=
X-Received: by 2002:a05:620a:2681:b0:910:c1ba:91d3 with SMTP id
 af79cd13be357-91619f7d7b3mr1735523985a.45.1781514805744; 
 Mon, 15 Jun 2026 02:13:25 -0700 (PDT)
X-Received: by 2002:a05:620a:2681:b0:910:c1ba:91d3 with SMTP id
 af79cd13be357-91619f7d7b3mr1735521085a.45.1781514805350; 
 Mon, 15 Jun 2026 02:13:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922031b7d2sm252204735e9.5.2026.06.15.02.13.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 02:13:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 2/2] qom/object: Remove pre-C11 check
Date: Mon, 15 Jun 2026 11:13:08 +0200
Message-ID: <20260615091308.4458-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615091308.4458-1-philmd@oss.qualcomm.com>
References: <20260615091308.4458-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5NiBTYWx0ZWRfXx+K3/IW2XPba
 xaaEPkmFmhKXzwLjB+NR72Yelrs7Ef3j3Vt8YbcHdUBFb8Ska5ytGGjPoOTG8jH7JO9MLy690Z1
 5bW5zJUzfp0VQGBKWybv30yOMAckHBA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5NiBTYWx0ZWRfX/dLd69wGSk6z
 Bag8vBwfy2CHiId5jXXatEXlqcrUP2PSoabFYNPsbMsSt3ljTwEDoDpc+AdimtbKnpNO47TV8Km
 cfxsKsGb448xLB6NUIThb5ThuAQZa7d64jf1IobYfHBpnr54DAdrGEukjG6BTv1M0Jvicqgb1a1
 16uextbbE65IyLHtsv0PSmAcPS1fRr9pFeeT+81iz/TexLZBfrD6z+LNq2DcLVgkMiy8W+X9f78
 W52jRpQd0NdjPArGdjDno5cCRUC30DKm8Zo5qbHMWYBLmaojhtSHjE0VfNbjuWpAsoWw/ienWdQ
 5/EM1L8k/zgCA9n0NXRMrkIfLdqHEaBOd5s9qHCJDncW6u8Z9RVltgDMrsLDr4EHLcOI/h7OT45
 arv9vtTBtQLsjL73pSVJSpooWZ7O+avJevpbanwyj5LMwWwyC8K21F+LD8+zwVWCwPCpsF/7VNW
 lIlxbsTj/pSx35248ew==
X-Authority-Analysis: v=2.4 cv=NrThtcdJ c=1 sm=1 tr=0 ts=6a2fc236 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=_WKHBmQO-qgaVRkQabEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 00VJLA5eRTJrOQjbpTvl8bhfOdi4P4zW
X-Proofpoint-ORIG-GUID: 00VJLA5eRTJrOQjbpTvl8bhfOdi4P4zW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150096
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

We mandate a compiler supporting C11 since 2021-06-15 in
commit d22797ce36a ("configure: Use -std=gnu11"), thus the
max_align_t type definition exists. Remove what is now dead
code.

Note, C11 provides aligned_alloc(). Using it is left as a
future cleanup step.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qom/object.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 0ac201de4c1..f79b2cf3618 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -675,18 +675,6 @@ static void object_finalize(void *data)
     }
 }
 
-/* Find the minimum alignment guaranteed by the system malloc. */
-#if __STDC_VERSION__ >= 201112L
-typedef max_align_t qemu_max_align_t;
-#else
-typedef union {
-    long l;
-    void *p;
-    double d;
-    long double ld;
-} qemu_max_align_t;
-#endif
-
 static Object *object_new_with_type(Type type)
 {
     Object *obj;
@@ -703,7 +691,7 @@ static Object *object_new_with_type(Type type)
      * Do not use qemu_memalign unless required.  Depending on the
      * implementation, extra alignment implies extra overhead.
      */
-    if (likely(align <= __alignof__(qemu_max_align_t))) {
+    if (likely(align <= __alignof__(max_align_t))) {
         obj = g_malloc(size);
         obj_free = g_free;
     } else {
-- 
2.53.0


