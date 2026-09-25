Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96D4C98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA9Ky-0006qR-9B; Fri, 25 Sep 2026 13:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xA9Kt-0006pO-Tq
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:03:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xA9Kr-0004MT-B3
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:03:47 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG0lHv2124496
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /1ew5LIpDxFFYDr+L6Ig1w3hOQQj7WBMx2GgwWiazJM=; b=jShXIPZx7C/A0cIt
 5GTPMsBRZH++COu3GyI1abPvh//6Y4akQEYi3H9DAtlkgX1/FUX3SdeC7OIPqzM8
 BiaUEFwbrj5T2OieyPVX1QOiF9ORAAgwTFw4CuV8o9c1SGBmtbKtnE8SOokIA7AJ
 75Zl2VfkgRJwrPBk9bPYVcqcnb7bQ8z7iPcBg7tttPfaBMbN0EmYAQuZQ+yE9eo5
 QX0W55+OKElZfQj68xr+fZsjmix4oUkkT5gWxxwfUn0+w4g/Oml24cXjqIxvh5+O
 Wv2SSyq+gKLPp8KgMuk2H997L7k4Fx8VvKBGBvnSYGIJFnzMNGg4ZFxtau6BthzA
 wJqOxA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq0abte-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:03:42 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9857717bd19so119147241.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790355822; x=1790960622; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/1ew5LIpDxFFYDr+L6Ig1w3hOQQj7WBMx2GgwWiazJM=;
 b=GpEKCNkYPtRfSzPuk46dvkNVTaONzIIeldOhXfTQXgeUVcmbApaH2Hcoj6a93OAJPa
 ++V3hj2wBItCKxD/PJcjuiX4/yL5b3zvfq0XsOJyO3nh0z0rVKYwop55AYgyMVax/sZf
 y6pOFVinOJMryYyLWZ32fI0i4DGC2dHWvPq3Nv3UZErS62s/u55DZA5bhjDqmz/rlUyQ
 W6tLXLQo734snuJQpZEh4mxc+UkpgpIpSXixarY666SjcPHpw/wNP5hiUBmjLX0o1WYX
 Kwmfsxy2NI+o5CNSr5poBH8mIaTBqBDnwIsD487ws/c9LoUtaePJ//vi7qqtLQoD0T/P
 SIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790355822; x=1790960622;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/1ew5LIpDxFFYDr+L6Ig1w3hOQQj7WBMx2GgwWiazJM=;
 b=e2bR+dGsSGsvqoTuwaoIWREN1JUpgOb7XDiMv/i5BppvNisvqk55qILXReadtotkd4
 BHGzPL/fvdL7yjwFu3eVrWK/i7gLxIF5dwEG0ImCYNyYWRNltL2tNOhTi4QkHU9mRurA
 4RwpNpaRB+gxp6dJQaKH6FV98pizUU3SZFN1shq/CAlK7YtbPFLeXgJcwEAi8/27vsRE
 fzFqQ7hXDpYpsgqB1SCJ9Fkyzx3IKVN4pS41S/rc3QdNp3TjD5dJ3+tbgrqLH1JUtO29
 EQEy86dMbhPornSank3r0qYqSaUBpTfYGixYoFGojpbF0u1s4KCrTpHGlwCDNyP9tsTo
 bUjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8mwT9ezV681Y6NEMHfwsXs36VKuADfFuX+K3z8FyjzxotpB83niyMogyKbZVKAaeedMuPemUhAk2h@nongnu.org
X-Gm-Message-State: AFuF++kHyxs3ziJQQUiPIzfcFWTYvxQko6ENmngryZcxZ0WrjddBXv9g
 lguUQgO7tItUv/R3rA1jMZCJSU4tOgGfZqkxjpnDOgbZUwsj/qgLYInBY51dfNYDnOdw8odoGo9
 xzCADg8aCwE8V/9eu+57PiCbqdgL4/u9KheZbKMFJWT4bdXlrjf+v34FvYw==
X-Gm-Gg: AYBFou1fgcT3AIiP8RyA44EyxAOEFW4BkspTO6rsmnOfV/krem2zoF0kL2Ov2xPdwFG
 NbByT79XNpxpMqYMNLW50J65et6d4LJSFZg11At6FEEnJyzyqCbgzKj08heXRMvyMZIm03S/2Kt
 ziNCvpheuSkF0W+WoPWpCcrNrL8YehLhvAOAaVI0XHjhBiCj7gzPYvEEFhtEeYa+XnB68Yrts8g
 ohL/cFaP0PeY9TUit61ciVcOv89p33G2BDIg+OqfNxy8uGT3AstRBapsbT686aKT7gZlUh+kpGp
 BbygsG2NIJ0kuNp5jO574kwUjT3EGWzYuZA76PtZBenbBMcQlLWXOssNkaLVcQj9Uv7ykGNQTqZ
 vl4OHDPrAfjR2sIVKrpc=
X-Received: by 2002:a05:6102:6446:b0:7b3:721b:4604 with SMTP id
 ada2fe7eead31-7b3721b4cd8mr64600137.27.1790355822008; 
 Fri, 25 Sep 2026 10:03:42 -0700 (PDT)
X-Received: by 2002:a05:6102:6446:b0:7b3:721b:4604 with SMTP id
 ada2fe7eead31-7b3721b4cd8mr64584137.27.1790355821388; 
 Fri, 25 Sep 2026 10:03:41 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.52])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a84205esm8295381f8f.37.2026.09.25.10.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 10:03:40 -0700 (PDT)
Message-ID: <01052528-0034-4263-a12d-4cb040ee1a3c@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 19:03:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Extend comment about PV cpu load state
To: Eric Farman <farman@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, cohuck@redhat.com,
 david@kernel.org, iii@linux.ibm.com, richard.henderson@linaro.org
References: <20260923082146.62803-1-frankja@linux.ibm.com>
 <e331d4bb-12be-4c1b-8d7a-9e246a77c283@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <e331d4bb-12be-4c1b-8d7a-9e246a77c283@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2NyBTYWx0ZWRfX2VUeL+wIbDo4
 asDKJKBHwdPauNwNP7AA7TNLHJDCdEMm5Gl61XLcl6am71B4bYGvywmmnYUaGPznuczwHZooW5o
 F0iVe7jcH5XNccrkhC7Nc8m0Kg7Mkv8=
X-Proofpoint-GUID: PgyNo5ke23YnLzLh0uDAOXgx3ntTSEyO
X-Proofpoint-ORIG-GUID: PgyNo5ke23YnLzLh0uDAOXgx3ntTSEyO
X-Authority-Analysis: v=2.4 cv=LNPz05W9 c=1 sm=1 tr=0 ts=6ab6a96e cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=QTt6BuOzr45adi7bDCnRgQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=WQIY_eRHi8kJPnR0mAEA:9
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2NyBTYWx0ZWRfXy4HREdedKeoW
 esn9yi8HbcLKKurfkM722yGjIV23pZWIXe+tTzGSor/P2c0qmCooJ7RrhMXKBgqCZMuh48Dlx5K
 BA5Jd3V4oxEbXiGMobyjI5b5/dhrOIGwg5WVWZstEUgxppq8XUeX/r5BN3XZXL/VQ+LxBXuY535
 oLui+W1/WMeYljJ4uWXyXs5mvO1CdxpTczsbj6L+PWuNXqtvgbcTNFp+oVU/albvqeQZY2ztNfZ
 ONlnzlUCbOqcfCyLWhXT1ese40Jva0Qu60u6YWsqXKQhjeP6sRwUoRttZk2TTcV5/afJloEbh9O
 nV4C+K3RMgtBqnItFgZ6zotK68kRl5bZDUO6eG3HqJipb0A+bgfjb3BZs5t63aijJh/Y1lTmDFF
 P6Z6QA6B3H79wAdWcLci0+zTRshyia+ba7G/3E0hoa8lUccfJabQrPfygVID2U/qF5IPJYk5+95
 UhlGy5Cr3O5BfvT52nQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250067
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

On 2026-09-25 14:47, Eric Farman wrote:
> 
> 
> On 9/23/26 4:20 AM, Janosch Frank wrote:
>> When implementing PV in KVM we chose to add the cpu load state to the
>> mp state solely to have a way to keep the UV happy. The UV requires us
>> to set that state before running the boot cpu since entering that
>> state sets the initial PSW.
>>
>> Since entering that state in KVM only sets off the UV call which
>> causes the initial PSW load and does not set the KVM tracking to
>> operating, we need a second set mp state to reach operating state.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> 
> I was puzzled that this was applying as an empty commit. Philippe 
> already picked this up [*], committed as 
> bb495851c6744ede99b457d50255964a61249221 yesterday
> 
> [*] https://lore.kernel.org/qemu-devel/20260924152353.36209-11- 
> philmd@oss.qualcomm.com/

Yep sorry I forgot to mentioned I queued this patch because it
was logically making sense in with the rest of the patches being
merged. Otherwise I rather the s390x patches go via your tree ;)

Regards,

Phil.

