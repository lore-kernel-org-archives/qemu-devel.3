Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6A4C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn9ax-00022w-Bn; Fri, 24 Jul 2026 02:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn9at-00022P-T6
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:41:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn9ar-0004mf-Tz
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:41:15 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4lNX62138098
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E0oae8mOGeheFWO/OO7cajGlB0EjqWN3FElajavxSJY=; b=d8o06Utv2LK6YsN8
 lBtSTQnm36f7w2/zmRLZ6fqjZQyUtnPOy8b3xTDDCcvq3cmMhYInc84zL5JOA1Ua
 ZO+sQWIKQ3VkqgSVvtSxnNI/hAA37gi0B7dVKFPsreD5mRkO5v84KddmXDPTIsdC
 ABB3sAKKKFUN7mtAhUihAA2XiFlW+nJ/2aYWxWpnIAbc7l4mCdevwKsZ04yZaYDr
 rlLobEW23dYT4xDloGAcFQC+sJY83CFYBCeqMvPdk9AlMGFEpRR31tvfDySNq+k6
 n9fSNaJgPeZIuBS3ODTxe/kB4LhMjuRbmplqHoTp8hLwsyk1K4O8RqpLZ3CywLx7
 PVYkBw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa1ag5j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:41:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c19493ac2so1889611cf.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 23:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784875271; x=1785480071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E0oae8mOGeheFWO/OO7cajGlB0EjqWN3FElajavxSJY=;
 b=iBTVU6euFCCYoHHOMmGct70Ip6Epm4ucR8KQNF1m6PYfjf6F/nEYWt11xHrUeYRLoJ
 kthlItviDb6YETLx8Pg3FbmMWPfNj5p1w7r6QP8rA97huM/OvAA4UvBmT6ZVxrycFGvY
 WopLkjAv4kd9wOSeFbX93svCYE+DxqwelvdNLP0OuuY+8pwqo+fkQ+Y1EB5lnE5tLHY9
 kHHyCy65GtV73qeVyTgknMcUln1q4V0i9JI+oNCnCv3sn+zAHzeLki7wOuWZh1y8NWiO
 4tSO/DXMyPXqJ+VuiEjxDtMU7ykU2wLUGdUGT2oI0PaeEToUTo7/Cm3LGd7If9pJKJ02
 V7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784875271; x=1785480071;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E0oae8mOGeheFWO/OO7cajGlB0EjqWN3FElajavxSJY=;
 b=IKmE6YjDHB5Ycap1ml0CGHL8C9MJ26glm9YMWVPjNzkRNbW2KcpNX/Xu8o3Uu7Xbi6
 LbCgXD4gWItV8QC0nfYhnIoGp6V9FPiFzcba6H9XQjTKXhO+JYjIpfrFzyCHdhzZaNC+
 cWn+BBx1yis01xDHJVGfNTtvPwAT0eGb7e0O228/MdzX57susdJKJVpa7qz+PpJGn58d
 XLaNvIL7YCn8acTDXAq2nnske4Nq4LDUcR+pZ3WQ4iCLy5bC0oxyLV+zHyp89kWV1JDb
 UXcCkvEXqtw+aygQdVS4yINHVPA7WNyIrVcXLHhnFXby8sIpSYygrB5Gjp8w2x/mKHST
 4jLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkfHamDtdkTVrNaNSdO6vgfm8T4oqESEe51soKMC7iQUnB47smrzNylmB4q/QmD97hapq/YsDae8vj@nongnu.org
X-Gm-Message-State: AOJu0YwKO+1pM1e5R2njANEnkQPWCM7YfIwGsd+2O8QzkxLz3MFQsiWO
 9BfGHovOqyUEFGEN644nh54cyEGz7THFuyVOK307GY8RxSFG0gen123kC49BXTmS2ZMAOsqlHZ1
 oF7mXiJe7nS6kB3tfzNxDKxMtilYu+pizQyexYxhn5a8+BeDYWnNLIdlYSg==
X-Gm-Gg: AR+sD11tEFUMasoQTZsO4KwlAtgT0uUDbzXOsXNPGv/TvoK6p8CSzD6Wkru0k54jMmB
 egRdPWBnA/48xyg4Y3bq0UBLKQJuuiM5Nfenou1rjxyqz7VxXeYTl05HxHf85E+5HXtbkqaeXpr
 HIMkH47i619hT6lr1yX/ZVnIxENBo7y3UbgdqS3EK1wbkTm+LttnAiNmO5upUkANfgcKcOMHO6E
 Zfu95EVLKILHv697+x8iABCs4VnUR14NGlenXX5XVyoz2Us4ddOpwe2PD97YNrWMACZ39tsbz18
 ZQOPd961jqWAsQBReeu/GOvALE3wD1hW6wQlBWNyibaUR6+I0tNL9/Fr4AOuXapJ1brD6jAU6TS
 Vd+JXtM29AnrGYpV2PqE2j6W7teo=
X-Received: by 2002:ac8:7f15:0:b0:527:631:8d6 with SMTP id
 d75a77b69052e-5283ddf74f9mr58785631cf.25.1784875271231; 
 Thu, 23 Jul 2026 23:41:11 -0700 (PDT)
X-Received: by 2002:ac8:7f15:0:b0:527:631:8d6 with SMTP id
 d75a77b69052e-5283ddf74f9mr58785361cf.25.1784875270730; 
 Thu, 23 Jul 2026 23:41:10 -0700 (PDT)
Received: from [192.168.1.138] ([176.176.154.185])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af16f72sm50774395e9.0.2026.07.23.23.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 23:41:09 -0700 (PDT)
Message-ID: <6b53caa0-023e-414e-9caa-dbc5155674bd@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 08:41:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1 1/3] dmg: fix out-of-bounds load in
 search_chunk() (CVE-2026-65929)
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, boy juju <agx1657748706@gmail.com>,
 Tristan Madani <tristan@talencesecurity.com>
References: <20260723144519.364701-1-stefanha@redhat.com>
 <20260723144519.364701-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723144519.364701-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JVQ1T4ZHc-Es9vmXq4V1W7_w2BaLzFvC
X-Authority-Analysis: v=2.4 cv=L4wtheT8 c=1 sm=1 tr=0 ts=6a630908 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=uVRRv9AK2fddTnT+2a2/4A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=J_-Nd1mkAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=DOaHdC7foVEXiuO_FjAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1OCBTYWx0ZWRfX+AVsjqlxXVHX
 Q76U+tmhMG2Q7LtZ5UFDcy7gTPGYdI1Jd8YRJ9UdzYgXkE0T6WVmTDHTTtBQgdKaP1rL9wjO6ZX
 FZgOyU3ihPPDAOo6FjLhZYuBMWwwUF4xtVQM4wZL0JERpGNjbRL4nn2WUFZQp0Mf99GCf2HMzbK
 mJoCnzXmnZ1ufMNy/U2zz0arIJLO5ygxH1NJI0hTHHDsYcInaIlAC/P056qd6HIicxIESEGw0Mt
 HnuO5jul3XAmZX/NdCspkeyzsNeMjml/j2aelTHZavGbdv4YbsfZ68mTY9nNXasN/ygmIH051OF
 jiVJ9nUkRlJmJ6zKZJXYd9eT8m/bDbHFjsTGoNSOHYr87T3RtUmY5QtyhgZyHE7cVsvShthBtJu
 WBHGb8+I/27wLHLm3zxcGsRLAz8wr0BsQfYtipkSGjlNJ+z1R2X6L0apidjdP6bxVJIrnI4NUMj
 MyH4mqLCGFDJkB4hLfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1OCBTYWx0ZWRfXxnMU+ASpel4u
 I58aQPbkC4iVP9R9TkeNP6GjEye23Bj2WmUDdZsWg4WdtA7h+RNxsB24G6FMK2ytH7EP6V9MWQr
 Y1NTuD3cYe4rp+/98yBEBoW2/qcgwo8=
X-Proofpoint-GUID: JVQ1T4ZHc-Es9vmXq4V1W7_w2BaLzFvC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240058
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

On 23/7/26 16:45, Stefan Hajnoczi wrote:
> The binary search in search_chunk() uses s->n_chunks as the (inclusive)
> upper bound. Chunk indices are in the right-open interval [0,
> s->n_chunks) so it is wrong to search all the way up to s->n_chunks
> rather than s->n_chunks - 1.
> 
> The worst case security scenario I can see is convincing a victim to
> hotplug a malicious DMG file to a running guest, potentially causing
> QEMU to crash when loading from memory beyond the end of s->sectors[] or
> s->sectorscounts[]. This could be a denial of service.
> 
> Fixes: CVE-2026-65929
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3844
> Reported-by: boy juju <agx1657748706@gmail.com>
> Reported-by: Tristan Madani <tristan@talencesecurity.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   block/dmg.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/dmg.c b/block/dmg.c
> index 33dcb3a3498..e325127d144 100644
> --- a/block/dmg.c
> +++ b/block/dmg.c
> @@ -609,7 +609,10 @@ static inline int is_sector_in_chunk(BDRVDMGState *s,
>   static inline uint32_t search_chunk(BDRVDMGState *s, uint64_t sector_num)
>   {
>       /* binary search */
> -    uint32_t chunk1 = 0, chunk2 = s->n_chunks, chunk3;
> +    uint32_t chunk1 = 0, chunk2 = s->n_chunks - 1, chunk3;
> +    if (s->n_chunks == 0) {
> +        goto err; /* should never happen */
> +    }
>       while (chunk1 <= chunk2) {
>           chunk3 = (chunk1 + chunk2) / 2;
>           if (s->sectors[chunk3] > sector_num) {

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Alternatively avoiding the assignations:

-- >8 --
diff --git a/block/dmg.c b/block/dmg.c
index 33dcb3a3498..85edfae145b 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -609,8 +609,12 @@ static inline int is_sector_in_chunk(BDRVDMGState *s,
  static inline uint32_t search_chunk(BDRVDMGState *s, uint64_t sector_num)
  {
      /* binary search */
-    uint32_t chunk1 = 0, chunk2 = s->n_chunks, chunk3;
-    while (chunk1 <= chunk2) {
+    uint32_t chunk1, chunk2, chunk3;
+
+    if (s->n_chunks == 0) {
+        goto err; /* should never happen */
+    }
+    for (chunk1 = 0, chunk2 = s->n_chunks - 1; chunk1 <= chunk2; ) {
          chunk3 = (chunk1 + chunk2) / 2;
          if (s->sectors[chunk3] > sector_num) {
              if (chunk3 == 0) {
---

