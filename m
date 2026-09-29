Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320F2CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBcj3-0007nm-6I; Tue, 29 Sep 2026 14:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBciv-0007nN-HM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:38:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBcis-0001ZA-2J
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:38:40 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68THg3ga3936714
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 18:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 03p2PDSI7Nv5Yy/KxdHsONQIKJ13J0iTVChphpMVhuQ=; b=hkbLLOgQDtjE49ld
 G/mEUSJfadpid7dZ7V3nGqFq/ztVvIULtLJ3F1oDlPqfeKgUNcUNDp4sjInS8rJt
 7w3Fm1GREDEqGZWKeNmZCdf3lW9Hf5fdcrPr6gO0yKyOrKNPUXgTxyJa9Qs/1j47
 3hHv8z2q3jX446kuNcGtufuoevA2/raGflTH72VRRm+AYMhrL37w6R86xqPGM9qx
 wYU25tlnJ7IOjir9MrlRSSNJ501eFSPDeXyqiD59j9e9a81/pSmqYOyWUMTFc4wh
 kvp8dHGMvgb7GOFLU1xJ/Q83Bw38rL5e3fy7HpLu5JHDeKtj/u4MJJgu21tnECUy
 SFSTpQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0bn1j73j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 18:38:35 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-349ffa249bdso3661865eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790707115; x=1791311915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=03p2PDSI7Nv5Yy/KxdHsONQIKJ13J0iTVChphpMVhuQ=;
 b=WeBme66fOqWEiZX/eqIrlFXiyQ5uyFb7rdrNQCXYRwGa+2eDnvMqhylh0P09LxrCbk
 kuNmv6XWis/Iy9LB23Ak23xqmTyyNbEYUot86tM4gY5XBm0tSQhBfIH6bRI9xxm/lXvv
 53Ib30WqzxJ6fu04KYJhF0UOX876y/NMUKyjRf4Hm444Adx6S9xKjPdbF/kULVUgda5K
 clRWQDBRVrHdX3J3Qp4hYLBPFVhkwZ2ieQ4/fnxjy/S1ygpeg+LhDZisWHIX5cCv8b2M
 skf/BHQjPCgev45J/1ic6zL+Zmb2YFdeC7Jq1HxFqhLq/42fVJgsRJGSTLsfFZ3SBxwH
 PhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790707115; x=1791311915;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=03p2PDSI7Nv5Yy/KxdHsONQIKJ13J0iTVChphpMVhuQ=;
 b=ZjFDnodPK1evqItQre8TvbtjjQ7Wpezc0RZt6OI5uYulCkXGOROKTsaOUDflSJoeiP
 rRa/R/lqTGE+x4FguYSSticUI3NBvXSAudT5PIUOfrKg+wXMrUyooIRnV8i3nM5jl1Sg
 4F4Md8Ykd8YDX2puwbhkLVe7i0kvJBiMzlu/IPErji/PBgTa7k3t0jCIqRl+kZsQXDVp
 SiQTqJ48h49s8ddQc3nqYdan/ENDWX7JJJdV4Dc56DZzHLafSXEsLK4BmMAQx+GivWui
 L2fvtYZQz1VcaQ5Q5t1y6QiM8KWF8wPT60/BXCWF7embNvLt8Viw8/usUvPi6dVmaBfk
 pReA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxlkZs/QdmAPm6iV9cYQRh+iZohM03OcfxGmc2+SuWJ/4L0MytMhn42LocPejlQIm94KKUDCL/+RO/@nongnu.org
X-Gm-Message-State: AFq9FYKPWq21KbsbQD7+vyCXVUG4o6xbFLDo/ADfJIBxIixgZ6l1462j
 glaVBqz8UPmCKFcj8ncQCvmtmwQC4eWL5vfeJvnbTJ65eLQkLPswHz9zMkixAcBS0GriZdNg5Iy
 CbL+ONEcyvhSQQADYOl+K6J8vpNOE7JkvMYuNsNKPL+T/+HEW5engs5VznA==
X-Gm-Gg: AYBFou23vr62VRSYK+nPzk5rqKHoM27yZlJ0xPaI0+5oh3DyrdiYEmTxuN79UoMLpdF
 YpgafyVKtpVxCeJGIBpnOFDmRdktGMcW+j3XFnQ+GkBufyPkwDYHcf5+3S24vJnP6+TLGJ8Qz93
 aGuWHemB4yMhuz3FPbZMXypCDBRBUoM5qDbbUibgYVGCEWEvjse/odFFBRz0/3dR9z7s67W2zE0
 4IrdZOJPs2ScUcSRRtOWK3BgGZ6VoOmOlVogbhAdYijcbz21P/q8K5duLPaNzL6Yrd9wAT0XC4x
 Pctn0C/hSPbzjO0/8gMZzv8fB1hacLGsFQSaYKbD+GxlmxsNW+aCHKUcSiQOuDgpbH+aSNJf8DY
 Y/Rig+v/5tXhVuUYC/c1vryiDkUWdARYeyTEJvqTEwr0BN1dumxg8tjJgRk2Y97+vNMb0Eg==
X-Received: by 2002:a05:7300:f3ca:b0:341:4f3:8f84 with SMTP id
 5a478bee46e88-34c660540e4mr193733eec.13.1790707114982; 
 Tue, 29 Sep 2026 11:38:34 -0700 (PDT)
X-Received: by 2002:a05:7300:f3ca:b0:341:4f3:8f84 with SMTP id
 5a478bee46e88-34c660540e4mr193709eec.13.1790707114286; 
 Tue, 29 Sep 2026 11:38:34 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c38de2290sm1256607eec.26.2026.09.29.11.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 11:38:33 -0700 (PDT)
Message-ID: <1452e241-dbe5-4362-a475-ddb8705a1df5@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 11:38:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/19] target/mips/tcg/translate: add sign extension
 for srav
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
 <20260929074007.118970-18-pierrick.bouvier@oss.qualcomm.com>
 <91c8dd12-1efa-4333-abf3-279a0c239d26@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <91c8dd12-1efa-4333-abf3-279a0c239d26@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3NCBTYWx0ZWRfX3W3yhpaoOqWX
 N6+cNfIUx6CBaErCcDlHdC7/XfXnkpNURLeUtb8cwmvzWC/BjdaHyaKi9vJXQ5vtrbxAdvscWQF
 D45jOx1TEMF2FCfCtouwEyvn0XlEpZw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3NCBTYWx0ZWRfX6sPboaxRhWG+
 FPPSgnm1sf2pm4ghvBdE9cqPqICzSBF4vUpECEU4jDLCXzuXIBCfFtPD17o8zZ1S3OvHCaLbiN3
 4zmlpMatBaq2AiBuNrVe4UNhZwwnHS60ktLHb8pRO7qQm62uuQTVuEL7y/ICHUx1u7zaW0zub26
 EEATcUkAa8eTp4IG+JWi0MsrxBdg0vC9dEl12v+wTiR0Pq5W6poSVdXgU/vUr66SbD3MNRjU9Ig
 J95sni8JLF68AZXhSkvz5GViN09VTBLV1u1nfy0DQhrmxvT6B+TtdmX00V7F2vgLChw8ztktb4o
 LAMfX526LzFBOzIToomSrzcrNV1xexTbcYZkHeh8wM27eflxxBgCJRb6rMKfgR3PSCr/RW+eNIk
 16RQ7Sp5BNjpLqfJaCvaCrnTHH0hSEJLcOuNMu9qLhqdIQnNB3En2ZxDe7sKkC7fIRoRmyU6kyv
 tz7G76e5cnsoENldbIA==
X-Authority-Analysis: v=2.4 cv=JMiuIMKb c=1 sm=1 tr=0 ts=6abc05ab cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=GFeGqhpDJw1CD_OEtpIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 4avDrqDFGq3VAswMvOx4CYPhjkECg9kY
X-Proofpoint-GUID: 4avDrqDFGq3VAswMvOx4CYPhjkECg9kY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290074
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/29/2026 2:59 AM, Philippe Mathieu-Daudé wrote:
> On 2026-09-29 9:40, Pierrick Bouvier wrote:
>> In next commit, we update references for failing tests.
>> One test, test_mips64r6_srav, has an output that is not reproducible
>> on my host. After checking, it's coming from UNPREDICTABLE case
>> described by mips64 reference manual.
>>
>> ```
>> Format: SRAV rd, rt, rs MIPS32
>> Description: GPR[rd] = GPR[rt] >> GPR[rs] (arithmetic)
>> The contents of the low-order 32-bit word of GPR rt are shifted right,
>> duplicating the sign-bit (bit 31) in the emptied
>> bits; the word result is sign-extended and placed in GPR rd. The
>> bit-shift amount is specified by the low-order 5 bits
>> Restrictions:
>> On 64-bit processors, if GPR rt does not contain a sign-extended 32-
>> bit value (bits 63..31 equal), then the result of the
>> operation is UNPREDICTABLE.
>> ```
>>
>> Current implementation takes advantage of restriction above and does not
>> perform sign extension on lower part.
>>
>> Given this definition: srav(x,y) ((int64_t)((int32_t)(x)>>(y&0b11111)))
>> srav(0xaaaaaaaaaaaaaaaa, 0xffffffffffffffff) = 0xffffffffffffffff
>> With qemu-mips64, this instruction returns 0xffffffff55555555 instead.
>>
>> While this is not wrong following the spec, it can be surprising. To
>> have a more predictable behavior, always perform sign extension on lower
>> part. This will give us the advantage of having a test output that can
>> be checked on any host.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   target/mips/tcg/translate.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Or simpler:
> 
> '''
>   target/mips: Sign-extend the SRAV operand
> 
>   SRAV operates on the low-order 32-bit word of its source and
>   sign-extends the shifted result. Sign-extend the source before
>   shifting to make results deterministic when the source register
>   is not already sign-extended.
> '''
> 
> Fixes: 48d38ca52b6 ("Switch most MIPS logical and arithmetic
> instructions to TCG")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

I updated commit description, thanks.

