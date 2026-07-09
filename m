Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72F8C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 21:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whvwb-00041w-Bz; Thu, 09 Jul 2026 17:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whvwZ-00041l-LH
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 17:06:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whvwY-0006E3-4s
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 17:06:03 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669KZFTa2917694
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 21:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NT9wSTQqiCx6Py9n0wbJL4qoTasrN/ID+pg47vv78nQ=; b=kt1ZxkHvzW0wUbUv
 cxr7xJbguM/A84arNchs07gtORTEeCUyKO2WQHln0Blmodc7pGIC/AKA6IyAtHwO
 ogHxnowOtvFLdyQWBPxMg4nIW6zf73DdZ8neL3l1e8tRRQfe/hfG3E3gzoRzqR9/
 BQK7acALBmzerH8Id+/sHfIQew3KGGJEXfQdZmHSen2oZeH8v3xDBuvLFbjKxi1y
 YsmEGPVfq17PfF9frK/iV6OZg39lMdNbhaBIlvnnA2em7hfaCG2Fb66TrfKjA9jG
 divkrRcpyQnQgGmamBkCpPgJzJJ4SvQRODE0IMYrL7MSSPc7USwlgDkrEhsVSWsX
 csJTuA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte038j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 21:06:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c20762d21so2564861cf.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783631159; x=1784235959; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NT9wSTQqiCx6Py9n0wbJL4qoTasrN/ID+pg47vv78nQ=;
 b=RdqFrg95i2tGuXpSwFXxpdw7jqjH+aIcfjCvFdEQ5iiLr8dB+piPdoGQXmvcGcYLpQ
 WcXFJoxRGfyqI9ijZxNiHeM/7Sd1mLC+FKNip63OwkrULDnY/eW8ngGm829EyAtKdgEh
 6TgNnqEXESfEq7y9t10Sg8MeQKRl+CzRN/5yqyF7FeUhxFqDj1KPYN7uuKe8IC3914IX
 Lfd0f630dgf0NPCTknevtwVHQAN8xT+d0MlP9wyzmji4MX9xVN+lU1WA5Ymc7BHfvzzp
 PWxkmqMGuXeax715IpBBk2L9WQUblI4VYZMv/HZOGHwuiVzB45hrqpntrgn0qsG2gF3k
 ChQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783631159; x=1784235959;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NT9wSTQqiCx6Py9n0wbJL4qoTasrN/ID+pg47vv78nQ=;
 b=rp7iG5kEpvSboA9F55EQmJHAYvIhQn+R6SFSFZMs22FKb/iJ0Uum6B+YamkQ4SeDjv
 QnFWQIQ8THcXRLUhEEyXnlhmPX6vr3jbAVj/BH4yeb1pTuhKDlpeB3VDoYAW6nSCFue9
 1MxfL5pwujODlCwnCZC8vwoZf43DBru14v9LvD7dogHTiVsMCRt0XZQusuddF/TUdfJT
 wPmmv0t6vfJNxODGPnBQaAzWZbeIWcBlh2TgAHGI+VMY1WfhFerepvHh6GzBneZ9suFr
 5EVLUPg+4XoIosxbn1WflwEmVSGn7oK/Lj8TTPf97Fnuny4tOacWzTxcK/M16N8I/O7r
 8vyw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeF/Q7DWasj3WlVSVNt5HYbtqObfVqJF990NYkPdgwPyEbs0ZyDXbfoFx0hKv6IfQxwS+6lZAhK56u@nongnu.org
X-Gm-Message-State: AOJu0YyMRBovrSF4f7K5SGoZRdiR6fQuyo/v2dG/ywtrOsq3DZRt1/Ok
 aDg5ga/g3zIj3yg3DW8X/58ZnRkuwog29Iw7I+Y5N86fXTIx5laq7WaUajNlpDUuGLvYST/x1ZO
 /OgpOgRWmfL/2szk9jo3iwAcSioT/Ka783p3n1nUTbVcg99cNTpfwoEA62g==
X-Gm-Gg: AfdE7ckFYWwL4xkN6oRbmL9JB+DtsAAQQ41R4NAcmmSxLmu+sOIzjqjQJB+pxu7I9HA
 37aTu3fCv0Yr9gbhifsr260PgWWs7g03O6h95FqXPWkXYV0scVQFXcdzw9oyWcJ+MEiU3b8Kmda
 hAz7nxtgqT71W302qJccPSv97+63rjqHzg9bmLSt+4lkY0jwL4XUo4n6VgMS+s/Ab0ZdeB9vAQN
 ytQKIA119Te/+tyzxN8NmzLRPltmZ6gnMvxVtXfKGFxmktgIokywdrh1J2Q+C8tMh+oTqZlaCtp
 yHEBF0BdqTLMz9YHr5wF5bP88KVtyifodTrat1De91oRTqJWdSyd++TjKBQ35ciy9jnpMhbyzwi
 NcaL5ccOSG1hUw4WMUMKlZbSFM4ahTLR4YX0w5rgFKMm8NulPrAtXkYsf55IcQg==
X-Received: by 2002:a05:622a:4d86:b0:51c:21cd:e2d8 with SMTP id
 d75a77b69052e-51c8b3033b8mr118175631cf.34.1783631159390; 
 Thu, 09 Jul 2026 14:05:59 -0700 (PDT)
X-Received: by 2002:a05:622a:4d86:b0:51c:21cd:e2d8 with SMTP id
 d75a77b69052e-51c8b3033b8mr118175321cf.34.1783631158934; 
 Thu, 09 Jul 2026 14:05:58 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb705e22sm67948485e9.6.2026.07.09.14.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 14:05:58 -0700 (PDT)
Message-ID: <e958f4ef-7850-4128-afc6-16657cd8dd1b@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 23:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Limit USB 1.0 (UHCI/OCHI) and 2.0 (EHCI) to non-virt use cases
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, devel@lists.libvirt.org
References: <agRC56rkfb4z6zSO@redhat.com>
 <CAFEAcA9_Xmy8FukkMDGVzU8LvE9giSp9zgrpiGvbxn=wNjJp-g@mail.gmail.com>
 <agrtSFk-XGA-EcQd@sirius.home.kraxel.org>
 <CAFEAcA9b2oeZaZtGkn5YPMKOXWDdZQEvdoBj5mGVh51aKi-BYw@mail.gmail.com>
 <agrz1zBDwGc9Bvlo@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <agrz1zBDwGc9Bvlo@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QojIF9mzM-ME3uiTX7iCKfzZAo-E3n2m
X-Proofpoint-ORIG-GUID: QojIF9mzM-ME3uiTX7iCKfzZAo-E3n2m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIxMCBTYWx0ZWRfX/rU538TwdsEU
 GxtzfuqKglsf98ktDFE6EzgAmjL5WagCYqrLS4hxdOaKXaO1+qaed7x2Ic7W8cycSQPsoHxf3D7
 5eiQz89FUId5dzvYrkG4eFjD2BulJSbODDB0iF7+xOaqIlcw4ISi/1/F8GBA8Pew8Fbfi7vNkK6
 8dbltLHkAdfWP6aaDMiQDd+uEABu4jLBuHUpdXgII3ryv3ezBjUkNOnckLJ60YiqvdH7gj7q+y6
 oFgEqMY3v8+WMIQRzJNPKFwkLvCQ6QrqZ8Xvy7zcpRjXB+pI5ZQIgG8+wHAJ7DD8Cu+5axh6Ams
 ZNOqYcZShCqpICDA1JMhr9KQybtLxfHHclCm3DrSYohc6Fz06j2AYfjmTgUNpfZtosKa+K/2ESS
 sQW5CcNk3bxAH/TQv1quXCOw4qSmR94MXAFVylF+gUjZKaYn4T4VBLac8QIALotfsKOj/8F/VoP
 4LRoYOSbLLSnAPz+v6Q==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a500d38 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=RYJPnzK0AAAA:8 a=20KFwNOVAAAA:8 a=3SmhVnXueZ8B8bg9T-IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=dawVfQjAaf238kedN5IG:22
 a=71IlbOU7e524H-Equz-4:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIxMCBTYWx0ZWRfX7sARQMTPIgsc
 vjRrSGltWrNT9MhSV6aJgA2GeHiftxkD+lwQY8DxUL0ZstwQ5UAPUmrFd0HNcNkMmOMhVZ92Lrm
 qt4mmKbPjj33p1o+Nh8sYrinzOvzdVc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090210
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

Cédric FYI.

On 18/5/26 13:18, Gerd Hoffmann wrote:
> On Mon, May 18, 2026 at 12:00:02PM +0100, Peter Maydell wrote:
>> On Mon, 18 May 2026 at 11:53, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>> I fully support that too, recommending xhci since 2018 ;)
>>>
>>> https://www.kraxel.org/blog/2018/08/qemu-usb-tips/
>>>
>>> Except for the claim that windows 7 is in widespread use this
>>> still applies today.
>>
>> Is it still the case that the "-usb" QEMU option gives you the
>> old OHCI/UHCI controller? (My quick look at the source code suggests
>> it is.) If so, that's an unfortunate default, since it makes it very
>> easy to pick the non-security-supported bad config by accident.
> 
> It was still the case when I stopped maintaining usb and it is unlikely
> it has changed since.
> 
>> Could we make "-usb" give the PC machines an XHCI controller for new
>> machine version types ?
> 
> Sounds reasonable to me.  libvirt has changed defaults years ago.
> 
> take care,
>    Gerd
> 
> 


