Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9311B606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N3uXpBq4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KogkEWvw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfuc-0008U4-Nv; Wed, 21 Oct 2026 19:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJfub-0008TO-2G
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:40:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJfuY-0007AJ-Sc
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:40:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKe3nn2748285
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2Wla5+fIfFLSmTapDWWt4HqTB3w0F0V84ufiha/mTps=; b=N3uXpBq4X6uRy20u
 oXRVizvioWufK68vCVW/C76YPz/LMrlv470cXGRz963pJXcvwlt3pWMy/izV74sR
 e/gPVheHp6RxL6U5dyuvSdF5a+nvkh+njsy6v8C5KnpkWqDp/aI8TjfUbaFhwxYQ
 rQ9+Ymr0gEOOBnR9Ou/iemqdVwYytmGtr3yQcy3JFHPZx54RVM8N/e3INNXvRdTy
 LXbqQpIuWvGbbQyEPPhyPvEkan6kb0vXYIe71ZbswmnIuVQ2cUqykgC0aHg7E/CP
 vy2/2bSBZv2aZdjeHczc7E3c55URW+hMfgv6+xBSvD7gX/5xYYM822ipVdQX1ocn
 Yn/h8Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke1kas-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:39:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso4644447eec.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792625993; x=1793230793; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Wla5+fIfFLSmTapDWWt4HqTB3w0F0V84ufiha/mTps=;
 b=KogkEWvwIQEnkzOac2o2uTsVS5ODhtc2xkVhH5xftPPG9IO0zBXlXRjZ27eb9vQc3g
 Q7rPSOXqp3jv5qbOH7X7jZhWGnawoVHMkVaz+QeFV8LEc8iwtIvjgT1OMigesugBGLpx
 6cyI5f+FuY+ygpwp3VjBCw5A35n9MDjcqp3TkOfQlfUt/yOJwkDm3QdxhkJx6peSizuw
 hVg7n3WjFkGaJSY9lgkGqVr0TNmI/dkzUlBSZv85DfD+rLRPJ8xYWn3wEfJq+fERp5Qj
 Q9I9jDAioVNyv+4VVkdo2lSAModN2GHGbrqetiJ0QQWmu1jo577VD4dVzMGVKU8OBOfm
 dg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792625993; x=1793230793;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Wla5+fIfFLSmTapDWWt4HqTB3w0F0V84ufiha/mTps=;
 b=iKg8xvsYvK6ZF5LMPzQ80EE0i4LE6M27ygC3PTxU+2db/KmkzR7Zz0QvYKPA22N9VB
 q571l4UYE53BhMHBLqf4wd+lhTTVIGtD/XC5komUUuj1Gydp+35zbC9/4OBuM4aiaFYd
 Zm008CHdUISXhbtB8ID2uf6GzI74cxXKplE3WXI06ubVSZFsLgfSwf9poKe3IHDFvQXa
 vvCRz4aVmOqP2s13aC8Hi/QklryMpKMtXp5wL2X+v96VTSf7Wu35RIa8PihgjJD3OCTk
 IvdNGkAJfGYxbtRFg2Quk0JS5GzaZm+vbeBR0BjVRFWlo/0QdMPPDnbNHvi4V+cVK4SY
 4X9g==
X-Gm-Message-State: AFq9FYJ55nT4TzMyI1dREthgdD9kMCNQEchlL4djktfHpUwL+EQ/Msin
 TAGg56Hg9xiJzwFJatM2QoFRzBhmYY4fq06Q3bcZ/0YUTth4FPqD70bzhRz/3oDnj6CNAwh23fS
 QLFJNpRh0FRXV27iYqacKk1BiXeIcOlOy/A3D1noRN9OalUkp8v4RiAQ3VA==
X-Gm-Gg: AYBFou2EWS/pgiKpZ5WdYJO/xOLdDIlyLdbT6i4W941jXNj+vGe4O2TsGp/drSeqPrs
 Ryh/uytIxovGZP5cjsTRJbUTYVjzvRHv3sKEg2P/EdBSypdy4p6YIh/nEn40ytZhvNZEr9npvjk
 BDgg/b4KupHWsPVjV9rr5MNQok3gMtWiy5NmvtaxnccN24PKjH8+BxYphZTH1ecnC7vG7PvXvVg
 aWCyM007ZFQJ8SZcdw2pjEXPjPZkkLKazSDwKN54+2+5b+jsRYvXLs8DF+a4nPkuK0nP3uHoTf/
 NUy1TC/yBuYTSQnH1sD0bh3khOX6jtWr47JQiZyeF8E+lAs0nHrpo6Qd2RojQLorQekG+3cEcdu
 j2UvIoaFGhQTrncGU3edF1yPtnYWo7aSPMrw3J2sxASpWowYWZVkSHnLaNmjDXAaObozaKQ==
X-Received: by 2002:a05:693c:6382:10b0:35c:de00:93d3 with SMTP id
 5a478bee46e88-3674f6143a2mr4702004eec.40.1792625993310; 
 Wed, 21 Oct 2026 16:39:53 -0700 (PDT)
X-Received: by 2002:a05:693c:6382:10b0:35c:de00:93d3 with SMTP id
 5a478bee46e88-3674f6143a2mr4701983eec.40.1792625992805; 
 Wed, 21 Oct 2026 16:39:52 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3674198f1d8sm15734964eec.24.2026.10.21.16.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 16:39:52 -0700 (PDT)
Message-ID: <98d7be02-3afc-49db-96e6-bd84ec6b7218@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 16:39:51 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/21] target-info: add target_heterogeneous
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, anjo@rev.ng
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
 <20261021181244.867840-2-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_78JWfKfs+5ek=6E50gjGpeRsoVe1meu=gi7FunKcjAw@mail.gmail.com>
 <e5c61cec-24eb-49a5-b9df-81cf4072635d@oss.qualcomm.com>
 <CAE2XoE-=z5NMAJ3+raj6G7tY2Mmv0=K3w5i8jPjvMmxo6eS-WQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-=z5NMAJ3+raj6G7tY2Mmv0=K3w5i8jPjvMmxo6eS-WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZPiHeQ_Bp5RWmZtozWojdWwgOBKaiLGs
X-Proofpoint-ORIG-GUID: ZPiHeQ_Bp5RWmZtozWojdWwgOBKaiLGs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5NCBTYWx0ZWRfX/vj8t33HxmFC
 Tf6vO2L4HTojer5mklecxhrPv64rPjnNj12DXGIRSN0Kx1rJLkd+5hdPNkNVASWO/YsZJ3H6S72
 L43H/LJqaR3Cnjzac13Lzvc5Q47a7ps=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad94d4a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=8JpEtOCANqbWPM1MXVUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5NCBTYWx0ZWRfX0RNPmtNHlV2p
 YkfIaMNvLRjp4XGRVaklyWYF3/3D9xqY1fOMtHqrhgcvd6+WxZ0RWjTSdq2pk1byLtm4r1Eno8N
 ndHBhvoByt4M8vZzrmQINv94Rc5BOEETt06f0qAkge8cs/qcIeuKnMDB9h2jrK/bdjrg8PeWIzr
 zVFm1RDJUuPn0Wp3srUlOmWvKvsVtvPdXzVr0OZj9vDSRbMEKcEcHW7cyO4/wFCe/j066S5Hpb+
 q67rtlE4IaEgR2QHl3u1hg6uPfJm/N4R8OnPnLOxm34sHSK4YirVQ1rWhPYNDNQwzLCkfq9rbyU
 zAXtZzWSac9L2zcx8csxRSAccm69AgtpkdHF++tL7/49MDL6/wTH2PyxHoDe7dkV0LbL6z3cgwV
 zYch2Xedd8KwEVFaxeT0QhFv0VxhUShcNCNYeTjbBB9cskfKP2QocbVVnxIrXAqDHRRAtTsd7XJ
 l7N/Y+1Rw7klQiH3Sgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210094
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/2026 3:41 PM, Yonggang Luo wrote:
> On Thu, Oct 22, 2026 at 6:02 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/21/2026 2:53 PM, Yonggang Luo wrote:
>>> On Thu, Oct 22, 2026 at 2:14 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> For now, this function strictly returns false. We'll turn it to true
>>>> once heterogeneous emulation in supported. Meanwhile, we can use this to
>>>> add various checks and asserts over the codebase as reminders about what
>>>> we'll need to modify.
>>>>
>>>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>> Reviewed-by: Anton Johansson <anjo@rev.ng>
>>>> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> ---
>>>>  include/qemu/target-info.h | 8 ++++++++
>>>>  target-info.c              | 6 ++++++
>>>>  2 files changed, 14 insertions(+)
>>>>
>>>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>>>> index 862097c6c63..923c00c917c 100644
>>>> --- a/include/qemu/target-info.h
>>>> +++ b/include/qemu/target-info.h
>>>> @@ -42,6 +42,14 @@ const char *target_cpu_type(void);
>>>>   */
>>>>  bool target_big_endian(void);
>>>>
>>>> +/**
>>>> + * target_heterogeneous:
>>>> + *
>>>> + * Returns true if current binary has support for running several target
>>>> + * architectures at once (heterogeneous emulation).
>>>> + */
>>>> +bool target_heterogeneous(void);
>>>> +
>>>>  /**
>>>>   * target_base_arm:
>>>>   *
>>>> diff --git a/target-info.c b/target-info.c
>>>> index 254530d8ea5..b8a4a7ebf7a 100644
>>>> --- a/target-info.c
>>>> +++ b/target-info.c
>>>> @@ -42,6 +42,12 @@ bool target_big_endian(void)
>>>>      return target_endian_mode() == ENDIAN_MODE_BIG;
>>>>  }
>>>>
>>>> +bool target_heterogeneous(void)
>>>> +{
>>>> +    /* For now, we only run a single target at a time */
>>>> +    return false;
>>>> +}
>>>
>>> How about place this in stubs/target_heterogeneous.c
>>> So when do multi-target tests, we can override it with
>>>
>>> bool target_heterogeneous(void)
>>> {
>>>     /* For now, we only run a single target at a time */
>>>     return true;
>>> }
>>>
>>
>> At the moment, even though multiple targets might be supported for the
>> same binary, we still run only a single one at a time (same in
>> single-binary), so this function will return false until this changes.
>>
>> Why would we want to override it today?
> 
> Just for less changes in future, this does not mean this patch is not valid,
> at least it gives an API that I can use later.
> 
> I did something similar to get the single-binary qemu-system working.
> And I named it as target_combined_binary(), I think they can act the
> same function.
> 
> https://lore.kernel.org/qemu-devel/20261014094224.1976-2-luoyonggang@gmail.com/
>

For now, I think we can keep the current patch, as there is no need
(yet) to have conflicting symbols for target_heterogeneous.

Thanks,
Pierrick

