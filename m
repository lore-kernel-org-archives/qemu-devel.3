Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8628CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 19:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZw1t-000360-GA; Wed, 17 Jun 2026 15:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZw1f-00033t-IN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:34:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZw1d-00049G-1N
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:34:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HIsWjG3068009
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 19:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zXH+EHTHVgh3hBEEmaQCAWjgWgqu3LgIjiqIgDTY0to=; b=bQ2Kb4JTBcSkbHtQ
 EkVeE/gLz4KqurFbTH06aQtkAoXHkqVf9JWwyYvJduYhZOLHa8vfcL4I4i6nOiTM
 wjoNq5jnRLIyvBsTpdaXDWc2WymbgYIjqOgLqHAtWx++/Q+IepeDASvyZ/p7AERB
 qXhcVnNbHFo3BOPwv+Ug7sYHtbSFnVZB25hBVRGIDgVAUKliDsKpFs6JuQkrptf1
 K5ys2vQwCVBqF/bH/d/kxjnz/4CEWI2UgqAOylCRYvqvatg1YkAyN92Liggmy8tk
 10KjWOCX/5Y7/+jQoSC1D/3bZLbDjCtM/xjX8FIvOmaUoxIVNKB9lwmW246mewwS
 3cl3IA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev199g4e8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 19:34:10 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30762d67a64so261773eec.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781724850; x=1782329650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zXH+EHTHVgh3hBEEmaQCAWjgWgqu3LgIjiqIgDTY0to=;
 b=Sh0P+Zz9N2x1G/wvm2mP1ROAFvTjaTTZYpWvWImue/Mm/MStoHVtSXSmp69ByivbJW
 ir+VqYSboS9qVXtor0zKFP5T9uVUR5w9Qzr7r58cJ921KxWogeLBpcdCqmyx8SG1ow3D
 Ffd7p3uACQj3LESqvTbhmUmoVAo8+jv3mZ++bEmQd7tqYA2y58bTylEej5JAts9ndFLL
 lftF9QF13SiZ+8QysEVRyjUb5JDno2uUnTUZkPVynqzegzfANBhGyp6DcUp6PXm0BHvC
 Bl7/vg3nOTW/BqhbFXVsCoA9goO8zc85dtHth5m2a/6UG5zoNH9zHy+yKWsr0i6NcKkX
 UtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781724850; x=1782329650;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zXH+EHTHVgh3hBEEmaQCAWjgWgqu3LgIjiqIgDTY0to=;
 b=d5hfezMkFYQnAnrQ2TRyp/Z9USvSH5Hmawjh90DHwDKCzM/JgumlN5u9d3QJd9ZICF
 2uo9gD9f5ddwjPO32Sx8n7U77r8qo3ezq3HO7aJkbk9C4hb7+8cP25FcTxFhEKkj+VoM
 QsZjq3i0fmaWU/PoZ9ymxa3CdIMjsNumV52OLHKcwJlTco5pnd9bk3sI1vZwk/2ALlRI
 f1jZ+easxlkO+25/xdyARW/NxXBCXHvo9QQ8lDOB8zCUiyBJkksVz+wLESSkjh97YN05
 7FLfRZJMf19o0WBNK7c+pZpQmIJX3Q2mEB8BlHw5ozndnk4y+HBaaB9z+6YaSwtGanW3
 sBpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Nwo48kzzw7jUoaC8ssM6jJ2mpMOQSz86cx7NMtp5mJoAxc+s4N0nyH0eDpz7PsApf/PT48wL9lTbX@nongnu.org
X-Gm-Message-State: AOJu0YxoqgTPIVqvf9AjFeJ4/Cg9C3lkdH9j4+b7k0sCgMeHlSyZJe6l
 yhDrhKSk5VTlaoh8vhCCAKVtCPt2THQujX/JQFcMPrUybl7xQb7ycA6cYmgijR8sWkIkMfkFQg6
 cTuP16W7nKnhoyiGW3H9SfW8Cke8ddCW62nPk1fuFs7Ces9stGEF2IqzaUA==
X-Gm-Gg: AfdE7clJPUu1B5EfYsdCGZ02vbcFU9xMdIeTwNrVzOPg6XhbOlhA6MXvFdY5zc9Zubq
 ErIrJTHjisd9LV3QLb/kjx6cO9+fZNgCwBAO3eX8TZEVkoB/qQlFn+BX9e0ETpogTvI46PYCoLz
 t9PfAgPQHWv676dRT1WZ2xjMxJoHCWaLcA3Ngz3eFrfvJ2OZkZltFGGZ641936F0Dc7F36LzsNB
 aolSXeU2+wGUEXqHc+0CHH7gWKpXawufc10/tl2WtZ66DHUohAx1ExzP5i6s+nvmSRtASle/ATC
 A1YImHIOzVwQrLmLvog+HIbJp0ULTOEyd4F0SGOgCz1UEq7tGCCEm6PaulyshOKpjPNshJ2QKik
 rjSy1rkPEDXv/wAkeej84WtMA+jo6sWFydYUSaSmrkz9i1UYSmhMi1jOs17dEcohpIi7rWgAWZ+
 AXt4w=
X-Received: by 2002:a05:7300:ec17:b0:2f5:5907:3a48 with SMTP id
 5a478bee46e88-30bc9aa745fmr2912526eec.1.1781724849822; 
 Wed, 17 Jun 2026 12:34:09 -0700 (PDT)
X-Received: by 2002:a05:7300:ec17:b0:2f5:5907:3a48 with SMTP id
 5a478bee46e88-30bc9aa745fmr2912498eec.1.1781724849212; 
 Wed, 17 Jun 2026 12:34:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea43b80sm22350753eec.21.2026.06.17.12.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 12:34:08 -0700 (PDT)
Message-ID: <3a732723-c9c6-4c43-b105-c74687d238e4@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 12:34:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] target/hexagon: Add hex_interrupts support
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com,
 Brian Cain <bcain@quicinc.com>, Sid Manning <sidneym@quicinc.com>,
 Michael Lambert <mlambert@quicinc.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
 <20260611052857.3911981-37-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260611052857.3911981-37-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Jtk2BuL9F0oEThbIWnJCWGR7hariHiah
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE4OCBTYWx0ZWRfX3bNi4k2ce8dd
 JbcoUUV/C9T0W4JelSIQdgdE1RbRTtxXfa4pODuwzhAi7yBh9Hi/BIVyun8gx/QEUUROk84QB5q
 jaoqW2lWWIZ0ZpD9wdNSEZfipm9/YJOcX78yRWrjMhbfpxyhox+PgDPV7Ts7NzCq/3GHQquN0x/
 oo2ZLa/50Vox77RSJnrV7iV23lUu06f9OrxCogQProzX4vvit6xrnGsEq2+p5J97sPXy6A9aiQQ
 RL5jmJV4ALxZ8wFxNHou+8w4eBEZ7AZ45oLAMzaV6wVPdb8BxkLWd++HwdVn+8ORSQ4Hz58EN8U
 WlkhfooVV7caf8bhsnDn3OVpEbyVYg7yL6icLPQNIY0IxnqIvTJiQVlYM/0iddwFcvy0RMGVh0X
 jhqrfF8hIALDvdTAt4mMeyl/e3W9sS4ywaJ6uYodZj0iNi94VEoYG2tQUnc3KqoVgxDEL28SJ2y
 OUoLpIW3pRg9amy4eEw==
X-Proofpoint-GUID: Jtk2BuL9F0oEThbIWnJCWGR7hariHiah
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE4OCBTYWx0ZWRfX9HEBzrqvS8m9
 3YocBhDamVNlHJqIZDRZGKblzkUJ+rANW4J0KZDAjINJkCmdgpVNk3grNvuYYerZuejJm80758U
 CrvYzFJmCt5zPde987x1DnbH4+pF9Ow=
X-Authority-Analysis: v=2.4 cv=U42iy+ru c=1 sm=1 tr=0 ts=6a32f6b2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=_Lby_Q9H4U5iDBhSG4IA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170188
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

On 6/10/2026 10:28 PM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Co-authored-by: Michael Lambert <mlambert@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h            |   2 +
>  target/hexagon/hex_interrupts.h |  15 ++
>  target/hexagon/cpu.c            |   4 +
>  target/hexagon/hex_interrupts.c | 371 ++++++++++++++++++++++++++++++++
>  4 files changed, 392 insertions(+)
>  create mode 100644 target/hexagon/hex_interrupts.h
>  create mode 100644 target/hexagon/hex_interrupts.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

