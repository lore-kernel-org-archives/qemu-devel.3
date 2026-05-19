Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2C1CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLUs-00024t-Kt; Tue, 19 May 2026 10:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLUo-0001uP-3n
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:32:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLUm-0004jW-PT
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:32:33 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JA3CuX1393139
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ood8GcwLjGnwwi2ET6k7a7dsQJryd/6uYIGMklTmYTI=; b=VS3/U8DoKyerXFec
 uVIrwCL77wDzcC5d2zM9CQZeafAKaAUqcJ/YhQiFF+a4eQlOsur41AWvdmkVQ7sW
 /L5daG0AQ1oneqQ/pUpB8AM7RN4nZGeGvtUmAzhiv7XBMMH2B4KIjjU6WbT0NFo1
 lVqWzKnHrIzLr8TTbP+8jgA4UWJula+lwK/51AI3Y/NTB8/Pkidhax3bVDLKzCCz
 7TF9Oe7p8snAMZ6QukZaUCTzk3+V5itQ32YxAXrSrpYv/RSLjiK6VeGDOiTvv2db
 8W4uxpQlNHS2DqDAtwGVOM8Z0mFS/dCnjyRGKJRm2HUFxDUNNJ7oRdknbMxvI4OD
 oiA3kw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ns492b3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:32:30 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1353ac304f3so6347905c88.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779201150; x=1779805950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ood8GcwLjGnwwi2ET6k7a7dsQJryd/6uYIGMklTmYTI=;
 b=E7sz0tZa6x3gD6D9Lo1KUaYEtmKEApTh8pqIhoZUaMC62FSJmMFVqy3MCTl5ikxxOd
 H3g/PNGXA/FQLGo3Fc4MhT6TdMxYIz5nyu//8w/PQ9UuoS2jucsRmo1VJ2wipG9BVqdF
 ZEA1ELAZ2dbNCTkTeTMI3NlblJfKg1hCvX9Q8yiZp0RabF5AQdZgmX4us32oDfckr1k6
 GFsLSdcKDI1yeuHAQPNsCFHSPoYwgPWNSwkj3p56JBBsASZeK3IpHP3kKucQiqEZq6WJ
 yzYYUxxkJ4KUjaRVNe9DAToBuaeg/in2yg+knReXveK2MApb6G0obBXuMWAeqj62NFFj
 A4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201150; x=1779805950;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ood8GcwLjGnwwi2ET6k7a7dsQJryd/6uYIGMklTmYTI=;
 b=jJEoX3lA7ikAwb3TTBgMLnGEZMk8srr/S3/rQApqFk5n8OWI6ipQRxh8F5uGuJq581
 rjoJGilkWONKY/3GAv75CL3NwROqO0BQspEtAcnTpWJaSbyqAlml17oGS965HVLRLZys
 ZS/eg61OmdKTWvD+0AKftVv/l2vhX1pPClAsAbbcK2gK1DN3hNmhjMvEWP64sSwmTfKb
 XR/XRISNXLOQO3+j89MKfeeSkjpBQkdrOH8bEPqMCjrT29UojsF6v4HHrlb9jXpBxouq
 bFnYWfhigFd5wxyxIJJcBysa2RyTVBlFpEKaeLIzSLE+LEDTvtkcyqSHFdn32kkD6t3H
 uMUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QZcLMqT8uukq19GRHcvXuNn9Q0ggZzKtL58KGUOODrUqijgIUA7HHhebFbiNMfz9oMktQm3GXIuuY@nongnu.org
X-Gm-Message-State: AOJu0YzWb9r+XK9/MnF39ibzaWkPVWolu9jXp8xW80mGYmPhFb4qhPB4
 +Pi1dWuHbYGJeJmF/HlImUDfA/xlUktT6LHb9lZ0NcO5oNvTvqvNlLtjo7MrUts/OeNnb2R/ADD
 QHY6tpqFmRZ6LXuH8DK+l/UagFxlvgW2YEarSeC09I+sBxlbTIkX+ReE00g==
X-Gm-Gg: Acq92OFQVKB3wBZBmK4QoawcpufBcKk8+ictoxeQnkRXc+/igd2NOV/Re1gPDInQ72l
 0VNP/MwPTEt563TYPlLWMuz9M8xFpLaN9cl42++s6xlKwBAjCGg97eZKjX9xJGKFHrhbk40UcAU
 BVdK3BOsRjJIa9D4qLCka7EPg63JcUnzblTDvdxikDPNTZRTXs8E122gXDLUmEtGK96cYBRfZ4C
 ZweH+kQIlAluQ8isLlSCnBLupvS69V1/hYCCwEPsISFv47j+mw0PCoQ7qGyU6B2I4n1w/i8lXK7
 GiccgV2p3RYN16dttHIajs9fWWtWZyTpr/y72UYRJResUAapH52aM/0S+Ny95Pj83CuYurBo4oJ
 F/822O9OuXOCaVvrLsR0qnvd8TNVd/ZFGRCsg7/fftSVqBlzUhGW7XD8=
X-Received: by 2002:a05:7022:6621:b0:130:73ed:215 with SMTP id
 a92af1059eb24-1350451b48bmr7215932c88.16.1779201149542; 
 Tue, 19 May 2026 07:32:29 -0700 (PDT)
X-Received: by 2002:a05:7022:6621:b0:130:73ed:215 with SMTP id
 a92af1059eb24-1350451b48bmr7215905c88.16.1779201148956; 
 Tue, 19 May 2026 07:32:28 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc2352f2sm23167219c88.10.2026.05.19.07.32.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 07:32:28 -0700 (PDT)
Message-ID: <541b933d-73ee-44ff-ae7c-9956d970c2e0@oss.qualcomm.com>
Date: Tue, 19 May 2026 09:32:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] MAINTAINERS: Cover python.docker with Python library
 section
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260518102222.80735-1-philmd@linaro.org>
 <20260518102222.80735-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518102222.80735-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MyBTYWx0ZWRfXxwp+F7/OZ/5d
 sO+BxXyyA6PBC2SLokbKG28pyxU2/kwz/EmngDs7rN7/KjmoO8m9QMb7mXxDO9NPZkeqsVKF5KU
 Z2ec5JIuuwVdg5qZiLQU/qWkpMuFpa/YLVWnnTe9rD/0MTdJugqTX0i2XnXSjjSTQVJXCNjHujl
 uLgKavQtTTguN6Gu+QdMZHZYsprBebuLnQd7HsRL9gzMbE7DSsQOvrCYzKggMozpQFkEZGBDehX
 b+6YDWDXURnIAMBW4kaZDy9ZJLllqroZnS4VN9unZE/38h9BCKao9JYbkYpUd7j7x+QFujxA+hY
 HmFUBz+rMa8KBZT7piSb2oZShie9iWHiP+eVxKq6n439c48+Z7M0UtHUMVAccmdblALph/soPUO
 VKKxYSGahHFDR3alSrdf/kh8tfm9TZsQmO6iJh3HxVhNocig+HWptKMvqmBvDVO8VQvkSgazbwP
 O+kcWsq4k0kJzDiPZjg==
X-Authority-Analysis: v=2.4 cv=F6dnsKhN c=1 sm=1 tr=0 ts=6a0c747e cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=sVkyF8UQa54zSR0tF_gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OtGS-68oIGAA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Or6eGfALcFtzjEzm1964A3V1kxihkobM
X-Proofpoint-ORIG-GUID: Or6eGfALcFtzjEzm1964A3V1kxihkobM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190143
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/18/2026 5:22 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Cc: John Snow <jsnow@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

