Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3C9C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6t4c-0007nG-Mf; Wed, 16 Sep 2026 13:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6t4b-0007n7-Dl
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 13:05:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6t4E-0005RY-Ox
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 13:05:28 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GH3ihw3897343
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 17:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z4bZ49uWO1Nfo5CBttEQJiAkbibqJKcyZxVOTSZ/gsk=; b=b3qV6Dl5r5dXpFP8
 IveXOExXo48dg4MyGPz/j1MnEQx32gKTsSwQlAvD4LzCHGfa19GBaabnQlBQ5BqL
 Bv20+EAtIkTgnojfmeRyWCJrzRAmEC2D44gOZnp0oTaD2xao70kA9Xp93f2MWEsX
 J6iT9TLAkx/M7v7TXZdyqsctOaX6bMUWMbnQnEHjA6e/5jqX8qsN2JH4R7lhGv0b
 Iya0sRTLTE/jdmTr4Xj01R9SEW5DiLMTdONxtLQjhZRjVGycYywHc/GlqbiMEdjF
 2KuayJc2C51pF9IJFt6QQpQOCk5Vo8VDE6YR5rPppE+wE9fH6KoIjV+OfXPD3Hw0
 dKoRBg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy6ar09e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 17:05:04 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6c1b24c4d0bso6809565eaf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789578304; x=1790183104; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z4bZ49uWO1Nfo5CBttEQJiAkbibqJKcyZxVOTSZ/gsk=;
 b=QQTsZcU0RjAmWrZtO01NdAeCjzpQpYLSud3c0OKy2mDzWCPU+hTyZnZT5qpIem1/SW
 9RC6WNNnMxSy4mr2uwJvT9IS2es4JCdvykTFLfhb+ArC//4/xBIMUhWfbRd5uOOABdra
 ru1IjrA5Tvd73oAD1bXuOySbQgAOBGzbUGzhr7eA5cLBtrhMZ0GOSTd2UtosO4xaOaVf
 PAX5lsi9JQgfsSHpmil7NIK2bYMP82gdAdwt3KZMD9v9Eu+qYiG+9yIKDYwMTvw/uVpk
 XVXrkOJlWZfNa6Zeau5Uftagq9LXeedysXVE7YT7/UMaBXSgE8VaYXKekM+6mvxlo1cy
 Se+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789578304; x=1790183104;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z4bZ49uWO1Nfo5CBttEQJiAkbibqJKcyZxVOTSZ/gsk=;
 b=y3iMVxdw+tqg9uiURTpEJqGtBJDVtgqfzgCbB0foWwbKWJ+nkY5jJ3+cxzJUG4QNQO
 3D4b5/4obuCIBI7VM+4y2kxKu094eUPwTiZrPoLspjMLq4FjdztTmIlQADSEEH0A5Tup
 E+dfUfIXFL9oyZh7cGHIIKt3H58/RY2eXG25kc5shTW8vwfSFrj9XaCRnbLMDcfXkKE8
 HKcBbgVZ8L7lQ6ZT9mijWIf5zCU8pKgX0dTrbF3zwXydi/G0fnQgEKSDcCY4vxLs7/28
 G4SWTtZ5t3WsQkKUvIc+I5P+Sw6GEA/K2B935lgyjg2Evs3qEmjCdIHqngOwlHmNKiDu
 LFgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBynnZOi3YuE/6RAIX1+vhuJEN+spjrV7kikFdTaI8hRzQtmyP1/TTZtTAqklSLd8kn0966Als1bswXg@nongnu.org
X-Gm-Message-State: AFuF++nczdDKeetwRUmtHA19hI89oNn3tdRPf/qt7Z6Ii1NGA3R8yuzi
 axkc5KZyF8bwPBxfbBrY+JN6+CzyxMiXZ17o8VDp3PQQ5nie7zIq3TF5l3bo+5zU09RQOdTXoGi
 lzkbLBfhtUUTz0kHLearTvrD0hn4c3y3HKg6V9rpie+spPFUJD5107PxgFQ==
X-Gm-Gg: AYBFou3fOGk4e07HDirC8jPeY9gSRBiIusEzjilwc5JNnFy1Ul5GwN+9q1zVBY8isj4
 OwYEh3V2+P2svXlzn1181cCkfqyyZBpPdPwpgU3YNVQwTIiOzhznKKWhWVOWDw4wVeWTjiYUzXf
 5fZlM+oy++yIOzPBsFO2luLhTBU7qZ5UVRhXp71W8mmItbbySfXPniaOJZ8VklaCd1EC9yJzVox
 9uhFFJ3zutvnvpRfz6KyZB7PAQlO3ryGjnmHmXwQIY2SjWI0rJpaF2AcpAQho5XMUsS3VFHHCk+
 kKieqCOojlzSHSxlXPWwTVhHfoDrRzo0lSGBCKcwJkGNpu7o9bzgOz2h14ONJacsuQm3oEoZaVy
 m0fAGyuEzRSNZx79vanZJHSc4n9c6axkYoeYXi2hnxA3UDqsOSXhj7E/O23O7+zLjya3q
X-Received: by 2002:a05:6820:4dea:b0:6b4:3a06:c251 with SMTP id
 006d021491bc7-6c7d25ee603mr3663478eaf.29.1789578303890; 
 Wed, 16 Sep 2026 10:05:03 -0700 (PDT)
X-Received: by 2002:a05:6820:4dea:b0:6b4:3a06:c251 with SMTP id
 006d021491bc7-6c7d25ee603mr3663421eaf.29.1789578303313; 
 Wed, 16 Sep 2026 10:05:03 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bfb19f8cesm11258261eec.2.2026.09.16.10.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 10:05:02 -0700 (PDT)
Message-ID: <22c1ad3a-c5ed-4ab0-be1f-c5b043bd67e5@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 10:05:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] hw: Add availfn arg to DEFINE_MACHINE_EXTENDED()
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
 <20260916-hw-riscv-cpu-int-v4-9-babc367b60f5@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260916-hw-riscv-cpu-int-v4-9-babc367b60f5@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DCyh5TBh-CtPFfHoukTebHab0nz1HWYI
X-Proofpoint-ORIG-GUID: DCyh5TBh-CtPFfHoukTebHab0nz1HWYI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIzMyBTYWx0ZWRfX+lSRmmhq3boI
 bzQcevOMdbWmjnbNJd2vOjh1Pwr4+G7A9uHtqiInJA9xGsOilPU9V8f/oDm79718FAqkoVBZtbX
 T1N2oP4bfRrGGNkD2LHVtq6YOsDAmoR+MtwpFCRB69rjsMo6zWabkgP4Wfr5Mnyd1wZAzV+L6sv
 b1Er9YUjG/nvzzrcSGiCjhPPlHWBIDaS6noeQd5jDGjKOQXs0cpf6xrqRFVWSXp2hblMxOuB5fa
 FMf941JNebJXHGzo08jh2sj8hHAxlLNLVaJwfgB7gmq2rePy6gDxnKYNrpDL1Bgdss7yC2nbk1t
 mi4D7YJhgETnb40T5Z5ZAaf3ydMP1Xg/yIW9xyP86uqgf58cBLlX/NtQMhHCEpPNeIEHBUEfI4g
 +9l+wbAwMOXXS6TEyhqAKC7phGRIaAl5ihmmF/nlK5MEw4apg43rlwzzqsGEX0rSTiq8KTmgD7G
 b8L/4EVf7I3Hp8RjCOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIzMyBTYWx0ZWRfX+b7veaeT+zrD
 wk4eh/Z5P48iSnLvrvDQh2e8rSK1EV4JujftW4O55Z5pO526j0To5ViCGDLqctmmPtDVziw08R5
 ZyspA5iolU+Mx0+uimt//aeuD50MW4s=
X-Authority-Analysis: v=2.4 cv=VIRIDNPX c=1 sm=1 tr=0 ts=6aaacc40 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Dl8K2LnWQjKZsW3-ZUEA:9 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160233
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

On 9/16/2026 2:19 AM, Anton Johansson wrote:
> Allows specifying is_available when defining machines using convenience
> macros.  Also introduces DEFINE_MACHINE_WITH_GUARD() replacing
> DEFINE_MACHINE() for machines that need to specify is_available.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  include/hw/core/boards.h | 11 ++++++++---
>  hw/arm/bananapi_m2u.c    |  2 +-
>  hw/arm/cubieboard.c      |  2 +-
>  hw/arm/imx8mm-evk.c      |  2 +-
>  hw/arm/integratorcp.c    |  2 +-
>  hw/arm/mcimx7d-sabre.c   |  2 +-
>  hw/arm/orangepi.c        |  2 +-
>  hw/ppc/pegasos.c         |  3 ++-
>  8 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index dba465efc2..8c35516622 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -514,7 +514,7 @@ struct MachineState {
>   */
>  
>  #define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
> -                                machine_initfn, ABSTRACT, ifaces...) \
> +                                machine_initfn, ABSTRACT, availfn, ifaces...) \
>      static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
>      { \
>          MachineClass *mc = MACHINE_CLASS(oc); \
> @@ -526,6 +526,7 @@ struct MachineState {
>          .class_init = machine_initfn##_class_init, \
>          .instance_size = sizeof(InstanceName), \
>          .abstract = ABSTRACT, \
> +        .is_available = availfn, \
>          .interfaces = ifaces, \
>      }; \
>      static void machine_initfn##_register_types(void) \
> @@ -536,11 +537,15 @@ struct MachineState {
>  
>  #define DEFINE_MACHINE(namestr, machine_initfn) \
>      DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
> -                            false, NULL)
> +                            false, NULL, NULL)
> +
> +#define DEFINE_MACHINE_WITH_GUARD(namestr, machine_initfn, availfn) \
> +    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
> +                            false, availfn, NULL)
>  
>  #define DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, ifaces...)\
>      DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
> -                            false, ifaces)
> +                            false, NULL, ifaces)
>  
>  #define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
>      DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
> diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
> index 8f59111fd4..7b86986efb 100644
> --- a/hw/arm/bananapi_m2u.c
> +++ b/hw/arm/bananapi_m2u.c
> @@ -153,4 +153,4 @@ static void bpim2u_machine_init(MachineClass *mc)
>  }
>  
>  DEFINE_MACHINE_EXTENDED("bpim2u", MACHINE, Bpim2uMachineState,
> -                        bpim2u_machine_init, false, NULL)
> +                        bpim2u_machine_init, false, NULL, NULL)
> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> index ae27056938..da45bb2be5 100644
> --- a/hw/arm/cubieboard.c
> +++ b/hw/arm/cubieboard.c
> @@ -134,4 +134,4 @@ static void cubieboard_machine_init(MachineClass *mc)
>  
>  DEFINE_MACHINE_EXTENDED("cubieboard", MACHINE, CubieboardMachineState,
>                          cubieboard_machine_init, false,
> -                        NULL)
> +                        NULL, NULL)
> diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
> index 8a5737502f..68526c0e43 100644
> --- a/hw/arm/imx8mm-evk.c
> +++ b/hw/arm/imx8mm-evk.c
> @@ -135,4 +135,4 @@ static void imx8mm_evk_machine_init(MachineClass *mc)
>  
>  DEFINE_MACHINE_EXTENDED("imx8mm-evk", MACHINE, Imx8mmEvkMachineState,
>                          imx8mm_evk_machine_init, false,
> -                        NULL)
> +                        NULL, NULL)
> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
> index 382ea7850d..6314bbb6c1 100644
> --- a/hw/arm/integratorcp.c
> +++ b/hw/arm/integratorcp.c
> @@ -705,7 +705,7 @@ static void integratorcp_machine_init(MachineClass *mc)
>  
>  DEFINE_MACHINE_EXTENDED("integratorcp", MACHINE, IntegratorcpMachineState,
>                          integratorcp_machine_init, false,
> -                        NULL)
> +                        NULL, NULL)
>  
>  static const Property core_properties[] = {
>      DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
> diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
> index db8a62e5f6..2c884b5c78 100644
> --- a/hw/arm/mcimx7d-sabre.c
> +++ b/hw/arm/mcimx7d-sabre.c
> @@ -87,4 +87,4 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
>  
>  DEFINE_MACHINE_EXTENDED("mcimx7d-sabre", MACHINE, Mcimx7dSabreMachineState,
>                          mcimx7d_sabre_machine_init, false,
> -                        NULL)
> +                        NULL, NULL)
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> index 7a19732f5d..87ed2ef4b6 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -134,4 +134,4 @@ static void orangepi_machine_init(MachineClass *mc)
>  
>  DEFINE_MACHINE_EXTENDED("orangepi-pc", MACHINE, OrangePiMachineState,
>                          orangepi_machine_init, false,
> -                        NULL)
> +                        NULL, NULL)
> diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
> index 9d7e279123..cbff8bb59d 100644
> --- a/hw/ppc/pegasos.c
> +++ b/hw/ppc/pegasos.c
> @@ -788,7 +788,8 @@ static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
>  }
>  
>  DEFINE_MACHINE_EXTENDED("pegasos", MACHINE, PegasosMachineState,
> -                        pegasos_machine_init, true, (const InterfaceInfo[]) {
> +                        pegasos_machine_init, true, NULL,
> +                        (const InterfaceInfo[]) {
>                          { TYPE_PPC_VIRTUAL_HYPERVISOR },
>                          { TYPE_VOF_MACHINE_IF }, { } })
>  
> 

Since full filtering concept was dropped for now, and since
there are not so many usage of DEFINE_MACHINE in the codebase, maybe we
can simply do a full declaration when a guard need to be set.

In current series, only one occurence would need this: boston-aia.

Regards,
Pierrick

