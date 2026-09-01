Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D57C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LAa-0007Sa-0J; Tue, 01 Sep 2026 05:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LAZ-0007S3-05
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:52:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LAX-0007Dc-JI
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:52:42 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179Rtv1811511
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9962qy98qgv78VEwglyReKkX4KojPn8juYKMeNcCxIc=; b=RrnlxdqItL8660R+
 YS63jxrcDNWBVIOC18feDostCV5jvNiXDrw687NHn2kh712QjScmhvm5I/GGs1tt
 wD0RT5zG9FEMTZrmEGwomdkph4w5Bj5Z0B6TBWBkYkRj34ZXgmV3sPcyuL9FlTFR
 nTEccfQQOSLRpKccPS6MDQTr5EzvOGs8+NE0fAUYaErEsX2W0STGhTOrKloxBwcg
 1/regGVvkAv0D8Bb2oThrHtFx7pLmADr/T4LNp+uxwc1S3ObE7xMNeYpNWo+iC97
 sGMtQIRkbEiXcmW2X+v2cWLfuyQiiat4KBivkPNmQ8Xy2nxcFsxeMyHgdecf2gHY
 L8BnNA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdd4dv6m4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:52:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ec3146553so1100609085a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256359; x=1788861159; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9962qy98qgv78VEwglyReKkX4KojPn8juYKMeNcCxIc=;
 b=GVgpIoo2T0zj275rcM8JvSAnM1EcaWpeKgbE1M6RzRLdhvFjuurE/OlGQfC50ok5YM
 MsN4ZhM0dGYfIjm7uAy3rQ6imAvi0nMCoU0SR7u/s5egv0dK+prezwcKYXuQ727ALkT7
 iMRlqNi7toTr1xo5DcbUz39lzpfmErpoUhaDJwl1GVyw6mYmWtOGhV0I06QJeCYJl1rP
 UJbruuNQ8qMsH6g6W1WFmkb6xpCA9ms8BPFs3Lw5L6Patai88gGjLFABFTFUMqAcDcJu
 tiCxVgCsJynw6B20fqg2Q2i3LrewtxJrW0I+HZmiJxGTEiPMflin8fKMtJuC3h5b5+Fy
 d0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256359; x=1788861159;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9962qy98qgv78VEwglyReKkX4KojPn8juYKMeNcCxIc=;
 b=YQ26EiC7oRhWDoWBen2t9itew36NKYeCPhn2OapKZytOFgATtxwkFrJN2H36P5h7c1
 RBaYBBWJC/dVO4OWZ868NEDEOEyjGUmMBvTCGYHqsEVg54PLvq9k+f8+L2aIk+MuLYYO
 1NEcXU/iFSwKEofpzBLI39c5uhktW6gF32kENXSB4o6NMJ75V6LAMa5lr/m3u/WMr68P
 vOV9pwK590VZVkCjH64+ZmHnp46PDnFmgUyBHVys9KXdVWSr+NJXJX3bpfV6SOpn0iCe
 fRtrwwnrL6FMaMRSDhkVyrbKQ8QD7QhzLiJs13QOd5HTdgdeVIinZmC5ufiZKKKMCBj+
 f10w==
X-Gm-Message-State: AFuF++l/ElhkmUYAdxZB3Hko4dabmtoZgd3X39NNoQbaSmk06t53Cr81
 xTR0qTlnL5KfxQwvhl+K/GdJGY3lfDjE3iwioPHgqgDj/E5OQrabnxFvV9IBZlNgavCp+hP5UIq
 HcRbLHr8kGjYd9u9Qzs+lJiIQj/4ixouZPT0vgYyqqSUi8J6/+r14uxws0frAzT+zdw==
X-Gm-Gg: AR+sD11Rx8hD2bU365fRL3o/n0SCOEIwrsy+vGG8o7TnnNdLSn8Oy20Owrey5JJKNOO
 Uv7HBd6PR1L/D3uvUV926f7VnpYeF7rH+Wkm4bKzrZUmyhB+IOEfkaTPvcoFZHp/LrGBFO0bUEA
 UDVC6tB7wGebZfQnnUokMcnXIO5ZNDnXryPtoYqnZpAtXf2UGQrjnlTwwKu7wYqsWTBNtWv/ai2
 XwYlHWQ9smuYd1lyDUwhK2Ygd9329rx95rg04Qd7Y3Nk3Qt8mVsQhA+4BEIDmlBuWQbaeb5Dn+c
 jG1CoSzuAAt5aOB6+JuYxr7zaK1hnPDOtFCbmM1MeRv5ioQSDwVG/vRi5TsPYhhIul/MCVYhTUk
 agyMusISLDwv3axCAyzYbCBNPFFFXE4MZjArpGcEv
X-Received: by 2002:a05:620a:690b:b0:939:4abe:4517 with SMTP id
 af79cd13be357-9394abe457dmr516546785a.16.1788256359322; 
 Tue, 01 Sep 2026 02:52:39 -0700 (PDT)
X-Received: by 2002:a05:620a:690b:b0:939:4abe:4517 with SMTP id
 af79cd13be357-9394abe457dmr516542085a.16.1788256358580; 
 Tue, 01 Sep 2026 02:52:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce10f08sm57101325e9.7.2026.09.01.02.52.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Sep 2026 02:52:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v5 01/21] target/i386: Remove const qualifier in ptw_setl*()
Date: Tue,  1 Sep 2026 11:52:07 +0200
Message-ID: <20260901095229.72018-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901095229.72018-1-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=b9qCJNGx c=1 sm=1 tr=0 ts=6a96a068 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=6zyGMrF3NIoAil_mprYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX+VViQgfOdJgX
 p8EbMJZYZCcTNLOBrmMSJEHFuazeekHPMicfl68tK7LqXSUQf0FgYPTyXWf03aRNusDh5g39xrR
 AP0waanG3BbS+z7aTquxx4Pq2570BP27873Xs2ElcHCaRnurIMHXl40aWcs2nLWmf2ARuyO3rHn
 O7l8P7vWMD3UFLLWOwGV+YuPZ4QE4AuJEcw4Qemf7t7AwVCgLA2g7O54zZQ8y/8egj3NK16LJ2o
 BOrIzNVttQSWfohw8ZFQyABmNRVcr3/+h8+F1wDz+fV7TSQ9W5481iZpqRKAXnsjpDK/fbOE7VD
 3in74Ct8EFc1yn9VnTRpkDaJ9vahrYspmkaF22RGddnRLUaL4E6WpxsEKTxHXOMDBlBooh5iZaR
 +4YC7PFZMKU+CnvZwAQ1B4n3SkK/YCYiyWIuvr4YguLNvNff9gMDoyoIiXQoTwyAm5V/eYVThdz
 5XH+5tewiwANrafGKJw==
X-Proofpoint-GUID: SdYtbHGj5eHPiJu-H2ZY6PIdnmY1ZPgh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX1NCFRsNxXrB5
 QPlLu47UIOvLLQRM7MivaYejp2UwhLIrw/GgN5EawBcFL70CD4y50P641VooYmbMqs/5eahw0US
 t12EB4zeUE9mB6AFnKougwNt9CyECfQ=
X-Proofpoint-ORIG-GUID: SdYtbHGj5eHPiJu-H2ZY6PIdnmY1ZPgh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Both cpu_exec_start() and cpu_exec_end() take a non-const CPUState
argument, however here we get that argument via PTETranslate::env
so @in->env can not be const. Remove the const qualifier.

Fixes: 4a1e9d4d11c ("target/i386: Use atomic ops for pte updates")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


