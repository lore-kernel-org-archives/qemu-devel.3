Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB086C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wti4s-0003bU-7V; Tue, 11 Aug 2026 04:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wti4q-0003bK-QX
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:43:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wti4o-00014j-TJ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:43:16 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67B43vZw3320894
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B2nxddVcofg6PvCUaa9DQIFWDbLiUE8FfLzL2b5XEhA=; b=ovmQjZB+JOrIk/Rv
 kP5SS19cfiSQoDakAJf8YDETxDpnVwWENWqx1dyfZBikIU3K1bIqlxPNVunW49Ox
 9M2OIuSgqhk3piWN5zyFuIoVBpf7GPs9iNcHonuTDbZW/32nig3lKtV8lyfqqgTh
 JmX5bb8KtASPqHHi2qjywc+YjkA4qc/w1uPI50c0YFPtQk6Kk/Z16B8AMFtGtxVH
 QT8tNVl5Ga7a3PzYVeSJQnUUWhKaHQhb7HnB8+/A2oiNH4iwlgF2VDbLNKBd7SNu
 KM8WTfemxMG0QMtkbxtZt+iHcKQDhgE1JrITR0blSrusSTGxEus1oZAWxdGq2Q+r
 /ABLZw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyvcr8xx4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:43:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52827090cc5so10166591cf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 01:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786437792; x=1787042592; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B2nxddVcofg6PvCUaa9DQIFWDbLiUE8FfLzL2b5XEhA=;
 b=g/ZJgvYW5oK16i8/n5S8nVDMdundRUi7cmuGYUDgTcNeyNfjFy2FcsB9ht+7oUYpQn
 qRfDfi3qrDP+WQy5FAh6qsy60ww12pVsyE4R5gJjX9+t9MVvvN3v5htphJsSTCByZSn7
 JYwqVLrtTiNPXE345EWKpyX4WVDytM0liXpqtDa4rS9lMpY11lW1HV2zo5s5BQKB5yjQ
 gIyojkHjH4mlPG2XfRudgEDVBdRUlBqd7SM7YBtzKF8cNa0+tXu0/PIlzG+eqU7u1Z5j
 9vHklp1WCMCAOQ6NH+95DLUc4N0gK0JyuvpW2GGrxlm8zZr7PvmYFDBuIHShwSK1HOIm
 weyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786437792; x=1787042592;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B2nxddVcofg6PvCUaa9DQIFWDbLiUE8FfLzL2b5XEhA=;
 b=TFjdtvK8zg6zDx2q/DLqVNdIv7t6Ezm5HZ1WNq+jBxAsgFp11ILCvgPD2bY753qGXo
 +FReF1aj/hlDa0G+lTCW1gnHiNtX9bdtY4ZMbYV4/SE6W9rCO1JnS1FX+GgDySoP+kR4
 Dnb0xp/qMt83kjTu4gBXV7y7QeUySrN6UVmsfJrzLtOq8i6puNRe4qBzDMpPUhN6h6xZ
 Yaku1tJtCIdjkbPyR68nOOBbathq7CP1LynD51hu/3kS8VHHAAhoVYbF3rdUFlPy6WgT
 l5vfQ8BflajocSKXOewlfsh+4ZFhUJppHgPgmlE83TEkgqA5vSU+FG/P6n9cyBXa6tmQ
 Lhag==
X-Gm-Message-State: AOJu0YwTW4nLXhFOpzb8I+V+meG2wjXFvHvotumNf1VIStJccGeRT0ik
 TomYmW0ornD3WqawS76dXNg6P/7+qEHWc6paBeGWEgrN8ofOhlWDjFKruc5FopDgxyMu9rpuw3K
 ikMgO9uO9vNh4hF8Zpd00PCRXHqGs9IYYSkKp6/zhHhn2ut/ZK26dweasoURQhp9M0Q==
X-Gm-Gg: AR+sD11i1uo0EUQKG46UxEP9nKBXl6qAVUfPjnQ+smppEfy4RsI8xYDVTW2fJSqJ2Jb
 oijlvux1dEShX1dPJap2Oh0fDTMBX0qxq7Du05+T49HmkWjheR02gWu/4xsbtrF6pGADSAL4W5J
 kHsHxaN676xuoengFSNpqMOELz/vxO8Yc9Lali4AQJALzW5m0pnYHQmjpHjUavp3AUjssK/ZLRA
 Sywx4GLycX2lAg08hSW0yNxDcsOXD9k7rbvs0B6KEdGdfuBs9Nb2ZGO1WgY2V8DHrIjauyfwX9R
 DtoRtbbC7ehr1oM7OiM4e8bCMQvJJSHNS1GvBMJ9osogwZiSB93pvYXz81YTM63N+gL5YrvU4Wm
 bH7ahdb9Nv9UqNQYT121n8qgoCiJmaD14FEY=
X-Received: by 2002:ac8:5911:0:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-52d59799c24mr8738551cf.19.1786437791868; 
 Tue, 11 Aug 2026 01:43:11 -0700 (PDT)
X-Received: by 2002:ac8:5911:0:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-52d59799c24mr8738371cf.19.1786437791393; 
 Tue, 11 Aug 2026 01:43:11 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997414694csm52961615e9.9.2026.08.11.01.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 01:43:10 -0700 (PDT)
Message-ID: <8d376605-e90d-4f67-9685-6c4e1ae2fb38@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 10:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/39] system: decouple qmp_inject_nmi() from Monitor
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Markus Armbruster <armbru@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-8-8af31bc54c61@redhat.com>
 <anoO2n0-ekf3EpFY@redhat.com>
 <CAMxuvazUkW=zUqJVSRG74pHnrMuqZgc71fin30rg0Hv4CBk9eg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAMxuvazUkW=zUqJVSRG74pHnrMuqZgc71fin30rg0Hv4CBk9eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MSBTYWx0ZWRfXyWtZp5Cje4bc
 CcaOR4ymdjOURWKhVhvhXOxMU9kj21Au1uf7eojwS3pLaOwtcohBnbWp3J+h/RE/3Wog/mLED0d
 d/nIxNT1ygY0uDrkzKbkAIrum1WHlunP9P7qbuG0YUF6YgR2FO7n1/CbNWdBIyBycF2CtqD8n2A
 mQMPr+ftC7IeZW46BtYV81ewxQ/TM4D3xFUzoMgTp1plly3mhyfYUCS2tHuZb3ncZ8zplkng70E
 M0j12EawONF8E8tnF4sweZylhcwkjMXThD1K1fttf/j1/cVuySonQcmS0ehTLEQA+jy6o+LEQFv
 FjxVRdR3EdQrUgzvZW5tBWSmuK6ZoFFBsw1O2ZGwx+U5fgnCzlUA9xmshtwUG4yBQXxHL4Y6I7p
 O+8fjGAvSFLRhH2WwexhCEM4wGBhkIFMXRGHW9bvcs7pWvwaBPCiPGGPMGt8EzPbRmaovkI9xkm
 ILzw9A2qJnpjUvwhllA==
X-Authority-Analysis: v=2.4 cv=e/A2j6p/ c=1 sm=1 tr=0 ts=6a7ae0a0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=E2OFlpCjAAAA:8 a=vqL-DJG3AAAA:8
 a=SqMvC5kiAAAA:8 a=J7Vs0gARAAAA:8 a=iXcLlBOuAAAA:8 a=20KFwNOVAAAA:8
 a=F0qsyyxOz1rhUYwkOXUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=l0t8tTNIJzRGstKQVvrs:22 a=N5whb6oI2XAsh5LpMrx1:22
 a=_o8VnCo6Hb5Oqlm6Mk7M:22 a=GK7RtA2AnwkbbjW1WRsD:22 a=U82d2PgYpd_3u6iqMSvn:22
X-Proofpoint-GUID: aFhw3JEPbZvrlhGFC4HQHvywEnAL7RKp
X-Proofpoint-ORIG-GUID: aFhw3JEPbZvrlhGFC4HQHvywEnAL7RKp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MSBTYWx0ZWRfX1B+llkYIB3Te
 MH5XPFAv794DxUZN/c6dpsaYBIYUVKpaXn++UII8i0Yv1mXMMI/zvFOO3RQK/nqRnVl7RV5ALtb
 Y6r37TOguuVhTgpV0bYruZnVerCgpEE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110071
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

On 11/8/26 10:18, Marc-AndrÃ© Lureau wrote:
> Hi
> 
> On Mon, Aug 10, 2026 at 9:48 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Fri, Jun 26, 2026 at 01:19:09AM +0400, Marc-André Lureau wrote:
>>> Use first_cpu directly instead of going through monitor_get_cpu_index(),
>>> as this is HMP-territory. QMP doesn't have a `cpu` command, we should
>>> add arguments instead when needed.
>>>
>>> Update the inject-nmi doc to accurately describe per-architecture NMI
>>> delivery.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>   qapi/machine.json | 5 +++--
>>>   system/cpus.c     | 7 +++++--
>>>   2 files changed, 8 insertions(+), 4 deletions(-)
>>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> I realize the patch is wrong, HMP calls qmp_inject_nmi(), we need to
> pass the current cpu or not use QMP.

See 
https://lore.kernel.org/qemu-devel/20260810213723.58467-1-philmd@oss.qualcomm.com/
which disentangle monitor from NMI class.

> 
>>
>>>
>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index 685e4e29b87..03461f5f723 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -432,8 +432,9 @@
>>>   ##
>>>   # @inject-nmi:
>>>   #
>>> -# Injects a Non-Maskable Interrupt into the default CPU (x86/s390) or
>>> -# all CPUs (ppc64).  The command fails when the guest doesn't support
>>> +# Injects a Non-Maskable Interrupt into the virtual machine.  The NMI
>>> +# is delivered to all vCPUs (x86, hppa, ppc64) or to the first vCPU
>>> +# (s390).  The command fails when the guest doesn't support
>>>   # injecting.
>>>   #
>>>   # Since: 0.14
>>
>>
>>
>>> diff --git a/system/cpus.c b/system/cpus.c
>>> index 49f6daec3cd..6e3ef0afeca 100644
>>> --- a/system/cpus.c
>>> +++ b/system/cpus.c
>>> @@ -915,6 +915,9 @@ exit:
>>>
>>>   void qmp_inject_nmi(Error **errp)
>>>   {
>>> -    nmi_monitor_handle(monitor_get_cpu_index(monitor_cur()), errp);
>>> +    int cpu_index = UNASSIGNED_CPU_INDEX;
>>> +    if (first_cpu) {
>>> +        cpu_index = first_cpu->cpu_index;
>>> +    }
>>
>> I'm wondering how this "if" logic turns into the behaviour documented
>> for x86/hppa/pc64  vs  s390 ? Don't all those arches have 'first_cpu'
>> defined, such that this changes semantics to 'first vCPU' instead of
>> 'all vCPUs' ?
> 
> All the nmi handlers implement cpu_index differently.. I have to review this.

(ditto)

> 
>>
>>> +    nmi_monitor_handle(cpu_index, errp);
>>>   }
>>> -
>>>
>>> --
>>> 2.54.0
>>>
>>
>> With regards,
>> Daniel
>> --
>> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
>> |: https://libvirt.org          ~~          https://entangle-photo.org :|
>> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>>
> 
> 


