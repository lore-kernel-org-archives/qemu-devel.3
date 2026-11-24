Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D27C606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dJiUefOU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TKppJF4j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzfl-0002so-Ou; Tue, 24 Nov 2026 18:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzfh-0002Vc-Ad
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:11:33 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzfd-0005FQ-UT
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:11:32 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMaxAt2558281
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vMSeu2UAWiiyueiIYSXdvL8P++2nb9vcqo/Fdu9JRaE=; b=dJiUefOUFlxOMRzQ
 EHs3E8M2pLaq2RF3sHQUEQiBu5ESVEeJ2XkdxfFiKMwn7J66XBAKZ1El97+fEKxi
 /CExfA+W7H2vPTCq4b9xgFcA0z5arB3ywQfANsyPSnttbY6KL2oEwox3aQ7Nk15d
 M1RJlo+xQPnMUnnxJJenSFYGV2AAVQTKFEDc3BldGkJFFZBCX5CGK5Qrv82f6F4d
 B12TG40th++hMDa2VnmXr/xR0alESaVyueL22Y6IsggCIQUoBEkl5oB08ebs5pqs
 hsS2z1nJ9/dfAyHnMshfQnZ9fQOdbOxmWyiVyYbNZBiUHVbt4RcKGX99VtJoDaLn
 frUFQw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5dnghpts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:11:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f26dd2165so1267229085a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561872; x=1796166672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vMSeu2UAWiiyueiIYSXdvL8P++2nb9vcqo/Fdu9JRaE=;
 b=TKppJF4j0DuD0ffU3KA7z/wFic6UpLkegD6x8ftt9HbwnXoiDrNWRBPYH6z0RZRS9h
 BHxdgbyvTc0Uy+lGac1VG3r3lje5OZHUSIyw8Ft0RLELYVfKHt4+YfuLPiPvD8N0Xd5P
 uIUkhTE368pg0hcbpX31u85GS/yjMn7m0/UBRggVoy6aTAvvFnzp4kFk4BibH1rs2FZI
 jYOQZXV7tUcZiuKzT216ej28G2b/x9ijlFaIjS+0oaEK1CpsEMIjyG3W5sx/T7F72IQo
 zNZ5PtnzAdmnEAogoHkPL8zZldvnWldIsyrz7wcNXgjzfVD2wB3cVzkSmqdG62egaUMA
 H+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561872; x=1796166672;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vMSeu2UAWiiyueiIYSXdvL8P++2nb9vcqo/Fdu9JRaE=;
 b=ZpHU6A+r8KtVZKNdeP5I/VaXeI6Nx4Lr6MYvZKv0C+Vw4ZBuj4Ck1mnpo99AV7MUei
 H++q+HfM67CLo5++aVgCvltXCuKM6ny/KivYTLSUTapghX7wXqfa5ZmqDdo4fGnuYO73
 depvkN/+ZfMrbFE7w6m1VvzV3daA+YP7yozZeHLGOTL2zkKnOeVfoJ+E/4oBfkLkqWfl
 hpBxJqZz9pAXdc6ql2pZ+DaQ5qZTQm/YYDEZv4uaxlIQYpUgU2lAJyprAw/i2P7+nfi8
 Pk3fpMm32cKVeJtJMTpGP6mBbM4OsZqeTaozsvN8FyTr0g/VlLSVPTODrT1dK5m9QEkO
 hd0A==
X-Gm-Message-State: APuU4Z+ZzY+uFIHC9e1Dfw8eipqkiVeQ5wPZQ98dOsM5BFyvUrDZJiRr
 BPImq2iv9ZaXdo9vtY+L8LhSsLwm07XiaPxBKEErQeiyhcms7LNMekXFddRFVz768QDLLmf0plP
 qpExh02DrHvR0WutU7wgeKAUEQtd4fehSVxHDFKjCh43dI2TTicH90NG2HJdor+yhlBBQ
X-Gm-Gg: AZFdTZdbs38wNBTVcpxpVIQASvFH3tfw6lz1vVFFS2bNaw5/LP/P+cb5nu5iB/B1Wq/
 UqIaCr+e9MpQKrFA3lom2+LjS6fohV13EzQYmqptHs76a0DwxuUKVPA/7F/BsOT0F3R+OFBCP+5
 ST6bWGy1NPzjdcNt+PwCB+qkM92YwpG7zaVQfUpm2b5WrbxHo+QhSbxGt/uX8WTVl0etvuZISe/
 mb/q3Oe1aVZb+TiVHz/co/jUxJ2kWtERoFTAm20GwvRawCoxgQHCOlsKf3saxf+fGlO/QcBjHqE
 ULdCOiSJq0UmpyfFS0aDlzvNHqqPEqOwa8jXZDgo8mzaqdsLfiAlE42cqQMSxxTfo8erbNmejlm
 Sln/z/dMCJq2d9vxfWQza4EJwe8GBvXfgv1hZtisPu+M3/9/I5+KL/1y+AuZbZJGAGvggbBYQAG
 nyN5QyzJlqQJNxUA==
X-Received: by 2002:a05:620a:44c5:b0:949:a9b4:bd11 with SMTP id
 af79cd13be357-949bab4d986mr2862117985a.73.1795561872144; 
 Tue, 24 Nov 2026 15:11:12 -0800 (PST)
X-Received: by 2002:a05:620a:44c5:b0:949:a9b4:bd11 with SMTP id
 af79cd13be357-949bab4d986mr2862114785a.73.1795561871714; 
 Tue, 24 Nov 2026 15:11:11 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989e3sm30532905f8f.52.2026.11.24.15.11.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:11:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/17] hw/block/pflash_cfi02: Return to read-array mode on reset
Date: Wed, 25 Nov 2026 00:09:16 +0100
Message-ID: <20261124230917.88704-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX9QAsO2K30Iyq
 SG5/wDgUPNHGLZbocDRLXLVfwsqQVZE9sD3azCiixIKCQf0L/GZVo9S1z5bvtlvdyNAKruXq34W
 cz7CxLGc11WA5Koph3xl8Z7j/L0cWLw=
X-Proofpoint-ORIG-GUID: Ky4DJanauuDLkS7944mJGGCbGN_IqYOP
X-Proofpoint-GUID: Ky4DJanauuDLkS7944mJGGCbGN_IqYOP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfXwyGy15gsV7Hx
 UeHGIrl6PcDQg5fzdsEMr0JpzThIR9SrXiRC35+9g076B3Hz1TM4Dhm8KXYJFsEMknFqqJGbsLU
 sK9TtMNp/Kh+Ys70stRumFlue8K9ZWMaEIGmwJOm8dmjfhrpBCSGJ7DFoKHtd0pcRvfIZ6EisLQ
 dhXJqJl6g6ozFHjtZR8vrFm5unMQJ70xOQh+M6bRvpcmEovYqxmSIXckrYqtn3BUPgZkzsqupxF
 OvJfR6WhkzlAKqk+qT4uiReTtcoAulPyCD4yd6XkwzuLxBK2aPggOpFwH9CDZBf7GFIznoyRcf0
 AU+jjU4YnltXGVq592eqSG4OAL8xW0fgFB9MUqUF18Nkwlee4tpjEjfpeGyoy3Ezw0idI0LIwxG
 q+LlnioabhzL73tommmWN8jIHoJjhgikwklnz+C+vihdsTcP4vVgZQGC6QsiVOT2LyH6dsR+Ee5
 wDZZbyMh1QTDRPrNaSg==
X-Authority-Analysis: v=2.4 cv=U9cHnuru c=1 sm=1 tr=0 ts=6b061991 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=iy6SrHTh7oi1FSrcmkgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
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

Reset left the ROM device in MMIO mode when reset in a command
sequence, unlike pflash_cfi01. Use the read-array transition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261124181209.71534-1-philmd@oss.qualcomm.com>
---
 hw/block/pflash_cfi02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 4f72c438c0ca..8d130e14d1c1 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -958,7 +958,7 @@ static void pflash_cfi02_reset(DeviceState *dev)
 {
     PFlashCFI02 *pfl = PFLASH_CFI02(dev);
 
-    pflash_reset_state_machine(pfl);
+    pflash_mode_read_array(pfl);
 }
 
 static const Property pflash_cfi02_properties[] = {
-- 
2.55.0


