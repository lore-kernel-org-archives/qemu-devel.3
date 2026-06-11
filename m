Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C91CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdbc-0008FG-W9; Thu, 11 Jun 2026 07:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdbb-0008Ez-1M
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:29:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdbZ-0004LA-IU
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:29:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BA1pUO271455
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BVGn3MLJQ6CTglzIUYSQn092miyr5ZXKx/+PkiSPyaE=; b=TENzF9OfUMpjzTWK
 qIMIWbRVWFd0MHJ84jZBJfyxTP4x1w3Fkih5WIOr9PxrIJEA9Rb7I0TJYx0rkfOO
 CT258prd4u3o/NfsGYSUUhirXQBvqCpI0O8Ez3UVx9Sc/eQw5Iib4IG5x1OrGghX
 zVY4/kf7PEahffc4H8jfP09bPj6D+82O8OW0ntVDLF8WSetCl/fnB1Syn6ZbiPq1
 faXMyWjVTYAZqLbwEGd82JlZuu25TaA9+uFlkTJeMKHo0Q1+aYXTN2BLddTYmyIx
 4Tp8XJ7qp6F+ttwE4toPFhwa9CAYrc0cgj9QBiXDQn2oqAmAD4mjh8yc6tmiwvp3
 otZPVQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe71k8cu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:29:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51768072950so107466771cf.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781177387; x=1781782187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BVGn3MLJQ6CTglzIUYSQn092miyr5ZXKx/+PkiSPyaE=;
 b=H2BW3Eq/3s6jjng5jm2QE1afv9b1FElOEIznPXRBensKCrSqsExJlhGGWVTQC0LoFl
 hbe75T8KjvcRnC4N0FfQOYV1Bi6DwhA/RjR32QMv57r5ZuKjtAFGF+UZ0Qtuvvjqmnc2
 xwhuWrHt3vP4okeGkOJ0tBjL4RbFmxAbfDOeO1qdsVcNRP3Syv6ay8sa3TFFbzMT5Qf2
 tzzSa3Yvu91pNW2am/eSeDmZ3ZfKykJbyg15rhSfixUU6PctdZjUhzi3sX6PywWNoDkz
 B8vRQJtjtqxn7RNwTWRldEJfdgVb/WAg3icZ7wOYN4lhAKjPKhZBOGjem2HVrZE1QigC
 oV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781177387; x=1781782187;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BVGn3MLJQ6CTglzIUYSQn092miyr5ZXKx/+PkiSPyaE=;
 b=iHqvNd7HLj5vtXypgBiHTBlPzjOBBQCDW0IPQqKK7C/hC+sKrn4stXlzJlv/gOB2C+
 VvkJdkUFWcKbVDVBcEfrQBw0QQiXmXpCuYdzKT/QW9LE2rzW1+1YY6nb+XEKpd1dbRSv
 hPbL/RZHBDWdLZETiENEDOV++YBHl8m9MxaAr1mdopTrUzmu4xKVhXob2B92KYfgoY8S
 RMkpjEhEszQbCOqRDL/TISJZNXLMGGM5/WOJaII/o9xrjsyn5G7sG7d8iDOHdIelkdEM
 QnmTdQykO3JJatevsgsi/qfS7Ubtjpsq/qhIQ0Mkh7Fr8BQ8e6op9wEdMcPW0eXwRdGt
 hrcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jqCK7kSBJT2qxwgGnQFRVbv46jyHE/zhzv1LEsRqpnsSAhMfnPxUtEXLhpBh/gX5MqCfA0NK5jlDH@nongnu.org
X-Gm-Message-State: AOJu0YxVsP89O/tKnxLDdtQLIjqZpxpq6S7YF4v6dWFBvuc9DrjbAd61
 R5Nv7+Ny2f1ag1cRw/Mixz73111YU+FwzbbLN2HZo01nu31UE86ZboLZpJEaLAU81xe2zKPr0Ro
 3xbSyd0UuV8ZloSiwjeej8Oed2s9Kq/HCvtbgv+Iv9LyB5MYEfdYn2TZLSQ==
X-Gm-Gg: Acq92OFFAqabac136vaMVqRJjNohhHa9TLs9VShX+cDg2f/0uPU09O6CV5h5/Tyxg1b
 /izx36It7uU8B/7YtDq7v+KzWbSUH6ETqYiQxvvnUwx3mI4zOjatcfahYTGZfNSq23DkLAly6Pq
 tEDB8V7C07hgAByWzp6fgza+pZCHJBRRL7srwJYKVIE8joNY6NxBWp13hPZvqZ8/0pudvI61p0h
 MFDmOSGxY+sEWntOS7yPblPI70qs0kQriPjoEuqOLrFZs2zc3isAMUwnur5w32vNQDhvsPQzV+R
 TZ3b+Qh/rZAZ3Qz5qXZMFzOb1JlIp6wm8shCPeecrcZybOZjZA5svo5vCktVpkZFBLtjwzBRgH5
 4ULac9qlFKUi05SG228cSE7vsYNLj+O+N67a/yHt0S/gvjESF0MYwZ3B1FzNgnjPV7HvVeqcJk/
 2QU5KhtcWKVlkN
X-Received: by 2002:a05:622a:4a87:b0:517:b855:b8db with SMTP id
 d75a77b69052e-517ee2141eamr39718161cf.42.1781177387338; 
 Thu, 11 Jun 2026 04:29:47 -0700 (PDT)
X-Received: by 2002:a05:622a:4a87:b0:517:b855:b8db with SMTP id
 d75a77b69052e-517ee2141eamr39717541cf.42.1781177386810; 
 Thu, 11 Jun 2026 04:29:46 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfcb1de6bbfsm52740066b.28.2026.06.11.04.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 04:29:45 -0700 (PDT)
Message-ID: <59406166-eea8-422f-b94b-622fa578b69b@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 13:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/22] ui/input: add LED state tracking to
 QemuInputHandlerState
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
 <20260610-ui-input-v2-9-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-9-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7pkaR38DAEX53oq2yiTSbQQey2kkv-b-
X-Proofpoint-GUID: 7pkaR38DAEX53oq2yiTSbQQey2kkv-b-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNSBTYWx0ZWRfX36IbylFdDtKo
 +v7vnVEOzDEqhr1srw66iVRLchqvxsGaFRufuN+73+EfK3n36p1HqeDhNfaAFUYME0WBDCvWWlx
 phOcOFNYep92AZckM58fepHfX/K3eWAmwG/yYszJLVBbZEVljkUxjQCgkEuvMHUEQToiXelIs60
 hzvu+ee8P+KEVNiKsm2lsGt5xWzKNMnl36RgqjyV1OatPCi8stDsluhnACxmIpyqoQRM+Nli+D/
 zSjlQUbp3f9+gm7lMaDsXOOMJbe77RvhCZ0d29CDTZWMqP9Fyt/qTP+vFOVngOsDRHQJEqT20ro
 OGMbDi/NsEQ/EcdCzWhfJWTOkFp3gi7oNQEbqFaS9ZC7Jtg1Ic4ebds8ihIM4+eEHgE9C9lGOtp
 pL1lZ533ZLLraLTc8Y3CK6Ood79jjiH7hbQB8CxG9ue5fKnqibEc1naFtsUlPKl1JkQ7o+klw8b
 MioOIFkT5V2Hn8DmylA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNSBTYWx0ZWRfX0yg0474LFgj0
 Xg6QHlc+6nuLWaOYKKv1fwDvCyialLzVfNvmttNhDry64+xcr48DaB443B3xdEgJ7fEHmkE5756
 kzqQIrML1Y/KrXw2lm5l4ZO4282PUs4=
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a2a9c2c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=Q-Kv7vJzgq53HO2jYf0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110115
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

On 10/6/26 12:56, Marc-AndrÃ© Lureau wrote:
> Add per-handler LED state and a NotifierList for UI backends to
> subscribe to LED changes.
> 
> Devices call qemu_input_handler_set_led() to store their LED state and
> notify backends. Notify also on focus change, or list update.
> 
> Note: I considered conflating mouse-mode & led-state changes, but those
> are quite different events (from different source kinds etc) and we may
> want to improve the internal implementation.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/input.h |  5 +++++
>   ui/input.c         | 49 +++++++++++++++++++++++++++++++++++++++++++++----
>   2 files changed, 50 insertions(+), 4 deletions(-)


> +int qemu_input_get_led(QemuConsole *con)
> +{
> +    QemuInputHandlerState *s;
> +
> +    s = qemu_input_find_handler(INPUT_EVENT_MASK_KEY, con);

Hmm can @con be NULL?

In SPICE (patch 20) you do:

     int ledstate = qemu_input_get_led(NULL);

> +    if (s) {
> +        return s->ledstate;
> +    }
> +    return 0;
> +}


