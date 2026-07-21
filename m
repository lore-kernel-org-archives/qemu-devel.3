Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC4BC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGoa-0003oR-EO; Tue, 21 Jul 2026 16:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGoY-0003nC-BX
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 16:11:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGoT-0002PT-Az
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 16:11:41 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2eNT2280244
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 20:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t0GNFOxMvMLmDuJHKCfGeryl22Aw3cATsUNJObgg0r8=; b=XwvAmmtzj0a9ERNS
 O2gGWNpQaA7GaCvnu6EkayqJIunCXfaG6Z4tMKwehFl7EVvUnX9qku+Wbb/IlwGe
 9wgJ2FySsICxl+X+XeAO3PKF20lX/+JpM3h+zn/EEyXv9kn9oR/Tu6/3pf5HFcJS
 zEGEetMgDIw99MZcPiVEqiUXdyoghFz3TxA+TWF6K4vtnCzCRvHdx+KZL8k+UPhG
 LxiSBuTIxu3N+VFWP4X618Y/m9e3JuJrsQWo4jsTJmiDpeBaT7DxDr6d3mM2bR1q
 2KGh3l2n0oJJvQ7dv2Q89NUt39rmZRuLQiCGATlg58VrRWTSgaJAS7LxkjJ3iF3G
 X5l26g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6paatn2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 20:11:35 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8eac2620cb0so163311676d6.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784664694; x=1785269494; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t0GNFOxMvMLmDuJHKCfGeryl22Aw3cATsUNJObgg0r8=;
 b=e5dcO6ti7icCSYNlJ6wD1OvmwBC4e7YtQqgacETo6MKLXGOMSA6b597muctWaPstTq
 XC06NBtB6lG+FJIEGq9R/SJVhiyBphIklysA0xGT280VoqX5RFmUxmc7dqEvKD9ePt+h
 e9IdMmpqxyN0H35A9vCkO4BwNG+2CspJ2PIDMxocuiwWy8yXP9eLLKTlOKYKPoY7XtW4
 9GsASRIREy5mvQd8JWiVkJuIduFJBJhl0d8Xhtap6cZa4xfHYjRbOrVE003cE3RGMmdN
 tmhwyYLhvEN4lm96lzjP6eDKC065g8ofSB3EbdfxFyZXxGIlfKZf1WiAgVLjXRVtd2cU
 HNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784664694; x=1785269494;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t0GNFOxMvMLmDuJHKCfGeryl22Aw3cATsUNJObgg0r8=;
 b=ek75v7TDwdWOUauvpmDe31uRUOJfSWVQKY2ERbSOztGgJ0SEHHwdw5nWHZwxbgcZsJ
 BXgcNH0hYTDBu5lAiCNz98bus7rvhK6SqLaZMq0evJQOUgJxzDFuaXmx521IRuP5ZypZ
 n0SzciuOgeHJOk7pvMbul4yL2ktXEgouLxWrTygkFoRz1yPQqHipcrU1bXuvSQ+og3Mh
 OjlKSbpqkty95wdK5ruEZ+4mm9yWNsOAZkVpbOoxyjChrqemhxODkO2XKuNKgah/H3se
 zEWplILVDvcN5A5SCvM743E2vTuertFTUrylIhDjy+tEYGqvvg/hlulrIyhXEmT6pfus
 c0KQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Robv/uzOPcpwrliCY/GHjTgwh/3mT774QuSCHrCsiRa4dDX7VWbVpTNjUs9SoiTkxyekQut8WTJb8FB@nongnu.org
X-Gm-Message-State: AOJu0YwYqf1MIozAabVl3mag7fPOxUsTZ+Bog3TaWyKZvFw5JWv7ZDzI
 hGr/2skJAT/aIF8VQQhKcZHKWW58RpTn3h6ySSi9kttzr/skOEkHzj43sYZIL82/FsTiToM/IlU
 VAx6hm0yjHfnU7JcI73GyoQ1yAJ7YYljz4LJM55a8ebdXKSMeGpkFtDFKcw==
X-Gm-Gg: AfdE7cnR5GdkFdM2KshCEGmB29g6z9rY80bBxvKpjqdTIAxqyziDlJPnf40pNp769Pa
 q16ZJ+tnJm7YePm907RmL9p/hq/rU3eEoo68QFJL+y6u6A+CqRXYz0Bpn8lQ1QIBDFEjHJGJ4+l
 s1tjTtcEUh9gt8ER+WUPPdntHU6/w9kvZPGMKtWuqz92DfpwhB6VPN0Lic6KoU89FAr5MMJwh0n
 hY8B3R/SqyyOxSAbrBAWRTSLFsYrZeE3NZyhKgPLFc2m8PwOgJXo1Yqgo/uvxnfHPASEfzeUzg9
 V10KI8AZly3Bnla8GovtCipZfbOLddvkpgUr9N8lGpcNxfLlw8aoSH0xfwoAn+T8ZJv5CV+2q7f
 j7GhMU4ehbf3V1SsW8jzBLs4rFpI68pZdcM5f6ktpKbyZhfo4ws4=
X-Received: by 2002:ac8:5809:0:b0:51a:8c9b:6499 with SMTP id
 d75a77b69052e-5213d0c6e31mr199642851cf.61.1784664694513; 
 Tue, 21 Jul 2026 13:11:34 -0700 (PDT)
X-Received: by 2002:ac8:5809:0:b0:51a:8c9b:6499 with SMTP id
 d75a77b69052e-5213d0c6e31mr199642211cf.61.1784664693857; 
 Tue, 21 Jul 2026 13:11:33 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4f2453sm18211865e9.3.2026.07.21.13.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 13:11:32 -0700 (PDT)
Message-ID: <356ebc59-d2cb-4c47-867e-8fc693b3a593@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 22:11:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 15/15] hw/qdev: Prevent devices from being
 realized more than once
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
 <20260721-qdev-v3-15-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721-qdev-v3-15-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xItMmqmCBePjqoIZX8wYQiOFuCavaDbx
X-Proofpoint-ORIG-GUID: xItMmqmCBePjqoIZX8wYQiOFuCavaDbx
X-Authority-Analysis: v=2.4 cv=eYYNubEH c=1 sm=1 tr=0 ts=6a5fd277 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=z4CWwV-Xco1BPblWOhEA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIxMCBTYWx0ZWRfX4+5TFz8o6EAc
 XWaso6A6SYZAr+gMg7blzcsDLrHQsQN7j2GmswC2NMXOrMxUl/QDs6Vf6f3KZirdL1Xqmb/0ihC
 SkbvvJMZoymT37P0w4nsY92PUBEDeUUjq+pzdixp3JWHCzRB8as+NFeawOPkV4KEp5zGyqgO/hU
 DHt++gj7o6rhRhd8K7cQ64mXJuLhYO/JxJjv/9/mHH2+GUCIA6RvkSNyEpfYHWTIF6h8DF+Jajw
 gNBBhfx2qNdJh+wVu2E3Q6K/xUNk2YJQJhEgkBOIneRxkyKWcCG3EbiV5QtCEkU8k3xJUBnf4wJ
 G81GKcfdyEF6SR7ebtxDEYKIAKTvSy3fFd03leeQn7HRzyelxP4pmiVTCimR8QW2DCl5Nx4J4o3
 oz0CXLcs2IdJ5g9uoX2x4+vodp6Yhiv7osdQUJ5boUfZsrGmK49UrLFsPbFHzqDsObNTut9D3g7
 +RrkRSiHQINcnl86eJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIxMCBTYWx0ZWRfXyt39QL4NvTjf
 O9PvmLdYqpE7XTnZa2NBsWcwZuxltR+1KmEm2GkB2vOPIDnCZGmm44c2uNLugvt/KbFyGQtJn0c
 FZCkv7wauDGwNLFB4Be4qgDNThKLBTY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210210
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Akihiko,

On 21/7/26 10:17, Akihiko Odaki wrote:
> qdev currently permits reentrant realization of the same device. It also
> permits another realization attempt after a device has been unrealized
> or a previous attempt has failed. Either path can invoke
> DeviceClass::realize() more than once. Supporting repeated realization
> adds complexity to device implementations. It is untested and likely
> broken.
> 
> Replace the bool DeviceState::realized field with the enum-valued
> DeviceState::phase field. The enum has four values:
> 
> - initialized
> - realizing
> - realized
> - retired

Excellent.

I have been working on something similar.

I'd start the first patch only including:

DEVICE_PHASE_UNREALIZED (false)
DEVICE_PHASE_REALIZED (true)

Then gradually rename DEVICE_PHASE_REALIZED -> DEVICE_PHASE_CREATED
and add the DEVICE_PHASE_REALIZING and DEVICE_PHASE_RETIRED phases,
so we can discuss them during the review process.

> Realization can start only in the initialized phase. It moves the device
> to the realizing phase before invoking callbacks, preventing another
> realization attempt. Successful realization moves it to the realized
> phase; failure after realization has started moves it to the retired
> phase. Unrealization also moves a realized device to the retired phase.

So what is the difference between 'initialized' and 'retired'?

> The QOM realized property is an internal lifecycle property, not for
> end users. Replace it with the enum-valued phase property.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   qapi/common.json          |  19 ++++++++
>   include/hw/core/qdev.h    |  12 ++---
>   hw/core/qdev-clock.c      |   4 +-
>   hw/core/qdev-properties.c |   4 +-
>   hw/core/qdev.c            |  98 ++++++++++++++++++++++++++--------------
>   hw/scsi/scsi-bus.c        |   4 +-
>   qom/qom-qmp-cmds.c        |   2 +-
>   system/qdev-monitor.c     |   5 ++-
>   tests/unit/test-qdev.c    | 112 +++++++++++++++++++++++++++++++++++++++++++++-
>   9 files changed, 212 insertions(+), 48 deletions(-)
> 
> diff --git a/qapi/common.json b/qapi/common.json
> index af7e3d618a7c..88a308cbd172 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -7,6 +7,25 @@
>   # *****************
>   ##
>   
> +##
> +# @DevicePhase:
> +#
> +# An enumeration of the device phases
> +#
> +# @initialized: the initial phase
> +#
> +# @realizing: the phase during realization
> +#
> +# @realized: the phase after realization
> +#
> +# @retired: the terminal phase entered when unrealization begins or
> +#           realization fails after starting
> +#
> +# Since: 11.1
> +##
> +{ 'enum': 'DevicePhase',
> +  'data': [ 'initialized', 'realizing', 'realized', 'retired' ] }
> +


> @@ -477,10 +477,10 @@ bool qdev_unplug_blocked(DeviceState *dev, Error **errp)
>       return false;
>   }
>   
> -static bool device_get_realized(Object *obj, Error **errp)
> +static int device_get_phase(Object *obj, Error **errp)

DevicePhase

>   {
>       DeviceState *dev = DEVICE(obj);
> -    return dev->realized;
> +    return dev->phase;
>   }


> @@ -670,7 +702,6 @@ static void device_initfn(Object *obj)
>       }
>   
>       dev->instance_id_alias = -1;
> -    dev->realized = false;

Can we keep the initialization explicit? This helps when navigating
the code base.

>       dev->allow_unplug_during_migration = false;
>   
>       QLIST_INIT(&dev->gpios);

