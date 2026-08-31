Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1310FC61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16VW-00067z-7J; Mon, 31 Aug 2026 14:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16VR-00067T-IZ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:13:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16VP-0005Jz-C2
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:13:17 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VFpMw9954469
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 82SiMzichM2VA1JZjRhNV8xGA16RzEb3qdmdORVi3Hk=; b=NMH5k5/msQoyLQq/
 C4ia3P4bYBAe+w+QmmfghKyfYRhWGvtt9gvCMIdQdhJRtke8XLEIXMo3wPwQ5ha4
 A5Ymc870ZY2HTRl7NgXxt7QMUenq0UXQTE9amLGaSOvANb0JOIGPh3gkZfg0IYFD
 b5O+VKuFrUey21gogETPtcSumoNKiX+FNDH5NwyHxCcxBi9BEb5TB6PpPsy3QGdm
 598W6ZmJTrPhj0wLHs9+5iXmbf+8gpIfRZp7kk3gb3oKva7T7ulOUZRxqF5PRyxf
 NvocAijxwzZ+F/d3Bk0MZ/GEFdF4ZA2E8Sdm8WBL0MTslCaUmQpNmVzVywYFFG6W
 lLvJzg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd8cvt15x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:13:13 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1cb806660so6070638a12.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788199993; x=1788804793; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=82SiMzichM2VA1JZjRhNV8xGA16RzEb3qdmdORVi3Hk=;
 b=PPUGsmgsejTYL16uylqMQ1xiZ8TBra/Ee8YP8ZO5Me+gxMfVAh3vwhTws8l8qmpjnv
 wa9Nik/i6JWQo/EMATsA9BwR4ZBS2xyy0c4dx9zpqMx/BnFk7iAnXF8dcUGMR+JcRqRE
 rrIHuE0cv/MgUSwozCpY0KbglGFA3/C9dKcbuZXmaR4F3Km6KK0WKlXQOa5JAmpSxGKz
 18d//nCCx/oaCRaguI6FMayA8vgFHSOUbWzjPFw6lqwd2KFNnCl8bo2ptBia54jkSDEw
 uhr1gqyGTuu2nM8IY8NzFDqhTCD9bOKfdgYDj+moxBA/fLEm/fONqKXCykjsqVkmBZVX
 FgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788199993; x=1788804793;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=82SiMzichM2VA1JZjRhNV8xGA16RzEb3qdmdORVi3Hk=;
 b=sLGhirbtRXJg3BeSylFpQEsRrGVwQepg0U5j9r3rC4Z1CtAWDufv0p7gwyA14e87Gh
 IxHS6oLPaw67FHdt9Z/3ZXIqql/ldmRVcb7irmM6AcD5vObaquxlZFdUpZhuHmTHSTdQ
 z9NPQp9OG4ZnUg9D7Jl9hKWLPprJtqFhq7InNQod/lLQvO9rZnOK+FFYeK0frR5oyjft
 xQzD3KB0uIG9z+AtFoa1l16533/joyXSw2SjqBrEXnif58o8T5j8+A78ejaubl3hU3ZT
 EtUk6URctMzH1wI3catG2jqvs5FRy+eSr5ep0hfop0+G1UyJG8mIF/mJKVXaoE5o1m7s
 3OdQ==
X-Gm-Message-State: AFuF++mCx9uAMXMagr9PCDdJJAXpoQUv6ltDTEud+7iD6xej6WCfz0iW
 MxO8M/RePgcKFfe4CA4vz58oOgDrqhaxWZiZ0AwCThZTQOG3eo6w4mr79NR6EsQcmvRKv6H95kU
 5LTS91J759nu7ywVqGdjGlLkgKEd/RTQQtSuVLkKQZSnSSzCHrrV0miU1lQ==
X-Gm-Gg: AR+sD10WjUHKb8E7KWKty9VEWlxAFXodIt8titHjAd71M88LfKv9SD8UV/TCe8ipcZD
 si28v+55DV/CHQ4W+XaWMBs0VBrT+2taZ4bn4zmJpdI3wjdF7/bffv/Gg/v6k9RvC5UantMAG6y
 aDxwpefBMl6xVv3pZyPoaZmkgJKHfvB8haxJcyfiVN/Zfgg4x4/6eb5BOkmXmGHd9J+POUmcz4q
 wqAruhT8OEbsskS+DVqrMfLetCdYgUUce/XPzepRME4z9LFR7qN2WAPnIfFVjoLgJACMnp9GcdO
 8lVPXWZLqUMi90v/Rf/HikIvpott60BbhncF0TWEJw33lmkhIBRwM6cBIHm1XkANiCBarxY4tg9
 yqti/cnX1EAo8+5KTfcAuaKp9NhVGUcxHzujsCCsLJweG9BKiu2bCPVFxLNJjbR+572gJ
X-Received: by 2002:a05:6a20:3c90:b0:3d2:2011:d184 with SMTP id
 adf61e73a8af0-3d2681aa109mr43228118637.14.1788199992867; 
 Mon, 31 Aug 2026 11:13:12 -0700 (PDT)
X-Received: by 2002:a05:6a20:3c90:b0:3d2:2011:d184 with SMTP id
 adf61e73a8af0-3d2681aa109mr43228039637.14.1788199992353; 
 Mon, 31 Aug 2026 11:13:12 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f959575sm31930309eec.15.2026.08.31.11.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 11:13:11 -0700 (PDT)
Message-ID: <1f499dd9-9504-48e2-9a6d-a207f19eced5@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 11:13:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/47] hw/core/boards.h: add available callback to
 DEFINE_MACHINE_EXTENDED
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, anjo@rev.ng,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-38-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE9NXdtkgAAL_B2842aOoOU=2cc1vEdprb5QDQSY9Rwy-Q@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE9NXdtkgAAL_B2842aOoOU=2cc1vEdprb5QDQSY9Rwy-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1NyBTYWx0ZWRfX+tCgTqvpWswc
 zSHhqFLXGyLyahN0/hguFdY+Yo6dZc+TuCWx1fAWr7bvuBAbshcHnBXko2i/f0pfOufOXbatI5a
 z7QS/V1ScO00HMAPtJrDF2tN2zS+394=
X-Authority-Analysis: v=2.4 cv=JtnBas4C c=1 sm=1 tr=0 ts=6a95c439 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=m6953_s6SuGIUegrp6sA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1NyBTYWx0ZWRfX9RQDl6X8MQUc
 qZBtbVvA3ZzB6okh/cnfaLgykQaDl7OeD8GKuCVhf8Pnr7RKncdFup7ugV7FBrKYb+nhhycFSjT
 rZ/DJQUP0SC9KjsFOwaHcaZuDUXkpNUBRP7OhLeUBSDe2c1f8bq3i8CxEtI3wT/RbIhXEYmjLQ6
 eT6p/h2w2CmKwmHNOZl0ki5Z4T4qrmA6cwsaautyhSIBVZlyb6GtqPi9PyvMS/3vADkCixdltHR
 36QnAZ6VprC74HqBR+OoPMhaKD4U0oDEFDE4gd5+DBjcgv4g6gTGMzn842MtqPvfo7yoqqfGzr2
 TfEcPzb3c6VIgYktjRQKnZ/OU8R76BS662X1oT2zBBpRB7dL9NC/9l9iL39tWXuJJct7cDZtzsh
 W+AyeO5Y47+cGHA2ZEPgf+q9sjqnP2En1bVPvbIby6LpthGGakCyqLsBej5DvO1vVvjegKthWkR
 KnBxDECuq6Ef00Yfqcw==
X-Proofpoint-GUID: opN0xYhNddI-x8Ebw8KVaMk83GrwEwPW
X-Proofpoint-ORIG-GUID: opN0xYhNddI-x8Ebw8KVaMk83GrwEwPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310157
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 8/31/2026 5:43 AM, Yonggang Luo wrote:
> This change is minimal, I think it's can use proper target_is_* in this
> patch(maybe). so we have no need change it twice.
>

That's the idea: keep it minimal.
Usually, mixing cleanup and code change is discouraged in QEMU. People
will ask "can you please split it up again?".

> On Sat, Aug 29, 2026 at 7:03 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>>
>> ---
>>  hw/arm/bananapi_m2u.c    |  2 +-
>>  hw/arm/cubieboard.c      |  2 +-
>>  hw/arm/integratorcp.c    |  2 +-
>>  hw/arm/mcimx7d-sabre.c   |  2 +-
>>  hw/arm/musicpal.c        |  2 +-
>>  hw/arm/orangepi.c        |  2 +-
>>  hw/ppc/pegasos.c         |  2 +-
>>  include/hw/core/boards.h | 10 ++++++----
>>  8 files changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
>> index 8f59111fd4e..7b86986efb1 100644
>> --- a/hw/arm/bananapi_m2u.c
>> +++ b/hw/arm/bananapi_m2u.c
>> @@ -153,4 +153,4 @@ static void bpim2u_machine_init(MachineClass *mc)
>>  }
>>
>>  DEFINE_MACHINE_EXTENDED("bpim2u", MACHINE, Bpim2uMachineState,
>> -                        bpim2u_machine_init, false, NULL)
>> +                        bpim2u_machine_init, false, NULL, NULL)
>> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
>> index ae27056938f..da45bb2be52 100644
>> --- a/hw/arm/cubieboard.c
>> +++ b/hw/arm/cubieboard.c
>> @@ -134,4 +134,4 @@ static void cubieboard_machine_init(MachineClass *mc)
>>
>>  DEFINE_MACHINE_EXTENDED("cubieboard", MACHINE, CubieboardMachineState,
>>                          cubieboard_machine_init, false,
>> -                        NULL)
>> +                        NULL, NULL)
>> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
>> index 382ea7850d8..6314bbb6c13 100644
>> --- a/hw/arm/integratorcp.c
>> +++ b/hw/arm/integratorcp.c
>> @@ -705,7 +705,7 @@ static void integratorcp_machine_init(MachineClass
> *mc)
>>
>>  DEFINE_MACHINE_EXTENDED("integratorcp", MACHINE,
> IntegratorcpMachineState,
>>                          integratorcp_machine_init, false,
>> -                        NULL)
>> +                        NULL, NULL)
>>
>>  static const Property core_properties[] = {
>>      DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
>> diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
>> index db8a62e5f6c..2c884b5c78f 100644
>> --- a/hw/arm/mcimx7d-sabre.c
>> +++ b/hw/arm/mcimx7d-sabre.c
>> @@ -87,4 +87,4 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
>>
>>  DEFINE_MACHINE_EXTENDED("mcimx7d-sabre", MACHINE,
> Mcimx7dSabreMachineState,
>>                          mcimx7d_sabre_machine_init, false,
>> -                        NULL)
>> +                        NULL, NULL)
>> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
>> index e1a336e861a..52805e41892 100644
>> --- a/hw/arm/musicpal.c
>> +++ b/hw/arm/musicpal.c
>> @@ -1365,7 +1365,7 @@ static void musicpal_machine_init(MachineClass *mc)
>>
>>  DEFINE_MACHINE_EXTENDED("musicpal", MACHINE, MusicPalMachineState,
>>                          musicpal_machine_init, false,
>> -                        NULL)
>> +                        NULL, NULL)
>>
>>  static void mv88w8618_wlan_class_init(ObjectClass *klass, const void
> *data)
>>  {
>> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
>> index 7a19732f5df..87ed2ef4b69 100644
>> --- a/hw/arm/orangepi.c
>> +++ b/hw/arm/orangepi.c
>> @@ -134,4 +134,4 @@ static void orangepi_machine_init(MachineClass *mc)
>>
>>  DEFINE_MACHINE_EXTENDED("orangepi-pc", MACHINE, OrangePiMachineState,
>>                          orangepi_machine_init, false,
>> -                        NULL)
>> +                        NULL, NULL)
>> diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
>> index 9d7e279123b..ad8aca85ab3 100644
>> --- a/hw/ppc/pegasos.c
>> +++ b/hw/ppc/pegasos.c
>> @@ -788,7 +788,7 @@ static void
> pegasos2_machine_class_init(ObjectClass *oc, const void *data)
>>  }
>>
>>  DEFINE_MACHINE_EXTENDED("pegasos", MACHINE, PegasosMachineState,
>> -                        pegasos_machine_init, true, (const
> InterfaceInfo[]) {
>> +                        pegasos_machine_init, true, NULL, (const
> InterfaceInfo[]) {
>>                          { TYPE_PPC_VIRTUAL_HYPERVISOR },
>>                          { TYPE_VOF_MACHINE_IF }, { } })
>>
>> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
>> index a436d48c8e5..2e2acdb6867 100644
>> --- a/include/hw/core/boards.h
>> +++ b/include/hw/core/boards.h
>> @@ -514,7 +514,8 @@ struct MachineState {
>>   */
>>
>>  #define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
>> -                                machine_initfn, ABSTRACT, ifaces...) \
>> +                                machine_initfn, ABSTRACT, available_cb, \
>> +                                ifaces...) \
>>      static void machine_initfn##_class_init(ObjectClass *oc, const
> void *data) \
>>      { \
>>          MachineClass *mc = MACHINE_CLASS(oc); \
>> @@ -526,6 +527,7 @@ struct MachineState {
>>          .class_init = machine_initfn##_class_init, \
>>          .instance_size = sizeof(InstanceName), \
>>          .abstract = ABSTRACT, \
>> +        .is_available = available_cb, \
>>          .interfaces = ifaces, \
>>      }; \
>>      static void machine_initfn##_register_types(void) \
>> @@ -536,14 +538,14 @@ struct MachineState {
>>
>>  #define DEFINE_MACHINE(namestr, machine_initfn) \
>>      DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState,
> machine_initfn, \
>> -                            false, NULL)
>> +                            false, NULL, NULL)
>>
>>  #define DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn,
> ifaces...)\
>>      DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState,
> machine_initfn, \
>> -                            false, ifaces)
>> +                            false, NULL, ifaces)
>>
>>  #define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
>> -    DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
>> +    DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, NULL, \
>>                                          (const InterfaceInfo[])
> { __VA_ARGS__ })
>>
>>  /*
>> --
>> 2.43.0
>>
>>
> 
> 
> --
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo


