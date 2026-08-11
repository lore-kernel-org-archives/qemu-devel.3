Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6ACC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtgLo-00049U-4L; Tue, 11 Aug 2026 02:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgLm-00049F-FA
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:52:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgLk-00072A-WF
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:52:38 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMpvej3553006
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xa6oS6G3Qjy38DLqMk/CQNIPn8aGyMK5OhZD93OWCYc=; b=EPwwlOAcPyLKKIs3
 8q6pf/XQhqB10RjhHychTwhoIUjy1+bfUzVA3IpL0E2H2x2EfslgZX95QUEp28G/
 ph7HnuR6ZzV2enHrnL9muaMPGMl0OTq79Z86bYI0Ci2iQRtpXxHLETXvc1ifqOCp
 IgRrewhNE8PnKR0JpwmpG2chQ37ka8CEgzB9u7xAvCDch/v/nX6krjSa2LJS0tMg
 vgQlPLz88L4Ic/MMqdI/2gtQQKQk0j94EIP1SOukXlSvUZpTErUG28aDBYOZuiOW
 0mhNt9VkBkqj0m+bzzypxkHezplxUIJQz3UIGST8A4v2jf2dsnnpcg/XEfvD1Wjk
 jq+oRA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyqmk1dvd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:52:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d137a68so60268651cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786431153; x=1787035953; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xa6oS6G3Qjy38DLqMk/CQNIPn8aGyMK5OhZD93OWCYc=;
 b=jm8/511B3Xkj2QBXrgSSHa8Qhft6fxrLgO+INyXbHmrS9vrqOn60YlfEijfHTu9hhJ
 Isp5BMaQL3/jjRCHgaQPOS6lSSd7lkzm61VWBKlHzQTtaV6PIfQf/ucC2D6Q4OZmwzWz
 upcQ5HjGYqztZcJOh472EZRUwgBpqKkRNxHUdoF7fB9FdOFbuCft0Pdkylfs/qMeDw/y
 eJr9Qtfnwut9hKazVZuBsFdo+ME7kS/QIjgY82/rPzPRqI+fMB+JsHy0HLOUi4uMfZtG
 vVOGJhzQ93IQVu2uQRmOzKUxp3Pd2r+Nk2HmrZACKlYCQsHRUulRFT8btnesy+Z3DgPV
 ea9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786431153; x=1787035953;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xa6oS6G3Qjy38DLqMk/CQNIPn8aGyMK5OhZD93OWCYc=;
 b=CRIZsP+An5BYVMnryGr39YAE8IGZDl7YpjhS0Y1dklKzbrP+8ctihMEdDveg31qFYS
 g3VVP9rNaWAB+e8dcxdF5x8ibc2xvfzEJaQqLbANB6IjWlT6117ml5vBYr8OGGEABbJI
 Uuxb0/XZIu6Q42CJdd0yucVNoL+hSl5RegLDWBLBT/XntHkmAMvJ8+VgUFyEOAVzXNR+
 P70ADkeZAp2EuV9MkEjxS16ZAzunfhO3iN8Pi+tIbavj7TyPIoEPkVl/owKuy1D/vPik
 yOSa8DdJxVC7VDRvdPsEJxKTdYT6ZFi4SUr/pLw0zGLNevrhz9QdweV/lkV2kvTnYACN
 qZOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrQvqKr/54dqEayfxIndFh7+dNLaH/vPA4COnjreH+dAKM515K+zuI1EkPkT2GhWPqhnqWTgohiMFl@nongnu.org
X-Gm-Message-State: AOJu0YwbwMc+wzcxbBXjaNq7xmWkXhVI5QLxROinUUZGpHtQq77OdoJw
 U20Wfc0vLr6msLr26B9kkCz/r6U8vMmQtxQzwBMRH9uizmd1N4x8+xIrD8ROu8FdQmUrjlfNs67
 fSFf8Po0chO/+gJkeYrS7Th8bLXAXLOM2HsSe+9+pHBtObSRoIYkY9292bo3ZcWFj8A==
X-Gm-Gg: AR+sD1369qhAm0/KrM741ajIopJ0qBMRGQUNYRUR1SQsRk7AbXlioecW0jiGqvr+kUm
 nN6tEvouOFJAsV27TY9KKq2Dzb7UupQNSAxA5m4zN8qKjzk4V3bBYQJE9GW7smb+pNs+JyuIu6Z
 xRpPZK/mWQur8sBG6MZ+keQkmus0Pc3s+WOuk0kueUWsaw0T7bQHnIq3yJxsHKloO0Y8LlfvDC7
 FpL3gov3zdnhe29GVVyllzqOImdlq7tOeWxdl1b3T0y/RnUNcLj3J2EhnOoU1RkLwTurWnugczt
 o6bOUdR5mddqUuqFrytnoW1gMCxWjH7Xa+BZoWRugtkaHocQn2q03RPFakkRmRiMdcDtQc+BWti
 tA9YEg3YwZRK8RA7LcT1EoHaPkYDcqPoL3k7XJ+mA
X-Received: by 2002:ac8:584f:0:b0:51c:8439:14e5 with SMTP id
 d75a77b69052e-52d584df9cdmr9199391cf.10.1786431153354; 
 Mon, 10 Aug 2026 23:52:33 -0700 (PDT)
X-Received: by 2002:ac8:584f:0:b0:51c:8439:14e5 with SMTP id
 d75a77b69052e-52d584df9cdmr9199221cf.10.1786431152961; 
 Mon, 10 Aug 2026 23:52:32 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a14ed5esm1708731f8f.0.2026.08.10.23.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 23:52:32 -0700 (PDT)
Message-ID: <804277d7-c8d4-4998-847d-4fe4bcc5f4b2@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 08:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] util/cpuinfo-riscv: Detect Zbkb
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
 <20260811045605.1246543-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811045605.1246543-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA1NiBTYWx0ZWRfX4QEQvKYXD1ST
 wngvoW70u6Mr3flvZyCiE8mGUDas1xgga3WhL/FJe3eFGYxpy0mFa0y8XOUq0vIhHIYrNkYJv0e
 QnrFFWh1l4qj8DO24LPMjcPc2ntqEuRpJFSk+DrMAI/YRPQqVAhsKImDXbDHDApxM45Tn7GRrFs
 LV1aa3mXRur9x8BI9TzTgt4MSzswmi+1uiq6CooLl0JGorDaMxiDgCENQFuC31fo6p6QomoV5gl
 Uk0GjefcxYHktEJOuQGPJYvELXKGBQXR5iNlnO+QvpjGDdGk4ohjOD2jm81ICdVWHQWzOwqdoW4
 cv4fQJRoV09lvsWGDvjSkgRMM7K05L5xwzkfAYPt1km9sJlU0MGJQMAAIAwq6USkZcPNySwwJ+X
 DPuTtI6CYeIoRz15ZPCkT5VVnHqtR0DO+3VsBP9jt3ydlZGF0o6UARBzJMXlidBD1nekP0LfzIR
 raSPhYUaY5k5laoTAdQ==
X-Authority-Analysis: v=2.4 cv=O4YJeh9W c=1 sm=1 tr=0 ts=6a7ac6b2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA1NiBTYWx0ZWRfXxTtGHu1TDnaA
 lF9dHT4s4uXVL66g095NE5SRKVuwGgCCwJ8gjz98LX9nqu/EF4fiZ6XHxAYjT7lCySu3GzExJRD
 xLHjwdogmmg/PiHJEKyzPCZ8ENJoWcE=
X-Proofpoint-GUID: 6f0k2JZBTMcLWbjxnk8bCfiJfRzd_kD5
X-Proofpoint-ORIG-GUID: 6f0k2JZBTMcLWbjxnk8bCfiJfRzd_kD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110056
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

On 11/8/26 06:56, Richard Henderson wrote:
> RISCV_HWPROBE_EXT_ZBKB was introduced in linux 6.10
> with the rest of the hwprobe api.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/riscv64/host/cpuinfo.h |  1 +
>   util/cpuinfo-riscv.c                | 17 +++++++++++++++--
>   2 files changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

