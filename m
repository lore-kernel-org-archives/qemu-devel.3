Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D397DC79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 19:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x41Cb-00055x-Se; Tue, 08 Sep 2026 15:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x41Ca-00055N-AA
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:09:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x41CY-0007fc-Jl
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:09:52 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688HLqsL2967568
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 19:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UhrVi7qD6QPyGcmvbMObVCu4drSqR818MPGmC4u4yxY=; b=LG3s0xrKDRE8RSSQ
 eOixE5p2BLq6U6flq6kiirwdGt+fTWNmQvJvZ8OrdpwJPh5kXQzlIYI9shWdPKw3
 6EtU/NxIAWCloIv6J7NsNgHQDHtO5OEhx29RTsYoc3PTkCu1qATqr/WPznPFE1Fo
 qUCFpnFJ1NK/iMqpnrSISx9mSN0lMAs8Dd+IF3PCoBgFlHYiYOLD4myBbZebovvY
 PaoXFdUI0FaD36VqjljwlfELpYSGWJ+oTIZXz5D7VWhddRPr26sDOX8c3VuMzfU2
 1WIqijEz0+s6ooGnOkkl362AwPNGb7fHRQdz1OM/QaBXnOL0vzYmg4QrIA8sw8g3
 gLf9YA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjppp0fg0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 19:09:48 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90c8da50f8dso58657176d6.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788894588; x=1789499388; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UhrVi7qD6QPyGcmvbMObVCu4drSqR818MPGmC4u4yxY=;
 b=R5DMgDA0shJqesH8CfaZRuyFrdNBc7d6N7NKofpnJjHtEvgtzXkHPCMb2ZaYGtQMg7
 YI0xGxKu9c1v1EF7judic9pdqe9k3kXEp4DL2oOYyLEe0Ltdds55qdlR0MZJqac9Sx9/
 3fGz9m1Iq7yaBsIiZLPD5noeInCWkYKRtOUa2/BmDvJ31/qtqt5xO3Zo6qokEeFB6UOX
 o0g0BX7WRCZIoX84HFYLQMPyvRt+h3nlYhuYWZWO1ar6YFSeJdTxJfBzhc5Kcg0wmna9
 kv4jEtpC4vQ0OKNu2M3+ubSFzTe6GUeAsEkaZ/y7eRBxDqKIAxF7UcWpift+DsS4IGiL
 xTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788894588; x=1789499388;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UhrVi7qD6QPyGcmvbMObVCu4drSqR818MPGmC4u4yxY=;
 b=G7cI0UjnKv554b51sgYus9yBjSjL5P1F2ZaCdRpfs0cTuro2w1okqeQVAzo0UPmd0x
 DWTEKXrQQid5ekvJAlI14mF7rLVs3B2qbQy4rNQkxVocq96KSwxdgAWl6O6pB4P5UGuf
 Xivpr19kf382JtDAd+y5Ur86pxiZxk7SkcCw2o6qUgxMV30/8t5wOE21MxbrO6GHOaX7
 E5Fnv4P9NuFNjoENkKRdTh5BfVzzj+a7yY9FiQyNmp04UyTcT+yp5pI+nDg3IeINJyag
 BdiIe8/TniFFYEmh1cvlb2uBA/ZSyd0C1JNH+iGSb2ViZGtk6p7+AUsBg/+yMj6mtiMG
 vGow==
X-Gm-Message-State: AFuF++kApxGgyCu2E6NI1qlesoIGx7hskX+DWF1+95yX/9y/dXw5oY+0
 EoxRaeJzUwVuVGIyUwJLd1+6nHgnHnM7ustMgM1JpqzPWkzcZMwXvsMeKCpPPxZ5d8Z6Klfa16h
 G09pcJ9yC9SyScRd9M0CXR5STJ4IcF+KnxHZAV0Q2K+8Qnla4peP1rWmLQQ==
X-Gm-Gg: AYBFou2GOgeJRo57d1EBl9SIYDJ93/0DselENicAT2JH1ock7ew0YgOYmyt3DizhaEp
 z8clJMx39C5ZKmCUzyr0qaPRhlXLnHC7LzDbigw6lDaZuX+nkgllrm4MbEwUDJs2iGsvslJo5+F
 d9d9Wcr9YqzqD0V0C8RTMhKKWoB+/ojOOTx/fTfzkKNsFU04li2drOb0n+VyxrXm+I+203vQi7d
 RpWEFimjJs52pNpdpelvHHm4KLqXNgDdJvxpJHOjH3BPd7TDPqE/WL0pV7wtao26NaTlnAEO+1m
 8W2uoa1BKcVT3icOV/yiwkH3SPEi5nICKKjITRfnrEvYWdWX5aV2FqkGlNQip9SNS05N50dieOf
 tLWmc5DW9zQwy6IQ91m2zDEWEu3nvS86Z4z648+5GfanPV0gOgNhw6xbKvT4hpRP3
X-Received: by 2002:ad4:5fcb:0:b0:907:bfc0:781e with SMTP id
 6a1803df08f44-9103f01a9c3mr374870696d6.30.1788894587693; 
 Tue, 08 Sep 2026 12:09:47 -0700 (PDT)
X-Received: by 2002:ad4:5fcb:0:b0:907:bfc0:781e with SMTP id
 6a1803df08f44-9103f01a9c3mr374870176d6.30.1788894587283; 
 Tue, 08 Sep 2026 12:09:47 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91058416847sm57248886d6.4.2026.09.08.12.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 12:09:46 -0700 (PDT)
Message-ID: <e1825e93-6dd9-4c0b-83c5-e87059f49297@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 14:09:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/hexagon: Fix semihosting OPEN filename handling
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260906222551.3712954-1-brian.cain@oss.qualcomm.com>
 <20260906222551.3712954-2-brian.cain@oss.qualcomm.com>
 <CAFEAcA92z5Hqn=Rb8dH+e8-G_WUSnhruYooq_fDzEC_VYiithA@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAFEAcA92z5Hqn=Rb8dH+e8-G_WUSnhruYooq_fDzEC_VYiithA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -CHIFtzilHhSD3RcDfKC0I74MBTH-U63
X-Proofpoint-ORIG-GUID: -CHIFtzilHhSD3RcDfKC0I74MBTH-U63
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIwOCBTYWx0ZWRfX9Sj+SIaEbn2P
 KyUkLE40QgSd/IgBh+PV5257zpnwEzfwWBdhgWyCQK5NA4stiwkvVtkDUswYc+xb+GYomQdUduS
 5Fy/8hrV6ypScttxNS3Q0lFeC92xEhcYZ8qKet2an9/b3XIpYQN6hJ8l/3KHAgoYlOfHjoV3+UQ
 QJX4GZlJ87pgDwXP7rkQ+z9XXoSKyOlsDCEc5RunpFBm12JN0VkzgQPR8Kluy71cJ9Wt7lwRIsS
 WHJxR2lDE/AtR7AgC5iW27MvcUJEacDuu9E9ju5HLfdQun2Rev8KbUSxvwDXilSLTzD6TNI0p2g
 ZGrR8OguoMa2ggQgSQcqbLtnm0iGjl9i0dnVNkGphgwmffRaHwPdUM5otyjngs3fm/cJylgVUtJ
 wzkPk6MNmY7Lb3X2X8Y3plkdEZvs/xmEPlMxs3hlxKR8tOSQStTO5TG+zjm5/AnUJunfh2biVmx
 uLo4gekhgzoeXxAYrkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIwOCBTYWx0ZWRfX0w6laxhO3SGH
 QCoHcKGiiiCkAM+xa0nW1B5zDSEbzhOBzhhVYuctiThGuWRuDZLwECxf/qDrXVpJYYKU2JUEkRg
 unG4AcOdWdrmJY7OJ4Lppx3MOcwPlbA=
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=6aa05d7c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=iMmJIdcIs4qV6acU3OsA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080208
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 9/8/2026 12:40 PM, Peter Maydell wrote:
> On Sun, 6 Sept 2026 at 23:25, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> HEX_SYS_OPEN copied guest bytes into a fixed-size buffer until it found a NUL.
>> A missing terminator could overrun that buffer, so use lock_user_string() instead.
> Do you have a link to the specification for these hexagon semihosting
> calls? Looking at this patch I'm wondering if maybe I steered you
> a bit wrong with suggesting lock_user_string():


Here's the link - 
https://docs.qualcomm.com/doc/80-N2040-101/topic/semihosting-specification.html 



>> @@ -461,31 +462,14 @@ static void sim_handle_trap0(CPUHexagonState *env)
>>
>>       case HEX_SYS_OPEN:
>>       {
>> -        char filename[BUFSIZ];
>> +        char *filename;
>>           target_ulong physical_filename_addr;
>>           unsigned int filemode;
>> -        int length;
>>           int real_openmode;
>>           int ret, err = 0;
>> -        int i = 0;
>>
>>           hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
>>           hexagon_read_memory(env, swi_info + 4, 4, &filemode, retaddr);
>> -        hexagon_read_memory(env, swi_info + 8, 4, &length, retaddr);
> We no longer do anything with the length argument, which seems
> like it might not be right.
>
> If we know the (max) length of the string, then perhaps
> lock_user() (which takes a length argument) would fit better.

Ok, I'll re-evaluate it with lock_user().


> thanks
> -- PMM

