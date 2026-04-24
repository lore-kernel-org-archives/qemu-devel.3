Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356C5FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 18:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGLOA-0002hd-7G; Fri, 24 Apr 2026 14:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wGLO4-0002hM-9F
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 14:36:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wGLO2-0000kH-4s
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 14:36:23 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OGubP42356062
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 18:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6CLaZ8P+v6TBqNwINoZ5o0rmU2kNYPMPZKyLL7dufn8=; b=IQrXG/nibY3GZ8ov
 Pz0NhkbbNxsQRejLZwj9yVjh6if+3o7arZLeape4a+iC/W3RHrj7odIOR/aBtYGr
 pWg0hlYtcdKHIf8rhuc+EeRtJRkIKrEmXCJtn42PJP5Dssp/FE+7MJm8nhoML0Lq
 nPaE0hM72hKBB5CTYx9LnrCtW3pIjEnNC0GGx/paGMUsiwaIQ36T6iD9NBHX90rc
 kKliSo9w46xFPD+pXWC3ygNSAeuqFm15FJV6s/0ilEZnxYbqGjRFVTmujsyTzPOA
 3kDIDLczxCFwKFJ4KVcumFU8+MK5TE3dVT7HkPVTfBKcIbpkqMOLVZczG4TENb+H
 7gj6sg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr0fnkgha-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 18:36:17 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c66fdd4aeso12307670c88.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777055777; x=1777660577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6CLaZ8P+v6TBqNwINoZ5o0rmU2kNYPMPZKyLL7dufn8=;
 b=f38PZ+lqyYXU14E5daWcNUDLcYe1eU5fkBunwHFBU+tJz2zku/+/THd7kQftDKAIXK
 v7/OFUsVdLuLGOAMg+tyMJ/TPFe+noJfEz/6sFY5X+HAkQLfTbvHSHkIxDnKiWLTdKF7
 dwdrR52LpkPNMe0ybuFN2/bZrgmwKlFDd3jvk56eyK9+Fi6yq3nTYrrzj/+rNqO8NSME
 w2bcICo+qSqNeyUgwUxIPifrlQJWh0RpoEIiHmVZr4iTqxFPMpIPBg0iM8HzH5vUNglg
 Foz++98X07PASxNv12z35PjFvwM4PU++5f+5C4pSo7uRu1IbELkyiJ1zTSmYrawqVd4G
 J+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777055777; x=1777660577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6CLaZ8P+v6TBqNwINoZ5o0rmU2kNYPMPZKyLL7dufn8=;
 b=XuZcPX40ldwFDeNz3YIFhyKxm1scmJNoEmo2tYaFqvyqpYE42ObziKZDeWdU9kuoQ0
 zyB6yUUmTvllzFsOI9QKVjFoUaK8Q2o+PMRE6SzTvSlZYX5cbCrKJul2n3OfJN4Pkvlw
 YAYPkkyN5SqvZgQhKCTHkdkUoSXZCNq9Y+WAEOjzYi1jLIO11QFfbwq2zJPNYiUN+t+y
 H2e9wIQNVy6XXNIzKCNTbCedvjfyKwtrk2yL1dP0Ya+ahtlRFmFHVn3yr6qX2jXvIrhJ
 IiNR349yjPGnwWxBokOVjbc+ydqPQnM7k5JnFBvQ6TQFyzK8L6fEpr7JKSI4MAKPMVA4
 bz3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vTPKUFe1WrTdN5eUor9zsbD0so4xhGuiicjacS+3ePHJ58xhPe0QxoBXLaP0qLiCa0KssK9Sc+1Un@nongnu.org
X-Gm-Message-State: AOJu0YyKuWuy5rkVW+1Y3yaZNQGSnkN6AusE2wiKrHJmcXRdQSJbNDNS
 UqlhyiIhkfUOR0NQNZ574X2npATow8NRqLLQa/oDirdWTGV+2YS2aaEIihlpIq38baSJ1x3zlcG
 u6faAtUO+6F2++eL8QJdjMPgckTvFkZWM8eqgo/kTpJs+ppOiqNtvQQljPA==
X-Gm-Gg: AeBDieuI7RPX7Hk/vW6BI98PO0ZeKjvZynZYQ5ok8NmDs+PqHRs9vIrUzAVIolWXajI
 vDwJmEkLcy/6qGT9A7BTEwLOEgjJhjgh09juKMvF7r7+xczkTBcWLnW+Sq4MItK/TojSiVUWOMp
 W/KSXiL2T+hqzn7T1qDCiPNQ4ejefCpaKgjzf/0tTGg0qklgbdqdHn0QxAUtCDqHV/3AArSluzw
 7g2wySCSsnzxVPCgwrT60R8qAfiNSxXeAkCnKQVH6wVRs0DayauRjXwQAwVp2uy/BVe8LIgTwhW
 G/cLmrGmAFO3pJ7uZ6+Ok9kPaRRkK91e9oaVqq+xzNFMrT8b7rkiYGXDl6QqqhQ00qCg6DVnJpY
 14HJJI0rPHp8UQWObxOw8D2kffsEaCcYwDpzFvADv/xRHS7HR7XUfI1nUohv6v0jQSHUBKtdfJR
 5Tm6DlHVdGW9JUlGozRvo=
X-Received: by 2002:a05:7022:6725:b0:12b:fa3d:e03c with SMTP id
 a92af1059eb24-12c73f70e92mr16667552c88.8.1777055776531; 
 Fri, 24 Apr 2026 11:36:16 -0700 (PDT)
X-Received: by 2002:a05:7022:6725:b0:12b:fa3d:e03c with SMTP id
 a92af1059eb24-12c73f70e92mr16667528c88.8.1777055775883; 
 Fri, 24 Apr 2026 11:36:15 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a18a2bsm49866947c88.10.2026.04.24.11.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 11:36:15 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: matheus.bernardino@oss.qualcomm.com, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, pierrick.bouvier@linaro.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v5 01/16] tests/docker: Update hexagon cross toolchain to
 22.1.0
Date: Fri, 24 Apr 2026 11:36:13 -0700
Message-Id: <20260424183613.3219759-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <CAEqNhNbeu5-yRiMMXRQDPtKDEMm7_ZtFr_GaSbfY+yRLHuz9mQ@mail.gmail.com>
References: <CAEqNhNbeu5-yRiMMXRQDPtKDEMm7_ZtFr_GaSbfY+yRLHuz9mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LfYMLDfi c=1 sm=1 tr=0 ts=69ebb821 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=qC_FGOx9AAAA:8 a=KKAkSRfTAAAA:8 a=vdlmo74XPWOaZmV8mBQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=fsdK_YakeE02zTmptMdW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE4MSBTYWx0ZWRfXzI6OcN4lpGwZ
 MucPdkVygNh/pUaVZP1+MMd895DDfjKOpw51zaI9nb56Xk4nosfkNmVCxtQ8JjcKhMPshENzz65
 4B7OmjOdNWoYkHoQ4EVG3BLnFhjQ0yMzkyAhqTwZYZV8UZrn5b8pmM5AdPhNXKJSjLUD5Y2pbQz
 AHwLtfg5cc8jMvsELOfCV/uM5CnSDoM1MyIEzRCQrRkObVRS55OV+hiXdtv6x6h+CckKGe9FJ+9
 7EHNqvnpopeLKOiX3DFVpE3GMaysMmyw3LULpp7frNB9MmXzYQm13+tmXpXJyyx8X4vpfpfnX2f
 4UtdvnD6lRuDpWXELYLWjLHI9Yc5hdtqKePL3LZQ7Dhn+6NgcgGUE8AXekghfqsc1a5qOXuFo0/
 1Qu4fo7cUUghXffQHmPyLmLZXU5oCdbmo3VlFJEVD5RtPuSKd9CJqyIvht2M3Wz7kWTfx84egww
 Bgk9vsjvjRoCPw6usSg==
X-Proofpoint-ORIG-GUID: 8MPz_ZOjeWffRf6Nu5fPgvZqcYeSVdk3
X-Proofpoint-GUID: 8MPz_ZOjeWffRf6Nu5fPgvZqcYeSVdk3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 23 Apr 2026 20:33:37 -0500 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> On Thu, Apr 16, 2026 at 6:39 AM Matheus Tavares Bernardino
> <matheus.bernardino@oss.qualcomm.com> wrote:
> >
> > From: Brian Cain <brian.cain@oss.qualcomm.com>
> >
> > Update the hexagon cross-compiler Docker container to use toolchain
> > version 22.1.0, replacing the previous 12.Dec.2023 release.
> >
> > Changes to accommodate the new toolchain:
> >
> > - Add libc++1, libc++abi1, libunwind-19 runtime deps for the new
> >   LLVM-based toolchain
> > - Add zstd for the new .tar.zst archive format
> > - Update artifact URL domain to artifacts.codelinaro.org
> >
> > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> 
> I was queuing this container change patch up but ran into some issues
> with check_rev_gating failing, seems related to -mv66  vs v68 ELF
> flags maybe.
> 
> Matheus - can you look into this when you get a chance?  Is it a
> problem w/the toolchain or the test case, I didn't get to looking into
> it yet.

The issue seems to be that we are using -mv66 for the check_rev_gating.o
compilation, but not for the final linkage. Since the v22.1.0 toolchain contains a
crt1.o compiled for v68, the linker resolves this v66 + v68 linkage by taking the
highest one. Then, the v68 instructions are not gated, but executed, leading to
a segfault. The following change fixes it:

diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index 09f0502abc..70a8ec2e7f 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -112,6 +112,7 @@ unaligned_pc: unaligned_pc.c

 # Compile for v66 so that the ELF selects a v66 CPU; the test then
 # exercises revision gating by executing a v68 .word instruction.
+run-check_rev_gating: QEMU_OPTS += -cpu v66
 check_rev_gating: check_rev_gating.c
        $(CC) $(CFLAGS) -mv66 -O2 $< -o $@ $(LDFLAGS)

