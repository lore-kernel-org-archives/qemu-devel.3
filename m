Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B32ACD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXHQ3-0000W7-FZ; Wed, 10 Jun 2026 07:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXHQ1-0000Uj-DN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:48:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXHPz-0002UZ-VQ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:48:25 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ABNYtS1501693
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l1HDAyCraZCL/zomXNuh3QGISgSC51ES1ApewdkIS+4=; b=n/hLBreIPFygrAMz
 JHkQHSQ0b2SxI5CLIHoUvhVO3E67gc+UwxDnQi3DOzz4UlHn/tXZZnYaJXGnzbfN
 5LPQgSmnxgjLs1w6E0+yGd8tj+Yzhc40Jp/1W3ViNCM9Et/D3vhQzlem4AYsYufh
 8rggjWTPwZaoOVY3l4ZKhvqwwT5hQ0jWZsRvOLuOjTOlTlATff7eMNJrUDSD8nOH
 m2v69xdawnBPNn0TIMsJMWi9PVboEpfizA4D7xEN1E+IKJWEvuAsPdvL0d/2fIlm
 4kgDB/hEpCjxW0SemTGsWm1aQzOnXOzscroqRiGzAGp5WvwSIhiKt0qim7yy4UNx
 nLLjHA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq10a9m8u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:48:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-517878a92c5so147233641cf.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781092102; x=1781696902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l1HDAyCraZCL/zomXNuh3QGISgSC51ES1ApewdkIS+4=;
 b=RVMnF3jCaRpqN3lSOMreXlnLDzYjDk+TZJ8yGS910h/73UrYJNKZfU54QoSIRCUn9K
 2nHSUXifRo/vof3v42JIalXhpvMO26h4zgMKfNV9BV0iwRMBjaQ257CAyhAguAcsHKxb
 3LQjM06kXU2uqkjcyO3S1JE/zqAD13T3IWL+LygzU2Sjk/PzL+FgewJhpNAcz+qm+NqO
 0yrr6kZkmwi+Csn2MnbGKduIqth10ZNBmQl4kYryXw/R2rhyza7O+2+Cl5ZrOwIs0LOt
 LwuHnwhYFzpZ5ySuUUnBikFyym1PqavBlGfvsI4Z9AJ+lhYjBx7gTNbRfKVRF9XEFYbr
 AQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781092102; x=1781696902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l1HDAyCraZCL/zomXNuh3QGISgSC51ES1ApewdkIS+4=;
 b=hr2scsmK+Gd55W7gDw7DntgX4llG1JwR9fDMe1gLoClhudaSewwQj+hb0vrkxrCB4Z
 aUhIIvt2OHY1jDI71B6bkLtBVsY/lYumJJdtxOvvFIXH8nq3E9MjRpH4esaCpK8zRAvb
 MM+HcKoHu43lJbelGo8joYLQU8yj/SsA8taAeSzHDOGXgVyMqhEu/9pngoK2OwcS3dNd
 6NU4A70SvEex6Hk7N3we9q0bOTW2Z0VwuFqHEa/MnhGoxFGTZBgLXFP+uAcRIFjfWATG
 p2MYaB7mcQpwggMnZ9NFb0GJ5COK2PhzE3xw7efcU6MKuxrj1vSMgaouNyEi4FAU/9aG
 Ym/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pgWP10xLuXV7NcdzSPtywCTM2TIVmTzO/g2F6X1ua503haRHduY4agXyJsIanVfWmeP6ov7JSPrVc@nongnu.org
X-Gm-Message-State: AOJu0YyfOMZuJD1MzW093EywDj/uSl9lrX5WdglEkY0V426M/edGGVw0
 ma359IJGT7FnWNYljaVWUnUHXuxzKyg1Lqp1dIgIinklZaPWI6q4Wr3wX9vCNO9L7+bEwThh8dS
 hFS+nmOv/R4KNHt0/6ojtqsZLy8tun0fDq12+PcxCNBR2UZ23qUcZYUVa+sxF+hhlWhUE
X-Gm-Gg: Acq92OEcDZjInxM4g3q/jvtpT3JzcNQinM40VwfhUalh077xz7szuAxrXIlifQc66AK
 IKqbK/7NTXMCjyyXf6RI7WFkPoKCiLigaR9Jul8CwsYQnWh/nq4bHSk4G94iWiqVE4slzZe8n6w
 eGuyrkO7aivlY787yUomm4eOjpP7Ap1QaAPkQ1ufL+2gvFgXAII6JGMW9rwwSVXWqQMpycSHyNW
 q3yAfnCnBLRUP89fFAPZ9JKv1h2wp4ezi/e05xZ6xNhpAdIpkQhSGtn0iZfpPb3P9+lBKHuiLCU
 0IKeYXy4b+4DsEmy5t/cTmi+rMUxHEjPhxozfETsIrGYsoD9iJCHO+liIP7sJzw2YtO4eL6RF+Y
 DDoruuGTtidigGC6MxSdenBpzMi+dnSgH36qKwRJsi7sPsqYkxxiubRYFv06t6yVBW5uM+PKgaJ
 SmoRo=
X-Received: by 2002:a05:622a:1c0c:b0:517:75d8:b956 with SMTP id
 d75a77b69052e-51795c55dfdmr371551751cf.40.1781092102426; 
 Wed, 10 Jun 2026 04:48:22 -0700 (PDT)
X-Received: by 2002:a05:622a:1c0c:b0:517:75d8:b956 with SMTP id
 d75a77b69052e-51795c55dfdmr371551301cf.40.1781092101893; 
 Wed, 10 Jun 2026 04:48:21 -0700 (PDT)
Received: from [10.156.84.244] (49.170.88.92.rev.sfr.net. [92.88.170.49])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65867e67sm9811421a12.21.2026.06.10.04.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 04:48:20 -0700 (PDT)
Message-ID: <b62c382d-60e9-40ed-a139-e31225fd1373@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 13:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/22] ui/input: qemu_input_handler_register to warn
 for unused result
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
 <20260610-ui-input-v2-15-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-15-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GoFyPE1C c=1 sm=1 tr=0 ts=6a294f07 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=YLXAUxGLE6hMr2F5uSHVqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=w4eN5qVpwKaXhsX_QJsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: hfI_sPhmkkqe6Kd8uw2FqvfrQbFuqffW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExMyBTYWx0ZWRfXzdZRoJU0I4tF
 cFqi9cc0Rn/o1rVDjsT5OqtggQLQhYJ6nhZILJep4KALU7lXVbhVmJzci8HZe9g3lVKj9fcMg78
 Wz69coYPRlQ4Be4mtXzyt4zRsrLuH8d5SGuhKnz5ka9TqSrXRMIitD8GfYGbn3VIRzYvD08QvJW
 AtzMYb9j4Tfc9N1rJfyEgo4Rek0u/zQuDwBPP+r1XSw0yN3NqReiaiRMwu3FhgP8fqS0ySMZUAM
 q2NArZteDL19XcAOW3pQL7L6G+gRG3944B3WZNJ9cZ/ldimWCs4q4JS/W7zBAnZbArY6JYN8jOs
 1s9DvukE+tV+NiIZua8FxBh3IV+14MdTwgHj1q/2ic3KHYKfYs8kAyuZhqEDOdCsAYr9xKwmgBv
 uIvs1NIBYdUKujiaYpYN4A6gS0Dxf0kLL3+m6vA5QB/c4c8KEmNzgOE1ffUMQpLiBL3OL6RvsQU
 wW/K3rn3b+nKHGnemXQ==
X-Proofpoint-GUID: hfI_sPhmkkqe6Kd8uw2FqvfrQbFuqffW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100113
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

On 10/6/26 12:56, Marc-André Lureau wrote:
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/input.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

