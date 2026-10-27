Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F20606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W6KM72RF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VKH7taxY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmrX-00067r-Ki; Tue, 27 Oct 2026 15:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmrS-0005W8-6E
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmrP-0002SC-VP
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:29 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHPnV2997794
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L1C+mEyTBY0xij6sEJ89Xe5A9VlyoX9PKY0o51G191Q=; b=W6KM72RFikQfXFvu
 ZKyg8DSXfQXD3yTPN4BngXAoMI2+/8Dg56Liey71wDIyea4a8gbMT9Srdh3T03p5
 oKQmNW6J4GMAKPkkbHWQQQDdoO2W4q2ht1M1FBbzU5NWxosTMYQmhCtP2JmIAnKv
 BbYk9rs+yEuX+2VRUQmYOjK5vN40T6cK7ZhWMJUzkV5/DTPPQm8fVVfs6YMngHOB
 5PTL438SWLXDtHTP7KzQFk8xaO0F4FUJ6MWPSQrG9mWLnYxZsyW20qLpGpy/JZkU
 9bV0/OBCmvzii5gHJy0DvSEs9ivs1B7ihnS+YavtV8fHtnf5eDy6r7/Bu7DmRaMz
 v9/rVw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1jcu7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2005ce21so20794785a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129365; x=1793734165; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L1C+mEyTBY0xij6sEJ89Xe5A9VlyoX9PKY0o51G191Q=;
 b=VKH7taxYljTQUnj/hAyFRku7hhgBJu2FbMjMUnj8fR3uhwDTLn8MIDWcNMqFbqACF+
 aAA7QtBHMtBvOY2QWoafG5/bBAZ9AcbKLPgYwtld1VVDYfLg1xv1fp2WTQXFskMWTs+z
 9jZbKrMS9EKeQ5BgquiYo8wu5Pjq6hHtnFJt9BVu4duBTPdnNFklLcN2YM6KItEqoeT0
 rrIirXw/mDUv6UjJJTy8OGGgnXajPX17q1nwOOHPuW6ML8t+Jg0WtPM71sa6Rwua/dUx
 srSlRhZvF5rWGIYL+2FwG2BtWr/QxRfuh/nwlG33XoUCGn5ZZ9kZUWOQBebEDnjzQQ/B
 qkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129365; x=1793734165;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L1C+mEyTBY0xij6sEJ89Xe5A9VlyoX9PKY0o51G191Q=;
 b=PEtDAI3YOdAGi5qz2xfYq8X76v5QqrbnEtWqmz2Y5OMwLy87pUIdKz5aqaH1VHaNo5
 tvoDpdycs0heoHNzHAUzUjXyDmK0xjC96Hx8ErC4K9CdmXW5nyUvUzPapyzhkm0MT0yZ
 F/Soc0gp24Zn2DyFHci1uNpRd+osG9trSdWhwY8wiQ0y/Gm58ipdaT6QRDdIIbV6iHYu
 nkNNjRCQSy2sYHiNNxMvTXm/O4sfxKdueAcoVmEox1i9vgsjO3/X+OJhpncoqnX1j/Y0
 X3DZJPy0h2otP1XZlNNnu/HRn7PbgaqTD5bJH4Sb4BND1rZeTWiKHsdCPQ87dmvnmqCF
 3xFw==
X-Gm-Message-State: AFq9FYIkVFZMhBYYXxbJggVIHyHA93u+mQ3jWrb6C8Y4MnGxkhuHPGoB
 CZ3kkqUP2Me7hRlctNdTso9oMMMwZVulhsl6gx1m5RzUoAds260o/MhIW/WSfhXAXeIBGL509fV
 er3H0jeJZ7oWu8zBNSxXUtYJ+MlISocrboRDj0g5/0OvHndkPk1c07g5FmUhhUTJ2hg==
X-Gm-Gg: AYBFou39rxnHYa/A1ajUv7o86Kimj8Id490byNnrjcSDFBMNTYpEUMH3FnD1vuXYlG7
 4ZVe3+fOhUiqCtl08+YbTBo6OXwe62RKG4QqLUbP5uSi2wkJ1rjAZBHDu/PIwukRIRrozniOhVG
 NrbYDTQiRSIOwA/S5Uzb38JO0HgGd0nPkMDxR3SZSxvPWAgD36BFWfTszWUzxP0gDsQZTzmyV7j
 rzvpPi4hLdgxLG+AwJLvmzPgVPYa0NRQLcg9pz+YxfKG2yTJXFe5/sx4w5SxX6uu5sClHAXjrvY
 jBflf+1ENlDRGneH/GpN6k26S5eGgMj+WSNSZtdyAuP51AokSKMrOGCzhIToohED3WNg2bCqUKK
 yM9KmTBWEZViKf/qpAFetIEpb1nif93+CmDxwf0ldtIlryT4Otw8VtRV1
X-Received: by 2002:a05:620a:25c7:b0:93f:6182:53d with SMTP id
 af79cd13be357-940ef7d39c8mr1650686985a.3.1793129365447; 
 Tue, 27 Oct 2026 12:29:25 -0700 (PDT)
X-Received: by 2002:a05:620a:25c7:b0:93f:6182:53d with SMTP id
 af79cd13be357-940ef7d39c8mr1650681985a.3.1793129364928; 
 Tue, 27 Oct 2026 12:29:24 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a93103e72dsm6189845e9.2.2026.10.27.12.29.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:29:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 50/59] hw/char/sh_serial: fix break detection flag
Date: Tue, 27 Oct 2026 20:23:31 +0100
Message-ID: <20261027192341.9197-51-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae0fb96 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=YEB5RgzmAAAA:8 a=EUspDBNiAAAA:8
 a=BwcDH0jRu0kHEOYv7QEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: zo-RlXm_U88SIQSyD2BvVcN01U-9Gp21
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX0jZASKQmWfBx
 JRXr2ZQvXDKEFWU1ffcaDI+vzCIORdrVuPGv87xe4rWnCn0L2u7Wli9AufFOkH1eZe3KWaqQwIZ
 zgyOhNmhXJpCkBOUuEQn6R3Y+tF25nc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX3EtUZBSzQhdJ
 R+ErF9mOs4Ymvx7bMB2OL0rw7KLyFntlxVnox1FV/PFDixeDVnyuE6JN4FHKYarR0JzY4hUFhUm
 R7k2e5fs5Rc4wTS1zO8OzejckbZE6MOAU9YcFd4xyXn7Uc+bUhzTo+u/0VKucFVDUvfWxylyVhZ
 m8oFBZGi+m8VHaQmipRzdVvJ3KrAAbesX2v+ITLpT4RJznQLjo60D9EIvgvnqir57zuWb39yriT
 TqTUQIT0i987PzKNSnUZy4REr51pPRcsMT2WUwqdCu62xe1OKJ/JtaL5djMK2z2zerCPJ7TwBup
 8rdApcd6UKjr8jMdtjTT9fSn7zbzNnCucvGm11gV23sRy2TGrhasvd1h4sSalUhEj87BcltRIar
 KpKHGSnedhBCfxZtwcWHpBX2RKHtwbnJxMxYZOq7cHrmgnL5v5lrNgaZn3ayOKnzv/HtQAxmMi1
 6paePOTqr5K/OZMbhOA==
X-Proofpoint-GUID: zo-RlXm_U88SIQSyD2BvVcN01U-9Gp21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

sh_serial_receive_break() set bit 4 of the status register (sr) instead
of SH_SERIAL_FLAG_BRK (bit 3) in the flags field. The read path checks
flags, not sr, so break events were never visible to the guest.

Fixes: 63242a007a18 ("SH4: Serial controller improvement")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Message-ID: <20261004-issue-4560-v1-38-ccbef537cbeb@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/char/sh_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 8728842b84e0..8933af24be10 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -322,7 +322,7 @@ static int sh_serial_can_receive(SHSerialState *s)
 static void sh_serial_receive_break(SHSerialState *s)
 {
     if (s->feat & SH_SERIAL_FEAT_SCIF) {
-        s->sr |= (1 << 4);
+        s->flags |= SH_SERIAL_FLAG_BRK;
     }
 }
 
-- 
2.55.0


