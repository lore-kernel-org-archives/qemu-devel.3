Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F02C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95JW-00070Z-W4; Tue, 22 Sep 2026 14:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x95JW-00070R-9M
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:33:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x95JT-0005aF-Sl
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:33:58 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIXUIa268471
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 18:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7qCYR89grAi9JEcjhyqM3sJeqXoYiAy6lFPaxGc03i4=; b=iznNQ72+osCc07l5
 3XNwmu8m5jaSKiTUy3lSZx2zlFC8JLIP4H4ruuIJ88ncRJwiKosMltNVt327fPNl
 3PUEFGOP4H25Gb2S8/uY15U8DER3Ssjd2w5MS/SHiL13WWRSf1yFYx0gZ+O0V9Mg
 LHDz5iNre6bm8gOagh8LLC2yC1hF+vZjybipNdA2EiNglj6D0HttGVBzh11/ej6l
 PzKcY6btorNAhoOPNZhe8MxVItdZKGc4EOEYxUz+xhzxI7zbMKeeYb16q7h2KoU3
 qMjP2024MpaHnBbcaUsYINQx7Y/N6C0QDToawTch+7sArSJiqlxUmHxVwEgnOxi4
 g2uAXQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guy2c0033-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 18:33:51 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1431ba79941so118275c88.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790102030; x=1790706830; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7qCYR89grAi9JEcjhyqM3sJeqXoYiAy6lFPaxGc03i4=;
 b=e34p20XUg20SW6ElZdyC6NSBvaJym5LLzrcYDiwNjQ2qvCMzPe4WwMma9rGg06IoME
 pTHWgEJrniNHc/N70eFGJwhO+uYC0n7uDftSv6nijnR4h9W/AdugTAvgD8VUoyJufTf5
 0XAgXnqE37P/g2RLHCqc6bfArYCh8JUT8kSQmWH1YDeNJ72V757xyxdonc8mLCDsqHU5
 Z9hUuoBLK843FDD6I51pIxVLVcslVqL1R03i9zsGo88P+kfRsHDD1WOCjlIaWdoUUqTb
 rAPw6vI9ti/gc9Eji/9EHLRywbhYkEbrWDrOjf6/PMOjtPayHiuEbcoHpvB1Qx0m42+f
 wgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790102030; x=1790706830;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7qCYR89grAi9JEcjhyqM3sJeqXoYiAy6lFPaxGc03i4=;
 b=qTJkWx0CsE3wmwxoQWRvljgF6PuFdwWk+PP/HMyJ7mmRRFzIrEo5crOhGrK7SQ8f0j
 jsKjV6o2MHgomf5Kavfq8YKMNpt2va4PoGbSjbQ9uvIgqTm9a4PN65ksFo2CTdHfkC+z
 6i6ZPwYE4i4xQOEyCYA9RkmguGcx3fSGhKbxkjo3G86LJE61IS86F+jwNTpQ3hVmjArs
 ibUi+fDpTn9zJCjUwqJOkeODhvOdq1QQpQsNigre+3sSodzGal7FnSCJpy4aYoONEpx6
 f+IDtC44NumVIdQkV20ab0TZB3o66DTZiaTTxEE/geZqDGiFX58e8fZdrRaQdf/fwEu9
 DTeQ==
X-Gm-Message-State: AFuF++nPrSdg4LDwyUNB5ImAIPvxW8J7LmKSYTnh5y9OR3HNSW/0Du6L
 sVROTHKERsaYJmRu3PqHbGviOvN9HfQKVR6hxTHGK+4WmPnH1owLREO4J77K/WYJhTceHR0Vgi3
 YBgArQZEuPwyvOinVGdP6KugFBHiFas1pzzzmQuW9XHQM4KWDh9SHKFS19g==
X-Gm-Gg: AYBFou2DOBKAyPXN/9TxXcJtz7gmYuwfeLTYAkLwbybOpPc5cHfHJJ0HzXgIVE1psYM
 /Ph66hT7hIIwQdZkljVLljKL4aLdBsOLw4Pyt9wf4/SUXLzIBeN+lM9xHSNX44nyJuh08i4PZpz
 DvNx5jmc5ZYeiSJa04lb1p/YfX5ONo+gOZVY8mdNC02G3mXqd4giFiLxccaFp6AP4LLJ4+USWNS
 rvteB3+BdBQxPMPKQWJgVcrDE5RCcKe2kv2zy1etCJqs9+kyM/b9YXks/0F73b1AtHE85dUts00
 AhDeN7WVcK1m10PanOhRaOSmw7Nr5qFo9IeXlPdSQNR91ZrbZFAJQPTSaP2KlG8ExEDbl/n9Bva
 PbGrGMF20xLEfHAog0bfGmK2iVnD/8IKZq3GG4q6Y5Lg/ljMxvtDJWhpxomglvQh0ekg=
X-Received: by 2002:a05:701b:42d3:10b0:143:5c2a:e488 with SMTP id
 a92af1059eb24-144f8fc7b95mr295127c88.0.1790102029873; 
 Tue, 22 Sep 2026 11:33:49 -0700 (PDT)
X-Received: by 2002:a05:701b:42d3:10b0:143:5c2a:e488 with SMTP id
 a92af1059eb24-144f8fc7b95mr295085c88.0.1790102029255; 
 Tue, 22 Sep 2026 11:33:49 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f9820ca5sm217042c88.3.2026.09.22.11.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 11:33:48 -0700 (PDT)
Message-ID: <f193b3c9-bbd0-4ab5-8706-43407873ca5b@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 11:33:47 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <arLJAD64Vwer21My@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: h8EnvE8VSknYSVFjCh52FO6NtNhfwkBb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI3MSBTYWx0ZWRfX0JPalpDS9GLU
 26kGiGBHdegr5rDf27NnVGl8V9sUfWZv/4cY7C/7vyRH9npR82c0akL7MrvD/PVGmqF/Om25mDf
 C2MSNIRnu4WhbgpjrQ1yzlq6MFMCsUY=
X-Authority-Analysis: v=2.4 cv=Zsh4uN7G c=1 sm=1 tr=0 ts=6ab2ca0f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=NoJ001HoygGpemXvnKsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: h8EnvE8VSknYSVFjCh52FO6NtNhfwkBb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI3MSBTYWx0ZWRfX9OubT6SvplY7
 KtOYoTDJ2izFPo6nRDeOIfVmjGaW2lEueJb4nKN8Tb4bciXfvXOzfvtTRoNw19lBORh+qAbuwNZ
 3QkwOWqYASYW91iMYsADS9U985W3dpnFq0XnfrC5gG1M/4swGlXw9ip+FyRAttnaNYMljWtabMn
 5zQjUp23nJj5tNFG0p+ZuHwa8s3NhKmMukWBLS7tM2KFGRdyHc+f3Rr9hrjnuBdfbEIbl5WfJYT
 UWPdQrx10/yUf2rUJBcjJ5N83w04V4+INTWKBtTxkU4diZeEB0qPi/JBFWnwGWZCocbp+afW3MO
 3DsYn9yEBLH9ET/msUUi5L6nabJZZ3cQCKJxkioftS3VcglEX2C4OjhmAyxINRGeVi3LmN9H/8a
 zS0h9+TxjuHhvnTQm1oW41SjSQSzfe2fkeddFhK/LwmjaNV4X6dCQyCvi0sRj6PmhFhrbFkE1Zq
 8kabIdyX/5Z2f6RU7lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220271
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/22/2026 11:29 AM, Daniel P. Berrangé wrote:
> On Tue, Sep 22, 2026 at 11:22:43AM -0700, Pierrick Bouvier wrote:
>> On 9/22/2026 11:04 AM, Daniel P. Berrangé wrote:
>>> On Tue, Sep 22, 2026 at 06:55:18PM +0100, Daniel P. Berrangé wrote:
>>>> On Mon, Sep 21, 2026 at 11:14:54PM +0000, Pierrick Bouvier wrote:
>>>>> We'll use this in next patch to switch FROM docker.io/library to
>>>>> docker.io/amd64. It would not make sense to add a new target to
>>>>> libvirt-ci for this, since it's just a variant of an existing target.
>>>>> Simply replace container registry with arch specific one.
>>>>
>>>> We shouldn't need to add new targets to lcitool for this,
>>>> rather it would be enhanced to include a list of arch
>>>> specific container images.
>>>>
>>>> eg in
>>>>
>>>> https://gitlab.com/libvirt/libvirt-ci/-/blob/master/lcitool/facts/targets/debian-13.yml?ref_type=heads
>>>>
>>>> We would extend:
>>>>
>>>>   containers:
>>>>     base: docker.io/library/debian:13-slim
>>>>
>>>> to allow for
>>>>
>>>>   containers:
>>>>     base: docker.io/library/debian:13-slim
>>>>     aarch64:  docker.io/amd64/debian:13-slim
>>>>     ...more...
>>>>
>>>> such that we default to the 'base' image name, unless
>>>> there is an arch specific name defined. That would be
>>>> a fairly quick extension to impl in lcitool.
>>>
>>> Quicker than I thought.... take a look at this, which
>>> I think will enable you to drop this patch and the
>>> next one and get the same end result:
>>>
>>>   https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/588
>>>
>>
>> Very quick indeed, good job :)
>>
>> IIUC, when no host-arch is given, we keep on using base, but in case
>> user specifies -host-arch, in this case we use one of specialized image
>> (if available)?
> 
> Actually it is indepedent of --host-arch.
> 
> If --host-arch is omitted we default it to what uname() reports,
> and the result then goes into the container image lookup, which
> is optionally specialized per arch.
>

It works for QEMU needs, but would that be a safe default for other
users of lcitool?

Technically, you can write portable Dockerfiles between arch. Our
current debian-all-test is kind of an example of it (ignoring the change
this series does).

> With regards,
> Daniel


