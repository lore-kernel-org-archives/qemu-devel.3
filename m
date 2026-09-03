Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C7AC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24tW-0002FM-TC; Thu, 03 Sep 2026 06:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24tU-00022i-Qz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24tS-0006oL-Lb
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:08 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHKFK055418
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LaNrput5HtIAIsWU9/zzKncb0OXi/vfI9KgofgDlVGY=; b=KFScd1TheCn0renZ
 6zZAigXub0XL/KvbQiJ1PZ5VrwA9s1yPL7bCUTXZ96f2NaF/RwRlxMRyrvPf12s1
 2Ear50Czr3meXI+OSrd/IrzROw/hikOhStbQ8lND8LUk4WRY0xZ1ZeFtoCWEGctj
 UmJGCB+98vjEM3A8AIRd8/XJPvcLQcTr7XI6v2pyIrZIJgD6I0GJg3tKw2Ekh5Nj
 yAUvp7ilHNafK3gciTIqig0TcFbg9n2Xv2zAimKhAgzt+Lk0y6JtWz6DEe52Ss/b
 3v9iu2t9/h5D3azc3Gw2JX44TdBkgZh0CN7AkEhd3G/dBiQshel92dCjB6ppUwI2
 NhcyPg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdvgs9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:42:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so165935585a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432125; x=1789036925; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LaNrput5HtIAIsWU9/zzKncb0OXi/vfI9KgofgDlVGY=;
 b=J1rDvTewqPWJHQyxT0O3XJwOTjqMtdkNOPjJDBMw9VUG/kEx5WkWlK4vbPKcqhvruI
 Sj16PSaDM4nEaNKvuhJ5N+zzpgo7+ig0GlefDMBbkbM7DEi70Ro4WikJgvTUiAtwEbr5
 Z4u6Kmn+tlouLPLtVsK34lcuW4VQm9chOeHC6N6iFJgiH8unvro7poruk80UUH4Q85qK
 7w15RgaATWiBIYDf9GE+fPoIqL8YaXToLUCIkSIE9x45cznY0Kh71sc+w4UfA24NH2rN
 gocig0QIPKc4xt2GtK48/sPt7pwrpy8r9T/hoZ0Yd4WA80JlmnnyypWO7Iy2gQLTe4oW
 KwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432125; x=1789036925;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LaNrput5HtIAIsWU9/zzKncb0OXi/vfI9KgofgDlVGY=;
 b=K0BfNFqkYMp45AdlMbILEcQlDKbozxH+Y36xqEs/mRYQZAfCeDDuopvcmP4Z+Tism3
 szNTH2p9rzBB0hnzRRu8rbRrT66BrYstHQN4zIBToiFNdoVD2clcJUY22/okXAN64MNm
 1wYdi1YPKgfnXvb8H6VkbUW3o07eupM+H8ssoPx5aM5li8biqbra/NgcAmB7iVWEY3GH
 V73e4Q/Cjy8kBSYSy3Yn4EJpCpmdSc5eEQdklrpiZotB4MCDnxDYmdh3JpzzrEAfU4Le
 f+ma+v5xtM4a0/jQyjRoyOvQnNHsQ+n7V8ly/TiRaF6UXbLsXwFZ19AKbVyPKI9hk9cO
 oqBA==
X-Gm-Message-State: AFuF++kaxN5v7RkuweizFplybvY+0kq6iAzcfo1cR0zLjtdTan1cium7
 FOUMXWtvBvdwccr9DvMdskt+/qUiypy93zx+vu7F87yGEfJ4iQMrL46fKLHO3FtLp5ITPzt4yNA
 Y3yb+cNfgmjjo913k2z38EZyXy3KrT3xjWF3nXa49bC0A0b02YY5q4pUQ3NMMjd7OOQ==
X-Gm-Gg: AYBFou1qKBjlJQrmWslcPiPIbjEvu09Vy2RS5RBBiNaPLOgXovIvslzupATkmfENV82
 f70SBE6J8opd75VHC0V5f5XNTw+cs3pTThdp2Xilo3casilM0oppvWjI//lhjdVYgRhy9e5j+H3
 Fd2J0AoRiVc/qrHmKVcICl+iIko6PVx63fZXRK+MIRH45QMntnP5OqDzswRxn2nj5kVhSNWs+Hi
 p2k4cdLlUCcruJ3SPWiCqaXiFR0sUDBccIallVlZRTLTCXbcF8IZf7eMhjratGXZRUsnRSUFuFP
 XB5uAl/mmOAbTZfE9uoOtkludLEU27b4ZLDctemcLF2dWcs4p4lsjf3JzNfeGjps7sBJgfg9F04
 HOt4r4uvkcCT00yCdHyAQ5I8ibM04mVEKbjdHbk2y
X-Received: by 2002:a05:620a:7112:b0:939:4890:98f6 with SMTP id
 af79cd13be357-93960f18106mr1328827885a.22.1788432125045; 
 Thu, 03 Sep 2026 03:42:05 -0700 (PDT)
X-Received: by 2002:a05:620a:7112:b0:939:4890:98f6 with SMTP id
 af79cd13be357-93960f18106mr1328824285a.22.1788432124549; 
 Thu, 03 Sep 2026 03:42:04 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5dadddsm70598645e9.9.2026.09.03.03.42.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:42:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/51] target/i386: Remove const qualifier in ptw_setl*()
Date: Thu,  3 Sep 2026 12:39:04 +0200
Message-ID: <20260903103936.62355-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a994efd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=6zyGMrF3NIoAil_mprYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 7121vG-S-SdcWGAkQ7_TxRnWyIrR92sc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX6AlVMRfUADZh
 x7AzPPmZnOkIWtTNz+dpTBWIpKcdaddYjObMct1aA1TJm0z4qRdZ0yqJ6pRNajNJSKWislo+qGP
 gFTbqwKdkH5q858GU60U5px600vaX7QJccDVDcBnOsxnzZVHTd065eLDFCS6G7ZiWmy7LDap63q
 6y3p1NYUeX2U93Qw8X12uMXq7Ce8H1aJVGHVMxEDT9lkcYIIRRy4lvGYWFbm55OY6GXIvYYg/Ac
 /pVhRl+ZHwbjXht//3kkMFxXkX4EqX9ITKY5AWdEFqyHrBE+95+epedJgLajVkIjjv0+XVUPkYM
 NEfGG+umgLajNBcD1Anzw+0UsjA/Ijq5k56OGcTYgAl1jJQQtzjjFHBeMKKjfope4YivtyYUmWU
 XstkJGnq5R0CX4Z+0/HTVG9iY/2U1doHy1jx0uBuPFYsQNZIP1sTBJhh3vYt7jMuwRdiYnAuptv
 QfKvjOuXGasvNyc1U2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXzIT4wXE0HZlJ
 kRtBzWsQXXiAnLyRgdHzd1cGnP+r1t8RcwnZ+R4o6WYoYSW3wwZVU+UWwGsTjq1+hgxNxXz0rTk
 HxjgFlRFGcjVcwpGrdZYypJS0gg/EKw=
X-Proofpoint-ORIG-GUID: 7121vG-S-SdcWGAkQ7_TxRnWyIrR92sc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

Both cpu_exec_start() and cpu_exec_end() take a non-const CPUState
argument, however here we get that argument via PTETranslate::env
so @in->env can not be const. Remove the const qualifier.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-Id: <20260901095229.72018-2-philmd@oss.qualcomm.com>
---
 target/i386/tcg/system/excp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index d7ea77c8558..44be98a3c92 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -106,7 +106,7 @@ static inline uint64_t ptw_ldq(const PTETranslate *in, uint64_t ra)
  * even 64-bit ones, because PG_PRESENT_MASK, PG_ACCESSED_MASK and
  * PG_DIRTY_MASK are all in the low 32 bits.
  */
-static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
+static bool ptw_setl_slow(PTETranslate *in, uint32_t old, uint32_t new)
 {
     uint32_t cmp;
 
@@ -125,7 +125,7 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
     return cmp == old;
 }
 
-static inline bool ptw_setl(const PTETranslate *in, uint32_t old, uint32_t set)
+static inline bool ptw_setl(PTETranslate *in, uint32_t old, uint32_t set)
 {
     if (set & ~old) {
         uint32_t new = old | set;
-- 
2.53.0


