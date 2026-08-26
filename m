Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9634C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD4d-0005Ts-CI; Wed, 26 Aug 2026 08:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzD4Z-0005TW-Dx
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:49:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzD4W-00018g-KE
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:49:43 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCBkNH1909143
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 12:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 duw8JrUCNyl2/roGy6RX/cNGxLeZ2QlTFOJb3gQdShY=; b=ZjZh+AE//7/Rwq0i
 zeWL7GOCl0VZR5UjKrdbcoYL/8/zZ38j/V+oTBMksmfPy7KJBHplzXMim0pT0zJo
 79SXwRqYgtN7IQDYKsSOT0KsfPVaRA8Y1fCb75Bw+wRMJQDZU2LctQ2kBFM1QT7d
 5J01rB/0yTzcvZVNjxy/U4gCGNPeQ6AhN+/BIqJZSSmdvhpcXOUHM0oQdOspc2tH
 lwGhmfX7nm+fCfGLBRd4MXZsmk9jtmAq4uV3iIMhd39FxrIZc4ywPDnC9jYBNfG/
 716koE91ohO/BRnEgj0glaAM+ZJ3qFmThXB1tAaFoM6tCyww39ZSeg4U2+STEHQD
 2te7dg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uq1s9wd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 12:49:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52f9f6b85cbso23421cf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 05:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787748577; x=1788353377; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=duw8JrUCNyl2/roGy6RX/cNGxLeZ2QlTFOJb3gQdShY=;
 b=akc4ZxR0qRCPynMvs0ISrB08V1DE0k6SCxqcXfueTtcNHyXQBzd4hQ7BxeXlaFgd6W
 tQtZ4FNAO7smz4D/NKCCu6HPf+q1Q9fXbBeiLaMYJGBGqvAK3VlZ5Zk/ZDMWjpthEW5u
 6bmhvpmX9VZp+pTTBv7UFb/HtR+3wAoT9tiJHPDNiVJ8cLCwly/XW5WaL7kW7H3GDqC0
 3pUfRUWJW/nx0bBros50DpOVbDVgSlbwm8k/u07rQL8HnovpFDlPaduR9m6r29qcOx8q
 tsflUpka7vY2P4erTTQT/O4qoTeurnajo6kRHFwdubIahUv23vi314KTRTjfaf7WXRlx
 ae3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787748577; x=1788353377;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=duw8JrUCNyl2/roGy6RX/cNGxLeZ2QlTFOJb3gQdShY=;
 b=YtcxWZD5EtPzvZdN6mBUdnDs9bzu3YjCbcLJ4SSbVUB/LCgJDRjhwI4h5YaPHL/zTe
 MzyULKYr0rQdiDRzyE4G9z6KM3wqNMyHLE5ZVWtFJEnVGI2m+OPMyYc2LEsfU+MSwtMI
 WbFD7hLxFxlBHcfTmbjOtYwLRePgMA0eTpRKdrxapyoxz1iW6Pan63B1YImmH6NVcifw
 vFgni2PqocsqQ/h9qTzs9d3icISBdSZC/DhydAWdzzHue86WMKT0OyrAY+Qf9hCvypU7
 YPi8iVKprFiS/vbAxCvVThJMaGHeIr7AVf7XiBX7Qq1zdYUGXLTHXmpKY7CWxu2oJcHK
 7qDw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHyDil5HoSGULYufU0HsRS4YFZD5sYSgce5aa+CfHiREEoY93BkJxWUHIYHUGXTNGRDDcOTWS3MCKL@nongnu.org
X-Gm-Message-State: AFuF++lbuneEro22WORpGzYIgPinVRoKq6VA/ZW8yftVQ+EF4joajTF8
 8nzDQ3WVSmO6j81RlFtx5DAyBEwj5e0pbwaIUJgFTJvrv4OgN3kLKchT4TcJhPOh+Qy4JaHfrMy
 CuBE6hSkqjvOixydDkfMXgIGn9vux4/ICg3ZppZyuSo7kM9S7UoY75cWCzg==
X-Gm-Gg: AR+sD10KFMfg/hvRXls0XE39E/zdxhTC2jxqHAa4JA5g0HbDMD537hD/k0FjwpJ4dBU
 1CPOuvMlKJ8xGkLg7gGlK3oVcgHPaO4zBqXekK3hHyW8icv1OXUqAevVlqD0ZtG0ENxfHwUwNT7
 oMiw8UdtwlMoOBcqs0p0i2aKSUPGta4GhBlntAOoCzOP024HzohYZMKfOgF19sX7RSaY09aNCXC
 EvrkWgGZuPHKk+7uJklQtTEdnl6SxhNon9YiaXYzPIBdVA9Du8OOrZvg9vswzUscV3ejmvPCn+i
 M37BjJA9N7tGr/MDQPflpHn5RUk4Qt0/Lp8CyVbW16Wm9u2Ptvp4qwoDRXZBmD+X13fLAQ23dK8
 cOOz9dAmQjLgxxY+oNuc8
X-Received: by 2002:a05:622a:4892:b0:52d:771a:231f with SMTP id
 d75a77b69052e-52e4228f2e5mr60240441cf.12.1787748577132; 
 Wed, 26 Aug 2026 05:49:37 -0700 (PDT)
X-Received: by 2002:a05:622a:4892:b0:52d:771a:231f with SMTP id
 d75a77b69052e-52e4228f2e5mr60239971cf.12.1787748576691; 
 Wed, 26 Aug 2026 05:49:36 -0700 (PDT)
Received: from [10.254.188.74] ([185.104.138.96])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b2817sm494596866b.53.2026.08.26.05.49.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 05:49:35 -0700 (PDT)
Message-ID: <b1f44715-9f64-412c-ad30-75e5ef235241@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 14:49:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/49] qtest/ide-test: convert to use qtest qemu-io
 command
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-23-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-23-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OyzaLDMsXB9NQoOjJLk25dSBNRyO_B0i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNiBTYWx0ZWRfX1bP5GCxEfFBD
 s8NE+Cgb7ghztZ/71U/Cx6BZsWtW3Y3ZMXCFQS1Uf31B9EWtAvIwRBXtmF6Z9qj2pyJPbTe9B6t
 SpD/5MmXFbTV1cce6gRxEEBfynQ5P13w+w+Bp3Z4nY44Ds2YDo6mI8/0EdVaKvQcAy7GaJK5Qxa
 vvic9QmpDhDccJQ1vexzWSMoodVlnDWdI4J4p5nsWEYHLEddo1HbtiBPh0Qw0wmZuldYLoK0iyL
 eXyVANw7JO0lmltmF+Q8vDBLv/p4dmA9ssUjAY24INn32ahw+VIV9OFTJnn0cWppLc/CO+LC4Nc
 Jzp6dfWOj0Y15bSxGxs2ifAOqOvjqXflgg5ffQSNujL6Pu+05tE+2ttS4jg03uh9+Hlrc8W2wvP
 RyhZ04r2HE3J621HilgAcUjmEisbxLU4zMUDluD9zonls1ue9/jNTR49gsxBGmCi48xVR5MkQF5
 RLSt6a0Vup6C6qbo61g==
X-Authority-Analysis: v=2.4 cv=Y77IdBeN c=1 sm=1 tr=0 ts=6a8ee0e2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=KRlTYBX1Q8J3JuxqD7zILw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=6rqHouBjAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-ORIG-GUID: OyzaLDMsXB9NQoOjJLk25dSBNRyO_B0i
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNiBTYWx0ZWRfX+R7iwWs957YW
 nlJBoyrYKIKXm0X6svq4Eg1TI21bDOf0KY5sGA2xjwUajdAoNJONdccwQXRMhUJ+Mc3IoV/q55r
 hkxu0ijFBxtqVAWymc67agJW9e8SNG4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260106
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

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/qtest/ahci-test.c | 5 ++---
>   tests/qtest/ide-test.c  | 4 ++--
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
> index 71d23fe56af7..0528a422fafc 100644
> --- a/tests/qtest/ahci-test.c
> +++ b/tests/qtest/ahci-test.c
> @@ -1719,8 +1719,7 @@ static void test_atapi_engine_restart_in_flight(bool dma)
>       qtest_memset(ahci->parent->qts, buffer, 0x00, ATAPI_SECTOR_SIZE);
>   
>       /* Suspend the next backend read so the ATAPI read stays in flight. */
> -    g_free(qtest_hmp(ahci->parent->qts,
> -                     "qemu-io drive0 \"break read_aio rd\""));
> +    qtest_qemu_io(ahci->parent->qts, "drive0", "break read_aio rd");

Preferably qtest_block_cmd(), otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


