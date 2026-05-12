Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA692CD37AC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 04:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMeZX-0003TY-OS; Tue, 12 May 2026 00:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMeZU-0003Sf-FU
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:18:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMeZS-0005pB-D1
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:18:16 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6j2s2187626
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 04:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vK4FfLA4nc5NIYhgA7gEmM2gj7sivHrliJZ90cd1C9o=; b=j69uPC175+6nnzRy
 s50A+lYnFjg3Vc3bB/0bYHGu4pypP/4X8wZytGNCIAYVkVknJUOjdnkff5qx8g5q
 5PEMbaxBnYRZKjc75nUJyDNq7VXJzQvztNbUhw877iOEp8PDfpcoMaaQc7b7Tdxu
 0EAcjB8Hj13Ff6lS7lYkjEXfBh0ksBzRGHA5rdtZVZ7Xe1b38xRpVCCY8Tg3k7hA
 7k5oSkX1sY9fEvec6wuAM3a05F6SRAtGRODUYt/yKV/wCqGJkBZParKFivokYUh0
 HWQXWgstM8uXFgqrCFIx9OdKTrsy7d+0Lr4kyfUfbzWEhinPmm9WGajVzN/9WNF/
 /xaoBw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0sccn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 04:18:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so8179154eec.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 21:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778559491; x=1779164291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vK4FfLA4nc5NIYhgA7gEmM2gj7sivHrliJZ90cd1C9o=;
 b=IbtNI0PHs6a5OlctTGhTsk1yDrn3szhpb2dZuY7j77CYTSJ1HlzZyVeN/2clkODRoT
 Bgq8hzoxry1v9l35gvTsc2dbquEuPFXDU4K/lB5ceP5PjHye0gm9QOlwBnAVAR+Pp+uw
 xsQpvgcoyXxnwAun55T8xC+vTdNpqdE9bv98TLQDdt5b5lda4esYnRPAdWr59qw0V/4S
 R0CZeVDcUA5/sLRoSp03S2Bo84hPXXMa++OrHceYyfECw1RixTpxRl7j4xEIUWNFLeOJ
 d7wpWwv89dgttKRfAuihYrP33Ilhj1vMUNZCn4ZeRLhLbt7jlf/4XNEbadhknFtTHh2d
 qPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778559491; x=1779164291;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vK4FfLA4nc5NIYhgA7gEmM2gj7sivHrliJZ90cd1C9o=;
 b=GUWi3zn6kaVbbFp7sugMyAB+AjqgckMrfpgzt+YkwhSo1b5xJ+1Xfe9I2UP/gD2cZh
 pfT546n7+gJZqJVngorDJMkYU3VNxoF8Xtc5h71Wneg/vDOgE42VZyvh3P4wiojr4Qfa
 XcL6EnHKeh0jhQM7LYEefTcS5Z/dAX2qvFhce/IPGGwjgIglGP+tyKdIfYZyrLVrdrSY
 KujEGNU8AC0Dn6x7Zq7CKZt0BhqKpxYWaAfYBTPTprxzYSPkkvpGylI5/dEhdMZDR1oy
 2drY6V3gcZdA5yMwKQLJzdJKHIIXgyvSuAgF+6YJJINtel2dwSpuaXSX4/4Sywp2C7Q+
 lSlw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RmB83tswa/0hF7g/9Xsuf7ckDcl667qi9eNDed5o7kMIHuM3hUbg8aI0SLUJZrJoIrQgiSMcCpnQx@nongnu.org
X-Gm-Message-State: AOJu0YyF8bFjrMTLaQAMFXDIU/Sw2fFH/XuRecULZlz/vrott3PIFBFe
 bLr+lL5NXuSrf3L97/VRjhjpP56KIPykRX4MmVVtMGTopQ7/ACsYFcLxYoDX8A3A2u9QLKRHxVE
 tRurmOfMlmO7Bm92e5UvDqsnGYlyk/7fB/ArBwUqQukYukJdrtvZu6zqr1Q==
X-Gm-Gg: Acq92OGa4AM1+NxRJoJg3sMKjNVLnMmaavnv3S7aAg05BmuE65tthuRHD7L12QNU9F2
 fJL8IqxhWjfJMrz7422gy8r6Elvu1Gb3Dy84eVQb7+VdyGpeaJwjakAXLALvjpmaAFW/kKj5RRm
 MVsg1/5B8vsJ3ajkoWhwzO44bjEfLjBXcWtVcBsqIWSBDjjlbevXGZk/Z7ZFpLfroQ7LfsmW81r
 /L/mgZRPvc3ItvhyzFSmHjpphRdbICdyHjii0tZVAdEmpXM0lgS3LsFG3MFkS3kXgm0SYEG8702
 ophIicCAk4bRfH1wjB9dmCKrsM5Ng0/7D0EXDRYkCzwdLupomctV/u47QA1iwDQLYuUgnkNuVOd
 S5PFOq/tJ+8mBrPIDJZ+RLrOHpxtpv3qAYHYXPLWR6XS/hYAgEWSBNj/D0NfNvscuXp0fmHEJ+d
 bLEZZ0qfhsH5F9hg==
X-Received: by 2002:a05:7300:a987:b0:2df:c5bb:3720 with SMTP id
 5a478bee46e88-2f54c587faemr13434634eec.15.1778559491093; 
 Mon, 11 May 2026 21:18:11 -0700 (PDT)
X-Received: by 2002:a05:7300:a987:b0:2df:c5bb:3720 with SMTP id
 5a478bee46e88-2f54c587faemr13434619eec.15.1778559490486; 
 Mon, 11 May 2026 21:18:10 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888c3b301sm20447728eec.23.2026.05.11.21.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 21:18:09 -0700 (PDT)
Message-ID: <7827e30f-d35a-474c-aaff-01fe59ff8625@oss.qualcomm.com>
Date: Mon, 11 May 2026 21:18:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
References: <20260506135524.20617-1-philmd@linaro.org>
 <20260506135524.20617-90-philmd@linaro.org>
 <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
 <a57d5120-dabf-4953-a680-a9c875ecf238@linaro.org>
 <49384318-3050-46fd-af06-4b5c0a14699b@oss.qualcomm.com>
 <dbd55bb5-392b-4a8e-b332-bc009b99014d@redhat.com>
 <5c5e992b-e093-462c-999b-47ff0e5c07ef@oss.qualcomm.com>
 <c4ba13b3-6e7f-45f0-9f4a-ebe2f7415f34@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c4ba13b3-6e7f-45f0-9f4a-ebe2f7415f34@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAzNiBTYWx0ZWRfXza7rWD1BH1pU
 iNz6W8uxvN32CXeTjK0PeZrV96ClgfDn6EZjDnzz1oZaUte8IxCgrOTQp+3p+Tv8Z6Rwz1oRqCY
 7KTqZY8y3DTKKSRZHBDrSnsT3AAcp1zHcqK6aWgM+JecY0/7LJk3k5pWb21+RtzNFBWZZZfv4iD
 LYWQ0JuWWDWaup5d/2vUhSOrGqLPub00U9KkEVKtimnwldVeGQNeRyhmiTGlBcVb81TpqBlzwm9
 ccG9zhRKBqwxUglKUjvTTlSbfZHS7UmWrkcWh4p2z+aLTEcMRWdjgwFtd8J+1BxopIPKBHeDOia
 oOaK82bRUpXA36fficZdkrM+NS0R4hKLdlATCFO6++BcKAWP584j6bk65Lv6TH1LFshXnVLxKOV
 BoQuAPXrAIkqfm328TA7utabDS7C0jbRbPL9cbqV3Jdn8fQBn7g3ZBYDyyZ1VXoRdrKXZDSUaA6
 m+2IhQIdT5M7If+CL6A==
X-Authority-Analysis: v=2.4 cv=bpB8wkai c=1 sm=1 tr=0 ts=6a02aa03 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=ehYRL7wMAAAA:20 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=y4Ks7J_q2si82F7K8E4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: LOq2ot6GwnaWWSMU3R4SfAB886d65FuF
X-Proofpoint-ORIG-GUID: LOq2ot6GwnaWWSMU3R4SfAB886d65FuF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120036
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

On 5/11/2026 8:36 PM, Philippe Mathieu-Daudé wrote:
> On 11/5/26 23:07, Pierrick Bouvier wrote:
>> On 5/11/2026 1:46 PM, Cédric Le Goater wrote:
>>> On 5/11/26 19:59, Pierrick Bouvier wrote:
>>>> On 5/11/2026 10:48 AM, Philippe Mathieu-Daudé wrote:
>>>>> On 11/5/26 17:48, Cédric Le Goater wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On 5/6/26 15:55, Philippe Mathieu-Daudé wrote:
>>>>>>> Introduce a source set common to system / user. Start it
>>>>>>> with the files built in both sets: 'cpu_models_user.c'
>>>>>>> and 'gdbstub.c' No logical change intended.
>>>>>>>
>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>>>>> Message-Id: <20260423135035.50126-4-philmd@linaro.org>
>>>>>>
>>>>>> This change introduced a regression with PCI passthrough which
>>>>>> stopped working. Guest kernel reports :
>>>>>>
>>>>>>      [    0.156501] zpci: PCI is not supported because CPU
>>>>>> facilities 69
>>>>>> or 71 are not available
>>>>>>
>>>>>> and other devices (ap, ccw) are impacted too I think.
>>>>>
>>>>> Is it something we could test with the mainstream CI, or does this
>>>>> requires specific hardware?
>>>>>
>>>>
>>>> It could be tested with a tcg arm vm + nested VM with PCI passthrough.
>>>
>>> Yes, adding VFIO tests to the QEMU upstream CI would be great.
>>>
>>>> However, the problem is that you need to cross-compile QEMU in CI to
>>>> test current version to launch the nested VM.
> 
> I guess remember one of your scripts close to that setup, mounting
> the same directory in nested guest with:
> 
>   -virtfs \
>    local,path=$(pwd),mount_tag=host,security_model=mapped,readonly=off
> 
> Same could be used with s390x / x86 I suppose.

Yes, it's another possibility.
I just like the idea of generating the image on the fly, and not have to
host it/update it anywhere. Considering this, it's "free" to include a
binary at creation vs a mount network.

For reference, this is the script to create an ext4 image from container
[1], and the custom init booting [2] and running a custom command.

[1] https://github.com/p-b-o/qemu-linux-stack/blob/master/build_rootfs.sh
[2] https://github.com/p-b-o/qemu-linux-stack/blob/master/rootfs/common/init

The scripts in themselves are not important, but it shows how small they
are, and thus, easy to develop and maintain.

