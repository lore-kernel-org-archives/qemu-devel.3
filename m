Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2451C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc7y-0000On-Qm; Sun, 16 Aug 2026 10:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc7v-0000Fy-MV
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc7u-0000cB-5w
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:19 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GEMGIE4022409
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1BHIiwaFAj5R5XVpPcwZSL5X+s5GtQyu0jdUw18Odrk=; b=IEPGL8duskCEStUR
 Q+4Fc5uHF4t1f4Dhf7Zj4NPuz8SnaflMKY4zYLZFOjKRSWwSGX5j/LD8Qnm27sLJ
 eTshI3JLt8cfif3ZXDPKAo3L9Yg4sJtN0MWg0+NLcyB6HdhHj2vVPujxxRINJB/9
 MgM4otKoY0Xr6TKKgAo/SE01u9t9B1d0/qWnBQ2bXPFn4msxQhvxn3ERg9hPkrY/
 7BcUJ1Vh+9mSvFqVWvwHWTzwPWI6sbQrfZ20crquJV/n/0DRc7m6WS9r/OEK6fo8
 bocgort9iU0KZ+AQOAECOZ9S1V5lOensuW6oQTMyPOGxSTrjZfmQ8S1PuDdDCabi
 la+Ywg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghnum76-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-930edb4362dso244010585a.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891575; x=1787496375; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1BHIiwaFAj5R5XVpPcwZSL5X+s5GtQyu0jdUw18Odrk=;
 b=Si8OE/OyBUWOj2MBrr9Oy9+o6f+eG4B+tp1JeHYuscVBlf/NRQml8tdq/MC7FLqM4e
 fNBlD+ilMLvsCNswoYgZ4uVaj5GDvGq9tYZjkyb0tuF+5RzB/nk6VyEROAWkI6aZrbX8
 LFxQ5a8HF2mUhCUiFRrFzZuVS1UzMUQPVXUAjZ0TwfcuuYtRfLpQZBSafJcp1srnuagJ
 xBLCDvDuDLUrVJAdKa0gqnJ9Yib+e70yygxFjVhJtvkqXbkmOKocAXgspzJE3gfCyL2f
 T6LkLdst6pA7lAbfQsG422Ri+gT4iigfrMLuQi5rk3E6BjQkuP1XfXSpMWkRxSfH2IG+
 GPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891575; x=1787496375;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1BHIiwaFAj5R5XVpPcwZSL5X+s5GtQyu0jdUw18Odrk=;
 b=gFAn5aF6K9Pdj5UBy2IJ2ExQdgNPhhRysSYlrtB8iD1ykzeOjmYWu5qLJ14FOrShjR
 IhgNG3ZDgFmoOdODr9O3TP/L0Mr2EV2pyJLLJ+Q9+vG6wdHu2BuJ03E4AFAkdp/6auLy
 I7MbyHsViNc7ZQf72F9NgGxzOcQobNFqTPZvuGHWa0sB8pQEj7xaVDehJb3bVWlgx2cg
 2lq9Mnt8P1i+pMijwe2q2g8uCmlv+AR5HpYS5Lk7dOKzHvd1uKfldmf60AUfV+/LCV2J
 WayXECHEOQLDcUzWfyB4M44s3bmVGdgpuqfPVLKploAQ37zkOmjx9mzka08EfF3J0/ji
 /wGQ==
X-Gm-Message-State: AOJu0Yz9LYYe5eSXzIyJCJ11lsTqMvn20JM6POwvS4oWpWSynzGKzCaH
 DHRnMEQIJqQyj9OKCVfuyjhv+Cc+ukDDL8w6t1NetYIHo4nuPtVzJpXv1L6ERCXFUXjl/ryFLJB
 zBvVg52sAxUeFP5hPdkqX8rfiK7+1vgCz42MHoNNFHEcZ5EnrG3osz891iGgjlwZHMQ==
X-Gm-Gg: AR+sD13BuvAsyev50UNlZNlGk0vTf+RViyKkWdAb5fKcfXbzyxMGE5IpW7HpjhPeNgE
 GvwdM72i6vCrtynH8Vyt2Ic3VeebKTdVlArvE63XwoFGnb2Pgbjfn2l+ffHCr29UVy+bglXR4n2
 c6KExgtkzqPPDHxJJux2vHLOwxg3j3G8pSjg/BtoaBfNkqpFYn2ON++k0Dy97r/ITBV4bYJvD7X
 4J5bq+4YeiPmFvtxoeOeUzyWEdU66qfRZKGRxi9FSG7HReK3wr9uqUiWKsber5145zxA2xC0p7i
 xp4Kge9tDJreH0T0b8QpQoW/ZETpKUMYmEBnsoomRCfwfIleX4KmOOLmlRU7hAQ68dcH0bBRJCh
 gA4YTlQRTSecYgIJWj+3EHRjYATwdSffPHWbEl1EzUQ==
X-Received: by 2002:a05:620a:3f4c:b0:936:cddf:3df1 with SMTP id
 af79cd13be357-936d234552emr1385910485a.44.1786891575235; 
 Sun, 16 Aug 2026 07:46:15 -0700 (PDT)
X-Received: by 2002:a05:620a:3f4c:b0:936:cddf:3df1 with SMTP id
 af79cd13be357-936d234552emr1385906485a.44.1786891574731; 
 Sun, 16 Aug 2026 07:46:14 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996109652sm70670065e9.4.2026.08.16.07.46.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:46:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/56] hw/mem/nvdimm: fix "size" property typename
Date: Sun, 16 Aug 2026 16:45:01 +0200
Message-ID: <20260816144556.69009-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExNyBTYWx0ZWRfX0UQguwuUDGCk
 7yWO8Y0UhNFg7ckMRA5DpdczxL26tzNsWGsWgm9l4e88b3jl+V2O7g/toMIAktJ/VZfqDCSPxmV
 1GTY6QUoM0XDmT8eOXQM7h6DzupFJkVfdq55JIv7Dpp3nIhu6D7HbV4BjKv1d85AQQ7y+XiQIp7
 pIad5kHpp+ymlpHc8OU2gFulH/TlQViSVcl8kAbTB4NgsjbSkpwng8hqrxPCyOGBpl1EvPlba2/
 Kt1LjVHpwopeFZ79gtFcBkuIEtHjGbq5reiOfB2I7cjSMwWxX2+N7aimmT9CAZudAyUqIsjyAyW
 K+3XzdYTzqMnVSTlmzJJ8CMIn5VIz5JUEsKELxChc7dKj3wbBkM+v+8n7xs5fISveJYLYdLfvCk
 e+1+PaHcrCSHsFG8I8pTuwjrgfzbNDDRVC1oBOY17qq5z3Fdw96UN7RleqIGAq81c5YORM85miX
 3i0AJabKQnvqBqEFFbg==
X-Proofpoint-ORIG-GUID: opBa1at4W7StoQM-fseTSfklslWbEw-M
X-Authority-Analysis: v=2.4 cv=QN5YgALL c=1 sm=1 tr=0 ts=6a81cd37 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=__lbXBbGMqqOeBtyAPwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExNyBTYWx0ZWRfX/zKZN8sEz3WU
 vrONt9Eq+hHROehOtqI09V3z44zfwQuIghVFjGCVSl0wqtQXTWQFZBtatbgzId1t6EowbEEFWaw
 Q6T8RNjagr5OFoLauLl6DnT1633EJEs=
X-Proofpoint-GUID: opBa1at4W7StoQM-fseTSfklslWbEw-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160117
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The getter/setter use visit_type_size().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260616-qom-qapi-v2-30-cc9396b9c18c@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/mem/nvdimm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index b7032525271..cf8a4d8c5f2 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -99,7 +99,7 @@ static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
 
 static void nvdimm_init(Object *obj)
 {
-    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
+    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "size",
                         nvdimm_get_label_size, nvdimm_set_label_size, NULL,
                         NULL);
 
-- 
2.53.0


