Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00EAC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 05:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whKdl-0000oT-2f; Wed, 08 Jul 2026 01:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whKdj-0000o1-GE
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 01:16:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whKdh-0007Mi-Vl
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 01:16:07 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66842AZJ1572648
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 05:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DnE3EHzcAAB3wOGkpHX7qlXo6YZQIie9HvI/CCy0uxg=; b=XsdzWbKeTFvbSjDn
 jrLZKh6BLeZ2s9Lj7/fBqnC1I2jpokEFTkWNRGloNLCU1f6ph6yJqAn5zTP+uJLb
 MbjA3lwudur0pBFrdvkNj97vldBtH5EWeHDhX7ZnW8s7HGDRD/nR/J4ppiTjl6Lv
 QcuWvFhYjEBtMg9THqeQzN7Ztxrtv2U6mf8EaaEP0iJ2CpXMrlEkq67Yr/kD3A4b
 GNrzKXFTIflGNZgNsVakuPWFcBAbdLGaFG/DJ5+t6w/HE82urKz3FTiN/n8uLGJ2
 8tyamKQYk2lq68bcv2dMK5jxwVPajPnn0+u9A7EQx96nimK25XZc9y0WhI4GvcCD
 ysIPUQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f99hgsfd3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 05:16:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0199faafso2831971cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 22:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783487764; x=1784092564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DnE3EHzcAAB3wOGkpHX7qlXo6YZQIie9HvI/CCy0uxg=;
 b=jBmLBHp1QCnDjFi51o6/JxZc7GjxBGMf8C5G6oYRsFRM7vawy8QYuB3s3zivgTYdHL
 MstgOx8MPlpYEjg0OWfXHR3TSRSFAY0vtq+u6RNdG5MNXCx1Y9GR/rI1r2ixXDL4HRq2
 3rVy/4ONz1TPbbqCU01XzNjlbf/DsbxFsyHZzR8oce6xcUmO5MxRkzYAyBE9rGYaJuXs
 43dRVS0IJ4KmN4rgOfyqt0tHbTimtUqObFTcgOVBE1WCOSMRvl4whdSHr5oJZ1Ut6+GP
 C34XL9Tq7L2Lo2QhcPetqpnWPMJxO+4GvwUQ7awC/X7zjZ8lB5KmisvwAneTNRIA8Wf2
 QyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783487764; x=1784092564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnE3EHzcAAB3wOGkpHX7qlXo6YZQIie9HvI/CCy0uxg=;
 b=LfOxzKpXRtrNu4I0wKOddqvCeYmVcwCDFiF53eWylYfSgu1/YCgoc2OrUOh+hl9WCm
 70M/xswKspAYHKiSg+Mfn8+LOUvGeTFjdEiwYaOrNTbAyVtwxdP5Gb76wLSH+oPx/j54
 hkouWyV7cxNeQhB+kfETuPvkb+lg9FE3bEjxiUlJCsYOc3f3bef26S/SjrYHFP0s2hl+
 c7pwj87bYmUh2ylLSxL6RySF6ebdJ6IzEQ9iJ0F4zHnTuYx0iK31CWxvi7tSgT1Yn+vM
 cC/tK9PhV3bVKuIyeyNs81DxpfOIGHj5QF/Y12l9N/LfjvqpsD+YbkZO7vFlOwpBVVWg
 Zw8A==
X-Gm-Message-State: AOJu0YygtJitLnpC6eiQzgTRgAIvJOktIGfRPDq9nhflG+gUTQGupr5p
 sIj6lWhGij9IVeTD4jEFHi9k4MOj/0ukmC6vopu+fF6/Qum4KzXUgoDuaiWTjQxgwO6uE7kNtZA
 rTUGYFtaHPRozAaIeGUYzJRWPEtjyaIJG+hPEOHk8pWRnzIdCtGZ/5vgB2A==
X-Gm-Gg: AfdE7ck6p4LLj/mL5bPXBeccYxx8tQthgWqeFjYIZKHbF00371qYnQx0gzJwZLV8xdj
 wRkAO03TMRWoxdK0v1fqCu/sc8L8kADUIL+zxUhOEx5GtdnDtikVK3VGy14NfW0KVJMrK0K6qg5
 TeshwtJ6GeWCD100T5grVtPTWIKWA9MCbc+7N6TZAaJAEX13RNeObt4QwFbdb1r5I9jbcXdjiXp
 UMPLCBgS2jVzV2Lx0Xx1Tj41x35qCWItJvsyFqTIH9CMLlMZcGsu9o46ZYxxR0PsbAYrGWNfQT3
 QP6EGNJSQqXz1kXHBlNZkmJ/Z4kD6N4DQEHajGgjWgrZtGK89VgfMW0y4vFCee2OrAx/zk8RyQ1
 5pyYsDC8nyeYytRoCKJ4YZ0eJ9qc5/vvxumNPcSdJgKbE1CY75rKP/LWrxvhPWg==
X-Received: by 2002:ac8:5750:0:b0:51c:7b12:5fe4 with SMTP id
 d75a77b69052e-51c8b4279f0mr11553131cf.80.1783487763976; 
 Tue, 07 Jul 2026 22:16:03 -0700 (PDT)
X-Received: by 2002:ac8:5750:0:b0:51c:7b12:5fe4 with SMTP id
 d75a77b69052e-51c8b4279f0mr11552911cf.80.1783487763595; 
 Tue, 07 Jul 2026 22:16:03 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f3676dsm113995715e9.5.2026.07.07.22.16.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 22:16:02 -0700 (PDT)
Message-ID: <d14eec9b-d6d5-46fb-b808-e59dee5f8c7f@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 07:16:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 23/25] docs/interop/firmware.json: Add arm-rme firmware
 feature
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-24-mathieu.poirier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707224306.1202330-24-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uQCOy-bnBCM3lTqhr57DKMdfQ9EKJWmj
X-Authority-Analysis: v=2.4 cv=CviPtH4D c=1 sm=1 tr=0 ts=6a4ddd14 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=GSV3El1kC2elkkDfeLwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: uQCOy-bnBCM3lTqhr57DKMdfQ9EKJWmj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0NyBTYWx0ZWRfX7hyOlHPwiovq
 P4Txm2Nbt8tlcEebsnemfwlx4suqF5Hq0cJG0nLoIiU+aKYteWNGBF8vBWy8/+cvfrkMln07JDh
 JJiEzPhABqKnVc20453SkXNSR8PYHfY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0NyBTYWx0ZWRfXzC+at+pSj6ZC
 aFbaS7F9daI640V/4N3AFotT9Xi5JM89X34y7qJ7lVcAvgaFeGaw1JL827HPw6nNsjSyFQEPGNP
 eaixfgeZp9YBQFYCCA+5t2c91cMdV9T2fLYAiMyq3ZMAsDWl2JsBIBcJLHRu0VP0M6RWTbdzTCx
 o6N2OP8hRgJqyinX50FGlGaoIajDr5zPD4LgoJqDZzhAj8qVuERK0+jyQqZj1ytE/Vn7U9sfkPM
 +AYcm+G0mZgTc5d/MsXFXetE+KyCKst/IZSknKQ5wGQCU1ZuumhTiBZzQFBzeoOtAEaQELjbOr/
 uanbD9PkxIQmDAUNRn1J9jdQ0tJVUzq1PjVSL0Mn4qrY3YuPUnsavGiiGUQ2BSoZ3+Co85C0Ahk
 0+rZb2X9pNVPeifcjzILP72hzIn9s5rjDmig4xpJ8Y3OuQnivtzFPYdj+4igq92B53jijDiqL7H
 VPQwbbNRPTsq2J4qUhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080047
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

On 8/7/26 00:43, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Some distributions provide packages continaing firmware to be run under
> QEMU, such as "qemu-efi-aarch64" or "edk2-aarch64". Those packages also
> contain descriptors in /usr/share/qemu/firmware/*.json listing the
> firmware features, so that environments like libvirt can figure out
> which firmware they can load.
> 
> Define an optional feature for arm64 firmware to indicate that a
> firmware supports running in a Realm. Firmware implementations need
> extra support for running in a Realm, in particular to distinguish
> shared from private guest memory.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   docs/interop/firmware.json | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

