Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80B4C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUuH-00048G-Oj; Sun, 05 Jul 2026 18:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUtn-0003y5-RO
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:01:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUtl-00014c-8c
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:01:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxU7a2786998
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 22:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nKWbeV6dy1QzTcg2r2krTsk35PC3Q8z5Zx1L07HjdlQ=; b=V+5NbQqexvTy+QZz
 tkTDVHQUWFI3gNoM7fv0Sll1+XNc6+8X/jQiVo2MwTiJBHx98JXPF8CFHoGmd/Qp
 srisZHHHhdLyZnFeAhFMKi93lkB0nb2x9Y6vq0yf2z8uxh7E1dKy3jBcLlQBX572
 SHGbvPvB/PUK1kayIpsE/0Vk64LITM5PlfrXSWojqKEtYVClNPa82aciDGCWdtiw
 lbeSIh0rRXBInLS9p4qr5HCJVy0VtPsk9BSpAtNuM0EFNioI7dSf80TsaVaMbaPM
 /zF3Y4Pn+TRjdoofjtxV1fqa+uZeNttLDBzCmG8VD6hcBQJG563no2h30X8K7cIS
 c+dm2g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qhnku2u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:01:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e59b0e0f4so167827885a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288862; x=1783893662; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nKWbeV6dy1QzTcg2r2krTsk35PC3Q8z5Zx1L07HjdlQ=;
 b=Dr9yLh05E6WYuPV1iSTT6sgf82MVgD9X2Q3D30UzA+G+fOLF8gk37NAC4uNCn6xbAt
 PxVIqs9yFi75VQwTMBa282/r4j40dUqi5DOwR9BNTlAFlLeO8KUPGP8jv17oaQBXpMmR
 w4mQMSBDNs6vb+fCcwA0Ge0x4YAZaTbCVmcDwXfRLTUhLETg64keslSm56aZC5sg1ffm
 LegIhdzbxFkm6yBM3qUMu75LcVyNhWcpWQh3CtSeVryH7VTJzmaOBoc1HQwSGnAUFYFQ
 ko4rl0GA4pp0g+Jf/2R0Gm6xXzV2GMvz48s9yT9xmh7w6vd1ySq8KVeSHgf1y5T6QdjT
 qwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288862; x=1783893662;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nKWbeV6dy1QzTcg2r2krTsk35PC3Q8z5Zx1L07HjdlQ=;
 b=TlKRzdH/69F0MUH9ln2YN7uMHXAVG9xxpconhzJdZ+jaKzKnpIWa0vCqnua6jAt0lT
 Fz5H4BNTG4J16PR3akGSzlg2wBoIPme1Xfry1O1Lo4ErRXsEp4m3ed1XdmkcDC1DOOeX
 qCv24o8rgUPCEWZVKvNLQAEle9pU0Kz1rkZKUrZAcy4Mgym0HdQb98iU5b07kDgJbKpM
 5DRzeVEkb/qZYPyQv0+AqvMyCmVTnlWn4M5gQWvVPkm+ddVZb6J6JBiAWHlRnbevojpc
 kBuDBrQWT6oy8s8W4JJt7PR3pUGjR9J4FCDLKYhiZrGOU1gAJpu+kj8VrDTcgbKtI8O9
 Z41Q==
X-Gm-Message-State: AOJu0YzbcBKsq51Ll1Q0J/9lQo8bFM7AB7Z/3fVrWj0B6lnYFsj3Ww+9
 TpF2V25LuEl8orbOwu/+jwlGjW//TSIHk0GWsY0UHG+vsDwMGIJeL723bPEDEf8YtoIrV1BQ2pa
 GKFiijNob46x9nX8xh/s5RAuepCXBB3nS5OhowBW847n0sIWdJ11qKP3oxDDNSakx9g==
X-Gm-Gg: AfdE7clERtt8EzXNPe/QO6sou4j6y3BbDv4bhEwFI5Sie2dxT1H/Q6YZ4G6SoG0wdPG
 03tOIJ8Ppr6cBANmPq/SqRBseMrWDHnj67tlKQ++tJIE2fW9Reb719rCMK8fd1Wwl+zt8LwT2Dp
 Z9r6Eznh+6UiwgRy6uixtdqeBLNuBbTFHhM2Zs8J95KQsGtGuTv1NKOeCVmX76W6xpsnkXbAmvA
 3C3hR4e/lC4Sp9+8Df7KGud0gXdYMpxWUu0Hy6ezwiltb8b9LYjzwMj5WSaPwSE95zd5a+DVp59
 sGcFD6sr1OLwg84tisB+jIz+bHbIDEF+elVW1ptevTubvhC8YOM0qeHa2fckBzHMlvtGVtWHb/+
 4PrPXBwUnYoThXwpzkfBWCL8rvRusdoG732WWiDjQAKJrYiueK1grvA==
X-Received: by 2002:a05:620a:701c:b0:92e:5259:1154 with SMTP id
 af79cd13be357-92e9a48ff9dmr1053791285a.39.1783288861435; 
 Sun, 05 Jul 2026 15:01:01 -0700 (PDT)
X-Received: by 2002:a05:620a:701c:b0:92e:5259:1154 with SMTP id
 af79cd13be357-92e9a48ff9dmr1053775085a.39.1783288860320; 
 Sun, 05 Jul 2026 15:01:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960af0sm17731708f8f.30.2026.07.05.15.00.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 15:00:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 27/32] target/ppc: Ensure TCG is used in ppc_update_daw()
Date: Sun,  5 Jul 2026 23:57:23 +0200
Message-ID: <20260705215729.62196-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX5WM5LXTZoi2e
 qpK/9JgBYl6/ZdnNcvUa30l4PkuDj6NJSFvLlTwu+M1C+d7zzKYjb6jyhiVepU3uY1ZEd6AmtaH
 k3Y1V+d/mR4a/4wvpxWjwP8NgM9FTFQ=
X-Proofpoint-ORIG-GUID: ck1x0H-PqHCC16CySwUWcn2ONm51eLow
X-Authority-Analysis: v=2.4 cv=J+yaKgnS c=1 sm=1 tr=0 ts=6a4ad41e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=nS8E-dRYisaDM6zJQEoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX18/v3ssknxwm
 ipjlionqH4BVQwaR4mxjTmQ06GtkhseFwa/bUAr5Wpv7jU97HuPblY/jmzuY+exQgSyZCwMZhON
 HDepsGaCstStlml220S3zUVHRt9jnr9DSAc+e/q6XEkeldAcKYFKM6rNoRLJulf6QLcZxoEQl6o
 IUBKmqXitEtGHW7dipg1VsxaM2t8ku3PBOn/LX3fHeOjODPRYKGwQ8UTBS/B5NuTuWpiT5Igw1H
 9aHwUjdFRPBqMieTCVB0cFvuodzMNTblloRE5uZDiT1z/3nQ7sy9znukNb2xyF8YhSluLvE067o
 rkwOcdUK3YJGi0BoeBWO8TNWpwjClQaZTuTQSCw+ssLidvQkcE351p2WmhqX9kP+CU0EHtO4PJE
 DLMTU3zwFdkMt3TO8oYoO6swnz4fZuESm/d8GBO9fI/kTSmtgHfLH/iFenW3y+tbAAhCsgeNZeO
 IG40JTHPkahyKWs5bhA==
X-Proofpoint-GUID: ck1x0H-PqHCC16CySwUWcn2ONm51eLow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
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

Per commit d5ee641cfc5 ("target/ppc: Implement watchpoint debug
facility for v2.07S"), only TCG is implemented:

    ISA v2.07S introduced the watchpoint facility based on the DAWR0
    and DAWRX0 SPRs. Implement this in TCG.
                     ^^^^^^^^^^^^^^^^^^^^^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/ppc/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 913920d55b8..36e1209119d 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -147,6 +147,8 @@ void ppc_update_daw(CPUPPCState *env, int rid)
     vaddr len;
     BreakpointFlags flags;
 
+    assert(tcg_enabled());
+
     if (env->dawr_watchpoint[rid]) {
         cpu_watchpoint_remove_by_ref(cs, env->dawr_watchpoint[rid]);
         env->dawr_watchpoint[rid] = NULL;
-- 
2.53.0


