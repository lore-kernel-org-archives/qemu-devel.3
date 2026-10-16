Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A022CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmRn-00076G-Am; Fri, 16 Oct 2026 14:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRk-000750-UK
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRj-0000Ux-FN
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GG16xf2551798
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iZzoLSVOKrz
 uJphUl+dMnLlDtXEwIlX+iwOf6YH9gzM=; b=SunKa+Dv5TaJF18MUcsMuEXlNXe
 2+PQOr0THOYdMUg+lW+lpO5dT7lK6Ex4++AcabGRV3u/rviOIQHY4KbjIUQbqUWj
 IlCN12UktyMSoL5xOEFg/bQRahUHLZWGobrk3mC4feLyigv3/tPDSscHuQWd6tG+
 zmvsqBk9WFkRElnmm5N610WRrCuc9D5oIlJc76r3sR5rukAs1MJso9m5K8FyxsNp
 KAQXpgXOJy5BI1/Cy4US4ME5S6rU1t7AgxJp1LPqoCQtVyAAw7LjwvgQbHvOeX/L
 2qv1g23P+rDIKs0mlV5GqNaLJnrBCnXj5wGGoUBynS1vjNKkjQTjPVVQMGw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq2wrq1s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ac450b74b0so302922a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174461; x=1792779261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iZzoLSVOKrzuJphUl+dMnLlDtXEwIlX+iwOf6YH9gzM=;
 b=Ouw8lVuVRTgU2lWtvUauZzedSIQXap6yH7M8VH8sSCPR1Hlsbq/8d0+6oFUcypDH6/
 Yj/JfuyC/MYSB3FSdp8I0KYUMuZQe69X/l3fMMI9oSnjy7tSK29FWxRhKoENE4vxiZFo
 eo7k1TWB5JTFs/nx6ZUwYnIcY63U4p9ertVWl8GF/Tchu32Ywb1j56sk7WixLHStY3X8
 uXkVQJi/1SJRlX/e9XvVmwGPP4wsuCBfAk56ot8jUcsebBfT1x+sdBfY/KufhTiqNxts
 ZQ+DOgCG4WBBsybVWssesTZV2wYOT+EFzn7LyqvENB8pxbIWX9JYEnVXPNybK1uAG9ws
 tt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174461; x=1792779261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iZzoLSVOKrzuJphUl+dMnLlDtXEwIlX+iwOf6YH9gzM=;
 b=OZXrRPhvi9ioOpbe/+qnM8Roo6ks82TAHVTQuv2OkUWp3+EQSREemqolFBqycE5Fvx
 azB9O1s9LpLPRWonJ4ObrecMbZ0mLmzGSZEOp+rRsHRENdUYxSa+wvzQs4swxvekv+iR
 L5INtrrVU3vo1kgd0PuNMrhZ66atBFGMowdYdlaD3qXQ1qfOjyflKo/PeGzRlJEYdhLD
 OJ7k0bK3RDVnjDOueCVrOzdbs8OIfHm/1UmxrJDBxjEtua3VxFmwUH4nZRtjydPa4lJi
 sys0eNOIbbdjuT47nhaDTjQr8wv9p7CqpNU5Lj3/I7QT8QwfNFG43nBWxMnWHPhevoHG
 yjkA==
X-Gm-Message-State: AFq9FYLwuyct2/jFf5je3SbED1yjJQoiM0u2sb9gOe/Uo9t6SdXKdVIr
 Qkc6ZWU/dcGvALB1U+b5gq2sPTBoS2fqFjpbCiHXF0OqUHaiVhILulFXGb0SK5UMYWSoohuzJVd
 eUMdAz4n1sUs/I1ZSIsEcfLXnaxQCDDwdt0f44sKf79JZyZVAxmQIgb7uxNUnropi1w==
X-Gm-Gg: AYBFou23pctCT1Y+NWUqtzWGyqZCyMMxgu4rGjcajtxTkRCmCmgKDAl7xzER6CtGy+K
 vrhW3mLPmswwX+yQTe6/WU4cnD8kuymOrKXLDUKJvsn4rIxDmyLMANkhjCTGdYAVbeZxByADL16
 B02YTWyVOzWoncj2fLEWCSxqFAfI8TMA9DpCaErR3UVFHweSizu+9s/70wAN+jM/eRzT+7/tOzY
 hk5fQ9sOmnAMk+G2beTUcVgF4FnZavEml9wVRuDfJNYWZfifwWu7tIEXIpuVuyeO+z3jmUoAZwQ
 e5sqqayECF6zib9hvuL5EE+oYrbUfpmyQxPUGhSWUSgUZahbJTSIs4keVKsrjoEPVHkyj/2P3W3
 WzXVuM/G6TUDJ97zp0R21zCgCsEY3yYmfyOS/QXUgBpQKqmpePY0Ct7fR98u5Z1s=
X-Received: by 2002:a17:90b:28c5:b0:3a8:c0cd:57f9 with SMTP id
 98e67ed59e1d1-3acef10d02dmr560221a91.25.1792174461275; 
 Fri, 16 Oct 2026 11:14:21 -0700 (PDT)
X-Received: by 2002:a17:90b:28c5:b0:3a8:c0cd:57f9 with SMTP id
 98e67ed59e1d1-3acef10d02dmr560193a91.25.1792174460607; 
 Fri, 16 Oct 2026 11:14:20 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 03/23] include/qemu/typedefs: add ArchDumpInfo
Date: Fri, 16 Oct 2026 11:13:50 -0700
Message-ID: <20261016181410.191743-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WIHqzXsR c=1 sm=1 tr=0 ts=6ad2697e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=GJhCjEP8skSFdoIm4HwA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: kCFTwP4nUOCYsNT-qwSxA-4s3FiA4a0F
X-Proofpoint-ORIG-GUID: kCFTwP4nUOCYsNT-qwSxA-4s3FiA4a0F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX5KuMwMVAivaO
 KxlbJblalhRw8CBbA5fPhmTu71keiT78BzY0QpROZdcPKZdaIa/t6Xyuc9DmolFVpCNM3SApp2Y
 JtXzIV5dIrNGqNPkfi4y98EiG2L92mqkYH36ujgB6pwIHw6H90i0U/9cuSuTAFje5Xcz8rgqO5/
 KxgGXIMdEM2CVH/FlSruoaymy7T9wmrA9EqVU9FtK2mEV9tmwm3UJhj4DxzvOApLs8uRL81UQyH
 me1vMzuE+YdmA2zMR/EuUBwXbU+UiGN7nJSV/ApvmF6iwHQrSArC7sa3Ma6w/jO9WszWoI7KiYp
 jOdSfuEbwo12aNx0OhL1f9mORYZLm9H/Cm08AplwesKeOvSLoi1eJEVw0ikcIZyFas4eCKPngVR
 TGpPFO7njW93YmLW+YKmA8U+SidsxvqwdRGDPnsGPi6h0uqaKJuJ/xsrdN+Qs1vx+U1xk8QyJdI
 Sc+j9rb5jJXV6vLu2qg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX+cxxe8ftjYlx
 Ad0cNOBAuIUWFn07MpiO/y+7Zw9trLDtTw6m0KOqPcyc1XsJIrisq90M7LCBUxyoacMX5c5Q75m
 UUvkSE4SDfHFHnQ3z64ni/VK7OKNLUI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This allows to use a forward declaration instead of including
system/dump-arch.h.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/typedefs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 2344c92182e..8fa7f752dac 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -28,6 +28,7 @@ typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
 typedef struct Aml Aml;
 typedef struct ArchCPU ArchCPU;
+typedef struct ArchDumpInfo ArchDumpInfo;
 typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
 typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
 typedef struct BlockBackend BlockBackend;
-- 
2.47.3


