Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5F8CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJ9w-0006fR-VT; Mon, 15 Jun 2026 22:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJ9w-0006fE-0x
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:04:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJ9u-0007tf-H4
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:04:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G1xiEd2338087
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iBELB2QcseXb5jo2451d8LaqdpobkKbY+E9paLs2UhM=; b=dGoItQqsMR14JqFY
 GiFoW3FWpE+1m3NAvrob0mnTmvpNp92pUjPdNdCgMEdnCUIoYyIe1phRUZCroYsG
 rOF0oVP1JIIkV9mYaQ7ANbZ//FL4iuBpW0Qo4zUTR0SR7SnpYLUZrr+5h0OpzLMl
 XbkXvQR3O2wzvajtoizQrrkIJilVsUlQ0ucy+sp3b1yU9r+YcNFk/wf6EBdopBmX
 xLLu+ygrtuHLuQTtEc/GEAd/iHtaQbwMc4bM/BbQaL/jiiPaqezT4fMqC3UtjcBs
 zCVGfxyqhU+KzgxCkoUs0ude5a0aC4/md0PxFqcWbvrhcuZ7ML1smAkCykgUpjs1
 H2sqfg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etgvhkmff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:04:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91931144870so456043885a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781575448; x=1782180248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBELB2QcseXb5jo2451d8LaqdpobkKbY+E9paLs2UhM=;
 b=asis5aC4mmfSCWHb8LKAv5/f5mg9tSm9yj5KokSH5b2749Obk2wf1qj0W/gfVb0mxL
 43DXsXPu7Gy8BuCHJkICA2AFMl6JVh34BRoF76e0q8ODpkpEu76W6qXGWUYlcOrIXDlW
 fEaW+lY2zpsFvo2j81duJy/jt3uXWo55aDzlGM0hlSOxnTLOoeTXMEnWTAs/auo5OeIB
 j+ql5aUW7fLdD7nMoiyoI7dtnm3p4dXDxf3jZKe10GmfoqpaC6gfHYXQ9KdXet5YOhxu
 46Iqsb9751GnUHjM9nDvdYYnhUeiZTM9DtDJKTgqMPDAhPey6OQV+znwZHE2JfYSX8Fn
 hnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575448; x=1782180248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iBELB2QcseXb5jo2451d8LaqdpobkKbY+E9paLs2UhM=;
 b=gL6UjHNyMmpsVRWzdjE99tVi8b5+mUK/zBgUwznCEKgyznuqAlo/sdrjXJsnpGVufV
 0ILvyeiwlhsTQWNMt39XKxM3yi143ilQf6ahZ98353cnrJ8RPqxxv11Kj2j6ZKENMp50
 tdwap3OkJIgB7ZTu79VPcdJfgJzPr0/xQPPXCWWPcegyO3dw2FaS1bxn8BFgkg1n/ZMW
 aRpDIwEmBbU2cFFvCfCqCZkFB+AN0coAk5Uj+HYIG3KxVIA+p6/V7bYytxMMYo+lH6le
 KM7WWnujguBDPSyA7Yd1tpqJR3Ijbf1aHTEKgkKv3v76eWhN7nYs/5Y0UZrojsNZmA8K
 fUDg==
X-Gm-Message-State: AOJu0YyqAy5reQnhVRzf5UBQHKvxbAYyweYIQ+Trat9g0RQskfHFuQ+E
 DwcpmShCY6BGpnuOo6SoSgIZB4WiTFtQKOnU2A7XM+41eSmbe4nZiFDHDh+gi9qfMCeYF5vj34H
 py+X4sQMHBw+ZC7Zmykx46Itq0+VgDScoK9HIarPTw1kERCuATxQBeBqL3rDTPYApjQ==
X-Gm-Gg: Acq92OFm5gNxN1y3wXMeh+u7KkNRlsorNgiiIPXRyAfThqtNHib4silqTOxhcyxS3Kb
 5+WqZ21+3rV6ggyAKc9cS3cbIF2soD/fhjMWuxzqm7l67ZTL2xmJc67NWO1zZPjWUFS2tOqmWIA
 2k3FHUxe/gHf0Qu4jOW3n+vCY56QmBQ7TzK/xPJvJQjWq8HmScvI2r+xXGOamL21hC6H4mFCJS3
 OzWm5oOAfmxDBPys8kqeuGvRDWu5UkTd/QdmYGKkGcy5V95E0N7WaS7XvyyhD9Q3WBi4vcghjVW
 VLWfhcraEp/EGlwo3FC9LFv8JuqUbMSdgmtyCdonLZaciQT1HsDKwQP7veC+eazXiSPeGOuQg6X
 q42cNfzMpjNH0mc+A9k3M/s41Ed+cYMsOc32cJuh1vLa0kybDY8duyyl/rkBfj/iPQ2/0GPtUFA
 WZM2o=
X-Received: by 2002:a05:620a:bce:b0:90c:a08f:c5f0 with SMTP id
 af79cd13be357-9161bccaed3mr2699398285a.33.1781575448513; 
 Mon, 15 Jun 2026 19:04:08 -0700 (PDT)
X-Received: by 2002:a05:620a:bce:b0:90c:a08f:c5f0 with SMTP id
 af79cd13be357-9161bccaed3mr2699394285a.33.1781575448058; 
 Mon, 15 Jun 2026 19:04:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a58fddsm17802425e9.8.2026.06.15.19.04.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 19:04:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 1/6] system/memory: Constify various AddressSpace arguments
 (checks)
Date: Tue, 16 Jun 2026 04:03:53 +0200
Message-ID: <20260616020359.18627-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616020359.18627-1-philmd@oss.qualcomm.com>
References: <20260616020359.18627-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxNiBTYWx0ZWRfX0WSs9JLsgGrU
 ZpiFi/5KdY+cIAgb4Rvge+sG2Ksq10n+MQ4gErRR2fCe+iQx52vFvd00zmlINrU9eiKGMn50VwA
 zFXSAAxO4I0/k2VGaeRgTQYkHB48TQY=
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a30af19 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=e-NtlPoBfifz4Kb8xpcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: e_4lNX16BcweBvhrW-S2_06Ly6MeA3gg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxNiBTYWx0ZWRfX57BTWoqbJRiV
 I8UpytTBfkDrjXRCV2RlFnlOaXT9szwZhetGmbdnoy1+vdXdoEBclw17waQAm72CozLUBKVUUTy
 ZQCAHGOr2PPg50nrTjJaeJ1Gnsal4GwVYxffmM3rDdCbk91yer2y365iFOD33rVBAmk7+htkiNb
 rigoaSMLrqyDzkCazCXnau4ekO4Z3IvB/IqrWNUJHGPDUqPu74NeofYO9ksaCvND81X86TD/PuN
 yqzNL0UQGNHHWmT/YBH0IQkXizG/wO+auDRZC/2zbxJ5Yf+YT2sknFSKOdpnaWKLIU5CNGBcvnw
 DB0GCcnwuTDJWgVvcK7ht0vClRi0SZ6htT1QeTYq30hJi6MZ/3yl/OOzr/bmqNxjb68AhD66ccY
 mrcozNTs674Y/QNLED0khTc3x1QDOguMX7IgWby8EA0rXF1q5peWtY8q34x4+ui+/C+GM5H/zuW
 rIlm8q5pZWOD94Qh9VA==
X-Proofpoint-ORIG-GUID: e_4lNX16BcweBvhrW-S2_06Ly6MeA3gg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160016
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mark the AddressSpace structure const when it is only accessed
read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/system/memory.h | 3 ++-
 system/physmem.c        | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d9..5c525646193 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2829,7 +2829,8 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
  * @is_write: indicates the transfer direction
  * @attrs: memory attributes
  */
-bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
+bool address_space_access_valid(const AddressSpace *as,
+                                hwaddr addr, hwaddr len,
                                 bool is_write, MemTxAttrs attrs);
 
 /**
diff --git a/system/physmem.c b/system/physmem.c
index 7bcbf875736..a0561177afd 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3646,7 +3646,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
     return true;
 }
 
-bool address_space_access_valid(AddressSpace *as, hwaddr addr,
+bool address_space_access_valid(const AddressSpace *as, hwaddr addr,
                                 hwaddr len, bool is_write,
                                 MemTxAttrs attrs)
 {
-- 
2.53.0


