Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283B5C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 09:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvWlu-0003Ov-LU; Sun, 16 Aug 2026 05:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvWls-0003Oh-Qs
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 05:03:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvWlr-0008Bm-9s
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 05:03:12 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67G71t4O2712485
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 09:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mhyXMt6UWc87BhHT7nwJWoGWyhlt88Jw0S+VoBsiT/Y=; b=Qs8KsdNc6uVtFnsw
 i62pKoC6jU6/5qjsXHUeDRxqd0AiPxcJM5AMavVjmxhh9mNvPID6T/lMhKikCxik
 2qUd2u8XRQ1+Xpog0sB96pF6pW/yZsCNSUEX6dHl7UGUeYDG4iRcjesZCvv3Q3I4
 zrGgjsbeiVHnz6DRoeoHAW0qs/yQ+q4/P9j6fbuxE1taunX782QBrjvajoye5QNr
 AMk1augupl35TnFv9npf3r0c3MEnEpPim8QhrKFFTWTLoZPxdWtFZFYqeH/PxspC
 HfdpkfBoxn6F+UEUlzmhYeQQE+CgrFqPxXVXm2y76fGtlSCWaENX4TmXzEFxVFXH
 AxWnnA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf34ah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 09:03:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52d9cef8d15so13861141cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786870989; x=1787475789; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mhyXMt6UWc87BhHT7nwJWoGWyhlt88Jw0S+VoBsiT/Y=;
 b=jDhHOThmUgqrDvrVy1NF3A7HxO0tk2jUiMpc/xqlIImBfIE5n9eMO6Rt3sVWbw+SfO
 fMLSaC7hDYiWkP1ld+mfu5E7gAA0UbQy67WQuED5L8vts0PRhJAuKkJH1UtV1CzCX+P+
 jJm4GvMQ5RLRolSu+7XSrjAeoW7fvw2OcLC9Jp8QB4ktd+6Q5/1q0RxlKMHj9wzpjhm5
 NnfA9vwXxjcM8zOMBg8VvgFEWDsrMzZsek39TsHlfj7djk0m5e46cRV9qqDAxYM2H+em
 7nn1LPe9NEgKblZ4pm7BV9JITio0ZIhuDEg7FTFWE3kjb7c030Mr5ug0/X7LoE3pTroi
 xfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786870989; x=1787475789;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mhyXMt6UWc87BhHT7nwJWoGWyhlt88Jw0S+VoBsiT/Y=;
 b=LWMqYIOZ8oiNAZR/Wd1GxMmpuACAWzQ4NzbRT4/6ef5YK7DHhUt7ORvhsGD28DL9Nt
 J/GkDgnPlRS9jD3VVwXipXA1PaVVkLbuJFzAqnUwkAdildkE5OjHuenLGirEhErP8KtA
 +V79Wl2+KZTqduX0Bwu2jp6cItmNLHUUIRWtUrDsruqBlhxXLxKWL2qbzHssbl8zzryq
 mpCA3lvSZpYnU1DTFZR5yzcCMe/c8nNRu4JXh1qbyfEuHXH/AN5PL8prHn9wb212nnuS
 5G6ZbEvEoaAFa82LKCQfOCT3ThvA2+OY7/4KK1gNSqDoe0I9FQCTCaY8u43cjpsd25+A
 V9mg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro62f7/MIEd7jwMQ9b/0xD3LpvqLcfoiYNwvwy0A3tviFsOqX1y0vk4tke1rIVf22WmwOzxKIEvfmSf@nongnu.org
X-Gm-Message-State: AOJu0YxP1dEgPbjaUBTQZm6EFgAWUHLQxoYCPDzxvWd76eNuOzidn8aa
 egJaCWxkK2RADfm1GB8IhLqvRTuJGtYmrmMtu9ZNOe5teUK/HWcZVleBXACLyVcu8TL1JWW+Gs+
 RwJucu+F5AJZM53fFk1E3wWEbzdRQHopCUsbSdb2+KR+OCMalSaDfaXyezw==
X-Gm-Gg: AR+sD10lL8IK6MSUUaFzE1va9kOpEspEuhFit/cTaVgTz4QjcbThkjlMPDKgeVo6ROG
 9if6SO1Jbn8acuJLP/cTGSKGDRS06D0EVtVM5lzSYC9YNSKe4QuW3Ewt0iXHBtO82dqDrGdZ1k1
 OzUzkok3YzFNICrct9hSN0oqJPSBW0VIaMb2h110gfbWMg5zvgUgB1lzphmOQ2XrBBSyKAj+/vX
 wIq33RqpzsMSuOX2gjicdmBc77CzyZqHUFtuNKffqMf6LiM9C8+JdEbfCEThxetLNym8CmY5/oR
 KZx0a6vhUREEUr4iLMozFpeVeplvEQCmp+I/wD8tikPXYNmN65uD/FkyASHuWhf2lElEVTgVDzO
 dcK+7RDRBCiD2fzlU9mdIQWjm70cQfNRmzkI=
X-Received: by 2002:a05:622a:3ce:b0:52b:6543:d8a with SMTP id
 d75a77b69052e-52d8542c17amr155022581cf.26.1786870988804; 
 Sun, 16 Aug 2026 02:03:08 -0700 (PDT)
X-Received: by 2002:a05:622a:3ce:b0:52b:6543:d8a with SMTP id
 d75a77b69052e-52d8542c17amr155022331cf.26.1786870988454; 
 Sun, 16 Aug 2026 02:03:08 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610ddaesm42524375e9.7.2026.08.16.02.03.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 02:03:07 -0700 (PDT)
Message-ID: <627091e1-a307-4afe-aa3f-15593478c5a7@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 11:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 40/53] spdm-socket: convert SpdmTransportType to QAPI
 enum
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-40-cc9396b9c18c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260616-qom-qapi-v2-40-cc9396b9c18c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QsVuG1yd c=1 sm=1 tr=0 ts=6a817ccd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=0ZME4I5e2UkIXez9rz8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: PlSDozM8A4aR9Vhxt2Dm3tAScjRhFfi7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDA2NiBTYWx0ZWRfX2e6mfP/BjwiL
 XD6UvPPGWfePUTD0jVXh6U2ZYkGJoO9qmaF9H4dKe22miWA7ocaYARAffVmvKD56SPUJzuFgPtx
 wiFbI82PyTMInvUvYIH0wV8JWevMcAWHGMvgNWEcapNoc01OjdZJHk2y69nc7mcQC2ppK/n4fAU
 QxS7G7cyIPsAfNF8tlUM9rt1JQV+ioIL3OBTucA8b3GYJEu/3z5nUWMQxuXVONd1EU5KfLe6g7Y
 kRteYJkUUNd6ew+Jr9suYIpk9VFuptaA5dlkmKeFBNiFxvTDq+7J0sPFWgpcLwuaIyOQMwAU6W2
 jo90sVF/Nqp4t24btf3s6OpBj6E66dr0s4itz5+40EINcQBCnUUNviebUSpYGQpO4olRjvljhrl
 0Y4imwAlz755iwOMRVq3haUWoVr0yugNL5EFYpCYJf9UdlRARGLWM0un9U+/OHSUTcOBUI2Qc3y
 LrNEXFzjBiJr2XjNWGQ==
X-Proofpoint-ORIG-GUID: PlSDozM8A4aR9Vhxt2Dm3tAScjRhFfi7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDA2NiBTYWx0ZWRfX/0+ZzOvTTgrs
 hexKWdWr6z6C+8hyFXFUI9x5j7tI+O+oepg/UR4ktlXCEd6DEcdszbtCd1j3WTWudO2WTbqlq9V
 N1HZhT2hGYX+QDTnvFfHcDpMDkpCjD0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160066
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

On 15/6/26 22:38, Marc-AndrÃ© Lureau wrote:
> Replace the hand-written SpdmTransportType C enum and QEnumLookup
> table with a QAPI schema definition in qapi/sockets.json. Update
> all users in hw/nvme/ctrl.c to use the QAPI-generated enum constants
> (SPDM_TRANSPORT_TYPE_* instead of SPDM_SOCKET_TRANSPORT_TYPE_*).
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   qapi/sockets.json            | 20 ++++++++++++++++++++
>   include/system/spdm-socket.h | 28 +++++++++++-----------------
>   backends/spdm-socket.c       | 23 +++++++----------------
>   hw/nvme/ctrl.c               | 26 +++++++++++++-------------
>   4 files changed, 51 insertions(+), 46 deletions(-)
> 
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index 473be2ac58a..dbb452cfb72 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -252,3 +252,23 @@
>               'unix': 'UnixSocketAddress',
>               'vsock': 'VsockSocketAddress',
>               'fd': 'FdSocketAddress' } }
> +
> +##
> +# @SpdmTransportType:
> +#
> +# SPDM transport type
> +#
> +# @unspecified: Unspecified transport
> +#
> +# @mctp: MCTP transport
> +#
> +# @doe: PCI Data Object Exchange (DOE) transport
> +#
> +# @scsi: SCSI transport
> +#
> +# @nvme: NVMe transport
> +#
> +# Since: 11.1
> +##
> +{ 'enum': 'SpdmTransportType',
> +  'data': [ 'unspecified', 'mctp', 'doe', 'scsi', 'nvme' ] }

The change is correct, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

But I believe SPDM_SOCKET_TRANSPORT_TYPE_UNSPEC was a mistake
and shouldn't be included. Not sure if worth a distinct patch
or mention here.

(Cc'ing SPDM maintainers to get confirmation)

