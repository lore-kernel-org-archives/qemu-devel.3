Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8459CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGkhP-0004KM-Ry; Tue, 13 Oct 2026 18:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkhO-0004K5-Cx
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 18:10:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkhM-0006gD-He
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 18:10:18 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DJaAxN2222100
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 22:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZRywliSbt3DPLxEpL0vh4e1utX+zPCfiiWr902x1caE=; b=HPto2TQ/Evl6M3Pw
 umGvolPzUzx6jzN0xMoSKkeTpDbrYR1Ka/sxc9XhayWpy4YB43vAD45ZjpPtOIjp
 /gfACbqQl+6Fpi+tPQ5e9MdC2YrCDQ1Re/UkA/sAXw6yDTohsOoxTtHHFnDNORKP
 5JTLwCfJoG0phCKFvGl6BwU76a38tA+RmB2BLjp7HEEZSh8BhLeo/5Hrpytneooy
 g21GUdZUyJmjwDc3fXMaPaq+HeEk8bz0h0Y2Hh7T2W+uPRHmZGvac75m2+NguzYj
 mHC4361zzyjEwyE53BGKKMlyGZLn1Aj6lyB+AmaTyCFgRam8oDMy8Sv3XZQIjv9e
 bsn9ow==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9txs8j02-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 22:10:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so908575eec.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791929405; x=1792534205; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZRywliSbt3DPLxEpL0vh4e1utX+zPCfiiWr902x1caE=;
 b=FrijZH375pSXyL9R4fr0aPJCNfsfYiW0isEfJLQlw0EiaZS3ljqxT1qWASnGYmgXSl
 JI5LZvRH9nEigkX30kdiclhdAgJoK7wwMiSn3ECQSceF41E3Vlw6tndxrd036sS3xQG+
 /VCoJQELUtSRLTm4BDYJvLXUSC//7OXCpdxEnesk2lQerlFZJy0NsfF6zdnsBynclvUE
 cJnY6siWQdcxwREpAEZJLkNWbBet9NsKg7iTKTyv1LZ+DohQSw1o+JhSMHvXqk2wwDOR
 +k3I5hsTpC2aUhWS7Fz22BkFiSt4il2HhLJGCs7Ufd/OshHctYaX8daTWEW9er1UQHNi
 iH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791929405; x=1792534205;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZRywliSbt3DPLxEpL0vh4e1utX+zPCfiiWr902x1caE=;
 b=uqWFNsRF3JtzmAzUxF2LGUhxUj1QzF+Sc6D2l9w8OF6L3345w/0ZHgUK9pW3GslSKb
 +RQIxrQZjV14KnEPvVPZL73bALefWbJAdVfcIo+vsTP78gFe+pXzqjF/i2TGY9oqP6wk
 e6I4ywFuISYQJ/4U0niqJcOpwt9BBmRR/SKFUsQisUmeB/555I7qh1kgMNSXXD3RatCI
 oxj76tH6UPhiHk7jYy/B5urcvfcnGYoUTlzP1kIKCEPQ8MZqe9W/iSmcnjke2BZRWdgF
 +CByOdaMM9d2y6V3Z0/IdcF0670OhduJwWhkQTDXWUUUt7FyyKCVGS8iAdoHOm2uigTR
 1ILQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByHoYnLSRxjegVzSZ0FuDv+PKhgXCl+ar7ICzl8nYRYgMoZa5ZeOVcVUFi7FL3I8rFHjKmlJ5ks7U2C@nongnu.org
X-Gm-Message-State: AFq9FYJdEtYMj2pRtmJX73IkeB5C+aUONDAbzGE//Hw/544mX+Szb+PJ
 /Bkz5zh5QqK4PCfA64WX+zbxg53csyPZzbnZq7/xVd1pIzqkaW/Pni1GrUlnvFybghHBfVrzv+c
 rfhC8LmjxXBi76Mc9+Rm+zJ8WVCIYbcdslXsb92sx+ozprL4z4rxDzjmE+Q==
X-Gm-Gg: AYBFou1gOEtnrN5SeoWXPnYg7Sc7aKTTzJyE2TIiVoTuJPX0QmlGAAoFrTwan/aAEBU
 jxSlzfcZ4GGqkk728loeXJQhTw6eBHOZK27GK6V3ot4iq1NO/1J6H4EtGRMzVty+NTwZ6qCKA2c
 9sPkk9ESzO06f0fa2yO3s4tDhMRndHogG3DsOOhBL2nc3B4P1Xc7BZ2EDkx38zKcOKSb9PL1rWi
 79cJIIynq0OXnDgqvvCCgMJDDhTU2Mk/orU4JAq8cNRixss63WvhpnUmDgx3QdKa5lOpwXWA6HN
 8DOacnS0ySRwhSkKoyoGMmCFw0RQqjQL+GTGsOR5VZ7yYeP+ij21TONEF6PwJWzOHI9Evp7Q5FB
 5u/sKbylEJnKFQAWOcyJZ2P0ySVbcXc302wnBMeLPPKKI4C0wC4WeLmpGatMphciGbYINqQ==
X-Received: by 2002:a05:701b:4505:10b0:143:2982:1043 with SMTP id
 a92af1059eb24-16a6169538fmr17644281c88.36.1791929404545; 
 Tue, 13 Oct 2026 15:10:04 -0700 (PDT)
X-Received: by 2002:a05:701b:4505:10b0:143:2982:1043 with SMTP id
 a92af1059eb24-16a6169538fmr17644242c88.36.1791929403952; 
 Tue, 13 Oct 2026 15:10:03 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a567bd18sm40258839c88.21.2026.10.13.15.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 15:10:03 -0700 (PDT)
Message-ID: <c7c38763-5cb7-4e4a-b841-5e52b1800b70@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 15:10:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hexagon: mark clock-backed register reads as
 I/O
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009003521.2227155-1-brian.cain@oss.qualcomm.com>
 <20261009003521.2227155-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261009003521.2227155-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4OCBTYWx0ZWRfX+WlFdQSgiR2x
 kzY3LDmQlx64Ch1pXC8mxb0Mvjd+4wOqQguIpfZliNfims7EsNMb9BDwTFw7wMF911EcsMWwMUE
 NuVufTfQpGWYsWE5aT/bbySCwQLEzpc9OmRR5g/50UXGGfG0GEZSldbwEFOdxv8AaQask8+jEo/
 s/0nYsQrvyeWODf2riAJiavf66Z9oDmJg2vRd2dCRSlZdQkO8x5qVVzssMGI5AtiY98bBFgmwKP
 Y4l2QbKiUJqo17567ozY0TfJDaCSi4Fle7K5gsZDI8zYDJXbtB4/y5RCkVYHx3mBtDRzP+NJP34
 8C6mRIp8BttK0OVLNwltNVbxYQhEUVkCVn+AY4HJ/BYTIpZ58vWuzScjA2CbdK+d1UMFBo7FaOb
 0zWuQwWFzRuu4g/sJoHhQUF0NqhVw30+QNSfqbrqfEr1ZQqGF3DZfQ0Q+CWWEmSv20lEgDRHtha
 eN0QA9X7vaDqdtJLwHw==
X-Authority-Analysis: v=2.4 cv=LPPz05W9 c=1 sm=1 tr=0 ts=6aceac3d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=aWDhbmfc8hegVm8qnHMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4OCBTYWx0ZWRfX6sjrcBrbIw9f
 OBcFueLL1exIuozog+IoRiZUFrIEnHc+2L7iQLgrdfC0cFUN/5vKUhPrFCDJtEPtKzlZgzpdLOv
 elFyZTkaeiYcNK1IOQ3mHhofU6tVIr8=
X-Proofpoint-ORIG-GUID: pX0oi21P1cdfKzXjB3wkYup2YvIV7oNS
X-Proofpoint-GUID: pX0oi21P1cdfKzXjB3wkYup2YvIV7oNS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/8/2026 5:35 PM, Brian Cain wrote:
> Mark scalar and pair reads of *PCYCLE* regs as I/O so icount synchronizes
> before reading.
> 
> Cover the read paths of {U,G}{PCYCLE,TIMER}{LO,HI,} registers.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg_sys.h | 12 ++++++++++--
>  target/hexagon/genptr.c      | 30 ++++++++++++++++++++++++++----
>  target/hexagon/hex_common.py |  8 ++++----
>  3 files changed, 40 insertions(+), 10 deletions(-)
> 

The comment on translator_io_start seems to be out of date.
cpu->can_do_io will always be set transitively, and not only for icount.
If I understand correctly, calling translator_io_start will simply for
effect to end current TB, and start a new one.

All that to say that I'm not sure it's needed.
Did you find an issue without this?

Regards,
Pierrick

