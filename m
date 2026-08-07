Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B694C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsNkK-00065y-6J; Fri, 07 Aug 2026 12:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsNkI-00065l-J8
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 12:48:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsNkG-0004br-UP
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 12:48:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677GOAJk1190366
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 16:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FQ652snNF1qvX8dAz2fc/CTMK1dPsxh0OKclkmREy5Y=; b=OeWkKWIy1qefOpID
 qIdXCMWqHOOzSo8T04g/ts15F48JnUPZZLxOrAXH5Irm32n679PFQhi1lXnOmrDk
 wcOp8tsSo9fvo/vys+tTeu5Jbklmyp9xgz7s0GVIIdiKd6G39sbg3cnU6J6RY/YS
 RfLyQtcoW1y4dWzlop8xrYlC+kwfhK6m1BQ5Uc/Db/q0vOdYsEbt9A2ch2LqSwWg
 keFmVtW+/+BwBKFCFSKUZHY2t3jTp6mazpAeS7Sthb493ZkJiRqZIHebYw4paDcg
 WmbnUQQTv/7ag9xlpVtb++pzWjsfWSAPG8znOrvLm4aOi32DudsU/cmJ7JXfesj7
 Md0AYw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwcujhr27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 16:48:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91931144870so481874885a.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786121310; x=1786726110; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FQ652snNF1qvX8dAz2fc/CTMK1dPsxh0OKclkmREy5Y=;
 b=FO+rauVxr/gdkoEcIBJevd6uTUU3X3If6HDI654sBuADf0To4NoZfz9OOTgf34q1wE
 Ps4yxAWZPEMYTaeiOaHcSNct6OvGQynIcMxVS3fr5BJqkuwThuJxJlZRYATYvCNPMjoL
 R+nh7AXyrVogaNxZz6swOVyeCRyIy2QEbEJiSOssTiwVePxQdz0KMrC5FzrjXfsE5T5b
 hY1zH/wIgp2JzzZQD1mwyygK69dzjjcxx/3B8lE1waXdm7Mmfvqbb+UmCnFAtkUjyq+K
 pz+MnP1Rja4R1y/HK9XzljVNDdgCMMh73KynIIPP7JvAu6oDrXl/pTonLBOcY7r1d45Y
 mPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786121310; x=1786726110;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FQ652snNF1qvX8dAz2fc/CTMK1dPsxh0OKclkmREy5Y=;
 b=if+U4q/t2pCnBCc9PGLsQxj/Un+7oQ7mGI+dow2DjeChSk4DUa8KlY5Icb/VUjzQHp
 ry56q4ABS6vTu0LanPl6hjgR03TSwfRVrb8zeA19SPnVmP0/9dNmnfUogNBXB1M1hbTT
 wD6qixEwZZYJ9hKF9d5mFz50/Xn0qI/lNjwHbjAS9ttvB9Gz0QYCw8YfSPEz4eGrD9pe
 uogKr2coP3u5dnnYkUR3mmsrC6RjwRjjOhGHj2CMlRjKB7W/JDgxWL3NMurfTho+ef1t
 A5w3sXOExj7Nf4mDv80l2PmKXsZseV+uNmkm1bazuJCgzW4Qi7eIr1H3f1/HzwxdWfJj
 nYHA==
X-Gm-Message-State: AOJu0YyEiv/1azGgLsx+GZqpSyOBbcdMZ/3UWwmrJ4k6vDqlq058Ui94
 Ps383fFkWdR+rnYhEnT4k2gq+CB7+ra75xj34T0s4S8y2WaMb6iUmS2Bn1thRAjvq7X8xUvCBcA
 f8aXOLn6tChdS5EJsP4/oKJJ2GUe6cy+l87D7vrf3KtEpo92tuRsjMLQU65wufpDn2w==
X-Gm-Gg: AR+sD12t9DniTqr1mtXWtvp7RlioWhs0T8NZQMqgk0KMnHNORrRlzYPw/219Rd8evZq
 xMKQDEESUUqQOXPXCqwguW35TU16UxwCpdCEsvqnI0PfywS1uy+9GpRTsvzFM0FZzXcOz9dx1Tw
 iXF9cpAX9ZXL+0zGyYHm8sECepMPg+Yij+UpVoGFCE5lpyUKU1EKt0g0VBiWUZ0CQ7MOA4RPmH3
 5upZB4ybQ2tqOegW8nrvHiK2wD2HF7dp9Tl+OGzZg9qjDmy+wnPy/LrO0CzfdsHo5z0QwA6sW+8
 NrPDPUfmYJ4TwJ2nelv+qmqzF/p+Bh8jvfLDHouA2JIOEwJvr1TnrlksQ61623WvPU/2Mr8jt0y
 kcxFxHFujOxmAiDr6bj/yMj2ubLPlMBCs7oK3cvsu37Win+M8Sm1QCGH7TuBCHMFl
X-Received: by 2002:a05:6214:27cb:b0:8ee:efa3:4466 with SMTP id
 6a1803df08f44-908813b28f0mr279941166d6.28.1786121309875; 
 Fri, 07 Aug 2026 09:48:29 -0700 (PDT)
X-Received: by 2002:a05:6214:27cb:b0:8ee:efa3:4466 with SMTP id
 6a1803df08f44-908813b28f0mr279940466d6.28.1786121309400; 
 Fri, 07 Aug 2026 09:48:29 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a91b58d6sm12754186d6.13.2026.08.07.09.48.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 09:48:28 -0700 (PDT)
Message-ID: <193758ea-acc7-45e3-bda5-a40253bf12ca@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 11:48:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] host-utils: fix ssub32/64_saturate return type and
 clamp direction
To: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
References: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
 <20260806043223.3787083-2-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260806043223.3787083-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX7dXE5DdZLHcp
 DUkOezJ3vxUi+o5hh/V+GG0ksGU24TEjyZynGlZrng/+t0cgvJgZhIwzpxbTstdRMhE2QUalebN
 5oIrJoKNg875KCNr8kmhPuzc8vg2RIo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX0LVLHRTIsGCf
 kaAws8dWL85KQbMPsC/EVNmWwKvKY3C5N1/AnVgzNcdLYshmnkuSiLZDBY+VUAkog/DL8JaK8Fw
 mwvPm/UTTtYtPPhtr3qA9rWZRyuX1jpuPNgtXpcavgHQfOLcscEQuVzTxvXB+KFtvUp9SEjAKoe
 mjyNF6IaCWtmVy5XKHjFBhEIVZoU+uJ4qtEnAJGPbfLT35I2yxXg0k1mb4raXocYQezs5WYsPf4
 /Db9Ayg1aB9nlOfiBuxVlKuz6up9DQXc2PRgDur+ldLrUv6XsS5aBxBfqudrDYFKXjAkKEm1vI/
 KFyT0uT0HU7JPmduirnS+/zD98zsgj50zaGPBE0seplxOCJEN+MwwMIwirdTesARgG8gtDwOzTp
 T5ZMkn2zJBcZQ+4eY5v3H6ufJ1lcesOdoAZk5h/Je22hr3xBpyGfYJHGI2braBoDRNV7S81yt0G
 jY3EXi3/ptQIsJo49Ag==
X-Proofpoint-ORIG-GUID: YeFRq_5QxKXT45HKcsLjcSs8D_zDJCht
X-Proofpoint-GUID: YeFRq_5QxKXT45HKcsLjcSs8D_zDJCht
X-Authority-Analysis: v=2.4 cv=Wssb99fv c=1 sm=1 tr=0 ts=6a760c5e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=zSMaiZIlteQihR2KgU8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070131
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 8/5/2026 11:32 PM, Brian Cain wrote:
> ssub32_saturate() and ssub64_saturate() were declared to return bool
> instead of int32_t/int64_t, and clamped to the wrong bound on overflow.
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Cc: qemu-stable@nongnu.org
> Fixes: 16495533131 ("host-utils: Introduce signed saturation primitives")
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---

Michael,

     I think this patch is a good candidate fix for -stable.

-Brian


>   include/qemu/host-utils.h | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
> index 2e8da7fb3d0..1db9dbb138e 100644
> --- a/include/qemu/host-utils.h
> +++ b/include/qemu/host-utils.h
> @@ -607,10 +607,10 @@ static inline bool umul64_overflow(uint64_t x, uint64_t y, uint64_t *ret)
>   }
>   
>   /**
> - * sadd32_saturate - addition with saturation
> + * sadd32_saturate - 32-bit signed addition with saturation
>    * @x, @y: addends
>    *
> - * Computes @x + @y, and saturates rathern than truncating the result.
> + * Computes @x + @y, and saturates rather than truncating the result.
>    */
>   static inline int32_t sadd32_saturate(int32_t x, int32_t y)
>   {
> @@ -622,10 +622,10 @@ static inline int32_t sadd32_saturate(int32_t x, int32_t y)
>   }
>   
>   /**
> - * sadd64_saturate - addition with saturation
> + * sadd64_saturate - 64-bit signed addition with saturation
>    * @x, @y: addends
>    *
> - * Computes @x + @y, and saturates rathern than truncating the result.
> + * Computes @x + @y, and saturates rather than truncating the result.
>    */
>   static inline int64_t sadd64_saturate(int64_t x, int64_t y)
>   {
> @@ -637,31 +637,31 @@ static inline int64_t sadd64_saturate(int64_t x, int64_t y)
>   }
>   
>   /**
> - * ssub32_saturate - subtraction with saturation
> + * ssub32_saturate - 32-bit signed subtraction with saturation
>    * @x, @y: addends
>    *
> - * Computes @x + @y, and saturates rathern than truncating the result.
> + * Computes @x - @y, and saturates rather than truncating the result.
>    */
> -static inline bool ssub32_saturate(int32_t x, int32_t y)
> +static inline int32_t ssub32_saturate(int32_t x, int32_t y)
>   {
>       int32_t ret;
>       if (ssub32_overflow(x, y, &ret)) {
> -        ret = x < 0 ? INT32_MAX : INT32_MIN;
> +        ret = x < 0 ? INT32_MIN : INT32_MAX;
>       }
>       return ret;
>   }
>   
>   /**
> - * ssub64_saturate - subtraction with saturation
> + * ssub64_saturate - 64-bit signed subtraction with saturation
>    * @x, @y: addends
>    *
> - * Computes @x + @y, and saturates rathern than truncating the result.
> + * Computes @x - @y, and saturates rather than truncating the result.
>    */
> -static inline bool ssub64_saturate(int64_t x, int64_t y)
> +static inline int64_t ssub64_saturate(int64_t x, int64_t y)
>   {
>       int64_t ret;
>       if (ssub64_overflow(x, y, &ret)) {
> -        ret = x < 0 ? INT64_MAX : INT64_MIN;
> +        ret = x < 0 ? INT64_MIN : INT64_MAX;
>       }
>       return ret;
>   }

