Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB8606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zb7XeQ1D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hr7QWyOd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuqr-0001W7-Ib; Mon, 19 Oct 2026 17:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIuqa-0001P8-KM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:24:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIuqX-0005yA-3x
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:24:44 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK4TV2157810
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r/AhrMuFWf9jk0sR19vNLLlk6n6Z31AcXWRPl6iUPUs=; b=Zb7XeQ1DFQWP3gsP
 zif5heGT3tw+D+r75fed51YdUCecKh34XszU/6+Ld6EEoTZJ76ZwNZWuGCXmesvA
 Yze1RmGKP1UCcMo3T0nbbJWefoeEyks0T826E9++W8I1taCA/1ARAeYPzOmzRVK6
 GKYNb2YuHCXnp6G4n8rIv12nYNDS4XLvyWEMJGD76sRJVal989SG1UxiBYKWRYb2
 4EweWj3ISzOqIuyhHGxYDKXEFLDM4YZkVuAlfcGWkJcI1iX5sDAkgecVFctR/2l8
 paJa2UB4CKQm9u2V9DFktCnltJHOu9DwVm1N52h3OAxR1P9EinBqyu7jzqJXIWiK
 nt5RNw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65kawg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:24:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a04491c56so112225eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445079; x=1793049879; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r/AhrMuFWf9jk0sR19vNLLlk6n6Z31AcXWRPl6iUPUs=;
 b=Hr7QWyOdWK5LfgmRj6qaxBx/buGw76BnKckIpesOk1B2jHLNsAVidi3icLh/AVayG1
 zEuLJN2wEYLDfS74kDOSCo7/fQhCkdpnBZ88mWypqTHayreFSac12hDZfZkyWubCP6KD
 9BKgRgN2tajKcM5vgfs8mv/auW6RVQp2X9b96GgAr6m+/UHtJ2+9fCpKcV3yBQyRQkdD
 yDFOGDx9MJyEOtB0V1cATH911xjmYoIBJtQF/yiGyOtCJNL/l02mh0qYELWsDEs5GSru
 CnN+NYMUnP/Vx+9VKVdq20TW5G3+uLQAb/lN9gvCFBOrM9pfd21v32Jbwj7obf0qHXjW
 iZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445079; x=1793049879;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r/AhrMuFWf9jk0sR19vNLLlk6n6Z31AcXWRPl6iUPUs=;
 b=zQoIu7KIzbh1X5OZrkOIBukfLQcf9Ix5jqEFbMZXi99fzkVJYHUf4OSRuHg2E81QSs
 MBn3Q1UULznJtEaSLwDvyLh6RJ/K/BMdx5Nq2AoHHGapCr1JPaiCpLQXyoiUAqe5I9iN
 8YTQS+NuSaKWifdhruzOX9FIhjlxDRbDc/4jxLR7EU21H6MOZnwQs4ZUOWb5/pzAegTj
 UoU7rmX+lEnl5xKck170Xw7Xh1FrjEbWAAqRBd/4l3nQHSpETTy9rbScYH5GNscwL5d1
 p5Cquj83+9+DxYJxcx9AXgvRwUeF7+Txf9vttU0MexKVY2FTrBBHEHD+kwEQQvn3bpVS
 66Bw==
X-Forwarded-Encrypted: i=1;
 AKwUvByImnDcWPEXJ4UvKew5KZz1+VyEcKK4cq2Y19kZTudwz9mZlcDVmWQUq3rZPkIw/B4vXiO5bHASEd3a@nongnu.org
X-Gm-Message-State: AFq9FYJzoKc1geMcdVy+/OD3TmjuvwtViS47dtFq6s8G3SYGikpDrgL4
 60akdU5oYoFjuUbm11nG6mxXz/CnV16NT/1m7Sh+bW2e+xtSmUPm99H8Yw0f0JFdiqbI8htsqPD
 v6dKZzmk34+z/n9YX1UqBICgSIHfS/rejqfh8qUGcQfE9moxdqX3pBuLCiw==
X-Gm-Gg: AYBFou2nylysdU7x9yG4vLUtI5BNTUFzckckq+ziLwRMmIN4xAN58xMubZw2b2C5Ck+
 bvYevum0gMQoqaBu/kK3yqSV0znNlB3cdiRmzFEaWCTuzyMV4NPHaQuWaLE4oeNrXQwylu6XdL2
 iSrTizfujOUYlZljpQeoD+FjFCcm2xU6PugX2/Iay1/RTJdxQg2mZmoRAxXzXVTPWzXQcoxST0x
 MbZXOkb0Vv0R23/N4hKTG84XUGHNRJftNa2kfGQ+k5g3NlpSVA5N/qfm2eTqrfKWM0uJklhqe81
 P5BqaZjo74vbnI7wwW7T0pqIGDJ1LXftZbAuE4jZInuIT+m5qQ/Da4feCnoevxeGjxdwOTrljAB
 0nytN4ifMWGUCCfCpVcHdOQds9bamBN845ewo8dWbhjQmxul3S282HQpznv4/mBvOA2GTnQ==
X-Received: by 2002:a05:693c:8108:b0:35a:dbe8:ccb5 with SMTP id
 5a478bee46e88-365f9b85d52mr428478eec.13.1792445079031; 
 Mon, 19 Oct 2026 14:24:39 -0700 (PDT)
X-Received: by 2002:a05:693c:8108:b0:35a:dbe8:ccb5 with SMTP id
 5a478bee46e88-365f9b85d52mr428457eec.13.1792445078422; 
 Mon, 19 Oct 2026 14:24:38 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b684dsm34620574eec.10.2026.10.19.14.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:24:37 -0700 (PDT)
Message-ID: <1e46e628-0790-48d4-9e00-5708a6851375@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:24:36 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] target/riscv: prefix helpers conflicting with
 other arch
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016232304.1215119-7-pierrick.bouvier@oss.qualcomm.com>
 <911a9b004bdb22aca49bfe7ded9c58817dbc8591.camel@wdc.com>
 <7c78ebb2-37dd-4267-858c-210c3d02e93b@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7c78ebb2-37dd-4267-858c-210c3d02e93b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX/oTAUdVEbicZ
 W4jjpcu2C6uODL2mJpsds3zMGWVCid0c2hySJuxaZ5f89cZ/p1gWhePdByV3ACq0hReoUgWJKv0
 3/4DHiiwY5PMyvbmL56F2J0JZhuN+Lk=
X-Proofpoint-ORIG-GUID: 4zMTGBuqo0F3rw5Y_z-irY-PHdJEpZEV
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad68a97 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=sHQ6uKZpXwfWrFug74UA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX1f60XJE93BD6
 KebOuSmmPxcJ/Br0B3ZzFYEO2cCci03FuaSPulCQyRBrD80Jp4ZPM9QiLtCj5PlNh7jww67W+Cd
 Etce+5mFLVbkPQAxULQyKq+iBTmSQ8pOQzrF9Vep344zCG9OzH4KfvSKLBMLJe1B0ZkwZ/u+cBB
 qoEAMsBLMR9HHvJa9/kzLQUHx1E+grTvUdj8TdBxtmDwvMC66MMHBN5xf6pyeWVmlIjJBjEHA8q
 JVX7CxTemZPrke7otEne7A0aC67EFNtSapP+rpWnsIWiuOm3rqYTp+fJZefWu2vEupSwr4vmeVl
 wT42cpS+KezLFggpE1hUfMDKvt0CLOHFc+PBMdPVOYtp+8d2EoR7N2jDZ35i+nmftVvxjrhrjAn
 OtSmLj+7d5LHSt47FGfRxhJ0MS1vTUADgidUbqltc3UyEthCAr1Ssoq/NU5O/XXTn7tqW1Ak+aq
 /o7Wz8P0i8uIptzlPpQ==
X-Proofpoint-GUID: 4zMTGBuqo0F3rw5Y_z-irY-PHdJEpZEV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 9:57 AM, Pierrick Bouvier wrote:
> On 10/18/2026 7:26 PM, Alistair Francis wrote:
>> On Fri, 2026-10-16 at 16:23 -0700, Pierrick Bouvier wrote:
>>> List of helpers:
>>> - fadd_s
>>> - fsub_s
>>> - fdiv_s
>>> - fsqrt_s
>>> - fadd_d
>>> - fsub_d
>>> - fdiv_d
>>> - fsqrt_d
>>> - crc32
>>> - crc32c
>>> - raise_exception
>>> - wfi
>>
>> Why not just prefix all helpers?
>>
>> Alistair
>>
> 
> This has been discussed here:
> https://lore.kernel.org/qemu-devel/20260930073935.712-5-luoyonggang@gmail.com/
> 
> Richard seems ok with it, and I'm waiting for Yonggang to respin it.
> Meanwhile, I just used a basic "rename" approach, that we can easily
> revert. Given that we are guided by compiler/linker errors, it's a very
> low effort to change/revert with a zero percent chance of introducing
> any problem.
> 
> If that's too invasive for you, I can also pursue this effort and add
> the tcg helper patch directly as part of this series.
>  Regards,
> Pierrick

Took a shot at generic helper renaming with this series:
https://lore.kernel.org/qemu-devel/20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com/

With it, current patch can be removed from this series.

Regards,
Pierrick

