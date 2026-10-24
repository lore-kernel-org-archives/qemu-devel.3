Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF8606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LSLASWYk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TFtNwURJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKYu0-00077Q-4d; Sat, 24 Oct 2026 06:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKYtu-00076n-Gf
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 06:22:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKYts-0006t0-Nf
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 06:22:58 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8ojUr2218331
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1minxUn4IZAgnpnGlDwD3RZGp5L86f15srgJVVeRZaQ=; b=LSLASWYkm4H0a2Um
 uI+y5xGUNjPlQvjtNLyp4rwqe30EB1I8NiBHNG9tWo5k3kKBfgZ032iUaAMvaa0J
 C5x+Ksvm1nd9MdBr4A4UbDcGCNWEZ1DNJtg50fIxM7zQcphDifOP1kDAPvKruBVS
 haAgGwrf9+t4m7yiRd5PKuaven4VgyLzhaWjHx9dEdeWL7urcQ9FJY9/mwMb+H5c
 +MPRFxrAzr4cCWPP962ASxlCRzOZD2e8MvPrE8BoZy8GENewQ/+HankdIplE1RTp
 ETtLsFyeeTdswVES39kQpzd5bkoR+kRbnKlBupvrAqTxVknk/4rEXhLSCtVUEvzn
 5zDT+g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgs1bh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:22:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5352436cd78so9704541cf.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 03:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792837373; x=1793442173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1minxUn4IZAgnpnGlDwD3RZGp5L86f15srgJVVeRZaQ=;
 b=TFtNwURJLc8454QN3lvfSNNhFKSIpCc9WTTnp0lY6Jb0G6OXkKDXCRRq5JkQSQRgRI
 X3Go0BYqsBuXbgw+IehU6/79kf5k9M9Xtzu8x8I60U8ldTOCyPawNvrhf3QQgMiuoYv/
 5LDfXXkcdlmIdxZp2xXKXlfB8am0abqEEJZZkbUHZZVuvzcnwkrU/SKoov1+wln3QiCO
 Kceb1i82L6LaRGv6quv7ehnXURGJ1U08+S3NDIl6zCYIPtoy7cT4yJFLfc13yKaGP6iE
 ptw+tLPL8ELCtpe2LVyYaOKe20YAbh+5A7kLF/r3Sd6SARtl76Y75BSZzgztGD6ody00
 VLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792837373; x=1793442173;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1minxUn4IZAgnpnGlDwD3RZGp5L86f15srgJVVeRZaQ=;
 b=uzesI1OEJsYlYIgCV4njNjg1Gj9dbGZc45S5KiIO2PPrKseKnyDMZs6PPTXRMlnyy0
 Cfd8UgHvbotH+JeDqiGZR0oq01EPozb+tiyyDfhsal92syAdPwM4BuvAqL/wzWfUv+yY
 hqxk6i7GdHcBY07chza1Jspv6L7JZ9pyZETMoX3NE0Hkr+6A8eeKfVP+IGIu/Sx2GU5X
 nSGD0iZzX1R3eQT/UD35ByTUc83HTP18W1R8ubW/65RDoJ97EGhdrp3Ipm3rMWBts8Un
 Z3+ZSoR54ZpLwBQBFJsYujhuS0C+uqZNoAtYjNtI3kg7Wf1fP2OOG5qg4YfFtb2sN8Bl
 PBPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmok4FPtWxzWlr8sQIlGzSd6TJHGNNUH4KX5RnuJHjns02jTz0cgrB7A9yNdt5ob8djAUQALKbxRu+@nongnu.org
X-Gm-Message-State: AFq9FYKd1Gw/INJwlYxJg4rq360nv1Fs0LTY8uLWks4b48k8vxHWGmEQ
 6sK/f7fYmi1HEg4dq4bcbfRMOjmlJiy1c45qa02mFhgDy+zYXfMzv19YBcIIn6hJ2sYQ+yC4/jJ
 760uI/UpEDCe8biD5cyy0lUqvAhF2nVXXxldWn3wb+b5t4LDwpg2wD9csWA==
X-Gm-Gg: AYBFou2dvT8LC4H4EOINA3HnBdi+DpU+didmRJqjOSTwL6BSUXAOnLXOiH8S81Opqpt
 tWtrbHG4JhDNdby/lPUc/a0819YUoq36d8URpN85HZm08pC6JBXPY8A8I7DkQ5TdavcGmxGCZYL
 noRCO1QFiKyyGZfQXDy89LnVfUlE/45iyFYCjkvFIlI5sxwQSk6UTgC/nyRjDbKgDIqij/rKbyi
 JDtoSOq2RkcOXzH1pI5vINbA08uuRkjZ2FudUIfmKwneuYoViPVjYJTkRPpRWt1hi3fgwPPOWYy
 jEJ220Q8KdnRtdpS612MFwQxh1ZWeBNxIuMGq/BBNaw8WcciTzkHXW3CMe2zfILghgsALOOanSy
 SgO04arZiHnNaJ7GsvBXEE8GRe5Lcx13hZw==
X-Received: by 2002:ac8:59ce:0:b0:536:6ec7:9f57 with SMTP id
 d75a77b69052e-5383b554149mr20807111cf.38.1792837372967; 
 Sat, 24 Oct 2026 03:22:52 -0700 (PDT)
X-Received: by 2002:ac8:59ce:0:b0:536:6ec7:9f57 with SMTP id
 d75a77b69052e-5383b554149mr20806871cf.38.1792837372465; 
 Sat, 24 Oct 2026 03:22:52 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fb08d5sm85567605e9.1.2026.10.24.03.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 03:22:51 -0700 (PDT)
Message-ID: <1fe11fc0-e84f-48a1-8529-81980e1f9af9@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 12:22:50 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] hw/tricore: wire peripherals into tc27x SoC
Content-Language: en-US
To: Parthiban Nallathambi <parthiban@linumiz.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Saravanan Sekar <saravanan@linumiz.com>,
 Dineshkumar Selvaraj <Dineshkumar.Selvaraj@infineon.com>,
 Christoph Seitz <christoph.seitz@infineon.com>,
 Sivashanmugam Natarajan <Sivashanmugam.Natarajan@infineon.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
 <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-7-c722e4ca5661@linumiz.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-7-c722e4ca5661@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX+IQU9dYooXQy
 OU7IMHIe281i1YB2EwPCNVaFt2wFOvX/g7nx/wuwuyDS9ykYeTwsuAi8sId1IWll4YBcs0fBA+9
 o72Bmp3WtI3en5dJoa23vANJmOt/DW0=
X-Proofpoint-GUID: CDUzI2UhPcBdQRbDL4_aHI0IqeOAoDcf
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6adc86fe cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=vU9dKmh3AAAA:8 a=hsfp0Rftoc65CmXm3EYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=rsP06fVo5MYu2ilr0aT5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfXyb2ps5w6z10t
 tYfz0BHsB+3n/SniCO42EXa/yhouhfngvPcNpos4hf87Snl0jMLpW80h0/X+xfe3w2LA0dptQOL
 8bvuFdu+E4mAyB6LXAYtsA00GjiqhcXbMovu0OemsPL/9e7+kFCDSbKbtK5DWbewVONjKA5en8U
 V9vqh3tezse3lBmkcXRUrt2zXQB6dPd7CjoEKVxY2TW/ar4+Saq5jSg6JAU8GfGq+mWKhELmECO
 Mc++sc2FwOzV9OZAYJ3tecaDcrTVcoAKeNRU2x4Pjxjxj0QUtlPi13Dg+CZDa4U69GQ4/8I3qX3
 Ins4YJumLwG6ierCQKRQBhoRrYG3CN2W/cZeuMI3GUAW6F7WMwhRjzst/qk+DNK5KUuZWmjPHP8
 MLEeUnd3e2i1j4dAQJo9BsT0Z1ZdBgX9YNmAnTLGjmdhntT54fIPkVYWXM+QcOsRQa8k+C75U8N
 /5qA12Neyz6168WC4mQ==
X-Proofpoint-ORIG-GUID: CDUzI2UhPcBdQRbDL4_aHI0IqeOAoDcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240041
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

On 23/10/26 22:12, Parthiban Nallathambi wrote:
> Map STM, ASCLIN and SCU into the tc27x SoC at their hardware
> addresses.  ASCLIN0 gets serial_hd(0).
> 
> Peripheral IRQ lines are left unconnected; the interrupt router
> and CPU interrupt delivery follow in a separate series.
> 
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>   hw/tricore/Kconfig             |  3 +++
>   hw/tricore/tc27x_soc.c         | 32 ++++++++++++++++++++++++++++++++
>   include/hw/tricore/tc27x_soc.h |  9 +++++++++
>   3 files changed, 44 insertions(+)


> @@ -182,6 +188,8 @@ static void tc27x_soc_init_memory_mapping(DeviceState *dev_soc)
>   static void tc27x_soc_realize(DeviceState *dev_soc, Error **errp)
>   {
>       TC27XSoCState *s = TC27X_SOC(dev_soc);
> +    TC27XSoCClass *sc = TC27X_SOC_GET_CLASS(s);
> +    Clock *fstm;
>       Error *err = NULL;
>   
>       qdev_realize(DEVICE(&s->cpu), NULL, &err);
> @@ -191,6 +199,27 @@ static void tc27x_soc_realize(DeviceState *dev_soc, Error **errp)
>       }
>   
>       tc27x_soc_init_memory_mapping(dev_soc);
> +
> +    /* STM clock: 50 MHz (fSTM derived from fSPB) */
> +    fstm = clock_new(OBJECT(dev_soc), "fstm");
> +    clock_set_hz(fstm, 50000000);
> +    qdev_connect_clock_in(DEVICE(&s->stm), "fstm", fstm);
> +
> +    /* Connect ASCLIN to first serial device */
> +    qdev_prop_set_chr(DEVICE(&s->asclin), "chardev", serial_hd(0));

Only board layer should call serial_hd(). asclin_uart_properties[]
correctly use DEFINE_PROP_CHR(), at the SoC level we should expose
the SCILIN UART chardev in tc27x_soc_init() (see below).

> +    /* Realize peripherals */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->stm), &error_fatal);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->asclin), &error_fatal);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &error_fatal);

Either &error_abort (programming error) or propagate via @errp to
the caller.

> +
> +    /* Map peripheral MMIO regions */
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->stm), 0,
> +                    sc->memmap[TC27XD_STM0].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->asclin), 0,
> +                    sc->memmap[TC27XD_ASCLIN0].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0,
> +                    sc->memmap[TC27XD_SCU].base);
>   }
>   
>   static void tc27x_soc_init(Object *obj)
> @@ -199,6 +228,9 @@ static void tc27x_soc_init(Object *obj)
>       TC27XSoCClass *sc = TC27X_SOC_GET_CLASS(s);
>   
>       object_initialize_child(obj, "tc27x", &s->cpu, sc->cpu_type);
> +    object_initialize_child(obj, "stm", &s->stm, TYPE_TRICORE_STM);
> +    object_initialize_child(obj, "asclin", &s->asclin, TYPE_TRICORE_ASCLIN);

       object_property_add_alias(obj, "serial0",
                                 OBJECT(&s->asclin), "chardev");

Then in triboard_machine_tc397b_init():

   qdev_prop_set_chr(DEVICE(&ms->tc39xb_soc), "serial0", serial_hd(0));

> +    object_initialize_child(obj, "scu", &s->scu, TYPE_TRICORE_SCU);
>   }

LGTM otherwise!

