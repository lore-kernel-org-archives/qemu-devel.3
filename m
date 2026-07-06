Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CE7C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgdlI-0006Yg-PO; Mon, 06 Jul 2026 03:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdl9-0006Xz-3T
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:28:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdl7-0000tt-H6
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:28:54 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66642BkU3595286
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 07:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EzVia4zTXwXEwRHQz6nvF2fqBoS6lNXurb95b2xghag=; b=ZjSPAfJMWhm8loT8
 MzommeqFQw+ehfkozh7SSCtZFQg26y+tpf7KUfcBFQECNw8AAjgZPh5MBAVaLL9a
 yb/lMvq99q0GN/qQ/AabjQR6bO5pl3+Qj7SL5xHr8+LzYxbs4TvTKFXULBKX33rD
 Wifw5nMAiZcY3y3HOgs9KfRhE7MXbR2yqJAbniV9GfQPSfhm7WuY+Xdl2CMRwtOM
 EpyrjQge5DCjLCtt0TGh+yMg+XK/DFAU1bQBieJfWgHvykqM7kxPmx1R/6ggKN6S
 05YmuYOBwuvcSf5a8/Gv6nAByJpFQe1FBqY3dIm85uR1glx06KcOExByzKyeBg90
 3lhvGQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgwc3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 07:28:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e663c29f2so287547085a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783322930; x=1783927730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EzVia4zTXwXEwRHQz6nvF2fqBoS6lNXurb95b2xghag=;
 b=H/Yas24ipvsN+x09DI58mpA4Hg7z1a4Rlt5bPkTQHEXzypxhEJ2VK60JLBSH6KqZSg
 JmRaeeoPrtEs03dyGo+xr6c1JvRSpFt8+34wQGEM7JrrpTWjK3uF75cmZPEMUtV3dwkq
 lTTrLH2S6ozkRKdTp+YHN+4y6R02fHH2tJ4XrwtO/u/hadXKWWEC1ws+v9tVCI/iEcBt
 zc+gMo35FmgFM0VPv1VRbhngm77xBJ+wULFPjWexpPLplkGb037N0UplZtCL2dSDwxUM
 KUAfLusW8VYQkQJFDKhQ5FIlHCaZHT2fUFEG4+0opprriDgbwSfStkCmd1j7ltftK6j1
 ZVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783322930; x=1783927730;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzVia4zTXwXEwRHQz6nvF2fqBoS6lNXurb95b2xghag=;
 b=HFXxNtaFuiYG6Rggm0lYIXiNemS/xX7SPf7P1cZlUsK+N5pkp6lJxec5fedw1XAYvY
 5FvfTKps599XGQLBGY5IUImaUyDeX+ym02gjJzBKWM8vj+jg8gn5MPdLLpberjqrMaHm
 Mn/SAujmCxNhV6LqlkXGLZAT4FR07O3i+9IXqZqb5gFoQDKNxZ1+yNRDScIcBaz0+nl6
 OsvkccbWS9C5g5B7JS4B9SlA6EERNsnHZzhBtWjxvc8XJiI4OjYRErhKcOulvSuOYIwP
 tb2cFye3I9QdIGWoCu7p/fqNzD+o2VlnCKXbalw9Naf6qIl8lCeLSvO36/iZdEIK3cP2
 DvrA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5oSQms4jCD9GEC+y9IaMAqCDhg3cesAKBiTGHsJdKtDGaJ++ArvLLtA7bAhGd6xRGLY2OHk9PApXi@nongnu.org
X-Gm-Message-State: AOJu0Yxbu7gPoBuh3895gVYDplRgSOYhpJ+vkl7CflCXsXxYOAm4wYtx
 3iIo9w8OwEmuiYS0XqkWpmM0Pk2aNgehnqVarWYBUVwAWJS+8zaJNtM5NIp+NORtUHsQko2b/6y
 jWTznNB0DW5l6YPi2J9j7SRiI7YMAqQa3mnXaRUjawAkFkjri+ISHHAKRYA==
X-Gm-Gg: AfdE7ckM84TD9FOMyNQTeGl2pS5kukLpt6Cpdl3Yl1o0CJOCQvL/t1SbXlIv5wOkc69
 oVAqAxrXCyg7gb96yjiEHxfv2O3us+aKcGyGyOynawm0kKnDqlM3Pmku1hLfqPETZHfjQmQvwZF
 OZulTbh1HHWEHI/pf5OqcvjZ5ead2I7tMDpvDLLhzTd3vLpoYB15oOPyE4L2CkhrVGmHurGy0cm
 vLMPLGWjeKirSzJhHJrfKqRyQDRyp1RB18ALUCegZg91Jx5jqkkz6pUuX4ND77CmLLV6CO+i5kW
 qCB+dqlzXDYkRrO+zmLaUJIDDS5UOYR8q51rlNL/8LmrY36T6mYIaKtV9BwBTCdcbte/d1p8KIP
 WkFV9kbmVMVRIIhXsxpYBIOrckrGtLLYAcILLoVgd0tOGGAihJNbh2prqm+nNxA==
X-Received: by 2002:a05:620a:258a:b0:92e:65d0:1cc7 with SMTP id
 af79cd13be357-92e8b5303a5mr1722429385a.28.1783322930320; 
 Mon, 06 Jul 2026 00:28:50 -0700 (PDT)
X-Received: by 2002:a05:620a:258a:b0:92e:65d0:1cc7 with SMTP id
 af79cd13be357-92e8b5303a5mr1722428085a.28.1783322929837; 
 Mon, 06 Jul 2026 00:28:49 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce12c40sm441137565e9.13.2026.07.06.00.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 00:28:49 -0700 (PDT)
Message-ID: <85042289-f115-47ef-a05c-25f325efff04@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 09:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/system: rewrite gdb breakpoint and watchpoint
 explanation
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260629105837.71103-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629105837.71103-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4b5933 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: atjObY0zoo2pynk-XSi9d3bp79vtMIw2
X-Proofpoint-GUID: atjObY0zoo2pynk-XSi9d3bp79vtMIw2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3MiBTYWx0ZWRfX5cttt7YT6smx
 eJHUwmXc6sSQh1+lLxXcJrvU0ZUsGDziV85cwnAZMuqWPmxHjD/KZ7/ebe1AiD+J+r4MteoFTHR
 HFnYrMGOBc4npgy7OxbVZkhmNbHx7k4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3MiBTYWx0ZWRfX+fwFdDSWKRDe
 M8Crlgd6mZfgOS+BQlC7XoRjMwT7mt5AvkGJb0GQUqESDG9mhuc4I7izjrPSeSZsxq7+OCczg0f
 2nIOHf588sVwNpfEyOmAxCTv+gdJ4LuDwD/TpouAc80Uvn0p/eAA+PgdD8pCFZ4HjGn//ceIW/k
 gy8j5XhUj280pdMZS3uV9/2ESPFpdE1++A2UWGsQ7p19YGyybdbvyJOxkLPGqAcnFvP5ECGG5z6
 QC8HXIsi5Y2zR7CvWsNwvwzKDyl4zEGIM1AY4dUhOWpfWknPDx1nJ6QXnG8qUl6d8ETWS5NiKaL
 2ctkw/ip/fmZ66M5V9DgoOYdH2Q+hQh7hlFxGYRdAx7H37ks/WEH+YoSfdYUVS+Pl9/uDZtY0d8
 /UCKeJ7xfYZsnFXQ/9hovpuG0sK7WdBojIiu63gLiV04TIjAFOOHEbBxzC8VZDMH9GELU3unb50
 jXbsvRfPw/yuyHEYf2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060072
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

On 29/6/26 12:58, Alex BennÃ©e wrote:
> There are a couple of gotchas we should point out:
> 
>    - software breakpoints can fail on early boot
>    - TCG treats all breakpoints as "hardware" breakpoints
> 
> Rewrite the text to explain this more clearly and call out the gotchas
> in a note and warning sections.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3596
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - made the soft breakpoint section a warning
>    - moved discussion about TCG's unlimited break and watchpoints to a
>    new note
> ---
>   docs/system/gdb.rst | 37 ++++++++++++++++++++++++++++---------
>   1 file changed, 28 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

