Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE128C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwwNd-00041J-1F; Thu, 20 Aug 2026 02:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwwNZ-0003vB-0G
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:35:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwwNX-00067l-FG
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:35:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K6KrHr2492110
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 06:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KLKQpZLWUccNiFupHHrIY3YrHfuFZRZ48snOXjmLVmw=; b=psPfq8bNpDAdGfZl
 CzCxbVhJtHzoIvkpUp1frSZwk/lUbXUrd/WEUM2e1JKLHa4YIHJjSVYdR2MT1vHC
 ei2uuESG9jN0V+Z58yEORVwepS4IFQydobJRGSKoEljP9f0MkxcQzWYeZKpZcJal
 92C3ABsroKvxZ3jQH8msIsxX2eMQ/itdQlihp7Qwr1IyXpWjAsqxp9FJZnjzn9d+
 n5KfyGvm9Mi2sUXDFUi3gHT5oxdevVLSkKm6XZTOt0MGPx+TM/Aliv2mOAClYjuY
 dqSAUXGAtJRRwJN5XSg80MuJHYmuQP49aU4nZBeEYM9vt2SLrQUZSbrd/+nnlJfO
 MJ54cQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5e83uq1j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 06:35:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso25646721cf.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 23:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787207753; x=1787812553; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KLKQpZLWUccNiFupHHrIY3YrHfuFZRZ48snOXjmLVmw=;
 b=D8CSkbMDt6UH26YQ8p0wVqBLIHFkKl3PxIh+PurSW5h8O0gTtVUcKJZr194jCFC9xa
 ut3JdMkepkiGHQX9VY8o5MngDZp7cx30anDVTrvsk3fJ91Ar2S0XNLmBv+0vRaXLmacs
 +0+btlxUn7CCRrJYSgPPMki6dk6QxAr6FUenuhDwhXM1AKvgAHhqYjFdIJqMEoSbqEFi
 XUD3m0HY64o5TVbfBurbEb6EnZewyNbOHImFwdEkxqz02AzPRygiiHEpfICQ/NNdYPL1
 szfu8kl6i7vFl0Qw6bFKAD5AsSRCPI0T9Z0fV52+Aw05g8hkUqhO+QDmi7J9Nfq8dXhY
 /ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787207753; x=1787812553;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KLKQpZLWUccNiFupHHrIY3YrHfuFZRZ48snOXjmLVmw=;
 b=DBvU2lXLmF0OuE9fIQGIG15yZ18080QK5MynYRHiMesqYQW/6kqmhMH9bQcyqfQwgf
 6k7UwbT6j5Qkfdy0Jgk8seYvGjGB3i9NGIoOTnsOXu5f+2nkJhvkaZB67szdPzU67lF4
 NQNnBk+tHDrxOmm/MGVus+K3f8LQJ6hfzKZYCJ+lq+/oCPuRnvhIzz+ke1NiEmOkTjaj
 ETuqKWUGEt2M0AOIFj66mS96eqc1Q8mLmeJgbNqb5H7ONoQIjYdH0jM9LpKj4nrOH0GZ
 hp/p2nSfb4YdYy01Di3H5CLadCwsRTSTkcBCNZ97zYKOTwarffyZySt3cgBhFHiG11Bi
 FgNw==
X-Gm-Message-State: AOJu0YzmiQMQQjJLYFiTEpMhUxy6XX8eS7+HL+lFckGXECHhwoHeAOPC
 /Kzjhuod4jW0nsp8AaWLU395QJ2ULC02+6ssZv5Q5AlA1Ma9gqjLHiNt3M9fZP9xuxb6HKlIZFi
 cP0Aa4Odv1OiV34Y9l7I69ojhxwO2plDX29429uFC665wyih307PBkniWoA==
X-Gm-Gg: AR+sD10EfhiMfaoHI9CVGalaURXFXE56mTnXK/sazaMaE7vKlPa33hfv3wbww10CJkD
 uVXgAgXHK+y+0Ed7WIrAGD/+YtURxXSYlIfJc1tvLJvVdFpFJOIxzvjNIQntNTtkDX7chwEgd1S
 1MU/l8uVKXwUt/V/adNIlXgrp4osDClzm16iRSXU+sNIBCLWqQzRYf0vnJ0H6LjxdRZRfUhEqg5
 qY//2xBLt62jOUJJW++gNQFO7htJBcQFG4Dr8jZilLF/gum31PzPgKpQV+fsIVGp+Qu1N6Ys89I
 y9375ZW/MSYHr3030xpmRyyiPOyxeV5rOJgMaaw0u1yLzRGuBwlNWbw1B6zDyZepKpSU/5aGyk8
 yYRLSjH6V7qqrq0xsDPsVJCbKZ7J4WLN7Zd3jKL4V
X-Received: by 2002:ac8:6909:0:b0:52d:8256:ac33 with SMTP id
 d75a77b69052e-52dd5c8b620mr92197671cf.28.1787207752974; 
 Wed, 19 Aug 2026 23:35:52 -0700 (PDT)
X-Received: by 2002:ac8:6909:0:b0:52d:8256:ac33 with SMTP id
 d75a77b69052e-52dd5c8b620mr92197581cf.28.1787207752565; 
 Wed, 19 Aug 2026 23:35:52 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b80a5sm11150549f8f.24.2026.08.19.23.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 23:35:51 -0700 (PDT)
Message-ID: <867923c9-9a90-44f1-8a68-cc131a655259@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 08:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] s390x/css: Fix css stsch detection to go beyond 8192
 devices
Content-Language: en-US
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260814152226.1834819-1-borntraeger@de.ibm.com>
 <ce91e7b0-18b6-485e-9837-9561e7373a38@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <ce91e7b0-18b6-485e-9837-9561e7373a38@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA0NiBTYWx0ZWRfX9lDrzPkGcxq/
 Ml/Rd5Sbs8jhcfL9UHbgxdA5zImjB9WD3b0dZMXcWVY8BSt3K5CjNubgXSeJrwI8RTbOmIwFtrJ
 0K/Fa5023sMn4j3GIa3hHXs+R7Gzung=
X-Proofpoint-GUID: bHzllJEjcE2NJMz_potqGWmgpaFGJfFj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA0NiBTYWx0ZWRfX/YcJG/MTyl3A
 NiFQEu8Nb9EDLzlRcszgZFDuWc1kjnTlXg/OCXzFCKafvxVn6JkqnaMp+fsUnWsZfdsa3ZnKoPN
 jVMGNTCVRaFHHcbb9pNmTnnU1e+mpLCO3XmhJC714U/D8h0Fe1dqbU+8g9JSeVIP8eSSrq023Wt
 sNUtyd4MlKNj69q22oGybawaFLu5BSIOetvj7yFwbNSfnWYoyO7noIWDDol5PzUCweqmStAfPjN
 a5QIEkAOeWMZ/UDt59gU9HQsDITQIW7i24rXfvtoZRpn+KvqlwTovsUWjk+bvpKK9Z8cJisTHSz
 2uDpfFMYiQJL20UrjcUr06lTynjv3vAAg7sNd75vPwGhzTy359OouDZcc88L19KGjno4gmxnXC0
 BeKvvGFFEIARiKprsKvdBvRiU4CsKjpD3VFEySTZeLuP7PqBi/5es82eXpyyBFdZn6Y7DrQdgHm
 i5unG/LF8jo7n8C646g==
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a86a049 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=I4fAOWAGuqHK7M9Z-jsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: bHzllJEjcE2NJMz_potqGWmgpaFGJfFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200046
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

On 19/8/26 12:56, Eric Farman wrote:
> 
> 
> On 8/14/26 11:22 AM, Christian Borntraeger wrote:
>> From: Christian Borntraeger <borntraeger@linux.ibm.com>
>>
>> find_last_bit expects a size in bits and not in words. the calculation
>> limits the number of guest devices to 8192.  This probably does not
>> matter in reality, its wrong anyway.
>>

Cc: qemu-stable@nongnu.org

>> Fixes: df1fe5bb49241 ("s390: Virtual channel subsystem support")
>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> ---
>>   hw/s390x/css.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Thanks! Applied for 11.2
> 


