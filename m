Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8F3C5DF70
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc9y-0003rW-9Q; Sun, 16 Aug 2026 10:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc9T-0003d3-43
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:47:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc9R-0000nZ-Oz
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:47:54 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkuOJ3631485
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OKyYdzYjIVu56aOdfxczS6fQps4NfMHVNbL21hnnE00=; b=JIzIFSQ5oYm6G0+d
 c8u4E9AcNkOw9OxFfy7eQpfNH6PiMc5SfDr9oCsBBLeUdrxOgsTJds2c3Bc89yob
 BEWLrZIzqWbM/o+9RNdHT5khZvOdZiMo9pX2/TCFeS3n4DvF5yNAr+Sb6E5AfWhE
 W9kg8ikDLxlTzYseoDhJNU8DKMN3zMes4C77isYXMKHTVebNx4hnN07OQCRN/fRv
 TYqg2e4KaG+bQXcPtE42S6Ho3+4oLkYZ6YMslBNv4Q/6QzclTVowPvcPLb0Uc3zZ
 Xe32HLexC1tFqh9wkGRKXetB+9+3kxu8o0HUno1a/NlBDmymHF6g13OH16iBbnjN
 9fb1CA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghekq1b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:47:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e62e3459fso233043685a.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891672; x=1787496472; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OKyYdzYjIVu56aOdfxczS6fQps4NfMHVNbL21hnnE00=;
 b=C5Mf1u6w7FRlt2UA1cdbyGGyohemTBOR77LobUcQJ26+y51JEH1pM8BG2W2gW8btDo
 e+u5/hssRCGcD4C+EDcHFe2FTqGB0SSyQpEMs5U1zjQ/DYAQf7urKAakJqKJBTheefeZ
 IRT6F47JolZNZgiLU7VFVlVMV5UouCTp0t0Arn+25XSqBO4Xk8V8bTd/v22SiEkM12qi
 zF0C5xukByZ0S07zm4/365ncy6QqSmIt94FtN7qxl+pqZESfXavGtxqqXKKAxvgfefzB
 tYCNBQLE75jloDBkbrBRKRydPT8uMgWd5/Xe6yLxgovQvaV66y+Fo8syVyFhifc/Z7SJ
 wYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891672; x=1787496472;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OKyYdzYjIVu56aOdfxczS6fQps4NfMHVNbL21hnnE00=;
 b=LcX16YQT53mp50nDGVW82PcbqhtAjelhmlJijYTGOtuv8vuig4INY2HnQVpeG/ssvX
 jNWRx5ZvfSe8UtRoWn/w0jreEUDF47hbgsmyPVpgAVyrEK34C0/NJtFPL4W8fRD6dNhz
 hw0Y7brbcSm5taY6cBv1xsh87/41LBTnE7YofB2U6HLYyJ7N+XalhD0INVwbEfza0rof
 j1+3Du9cQdMyiJ24PoA8IICiUQT6YM+WcysQ3gt4+hUUv4NQAu8QefqOMHsWlzFYwjoE
 xdl0uGGp6d3Fyr/l7imCznYq9RUJp+OCNSnW0DXM22CSKUhU3irYq6s9lgMHBlcIGa3l
 u44A==
X-Gm-Message-State: AOJu0YwA3gbZ9/WrA6fNBTupHIPpRii/c66DKDB6kkokBLeC6DEYeeid
 iJqVqFvGdVaGL/x/jtjsJe3hLDXDjBuruewxc1RTihz1sOsBMM+1NaC8VF7BSidd3mezva5UOJk
 f1R2uhMEMfP5gj2A/Iltrnfh5t6MbMxEDXZRsBmrIiKzKlmhQp2sCnJftv6H7QmkBjA==
X-Gm-Gg: AR+sD12/yC8NONBerrHSQxuSAbrphG2XnArETRtvFBa7wEBDy0WYlcykf1swehPJVRy
 0A9P4cRPAIoQ90xAnzgNWeDK9pt05tCxlrBqTsB80/BfOTAqShbdHixDBvwnGc3wpZT65SUXJcL
 93Age78y+y8uegL6ZWW/zJXlfK/Z1UJ7u9i/bCRUI7jez/EoG4xmp/J2mAnnl1tQ0O89oUWlCHk
 h3B3NCfegcd4VCbohoLxnmBzU1StG3DtKdZ/mGU2lr8VxQLajaNarajxwnRPC81OOH4CaZ/eT2H
 agzig0NvkX440oM4FGlQaNy1X0/kDINxOUCcJMiJdbYibvfu4CacrmomHB/EYmJBVaSAvswE2S4
 m8/vavN/Y/v32eqlbGjD/cK3VBEc7F+43NF0onqYVbQ==
X-Received: by 2002:ac8:5949:0:b0:516:e0eb:d7d with SMTP id
 d75a77b69052e-52d85439fc5mr212723831cf.27.1786891672249; 
 Sun, 16 Aug 2026 07:47:52 -0700 (PDT)
X-Received: by 2002:ac8:5949:0:b0:516:e0eb:d7d with SMTP id
 d75a77b69052e-52d85439fc5mr212723391cf.27.1786891671810; 
 Sun, 16 Aug 2026 07:47:51 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998ac6afe7sm128306665e9.3.2026.08.16.07.47.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:47:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/56] target/i386/cpu: Use qdev_is_realized()
Date: Sun, 16 Aug 2026 16:45:12 +0200
Message-ID: <20260816144556.69009-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EKc2FVZC c=1 sm=1 tr=0 ts=6a81cd98 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=XWD-wEe3UW7fOdRgLHAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX0jJCtWPQ8rlo
 jn6iiy/jzOX5RBOZeuTaUJLsJMtOJ5PKat8MghKOCSiXzghDSaql6sdmSQEACrHFwe4CZMZ81si
 wyUAXnCxqKxAMKYR7/ujIpyEH46Il3I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXwF6uluuhxNmw
 KRLNxOEIDdD9MhP6X4b4F7bKelUrG0TZK6KpZaBxfJTCZLtNrVCTvFmkk/+APy6HQOWw4y+c9ic
 GL055mW8H5ZcYCJ3D4Em8gE490F2BaKnani15qQ/l3FWS6VJIY2zZun6mSEhKhMZ0FRSOjzZWjv
 yg/+TF9iFa0G8y82t0hyQqQywABM/5sKaE+jbyIijech6z1Q596YwneR7tyRyx69OYm7mRAa2x4
 s5H0tfXcOgFwhMS9wvgw8tVillwHqhYFJOoS9b5mpCODV2o/GhF+nsiv9/1tHhfmpjFr46fwEkU
 WUB87/kCaxiNJIQbkJudEz/hXBc2LFMHAAYJQCxuo5Rzo2Q7gGlAwXA5sFxEzhM5buEd4PKtoCJ
 9IoE8+zp19Ki3DXUGmsYgbxWTkyH29xOc4hN/4B5OOcU/RDvwhIlrlBnLynMjB9QNWweW+TyOsJ
 NVAnQboESxHyNQJowTQ==
X-Proofpoint-GUID: okomQRWGkQFqgVfSGrYAkgvsw0vZhyym
X-Proofpoint-ORIG-GUID: okomQRWGkQFqgVfSGrYAkgvsw0vZhyym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

DeviceState fields should be accessed through qdev helpers rather than
directly. Use qdev_is_realized() instead of reading
DeviceState::realized directly.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260721-qdev-v3-12-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab92..7a2c3cf358d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10387,7 +10387,7 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
     BitProperty *fp = opaque;
     bool value;
 
-    if (dev->realized) {
+    if (qdev_is_realized(dev)) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
-- 
2.53.0


