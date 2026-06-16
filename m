Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61FECD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 01:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZIBn-0003i1-3i; Mon, 15 Jun 2026 21:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZIBl-0003g2-8L
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 21:02:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZIBh-0002Oa-Nf
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 21:02:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0OFIt1914864
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 01:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cTiGxaHg+wljqHz7dJNhBEhJgtPYZ+sk+06FwhQAtu8=; b=junSls+UoSp5EQN5
 mKQ2FQyVurzMXn5QnjZMz0dPytalX18w0jpwHnNKh7zMcglUDhJ8x3bEI1wXOzcf
 rykHGyYppnMt6pOwFuOFidKxnhyocBsLTOAb+bKkzBx2SEnxnmFdYjihgMDjhFqO
 wBfXgSivaQ3At90Q3bKK8OfHuHboU4knSXwVgg3SLff/Xa5oZ5GcaOOXwCjZ8QL3
 fegthad4R0szhIArgi/X7eidg4tBz8GLZuFM0fzUlaI3qVUrxRljkDLhqchkFkMn
 DGmfLL70ri38cbU8UoVdr8obUE/lOM+n/3LLDYkDLIYdsymdLeKTNxEeUPd/YwSc
 oHHbQA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx3vhu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 01:01:55 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6c77c80d967so3597436137.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 18:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781571715; x=1782176515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cTiGxaHg+wljqHz7dJNhBEhJgtPYZ+sk+06FwhQAtu8=;
 b=YiXIaabXlEPgu2Zb/iSu3YZrmp5xC0HCraEABKVhjjpusp6sXYRrGtYILlXpadG6DE
 TJmHDbwJxTg+GjPvhChtnrere7aZ2JKk4xHrZ5vyNm+gOaxRObG8QfXqIRhIDfoCufuh
 NqvT3Gh9Wzxolk4leNZvRG9ELPoqCeaO7lkvuolb2mmt/KRCxbnSnO46LjAeRgR9z+Qb
 yjP0MLdGeFUyP4GXrk3zmzSiXQ3Pa2uixdlYasiRRGYHgCssv1wbcXQ+i4txO0qyIE61
 Eb7KD1fkRBLR6FxX8cGdGT4zotM9/PR3BzwJq3bc6LVISgI+4AWN+7UP3CiTJ0VQyF7n
 m0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781571715; x=1782176515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cTiGxaHg+wljqHz7dJNhBEhJgtPYZ+sk+06FwhQAtu8=;
 b=DgpMlNYtiHQ/GPeEreioto9+YnR/rdi+Rk1mgiLTzq2mvnvt9Y/DfABg7NAzvM76ez
 Nzr+qJuBBcGIKHIF//k+zwUZet4kBkdqHr7lyenm8aeB5RCInsPBWgCBDFsxnegGX3hS
 4iCe1dSvqD3mSYBoGarunklTD7oBDyYm9noo4gc5cjzdcMgXahRuT+45F1zlm1ziI34m
 zaWy0o/LlUoGpOUY7Oq9DWa9YzAq2FSvDsDFXOi5vDv2nwWzDccoZMm1mR3x1/eCtFhv
 ZAu9NubvDHs1JRDn6CPGa+MyExb9IeFwaIjN/gamgrfsGqLoSsPpXh8ycdynnMbi81YX
 8nDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ//CCzt8mh+nXRlAPm82qDLgHStsPB0NJLz/iaG2h5Qa1dMycw5B698ziniKTl4bZE1srnYiBAtBIen@nongnu.org
X-Gm-Message-State: AOJu0YxB1WFqFC4cueV/Jj1WwNdooL8Zh5gB9ezJLlOIcUfEXV2oFdh6
 xZh2yq/dYmBwwxcFACgNXw8/cP/Ucs7r2zFhiSeTXykuvnzIZ0PBCTFI7/JPPWAZTgetNur684J
 7xQnloQfjzN26VtHD5B1SygJgHnNxZ/onAKcaNaRCHXqIE7rw0OWvUkOsow==
X-Gm-Gg: Acq92OEDWXL7W6c1FMv09hXDQ5tkcYpYRCpzBT7rP7cPJAprCa8T5PBGY1qsfOAhNpi
 y82VeZtjjuRSEmYB0BbIfMpfHa/gUPjmRxHa/uIAT7xDJsIAnOmOacuFIclTBw/ZcU/RXdS/UUG
 QYPwatvbo5uGVqiZt59f+yQZl9fozmlqcKlKQuqVGp1vBwZUdWj9yQ64+Y6/9V9EUMv3xqydXbR
 cwnTz+O5w9MFiE5jCMNQrAR2vLnTJetNC+t+fCzIIRyN9yQR6dKBmuPEGf91zMsX9g0vTKdJ9H+
 lp1JXU1J5M7LrnZ9h6EIGdtwHlWJRuBGkvNsB7KP1yGjnnn8k+LGodRWU0y1Ghk+Po9Ehw4TIs3
 Vurlsp/7TY/uIcP96nR00RA8PIP8FLmvpmHDRq0sSspHo8Cgrc4ma7UT8dun4FE/WwSLwxjXz
X-Received: by 2002:a05:6102:f0e:b0:631:81d6:e152 with SMTP id
 ada2fe7eead31-722d4f64d61mr1000202137.0.1781571715241; 
 Mon, 15 Jun 2026 18:01:55 -0700 (PDT)
X-Received: by 2002:a05:6102:f0e:b0:631:81d6:e152 with SMTP id
 ada2fe7eead31-722d4f64d61mr1000147137.0.1781571714834; 
 Mon, 15 Jun 2026 18:01:54 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d4fsm42872977f8f.24.2026.06.15.18.01.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 18:01:54 -0700 (PDT)
Message-ID: <579f4b2e-d3f2-48ba-be36-340c2079936c@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 03:01:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] igb: Add VMState support for TRL state
Content-Language: en-US
To: Josh Hilke <jrhilke@google.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
 <20260615-igb-trl-v4-2-cf5739bf529f@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615-igb-trl-v4-2-cf5739bf529f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lZWW4Ip02wvoO1TorlJLUQyukhyoBW04
X-Proofpoint-GUID: lZWW4Ip02wvoO1TorlJLUQyukhyoBW04
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a30a083 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwNiBTYWx0ZWRfXywz+Go+yQhW/
 p2uiM0Vu9bXlwd0GVYjEhLaVdA6hlHI+/QAJOZWl0QhjPo0HCBNVz8rp88ZlBXG0l25eUUfXLqr
 kk/gb1AJzdvOH6JmePMv+qXkOAAAwP4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwNiBTYWx0ZWRfXzEWeIeVXHw8r
 ECb6xrmawBO5qtG9MS3YzlzpNkRLS8yL2ydiTmobEn+WBJM+2Emk3vjgFvsDpTk5qyU6CynHoLZ
 t1pXVDYxv3Q6KWnMgU9YDLeNIBHuEZi0w4Tw4zlM+Q9g0bOwqXInn0WTfE50uBUWdMn2/+4kp79
 f2/xH2LAJfrnr0n7/3wMDh+MRob0DUwziHuS4WtLopRAuwamNYK0kzZjsaMG/3EEoNIEoDfq9wl
 Vw7oEACl2UwGs/X5Y/LUthZSIxmpj359pBBBntKXglSOv53MK/XrRxXeKK6dyrN04P36waw2itP
 2WcNnG0TB79hVH10MZGcuoqXlwoBL30qcCCnA838jpt9KdfkZ35k4wpapN2SSuO+amHAIA9LS1+
 Ae7e6WQJQmTHhcY8ca2sgE3mMXkrn8K/LJ2mTS+dONMNlEXprQ9U/+zOihJ3Yvmqh1ngJnrRq9s
 /SiPHtoYOeuV5Q8TKvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160006
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

On 16/6/26 00:18, Josh Hilke wrote:
> Add VMState representation for the Transmit Rate Limiter (TRL) state to
> support migration. This includes the TRL timers and target rates per
> queue.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/hw/net/igb.c b/hw/net/igb.c
> index c076807..04c48f1 100644
> --- a/hw/net/igb.c
> +++ b/hw/net/igb.c
> @@ -563,6 +563,45 @@ static const VMStateDescription igb_vmstate_intr_timer = {
>       VMSTATE_STRUCT_ARRAY(_f, _s, _num, 0,                           \
>                            igb_vmstate_intr_timer, IGBIntrDelayTimer)
>   
> +static bool igb_trl_needed(void *opaque)
> +{
> +    IGBState *s = opaque;
> +
> +    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
> +        if (igb_trl_enabled(s->core.trl[i].trlrc)) {

Using 'bool igb_trl_enabled(const IGBTrlQueue *q)' in previous patch:

            if (igb_trl_enabled(&s->core.trl[i])) {

> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


