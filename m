Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660C8C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woFep-0007yp-Mn; Mon, 27 Jul 2026 03:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woFef-0007xv-EW
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:21:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woFec-0005kP-7E
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:21:40 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R1fcqD2416949
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n9Aos/jywAp1KiMqxdiE8FS02FkmBZsX9G9dQPrcuvQ=; b=EL2iPqfyrvykxEZa
 MFiIQ+lSCqpY0dq6MTGp18qPgDTC82WXawL2HenxIA5MlUO15NozzHXVbLLpfkvi
 8MaMguk/OOYpkbFmN9yrJcWP8M/m1PPSkii9gtLTmd42ol9mQ5LbcCsUK+ekAkPQ
 3t5bwh/Wd1sUOXBgzyjN2jCMYKUzkrYOSeKHliskf/RBkUf311JSJ8L24A2wqtYx
 NstW3BXVnO3J3WCVZAJ3Uf/u8y8gwxHjwzVueiJo2/l3rMYbZQE/Tm+Q31ppiT5M
 tUHFcoJ/2m4xoN5b7sSEf+I3PoOFP37DRL5e1qbqGVZj0WNjZr1pstUTxXUOeOqE
 l4M3QQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fngyst6c5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:21:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a236220so27540011cf.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 00:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785136894; x=1785741694; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n9Aos/jywAp1KiMqxdiE8FS02FkmBZsX9G9dQPrcuvQ=;
 b=gGHRlqeublu2dvm7U8ha5HLwqUNuOnX5COqKkicGx/08GvRhoG7C/hYokJzFyUnkF/
 CFQ84PzxY/9TrWsatKfb+8xB4ZcXrYoo5qSnbLZ61G0OgJNcAC8OkQTHSrCjmmsw/Zl6
 +Nx4utuJyAwN5W7TBpSLznBPE2GlK6Ggn8gaxAOYybrGdnXcjhRmTT7BFvhW+Nck7U82
 leCqVjjhT5LLlHseW5ZQIemI1sF0hM5gj1jOfJNeYj14DtiGhaUCZb1GkkHvYm0q/YhN
 bSprPqscE3L+LyXxlVq95BKgfAJv8r8EQatSNbL1wbTtVBa8n84Ns4foONDVxzGB5fQl
 y5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785136895; x=1785741695;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n9Aos/jywAp1KiMqxdiE8FS02FkmBZsX9G9dQPrcuvQ=;
 b=I6DktzVRgu7oUxFSV6hNlFl+VzGPnP3BHOfXI0Qw5Y99RpOa5oGljZJVckDyjF/Dfk
 q8IwLrD1Yw3iyptI9u07JU8xYggRDQu6zygQCAjVZaRLMF2OoBC1Ahg2KEroto7+b1GA
 /SLzGhBiBTxNKHhbzmDT25kxg0OWWuzVBj0FQJXBgBIX30LfxEGYC1UN5kzGjuEdnNsr
 0GBxSywbkq7ayWvHnE/Mn52rn4MbRhHuH/22wMtxUuDiDUmm1+SNmHA9T92+fBPdBoEr
 P5ZN1PisMNTXiCuX74pUMYq1axxKh8F+yWeVtz7I4XrLThmtnPA+S+1vzIAyAqRNRqIw
 GPEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzNZxuJEleIt3kXZ5kkGPyyb2I5O6Z1rJ85i0JTR1WjXSGLen1G2Wofc5UW0HwpHk/vAGgFV5I2arP@nongnu.org
X-Gm-Message-State: AOJu0Yx3Qvla/tWy7eS0Uu0NEm4aRT9q2AKKucZJH/lW2Jvxd7h2Zp26
 bot0C9vModyY2yADiq3LfFRCapK4PJ6YJhwRu9Z7k0eR433rwkAWdPLzbgIdJ7qTRq9oHfLiYqj
 WjAmnwjwJIwcNDu4bCcjp0M1I2nFxyfASqEBhLRRZaFMtapiS4Z2DFCbU5A==
X-Gm-Gg: AR+sD122G/X1oZ4KrI/09eSEf/hgAPp0ZDEgEd8MPAwFKvJBEcQPn2jc10fyZ4HEz8I
 bd3hAO1J4yNTBX6xYQdUQgqYZVZfksdW8rFwFGFlH3ju49jAJ/NcXeFLbcQK818Dr2AsIOsA/c7
 t56mr1LTWhA3gLPyW/WELk5I9aUPSSQA24sP/rtWgb6z8IE9h9HvfvsXM67h9hCvbpeoqvZHolw
 n58NWvOOevi5HnicAfyLOeEzgiRXlkKtUk0bZzKR5OkEDoLMY8UYMvTWl9s2adbuNsCaycwnDPq
 RXdnB8YUvHU1s6IV7KL8246orbtz8yG5XS9gD9nowsjyUhEK3v4gOCxTBO2/IbD6CIkNySrapfB
 +KMtC7JlMhtL9QwjdxJgmQMqgi8f0HPyQIuS/9RMnaYy/kCQb3R8=
X-Received: by 2002:ac8:7d16:0:b0:51c:92a0:b2cb with SMTP id
 d75a77b69052e-529a84cd3d2mr70090321cf.26.1785136894607; 
 Mon, 27 Jul 2026 00:21:34 -0700 (PDT)
X-Received: by 2002:ac8:7d16:0:b0:51c:92a0:b2cb with SMTP id
 d75a77b69052e-529a84cd3d2mr70090121cf.26.1785136894171; 
 Mon, 27 Jul 2026 00:21:34 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4ee0e91sm201630615e9.4.2026.07.27.00.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 00:21:33 -0700 (PDT)
Message-ID: <d5f540ee-0d6b-46f7-b3d0-6405bc826eba@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 09:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] hw/hexagon: fix machine->fdt leak in qom-test
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-8-d0c4831ed7ea@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260727-fix2-v2-8-d0c4831ed7ea@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3MiBTYWx0ZWRfXxyg1laA1BpoZ
 YKRAsHqlIX0eKrLIiprGCNLa4za8jgxXJ/H9xjLmfaV5ed6Fq7YMsni4LLltjHGkfBaDNZU4qAy
 zqBhfCVaWaso/6PO3ZuR0uU34Mky7cUG4QtSBwjt+XCWPIojArwY2tOzpxUXA/QgcM2xF24uMFP
 nRueIorzqvMiAoxGVVrMarHhruIefe09eyjUWNgbWPXakiWDXLyXwIKNoXE0OWzC5VsOXNCMTaY
 +KGvJHuiQjr5stS8pX3DSDJMUwLiUuB3K6xW2W+gbyedavVcFJMoGc6r/MsjNa2QViF3MQJxMJm
 hySstcCNpd7Y75+7BK9LIeq8lR0uS7zpSExjhw7QQvHZhBJRlwTQbn6aaG/f6A6MpPBCtZQaLdY
 5KMlaWD0Ha015ZPizn4W9yAFAJkCP7d/8z17x1WnUyUg71r2CiIC4IvCQO8ktRE3/Qykoe6eS/j
 iVRrz+An4EUxdwyb15A==
X-Proofpoint-GUID: tGb5uolCEjvZ_8OqummJqlI6DvCd62ul
X-Authority-Analysis: v=2.4 cv=DNG/JSNb c=1 sm=1 tr=0 ts=6a6706ff cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=CN8BiiQClkPCgTBgyyEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3MiBTYWx0ZWRfX7rRx+dJ7NxJe
 nrYwqihAD26KvX61HT1/5VVe2yRN+Gjs49XEVieTdQHO0dWGuKD1RvSy/T4uXhWckY5xH4u/l5w
 HACf48Haz8h1lehaTTNbGlTh2ETkDQ0=
X-Proofpoint-ORIG-GUID: tGb5uolCEjvZ_8OqummJqlI6DvCd62ul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270072
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

On 26/7/26 22:44, Marc-AndrÃ© Lureau wrote:
> virt_instance_init() built the FDT unconditionally at QOM
> instance-init time, so simply instantiating the object (e.g. via
> qom-test's introspection, without ever realizing the machine) leaked
> the 1MB FDT blob: machine_finalize() does not free machine->fdt.
> 
> Other boards (arm/virt, riscv/virt, ...) build the FDT lazily from
> their MachineClass::init callback, which only runs when the machine
> is actually selected to boot. Do the same here by moving create_fdt()
> into virt_init().
> 
> Fixes: 88a8bc7f43ff ("hw/hexagon: Define hexagon "virt" machine")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/hexagon/virt.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

