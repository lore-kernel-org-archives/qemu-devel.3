Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34656C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrFP-0007ty-Rt; Thu, 09 Jul 2026 12:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whrFK-0007oH-4R
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:05:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whrFH-00056t-6w
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:05:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669DwC8V1833851
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 16:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JHXFVAeUHgMdM8F+HXfip36M2o7abxgX+HnVsOXHoi8=; b=C+7x++Z8gH7dZNrZ
 IY9bmG8DHxUqbKYT0shFj5K9/Wk5acWjF7uZxPnN1n1Xo6b7YEwEAbOwQm0P31qj
 LTD2ba+4x5UVnPGnd0qwQsOIrQLvLW9ItX20OyJxkbGmhJ4NzBpsCOC4u+45LXeF
 VbYjRBnvkevholpMoq6krOPXliqbXKlwYbdNwDDUDvs6D5LOzNq1uDnmv/DstCmF
 8EJSC3WvyNH0rgpEBEnVbEYB9o+VhZo3bSC/jrgjMA19Tqrluh9vnOVnTMrxEc2n
 poyk3ZK40RKiOCfupuTbUrym4bJ9MRfzmjWdmCm5IxNlNZyJeXpo00w4IK/TmalZ
 MgqC9w==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwfv63w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:04:54 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5bf8728fdd9so15827e0c.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783613094; x=1784217894; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JHXFVAeUHgMdM8F+HXfip36M2o7abxgX+HnVsOXHoi8=;
 b=b3UjUqN4/1pCaFa38Q3eaPjNRyczYpVj85SZMqkZ6O2DE9JzpmkM1vrHLANHf9AVIJ
 3PKZWzPiuzU5ZmGvcgHV23Rx7X0Mc2lMoHoGOMrlidttC76QYjnqEhBPJjDFSjVIsnux
 jPHBTwv2ekKHEz829Vb0ycIuBSrNWQ6+bF7NbFgRvm5tpcJs9FJjy5nkGgbrVNR7M8VV
 dwhMPYXKiHi9YP4c0EYRCHyd1HUzqpqTsCuH1yJB/6QiOJaB01Kjr2UUZnoxZW+/BFkh
 ebimbuNvjHknlmwFcS1soIi5/Tll5NFt8srQvMppSBOkmVPy7k56aexSlkginHLtu1l8
 fMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783613094; x=1784217894;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JHXFVAeUHgMdM8F+HXfip36M2o7abxgX+HnVsOXHoi8=;
 b=GtER8MOB5qvFQS+OP5fYBKaYbrufuctV3McXXqhR8FhtFUOQwMmmkjMSAIePsYGXqs
 0xk9/7CfoEXiQZdrpIUR1re2AegRw7BE4jOECrPMxRgjrGtK5L1zqpY0kzBR7nARR4bx
 CZzofmRuKlYmT7wNpOuVqiTwRPY1+deCXe4Iln6RUEjnN9l2d0g/ZiJTEV7vxAuDME08
 eHeK3Q2rorfsLDgjlOuMddwblu02+CpDk/k6NP4fE/Ct8XeXZqS+V+w0gDOIsa9uHPtH
 Vo3ndYh2oancfTu6Vy6LH2Ehr9sbknN0WfHeTrWlUBstAkMJaSFzR+c0wlZEowTDQSvk
 Gvhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpN+TYD2f7lWM5R2GVxIJxBTpSweH5AXVU75qwvZte2+SCj+C8k8P1FE5XObMxeY96VuFnW8CL/dPZo@nongnu.org
X-Gm-Message-State: AOJu0YxyJPXdLUTDG6yMiVQMGDikz7puBAN/MQnu/wLZKDZb2WwjVwzr
 lGG6Q3r5nMu5aGjA4we1NDrOXWJS7PjDxdt8CetPe8JAkh7L9E74JwUkDuwKFu6xKWx51yVqSNM
 2OL+BwSPrvCTg2DWh9cYBOkVFAixa7XAUv7tcFfSE3lKUUiIfqZqKRRCkuA==
X-Gm-Gg: AfdE7ckjqIKpOzidKau5zBehvHUCQLSwRJNTAivhNbYx1EzB7DCsmZuvoIGBc7I7swR
 /GTwBkNMP19sA/X1Bhhpt6CZCrGoAneodn8yS4RxKLrccW0ilIUJsHu2IoIHFa/tbwIl0HHMkHi
 np4L50UtnVAMuLWABDB3SQUyumU3r+g4ZaR2hgPVrB2XWbF93kU4MQCGUPhgIlTjoK1ycWijgH5
 gDNZu+K61H2rbkoTipGMibSK4AsiIDu0dcmZiCwbCDNNb9LRWG7ImFCOjipx4CeOCtE9/aZywGs
 7/B92RUFLJEY7CeoAv1cSVoD9FPOvj2fBCZcmDMXdb4GixNkKIFjczJvJLO56zJetc8zty/cYhw
 WKGAZkAbrZ/FE4YHB6LRasLygVthjurzlbzE/1OXzCqBPjXgzkIDwyZhMVJZjKA==
X-Received: by 2002:a05:6122:a5d1:10b0:5bf:7f98:9657 with SMTP id
 71dfb90a1353d-5bf7f9897b2mr2061554e0c.6.1783613093595; 
 Thu, 09 Jul 2026 09:04:53 -0700 (PDT)
X-Received: by 2002:a05:6122:a5d1:10b0:5bf:7f98:9657 with SMTP id
 71dfb90a1353d-5bf7f9897b2mr2061495e0c.6.1783613092959; 
 Thu, 09 Jul 2026 09:04:52 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960b06sm51610764f8f.28.2026.07.09.09.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 09:04:52 -0700 (PDT)
Message-ID: <2f68ea60-e48d-48a0-8f89-1e2ef2d582bf@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 18:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pvscsi: translate data endianness
Content-Language: en-US
To: Miao Wang <shankerwangmiao@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-s390x@nongnu.org
References: <20260605-pvscsi-endianness-v1-1-b0bf472b0f59@gmail.com>
 <273f53b8-9edc-4c0b-a793-d0667548553a@tls.msk.ru>
 <89089d8f-101c-4520-8031-e9522e2cbb1f@oss.qualcomm.com>
 <ACA8103D-AF3D-464A-900C-5448E29571DD@gmail.com>
 <CAFEAcA8Rx2MHUDXKAyr-4B_L7DxGEpOHtB=tfauTvfoqhkkPnQ@mail.gmail.com>
 <F04E93A5-9C6C-42AA-9097-838EF31C847D@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <F04E93A5-9C6C-42AA-9097-838EF31C847D@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE1NyBTYWx0ZWRfX+kUAKYz+L+Db
 0QHfM23gsUdtzH3zzqH91iJ/AvV3EdQJEV1xMxmZWlDOeWN4FhCufkp0/nMAFFZtMBhH5vzyZJj
 vlw77b3uXDvjFUC7xJbP9H1rjDQ2wfxp/rRbct28UI1q5uGDoGe9TeO8KLUGT7KnTHB9TiwhLsQ
 lE7CDFV3cxVrNCYgg6hrttuRZeSL9EUt+f2ba5DIbQdhXpe1x7RoDKqZbG6tsdxWPkpqWt22j+F
 n+cgxqHj6Bi8j0WnFo1cqEykZ2b+sH1cyzme2HfnIPpE6PPQA+q2xU+UV0O6YrZkBVy4IuU+jmN
 wjMEQuw3vxZYr8hhOt7Mv+uuZsVApVA4ZqBstNiliLWX2HKbn5W3ebhwExxHcmylXIuarF1WzD9
 FD93PLuZ1FuZ0gG5hI1J+TdeIdlGG3yIjEV9ljTbwpLPOZJZTLlIYh8uBQXhXphk2h+6KsVoX7j
 dkvYKOEBKtq7VZf7Pgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE1NyBTYWx0ZWRfXwof2zwiy43nt
 4zy7tHTwkhfMkaCad/gInZJctuO3lw71KLcxU/jj9oY5CblN1Qq7n5qyTXONyYbU4r1SRludOT9
 p1+pqPw1tNa12W34sa5cxLFhVU/F+Yo=
X-Proofpoint-ORIG-GUID: WmFvjcSRtKkrloJhSK93bL16-riQRc7w
X-Proofpoint-GUID: WmFvjcSRtKkrloJhSK93bL16-riQRc7w
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4fc6a6 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mGDK7GyyVGTauHR5JW8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090157
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/7/26 17:41, Miao Wang wrote:
> 
> 
>> 2026年7月9日 23:06，Peter Maydell <peter.maydell@linaro.org> 写道：
>>
>> On Thu, 9 Jul 2026 at 15:54, Miao Wang <shankerwangmiao@gmail.com> wrote:
>>>
>>> Hi,
>>>
>>>> 2026年7月9日 22:41，Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> 写道：
>>>>
>>>> On 9/7/26 08:39, Michael Tokarev wrote:
>>>>> On 05.06.2026 16:27, Miao Wang via B4 Relay wrote:
>>>>>> From: Miao Wang <shankerwangmiao@gmail.com>
>>>>>>
>>>>>> This patch improves the implementation of the pvscsi device by
>>>>>> translating the endianness of the data sent or received from the guest.
>>>>>> This ensures pvscsi can work on big-endian hosts with little-endian
>>>>>> guests.
>>>>> Hi!
>>>>> Can we pick this one up for 11.1 please?
>>>>> I know right to nothing about s390x internals so can't really review
>>>>> the change.  But the fix seems to work, and it should be picked up for
>>>>> the stable qemu series too, it loks like.
>>>>
>>>> I tagged this for review and forgot. Basically we shouldn't using
>>>> tswap*() anywhere in system emulation except semihosting. Here it
>>>> seems reasonable to use cpu_to_le*()/le*_to_cpu().
>>>
>>> I have no idea why tswap* should not be used. Here the problem in
>>> pvscsi is that the driver on the guest side is using the native
>>> endianness of the guest CPU while for handling the values on the
>>> host size, we need to convert it to host endianness. As a result,
>>> what should be done is to convert from the target endianness to
>>> the host endianness and vice versa, instead of converting from
>>> a specific endianness to to host endianness.
>>
>> Right, but what is the spec of the device supposed to be?
>> Generally speaking in real hardware devices don't have any
>> way of knowing the endianness of the CPU, they're specified
>> as "data is always little endian" or "data is always big endian".
>> Sometimes paravirtual devices end up with "assumes guest
>> endianness" baked into them, but this is usually a bad idea:
>> the legacy virtio does this, but we fixed this in 1.0 virtio,
>> which is always little endian.
>>
>> Do you have a pointer to the specification for this device?
>> There's no URL in the source files.
> 
> Sadly, I do not have such specification and I strongly suspect
> that neither does the designer of it, since it is designed to
> be used with x86. In the source code of its driver in Linux,
> it can be seen that the code is not endianness aware. However
> in the Kconfig, the driver is limited to be compiled on X86.
> As a result, there might be two possibilities:
> 
> - pvscsi is designed to use (guest) native endianness
> - pvscsi is designed to use little endianness and since the
>    linux driver limits itself to be used on X86, the author
>    chose not to bother to ensure the correctness of the
>    endianness

Likely the 2nd possibility ;) Also known as "implicit endianness".

