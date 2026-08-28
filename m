Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B9BC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzy4M-0001Qx-6v; Fri, 28 Aug 2026 11:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzy4I-0001QO-C0
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:00:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzy4E-0007Ec-PT
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:00:32 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDkdJW2538480
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4azgbFq2nQKth/Gl1h93wp/iIU5ib0OFdKkEBJq6g5A=; b=j5/CccxsGWNeqqRT
 0C4b2NVAOqSzsU7FkL7htY+H6VMQ4mR2jbYMbKfGhgp5puW7Ic7y4GnJRQuV9yVl
 /XWUvRQt+n33ABbTj1UIS7KnFVKD7PZ4YPydZpq4GWIY1N0cLBDiiNRv+JKkaZ1i
 jrefmz4AiNO845Kn1HeyExBsGmcx8/hOekA0aHhfY8EwWNfaeT2XmbpA2BwMTELT
 hQRZy5iZrnmJN2EPVjPrnul7DrdhCz3/psburSfa1lFDnNMZa99i3TGcU8HWrRAZ
 BLD2ZFD2HqLAjgtX4Y9/pGooBTV/YM+dtJyqcPdf8+R4IBVTW+VFVq9byyyFnRDi
 Lc1U2w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mua8dc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:00:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d001671a54so19640565ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787929227; x=1788534027; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4azgbFq2nQKth/Gl1h93wp/iIU5ib0OFdKkEBJq6g5A=;
 b=GXNZ1tLmjbMEPjrAqUDony7n8H7RLDNw/nETRqCSqJwdOHAcynXNX7h8naT71XH+5q
 RNKbp6JfghCTPGyodOQd8eu2mUsGs0saYOXVuPBh58ta7SgwUC8PwHzO5XBfC0QgsuhF
 I77PvikPDtsXV5g6jaEqT9Ya9Fe/YmH5Ja9R5LKARyvD2r/jdj1fgj7YOw2gOQQiRkkQ
 VTXzE6ahiH75KGfybqyZ0S5DENKQKquUHm1BZWVJeiDX6ZY1ttEokmuK68g6SMRlPjbm
 rnWBeQDjWxmmFQEoJvLDoD9lJyjB8aan+96bdBxM02VSlV0Cycvg1OZyNgfsjXe36uun
 8D4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787929227; x=1788534027;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4azgbFq2nQKth/Gl1h93wp/iIU5ib0OFdKkEBJq6g5A=;
 b=sDg5WTH5WnwVB2XTsVdAPl5wvUcL1wDcSaOR8/n2TMibfh9cSmy6S7a19ZUDwBvO8o
 7izBTS2QE7oDBEfVEvBt9y+bPDv6UbfUWg0H5u8yJ8DPpRuJeqJl0Pp/98KcM25n2CUJ
 8UJNLAOTUb+xF8UXJcKUMamDrU6KLnmum+goTrxfPe5MY96BZHE+WuNBt23TlTBd+Eyp
 DMONdV/ScZu2aI9V3ruGQyK2RkAXvKAmMEDLN5XMp1aUvjWgZpUl3ENkYRoirOCot6NJ
 orRsqYjMgU9+UC+QKsg8qQ3uZjmKFMWNoOwXcu80/IMO9Fl5l1nl998ppYJt4dUj+sC7
 KUXQ==
X-Gm-Message-State: AFuF++naSZ7YuDUDuo1PtvG+ViudSVUsf0EYn9VJrDXLL11DXGExK/7v
 8nqooYaZt2O0pfRIPoAnpuvWaF1tuihNPZSkWm/Fh0TVagH7T9QgxHUA09Ym/NgltQQYvOScQzf
 2HzyHw/VQLRLGk8yF0yQqtyn2yuZflI58fmnxlYCUw+2HkRHa0wq+HnK4GA==
X-Gm-Gg: AR+sD10gshDSQUt1CZxhk55J7BfX+FV6iXtXupdrxRdvfuZqDeW203H9sk+8vku8iVG
 vrKBJlB92diibNG3vxn/u6khoVdV/+s3LfUZA2RkoqXD+yR2bJ9fBf8A8LyGxnMP4WsSzIqqSt+
 XFBsIa7s//ZbvxFEJ7CrWexGBeTkE8qIBA0UPLqGV78lXxKOd1If12B4yO/KofvgKulPYbTs/7Y
 aT0zKi2P9xu5L75c3vtkxa6SPPJv+T/dCzhTecjmW0m2q6Wq3bHzVqw6yI+jjirT7eImmLl2ert
 gjgWRChtEPpAj16KNtwc9Tg/+Oc7cw+MN4hjLCVY4BsoEfqLYCJ/RWRJe+BdKY7u2cZrJzZM8Az
 9z2xHPkpmkKFBlvBYoISOjdUx8eQ6VXRc1eyh1PHwa4/ciZQd3aIKbCo=
X-Received: by 2002:a17:902:f546:b0:2ca:6c8:abd8 with SMTP id
 d9443c01a7336-2d74df45042mr134414135ad.12.1787929226531; 
 Fri, 28 Aug 2026 08:00:26 -0700 (PDT)
X-Received: by 2002:a17:902:f546:b0:2ca:6c8:abd8 with SMTP id
 d9443c01a7336-2d74df45042mr134410775ad.12.1787929225548; 
 Fri, 28 Aug 2026 08:00:25 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d759869b28sm6269555ad.39.2026.08.28.08.00.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 08:00:24 -0700 (PDT)
Message-ID: <0e1c8986-6b72-487b-abe3-7c559457be73@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 08:00:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/1] tests/docker: ensure container command is probed at
 most once
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
References: <20260716195807.3219466-1-pierrick.bouvier@oss.qualcomm.com>
 <20260716195807.3219466-2-pierrick.bouvier@oss.qualcomm.com>
 <87v78u3007.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <87v78u3007.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZbMt8MVA c=1 sm=1 tr=0 ts=6a91a28b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Y4KUgLan4rUVnHkZcAsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: uH9bTaF2-0-I4LKXy7aAImN5ihpgu6lL
X-Proofpoint-GUID: uH9bTaF2-0-I4LKXy7aAImN5ihpgu6lL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzMCBTYWx0ZWRfX1byoMa5SUYXN
 NNI5KqidvrE4Yci3UJNqIyKXXgCYhO8WdtIM+us13Tku2SNdR8pZapsIvPKjj3VjpF6NAm6twFK
 0/Cd7nANmj2uZslUqDfLycRNONVGeuU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzMCBTYWx0ZWRfX4PhOT/rhJToY
 UAU2VxQmrdzrK5nCz97/v8eyc14/fFq7FpeS6/GBNp/fM9pTpvxNsRlJKh7+chotbwJHL7rQqiC
 RAKCiZVUWPSrB11BiMR0d5+w+3cORgh1AHNIYxaOVBbPHSkW7FdpKzaxGEIlpfAx1qdKOkqS3gA
 fd71KFBjMLzXQeLnXtQRjT3IawWJq+/oRBFwA32tYp0NXEaciI7Ue23MbID3542AE2BV7Eh4tEX
 znGErRCpNJ0EUmY8LsxvRr9i3slJUg3EHWxx3BB3NFTe3RjgdCFNt3djmxJBa4EZowop/BGfP/U
 3sw2dcQJ5+chgcMx910VggJZYcfInT/Iu7sLMkB+kh7Cwcwj05XYhntM+OAWhVw3BrRmCzmwKfg
 Iew1KjETrr9EFoNYZpDnx2uDIfakb4tiS0Mkq7fg8jVTxp79rscPJNnMqnYdYlKUoeZZjc3Vrnn
 ee2RvMrUAejnaLV7Q7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280130
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

On 8/28/26 5:25 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> From: Daniel P. Berrangé <berrange@redhat.com>
>>
>> The '--engine' arg accepts either 'podman' or 'docker', which is
>> not sufficiently granular to map directly to a command. This
>> means that  docker.py still has to then probe the exact command
>> to use.
>>
>> Meanwhile the 'probe' command prints out the full command to use
>> but this cannot be passed back to docker.py to avoid probing
>> again, so the caching is only useful in the few case where we
>> run a container directly bypassing docker.py.
>>
>> Address this by replacing --engine with --command for docker.py.
>>
>> This in turn requires the --container-engine configure arg to be
>> replaced with --container-command.
>>
>> With these changes the container command is probed at most once
>> during configure and never again, while running in an unconfigured
>> tree will still probe on demand.
>>
>> Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> Link: https://lore.kernel.org/qemu-devel/20260716102515.1503404-1-berrange@redhat.com
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> I've bisected to this as breaking --disable-containers:
> 
>    ../../configure --target-list=aarch64-linux-user,loongarch64-linux-user --disable-containers
>    ...
>      Cross compilers
>        aarch64                         : aarch64-linux-gnu-gcc
>        loongarch64                     : cc --cc loongarch64-unknown-linux-gnu-gcc -i qemu/debian-loongarch-cross -s /home/alex.bennee/lsrc/qemu.git --
> 
> So some mangling with the container command line has happened.
> 
>> ---
>>   configure                     | 25 +++++++------
>>   tests/docker/Makefile.include | 13 ++++---
>>   tests/docker/docker.py        | 67 ++++++++++++-----------------------
>>   3 files changed, 40 insertions(+), 65 deletions(-)
>>
>> diff --git a/configure b/configure
>> index d8bc10060e1..6ddfe4b5342 100755
>> --- a/configure
>> +++ b/configure
>> @@ -172,7 +172,7 @@ fi
>>   # some defaults, based on the host environment
>>   
>>   # default parameters
>> -container_engine="auto"
>> +container_command=""
>>   cpu=""
>>   cross_compile="no"
>>   cross_prefix=""
>> @@ -734,7 +734,7 @@ for opt do
>>     ;;
>>     --disable-containers) use_containers="no"
>>     ;;
>> -  --container-engine=*) container_engine="$optarg"
>> +  --container-command=*) container_command="$optarg"
>>     ;;
>>     --rust-target-triple=*) rust_target_triple="$optarg"
>>     ;;
>> @@ -869,7 +869,7 @@ Advanced options (experts only):
>>     --enable-debug           enable common debug build options
>>     --cpu=CPU                Build for host CPU [$cpu]
>>     --disable-containers     don't use containers for cross-building
>> -  --container-engine=TYPE  which container engine to use [$container_engine]
>> +  --container-command=CMD  which container command to use [autodetect]
>>     --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
>>     --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
>>                                  is to use the whole 64-bit range).
>> @@ -1291,12 +1291,12 @@ fi
>>   ##########################################
>>   # functions to probe cross compilers
>>   
>> -runc="no"
>> -if test $use_containers = "yes" && (has "docker" || has "podman"); then
>> -    runc=$($python "$source_path"/tests/docker/docker.py --engine "$container_engine" probe)
>> -    if test "$runc" != "no"; then
>> -        docker_py="$python $source_path/tests/docker/docker.py --engine $container_engine"
>> -    fi
>> +if test "$container_command" = ""; then
>> +    container_command=$($python "$source_path"/tests/docker/docker.py probe)
>> +    test "$container_command" = "no" && container_command=""
>> +fi
>> +if test $use_containers = "yes" && test "$container_command" != ""; then
>> +    docker_py="$python $source_path/tests/docker/docker.py --command $container_command"
> 
> else
>    container_command=""
> fi
> 
> ?
> 

@Daniel, could you please take a look and fix this change?

Regards,
Pierrick


