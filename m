Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313C9C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95ml-0003wH-CT; Tue, 22 Sep 2026 15:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x95mi-0003w8-Ln
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:04:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x95mg-0000EE-Df
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:04:08 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7Rv2900465
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 19:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2NZepq15DZq1mtUg7lpX9sAXStsT+7Mx0SON+Gs42Y0=; b=PO9So1sWD2zn8OUe
 syX1Tg1b0thLtanCITgeLgX896UDwPfX4P7Ku4YjyVF10yoRU2H5c7VVGo8U3KFJ
 H2lymnYPzfJes3pO5ZDroJ3v3seWW2e+6+0dDA9uUed4Nk5xmU8HTWmx0YKzgAJI
 8q33Vy2qVpG0ES1Po+XFDSRp/qjZRcM7XiCtypn36yYp2NKAkDy304S/Rw2NUo0R
 SfUYAW5wM29V2mpppemv+G8cmI6ec8ze+rF6jrSDSW6TAnBJiJf0XEhKB7l66pKn
 YAj77JGnHZ7Y34th6+dkE1vPd2rA3nWfraZfDkcsDDo22p/qQiVJrc9YvupkPQaJ
 1vq9zg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gunjyu5ha-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 19:04:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-333543ac378so110410eec.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790103843; x=1790708643; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2NZepq15DZq1mtUg7lpX9sAXStsT+7Mx0SON+Gs42Y0=;
 b=KysWTIithGpt7bPbkvS2YefXqfiSJP1XwjWSrtE8k3+vx0WJ9v3V5BiNjM1PZbKOTs
 KjFLqZ9Ua+rwqL+28ewfchABMO6wISUVWy+wsQE3wU4DrEPA0mTI9U4vYl647xyZ2hXD
 /isPeR+ePe9HoU+lhBOEJ8WBo7PRzjGBAQdX6Pk6x6LGOLtDNEZtm4weSgp+LfbDWajb
 BqL3Rrs5HmWcXQX+bYFJ5UA/nQS1UU5uh0ZN/IT9dh9Vp6wV6NXRoasRmMZzOf8Q/T2h
 m0vy+M1gg2r+UbetDMrIaHFyNAB7PowDDQS2oEX3IIax758gGbmjcGmuA3qpfsxLc1t4
 NBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790103843; x=1790708643;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2NZepq15DZq1mtUg7lpX9sAXStsT+7Mx0SON+Gs42Y0=;
 b=uLg+aRZEQLkjIhJWwG9qixz+PcIzgOGy3vEs9ErORUhVB9lVGFSyy8kKFFKcUvLjL9
 PBb+Pt9ZcWw/UltBZmI1Q0b+8woxEwkDrXeo9VjG/8G704GzcQPDzzSj8BQnlJIoNa/C
 fePQs9VAW8oDXGoDf9DAswrc2bXAtU4/rcoG7cIUwZlEyL68kytUCffWiJDMGCMtn/XC
 AG4w7VkX+JJxriAlt7Qoh3awhuMT5/AxM9TuGCkyBySVxU5ONPGIJtN5ChDOAMbw61z0
 /CKd7AbEvxj7pCiOH5q1aRpHBOPqdxEA1SpgMEbwj9cc5WBCEYBVk8oqRDeitmdZJibJ
 P27A==
X-Gm-Message-State: AFuF++nZ7cvwB7XcvMTKQ8/O0+AV1WBER7beX7qWaiSA5PL/H1vpEL8E
 xLW5kKSWCe4ohoZKE4U98yfyRxHdnVwIG0i8LeJLU1aQ9qKAvH7as58M/UCqMi7VxnpHr0KeXEM
 CcWx6h1LxVUdv2+XOyBY6CaDneXtNjDJOBtMN2KL84B+SCk1DLhYE6sMEaA==
X-Gm-Gg: AYBFou3FeHqvb311Hnl5mpjHuZC1fWKgo4AD3nj1XpBRqJd4A1fbC/vFxMSRcittdgT
 W6r6p9erUbkA2F6uxwCIiVpU5CfGtP960TXaNfILuEPrLrBln4+R/b+lOe8qyN+Z2uyTVYopiJH
 LyMUiVhqv8wp4xyRhQ72n+6iB3qZZf3TdgTb/pABKQzxNJt6ceyakxXEH5VNaSKZJyi1WlMhQUm
 +3v/Sr0Nesfxvv8NSPqynuhLndIGLecWGCh2SuK8PZPDkbb6eY474KfxTI5Fynp9XAiWACpzwX2
 fqZGgY44BRfv+2jrgH1QBMQJg9zsWUdMew0nBlRwauhqtKA84Ulg0qRgaNNU2yRUW5nEsuS5FOn
 7R9vVE7GPFRf79/88K8VL2gmkB8ABuUCNza9ebVZOcKBnHPIZ7mZV7Xdld3Yf7rKkGjo=
X-Received: by 2002:a05:7301:7004:b0:33c:6e4:2946 with SMTP id
 5a478bee46e88-33e8c0584cfmr193925eec.6.1790103842485; 
 Tue, 22 Sep 2026 12:04:02 -0700 (PDT)
X-Received: by 2002:a05:7301:7004:b0:33c:6e4:2946 with SMTP id
 5a478bee46e88-33e8c0584cfmr193898eec.6.1790103841698; 
 Tue, 22 Sep 2026 12:04:01 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e9625921asm279767eec.15.2026.09.22.12.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 12:04:01 -0700 (PDT)
Message-ID: <923147f1-4a20-4cb0-b2a1-ccce3450796d@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 12:03:59 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <arLQljN_Y52KdjHW@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: adUJqWKWX9RdSedFnljXmaGHHqbA1fTF
X-Authority-Analysis: v=2.4 cv=KqHYSmWN c=1 sm=1 tr=0 ts=6ab2d123 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=ErJZW3UFpw66oPMwJDgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4MCBTYWx0ZWRfX6GnF6YgLik6m
 fS+Vh0IlX4++bkkQpQ0dnPL19ooYS+oHz0pwUkhvSVkDmcAcT3Udw6IviQu6mYHN8p80jUG3biJ
 vFcmGbCU5qpakuebmTSHyLCmFIfqcgLhF5zmw+L9M1FkzUqfGZYHeKJYWYrDbhtPsNaYYQ7VzOC
 9qc4Zq0RzoyMNT8FBJGBPfeIt/aWvgFWlOyjpDQNVF7Esd5UQvmztMwQzp0gXNKnmpunkHKNCv4
 9PP60orlBLGm4teAqSsiEP6x0kTdvLumJwYYw62tVp25LGLlsdZZgD6D8gRLL92LB0Pglt1Envq
 ZLKodiVsozKlgjLq79eqcOxWeCZpKgqfy40Sw9krJhwmHnpS3EpSwsempVHtZFyd64T9FKDlMr0
 IYkTfeQf3tjm/fOL7qDF9hjuO03eOesH917KYtGq7PTnLscQeaA/L8GnyCyOMW9628yPXzHziOJ
 kWM+N+ZXfzO8r7gxBVA==
X-Proofpoint-ORIG-GUID: adUJqWKWX9RdSedFnljXmaGHHqbA1fTF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4MCBTYWx0ZWRfXx3fbX7yQSCj9
 nu3geiAbuEwBluUnuzXVEeBQ0T6+hEe7nOQUxE4n8WVHJ+xF8QmyTAAiLoxgGq9XUOtCnR06YM/
 cHyAq3sbemwsVAe+4y7W6PdHR3HCGH0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220280
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

On 9/22/2026 12:01 PM, Daniel P. Berrangé wrote:
> On Tue, Sep 22, 2026 at 11:33:47AM -0700, Pierrick Bouvier wrote:
>> On 9/22/2026 11:29 AM, Daniel P. Berrangé wrote:
>>> On Tue, Sep 22, 2026 at 11:22:43AM -0700, Pierrick Bouvier wrote:
>>>> On 9/22/2026 11:04 AM, Daniel P. Berrangé wrote:
>>>>> On Tue, Sep 22, 2026 at 06:55:18PM +0100, Daniel P. Berrangé wrote:
>>>>>> On Mon, Sep 21, 2026 at 11:14:54PM +0000, Pierrick Bouvier wrote:
>>>>>>> We'll use this in next patch to switch FROM docker.io/library to
>>>>>>> docker.io/amd64. It would not make sense to add a new target to
>>>>>>> libvirt-ci for this, since it's just a variant of an existing target.
>>>>>>> Simply replace container registry with arch specific one.
>>>>>>
>>>>>> We shouldn't need to add new targets to lcitool for this,
>>>>>> rather it would be enhanced to include a list of arch
>>>>>> specific container images.
>>>>>>
>>>>>> eg in
>>>>>>
>>>>>> https://gitlab.com/libvirt/libvirt-ci/-/blob/master/lcitool/facts/targets/debian-13.yml?ref_type=heads
>>>>>>
>>>>>> We would extend:
>>>>>>
>>>>>>   containers:
>>>>>>     base: docker.io/library/debian:13-slim
>>>>>>
>>>>>> to allow for
>>>>>>
>>>>>>   containers:
>>>>>>     base: docker.io/library/debian:13-slim
>>>>>>     aarch64:  docker.io/amd64/debian:13-slim
>>>>>>     ...more...
>>>>>>
>>>>>> such that we default to the 'base' image name, unless
>>>>>> there is an arch specific name defined. That would be
>>>>>> a fairly quick extension to impl in lcitool.
>>>>>
>>>>> Quicker than I thought.... take a look at this, which
>>>>> I think will enable you to drop this patch and the
>>>>> next one and get the same end result:
>>>>>
>>>>>   https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/588
>>>>>
>>>>
>>>> Very quick indeed, good job :)
>>>>
>>>> IIUC, when no host-arch is given, we keep on using base, but in case
>>>> user specifies -host-arch, in this case we use one of specialized image
>>>> (if available)?
>>>
>>> Actually it is indepedent of --host-arch.
>>>
>>> If --host-arch is omitted we default it to what uname() reports,
>>> and the result then goes into the container image lookup, which
>>> is optionally specialized per arch.
>>>
>>
>> It works for QEMU needs, but would that be a safe default for other
>> users of lcitool?
> 
> Yes, I think it ought to be OK.  If something unexpected crops up
> we'll deal with it as needed.
> 
>> Technically, you can write portable Dockerfiles between arch. Our
>> current debian-all-test is kind of an example of it (ignoring the change
>> this series does).
> 
> True, but lcitool isn't guaranteeing it can be done, as we allow
> output to filter per-arch, so there's always the risk of getting
> the libpmem situation - IIRC it hits with 'xen-devel' too as some
> arches lack Xen.
> 
> So realistically I think we would say lcitool container outputs
> are arch specific.
>

I'm good with this assumption. There are always small details that makes
it hard to have truly portable Dockerfiles.

I'll wait for PR to be merged on libvirt-ci, then update current series
with it for v2.

> With regards,
> Daniel

Thanks for the help on this,
Pierrick

