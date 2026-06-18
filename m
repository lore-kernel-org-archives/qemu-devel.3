Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F356FCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waA6k-0005W1-Cp; Thu, 18 Jun 2026 06:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waA6T-0005Qg-Gl
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:36:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waA6S-0008Lr-3C
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:36:09 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I8Fulc1252623
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CESEJVVUWrtxLAIaH60d9BgyKqfHkzQNjmLmDIORjwc=; b=KqbW6oHO18USqCR9
 fCb1N2tIIavlWWoNESXFKJtBWZiSoeRL1ukhlj7UIzSY3DCK6v6M+9rbpjyJLrdw
 dftng9CsJfLlC1mNlRNFRPqon0A2BQ0hIkiqjxGKYFCZ+DexhNEJNsXMH5nB2LDf
 edaP8gZs3TwKAw/IFYcLOrbdqUCUMaMlNq1bYuSS2okbSvYOWPEdJQdM5WVdZD3x
 /hNo7C74ss7JQ6RCNq47kakzEQmBAswwziAoiztfK51Yq6sSR1VAHNwKa+z70AE3
 qC1nCJdTRMrrUlJPtUcEc1Ix7Y/ODUw+cGoPhawMdfScwFG7yS1DcCHOeaHqBAcB
 Jej0/Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7k8cp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:36:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9159bc52211so155168085a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781778966; x=1782383766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CESEJVVUWrtxLAIaH60d9BgyKqfHkzQNjmLmDIORjwc=;
 b=iyw3feEva4Gk3+3CM5tjJwcdd2vFjLV9Da+CR5dpbUdcpk//DvEKyaA2kBN+lasipB
 iqucd1H0YATz87m8x8dvZE8ktj1fnQPjbjHl16pmhzGCZ32Pcrqdf79F+T8j0Hbrxled
 boAssrl3tcDDpVX8P3N+mXbZ3coHYxVU/fTeml/QJaf5tV6/MFzT6OOiLaynLW5ASNl0
 uKkCauH1Ykmz6utGYRkjbvnihoAzRHuK9VdhTcfO9LIQX3EqAaJUvG53p6m90FBH/EH6
 G/ZlHGe/7u17C/1LyXpDObFE5ObIYUBU+OQpK5IqatnXSQvtw+A0nOMf6UATmIMl2wDB
 IA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781778966; x=1782383766;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CESEJVVUWrtxLAIaH60d9BgyKqfHkzQNjmLmDIORjwc=;
 b=gLPz0oKUpLousmnv8Mq6QKO/zFJ2Ky9lVQvvLKof9rm3vvA/yazakrXmeHAiWMsQ0Q
 tmMXlNQLA/lx3kdCfdfBUn9IgW+pgohli7a1PllLJWwiTraZX4/hfHmDr68ZJQ6xeKll
 cZ6AZjtnJdp4v5bhU7phwkdLSx97xuofPNrCkw264VwuUTXuEH5oInK+KDVKfVR0lYTz
 LPcQEb+ZEDLrI16t0W5wt78QpY4JjNJWyT1Y0LXdKJSs+jiVp8bOwJLt2hKYQMxH0ba/
 oGZzhttBYm1sOqJXjyXYT7SCBVfbgcgKHsBFxS9QvwV5nyw/qyDsIKttDkyQAjXhB4nO
 /9Og==
X-Gm-Message-State: AOJu0Ywn9hF5cVtiJZlje/d2FjDtX5ZmD+P1l7fUhRTzGGcDD6bfKJM+
 vgCB+XjJPfH6H8ZZlA93ScbiB2vmjWF2M0TT1rPR+LR9+EtOpqndYKyDtdppWnBkucDZmX8QLA0
 8axVseqZAYViltiEyNiY88ZXSjCUeImL5Oex73QPwD5uTwEeWY0W1Hd9287qXu+bqZA==
X-Gm-Gg: Acq92OHHcn0ASx8vikRYKarMK6qKuwK+65Kleibb7zjVtaE7XHbxx9mllO+/Vmd35Ho
 s2qYApqbsFCo7prL8Au3yOKCaHonJg/85tNIiPZO3GDJH46x6b0sGha0BxrnLi7on9pSK9bN31Q
 RCUAeqAuMzzAaWKfuP+6tczShAV7kBBgMvdgbdqhu/eQmp4R8jJ7rHHkspI2tqiIjL8g31TBHZv
 qoFY/E1giUK9zAYvANf1/t7tIQCAVMniWGUHJcoC66zxU/HK8BaUyhpkbkpPhzuJFz4g+mfBowc
 Eos/IIf4Jea4llq3BEiFQ1Ed1LrBjoHLOXMFWMbRJRNQfxYlg7hnH6IY4ODJvjgvGwfXrQ6xWN7
 1jx4QRLgX+WEzfMPG8HWHs+xvnaR7MIUYWill0zlaiFrPuNzmcm+4s8kM5qr0BQ==
X-Received: by 2002:a05:620a:40cb:b0:915:b718:accd with SMTP id
 af79cd13be357-91f25f90e52mr477030185a.6.1781778966329; 
 Thu, 18 Jun 2026 03:36:06 -0700 (PDT)
X-Received: by 2002:a05:620a:40cb:b0:915:b718:accd with SMTP id
 af79cd13be357-91f25f90e52mr477026385a.6.1781778965852; 
 Thu, 18 Jun 2026 03:36:05 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1ce102sm42222975e9.1.2026.06.18.03.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:36:04 -0700 (PDT)
Message-ID: <17a14283-a0d2-43bf-a055-af640177ae4f@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 12:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] exec/cpu-common.h: Reduce header list further
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260617160426.64461-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260617160426.64461-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5OCBTYWx0ZWRfX1QY6SwlSvf1V
 8zTQkoV9Jfwf/4HQxcvMuZ6sH1I090AvGc4o5I4jXIiZJO+ZntE99pnQGIbGVqUUF4FwqOonffT
 KbDxV+T+QYyWnmjwz4JietkgjbrZuiSqb8YBkCBr0edMcMa3bKTGPv4F8sQdyque+0Jbxtko2VD
 hRlKlro0CM7KqE2n3rEkC1Qr0QRni7Th2Xmc05GPWqXW6smzREktjs+SmXuZlAqZ4Vx+OtTw//3
 R0B9ay0ciCfPbeGjn+CEcvS5EltA1RDgbWV7n3RLvvGeZ3/S/UwMXNTl1JLCzaVfu+myP5fkIsb
 oNWj7hTar1J1zdzv47kyZ88bpaNAu3xrhd0CTSwVMvCzWl09f4+RSGEopT5sIkiWNWBlDRWh4jT
 8xBuXdim4PiNDcQOEobxAFUvf6GNwWhH0uqN2bp85Rb5bAy/nYieStuJ1pGrOT9phWG1RRoyjdg
 /RUJUQ9bHTN7S8H8qNw==
X-Proofpoint-GUID: IwUhQbVgt_UbBEW9WvqomcRgyeO8zMPv
X-Proofpoint-ORIG-GUID: IwUhQbVgt_UbBEW9WvqomcRgyeO8zMPv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5OCBTYWx0ZWRfXx+mURnRwL3y4
 7Sg0dpSFF3eKpwSqt8dUAqulEzHn3JOt6+KHJNXD0LXQHhx/22yLmaVfhiOAPpj9Pz7eH3jX7GL
 1j4MS0TNa1X6cxi/nD9e7vDuWmhF5zs=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a33ca17 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=4pFyefBZkyx9oJED_4oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180098
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


> Philippe Mathieu-Daudé (5):
>    target/sparc: Include missing 'accel/tcg/cpu-ops.h' header in cpu.c
>    exec/cpu-common.h: Include missing 'qemu/thread.h' header
>    exec/cpu-common.h: Avoid including unused 'exec/vaddr.h' header
>    exec/cpu-common.h: Avoid including unused 'tcg/debug-assert.h' header
>    exec/cpu-common.h: Avoid including unused exec/page-protection.h
>      header

Queued, thanks.

