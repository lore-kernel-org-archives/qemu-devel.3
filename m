Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA7606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NzcbIyjc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dnstXMBZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgT-00046h-Au; Sat, 24 Oct 2026 13:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfgQ-00045G-FM
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfgN-0008Kr-EP
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF0BLh1354558
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rmLhsxmFR+r
 jdh2BaU5nurhzxyWvxP09XmyFoBtLTYg=; b=NzcbIyjcTsPiy+w2jrHFwzYBMEp
 pNgrDnt7W0m/Vnf/d1H01KgvrSVzWPLbylP4ZbU5jfXaHehHjpVh+8/G3htCysdv
 rpJd80MfGOt49k+OYCnM2TLyGbIUX/BL3FMxOSSDrDOSSkXja5tK+Rd5ysp9qqlu
 hXjg86noIrLwlNFvq/KwrcIJrW1exrlfy3EVMchlIkD4AsTX2CJMpya2jCRY/1p3
 NfnVpRDiFwTs35+qUd2Tu1MrzdqbuIBIFJizH77vZsYpHNnhdSew8Demuk4pCabM
 kTdLjwTpsNoKb6L9rXACrKDTOFQqebUdXgWwc1AgSvnmE28V/gNKE3SacCg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehhc7y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e869e00005so27147335ad.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863434; x=1793468234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rmLhsxmFR+rjdh2BaU5nurhzxyWvxP09XmyFoBtLTYg=;
 b=dnstXMBZJfOCo96KsQk/a++/JU0YxFETAOSgcrgt/bfI+LUGSqMnhRs77ZT2HseG/c
 LA/Bk74PXt0sO62oLOeB5D3fOVAtsrorN4z1gqXMnv/KfnaoR/t14Ee+L5PAHaX6EcQI
 sHQiEuBlbiL2AlrxUuTvNfHriwM5hJ83bkHjKg1BFRvGgYEaDaD/lHRsuf45lMy8YoC9
 QUoAzBW4zUDgB8vX/HKxH/Pc57yO2twT+sB1kTNfMkTAQG5p/QQbxOYTqIkPl1JPYIHE
 9m3bE9bVo00hJpN7kVMSZ5IkrX+Eu0i8X6FmTR+IkGankMFSMStPodYjv3Jf9FEUMK/3
 TCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863434; x=1793468234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rmLhsxmFR+rjdh2BaU5nurhzxyWvxP09XmyFoBtLTYg=;
 b=hQcNYkaAwGSPPukA3gQfcfkXZlgUvgWoK5OjtpdaV13eU2yS/xAksOjIuRRnVeyVdM
 pXKMzzUqcdKEWIRre96EFAkiOWmPDlMjMEG3oUXl8WH+ic8fmd6flMgZiOCmdoLtcRLl
 ZZA8pwtg7/M2XsomNoO/4gTatdiMu8sVJcRIJxiQos+I7tbpNwAm18mWmwT4+Wocxwi0
 A1AWIxO0Mi89oC6WEgjGxJrwg3GNNJ3XfRKdHhKfdnTKNZxCrNdyO8Stld/k0fwK6KBB
 BStOYoMbcC0yjmLdfX6d3k4Wog7sX5bPwG5e6QtEi5XPdT/0rwyKPx6sX937+cFnDBOD
 Gwhg==
X-Gm-Message-State: AFq9FYL5pz8aAlAoNG+IadOLISOYnTjqLb7lCzoB+dO8QwSgXZa92pcN
 WGaxRP64KKD53msrzEaO1mFBsfTme4mR/SxwVhKNyBOMoKjC7WbmcA2F/Xb0YoeKXkpBnnvl7ry
 uq5hPFKLptq+Fdp/UHhiVQdD89ViH3iiKdnGqr5NHXoAqtR25+1/YQR/kMq8pwzvL+w==
X-Gm-Gg: AYBFou3tDn/86A7i1A6gmJ9QEqmQN8jwgQgZG+8et7QY7bgbX87KSvrh4M/Iaoqzi4i
 ohZqIpbEPtLVUNQ9I9DAD7B/it8TzQYcmwKad/UiWZLKXbuupjDydIouUQm1L6hqcuZnSDc7M75
 ivtm4LMAF24OIuqCkWPgWNyLd8qKSXFZQ06S2brjDSa029svFvus95i8uCek/7WyO0Ku7ADRcM3
 YnVI+FMUc6KNMFSEZjb0vuQMIadlouf4ufxTF2xJ3ghzoyn6ziuVzt4rPfrfhnJy9+XxNC7wDDf
 3TVAfdWbT8dE4OBoTuyJinJm4rrowPddr7FNo/CGR+q3PUxIWr+pxuvqG/B1tpsZfdoM78eD6eB
 Hd/wbKunaLeJ63Toki+j2Vb/sXTh3elvv/4r/dmxPBjhsb0xXQJ1zmyxpohEejzY=
X-Received: by 2002:a17:90b:528c:b0:3ac:b08a:ed2c with SMTP id
 98e67ed59e1d1-3adead49388mr2203613a91.40.1792863434465; 
 Sat, 24 Oct 2026 10:37:14 -0700 (PDT)
X-Received: by 2002:a17:90b:528c:b0:3ac:b08a:ed2c with SMTP id
 98e67ed59e1d1-3adead49388mr2203605a91.40.1792863433979; 
 Sat, 24 Oct 2026 10:37:13 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 20/20] meson.build: list all remaining softmmu targets as
 comments
Date: Sat, 24 Oct 2026 17:36:49 +0000
Message-ID: <20261024173649.7405-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfXzhm7HTmnenuK
 mc1QPSGkJcQWxzD3LK/zjDvLaIWPux4VzxfMHQtuE6SklscHcaLdrLmR9FlR+BTIvLREwaLCpXD
 x5NUcaoU172FCiQKQVAD8vjKV14FuTo=
X-Proofpoint-ORIG-GUID: Jwn2_Ol8xU4pkGxJKlZuAOs9_d-uCf-Q
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6adceccb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=EkFlH8hhcvN4hlnFHCQA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX/QEK/PekKHQ+
 kneF/waOgb5DBPdUoTec3m/F95fgwk1J9s7qH1oytecyyRu3lI/HYDeHRDR85XXagsHhWN0aUhs
 lq8ZuaG9k15qLvc7QGBXEsd4oWH2fK3YJAesuJZezTpr7oZnPl9dv7Fl+oxwxQ2wAJbaQLl4QQs
 XUdLWbW1Qk/fWdHkNzDeQc/a4gqj5D9+uWunKHgrb1Gc//GYSOez5AUUYnBIvQfHn5qoR2Qg4IX
 V2RfPA857mhT+gJ8PVpPlF6n9na3AFFjERN+KWoZ0G48O7iEpXgCECdw350IdXFs3xr1R6GX5MR
 OBahvfjD7/mw3k1zylMe0QhhpXGF+jtVhrsMBuDmhe2+jyTVt4NPMUM6FWSFwVQiH1KlNtpBCT/
 OGgpjszDClvHdEHDjr9H9ENC40ZowyD/sKTkgOcp6alNxKwGOXmR6euoJy0D2zXRIWIRjReSyra
 5osn9kKoWyvnSKO7eTQ==
X-Proofpoint-GUID: Jwn2_Ol8xU4pkGxJKlZuAOs9_d-uCf-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Link: https://lore.kernel.org/qemu-devel/20261024061616.27381-10-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/meson.build b/meson.build
index cd328251829..671511c4194 100644
--- a/meson.build
+++ b/meson.build
@@ -4275,12 +4275,29 @@ multi_target_supported_targets = [
   'avr-softmmu',
   'hexagon-softmmu',
   'hppa-softmmu',
+  # 'i386-softmmu',
+  # 'loongarch64-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
+  # 'mips-softmmu',
+  # 'mips64-softmmu',
+  # 'mips64el-softmmu',
+  # 'mipsel-softmmu',
   'or1k-softmmu',
+  # 'ppc-softmmu',
+  # 'ppc64-softmmu',
+  # 'riscv32-softmmu',
   'riscv64-softmmu',
   'rx-softmmu',
+  # 's390x-softmmu',
+  # 'sh4-softmmu',
+  # 'sh4eb-softmmu',
+  # 'sparc-softmmu',
+  # 'sparc64-softmmu',
   'tricore-softmmu',
+  # 'x86_64-softmmu',
+  # 'xtensa-softmmu',
+  # 'xtensaeb-softmmu',
 ]
 
 emulators = {}
-- 
2.43.0


