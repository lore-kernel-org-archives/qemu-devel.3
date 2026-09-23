Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53204C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9NWE-0004oK-B2; Wed, 23 Sep 2026 10:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9NWC-0004nh-8K
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:00:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9NWA-0004KL-3c
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:00:16 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NBbUAE2637893
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 14:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UbKv1FDh3nXKZXV+3a9PsbcLwFHVbXC+FCeNUERPn6Q=; b=S+5fdDopBEtYG6SY
 TFwMcK/uBlHob0GL001S/nbCa+QgdGbZCMzX1uyryWHmgEvnPTkKgc2kTK05nwII
 hLz89xbI92qYj8ViChHJxZOmASl190zg3yCdzChDo5p70zC83Q7JjppBsv34GlyJ
 ZC3K+5Gfe9Qmzbq5ipU/iWpS8YjOKO9nHnPB1KeG6DCtpO/MCCc5XJB3P7bVnYyz
 AkkdfDNe8uGfUl53Dk9VhM2jjyYTmJNBkk3lfGRj63ckj7lPW+Y77r2EtmVDEked
 IQaNY4AdQdzC3s1inT+rlFuH5b0r7+YBnojPsZuJZrWagEMxeUL4dKtqQZCi5lWy
 o+qk6g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv9bqhwge-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 14:00:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33bee712354so1180057eec.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790172011; x=1790776811; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UbKv1FDh3nXKZXV+3a9PsbcLwFHVbXC+FCeNUERPn6Q=;
 b=KgZ5BjfpWZq9LpVY5NMIMhk77K68qqyaxRlbSpU3w/3Ffk46rXiwTHmRXDFwwMCVl3
 GAq4UqvfTC+94zTJFj36yBnHGLzYg9ThRlU5SesUcDwDKDa9EzI0+1URJfs5CieysDMG
 /Bk6cId4AxMoHPyd4w93/orINnIMIe7Naut4PChWVBcOHgc/LD9pd3lDzHI8IAS8l608
 mXSGCz2ihAmlYCcdIZs/bNE1pueC/AJ0msuINYWLORAZxS1SoRr30tmt96svNdjpKrtf
 wG+N5S//pIiiZoKXHA0AIjuvOY544yQfDCg6rDzeKWjAuEYvYbrGCopCNOtDb98yBKvA
 tG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790172011; x=1790776811;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UbKv1FDh3nXKZXV+3a9PsbcLwFHVbXC+FCeNUERPn6Q=;
 b=ZMHlFFNNAGh/J1evOhUd6C3Rb3GJ+wEcwZYNIG+OEemH4zLXsXS3aVFxR7YZKEG2Jq
 FAdqjQd8kIDpqm8AAZPmgkwkYx30TIfdQXs2SbFHtzmyoWB0UX/MHUrPtjQVrZP4oQT/
 HGkTlhUvvspARpDQmAgvrGrY5LbOMMUc0yHl964uIouIoCk0bBSr8DNCML4Y4BzMrIZr
 9bfGl9uNa8sxTMgQaDqLlXUFG0bJaH0OKjT0LQP3tuDrNDUn2udifL3m4MdC4bztHxxQ
 tyfU2JnGW7BcFouzjEiCdrmkGO81e4RoNkRPcTBRTG7D2ivu5LCU3iMf07ZYHBdtd6Xp
 ZJYQ==
X-Gm-Message-State: AFuF++mY6W8BomdaAV9VuudU3TkxZ2UOFDWX/AUdnTRhqA5hMPfjzuOQ
 OiG5782Wj+EO5cP/yiIB9jsj8x92o6cZAK+XQqaRa3xJ+6FUNCfiRxqfIEMMyZ5BbAeiqkIxoEm
 JBaYyESPs+WP5tMYOydnCmh2xT8rUHAfS1wt3ORrCv1RVlrw8tA9lZnkC9w==
X-Gm-Gg: AYBFou38In5zHdQjafrn5sOLKUZIVV7+FUn2VOlkyYFu4uHtULxMs5bU5kIQrRiW6Xd
 AfqUnewx3f4Vch0zJe/vxJT5lxWw2jB5PitXGPuoYAlxFiTxu13WvA5Mn3IEIt4Ji5Hl3tSogb5
 ZFIgoqp7q7bh8IVQYwiuMcTVG6ysNAmBCWKWEHOFEqtx6u3+oscNzu2N987lsi3FVvMb6XEoZ6I
 QneNGSBpm6vYCs6fzUCj20baGFHzbWX1ytWJfn0ZQKO7IygdkaDyBBhwInOpCGkbdC6oMbxPbPb
 pk6C5sKNwlP4su57cv9PIXD7DvgiYBwtsvaC7qWP6GGRTYSdDNQl/h2ZArTBkIbP+dLxbxCg95f
 5emSVslcb5kICxzZKN2CdQWoncxIwxAdUjB2tp0zbPr4A4qWqK60BfymN2KtdPhsqBoE=
X-Received: by 2002:a05:7301:3a86:b0:33e:5c4f:f46e with SMTP id
 5a478bee46e88-33e8d8d2598mr2500042eec.30.1790172011115; 
 Wed, 23 Sep 2026 07:00:11 -0700 (PDT)
X-Received: by 2002:a05:7301:3a86:b0:33e:5c4f:f46e with SMTP id
 5a478bee46e88-33e8d8d2598mr2500000eec.30.1790172010062; 
 Wed, 23 Sep 2026 07:00:10 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e975223fcsm6454233eec.31.2026.09.23.07.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 07:00:09 -0700 (PDT)
Message-ID: <f639dfb8-79f3-4678-986e-2ebe403cff58@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 07:00:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] tests/lci/refresh: add parameter to override
 container registry
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-4-pierrick.bouvier@oss.qualcomm.com>
 <arLBBjS_T40wBa3X@redhat.com> <arLDQHOSRX-xcJum@redhat.com>
 <e97e1bb5-80c6-473d-b890-02f3cf9d0661@oss.qualcomm.com>
 <arLJAD64Vwer21My@redhat.com>
 <f193b3c9-bbd0-4ab5-8706-43407873ca5b@oss.qualcomm.com>
 <arLQljN_Y52KdjHW@redhat.com>
 <923147f1-4a20-4cb0-b2a1-ccce3450796d@oss.qualcomm.com>
 <arPCY7SOxipb0d0P@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <arPCY7SOxipb0d0P@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -VIlFPRDurdrlCFQERTPRc724cevXSTs
X-Proofpoint-ORIG-GUID: -VIlFPRDurdrlCFQERTPRc724cevXSTs
X-Authority-Analysis: v=2.4 cv=WZuZ+EhX c=1 sm=1 tr=0 ts=6ab3db6c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=Tk_493ufc3mdbYbPnCsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NSBTYWx0ZWRfX1Dvc5dIbudJ5
 p1Z5j79oT15hfJ72C7eiAgOM86oeE9BLIGjckvdg+NtTOMfbs4qW7mn/uuYAj7G18Ctmq9aHP9s
 4EmMEjImsu1WbPDAYhxDBzqfFj2pxow=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NSBTYWx0ZWRfX5mutvdD5hc+S
 kZFvRtQ8QR7fvQxwgYap7Sv6Ss6q5olPvOIHTMQUE12jv1m03MNoDHzSefMuSziP6kE8yIfhmRG
 Sdw4d8Izu6eFE/Cm8xyVmJaDs4RCNJeiiK2+2thLBx2A1I3XNKaA0I1pLXCv/TCS7AWYsV9A4AK
 W7QxIa3gIkIQ7WmmqEQuphNi6YTEWUhCmuimRtY0cC85MN9DuQY1gyHsRAnKHn0Te5AnORVH1+4
 BBq5CwNfNsGP/xTJPeTaVksfMOuUowv1/Luhs9lLwiGhcqqkiqusVVMl/wihzbCRGKW7Dug9LZJ
 wpF21I5AEe/VZcm+C3R+R6qV+mFL+tBfSfU5l8toaBE+hKOu9zyXtElawLGZpkIMeiz2A7BIYjU
 Z0QMD7OhUPuVO7K+IGVu/VI4/eiRz0EMdEeYzP2rAf7rW9INnCCNqQhlRLIBa17+iH8cc0WQzqx
 HUcmYHa/URBI7uHJGhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230055
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

On 9/23/2026 5:13 AM, Daniel P. Berrangé wrote:
> On Tue, Sep 22, 2026 at 12:03:59PM -0700, Pierrick Bouvier wrote:
>> On 9/22/2026 12:01 PM, Daniel P. Berrangé wrote:
>>> On Tue, Sep 22, 2026 at 11:33:47AM -0700, Pierrick Bouvier wrote:
>>>> On 9/22/2026 11:29 AM, Daniel P. Berrangé wrote:
>>>>> On Tue, Sep 22, 2026 at 11:22:43AM -0700, Pierrick Bouvier wrote:
>>>>>> On 9/22/2026 11:04 AM, Daniel P. Berrangé wrote:
>>>>>>> On Tue, Sep 22, 2026 at 06:55:18PM +0100, Daniel P. Berrangé wrote:
>>>>>>>> On Mon, Sep 21, 2026 at 11:14:54PM +0000, Pierrick Bouvier wrote:
>>>>>>>>> We'll use this in next patch to switch FROM docker.io/library to
>>>>>>>>> docker.io/amd64. It would not make sense to add a new target to
>>>>>>>>> libvirt-ci for this, since it's just a variant of an existing target.
>>>>>>>>> Simply replace container registry with arch specific one.
>>>>>>>>
>>>>>>>> We shouldn't need to add new targets to lcitool for this,
>>>>>>>> rather it would be enhanced to include a list of arch
>>>>>>>> specific container images.
>>>>>>>>
>>>>>>>> eg in
>>>>>>>>
>>>>>>>> https://gitlab.com/libvirt/libvirt-ci/-/blob/master/lcitool/facts/targets/debian-13.yml?ref_type=heads
>>>>>>>>
>>>>>>>> We would extend:
>>>>>>>>
>>>>>>>>   containers:
>>>>>>>>     base: docker.io/library/debian:13-slim
>>>>>>>>
>>>>>>>> to allow for
>>>>>>>>
>>>>>>>>   containers:
>>>>>>>>     base: docker.io/library/debian:13-slim
>>>>>>>>     aarch64:  docker.io/amd64/debian:13-slim
>>>>>>>>     ...more...
>>>>>>>>
>>>>>>>> such that we default to the 'base' image name, unless
>>>>>>>> there is an arch specific name defined. That would be
>>>>>>>> a fairly quick extension to impl in lcitool.
>>>>>>>
>>>>>>> Quicker than I thought.... take a look at this, which
>>>>>>> I think will enable you to drop this patch and the
>>>>>>> next one and get the same end result:
>>>>>>>
>>>>>>>   https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/588
>>>>>>>
>>>>>>
>>>>>> Very quick indeed, good job :)
>>>>>>
>>>>>> IIUC, when no host-arch is given, we keep on using base, but in case
>>>>>> user specifies -host-arch, in this case we use one of specialized image
>>>>>> (if available)?
>>>>>
>>>>> Actually it is indepedent of --host-arch.
>>>>>
>>>>> If --host-arch is omitted we default it to what uname() reports,
>>>>> and the result then goes into the container image lookup, which
>>>>> is optionally specialized per arch.
>>>>>
>>>>
>>>> It works for QEMU needs, but would that be a safe default for other
>>>> users of lcitool?
>>>
>>> Yes, I think it ought to be OK.  If something unexpected crops up
>>> we'll deal with it as needed.
>>>
>>>> Technically, you can write portable Dockerfiles between arch. Our
>>>> current debian-all-test is kind of an example of it (ignoring the change
>>>> this series does).
>>>
>>> True, but lcitool isn't guaranteeing it can be done, as we allow
>>> output to filter per-arch, so there's always the risk of getting
>>> the libpmem situation - IIRC it hits with 'xen-devel' too as some
>>> arches lack Xen.
>>>
>>> So realistically I think we would say lcitool container outputs
>>> are arch specific.
>>>
>>
>> I'm good with this assumption. There are always small details that makes
>> it hard to have truly portable Dockerfiles.
>>
>> I'll wait for PR to be merged on libvirt-ci, then update current series
>> with it for v2.
> 
> FYI, it is merged now.
>

Thanks, I'll update series today.

> With regards,
> Daniel


