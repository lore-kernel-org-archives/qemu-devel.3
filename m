Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD47C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weDPw-0005MP-Im; Mon, 29 Jun 2026 10:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weDPu-0005GY-57
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:56:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weDPr-0007zZ-HO
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:56:57 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATEPU2579076
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 14:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CiH2B0nlKPSBnM3F1KubX/khe5K9fUlYQTsI9uqO43I=; b=DOEUce4a0uwyi10K
 1rX6DsIw9w2wr4MTOtiAkwQ28F0FL/2Bax3a66k5eSd4G+2F/xeqpOJb/dNP8QKf
 bfjhsTK5i5z5yBxsLAm3VtvV+8PDH3gMuvLu1He9Wa+0TJnH8iKe4cL8xWyuRTqS
 pZm8w9VD8fZH70C8Qv0bld0VB3ERaMfLJRHTylLyX64Cf/LZk0ibWf4401MdsFdm
 Y5ukF7fKQwT31qPiEskd38zeYGIJOYfIh2ncQReuB7U6DHwtfYfE4oiZ9faEM2aB
 YKrycEDeLzAVvibc2H4wtO7+Ivi6pE/d3yVStuCRVf9DTulvBI1Y5Se0jggzE52u
 TgmIAg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hxw6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 14:56:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92b4b575561so648272785a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782745013; x=1783349813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CiH2B0nlKPSBnM3F1KubX/khe5K9fUlYQTsI9uqO43I=;
 b=jx1pyIjF4P94In4ws2+tMMACJCEUTL7EpU9/PdAjup/swY5gGpxkhmPYwZIIC3KoZE
 t087Q6zoCSdGyvDy+/PI0jEROWA9tLFlzUhPrREbnPTErnHJ7m/k1xaEknhNmJh1B9cw
 EEYOrhcQiL1TN1nwOmjagcBeQmpOZ0fDEkyjcbxWI96yi1ZcUdEmYTptgxE4Cf0tOYBu
 t00QpogmfUwu6wdp5t/6xeI6WSva6KhsDAsrH/AbQ0RG+e2uzTqPtr0CLGRs27Cew1cB
 znBOA22DpFxC7L494Np4SaUvWTuQItgtV/s85lj62Yx75qO0bd2WS+sbjUYOTCa33tBa
 TlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782745013; x=1783349813;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CiH2B0nlKPSBnM3F1KubX/khe5K9fUlYQTsI9uqO43I=;
 b=J2QoZWW7A0vRMF6ga70rWqmrqLq08b8Xx2zE00G8gwZoaI3nLEpYFB3m+8Qxxc2luQ
 eleaxayKCt7LXpYOB69RFuygvMKmCP29ZwIb7T/YYxeTg1d+A0nHXmvwqmbsQLDwM4tf
 6Z1OCzo1jlprLQL5UygV5+ckSo0299xDXf1K6/vP1cMRl4SyFVN6Trr3WHxzrUUsnhYw
 F9ekEZNtREPxOy3AXRDZRA4T2oMN5S5wCDk+ZkN6BXAtzU8RBai3AHBX9mtbp4oEiMAz
 Foor25WJVUny+v3jFtndXwcRjgWuZfFew7M76SHAMaKs7IfU0SLi2JWm8H/5p6uyME7n
 p79Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9phmfx4HxRoM0BC8SCLzwQZft3DqOgsBJ239agM0KvchXL4qbqjBj9nDu+xnd/8+eDh8/BAGvCQv9B@nongnu.org
X-Gm-Message-State: AOJu0YySc29fHI7tqVe/WhIua8O3/hEvtlL2TBVx3jY3Xn4NstUKjSXM
 wjl3EEAbC2KLXkB8Fns17S3vsAkgKCv4K5x4/+tY5zCAMVwwaDPqQBlYiUv9ApYbZoHhG2bjTWd
 /C85L8ePOr2JXWonXMni0P6xhUWdDqvun8pPfrwarN+XL0KxF3w06SiVPgw==
X-Gm-Gg: AfdE7clQc3OiAT4Kuf47IlEw6DvgMsyNNPPex/PyiRyAT4YBnCgsDMGSw5s3yQnpfuy
 cZXN6hVONKsRbM9Jd7EKAc2Iy+0QMyMglNv7v2rc1i7qBF6Y7blQGhaVVf1x/86ZlTdWBnimTSn
 SJxKZ9s1kN6c7IInJmXLGrzhZf1EbVpNbpffQ3n6q0FjT6g01/4QhgrGqUZaJqwCu2fE9CVfZm7
 /u9Zg7sQbCOKCQ42rmk/NehM/CxpYXnlznvMkm3kHqxYXx1QHtSicw0kzW4x5U1/O/x6nRlPUDL
 zKWjWfyXl2YUs05qk5HY7wGOASYCv2ityEfXDq0jDn/VFhUNztKt6Z0akpB4kS0GIu3P7hGUIp6
 IlszcUlJKXHRYyKGWVKyYDsnQL6+GRtwkh7w4XrlfaJZ6A433H5O46cmM4mvB5A==
X-Received: by 2002:a05:620a:29ca:b0:92e:5b63:224d with SMTP id
 af79cd13be357-92e5b6324fbmr248743485a.26.1782745012628; 
 Mon, 29 Jun 2026 07:56:52 -0700 (PDT)
X-Received: by 2002:a05:620a:29ca:b0:92e:5b63:224d with SMTP id
 af79cd13be357-92e5b6324fbmr248738485a.26.1782745012119; 
 Mon, 29 Jun 2026 07:56:52 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4730937e18dsm15028101f8f.21.2026.06.29.07.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 07:56:51 -0700 (PDT)
Message-ID: <b2eb84d7-b74c-4edf-a4af-df92b4ea2032@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 16:56:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/gpio/pca9552: fix off-by-one in QOM led index
 validation
Content-Language: en-US
To: yujun <yujun@kylinos.cn>, Glenn Miles <milesg@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260629074133.187549-1-yujun@kylinos.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629074133.187549-1-yujun@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyNCBTYWx0ZWRfXyJ1QRqIsLOb6
 Nb90uIp0czxnrjizQy7LjPaDXLncDM2zjg9sK1aynnd1N160YDPEiUOtZ70chpc170NXUgR4Z47
 h8ICkoAlhzAJDYY5Xd4UUbqAasxwvtY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyNCBTYWx0ZWRfX2rwIZTq6NX2F
 aXRCkAYh2nY7EyZX+52yppBjo+erFKDRKevlXAy6hcFQ1h/KxbvlE55rk4qIPdBETKyiQyTohH7
 lAfg9DqZa9EapN/rUAb+FRGq2MQr0NEFSBY+anQTtngFcb7rMtdcQP7dJtGsSslJDZifa+Nfgxm
 GMzEeA14Y+3w2wQ8V8Nr0j100Lyrf9ktgSRw68wkkt6Z1a0g8gW7XQdnDLMaATrCmYJ6sbci+hi
 QsUnjqX2lR1PdrO+RnnaLvVzI/HlDd+NRgfWb87NsMhr+ydmFeGaO6m6MMXjFtyPLGidMro66zZ
 tCsZqAcWmUBrh5fuclwuJ+2uWjsZvMsVE/PAIZNEPuHrxj9gTPgIqo8dTc4bnCHblz/m1A2awoo
 Xj7c+v51HpWM30JRbuI0Fxz/D1h6zrd7pdee76c6taUUFFs2FRPXva+7GkD/9TZtnJQko5PhDyv
 ea3FNQYuW51oDdHyQIA==
X-Proofpoint-ORIG-GUID: POLnNjqvN_cc7gB4hXohJYInBk9D9r3v
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a4287b5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=6CSop681rr5zcgR6WfsA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: POLnNjqvN_cc7gB4hXohJYInBk9D9r3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290124
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

On 29/6/26 09:41, yujun wrote:
> pca955x_get_led() and pca955x_set_led() accept led indices equal to
> pin_count, but valid indices are 0..pin_count-1.  For a 16-pin device,
> led16 passes the current check and then accesses an LS register past
> max_reg.
> 
> Use the same >= pin_count bounds check as pca9554_set_pin() and the
> gpio input handler assert in this file.
> 
> Fixes: a90d8f84674 ("misc/pca9552: Add qom set and get")
> Signed-off-by: yujun <yujun@kylinos.cn>
> ---
>   hw/gpio/pca9552.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)


Queued via hw-misc, thanks!

Phil.

