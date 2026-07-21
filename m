Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E91FC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7uJ-0006ka-RR; Tue, 21 Jul 2026 06:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7uH-0006Yp-Br
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:41:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7uF-0003I5-PD
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:41:01 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LART6k1230186
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TWY33JP8u+UOt+0zjsff3m8HKZN6QdP92OszQGz9q94=; b=YRgFnh4iYuHrEMoy
 PNVJtDvkleDwy59X337LFCKhHMSk4+8+i/KtLZv+jeo6zmaWVstXSs4Ziu6tHryj
 L6dySYB/rw+pD7/767Djna2CByCEpqV5BUzWao23g7LgG83GQpKrxDHb9pt/nY/B
 103oy5oM2/szmS4+Fte20qK2gHCJUs5kswERILh1fJ9FAR0+9Bks53Gf6s+njArR
 XcVf8xcN+i2vNZgPf4f2Vzmk5xp1JAnurt+8kOUAPe/fxIgMnvowO7odMMFIINX6
 LdQiuDbzX1i7WhsqKkxcIGcRvoRoOang7YzrjOULkngRpPL7mqJLJL5anwFCkfXh
 VDcqtg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj01aa4en-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso228785281cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784630457; x=1785235257; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TWY33JP8u+UOt+0zjsff3m8HKZN6QdP92OszQGz9q94=;
 b=fKMLGwkPQvMpyFglg8whw0SECg2STqaSlvuw3G9F9PX82LL86xLnZdPeND+UtAuDNg
 EQSYr2wog/s22JBUvCWdaRvJqjVXDimRymDspQS4aztJwiP9ilV5VXTOUYV5oN8mRjhU
 j0JSHNQpBu4f+FUHyaI9S939XlLRRnqtsFcPjW5CT1mKnOpmaZfxNTPlf7R4TdC4bZs7
 0HfzxrQcnYDbDW9qQfl1MG7wamAdCzfI74rYUNtgTG8qO9sQftvnoPettvQl2km0deYc
 QrJMFOdRRn+PdG4Ym+FFcLKsuw6btZrD4OP1woHsC+Zm0iaVR4gJ0XO7H5KxtR/Nosc9
 rUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784630457; x=1785235257;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TWY33JP8u+UOt+0zjsff3m8HKZN6QdP92OszQGz9q94=;
 b=kuMwzX2FlvQHpiqvyOl+d48Wd4yLtHCisEHSA3CRAD1byK2hlsctcn8yfgNL4SP0CV
 VMbbGkTRM3NXyp+GJDYNDeSYC+ASe2XhNZPvdj1v+EkzLV9PEYeqEjo/TsP8qQTN5y9O
 rLFfhSpbdGwqM+AOGC2l/1r2oEJlr8B36Zjgn8+FOc/Q5eS2Hy9Sq/gDYlE4y0oHSQv7
 zChwhAGVzVasKRS4JEUf3mR2X8CnHS3J2qQLdU9flA2oOoVFE7m0QWFtrINdc0H3pgo4
 uLTzYd4t0Fg/XGATiSTP75BhZw/rwn1DnrPzNpByAlsxzeSc1+gwYR1D1w0uyYYLjuA8
 sKKA==
X-Gm-Message-State: AOJu0Yz6yL+sPD1tLRkPrgwy2aNjEkn94Z7PyI+i/93aC2dUHgcL7ten
 McNRBmYlitbV/bFamXZdEEdaxL3JDXvYwQZt/sWswfzaOZVlE/9E/0SkFUDlInTxxDf8/I2ReM4
 30NddqyNPO9cpnXvzykzTmWiO173eRA93dZ1cA1cyoR77SCWkyhe+olDG55yeYNg0VA==
X-Gm-Gg: AfdE7cnz0mF057ACIwFz/MPUpjgGy2yt5pUjSTyDQON10t46tVAbgOOH+/+w6RWJ3rY
 ZWU7C0i+mBR4EJxj3Yk8IP8pDi0V9HtqmtIwEhsb+hpd9qjkAChN5wGzrRWGGdWrPWrqblm7mff
 K0gl/8qIucpkF/+2Lpd4Ub1MyhWmlqzD5pGCqWbwLsJxt7WaX0Fa10fcH4GFpVv9r/A59YtSUSv
 war1k7u9QDMw2CEW6cDTRGp2ePwV0Gydmn/ZSKui+PBJbuKabW5kpId9zvEOU8HhWQkNxvtomNH
 XAsFe1RUO0TA5FOW3KC4i9Vde/BBWhtIMYaj6XNI9q6eKE6ryr3nMEvUF0IL6B1WLHbgrNRg0Xy
 jljSmS6zHxLfYL17cDBqxcybiVt4DGJ6JOrM2X/Z1ivts0s7HikJuNA95Qg==
X-Received: by 2002:ac8:5a04:0:b0:519:f420:d780 with SMTP id
 d75a77b69052e-5213c7e64a6mr160939101cf.30.1784630456698; 
 Tue, 21 Jul 2026 03:40:56 -0700 (PDT)
X-Received: by 2002:ac8:5a04:0:b0:519:f420:d780 with SMTP id
 d75a77b69052e-5213c7e64a6mr160938961cf.30.1784630456213; 
 Tue, 21 Jul 2026 03:40:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49563eee22esm89834425e9.1.2026.07.21.03.40.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 03:40:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] hw/sd/sdcard: Fix error case for CMD18
Date: Tue, 21 Jul 2026 12:40:02 +0200
Message-ID: <20260721104004.84934-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721104004.84934-1-philmd@oss.qualcomm.com>
References: <20260721104004.84934-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BL6DalQG c=1 sm=1 tr=0 ts=6a5f4cb9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=K2pyRKyQTF4BWjdTM1gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfXwCLk/sobtC60
 eVY1Du/6snQuBtjtSFHTnuNV2nfQ67O06oE7lnqQI3xTHmysXktxmWuC0C/5qN2SltjguOeNxtM
 6vHwdQ7BX0DxL7dCGT+O+Bxh0bU0JtMFTlrY+Nwj4jOQPAysCKGHMA9o2YzgTF5rp/uHSfrtcIa
 /L2BL9LWXL7zsNfqLlPSjs6dLO42vvQIcHlwhOCpQHdwuy6Uu+0t9tRjkChr4fTIME4Gak9KHKa
 gBGCQyBN/kY4wAwr8WecKXac2SJCmAXGyuVeoHdS779JEO7+G/Aaz8hpxD+BE98p01M6Or4YUk/
 nSEfoNDAaygYJJbOdEnms0m+YULSMwYl9Y2A/04+K/0PAhjIGHYg96Tbnz6wigWoRwA5sPr0slQ
 +FYSl3cF6DMrqILQiKHOG0ntv+b8iC3ecr5Z0cOT4FcneIO1IiudOEj9Oqh/zzwle4QTXNheKzF
 JYsTMy3lxGi3WcAzeqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfXz6RPWi9XdqUq
 VOkH7u6Eh/9GnpqWD11N84YfQInNdBbin8W/+ITLnHRUSBaYFntbDRShNqBoupPr6u2e+6vKL4K
 T/IRWykirKHtE4x+kSJ+7K8on1asLA8=
X-Proofpoint-ORIG-GUID: -A5JQEjkqq0xEtot8Sq4_NhBuBlXpqOG
X-Proofpoint-GUID: -A5JQEjkqq0xEtot8Sq4_NhBuBlXpqOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210112
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

From: Bernhard Beschow <shentey@gmail.com>

In commit 468fa450a7e0 ("hw/sd: Switch read/write primitive to
buf+len"), `sd_read_byte()` changed its contract to return the read size
rather than the read value (and was renamed to `sd_read_data()`
accordingly). In an error case, however, `sd_read_data()` returns 0 by
means of `dummy_byte` which is the code for the old contract. Moreover,
`sdbus_read_data()` asserts the virtual method `read_data()` (and thus
`sd_read_data()`) to return a non-zero size, i.e. to make progress and
not loop forever. Fix the code to behave like the "DAT read illegal for
command" case.

Fixes: 468fa450a7e0 ("hw/sd: Switch read/write primitive to buf+len")
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260720201133.24796-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 33607570043..a30c541df07 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2860,7 +2860,8 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
                                   sd->data_start, io_len)) {
-                return dummy_byte;
+                *value = dummy_byte;
+                return length;
             }
             partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
                     & EXT_CSD_PART_CONFIG_ACC_MASK;
-- 
2.53.0


