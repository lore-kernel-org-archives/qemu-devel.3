Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06158C55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqWwl-0007dG-El; Sun, 02 Aug 2026 10:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqWwi-0007cs-1P
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:13:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqWwf-0005j0-7v
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:13:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B7NHY937346
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gDaUgtQ3R/b5gkaaxRCkm7HDF/S3U8VGnrJIIF6/pNc=; b=e6QUCkmlE1q+XxEN
 2h0gDWAawp5t6KMxeANpoUsVNAqYrg+Yu9ySw9p7U72CyKB/8rDt82fzkXwRQQmg
 ZrGa63NTX6Hte+M8xK7FsmvaUz7MdbxaJGYvYJoUjIrIMQMXnkk85zvINMuh+iAc
 ceo2T8u24ooPjKHPyI6ehksExHhU5HvD8WGjHg7S8f0bwJGCtNlheU+1gvhAiwJU
 wlMD7SmreKO1ayeV7XHPJd06TeLU6dZ2iEYxVrxRU/OO2BGCSoQ/tj4ZdEzlSYQP
 FNkP0300iiFj9cVrW4b/m2UNjbfPQO+19l2KXR3oqyEosWmcpHtx5AimWWkXKGAc
 7fDvhA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs9ygjs14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:13:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso50439781cf.1
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680017; x=1786284817; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gDaUgtQ3R/b5gkaaxRCkm7HDF/S3U8VGnrJIIF6/pNc=;
 b=TqhhtNqScfMWd2c2P/BICoeE4gcRTZD0vHeEKUwjbdcIoJvcNHEtC7tDw4gKIXBJyY
 DHI7yBLJ4fGqcTsGv8Kl8V3m4/waVvA6ntavmzi2D8Fg14pB+VpXp/X1ZE/1WeIyEebm
 4A3IUfydvvnb5wTk1pFBScsPd+6XxmC27iAPNyYixzFM2zEuE+9eGZB37oZNu4rIUZ2N
 Z/T9slB1SRQHq+YBS7qTr4eS0JI3QQENbsikAVqhaiTJWdbeOZFhcw6250fflGARbsyT
 eat+QiE7a1G3fYnHgy66f4eDRVKvo13Hb5cTSHuz7df3wwnOzdOXw0nx89VB0yQ21NoT
 3A1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680017; x=1786284817;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gDaUgtQ3R/b5gkaaxRCkm7HDF/S3U8VGnrJIIF6/pNc=;
 b=YYRmEJ86JFnYH55SJqUQznkd3UBQQSrOevJhcHT4e2RzKuSGF0+yuv08ugdLoucXdd
 tBbIyv2qS/jSTyqyu9WFIOGw+EEZDkMj24IKZqBAkDAoWrJ+vyt4NshFfxyK3UPtapKe
 0cYvrX4RstBuuJFsLjP8GN9lEHlmeFrzfdNoWhaCD5a6/RsZl0kKzQJ9MGpHcXFXR+55
 Zh+iEg21jius2ZCpGU/Ym678ObszzjtTKmNqeWUNF7YjVj4HrJ6diS06zcD20rTZtI7w
 OvD78ys+kEXh5qD6yu94hwO6WiQhSUTRkLpg8N5v7krKBlHAudvYbTlYYD1xHjCVrnjs
 j2yg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5yLvhBNLMHobzMQ3ZkyUjNysySNaXaRfG5H25I5Y5Sn2pqjVCywYApMUmloAW6pG3gdFNB+2kcVX3@nongnu.org
X-Gm-Message-State: AOJu0YzoKy6Zte7Je44MrpqtfX73LKnqqlcjM5RI170aQV2dUgIEDccs
 3IrHJD4NCOIzfI56pm6dfrJjWBnvkz+G20jEqj/hpT1WAt4kbP7RlJF2mr80siYaqqAzuoeuBv8
 0xl9Uiq9iYXf8KnxxwCvrvoZetjylAcPxU5nh7QoM5g/+tuA2n+wonBPTCA==
X-Gm-Gg: AR+sD10av4r7ahwJ+itNKcUg5dWxqujjPTXJ8o5B1u+l4bKf9aDCvaEck/1e0S8CiaQ
 K2fxrv8rJvCpRzEuZVCmEwJilvsikr64GTwcUIajR1UTWz4ow3tjQrtzl7x144XX+w8bNuzz/Wy
 7z9twlBSyU4ZbWDBsBg6kRvCcBEAHyySQ9VporU33N6yHe+uexVCsisr2tomMg68u4j/DquRrgm
 WmqyCEzfYlgKNR+YKJnz6pQGDtAIAYlq4o59fXCn7aeIgclgCO5C3ck4Py6CXoomidSqD/0phw6
 /SIXxvGo9SE0uxI4lxIVYBxPZqjGdUphrWW3kRdY+msmMWQ2j2z/cpSKyIP5h0lXYLo6dPcN0Bx
 2n2RTmCFF+YSLls9UplXg6XLc+j5SyqXvM06jFhFDI+3jMrb0kLU=
X-Received: by 2002:a05:622a:4d98:b0:51c:19af:6330 with SMTP id
 d75a77b69052e-52b567cdeeemr142064151cf.36.1785680017632; 
 Sun, 02 Aug 2026 07:13:37 -0700 (PDT)
X-Received: by 2002:a05:622a:4d98:b0:51c:19af:6330 with SMTP id
 d75a77b69052e-52b567cdeeemr142063561cf.36.1785680017270; 
 Sun, 02 Aug 2026 07:13:37 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458ea4asm23924657f8f.31.2026.08.02.07.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:13:36 -0700 (PDT)
Message-ID: <7239bc2e-b180-42ab-ae56-454557cb3194@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:13:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/8] MAINTAINERS: add myself to IDE maintainers
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>
References: <20260730081325.1816193-1-den@openvz.org>
 <20260730081325.1816193-2-den@openvz.org>
 <CAJSP0QUnp4=pPYQvGvTEoBCndvJb0o=Z0RzehP30KKK_svyXCA@mail.gmail.com>
 <f271fcff-4428-421b-b2b7-472cd8bf3cba@virtuozzo.com>
 <CAJSP0QX8JnTSWHQeQrH5dKHeC4oA9CMTzHAZNhzt_8gKorJ9Gw@mail.gmail.com>
 <3f84a950-d079-4e05-a3c5-daf81672b3e4@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <3f84a950-d079-4e05-a3c5-daf81672b3e4@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX6Tsm1ebJ7SLs
 QiYe5UGiB76r26IU1BFsOH876MIQjQzUK/pyvUH7zuLw8fMlQ16pRz+sSJjkNEvUGLggJ1z3rlw
 G49LJCGgtP9RA+QyyFYHna+UOppVGqo=
X-Proofpoint-GUID: seV-7INigv_qpkcX-vknCqQWV27UQ2bi
X-Authority-Analysis: v=2.4 cv=Gu5yPE1C c=1 sm=1 tr=0 ts=6a6f5092 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=TYBLyS7eAAAA:8 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=8exCi9owuq3J_P70mcwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=zvYvwCWiE4KgVXXeO06c:22 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-ORIG-GUID: seV-7INigv_qpkcX-vknCqQWV27UQ2bi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX/boLgEBootUb
 ruIcohGmQf9ffqKkANKncO5vrOjPDE5EFwAcqDqjyaeUPdjko57RhDD81jXWGDGbIlAYtgHz6SO
 haEMH7Ehq/MmTc17uDC5cf3uiuyN6NfCnyMChL0PaNEsab5ctEEXRU2z7V9PesldjmEMCjnDJkv
 NcL0w7YU+57NNxIRHSe0mCm+HkXetfx+PrRjejFBLjI1vB7yaGqzlDqUkNvc+LuCjq5amzuKYcT
 k7mYfdgoNNe8uI2reTTrcFtcV0ZeWAlNJ7F1ju/wDrW/6onTspKUR5qrXsfOFI5Hh6YXUNpyO0n
 5eDVMTTrssxa4k7S3x60JXGO9ZWv2qBQKgcXQojXs1wIaspfa7h5HchFVNsfKU1y/9zOmV7bKnE
 vOhR62Wvm/QIQ4u38fERLuc2uo1NWKZjvEF5wB5Ya8HgztROii4/FryrbME6iPvqHvi0edIb8fA
 rMwrVXjZFRJJmdEetjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020126
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

On 31/7/26 23:17, Denis V. Lunev wrote:
> On 7/31/26 22:18, Stefan Hajnoczi wrote:
>> On Fri, Jul 31, 2026 at 9:45 AM Denis V. Lunev <den@virtuozzo.com> wrote:
>>> On 7/30/26 16:55, Stefan Hajnoczi wrote:
>>>> On Thu, Jul 30, 2026 at 4:14 AM Denis V. Lunev <den@openvz.org> wrote:
>>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>>>> CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>>> ---
>>>>>   MAINTAINERS | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 902db77218..4628793dde 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -2160,6 +2160,7 @@ F: docs/specs/edu.rst
>>>>>
>>>>>   IDE
>>>>>   M: John Snow <jsnow@redhat.com>
>>>>> +M: Denis V. Lunev <den@openvz.org>
>>>> Waiting for acknowledgement from John.

Note, Denis is not removing / replacing John, but simply
stepping up to co-maintain an area unattented since quite
some time. I doubt John will oppose to that precious and
scarce help.

>>>>
>>>> Stefan
>>> The situation is not changed in general from yesterday.
>>>
>>> I can drop this patch from the submission, that is not
>>> a problem. The problem is that IDE changes are not
>>> moving, f.e. there is another stuck item for
>>>
>>> https://gitlab.com/qemu-project/qemu/-/work_items/2399
>>>
>>> floating in the list for month.
>> It would be great to have you as an active IDE maintainer, Denis. I
>> would like to see John Snow acknowledge the MAINTAINERS change on
>> qemu-devel before we merge it.
>>
>> Please resend the pull request without the MAINTAINERS change for the
>> time being. Feel free to include Peter Maydell's divide-by-zero fix
>> too if you are happy with it. I'll merge the v2 pull request for
>> v11.1.0-rc3 and we can independently allow John time officially
>> confirm that MAINTAINERS change.
>>
>> Thanks,
>> Stefan
> Amazing plan.
> 
> Thanks,
>      Den
> 


