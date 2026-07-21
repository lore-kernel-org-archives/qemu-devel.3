Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF6BC4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmHCy-0003a5-PO; Tue, 21 Jul 2026 16:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmHCx-0003Zk-LB
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 16:36:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmHCw-00061W-44
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 16:36:55 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LHRMuF2446029
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 20:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XFFqVtpBpQbaqPThEh/QDJY0pbFLoPfJBGmm0F3HSDs=; b=D/6P25fjGL70Htwo
 Jhg5e3O2jco8L+TNCYkvxk6WA276cBZLb68fBODEiX8ySiOQk/7JeJgG+Gp2q1TF
 loPEzdk6w2IMfBqECyWK3RoDpOqFRqhIjvJeC+libKb+z3KbVaTimKrPcwOXXF73
 JjYcVHP9t0hwnDVfwoUwBM9bDeJc2bobhqW5hNf6O69BVI9N0uCUuTsC4PyU0kHo
 yuzeY5p3OO/Sbt6KhPerouiSzWe8h1Lu0nfQLZ8r1Ah/+UXahAA5D8qKy3Pi/Hqz
 Tw7/BS0DkGHDKv79QDt64YTtW1MA01MgrI4ACPnCfAhVeUuJ3+PKjdxsM9TDWdBX
 Nj2wQQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6d0tge-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 20:36:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso126310681cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 13:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784666212; x=1785271012; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XFFqVtpBpQbaqPThEh/QDJY0pbFLoPfJBGmm0F3HSDs=;
 b=EgCrq7OCSIDD5SA9bfpJ6bDnOLRQ8BZZQjDUFc19uK6uNYuYy19CvC8Vfaw1fciN/I
 /dcntq2e6wOah358IaMV88rSBwQYVqwu7gUYfOl1nl8bh42OpddwAzM7jm6bDgvDEv1A
 vSMIxeLflgAG2d7U4P4cMCuaZJW4DqPssyF9YLybZuKPndVhDsJZwYGwz2jjRJy5hm2C
 NSyqP1wht3qy5lgzoqvhYlkJ6esEnaNG647ITBQis2/ZJAtaaUUxL7mGYp4MiHSCEZC0
 9vdGkUKW00tGML6U/kNmw7O3VoisCvKS9A7u3yDRFX7ywIseAExEMkrm1i1eWe5CK1CM
 Hc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784666212; x=1785271012;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XFFqVtpBpQbaqPThEh/QDJY0pbFLoPfJBGmm0F3HSDs=;
 b=R2Tp43TZEYnT2nq/ALcVNn+N1wDEAEg5/iUktwbwvWMrT7TRwnao12TZTrCvhHZSt1
 o0w357fw9s980Tuw6+cxeL8Z7DVPAiQOUJMjZsLNDOHiqE7px/VRXOQxgG/+WmokEWd2
 racUwFo4YnHIWhCLjmLPsVf73404o+794bdYLram/I20GFaSgKDcgbNPIEifW4Fu/Cp8
 wRJ0f+6keNRnS8GP3mysZtCXFr3AoS6AodWbGL+8LiSPySVxAuvVewcOtRobXhA2vfCl
 sGvjGVEASrW6rYab56rGm4i2uBYnJ1H2DjXnk2ABelDLDVDGPDu9tzyTPRbtKVn+Nx0/
 UIMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrtecE6oVqXlu1jKVmKVJ+mLLzTr4mOw+jqfXEpc4r4MNj3ZY+/SCV1gpa2RX2E0nWf2+ZyhKTe3Kno@nongnu.org
X-Gm-Message-State: AOJu0YyHne9LfuH3JveV/sAunjhy0Htbb/zQCDws/3a5HUhjQv4uZQEF
 WFPo69P/+sHRv/V5vhAb3zVMeBS8AOaeP3dlyKdu3XOQIgcuU14Ov1UoIC0mloiHKXiwPL1ADNX
 U82TkU3/JlOgaJZ060F8Zq/xRoaM95XQ5tRMDvWUCaNGcyzg+id86tjoyDg==
X-Gm-Gg: AfdE7clvuKZkw3GESNnx/85X9NKurtEgHYAtcX8JjY4/w1RFHLZeGo2gTtNF8SnxKQq
 8r8Afn732lTm/rlEug1Jb8y+1MRBnAVhPFZQ/kw8nB5wGqvHAQwCzxqStN/7BXfGCLHT1xok+Zf
 YeWk7CUX5Tt6NAFMLFwd/6Spkf2zinrb7I7YyfhPvSb3oOqwDZfvEJsiEfKrDAerk16qQkg8lNE
 S5BqEnM3ZwX7y4mdXSQNVhHDzuvVDUJy5Pu3qDZPW5LCVnT8GqhkYFYXd23m2rWSawcqXaKMSlz
 Q2CUPjfqWPSEN+BkO8Ag5dEP9R8EI4JMoGXA+ciol3WQGR86MGIf3xipYsaKi1Y2Xtxr+P7FLX3
 yiMjZgAacf8D3nM7UzR5m85WtL502L8SY5/09EGAYTJL7CsXVboM=
X-Received: by 2002:ac8:5fd5:0:b0:51a:8c86:bd48 with SMTP id
 d75a77b69052e-5213cdccb5bmr189544381cf.69.1784666212274; 
 Tue, 21 Jul 2026 13:36:52 -0700 (PDT)
X-Received: by 2002:ac8:5fd5:0:b0:51a:8c86:bd48 with SMTP id
 d75a77b69052e-5213cdccb5bmr189543911cf.69.1784666211736; 
 Tue, 21 Jul 2026 13:36:51 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c6besm88418005e9.8.2026.07.21.13.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 13:36:50 -0700 (PDT)
Message-ID: <0a8f5dca-ec5d-48c2-a2e3-47a092e808b8@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 22:36:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] hw/intc: Add l2vic interrupt controller
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 peter.maydell@linaro.org, matheus.bernardino@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Thomas Huth <th.huth+qemu@posteo.eu>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Sid Manning <sidneym@quicinc.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Damien Hedde <damien.hedde@dahe.fr>
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
 <20260715185701.1287176-5-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260715185701.1287176-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: c8iBBjOy7SMM-KRdPSxBn92Na2pUDaX6
X-Proofpoint-ORIG-GUID: c8iBBjOy7SMM-KRdPSxBn92Na2pUDaX6
X-Authority-Analysis: v=2.4 cv=XaG5Co55 c=1 sm=1 tr=0 ts=6a5fd864 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=qanWtBFF2Cr9fZHPp7sA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIxNCBTYWx0ZWRfX3/nJwu+Xd05p
 BD8Y00Ccz6pD0MTlPtRoJMwN0SlS+Kk9WZOMgXtyVPwCLAE48V1Amk4jRsE4R9HkB64f33xFur3
 IuxRVymmWWs2U6B0gCZF5QMS0khPSbe1uJ0Ut6Zd9qsAX0ptcroq8ON5GIwAetE/wPhwdh4UFxG
 OVdPwg4EOKoCO8hHGaJIjZkVS5CeLsYtQCYRNqbeKrkj6bCeRNlfE3gjUSr2XmQ0vKtzg7XGg1U
 sZP3/b632MX4MXe3FoWUX/PDiu42KSFCbxLUsXWT0U9fds0GTLifhENz9uLZUBo7Ld9xOSsVOtv
 LzjGEBYXgAckFH6bTMhIKQUGLyMSWrQfUORofUgnzyIgic0ntdC8+9UqiwCjJFVFztFKti1aRvm
 +ykqxA+rhJdjbahRIkSmRpGN4Cooq0P8ktbgLECJme5kiCehslbZ5WoGpwrKNm82w76lmqj4xsZ
 LGs2+GxNCkHOs5B4P0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIxNCBTYWx0ZWRfXybLbzWQhTbHX
 0v9SAfxYCNvrCTMpXoUTUWa/Yx96QgwHaDeNmLPgeh7T1nEOAPb2nnG2Xfs0Z8NB/vNN1fhws/s
 JAOxhwQkVUP3wpL9QnmKqrrZqZyHFCc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210214
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

On 15/7/26 20:56, Brian Cain wrote:
> From: Sid Manning <sidneym@quicinc.com>
> 
> The Hexagon DSP requires an L2VIC to route up to 1024
> external interrupt sources through 4 VID output groups into
> the core's 8 interrupt inputs.  This device model implements
> the register interface, interrupt steering, and edge/level
> type handling needed by the sysemu machine models.
> 
> Co-authored-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Co-authored-by: Damien Hedde <damien.hedde@dahe.fr>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                    |   3 +
>   docs/devel/hexagon-l2vic.rst   |  55 ++++
>   docs/devel/index-internals.rst |   1 +
>   include/hw/intc/hex-l2vic.h    |  87 ++++++
>   target/hexagon/cpu.h           |   2 +
>   hw/intc/hex-l2vic.c            | 532 +++++++++++++++++++++++++++++++++
>   target/hexagon/cpu.c           |   2 +
>   target/hexagon/op_helper.c     |  21 +-
>   hw/hexagon/Kconfig             |   1 +
>   hw/intc/Kconfig                |   3 +
>   hw/intc/meson.build            |   2 +
>   hw/intc/trace-events           |   4 +
>   12 files changed, 712 insertions(+), 1 deletion(-)
>   create mode 100644 docs/devel/hexagon-l2vic.rst
>   create mode 100644 include/hw/intc/hex-l2vic.h
>   create mode 100644 hw/intc/hex-l2vic.c


> +/*
> + * Find out if this irq is associated with a group other than
> + * the default group
> + */
> +static uint32_t *get_int_group(HexL2VICState *s, int irq)
> +{
> +    int n = irq & 0x1f;
> +    if (n < 8) {
> +        return s->int_group_n0;
> +    }
> +    if (n < 16) {
> +        return s->int_group_n1;
> +    }
> +    if (n < 24) {
> +        return s->int_group_n2;
> +    }
> +    return s->int_group_n3;

Declaring int_group_n[4], this could be:

        return s->int_group_n[extract32(irq, 3, 2)];

> +}


