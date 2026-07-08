Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF2CC43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 05:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whKcM-00005b-0K; Wed, 08 Jul 2026 01:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whKcF-0008Ue-6e
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 01:14:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whKcB-0006f5-Bp
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 01:14:33 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66842hZI1695963
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 05:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n5w/YIhHfcHwt8m85sXZA9WE7xPsjBhvL2VklZJk6Yg=; b=JntHqjhnocNUi16o
 oTyrpJoMakfOX7/Hh0gYKmi6e8PrO6/L0iwG/8nzHxlSWAsaulWqYh+R0/svFbvO
 tA+CJr8yN4z0yRnN9SK4XZs6hZKTiGEr5xkWR4i2u+2Y8wtVf715gAfQ99Y4xGiM
 1ZMqMQ68WMAVmV0bY9wP0PPAqrDUrtJcFY2ZMZNzuYQhh89skIhjNpwHxOgJ+dSJ
 UN85/MghcOmCYuuQqgNraNqFIDl35sP8ZsWs8MUuvS64wRRIczN58PSwbtlxnmyw
 j2Ah+jrbe5Tsp7Lda2U4dn36QB/cxrAz1isLLp/K3+ACEW9uvNKfHdFEud+6BmQ3
 /0L3Xg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9csw8qj7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 05:14:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c33f48ee4so3112441cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 22:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783487667; x=1784092467; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n5w/YIhHfcHwt8m85sXZA9WE7xPsjBhvL2VklZJk6Yg=;
 b=WQ70d7xqkzOXAJuCWwHD9mjHux9WJ9r4bZyQdf3sdW59VR08kqpfjCHABkuklRBbDE
 73ltcg7y5eFzqsC4eBJxYPj7wuLCcP2xLKBY0/gR6uGxghuhBs1zkNVOfg//nOnNmTDJ
 /bH9b8n6JTpqCy3+w76on6T+8tyUPDXiQECPxXjyovL/Zh5smT+YJL5vAcNaBDCQQ2BA
 0iKa3tWVAC5xcwkFH+gPA9bzNDJOuIo1xpvRtw7YsiewIQNv3wY2EWKd3DzLm5rGaTr4
 1PaUYE2ryjvuAgPaWcq2VU4uhix3PuNu9IN5facDRqvbIWpnmK+1szEVYVdkfTXULM2b
 lqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783487667; x=1784092467;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n5w/YIhHfcHwt8m85sXZA9WE7xPsjBhvL2VklZJk6Yg=;
 b=BpyHwqF5uiKRy2i9hI/VCQkKut2vpFVKhgB/Q9DiPK8bejDaJPFUl6+1SfkAhPLmRa
 4oOeIBk8mCjvfQtTVHLzM6l3KO1tGMN/eGdc+cJki3eT7HUpzEG+QxUPyfMsqwr4fA8S
 K0NqDJkRhzytlX5YXqPh5HV2kQI6aUqzRk1EJfEYCll8GnQ1BeO2Nt2DW9NykcK/jEdn
 0R2XRzgsH/EWHIr6jPfcZa1LhwN1wOQyJT1CiGDq7ptBwK5+zeb6YCmEJGYBVH5wO9zg
 Dci3JHlWjHRj49ReEncxiRWOThB+yx7i30+2Gkag0aDcAWgo0GyaZ9+f2+0mmvNURcfE
 yQCA==
X-Gm-Message-State: AOJu0YxPxYWmP2v216y0DTdFN11jVaHJOnBqAr3CzIfYYYfOzzcb6PkM
 T9praj3/qR11trJXsSlcHn5x7cnp/pFhL9AeUmOTLjf3lCnXLM/H8B+wHUXHK7dDjI1zI1KBAUg
 /hNG2nY21Yi+bg/T1pfjM0X9YYaxpxVWZ6a+ABGQCwXNCXar8EaVFLxtYzQ==
X-Gm-Gg: AfdE7cnVqjIUx2scykhcgIkNSVmy/bk1dImwYLJanO9mU/o6e6hNwNgzjra9Ik04iXO
 4PD4FjUx/qQTtQ8Z3oVXIWhcK7f56MyNiiR66XfforodCoQzY//6r8o+Bs88nOBPFfkp36akQLC
 4mpyNxYK25jQ2vplwgYO93lzDbdyk5TEw90b0p78ZlOXrzduQXr7syWzxcnA7qofjLozRcY0qpS
 Rev0ITuuwv2qfW+ZuXkvtxTEhZlwpJ2gfD9jPWh0PyKt1xBqC4H38Psf+Q6YIGertIqAIVe+nJE
 O3xGsuDbJhLzJXhAqjO9UfukcryVc6Dc3RaGT3CioDOF6Pv4tEyLxBnztEZzqTWm6lEz9rt0Z9q
 EvKLHpkZ6wvoiLvVgC8hsfSpSH4lbc7oEDnXKqvoGGxEu2hnwBAzsVe6BvGXtZQ==
X-Received: by 2002:a05:622a:1a92:b0:51c:14b1:8e1f with SMTP id
 d75a77b69052e-51c8b4307cbmr10548271cf.21.1783487667104; 
 Tue, 07 Jul 2026 22:14:27 -0700 (PDT)
X-Received: by 2002:a05:622a:1a92:b0:51c:14b1:8e1f with SMTP id
 d75a77b69052e-51c8b4307cbmr10547911cf.21.1783487666654; 
 Tue, 07 Jul 2026 22:14:26 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e549e56asm32807885e9.0.2026.07.07.22.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 22:14:25 -0700 (PDT)
Message-ID: <3cb18f9f-37d2-4e13-9333-65e5a65677db@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 07:14:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 20/25] hw/arm/virt: Move virt_flash_create() to
 machvirt_init()
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-21-mathieu.poirier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707224306.1202330-21-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xPUuQ-YGJgs4362pccjwDliT-C9JdSFf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0NyBTYWx0ZWRfX8eYaQaWSJJjM
 ycoyOvwV3JvA7kZcAaTSUBIvbXxMUJ+eUpzlSjqfEPi1aKvc0jylzi6i9nFGM6BkU8tC3suAzEm
 d+xP3nhz1kxqVzziVrJfGo05pttTQJU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0NyBTYWx0ZWRfXxKxj34DMqTUI
 Uj/OzUUtxsEo8+mHpXy+xcwddO0IH9FepKkxdei7GLXiZgSftIkrMreqouS4IsfmBIChr2D7PLv
 bYlaLamu6m/lwbcZUQoZZ7DRdtg35Hx+e8rmiOcXR/b7EVBlo6I1BMyBcSGSsffHttAMN1RF3TB
 NVDgeRDRVJvY61XAazzJINe/Kn0+rSmBzLndT7waeOmYJs5QjpkIIIKnXumkvYkSMAKUMAcOvxM
 IIYzNPD5Y0VwQHcgxM47mFuXjk0N37iEqk347+OWaXJlsPeqFjTsZsy1dVZ/f8CU3lQq76wVLSS
 6/QfCKADU9TuHv3kZhxgefJJbJOIFD7OyEW5lEbQb1dImUsxBSupG2GYJ8JlJJPkxpkgmcfnT2o
 JnVQpuEXZv2YZAOORV7uTm44dPuW9lnj3aOflhDm4YT1rPCV1p3Osam5P+hcN4o64YNKblWvn6D
 +sh/H4DA1NzoyZGSwNg==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4ddcb4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xPUuQ-YGJgs4362pccjwDliT-C9JdSFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080047
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 8/7/26 00:43, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> For confidential VMs we'll want to skip flash device creation.
> Unfortunately, in virt_instance_init() the machine->cgs member has not
> yet been initialized, so we cannot check whether confidential guest is
> enabled. Move virt_flash_create() to machvirt_init(), where we can
> access the machine->cgs member.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   hw/arm/virt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

