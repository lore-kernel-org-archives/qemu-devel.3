Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D337C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 04:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5FPp-0005Ae-R6; Sat, 12 Sep 2026 00:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5FPl-0005AP-5n
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 00:32:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5FPi-0004rS-Ok
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 00:32:32 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68C4V4tX2392375
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 04:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /IaODg0roIXu2/m8PyApk4JYXYcgoOEvZQ820czb+tA=; b=l7bQde35X4kUdNRc
 eeFnDKbmKMYrn1mjEwvEEEgbLI+qKGICD7tMPGFhNDw3R98+mg7+IHo9GPA0C+KD
 YfWN4g9ErQ1qdX2xpWvbW0rvEdRa6v61HPJW+LUkWFppb9YJqX6+lmkCi0+HtKoy
 xJITn5vlfA8x5emWVYDe+Vbc6Mxp+6QY1cOFG4pECg8/6IJMyVr+aNBfp2UBz6zs
 lcAOVa93dxgf10PvtD872uar4RQhvN1r0gGjs6Haj6RNTrYqljSGtSkclCE/lrw1
 3Uaz59Nr541VVcOH/xhQHiRkno0tpa4CByfm4NLENu4nwgJQgREzMMd2MDpHcsT2
 UyGNNA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dg25y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 04:32:28 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-81eddfe28b4so30797867b3.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 21:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789187548; x=1789792348; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/IaODg0roIXu2/m8PyApk4JYXYcgoOEvZQ820czb+tA=;
 b=HkMW3GUfafBYwB74bXh0cqaKBvU1KSQLdZXFYRcmZPfL+EVYyFmiK+WiZB8xydmKTj
 1/WlSTIlWAvmrASyE9dJ9PFyMoHU+WDW7wgj89zCKhY2Va/qtahU/waJ7ktrpV3MgZx3
 WKKITW4so3KdLoiiawkIbhR9Icdz+6gmkCVCx7+cEMpq5b7HMiaSAN4sgxYrR5z/0BRm
 CrDrxuJENewnCERgD+nPZvn/0agUPHpXr26hlE7BeSi7nT9xKWuan1feH3d2FdLBgpUS
 ra3h6chB0hJCcpoueQDYHcKpM5HoE0+bR4wAaSbqDJkOvRqaFvWN6toJbPF+c6VwCByb
 YMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789187548; x=1789792348;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/IaODg0roIXu2/m8PyApk4JYXYcgoOEvZQ820czb+tA=;
 b=hbYRPPw/2vlaWuy5OxvPSxrQtHLnDtgGRT1svfIWhbI0JqzH76T/xxo3Nnk8hUtASW
 Ww3D9yM4AYlxSKCbAuJNkh3hAXMZgLluOXwjY1PtWXrgk2rx3nxhnO62zCP3Et0l7pp4
 nX8FcaJbLzQ2lJPM2G7LUNFVX0jx3ACgBk5ZcRgkZTg9PTgUbeHvAssisPE08122E51J
 +DCwdNc+qjc2S04V5Uzk9EPor9i4ZyC/mdBGZJOjn/TqFlifOdtewfV6KcCCDHJaRU1n
 3Gb0FavO7dmy5KlQbvBXcR3S69tfsht6h/LR24o/V50SJhP9IgYmZ2IWd+ucUlcUOaHY
 apxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+UxmEBvte70pqiUnv+OJfxQGhNHStn4Ff4AG+7QkIEgwwXqxhAZT60wA1p9fX91/tX+VcgDIm1OQb@nongnu.org
X-Gm-Message-State: AFuF++kF7HONHdWkJ0pmJsh2nmuaambfZ4bA0Q3/8nmunUXKHORW5muA
 ilAJ/2KTOcgSxBOr522CRyJlnZQo97ELSjYfmznH55tVadzpVujteX6m+4ytZGdZgd4EjRWZyQJ
 2MYpczOlg0UX6WEqLdt2kgK5GAHIQvPr6zcS1MFVw8Nf55pPb60/EO1ILcw==
X-Gm-Gg: AYBFou03odnb296TakvxXjFAkcbnoJHggCFS5Tfn+xakQj8DqPuAUNh7BXnsWUgNCPD
 k+ExU7o3diPXPduuiZrRubxQG/meji38FApwNOqyN8bOlosIrK7XT79OaOcLn/2enNub0FjrRtT
 ogeoVWXEsfn2viy9aG9UyG/+4xYMBp9Zp+skUagAap9JjsIOC459YVKbwvmFHsA/7h28EtpZw5i
 INbx1VyxGtr2CS4jvmFPbiAmMhq1TzKzJyEC2qNnT4EOnaMRaYhAEzZGOESTFQyquRKuia4/pSC
 yvRCDeu/yeItLEis0AfRpYtrG+GwTStLV9W66M7VYZ/+ZMmtXV59pjEaV9hGyZLw7G4V1e7W+R6
 PfcZiIzMaGnUjuTE8CUbNdIgBmO2+1Rm2MS4uAVk8CkwxmJVwUuzRSPE1ExnS
X-Received: by 2002:a05:690e:169f:b0:66f:c1bc:402d with SMTP id
 956f58d0204a3-67135e3f053mr195756d50.90.1789187548427; 
 Fri, 11 Sep 2026 21:32:28 -0700 (PDT)
X-Received: by 2002:a05:690e:169f:b0:66f:c1bc:402d with SMTP id
 956f58d0204a3-67135e3f053mr195750d50.90.1789187548055; 
 Fri, 11 Sep 2026 21:32:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:1d0:c210:bc8f:aa56:8c4:fb36?
 ([2600:1700:1d0:c210:bc8f:aa56:8c4:fb36])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67125ea8a35sm1903073d50.19.2026.09.11.21.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 21:32:26 -0700 (PDT)
Message-ID: <9e5c2555-71a0-47e7-b89c-045115477f8f@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 23:32:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] Hexagon (tests/tcg/hexagon) Add tests for
 multi-destination instructions
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-4-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260911220825.143115-4-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDA2MSBTYWx0ZWRfXwGb9y/FrdgSj
 Bl7MtU5Nm2t+7JKjuT4TnrC0ROamwo/l6HiJAUO5CxzSMEzCPDBFm8e0vi6cEBzfMRwE182QP67
 Eu5WO7N2rFjN1iTH0zTyWRzIgRQzHVjYtGUA1TBzYZROArfGo9G2MrZE9xCnY8DHBHMvk5qDw6f
 YrblwlRFubfeOHzvTv9mSA7sY/VR5EsVkO248D6iQQKYuOhjNUOH+eiRC5GIVxtIhsU5Kp6F6pG
 Q2cMRDn3YkujlYJx5ZnRN7qagMJ4v73SVHOWIbGrqoF3Dq16dzqNo1iZ0eqnzpli2abZ3VLQ/Nm
 Q+Jvvw9IT07MgYDHm5EDsLTdHeZbeHWUoA+4cBjWzIew2w/2aSDeufWTWraGbHSFtriJKKDw+rC
 ix3urr6XH1/qcACPtlWvgwi6xD6gUxp+sFx1EyOl2Mrw3B6EODl8jneTzQ6Mg8OyJLWOYw/HLQF
 lvFXUn1O0F74AfMi3pA==
X-Proofpoint-ORIG-GUID: e2Z78kt3JJl5ygmEQ-eS998wM2q51Xmt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDA2MSBTYWx0ZWRfX1gxAOlW9VyuT
 9O6CnEmuwdEWD5FlXjeqfXiF/irbsujMJIsaCiw/U3+bSFlWr53ExERaCE1Al81cxzo5AInkAoQ
 91zgQIK0UqdFd5OZU+gcnUaDwhJDoBo=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa4d5dc cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=cyo-mCtPde8KWKw_Nn8A:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-GUID: e2Z78kt3JJl5ygmEQ-eS998wM2q51Xmt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_02,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120061
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 9/11/2026 5:08 PM, Taylor Simpson wrote:
> Instructions such as post-increment loads define multiple destinations
> These make it harder to detect multi-write conflicts
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   tests/tcg/hexagon/multiple-writes.c | 60 +++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
>
> diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/multiple-writes.c
> index 8686317fdc..4305903547 100644
> --- a/tests/tcg/hexagon/multiple-writes.c
> +++ b/tests/tcg/hexagon/multiple-writes.c
> @@ -143,6 +143,62 @@ static int test_zero(void)
>       return sig;
>   }
>   
> +/* Test multiple post-increment writes to the same GPR */
> +static int test_post_increment1(void)
> +{
> +    int sig;
> +
> +    asm volatile(
> +        "r0 = #0\n"
> +        "r1 = ##1f\n"
> +        "memw(%1) = r1\n"
> +        ".word 0x9b004021    /* {    r1 = memb(r0++#1)      */\n"
> +        ".word 0x9b00c022    /*      r2 = memb(r0++#1) }    */\n"
> +        "1:\n"
> +        "%0 = r0\n"
> +        : "=r"(sig)
> +        : "r"(&resume_pc)
> +        : "r0", "r1", "memory");
> +
> +    return sig;
> +}
> +
> +static int test_post_increment2(void)
> +{
> +    int sig;
> +
> +    asm volatile(
> +        "r0 = #0\n"
> +        "r1 = ##1f\n"
> +        "memw(%1) = r1\n"
> +        ".word 0x9b00c020    /* r0 = memb(r0++#1) */\n"
> +        "1:\n"
> +        "%0 = r0\n"
> +        : "=r"(sig)
> +        : "r"(&resume_pc)
> +        : "r0", "r1", "memory");
> +
> +    return sig;
> +}
> +
> +static int test_post_increment3(void)
> +{
> +    int sig;
> +
> +    asm volatile(
> +        "r0 = #0\n"
> +        "r1 = ##1f\n"
> +        "memw(%1) = r1\n"
> +        ".word 0x9bc1c020    /* r1:0 = memd(r1++#8) */\n"
> +        "1:\n"
> +        "%0 = r0\n"
> +        : "=r"(sig)
> +        : "r"(&resume_pc)
> +        : "r0", "r1", "memory");
> +
> +    return sig;
> +}
> +
>   int main()
>   {
>       struct sigaction act;
> @@ -164,6 +220,10 @@ int main()
>       /* Illegal: zero encoding = duplex with duplicate dest R0 */
>       assert(test_zero() == SIGILL);
>   
> +    assert(test_post_increment1() == SIGILL);
> +    assert(test_post_increment2() == SIGILL);
> +    assert(test_post_increment3() == SIGILL);
> +
>       puts("PASS");
>       return EXIT_SUCCESS;
>   }

