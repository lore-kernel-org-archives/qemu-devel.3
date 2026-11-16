Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088D1606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QLtcKav6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EazNKv5a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSsDz-0006Vb-TC; Mon, 16 Nov 2026 03:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSsDx-0006UR-DV
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 03:38:01 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSsDv-0002aT-Eq
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 03:38:01 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG7f05s424030
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 08:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7oD50X8cW3bmIdcheD+z3z6SPC/2uRI5TAHho2UnIX8=; b=QLtcKav6WMFT+NPt
 7N4e6WPx+jp6ooUawHoEt8HLlvqEPDwvZ8H1kQ2tMhxhs+Ep/R78cNPlDFeBsqHK
 qE0o8Ehyv/fIKUVqq8Qi5xLQxR2QD1WACeRFaW32Mx0xEHcm1cvQi+k0VsA+OoQg
 dkmpvHVZfucox23Or5KcrP0/yGbanYRLVAClQV45wQce1uRl8lkFOZ8LKFtcU1dO
 SPuGUIUI/MVoDAd1wX352ONVCC4aGCKicQX41FRpGvFeqehoxhPTURQRzqGH9O/t
 OFpSMnB4E4TkXwOu/NMuw/W/vmwPgsUGpTqZ6b1xpGPhxYQsIsxFOYgNuQmp8hiC
 pKdbZA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhkwdhh7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 08:37:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94967c6d4f4so145408285a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 00:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794818275; x=1795423075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7oD50X8cW3bmIdcheD+z3z6SPC/2uRI5TAHho2UnIX8=;
 b=EazNKv5aZS7ltEo3cnKddn6ckGhNw011+BRPiUiIeq/7mNQr05AJIkE8wbQqwWexoL
 sKX5Wjx7CHSvg1RDQP+GjqBob7UUzVW7bS8ju8g3FHsFG4QznDxxyjo+aBe/mda7nXsw
 DwBoR5kXLEsxKq8/N3hR/USYFPn1Y35fmWuVw6QBaojiA655GNG9tqQPAFmxMGPjoW3x
 Ean2L5dkQqAruVpy0jUX3Vbw4oRkqJSCcb6hvIeaFCsAumyyWYdR6JCHUOwJDGMhN0+O
 RB1gKfcZyLOuXZyLqz1B1sWZImx+cY1EB3hVhsOG8VxKXoCefKACkJ98ym31TmXI1Mn/
 kn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794818275; x=1795423075;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7oD50X8cW3bmIdcheD+z3z6SPC/2uRI5TAHho2UnIX8=;
 b=mPz+K+YXL5tfx73qSAFUGLFtiNNtCaFA922bWo3kAL9JZz/13LfKIvJ385LtWZoCmP
 5I+Rl/ucbnjzq1oN4KHtKcpxz1ny5Ba7/8z4MU2KDHcj4NplaNv/Y/QOYDJrdKWHuXAc
 A/dcJdHL1L2UsNcg3c0US/HI1KssWDnG7Xp8GkR2PoJfxUGL3S8379XfJWvoDGSC3l4/
 yC/ZukOr4bqY4dLnFuT2mCLVSHzt1eGHs2S1q5ex+af1+hDQVS8hvKlE6uEm73Vaqeul
 70vgNjXT5ykMCCCJljT7PFM0PbSmBAiCqRHy2CdCB3hZQPwvfqaQeu2N7GN8bV6iLIyt
 xaZQ==
X-Gm-Message-State: APuU4Z9WARiCKPaALKgOT0s8G4AJL4TBKSagAfinBuLQJsr8toBCMSAu
 mCGUbPjskuyhXtLXShUm6HzRTqaliIhp7kEhB82FBsm2+2OtavX5MQ2ewTy0pvsh+bI1YHkSrBN
 hQI/WNb6PP/z5Mw3HJz8FgLOHrJDpUHW15rY8SNGMVDIA1yzLEZkOLb17sA==
X-Gm-Gg: AYBFou27GnqNqKQoSvM/K2iXzQYxZXBKEYuBCPmLsnb9+Yz+U4NzgqfU45wN/SWilwj
 36//nMmVSl0mUgcDRlAFJcrsmjt0g755KRSabfiu4SZeKUdTV8BOCcZIzhW09FkOYQCqEJbjBVK
 SjJBImbV8cJHeH7vLDrLz/UlSyTjGH6mZgmkTaVQSJiAh+sGZeQop2vwdWhfNP+JhlhCTNhYPq6
 UL4QMf4WF68C4/Zj0/LXYB4JqZC4wqiv7OeHMRtujxhg9oAHeLNhhpdvRf6eLmrEdOoUea4uAF9
 ceDTuIicj/l7HRrriUikwfT92QfOx+GAzN5ilWypztxR3ILBnEJ0WfKpfQtCuP8OA7cNVG4Fw/w
 t2JRTnTliX4ZIEmryAfht92Ws/UeSaMVD3TZcXJNOe9ISpDVCFOgHgmHBV0IG+0Y0lI2C27CAt2
 Z6mPJNK98=
X-Received: by 2002:a05:620a:1a09:b0:93d:23b3:5088 with SMTP id
 af79cd13be357-9494bb88e1emr1567765185a.16.1794818274881; 
 Mon, 16 Nov 2026 00:37:54 -0800 (PST)
X-Received: by 2002:a05:620a:1a09:b0:93d:23b3:5088 with SMTP id
 af79cd13be357-9494bb88e1emr1567763385a.16.1794818274331; 
 Mon, 16 Nov 2026 00:37:54 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c608d10b2sm35086140f8f.44.2026.11.16.00.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 00:37:53 -0800 (PST)
Message-ID: <f749e844-5f7b-4e5e-9251-40251c531b82@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 09:37:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] target/mips: Mixed bag of fixes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Milica Lazarevic <Milica.Lazarevic@syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <CAFEAcA8G-aoxoeEOy2SyUcYyrfxMazHZvB+hfZZYOrbMcmhxkw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA8G-aoxoeEOy2SyUcYyrfxMazHZvB+hfZZYOrbMcmhxkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNCBTYWx0ZWRfX1y7CqkvbWoBx
 3/g8/J+1QdH5+K4H4GSY+VN4nzta1yeQXKWzWeWkukgiLlslRH8/MP9/+iovAtwEbU0T223VLFu
 Af/+K0ZRwR2HzdDFNLtPIC4Xqpwh+rZPnSYP8SrbQeUA1Kd01grUQ0PSQiTokR/IfGqYF+UhEKM
 AMDRmsFxPDFo5QZCG/SFJneb03J77BBIy6oXT2nbYAKHln1roOu70OGHfkyP+0hQY/N7bPSxkT6
 9ewgVssEo1OSsearX2QuEjWyvXS/PX4DBEpUAF0klfreqgguFbYMHFNavCYJJlRz6fgWJhk88+n
 y/PIiAalbybOoU5fXMhsTjSC7SLsZt1Eqlomqe4WljI1Jc3h8JzDn1zBHY3YMLowIrRMfNVLpx1
 VPVqbEeb8T+O11066rGZ8Hy2dLn1k9Up+jGNwO5RjT1NA8IaBOvVT3qrAL5hHchoip60saUuKYk
 duUulrRJuHzSVsBsIFQ==
X-Authority-Analysis: v=2.4 cv=YPYKWhGx c=1 sm=1 tr=0 ts=6afac0e4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=FpiuORI1F0Xz9028B2oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 6-IKmorFapeunz-uiVv_4-2eJMmjnhQt
X-Proofpoint-ORIG-GUID: 6-IKmorFapeunz-uiVv_4-2eJMmjnhQt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNCBTYWx0ZWRfXyLuZmE+iUnY3
 RDZ3L+RrREEmTf0mQdxONud3kwv8+GhMvZ0BoCz5+HcdXXZ7rG3IW4fB0MBSP0M4J7l4XCnCQ//
 TszSPveID65TnuDN5UWjjX2BGypthuw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160034
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peter,

On 13/11/26 17:34, Peter Maydell wrote:
> On Fri, 13 Nov 2026 at 16:13, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> Various individual fixes noted while reviewing manuals
>> during decodetree conversion, and using a RISU prototype.
> 
> If you have a little time for MIPS could I get you to have a look at
> Coverity issue 1689817 ? It's not urgent, but Coverity complains about
> what it thinks is some dead code in the dextr_s_h helper:
> 
>      } else if ((temp127 == 1) &&
>              (temp[1] < 0xFFFFFFFFFFFFFFFFll
>               || temp[0] < 0xFFFFFFFFFFFF1000ll)) {
> 
> The compare with temp[1] is very odd here. The constant has the "ll"
> suffix indicating that the author thought this would be signed,
> but the value is 0xFFFF_FFFF_FFFF_FFFF so it doesn't fit in a
> signed 64-bit integer type. So the C spec says it has type
> "unsigned long long" (because it's a hex constant). That means
> that the comparison is int64_t against uint64_t, which causes
> temp[1] to be cast to unsigned and we do an unsigned comparison.
> 
> The upshot is that "temp[1] < 0xFFFFFFFFFFFFFFFFll" is a funny way of
> writing "temp[1] != -1". So I think Coverity is wrong about there
> being dead code, but it's confused because the code is written in a
> confusing and possibly wrong way.
> 
> The comparison with temp[] is also 0xFFFF_FFFF_FFFF_1000 with the
> LL suffix, so it's also not really a signed value or comparison.
> 
> I don't know what this instruction is supposed to be doing, but
> it would be helpful if somebody who does could have a look and
> rewrite the code to either do the right thing if the current
> code is wrong, or else to rephrase it so it is clearer about
> what it's doing if it's getting the right result in a weird way.

Although MD00375 (MIPS64 DSP) and MD00765 (microMIPS64 DSP) manuals
list the DEXTP* or DEXTR* instructions encoding tables, they do not
contains these instruction descriptions. We can infer from the MIPS32
EXTR_S.H semantics which saturates to [-0x8000, 0x7FFF], sign-extend
to 64 bits and apply to the 128-bit HI:LO.

0xFFFF_FFFF_FFFF_1000 is a typo, should be 0xFFFF_FFFF_FFFF_8000.

Fix using uint64_t and explicit comparisons (positive values with
bit 63 set in the low half were not saturated, as that half was
compared as signed):

-- >8 --
diff --git a/target/mips/tcg/dsp_helper.c b/target/mips/tcg/dsp_helper.c
index 73934cab7786..1d4d54897dd6 100644
--- a/target/mips/tcg/dsp_helper.c
+++ b/target/mips/tcg/dsp_helper.c
@@ -3379,22 +3379,21 @@ target_ulong HELPER(extr_s_h)(target_ulong ac, 
target_ulong shift,
  target_ulong HELPER(dextr_s_h)(target_ulong ac, target_ulong shift,
                                CPUMIPSState *env)
  {
-    int64_t temp[2];
+    uint64_t temp[2];
      uint32_t temp127;

      shift = shift & 0x1F;

-    mipsdsp_rashift_acc((uint64_t *)temp, ac, shift, env);
+    mipsdsp_rashift_acc(temp, ac, shift, env);

      temp127 = (temp[1] >> 63) & 0x01;

-    if ((temp127 == 0) && (temp[1] > 0 || temp[0] > 32767)) {
+    if (temp127 == 0 && (temp[1] != 0 || temp[0] > 0x7FFF)) {
          temp[0] &= 0xFFFF0000;
          temp[0] |= 0x00007FFF;
          set_DSPControl_overflow_flag(1, 23, env);
-    } else if ((temp127 == 1) &&
-            (temp[1] < 0xFFFFFFFFFFFFFFFFll
-             || temp[0] < 0xFFFFFFFFFFFF1000ll)) {
+    } else if (temp127 == 1 &&
+               (temp[1] != ~0ull || temp[0] < 0xFFFFFFFFFFFF8000ull)) {
          temp[0] &= 0xFFFF0000;
          temp[0] |= 0x00008000;
          set_DSPControl_overflow_flag(1, 23, env);
---

But this is a good opportunity to rewrite in a more readable style
(I'm not a fan of complex condition checks in particular when 'else if'
is involved, I rather use local self-descriptive booleans); the same
fix becomes:

-- >8 --
diff --git a/target/mips/tcg/dsp_helper.c b/target/mips/tcg/dsp_helper.c
index 73934cab7786..82a9a29c0213 100644
--- a/target/mips/tcg/dsp_helper.c
+++ b/target/mips/tcg/dsp_helper.c
@@ -3379,28 +3379,25 @@ target_ulong HELPER(extr_s_h)(target_ulong ac, 
target_ulong shift,
  target_ulong HELPER(dextr_s_h)(target_ulong ac, target_ulong shift,
                                CPUMIPSState *env)
  {
-    int64_t temp[2];
-    uint32_t temp127;
+    uint64_t temp[2];
+    int64_t lo;
+    bool negative, fits_s64, fits_s16;

      shift = shift & 0x1F;

-    mipsdsp_rashift_acc((uint64_t *)temp, ac, shift, env);
+    mipsdsp_rashift_acc(temp, ac, shift, env);

-    temp127 = (temp[1] >> 63) & 0x01;
+    lo = temp[0];
+    negative = temp[1] >> 63;
+    fits_s64 = temp[1] == (uint64_t)(lo >> 63);
+    fits_s16 = lo == (int16_t)lo;

-    if ((temp127 == 0) && (temp[1] > 0 || temp[0] > 32767)) {
-        temp[0] &= 0xFFFF0000;
-        temp[0] |= 0x00007FFF;
-        set_DSPControl_overflow_flag(1, 23, env);
-    } else if ((temp127 == 1) &&
-            (temp[1] < 0xFFFFFFFFFFFFFFFFll
-             || temp[0] < 0xFFFFFFFFFFFF1000ll)) {
-        temp[0] &= 0xFFFF0000;
-        temp[0] |= 0x00008000;
-        set_DSPControl_overflow_flag(1, 23, env);
+    if (fits_s64 && fits_s16) {
+        return lo;
      }
-
-    return (int64_t)(int16_t)(temp[0] & MIPSDSP_LO);
+    set_DSPControl_overflow_flag(1, 23, env);
+    return negative ? INT16_MIN : INT16_MAX;
  }

---

Is it reviewable-enough to be a single fix patch or do you rather
that split in 1 fix and 1 refactor?

Thanks,

Phil.

