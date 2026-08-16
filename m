Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B530C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc8m-0002Ft-Hp; Sun, 16 Aug 2026 10:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc8k-000265-Ql
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:47:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc8j-0000i7-3q
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:47:10 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkn912760476
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ueiXCUBV4BeC382azPN6x+rhQstqJgU1/MI1GdQZNgw=; b=T6Qaf7hyV2P/XV7t
 Lm642ElAvFjDuySPzUgDhzBJpZvZnm/8ZgcRoMUoZRi+dvsEjtaiWfmaStCf7hcc
 8ZnqfAeBiybxqe2AU0g1lnWYCaC+yE31wpygf7FC+OPti+LdBxtJLBWcAQnjE1kr
 aj0ux+D4YgttEmLLJcXJ9vdt50/3wSNXWuTvmIKdSmu5/Uu2qqd2wCS4Itm8pxeF
 al8bzgPeEbMRiv6fD/KRivxLdwnf10eR/MaI8LSbSYdIVBulQc7B0GV5cNFDdIXI
 qyyK/WhOyAKJDSWbLfkI6Wbb22YvYLEh0DqzwWzxCyDNh2Xo+dUUQrkopswdnf1F
 xkp5IA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gkh0v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:47:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bf321d786so36976981cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891627; x=1787496427; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ueiXCUBV4BeC382azPN6x+rhQstqJgU1/MI1GdQZNgw=;
 b=IypwdJoDBrrFWW1/o2LqAvv2NjHg89b90b98ydObbXMe6aXqdjhhxRMFWOrrmbQbth
 M0/st3u3jTTnCjgezpyfA6jsERlmwLWu+86orA6r8ksBWMU+BCHax4/s/MuFmx1cscfo
 ZzKQPDLnJNsA3wzLuaG1jmrjoM9f8S813RSWUbCwnj05lH08CeRnqo6dSoBTP/cSjlMB
 SqkPJxdVTV3j1wOX1ETqvTBVZyX9XcUDHJWt8iwmRgroi9Vch5aLRLMyKtYtVS5V4r2y
 C2hRDnW/81JJE0M8MrS7FqwTOgJOqB+KeqK7VsGZuK88rDXuRlx1F/TYJMTz1cMGPC93
 v1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891627; x=1787496427;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ueiXCUBV4BeC382azPN6x+rhQstqJgU1/MI1GdQZNgw=;
 b=n/Gb26G0xkw0au4pPH5dK+qtQ0+IhgJ3mgL0imDLoDfSiTCEKPDtuCWXc2/JKi9vid
 ekC512MiwgCWdna++d1nuENtm0SpEKS4ejjV/c678dns1YuZTQXwNSjWRzt4XYKHUZvk
 aC3iItWbUsixlgbqqENHRw9eVhhiw1yPX2O1eeoWE6a2h/jtGrvx5ZhQ09wX2+vJohaz
 zmyQY7t7WvrHK9WXWzLnV6M2Yzhs8wBHmdfXLOsd2CE4C6/4zufgE8BltC03Y03tm0eb
 kFIFb+8JSVk/nyJ9i5cQsVLKy3GHBw96VsHR9B5f8rCcXvuWNilY8cCZrEyK+QPwVgEl
 aeFg==
X-Gm-Message-State: AOJu0YzrdwaTSi4Xru4oasDRxAivYdsZjhy1JrUZXaN3J8gHy3/tf+2s
 QHiTgRlqT9tsv+kIdvM1ym8LsYNVwPxy43RPi/OGJiljLhrCs3ZLYWSdPZaDflCnGa/MW6LBZEN
 6xvfJSH7pmIYC1ARKAO12IQf7QKBVjinHjJBskfL/cmsDq6KdU5Knz1MozWjeqAkf2A==
X-Gm-Gg: AR+sD13FONHnepxgXLNZznF17Endo4QZEiTU6x2kBaMnIH+lGnmNOIxyRXp6Yp/Yn0o
 yQegLxfunNIA9wKc90ylqWDCg8pD063X6T6ZHWiHtdPzgrtElhcBQjkgTyL6pVOywG9kg1MPUSi
 DpB1cP/emmGii28BmxkfRyaEY3e9wyWV/YX6evK623XD4bNwGfTGtaYdbTj7TZuntKjHc7Du5NZ
 lVeynButfMzklwXXYDmX5j8/MTfgHRZDQUIkskSMQS4eQSgFOKafBiDV3OJoDVfwJZ477h/Wd9A
 zDE5p8cpd2Gu+knjYDmd9iTOYB8RfdB7pNu7k8L9p/YPdg9NJfRxUoGdB+w/dLMpDjLSFNgNN/O
 OmqYSGVQr52B8mDTKh5LBGPy57qKgR9F74wBedtXynw==
X-Received: by 2002:ac8:5f10:0:b0:528:1478:e1fc with SMTP id
 d75a77b69052e-52d854a4899mr190269491cf.34.1786891626674; 
 Sun, 16 Aug 2026 07:47:06 -0700 (PDT)
X-Received: by 2002:ac8:5f10:0:b0:528:1478:e1fc with SMTP id
 d75a77b69052e-52d854a4899mr190268981cf.34.1786891626144; 
 Sun, 16 Aug 2026 07:47:06 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999611b043sm73665515e9.12.2026.08.16.07.47.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:47:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/56] hw/ppc/pnv_xscom: Use qdev_is_realized()
Date: Sun, 16 Aug 2026 16:45:08 +0200
Message-ID: <20260816144556.69009-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ixbPm3E8CFPtSJ1OGVNaDM99bQ2LdTEd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX0SxJqagSEoiB
 n9TOSik1GxlxeFIcGCvIoW4s42+wj0Vt0bzZuv6WiLjcmwETYUFEyiIX+ykfNBsoe9qWjphS4e7
 C2Dywi/pU2b/AjKcp84X+/FWdeHQqUE=
X-Proofpoint-GUID: ixbPm3E8CFPtSJ1OGVNaDM99bQ2LdTEd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX9uShXWQyJhME
 BkhWX++0XIUzqOiccQ9p0CGz1D9LHfeoZquH0pfWoltvgC+YVAOjQRPXvk43AcOlq7k2+KuNqLh
 Zom9lrk5jx60LF8aJNj4mBsa0S+eSfjsoHGNQPeZ9u7DRHMcFIwyPEvcKKVHw3k7xdfbEMWf7KC
 xtKRYvQ3n6XxgsxJgsOxVjaZaNAEpEDxWj3EuGoH0Q7UdsBs1zjCsEALurJ7htH77VDElYF6Q7W
 9ercN5Ez3yuHnpym7lLOiMkw/zg/30Cis8SeR5GBxVKolxyq3rRFkwySpn0ckjC5hp/6HBaCfnW
 ZKobtxGHeq4gnS+gJd+rGB814kpuOAAOSb8fKAH1YMKtOFZGVKPu94qqcZBmStO8fAd2vGiXLGx
 UdIkdqroPZyWmkfGUwDacF/LaNxQyDqWu6RNT/RVGzB5eJCTvdXUAyeggX5HF/ipaOfozW28M1Y
 5Z+rtKbvH69uBueayrg==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a81cd6b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=uRxLgUfnyXHAhkBXUOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

DeviceState fields should be accessed through qdev helpers rather than
directly. Use qdev_is_realized() instead of reading
DeviceState::realized directly.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260721-qdev-v3-8-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/ppc/pnv_xscom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index dc1ffc6c014..7af722584e2 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -253,7 +253,7 @@ static int xscom_dt_child(Object *child, void *opaque)
         /*
          * Only "realized" devices should be configured in the DT
          */
-        if (xc->dt_xscom && DEVICE(child)->realized) {
+        if (xc->dt_xscom && qdev_is_realized(DEVICE(child))) {
             _FDT((xc->dt_xscom(xd, args->fdt, args->xscom_offset)));
         }
     }
-- 
2.53.0


