Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CBCC4453A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmTke-0003Fb-Ca; Wed, 22 Jul 2026 06:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmTkc-0003Dh-H5
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 06:00:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmTka-0002fO-PJ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 06:00:30 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8xd17123862
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 10:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 afupgWY5toyNdT7+u/gwIbyLQLKDKwstHdaq2kL2imc=; b=fwi9D6yWinK2X3zc
 kEAjfUoXUHIti57v5ENpgBoF8sgpsZuWrx2uH0FrxzHsLpz3ubq5Ex7v82aSCSBN
 oMqf1Twi4oSqY/q3o1Z/AXg0UdC2VzDjGC5YfwyHRJyvJ66lTorhK2MVhJInXYls
 YZ8gLfPKnJnUaq+2zec0LUnIgKpxEOBQuQ0w/mZ+iwsA8D5N07K93u0Qo+lY+DvH
 2Ix0kqD0SD8mnx7t8etyK8r89tFu1xRWDiZH1PLNEzKMeezcKLIrpNs41uQY8yAj
 5ARSed3EyKhjkNVekJqFwIHlDBwFF+BKwkujlOTLhF5eXg+iauClXSTq6ROuzVCV
 IUbrDA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4sh92-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 10:00:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52827090cc5so7443391cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 03:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784714425; x=1785319225; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=afupgWY5toyNdT7+u/gwIbyLQLKDKwstHdaq2kL2imc=;
 b=S9VzH050d+kp+nmQjL+DRSTt/r2905qIMbwo0KhQAHmxN3xLa9zaP+pQp5xwLFFz48
 LrQly/uSlrJgEOyONpHppIzW8/+yU9tqSIX5U78d2r7VIkr5jI6R94QOe3ugS5bAgqu2
 SePK3Ma5067Y+V8++DUjaRwJYTBRr26OrtL4vH0V81SdSek+0W0z7RlWz0D9SbFpXiIz
 f0l9uYlbdMKzhO6Tm9qx9EHvooIut2irWBg9hQbXikcQqLazUWjx7jF/V9RoJyIvPcGU
 USAA6kh3s04YCXaT+nVb4lskhGFREFilykdVUc3j3gQC2M/6KaGEXSyKZugg6idzn/Tm
 gS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784714425; x=1785319225;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=afupgWY5toyNdT7+u/gwIbyLQLKDKwstHdaq2kL2imc=;
 b=p/AXrgzDkosrRb0axwf8kfuN8jlGuWNAvRi9HbbnYVuIWII9cWqKbVY4+SWbwigypv
 nato4RBEmgaz10BG9kCa6hqMlDtr+COpIQpASQtX+H8/aT+gdnfAohUzyk+DnCv5IWXr
 6KkxZmkdAZuWJMQgSFGIukvzGpSQ0Bj1XYcpM+4KaKrHopCYTJ8FdGKj1XywcjyqYip3
 t2uvA3O4LHVV9r9i/aClH5fp2l5x+wHTHSOQhZMcFbb6S+YbMsIhGz5x6a5eReeQFohZ
 JXZpTwR0gdv8vUKRja2eH9IhXdjL/V861x9fvhsyp49aKGSwLrMAiD5BZg+EVQkS3P88
 shkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrA50Atw+SWplPSS+kZLkqgTEXzoYr2FH7uzTFBQ5JGgcIwY9QDeI1l12T/kpPmo/s8BvR1lghkCNg1@nongnu.org
X-Gm-Message-State: AOJu0Yw7/LwvKpsXr/EOZHFEhLfm88+qngE8TnjDnna9jiF6rLGEBkJE
 LvTNVFSzXs88eZKBn/SU63xHoaq1MMd0bndcOmiEx4Pwqr1kb9qjhZBB1cFVl//zSCklfawgYqR
 xxJVA21RKydonFoCCTpd/WdWAwnvmllFb3fxlRxWiyd4Fx9uDXrKR0HNUMQ==
X-Gm-Gg: AR+sD11cxNdzq/crLWsALaYIGGx1uwjEAOhoIrXnGqhDv3uHOJCug+ICsoFNp+xjC6I
 7YqaglJumlag+L+cAH4ekyTbN1zhSuCEwaXdldZVAxy+x3EMrBRtS3UbyuG6HgdUWuht+MwmG/b
 Sc50IxpISIQG5KQ2U2R+oH3J+0RhDbFrWNZRjO1q2hzdhpaedQuEjHh6VXlip9Xw5JgzlZMsfgB
 HKgnKVyUn+vBMZwWQYytxx3/lnuK3Tf9tYVUMbxR6I4qhbBBioTCiUIAFkJXaJsBhtNMXNWESQf
 L9tETWaq8Y3rD/e3bxQIvDbb+bFsFSvtQ6UsTSCnkdCzR6iTlDjJG76fRlkwI7z1fu6d0rLLzIh
 kiFkfwjX6awec1aiedZZH8DgX35RCwjXhSJ9dNmrUn7DrKj1WRJM=
X-Received: by 2002:a05:622a:653:b0:51e:aa39:4fc0 with SMTP id
 d75a77b69052e-527a9cfdd3emr33422341cf.42.1784714425393; 
 Wed, 22 Jul 2026 03:00:25 -0700 (PDT)
X-Received: by 2002:a05:622a:653:b0:51e:aa39:4fc0 with SMTP id
 d75a77b69052e-527a9cfdd3emr33421441cf.42.1784714424683; 
 Wed, 22 Jul 2026 03:00:24 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b5c2108sm75593635e9.2.2026.07.22.03.00.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 03:00:23 -0700 (PDT)
Message-ID: <29875880-d0f8-4bb9-9688-c1d0368cc4d9@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 12:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/qxl: validate monitors_config heads[] in
 phys2virt
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org
Cc: QEMU Stable <qemu-stable@nongnu.org>
References: <20260715072722.1643289-1-marcandre.lureau@redhat.com>
 <05b2e507-0c87-4f9c-9a1a-846a44bd396a@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <05b2e507-0c87-4f9c-9a1a-846a44bd396a@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kUZ5n9APzjxCQEWG8Zs_nTDgDd32pZNy
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a6094ba cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=C2LyrcqBaCNN6wcuwNwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA5NSBTYWx0ZWRfX08UeJ4HLS2cC
 V95qcEv6k/C8Khpq6LHOwP9hwi3y3nNEYm6YbmX0IE953zub3OWyUXwahoA+U0fkANerfKPE7ad
 cUQsi54v1lHEIRNPN+y4frRdzvp2MfGGfk+0QknUwgvENZ/5hdGFMZQUWrzE0v/YpXBHBwWMeO7
 KH3zNYCL5mkZeaSWIUJj9j4rKsArtI8J3N9cr7+6jnZBLNpkG+aJUFNmttxNGS6tDVCPkmeWdgq
 R4WtXkEpYO72AX5VCb7BZtROAQX4jqGGRnorhWrRJAe46plYC+6aChOa4A/LxAoFE383CHu6FZ9
 0R3d5YrziYq4k0499Qy+rekXmPNnNXP0cPgmw76dPhDtkUpxrx5+uxFbP/FTyVhn2ntLriJI3bb
 BAuF7n+N7u8KxomEsvakbIGnXIBnuQQqDRT+rQIwiq0b6AwxPA/WOZFg+F84xAEyiCbttkeB0XT
 RapACHG7DM2KN95qspg==
X-Proofpoint-ORIG-GUID: kUZ5n9APzjxCQEWG8Zs_nTDgDd32pZNy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA5NSBTYWx0ZWRfX33ocwqMwIoe8
 A6Hrid/Y8ZGsHKKmXmibk6DZwsxWwooBNv2sYIds1suwDO8HFtcb/slzZjJWzB7HbMsOGdOp/b8
 3WHeuyelSZHwjnCZ9qt/7tCx193vzXM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220095
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 22/7/26 11:38, Michael Tokarev wrote:
> On 7/15/26 10:27, marcandre.lureau@redhat.com wrote:
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> The qxl_phys2virt() call for guest_monitors_config only validates
>> sizeof(QXLMonitorsConfig), which covers the fixed header (count and
>> max_allowed) since commit 8efec0ef8bbc ("hw/display/qxl: Pass requested
>> buffer size to qxl_phys2virt()"), but not the flexible array member
>> heads[]. When count == 1, heads[0] is accessed without its memory being
>> validated, allowing a guest to cause an out-of-bounds read.
>>
>> Include sizeof(QXLHead) in the size passed to qxl_phys2virt() so that
>> the first head entry is validated within the guest memory slot, 
>> preventing
>> guest-visible memory reading.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4027
>> Reported-by: Tristan @TristanInSec
>> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> 
> I'm picking this one up for the stable qemu series.
> Please let me know if I shouldn't.
> 
> It would be nice if changes which should be picked up,
> had Cc: qemu-stable@ in the first place, to avoid this
> extra round-trip.  I'm trying to keep it as simple as
> possible, only asking to reply if I should not pick it
> up, but it is more work for everyone still.

Indeed this patch should had a 'Cc: qemu-stable@' tag.

