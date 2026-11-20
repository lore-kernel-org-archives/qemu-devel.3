Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92A60A2616
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mwXOWrm9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ioxjSz6P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSCn-0005SY-45; Fri, 20 Nov 2026 12:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSBj-00041W-6U
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:14:17 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSBh-0003wW-IF
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:14:14 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfIG42040039
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dbfhzZmvCYz0EfZjp4Apml7ltXRLpLRV+x+jc1oHKVo=; b=mwXOWrm9nmxBXlQH
 zpDLHuHUxePuqQazR+hGh0g1mHzuC0v7feFFyPqEn9mNjq0rJx2GCSQVh7bIwLjh
 j4orZMmrUQd7o5MBS+AVXlwMMa/JyfeSU//Z93T2rkiMLDIP6LnToNvsR13CxHcD
 h79eWu53PXWys5zx245+kk3Xaf41E6Ob0N3CfTSpJWLUsAEPC5S18UbsKxwqMC/S
 0s2e/i6d2GHRsgapSt+EtsxPN4TUkVNfAkI077cu5fxMR6HM09J4KfCyIdb4SeDt
 wzWMUvYH4kd0MhlS/b/zorwf5e18yf86mVJKSVL9g5Qcef9j6aMhXLLFFi1y9+aH
 N58d/g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjtty0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:14:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-92137a721c7so16678326d6.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795194852; x=1795799652; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dbfhzZmvCYz0EfZjp4Apml7ltXRLpLRV+x+jc1oHKVo=;
 b=ioxjSz6PPjMnfQ9lD7w+vkuBSquV9ior8N5phEBnYy/u6dA5csNEEBz6BS8LKrJyiv
 3CLavoo3nVQx/zlVErE8kyEfw9L/0vF6XnK3N8uV13eQHkRSpEM7BDNOhWxsYcTKjzyB
 idS+LMEfrGPMLudL8gBuBg6Lbj976HjLaz9HGvqG7o45vkTjOeadZO1N21h6b1YAjITW
 PGr9nu9SjI1BPUgb3VwM3rXCIcYIsCNx6b/eNrH5ZaVxpnmkVWde6iDOfmUv4VRwrzAe
 C8r/bSbDzktqZTFXd4ZJLFD/GkoiNGdacIbs1Q+Iy+cFPT5TVoyOgTLu91oyf58Hs40K
 dNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795194852; x=1795799652;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dbfhzZmvCYz0EfZjp4Apml7ltXRLpLRV+x+jc1oHKVo=;
 b=0hmTy3agjK6PTxysdrkD+rzBuBhJHL8geACNV+YEvhYsi/Z7mfnv1LPy+r8sLaVwhE
 VrrxEWDDzGruC3zQzmKGC45UExpzde+7RB41g95M69Hf3oJGFaiZBYRSEpg4oye+hXl0
 cAj4EsCkgM7NNCwyhdWcL8ouEWygcpPOOyH0PubKmxptXLl8Gx2BeZBtGREg0V/gCpIH
 HQCKTIDu3JkgW5Bv+QPHHKlh0ZSRdX8uPcrc4L64mJa8/+jrjHkG1r65otyhXcBQaI30
 JP5D9NUQ5mrJi0A/utwO4IdifF9jXb5uUM6huDpT9FZR7dOQeigD1UWZg7S9Zir83awI
 4/YQ==
X-Gm-Message-State: APuU4Z+1q1MNHdiJwqQgTpn60la4tE58iuWhaenxZ+rsmHNx83PA/vkV
 HB7hsi6OyX9GzYRgsghrDr2ZsGaeG0PqjV0QmNCxVANXQ3JF2OK2y9YM1kUAw0cwZcdzHT7JuPJ
 MsBoIRzoOnVyEwOLHG4Z5t6r8OU9MtboFfM6ze/HDi7dzqgY4SLGtXezFJ5uanyEZtQ==
X-Gm-Gg: AZFdTZfsaP920yOmDr9hpQg4Mzj3ittg7iyk/Rgje3VuTwVLZ1k+eI84TzFHa17qs2D
 Jc0C/PFx34nQPcLS7oaKN3/r6/sgbBK3dorfbxaNoXVY5MHBA1jdpjQqQDfekaE4Ty2NsI7jLbQ
 44Y+3T+7HqDYE/CgrYw+QiDbGZ+MfwVf4dWR+aKiY5eoObnZ9vCzaUdN8moyg5rfJSXIw+kKTfF
 6FJ/Cgic+JhYeDOwmDFNQRHYfO9SzFqEjQ+7AJSJ6jpYDt/wRLf8dCizUnX6XkqRSQIdxGkLxiQ
 VHqtY4iqid6/t85Cv/o2pgVWopX14TK75Oi16sfeAq4O6mdMMWndpomTIw/Fqrzvuhc+OAaKDBM
 CvtHPrzywAYd3sKy1ocnm5ReFZvBdtgrxDkYB4oLdZr+Jo4fobOrDF5dKpCtCcuDndaCNS4aCwe
 eVcSp10HMF7fGytg==
X-Received: by 2002:a05:620a:4590:b0:93e:6a4b:3ea6 with SMTP id
 af79cd13be357-949ba965a82mr615578885a.24.1795194851840; 
 Fri, 20 Nov 2026 09:14:11 -0800 (PST)
X-Received: by 2002:a05:620a:4590:b0:93e:6a4b:3ea6 with SMTP id
 af79cd13be357-949ba965a82mr615573185a.24.1795194851345; 
 Fri, 20 Nov 2026 09:14:11 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442693sm90564945e9.1.2026.11.20.09.14.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:14:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH-for-11.2? v4 13/14] hw/scsi/ncr53c710: Document the SIGP
 latch deviation
Date: Fri, 20 Nov 2026 18:12:33 +0100
Message-ID: <20261120171235.61325-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120171235.61325-1-philmd@oss.qualcomm.com>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NdAYv1kgj8KpJR0b7ibcLCbK_kjsNHaW
X-Proofpoint-GUID: NdAYv1kgj8KpJR0b7ibcLCbK_kjsNHaW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX6DEaROHFlYNB
 TmYn6jdgtRoo3RGBK0aRxwPyjveuZPc7a1jf8+3Wc3uFIx6hisNp16KmXik9Eqk677b1WoeQs4g
 48OCurmlNWRG4zylWLbbtdztx1Tn8X1oWmcHk4QQerqlBTRkpYQvTwgT0peuF6wQHGcyYzPeyk9
 G6htTA7NBoBxO5P+Q7p2lZuCvxV/3HR30Yp2UKePIH6ZaToDauOBcrXI3xgjsJ3BO732NH04vro
 4DYXrqQECadATKtUOrgeDpvSmS7sMZtWwB8+hJgV5hZmffClemxI8M2xuj5TaoMzDyOCuBEsctl
 Uvq+AyPm3RPdJOPMywcF+1YTrvtUr6+VoAkmoh1Hb+jO2widfWQEoApVm5Xo70ua4BCOb0eYfFo
 jd7/i0vrsy1SGtekzoBD3LYB64aZjfSipc8PQoVXlSxF/mZxx4WDDHV3pC+7wCkFT+29zl2JnyK
 ONYGWIoikLlQN4aGddw==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b007fe4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=GChFR1gXfXaX4RAfPo0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfXx5HveQOFL2sN
 JsTWi7F8hVYf+LP+iDxnh6+H5XRvYgTsh4rN2FOakIrzfDTFqJy3mQU69zMlka6XYa8TgF+ntCd
 JvqDJgNQ8kRK54DDTMtNNBiEcMZ0eOY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200068
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

Comment only, no functional change.  The data manual describes SIGP
(ISTAT bit 5) as a read/write flag that stays set until reset by the
CPU, either through ISTAT or by reading CTEST2.  The emulation drops
the bit at once when it is set while the engine is halted and
remembers the kick in sigp_pending_resume instead.  Note the
deviation at the code.  The reason is not documented in the history.

AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/ncr53c710.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index f75540da7720..af26d26a05bb 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1524,6 +1524,14 @@ static void lsi_reg_writeb(NCR710State *s, int offset, uint8_t val)
              * Reselect consumption would, without disturbing the pending
              * completion.  Remember the kick so the next command is selected
              * once the engine parks again at Wait Reselect.
+             *
+             * This deviates from the data manual, which describes SIGP as a
+             * read/write flag that stays set until the CPU resets it, either
+             * via ISTAT or by reading CTEST2: here a halted engine drops the
+             * bit at once, so a read of ISTAT or CTEST2 no longer sees it.
+             * The reason is not documented beyond the commit that added
+             * sigp_pending_resume (6bf09c62fa), which only says that a kick
+             * on a stopped engine is held and replayed once the engine parks.
              */
             s->istat &= ~LSI_ISTAT0_SIGP;
             s->sigp_pending_resume = true;
-- 
2.55.0


