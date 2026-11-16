Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054EF606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eX+yHycv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Il6etqtL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSwt9-0007aW-Eo; Mon, 16 Nov 2026 08:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSwt7-0007aI-VK
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:36:50 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSwt6-00042c-2B
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:36:49 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGC0uXP536292
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iBMSmXNDl4pe3wsf5Ox+yngst8mCw+tnGx5Jqodw1BU=; b=eX+yHycvaAXcoubD
 udgCddjHTcs6aNjpUiwiVuYSPM01f/+dOK2tWARI9cW8PK26ab6+AQyTgkNfadEO
 Wa2qsDg5AVoz7OGCk2s3S4jlc9oDy8Z52Ltk+i0rvZ8Z2wtPvPlCbTo1ErnFfs+C
 XkNPgbaBxLGRAnOq9YjheCBW08I7bvrrL/RYmdFgwmrL2rNUYlVC4a0G+NQPhtw0
 iavBT1e85X6wKRlRcO1BNHttqesgeoWDtizgzJQU9NX51EUwv1xG1i8FfETCr1yp
 3MGuYRoNt129KwKeF5grXzcHfadD6rvt7pwdgpzyEaeprnu5fT/CdScBZJdwoNFc
 0PJXfQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqggr3p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:36:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f37c94ceeso818086785a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 05:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794836205; x=1795441005; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iBMSmXNDl4pe3wsf5Ox+yngst8mCw+tnGx5Jqodw1BU=;
 b=Il6etqtLuU2Zt4e5RrTi5RQTJ3DJBjZMbvHtjoBuA/ubM+WQGZV8uaDw/e85Z5wMQ5
 5jq4h5VK9DKBUz3tkjnTc7HnublAa7ckk26TXYN/172KkON4umVJWLLBCTzgZzZYsGbh
 sAe3zygKuQYl1AtgnUJJHr1MEnAL4ggIDSUL4pkB5wSqkCm/Aljsve6cVkyiZSMG45He
 BX86u7T7RH11Y8DgnYJPgOe+7vmbKUbCNT0ZBoCRxf/a0C2xk893cGlTF8nssmNJ+JEi
 MKYNg9MZ7E+9/VBou71qU7zVzjuHA5H3aKKIxpi6+WV0EdeTcaIUFD7S293OfYtuIsQA
 zVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794836205; x=1795441005;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iBMSmXNDl4pe3wsf5Ox+yngst8mCw+tnGx5Jqodw1BU=;
 b=CxK19ErdoZfzC5Fb5hXXSRzk+ZGNJlo6Ugr/t2DmpMp/bAH0m+gr10b1BjA81pfQPn
 tSe9M86LLi2THyysqCbTBWww20mB0ywwqBY2W4F+/o+w2yIvq4jblR2Oc2BTb9nCtf0d
 fPcI6Q9dq5GF4sdFWasutIPWRtWr30WovwL0fHd6QHXoT10qgN2K/4k+csYAt34b77TC
 xeIfl2c1oIOKoSQuviqk1yFpzHiKrIc51gh/1v+iSHK+1PSZOrJ2WWa2KOrEA4bC4OdA
 n2TFWCZZbrTXYEoNuHo0dT2/mICiPxgEMbRrFxP7YFp2KCQOKqcXqEMKwJJAlaOcsHgQ
 CbUQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGTcMXJC7/9nnz21dNxZkldploSMe5cEwJn728NSKX/e3sLPR9HzQwxZmvl6ZUw4X4frW7tuqR4AEYw@nongnu.org
X-Gm-Message-State: APuU4Z/rObiKPRJb2fTG9AGnuEpbcAS32kKp7ihqac8RF8oqSACQYMM2
 Q+hHT/pUAWhjj4CT885klsBKYQWooPZ/b7zkn4/hkYNW16HoxMQ0inZn4cmjQ0Wc9QwaTIdNpqA
 66bDeMNSGFm6nhSFzTOHbKZafwshTCWoYMybeAoEbOYRfBwKSMsU4aW3cFQ==
X-Gm-Gg: AYBFou3eaJc8c/u/GcwmJclXr6gIXMRJkZRucKnRtp1x91fn9FXy44F8FAzvQeLcFNF
 TNn+b8hM2p7H7ueAb2XMzy9i1ZsxKH+g2H9CvOvpi34C+XJ9VHvv/5H2c1Uvwhv0cxlgQHhcJGf
 KHjB3HHTC4vN0Zg/nrlUk3foL9iBVbeQ9gGbWXn/Osd7E1laPumwsdIlZaJu0nDsV3Ou9n1mocR
 wjIsyEEmjzGBoVCCS9x47c4zmrWXQ/39is3qUVztZNRToTu4pOOudO5U3xquWXGUrpYGQFsFFK/
 F7WzRm2GKYGikFcPCkUG2GHBAo8bzZKWfqHvVtJoc1M6CUy3cu23Kt17DEnurqq5CpDjPzLgs2g
 aAOB7ASXkT8HupFSF6hBBKAy+0AW2KwPHO/ZTLycmHr3cBMrU7KiVqen5UGTQSXAvZGiC5A7xRi
 bPDcMh3S4=
X-Received: by 2002:a05:620a:3187:b0:949:7058:dbcb with SMTP id
 af79cd13be357-9497058e11emr838265485a.14.1794836204656; 
 Mon, 16 Nov 2026 05:36:44 -0800 (PST)
X-Received: by 2002:a05:620a:3187:b0:949:7058:dbcb with SMTP id
 af79cd13be357-9497058e11emr838260785a.14.1794836204061; 
 Mon, 16 Nov 2026 05:36:44 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60116323sm21852271f8f.32.2026.11.16.05.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 05:36:42 -0800 (PST)
Message-ID: <1725710c-a202-406e-9eb6-d8a42a62d86a@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 14:36:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/26] hw/char: mark common serial / console devices as
 secure
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
 <20261113184254.2524253-20-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261113184254.2524253-20-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NCBTYWx0ZWRfX5cr4wDNf665g
 gq6gGHpjQCLuQtxqkcoG+lIMRlLfGoyiQknD1hQOj+OaoJ4d6PDax18ANBFTKy2/ESHQ5JukiZh
 EAJDt9n4MzUwrrBPtv68uANv3/m/K+I=
X-Authority-Analysis: v=2.4 cv=epRKXYpX c=1 sm=1 tr=0 ts=6afb06ed cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=A4n3DYk0GJPsPhckN_UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: LE9aVKuvzIWOFyhv7lGvDltgG94rSuHz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NCBTYWx0ZWRfX7GWuq1MNxD+g
 KQe9YWdh6mRSJXTu5Mu4iJGQIwO18SyelnO3QdVkItSxmr1qpSONdULmIcVOqhG+bv6AzOcUqSF
 FSxELvHSNUGPajuyWRyOTj11nfVJacMv5OYuX75IdCuPKUYeX6OmHjn7Num1Onq8ZB8X1pJmSyz
 GuWIvDzWOYK1kEgm1PcG8CMbtB6dDvkY1mhDF7F3zdsgsbhUVphhQ021J2d/wmRO6xl/S7KJe11
 WhIULxxsuAmawxWotIzkm4O9dXAgcyo+8jXrXflgae9coxft0Vv8/EmaOUaaJi6mwR8EnC4VXrD
 HZsdKXHCjOqVYuzMOkCXi2jmT4T59cOaqq0smE8gjvZgIsmFeQ4wHdAPNeGvOdz7BUCHvj3PuHG
 vl3JKXfy+0OxaR+elrM3pD2urE/d/NY5vIMW/7YCbNCfVuf73+Mfov6irTp/n70gxAlmjHjgdCy
 pg5rUXiZOF1mVT8kF0A==
X-Proofpoint-GUID: LE9aVKuvzIWOFyhv7lGvDltgG94rSuHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160054
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 13/11/26 19:42, Daniel P. BerrangÃ© wrote:
> These are needed as a baseline feature for many virtualization use
> cases on x86, PPC64 and s390x.
> 
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com> #sclpconsole(-lm)
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/char/debugcon.c       | 1 +
>   hw/char/sclpconsole-lm.c | 1 +
>   hw/char/sclpconsole.c    | 1 +
>   hw/char/serial-isa.c     | 1 +
>   hw/char/serial-pci.c     | 1 +
>   hw/char/serial.c         | 1 +
>   hw/char/spapr_vty.c      | 1 +
>   7 files changed, 7 insertions(+)
> 
> diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
> index a1b370b90be..f38ce7b765e 100644
> --- a/hw/char/debugcon.c
> +++ b/hw/char/debugcon.c
> @@ -134,6 +134,7 @@ static const TypeInfo debugcon_isa_info = {
>       .parent        = TYPE_ISA_DEVICE,
>       .instance_size = sizeof(ISADebugconState),
>       .class_init    = debugcon_isa_class_initfn,
> +    .secure        = true,
>   };

What is the rationale for using the debug console in virtualization?

