Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01006C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24RF-0003hO-6I; Thu, 03 Sep 2026 06:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24R9-0003fU-FF
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:12:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24R5-0000iY-Qz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:12:49 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68392DVp3612605
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dRaAc2JT9k+42jyPcPc39c8KcHx8FWTV7igPIOy3ST4=; b=lwzCgnm4GWT/4TpX
 tM/lCy8S4LnmPs9jsg1cswbijs2bXCWVafh56s0DD4L5LjwR4T+U3WyMLPlXiK8y
 tKwcDMpSh6ewW75wibcXFlj53pI2w9YUcDBcRLwi7OT410Sy+yWHwlUVo1TyBrAK
 cy0kxnTWJNxIdevRjCeKkvw0iyB/0Ry3r9v/l3Yvf2yIEO2xl8aI6lgs+ZiRQNIr
 VD+JiBapf1j6rH8GDs8eYO5JndEuY2A46lYewqsDt9vLGXKbliSwB4AQ+T1YrUPW
 aHiP6jlKLeuKC5cBgpZL75uGWJY/1IEkHTqvdxaIoPxzvJzj4jymqGqZeYXH06Er
 VNREqg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5pdrc32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:12:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939281526e1so117426085a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788430366; x=1789035166; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dRaAc2JT9k+42jyPcPc39c8KcHx8FWTV7igPIOy3ST4=;
 b=PqtiTluoFbMGOvHeKrhSiJe8IC2GkRQTZrvRQigteKtp7E6IBEEgvssuEOYkOjsgCz
 WEKsRlShvCSkI6VBnV/ARPaA/yLHndLtG0bwSOUTpPZS2aV03EMx/X/WasyVjfQ459wV
 b92s4Rpr0ibS3E3yZtNfDpQkQckQmBDJ/hsXL4KyEJ2UZRWAS1nCAwqpbuPOL2Fjp3E5
 URyIS483+51T0nOLVlUEMaJUgd7MMCCc9s4H5ZTMxk7NlzdTRTqNxIBXEynSoBpn3Ana
 ypYZsbFVLom3Z/uDkOgGkZMOZes7sOilkPQkJMf9kC3T0emSUUL4tiVhuetud9XZxMpV
 88TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788430366; x=1789035166;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dRaAc2JT9k+42jyPcPc39c8KcHx8FWTV7igPIOy3ST4=;
 b=ayc2McU2bK9fEck6s6AMENYeGkPYR+uG97z9Xww1zRE9aMuHtIiKMYksZmg/pZnFvV
 xWOEA7PjutuqO6VV4jYzLdyKlFhx8EUIS1dX74V04YlVx8V9Q2P9G3CPcy1KO6QXutcJ
 nOYX+a0UUVRoh2r5DDUQ7g126Dfa1sj9grwBDZZIONKWdZhT93IgU+RjF5heNRbJWe3f
 V9AX++C60SLwURM5v/PLRLQF3DjWrUuJu2xexGUQxNxvstH0YZE8A17rM1YEmqq++WN+
 wqL3VOnypcaw7FmvcpmAq0Q7E9eGvEkOgSD7LZM3QT7mkxOAKl++yGB/E2Dc6v46T67O
 WZ+Q==
X-Gm-Message-State: AFuF++kqjo7oEvGWdjR8mp00J+eouPAzW2ZvJSdRhHMNj/JKyw8DEoLQ
 NJNmLz6hhryX0M+VBqU1kl9jfajkjc7zU7O3IVARU6tz+dTt2i5NZLumbOHY2PGIx8quiy4+3g2
 plPqkqkTJlZMFTZZfMOc4Uh4KqaaaN8/hWqMH4QryO8E3Tc328ZYgz60LbQ==
X-Gm-Gg: AYBFou1OXcdjAQfqYN17D7i/W76to3fsyfm/YEIwuMcIHT3CqiaT9otqpJ5JyY+u5Nh
 4FtjFIwIztlKsDQpz2r2g6yfKXC6EyrntrS6FguuLm8vMivbIoMTJ2XS91WPqW4fpmZdqZaWjTd
 VXq2RdqpeEeKhcaB15gUzn7jLY3jQqRNUrTaeYRlLc9H/y45OKnwXVLe5ANMEV1+FxdEzwd1OA9
 HBaZr9g3NDtjnV7182AkvO26EUUNqKC7I2ld3yWn/TU6/elH84Ik2PVR/0i1SxlIZl6S3KnVZWq
 rI5a08+jX88QnFUDuKX2M/onn6bxMUy4Qs0eNRZEaKIVsnkcK1IKJRZJD/ZRJbcXyrFMSGYeCfy
 bVUMg6FPzVorun+Pm4NaelgRA4zQ6RfesAA==
X-Received: by 2002:a05:620a:8082:b0:939:6de9:208b with SMTP id
 af79cd13be357-9396de9319cmr672986885a.48.1788430365613; 
 Thu, 03 Sep 2026 03:12:45 -0700 (PDT)
X-Received: by 2002:a05:620a:8082:b0:939:6de9:208b with SMTP id
 af79cd13be357-9396de9319cmr672983685a.48.1788430365198; 
 Thu, 03 Sep 2026 03:12:45 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm116409425e9.1.2026.09.03.03.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 03:12:44 -0700 (PDT)
Message-ID: <8d8693bc-e542-40fa-8955-c3a1898d4b75@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:12:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] sdhci: fix SDMA boundary bug
Content-Language: en-US
To: Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Ding <dingtao0430@163.com>
References: <20260715160731.29969-1-dingtao0430@163.com>
 <CAEUhbmXiFwpKv9tpBMGeX6mWw2CBisibt5JkM4S-CAVf0dDqYA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAEUhbmXiFwpKv9tpBMGeX6mWw2CBisibt5JkM4S-CAVf0dDqYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4OCBTYWx0ZWRfX5KaMI0SzJLJN
 Lq/0M+aOzZXMzf7YRluRQLYt2E67eH0wYi+NewqM0GGCVv55ATnZppQwEUkag+zjTZpqyUXPRTb
 dYvaNbSCxmkH6vgdp8f3ARazY1LKDLQ=
X-Proofpoint-ORIG-GUID: ODILo7JMa11hrlBA92t11ckMBdSEnUQx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4OCBTYWx0ZWRfX3oaa5G0OEbAT
 mB4J0VvRi3+FtUtg07+oi7PodrQNX5FqAoaSPemfZ/nIT52Eq+WSiUDIY0wpvQuwL2wFyAw+HYF
 kG1v+IRAl3qadTRgyIFhIAD6rF/ZVrRY3QR8eZGg5q8X+EKxtpi5TB7vO2z2xVxP7ev2Zrmgaz0
 E8mXb9QE+nFbvnKnBZjvUmr1rpzoTA7Qwgn9vRQw7iAEEmif5pIjS+4x6l4ZvXFLvRtbcP8aJIz
 CeYvhLAkjZiG19PRmB2xICXUXA9MDfKpgb3TI9ZJ96qyyAXh8YV76k5FBrZKYOcQmTyim1+dCFY
 1IGYvvYvy9FSTTk8hv3570BwpzA8kEG0QzuTXrPz2Hk4YzyqG6wr5v9PaRt2vHuleVhwprzuww+
 r0Ax48aasstEC87KZ2UGRSztDVnDqY4SI/hf+U90TTHul6qqDquVHFfTxskbcNr7sjd7S4tYQoh
 k0i1kDtNLhlL+oli5Pg==
X-Authority-Analysis: v=2.4 cv=RsL16imK c=1 sm=1 tr=0 ts=6a99481e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=AecHSXSJ-p450t0UaTYA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: ODILo7JMa11hrlBA92t11ckMBdSEnUQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030088
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

On 22/8/26 06:34, Bin Meng wrote:
> Hi Philippe,


>> Tao Ding (2):
>>    hw/sd: sdhci: Fix SDMA boundary bug
>>    qtest: add xilinx-zynq SDHCI sdma test
>>
>>   hw/sd/sdhci.c                        |  54 +++++++-
>>   include/hw/sd/sdhci.h                |   2 +
>>   tests/qtest/meson.build              |   1 +
>>   tests/qtest/xilinx-zynq-sdhci-test.c | 178 +++++++++++++++++++++++++++
>>   4 files changed, 234 insertions(+), 1 deletion(-)
>>   create mode 100644 tests/qtest/xilinx-zynq-sdhci-test.c
>>
>>
>> base-commit: 608ad9307d5b4797d2254ee3a4bad2bc8c8bcbae
>> --
> 
> To make things easier, would you apply this series to your local tree?
> Some patches in the ML are depending on this series.

Trying to catch up, I apologize :/ Now queued!


