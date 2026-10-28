Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF632606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=doff3ApM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OtigGU9v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8N6-0005sb-DX; Wed, 28 Oct 2026 14:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xM8N4-0005nN-Lm
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:27:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xM8N2-0003Lu-Ps
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:27:34 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPMuY1942117
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qjEtDEBHhC+ZxW9bQQmX+mN6l97+g0aVU5gve+kj5iE=; b=doff3ApMh2oCSYiu
 a0UW9j1ww09w3pVNfKCa9Wf3tLBAtrpd4HcgnFWkjQeG/h0OoZS/+3gtzZHbG+p6
 rblLVsDPbaEiLz9icor4vcd4LEnmCvlSh/9shxNfaa4JRpLxWZtkWSTjyhUgBuJn
 5vSsMqOIGe0jD7QR8EFwaMSsaWEl2J+oVDNC+LgVDaJR93fO5aHG50oRNKwm2Dky
 GUaYY8tvBgKb5V4rtdNUmu5+olSOEgAicvsmn2DbPosUGRL44Wnz+qKVD7F4Wspm
 k3mOun5MiknC2WJECUGpBYdRyW+Z+fcygt56HpRnveiTXyYKtVG4x8QCO0ZUNRfq
 Bkum0w==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkbhwawje-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:27:31 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso2763740c88.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793212051; x=1793816851; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qjEtDEBHhC+ZxW9bQQmX+mN6l97+g0aVU5gve+kj5iE=;
 b=OtigGU9vhUxNMX/8V40QPXserPSlbpG1NGZ2HAqlF19fgjb6Bv9kiUHXosQ2Wv2kX1
 s377Fi+dmsYvExCHk5dLLVMGPgOAmDJmociUsIISJ9StXZpFyLFbyIJcab+fDljLq6kJ
 3FvjGNTi6HthUkREjNL9id2wQJjg1lkccOPHUvEqMKpIM5PfHMgMdjfqs5dU9rN/fSLN
 sRocSuLNTxG4Z7FroU2GViZQ0IjBu9FHCFS2ek7l5NJsxgkoIpwHTvuY+zdHYnKnyEAs
 ZKIBK0Mq3Oa9ZK1886PWvyG6VGfN8O/b00lpmcAmTl7v5ig/beXaaNyAnUth1bs9C3Tu
 xtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793212051; x=1793816851;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qjEtDEBHhC+ZxW9bQQmX+mN6l97+g0aVU5gve+kj5iE=;
 b=lAxuApNpj0gsAs82Z0AcZXUE6WUJ08kdstdqUd5tENqmIBo2ZSqB3009YrHqDF6HZY
 bBuVRVfdcQr0q4r1oPVlGadRl2evd2PTxolIidIcVh1Z/RZc9lsZ7lawrg4r048kW8Mw
 kA6/T3urBy0Ht7+M1NmGFsT6tzqFh3f1lyyt7fU0CESMsHFjGXjA8A1s9NFg+Jee13K+
 wMYl+PFZ6m8ZqhGC4s3WJlWC/MoRTEVsDob72gRnDCusSDv5PNl/lxW71lnmm05OQfL5
 YGkZkNnjnevHLELPT1lUsj+cshp2HixA/SgZt/3AKTKh9NiCKGSlpQMfksyU1rAk8zQV
 4Y2Q==
X-Gm-Message-State: AFq9FYLnQMZYye6whlmG/vu7l8ksn38CSNlSqzK9kRsZN5w9Ek6yo757
 F7jEQxYftot7jBXV1kYj7UHY93Xj58US+EUodbhJOgMflMYecq/16S2M0m7b8YAmzAXt9H+LedA
 IJOqtbHTtKJ/6xj5xILHHsrMkMKPhxFomiEKlh2CnMDP+6TaFT4no2A0DBw==
X-Gm-Gg: AYBFou0lcxBkySYnu97ciWSYOb8mnxPQ4sMhyGJY6++B6iIULJOaCeaIJO8L11ERi1B
 96tCfV+jgTOGsP3aiTiqDagPDU1ZYZDPEIjS3H9wWiq0cspyT9Ilv7C+Rc3OxLxHDkIKTmxQKdw
 hy3ybKIHE550nrnIVer/slbZqhUVZODmP8jEdNgbO028tJXp0ZOdaOphE4G6nGk3nxo4cxz2r1Q
 8Q2GzzPDDmgQ9VI6nWOP2m08ulmbBZf0NFGpe7NTGXw9wAat9QdDgc/k55Mfz9OOAMbWU3x0kxO
 ewYeq4x7/egoyeW4qtsnW8qqO1uF9n5xEAXV72uTTcyehOIs482I7x+yMUhxIWhkG3kwiAY5mSp
 hfSWEt2N6exagCEH4dFDCpPS+V50P9uRGbA0PhBYdciCkayWumj+tW6Fc7Op4BlDNTBksfn+id7
 +SNGTsBkKVbGmZAAIyXPoQi8FXoKJw2Ag3epPxzy4QcGA=
X-Received: by 2002:a05:701b:464a:b0:166:b307:5855 with SMTP id
 a92af1059eb24-1a6c24c4efamr4166341c88.0.1793212050528; 
 Wed, 28 Oct 2026 11:27:30 -0700 (PDT)
X-Received: by 2002:a05:701b:464a:b0:166:b307:5855 with SMTP id
 a92af1059eb24-1a6c24c4efamr4166304c88.0.1793212049888; 
 Wed, 28 Oct 2026 11:27:29 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75c814917sm7222770c88.5.2026.10.28.11.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 11:27:29 -0700 (PDT)
Message-ID: <14850e9b-a9fd-4a97-8040-ba67900e3aa6@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 10:27:28 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
To: luoyonggang@gmail.com
Cc: qemu-level <qemu-devel@nongnu.org>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_4_kLo+p2k+3+JvD_pPLPjc5M9_HSX70_6ewqjg1HyEQ@mail.gmail.com>
 <cd06ea46-5935-40cc-9897-bf004c0983d7@oss.qualcomm.com>
 <CAE2XoE-xipsj_xNJ5tQ5GEkNV+sJE3VuoATxuHj8M9xyVW2u0Q@mail.gmail.com>
 <bade67ae-332a-4b51-aa4d-02c49867dd91@oss.qualcomm.com>
 <CAE2XoE-iOCdGxPtg7MqydmahpnOTFM_15dR0eJKGMrQKxrgeQQ@mail.gmail.com>
 <b45d0be7-519b-4c7e-9934-02929e98b1c1@oss.qualcomm.com>
 <CAE2XoE87zFaWZOY4EUjxrOo81+LNbEH_bsm1Hhe-kAdoa9teJA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE87zFaWZOY4EUjxrOo81+LNbEH_bsm1Hhe-kAdoa9teJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QokCJhJfuj8Jm4FjNCxC1qr_Yd64_HHx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3MyBTYWx0ZWRfX9AWalYB4+Xyz
 CL8o0by+hA4GUsFsnMduSRNDLe29BtLj847IyyMnGGcJn8Q+gWd3KQ8YGF2cWNR1XiuyN2b0Di8
 oF9xwPo7aC2ofipFWzsSL+pKmn7CeRk=
X-Authority-Analysis: v=2.4 cv=V+joQuni c=1 sm=1 tr=0 ts=6ae23e93 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=K3aNl5EA7VVrim7irGUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: QokCJhJfuj8Jm4FjNCxC1qr_Yd64_HHx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MyBTYWx0ZWRfX4mvjZ/YFkv0l
 H1lrNWo0FN8r+NlkAnSx6Ow67qd0qOxSs9CeRQ8SEh6s4DfDJ0w46eYFBpMhQXF4/+SMRAPB0RB
 E3cvbiRS1uraE7Hnnut3QTrLJjEyAyFoKtdPhSWAoCR50HxArFqaIS4PyoXONUZ/9G+e+gJlgg9
 STnnCTymIPqHsud7plzMPy8iAtKPBgEl6aVXTeqErHf/eZf+hEYATL6WmE6lH175gy9bRnYvEoF
 +t7matohHOtin4dYT59MTiDghRsNNE9spZCITI0UcFYPVkgbKjxHafGUgyXnfst2z2lHpCVae4c
 WV3GTH0Krqm/hRd8hrWgDWNpQn33NDvKTt83IAQdrPt5x1V0Lv4Ij19wa5IgeWqgXqqi3lpP8Qz
 rwX5OmsXh+BvH1SoTF2aMdVm5mwDN/ngZl9oPrOMqtvg+GEu8pDTj2pFwAZsqbsO+fJRYQ3OZUn
 No2hGKOgDkiNG2nwSYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 10/27/2026 8:06 PM, Yonggang Luo wrote:
> On Wed, Oct 28, 2026 at 11:56 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/27/2026 7:15 PM, Yonggang Luo wrote:
>>> On Wed, Oct 28, 2026 at 1:40 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 10/26/2026 9:57 PM, Yonggang Luo wrote:
>>>>>> I hope that through the recent series sent on multi target topic, you
>>>>>> can see better how to try to slice work in smaller pieces. I try to
>>>>>> focus on having a clear goal for each series, and each patch has a
>>>>>> unique purpose. Then wait for reviews, and iterate from here.
>>>>>
>>>>> I have learned much, I need more information or discussion about thow to
>>>>> avoid calling target_info() in class_init. You suggest me to use is_available
>>>>> but I still did not get it, because for multi-target binary, the is_available
>>>>> will not be called. so adding more things into is_available is
>>>>> useless(for my target).
>>>>> So I want a more clean explanation of how to do that. (I have already
>>>>> tried rename/duplicate
>>>>> the QOM name with is_available, too much changes and cumbersome)
>>>>>
>>>>
>>>> First step is to create distinct duplicated types for every QOM type
>>>> concerned (like two cpu max, one for arm, one for aarch64), and select
>>>> the right one with is_available.
>>>
>>> I think this is easily implemented. So this is fine.
>>>
>>>>
>>>> Once we have all types correctly duplicated, and using is_available
>>>> everywhere, we can replace the callback approach with a declarative
>>>> approach (.targets), and register types in distinct buckets.
>>>
>>> Indeed, we can compute .targets from is_available, as we can create a
>>> constant mapping
>>> for those target_* is_available callbacks. So the prototype can leverage that.
>>>
>>>
>>>
>>>> Then we can have an automatic naming convention "arch-type" which hits
>>>> this bucket, or "type" which must exist uniquely among all buckets.
>>>
>>>
>>> So you mean use "<target-name>-<TypeInfo::name>" as the QOM name when
>>> registering?
>>
>> No, it would still be registered without the target prefix. Then, we
>> would automatically make an alias as target-type for each separate bucket.
> 
> 
> any pseudocode about the bucket? For example, The "virt-machine" qom name will
> correspond to multiple totally different TypeInfo, how is this achieved?
> 
> Currently the type is directly insert with
> static void type_table_add(TypeImpl *ti)
> {
>     assert(!enumerating_types);
>     g_hash_table_insert(type_table, (void *)ti->name, ti);
> }
> 
> where should be the bucket, I need to prototype it out so we have a
> clear picture and
> avoid risks. Or we turn TypeImpl to be a List instead? so we can
> iterate on it? when
> it supports targets?
>

I would suggest you first introduce duplicated types + is_available
where is needed before trying to do this change.

For this, as suggested previously, remove the global target_info, and
make sure all types can be initialized without crashing, proving
class_init don't depend on target_info.

Regards,
Pierrick

