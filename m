Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5CAC44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmBLL-0005vw-T4; Tue, 21 Jul 2026 10:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmBLH-0005uD-90
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:21:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmBLF-00065E-FT
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:21:07 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDfqiC1687322
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 14:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wdpnRsyvCT8+pENFfuAJ3cAGmvRIPlpC1UrlFpxdRTs=; b=DVzlVdjdb6/TUP72
 AyW6bppczjud8sDP/f3akFYfi+fsbtk5myO0xcrCp5HkaJJilxR2I2sWc4rgzxb5
 j0J9nFif2DAVivMvGaASi9Ed5UzfuWjJCfM1n3wBs22OglmJN7brcsbOxFRviSs0
 FO5qvAunDEqJFUD9yynACNZfOjoJYpQEG1ShtI2QkggKkCgQebeDv94yOABcCrb2
 4zWHdubb9psx4GmdznunOpP3ZsNa5evwBC6xEtUsHFJCphBF60pfk9XrElX0FIy9
 GHQ+JyFv7lNTwfo8QMUWb8zuSyWO4ssoMWMYymiZqXRA/uqTfIxmTdqWeSmoovYA
 GhKFUQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9c40am1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 14:21:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1a97644aso12994021cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784643662; x=1785248462; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wdpnRsyvCT8+pENFfuAJ3cAGmvRIPlpC1UrlFpxdRTs=;
 b=L3dMTNAhQbBFiGM154fPAtXeBtP6inoANyi17fC/hVsbTHzeryYtDAxZuz48XWarAZ
 VPPpcCq21LDpMQO20k8Bw/5KUA97sr3c6JWAdAEHAj1QxYQIeODPZX7NIvSOFcDcn3yI
 /peOzZTGCffNlHlO8UPAcjoVCt06iVFIinIgop4qHgETEtTjsRwZf66ti7KrjGaXGc2+
 V0icG0+vSdPsEvi1bmsqBG09nIZSVccmFTqgH1Mk0iWLdI1BkIxlOTvwdAU3uQwXJdvm
 lVz9xXNEG09nTspaq/7jA56wE3sjACe/AoRyOZ78CklcjOjXsmaJfzv45j3PpupAdGCy
 nvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784643662; x=1785248462;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wdpnRsyvCT8+pENFfuAJ3cAGmvRIPlpC1UrlFpxdRTs=;
 b=WRjCARCjGU2ONalXPxohUTr2J7Ccjt1gTSJglLGgx0CAXOEG4qKkx7tGGzR6Ar3/f3
 UDm88uXvtYYcWSGieqppGjohkh7n+rBn7HDhz4zh53vMVwFYKk1Le1QglAfFVH77apdI
 gupcw7iNeKts2M0pE2vzm9avDc3Iho8E0WnessBvvJodOmuorCkA9oa5D/7J8fASARrA
 cnQrdYe1mgDYFLgvxMShEfwMwlLeshv3z0vpFzISQVozmTZVEE2HAR7n8/WIKc6E4kC+
 mUSqzmfniER9h3Qg3bfPfh5qbTXObXZG4mPSSoPMt1OcuQt3sZAudH/DaBxRT1Ufnz6T
 NcNg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFd6rDTst5roKptCe3cnqgrXTECWEYnJt2eg9oXQRRzdNfnZL279xgFCYSAJCmTg06WOCnFbzShVNa@nongnu.org
X-Gm-Message-State: AOJu0Yxx+yDdrS2H0Ps0+ivSOEPx1f3yFoFcKzRSyoxp9wTqe2pF+LR2
 DYA/ALcX2TBtPRxIG8Qf8EjFDukg+a9Q8CkgN4TgaZEIW1H3UPzCrfqJcnd2LzpTiyAmWOycLZ8
 b5sDnRZnxDAsoH7xxt3albq4l186uKQGWd31dqG3dEkHBpTHUZ6c1JknTXw==
X-Gm-Gg: AfdE7cl3eukq5SQHXywHrIPivKtCw8xjbue9muKhE5KSKetPyXExv5BmCCG+eC0aPXy
 VuI3c++meGAMHg4OBcC2W9p+Y56oddqSd74voRkAvmGxwGTJVNsEqjx42Il1MJgVX8I4B737Pvl
 7P7kYOdaNt6aj1FNpULBsmllUREJa1p1vRPUsB/ehLo+dyrZVxeuCGHmQfU63DPM9mi679YT5Gr
 2UdnKmnAzOouF0qiR2gxB6MSYTh5GJWbag4GQs3oIXjv7zgn3l79dbE9uP8EYR/MYgZr4Y47SV5
 bZ50mn2WZUt3lIHKbgAsWR6xkW2/n4arQ6xN4TiraUBO57xzr12/Qjehh76FaFdEONcKckkN95j
 bruGpvXbOsDLTHYKqX7io3YRCsRj9Po3zuqyYSEwdl5z+MA==
X-Received: by 2002:a05:622a:d0d:b0:527:8214:b5fe with SMTP id
 d75a77b69052e-5278214b6c6mr5218081cf.51.1784643661821; 
 Tue, 21 Jul 2026 07:21:01 -0700 (PDT)
X-Received: by 2002:a05:622a:d0d:b0:527:8214:b5fe with SMTP id
 d75a77b69052e-5278214b6c6mr5217541cf.51.1784643661313; 
 Tue, 21 Jul 2026 07:21:01 -0700 (PDT)
Received: from [10.131.142.220] (220.171.88.92.rev.sfr.net. [92.88.171.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955dfa81b2sm110047715e9.4.2026.07.21.07.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 07:21:00 -0700 (PDT)
Message-ID: <07763435-a39c-4162-91df-06e0d095b750@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 16:20:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gitlab: remove gdb from MacOS jobs
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260720180459.2542918-1-alex.bennee@linaro.org>
 <7d5a7592-85d8-4559-82a0-2e262e5ebef0@oss.qualcomm.com>
 <CAJSP0QVnLrMkVOh-1qCbbaP40nX2soDpx31oBc=M__xgHPzGsQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAJSP0QVnLrMkVOh-1qCbbaP40nX2soDpx31oBc=M__xgHPzGsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a5f804e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=HvFMDRKYglX6yPpWI6gtsw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=mS5lYXA2t_VaYkO4BlkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: iwUlM-BISln3YT4uAeMo8T78NOhl0h1h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1MSBTYWx0ZWRfXw5YJNVRCePBP
 BexGe1GMw/mjR0MDjxgq1c4UctqcYKQmNl1f57DwT8WkxF2yil1fHgpu+ej9UsWzlsoaB3W6DdQ
 6Lq9jKUDmB1sRxh4aWhMzcovOkFmvP4wdQ+1+r9qDikno4Y5fibi39NBV/xtqWOe80TrY6RLMXX
 BDyvOTeRIDX2jhEdm0U/Zm4UFfJ33QdzbkKLOOI1DVxgWAXsC/WIrpuxM2Uv4E74uVNSqj9qUcz
 Xry9B6b9/BPghLVE/fRHgDEQk4rahvMOKbF0MYiML2hBmF9lOeTQKRPs47aXUx5zwn6YjYbzysS
 7+D/csv5Dh9NboTSkKCIKURviLAWXsKU1w338+DIbIpwFfSboxKrSzwX2g8gJ+sqMQF8hz3iaWI
 hcFkTEYpkGJa7hwy7Uz5gRzk/AnLnDxRLPtvJPdl0pS1o4g0GFleoLw1VRRnYBUkR1WHB9U3MHa
 hkbWdxghsmvnfbKZMBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1MSBTYWx0ZWRfX+dc/s0t5RcL9
 btJNOaz6iAm2XhDQKa7fhzsV5GaN7/L6vvnKocBH5d+ZjKFiIMP+D40NTkXqBO196zH4A4qHOA6
 2KfOvLy3meN9dIyG+yaU95+rFc84yrI=
X-Proofpoint-GUID: iwUlM-BISln3YT4uAeMo8T78NOhl0h1h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210151
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

On 21/7/26 16:15, Stefan Hajnoczi wrote:
> On Mon, Jul 20, 2026 at 4:28 PM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>> On 20/7/26 20:04, Alex BennÃ©e wrote:
>>> The gdb jobs fail on CI
>>
>> What is the CI failure? Could we at least record where the
>> CI console fail?
>>
>> I'm worried to recall what was the issue when trying to fix
>> this in the future.
> 
> I added the following to the commit message when merging this for -rc1:
> 
>    This fixes the following CI jobs: aarch64-macos-15-build and
>    aarch64-macos-26-build.
> 
>    Removing gdb from macOS jobs skips the softmmu gdbstub tests which
>    currently hang on GitLab's macOS runners:
> 
>    qemu-system-aarch64: -gdb
> unix:path=/var/folders/fc/8_hzw5tx3n7c9c04tzd6tv_40000gn/T/tmpes3paikrqemu-gdbstub/gdbstub.socket,server=on:
> info: QEMU waiting for connection on:
> disconnected:unix:/var/folders/fc/8_hzw5tx3n7c9c04tzd6tv_40000gn/T/tmpes3paikrqemu-gdbstub/gdbstub.socket,server=on
>    gmake[1]: ***
> [/Users/gitlab/builds/qemu-project/qemu/tests/tcg/multiarch/system/Makefile.softmmu-target:35:
> run-gdbstub-interrupt] Error 137
>    gmake: *** [/Users/gitlab/builds/qemu-project/qemu/tests/Makefile.include:75:
> run-tcg-tests-aarch64-softmmu] Error 2
> 
>    The following GitLab work item tracks solving the underlying issue that
>    is hanging softmmu gdbstub tests:
>    https://gitlab.com/qemu-project/qemu/-/work_items/4063

Thank you Stefan! :)


