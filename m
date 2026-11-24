Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29A606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ffrekm/1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jk2mWwdd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzf2-0001af-6T; Tue, 24 Nov 2026 18:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzey-0001LT-3z
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzew-0005D1-CZ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:47 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMamIU2140061
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qwdslF0vVUstngm6dnE3eJECQEl/HoretCvPXIweB90=; b=Ffrekm/1H68zSm+s
 r15fYvdjpt5WTuku2cRiG9OY7v0QQsLNOAAamj5pmkCxlskQL5JpA7zk/OG5g/Sf
 4aNHkEAXn29iAWQZMDiCVX21vVmyvcvbnfafBtofZh6lI85VWT8Ih4gzNbyuF//v
 ghZPraPFwymYGCr6q+cKV41Qd7Jy1Ph3rUvHCnpOS6aOPGGnzBanV1T+YgFDjbMd
 dzyO7W8vIO5adIxuWuDBBkr9BfoIOaD1AtPNvcQp+JpL91QYCkx0Nmbq2PJpGDVB
 mI4Yc8JRmx1DIg9L9ew5yUchF+MmxRNbsXW/tLZYEt1nF9jUthBiOW/UmNy1mymu
 5vOXbw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gns8r15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f26dd2165so1267160985a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561844; x=1796166644; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qwdslF0vVUstngm6dnE3eJECQEl/HoretCvPXIweB90=;
 b=jk2mWwddT4f4rsXmJjhaDe7PSIw8vw/U1Z+OvoZ6FAi+k8HT44P2CmI3qItIQExTSK
 FGS1N3NbCdHHsn3w/JrOxmPy4YB4GFnf33DmJcHCd4hd0q3Mkh2A7yedWibfEWxS9wA2
 ude5yYKbyfK+B0fLcVJS99dDaugmh+CIh7BEVUQOQQLRtlI58fRPPqR4EOj4+G7UCLde
 Bmmi+g5vdnprx4UKbaiGK0M0TQu1b1qRV6iTIPvLKNdk2anyhTH3i62BvIfEfs2wSGKv
 MMs5lboSUYGBlM5eD/BEzI84y+RmsskSKx190ebdMgFOPaDlxfjeeclEjjHThjwNid1g
 GAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561844; x=1796166644;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qwdslF0vVUstngm6dnE3eJECQEl/HoretCvPXIweB90=;
 b=g4BKL+NEwDNCRoZVoLzgNLItSCCQcmM3lnJLKeFNC5FpM5dAQ8GnqUIrTODt//hkGW
 9oCWWh7NcaAqwatvF8tys6k0+Rw9VI/j2aNKHPL3lX0nZQsQ0c5Tixwpug+GLyasmDSA
 /lwP1w1JfYzyqBJcIxNvBLMg/TOudvDoFnkmOxllkxwC4CQwXsJQKPfnYkIU6HCeAkrF
 pkGzmPFyfRV1huv4UoFVJrdQRGcdW6r4flqV3Wb/5JCof6zKIa0fLWRxI54vezj/20AH
 7ipLAnY0NDJfv6/Jg0OXOCLxesMnAtbdr4WHzQea8QI6OP6C6g4maEuVJwxu6COrsOEo
 9USA==
X-Gm-Message-State: APuU4Z/jC1AL8+k7vjdG/vqTeJccZBXrhcuQDQt05NkTdx6ioy8R6QDv
 pQzwznIXxG+TX6R4ZikRBQAG3aOUfgv9gqst5lh3tmpsFTO22Dh4eFwJq4gxAkjNRn45snPvuR1
 YY667Wz/IsPtNp0mKbofwuq5RMMeQ/fRQh+OEOj6EqqQLFJugTyU2YM9mzaZyC6F3rkaj
X-Gm-Gg: AZFdTZcjYVk5Ni/C4hixzd0/lRxOMle1+9IBMKudTuHqCnf6taIjAk7tMjie7R59cco
 CvPBjg3BWoAqj2jAistUuDg2hwaZhLOwFO1rnkwQudw89iNFf4nbKD2k1NsoBSHL4KlyHEQSIy1
 GDwviLxsCEy3EmlRRse2QgXz0IOK2lY62b84Fck2cNTDV/tCnAN06C8Fdwi1QIju4FJQMN5yLiK
 jeGxnSSxwj7CWKHe/D4LZAE5aLhNFGKYHXQxGRd0+W3EWTWvPw/Ri8IoK9whf/qfLuVbHAeS2+T
 etp1rBByJ0lCj7rq5WH9H2HpNpxClcJGrAlBYWIAT5plT/93WC6QjXI7wrtDodqi/UpMgnUhcN6
 gK0AwtYNPFZy3+rZpwedLK+zE8ZXgyWlUBZUHfHUpQc8j93zku84OVMcRdNsYuqeEHkscdjljSh
 /RJzcgsJAHb0Pmog==
X-Received: by 2002:a05:620a:1a20:b0:936:ab1f:6aa4 with SMTP id
 af79cd13be357-949ba8482a7mr2812686385a.1.1795561843862; 
 Tue, 24 Nov 2026 15:10:43 -0800 (PST)
X-Received: by 2002:a05:620a:1a20:b0:936:ab1f:6aa4 with SMTP id
 af79cd13be357-949ba8482a7mr2812681885a.1.1795561843361; 
 Tue, 24 Nov 2026 15:10:43 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm866248165e9.4.2026.11.24.15.10.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:10:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/17] hw/dma/i8257: Honor the command register group-disable
 bit
Date: Wed, 25 Nov 2026 00:09:12 +0100
Message-ID: <20261124230917.88704-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tOOENmRKmVzcpFmVFqL61QQfZT_rjFgr
X-Authority-Analysis: v=2.4 cv=G+SJgNk5 c=1 sm=1 tr=0 ts=6b061974 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=pcZqCyVeAAAA:8 a=XsIHFW3MbSe0Gcz3ytYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfXyDfRBD7JqC1b
 aXCk9fOXAnhmyzN0tu518rk5/OgaRzI3uiBypdiBIuzjY0AGGUfoPYt/OWxmo3pHPhrHYNdKhZK
 J91mYwp/E1UsWwIVL6W2wk3t1Et86EU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX05tOJmS9INho
 RFE8gi5cZf2rt/NIDJFRAwX4n8FPGpMl2VFNOPycDwMK3Q35qfUTJum2Ej4m+2H5YpWjGKnf3SL
 kVo+Zc34CGx3hSsuF5VpWMSzemSfL6W9BMvP3jafLdr5PGsg5sQ3WwSzAzoYAOYgnjyfW5ZiMC5
 3PCxAsDhBINREQrA8est4jXXeriZi+x6Sa/Z6/H8dnCGQqLkfLfcp29BHK0NgiLInqa9uH0rjag
 JvCmTUI9jy807OskMg4TtaMf/KQ+fLiHydntpYokct0oVy6HI2WbYsdqDRWAkX+AfeUl1eti+1q
 VrHeRukNiGXwJa4FnX+JjzR5TbqlXvn3Hz5qw3VKUaRz02LzuWeycb3XvtBSFdGWrTtOBQJ5Ooq
 vzHoUGAjbR/8+yuZok3JogH3JbFxgJ7GK7Wr5ilk5Tl6LCIV7hBL4NJ3q3cQF2FCNttQ0Is4h28
 Yo1R3IjTnSl6crfZDQw==
X-Proofpoint-ORIG-GUID: tOOENmRKmVzcpFmVFqL61QQfZT_rjFgr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240091
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Command bit 2 of the 82C37-compatible DMA controller disables
the channel group (PIIX3 datasheet, section 2.5.1.1). The model
accepted but ignored it.
Gate servicing on that bit and re-run the engine after a command
write so re-enabling resumes pending requests.

Fixes: 275033239681 ("Soundblaster 16 support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20261119220838.52034-4-philmd@oss.qualcomm.com>
---
 hw/dma/i8257.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index f44632de3db0..8ff4cbf4972a 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -195,6 +195,8 @@ static void i8257_write_cont(void *opaque, hwaddr nport, uint64_t data,
             return;
         }
         d->command = data;
+        /* A pending request may be serviced once the group is enabled. */
+        i8257_dma_run(d);
         break;
 
     case 0x01:
@@ -354,6 +356,11 @@ static void i8257_dma_run(void *opaque)
     int ichan;
     int rearm = 0;
 
+    /* DCOM bit 2 disables the channel group. */
+    if (d->command & CMD_BLOCK_CONTROLLER) {
+        return;
+    }
+
     if (d->running) {
         rearm = 1;
         goto out;
-- 
2.55.0


