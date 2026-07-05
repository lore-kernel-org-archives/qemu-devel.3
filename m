Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDB2C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUtC-0003Fy-Vi; Sun, 05 Jul 2026 18:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUtA-0003C6-U1
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:00:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUt9-0000w0-80
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:00:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxldS2716618
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 22:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gfohBGLaZbWwSsM8BLb51a9USAKrCnCAVyI6ZJxJiSc=; b=Es9uNhK740CyD7QO
 0vAR11NLavvL7oXzexZZiOXbbsnuRaNjL3nZJGXiPG/gTGPVPxCdkSWdlfal9LsZ
 hrDlEXkixNSC1PNR1MbwGmhhH1GyX9ZYLrVkbo6ECPyt3cDE50GEvpv1dEAoygdY
 yU43jFWoN8oe21SJU4FAWS7KIZynZt1Wy97l+wwCK/mXEdZL29ZwL7SoSwxUu9w1
 mRUpCtbQ/u7zS5jaMrfJ7ux4tXngWEdARp2cMuay+2j0I+S1b1zjAQRIXCDUP3y7
 TLZiM//G1wdNAUzqX2wffvNUqYcJ6KFXI3FTOsIS4Y7WZZ9qtVMY8M2cw9H9EPAf
 7+Jhrw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txekdxb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:00:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92d1cae5740so261862685a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288822; x=1783893622; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gfohBGLaZbWwSsM8BLb51a9USAKrCnCAVyI6ZJxJiSc=;
 b=d86MqNlEqui4nqrY0Lv2SkgFxeFcuf50yfEajGdO71k+rgvhy5Ve88VbgdJBPIS8PT
 pQWmxpAqGJkwLl10z86mdwBNHIUA+pMYKgBdP+SqLLS+MAKE64zGV10FqWVkhiPdX6lz
 iPKIRtBBRuSX/nM5CPAq9cacbgye6dLNVuCzWP7HdtMhZXXCQLn82z362TKAKKiZAQHJ
 3Xk+9RiMHofQkgf1wVjIQCVBgJZ3tepAE5VkGYqsuAEFfKJNvk/YpT+Byz/V55u+1f7D
 fM3apmALiA6TZb8jW1rl4+KDmE1XvmGE/Z5yIoEvnfjKIpKIyRK602UHohBs2vcR98jc
 kB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288822; x=1783893622;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gfohBGLaZbWwSsM8BLb51a9USAKrCnCAVyI6ZJxJiSc=;
 b=r2uE5gIVWpmSyOZ2L4CeV7pt5qUV734SjExb48ZPTNJisyucboLsdOWLW55xcV/ZbJ
 IIS3/V+STZ2iI3XrFHSnTUJ31eiu8NjYmG3ocLDbh55uxst+me3kYCUpy2jaova07epn
 jgWyIfM9wimlhglzue6Tj3BjzDqAZnvuivILiJFudRkslOUgPse2/4oSrImX5+0Hv0UE
 5WotwmRl3/HuM6mPmdKQnd2K1xpX6b1S0Q1S8bZ5kYmV8EvM1/RL/DfbPz48brdb+Z80
 iiPpFdu6Tn+3Er4X4ZUdka63u3BNuHsgEnAapbZ17V+FQr4LvfWYROGVdHpx1dqczxvc
 69Bw==
X-Gm-Message-State: AOJu0YzrK72rTF6ys04u7v2fHjpyVuI/WQq0IqoqMgIbgzLjzJvCtgbj
 DJi6waKy0Q1xl+Pl0HRA/FVhW6CTWF86a/CsDw9vGTW0XFC4QBwptd0IEsRYvnnGmIN2R5XpM8E
 QiFB/zO44Wm+uRqEEcM3jFeK8alHfdCxo9vI3FsMP4ENLLMWYVFwbaOrl84EZm27xEw==
X-Gm-Gg: AfdE7cm8Gux/Rd0lTXrp4gANzBciNu2Q9svPbqrwLLAla1Bfz+lMh2EgpvytDqaZ6RM
 +RsrGcElcUQqxLEqUD+wytsNd3phYGKBr9okytNzwYJioLJBTFfNMSjdbiWmzjRIXcQsbVCCp21
 P4U1V6cUgB7Z8Q7C5+PLOdQdlGhw92Fe9EOvL73c+sdgeL2AoBB2hFloJjoCy9yRJXKlhIJbeen
 Z/wRAtu6b8wF3dEjjhEqsOoTgGyj/ggmiTq8lnauOE6Ge4JXiOUlngAGQuxAcEQG5FBS0v30PB9
 h0RnrF8stmd7CB6jL+KXFJR+U4cBFM/Y6CKTFtsgBoOLVJTltGzRVQAs36W6IBT99KOoZsoTgfz
 vNCxnR9wuNrtlU7VuJkIxuZaGw/x9ou7xzc0TeGptEm65DhUt9oGMGgxbbF4Ho7Czvkyh
X-Received: by 2002:a05:620a:19a3:b0:92e:60cd:9073 with SMTP id
 af79cd13be357-92e9a3a3b80mr1235621585a.23.1783288822271; 
 Sun, 05 Jul 2026 15:00:22 -0700 (PDT)
X-Received: by 2002:a05:620a:19a3:b0:92e:60cd:9073 with SMTP id
 af79cd13be357-92e9a3a3b80mr1235609185a.23.1783288821496; 
 Sun, 05 Jul 2026 15:00:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c636ec8asm265412075e9.1.2026.07.05.15.00.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 15:00:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 22/32] gdbstub/user: Directly call
 gdb_breakpoint_remove_all() in user mode
Date: Sun,  5 Jul 2026 23:57:18 +0200
Message-ID: <20260705215729.62196-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX1oayr0+iY66o
 hKXUcmcGwEMvkJz8HMIv4IwKd++BYfAch22A5TTIJp7R04/MrmhX9XUrzDKK6useopwA0mw2pxF
 dUqLanZiXIou3itgEshqLetPeQERd00=
X-Proofpoint-GUID: O2yrqSpBruDBnNauXD3jkm9-PHFcNLuU
X-Proofpoint-ORIG-GUID: O2yrqSpBruDBnNauXD3jkm9-PHFcNLuU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX7sOb8vtcTQJx
 8zErBFwjKN1dMIsQQjVyz31NCZKbPic8AWy95Hz3dWzhuZVyeneZqMih++c/HaE0e/gwT3s9sOI
 FDaQCkUP3l65I0c7uSHwY18AhP8ag7fcoPHj0xU+IclkgcdTXX1HnEyU27IpqZcKZolTOG5xw86
 PC0Q3VWGpQZr+bl2/vDA9WhTQi7+kQ7E+/xuSfF1OppbZbn9YqnFhw0HKdG/AJwrjP1d78Z5cp5
 RXLB8J2lg4uuwpxJgFtRYuH4194Erazy6rCJFEhQb/2cbVOpEuRRuyDOMCazDFO0cd3d+cnOfJ6
 ekqOX5mrqpwYrPkmPxpHm9OfBczgaDFQXGIHatTaxTWdsquu4GTqLFRNwCWquHxRURwRqIHWDx5
 /F9nwbdWsrfDzahZYXIRg/+udtDXvP3/LMXygXLbcizeXYS4Eu4WydTYnoqEGtf/lnOxd2mPQio
 AHQA2Nenwspj1CZ5O5A==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4ad3f7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=zxLOgqzoZ8asriTz2EMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

No need to deref external methods with unused argument to
end up calling a method defined in the same unit file, call
it directly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 299388b9f71..90d6ee49fb5 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -557,7 +557,7 @@ static void disable_gdbstub(CPUState *thread_cpu)
     close(gdbserver_user_state.fd);
     gdbserver_user_state.fd = -1;
     CPU_FOREACH(cpu) {
-        cpu_breakpoint_remove_all(cpu, BP_GDB);
+        gdb_breakpoint_remove_all(cpu);
         /* no cpu_watchpoint_remove_all for user-mode */
         cpu_single_step(cpu, 0);
     }
-- 
2.53.0


