Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FA7CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 09:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9DU-00056S-LZ; Thu, 18 Jun 2026 05:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wa9DT-00055j-6y
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 05:39:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wa9DR-0007bN-6E
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 05:39:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I9Yg7s1424194
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 09:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q/02FjgiSWxfq6+yFcT3iy3L6YQav6jkJNu4ZY4j2bQ=; b=NFyPFftgCMoECh3K
 DoI8I4DYtOyWiuEbCHpx3FzsWkNmKFxai28hEf3DAkrQ2TOE7Sff0RxxhClL/32n
 3jE7xfhsIOuMSte2k+3K5WpvOEhJISqHviinZpmowIdM7bVdWOqDCNae/JAvl9Ej
 SIpf+73fmxcVSUr5EOX+W7L+Qi862jw4iWLY06PVoKP9sF294Zaal5Q6SyaGA6RP
 gl1ViJzQt2ygS4dlfzDQAVsKZ2SZCXAdy7zkgsxMUGEzeisk+nhsFSU6Omeq2DtU
 XmPvHMnVSlFAjUf+IZESz+PW+1k6LNYcnaKVZ2onsaQXWnvQ5SEcZKzFBYBU3XLP
 OKPtKw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2juxqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 09:39:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9156cb14b1cso131937985a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781775555; x=1782380355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q/02FjgiSWxfq6+yFcT3iy3L6YQav6jkJNu4ZY4j2bQ=;
 b=YDA5B1rD0rflO+c7CUZnQnTmcsKygKhOei9Lw+KRYYj4YcssgdvX84qK78j6q7RXZP
 DthEVRTm0p6qbtmBATl5beCpJWuONAMy+bRTF+fWBduaOZG/FAkTd4Ggn4QZ95+x3lHq
 DA0ZHEY48KGqbcjC117Rptdg4Xj3SifgrhWdSEFt9gR7jie0l5zgIfDDw4viUPPSZtHg
 auGJwlEteuwv+DGjX8cWC2ra3chGJsZmlJKNBrZGfJz7CuwgRpAsE6X9TvcltosROc3I
 RV2641m7XCfXYeE/IQER/UqbXW3HqwXwUfEIMEKQd0vNDn4mzh1x+w93WxV+PlcNelrn
 3YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781775555; x=1782380355;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q/02FjgiSWxfq6+yFcT3iy3L6YQav6jkJNu4ZY4j2bQ=;
 b=s29mp4jQU1wY5ZIQgYwmBP/2PD2PdZsoXIC5CFAeITdVNnfRRZaQWuMbYzlBHCFKZd
 xTNRM3LAkNzzkRxYyQIbG32LsHOpQIf2wnwHfXUrea2kdJ7teFajQ4lneIldNWa/WSQy
 blUEigvkR8q1e7KZLHfVLDaHWgX+JJBjhxhJ9YHsib8QMfpXLsb9CmSJREnMGC5Jmt35
 x8zrbDdlgrVWsabYlwgigSc4nj6f814aZXMMbRLtoDZTo6IGrsVOSMCAjiTDX1bz0vUj
 TnhFvVAwlgMrNnwRFLcYYEZiMqlIGU50TPKBlQ2E/3XpEe3HK2fXgv7/2WELkXapDEuU
 2lsw==
X-Gm-Message-State: AOJu0YxLhglQ6KqowV3o3OnGQFxh6WvxmjhELARTbModivQwUBfM9n7W
 itLPajc+MlNFR4jONSWpGH09KGOtNKKpWnhLtR/1PZvm6HDI53IW+l4LxfbVxfrH3hQqTcH/JDO
 hNf7cfgD7s2JbFexYpArKI9BUHBxyA9YVwH7O6vK01v8JCX86ymMfL2tkfO0ZDPERgA==
X-Gm-Gg: Acq92OH+iPT0CFtVLkT5sClIcsFsfrZc/gsL7CyUtJEM3h/P51tzpiR0Hk/N+80oirS
 zDZ+5FNGJFmavY81NMC+Em0smXWvMdR65dj0AQtbLIIaQCP47TSmg0CqLI2KgbJytkmBVjqJoNr
 yBZ0wbzjyvWmnOisU7cZlihUWCzV26RwaJyDntWWUxs/amXk09+o3Vyi1EvvOtA5KskNdkz2eGW
 tpjGxud2gPTXx5oSoMhlT+FXc4wLRMxcIvy5ejYGFYEfCHFWfxvbvRnQN8Bi7LH0elR1SHgeBuF
 Zzchn9XLPbvC3HKU1KHhGdo4hbp4Xy9O6S1SJl1eViasyYRhQY5aolqQpmLmSjoxpn5Nu9Bh8uv
 0PvZOHWHEKg7EKBg0TtOs4HtDGGWvYTeQmTJ0IUeJ3U/Sf/xY1LYB1DxHtEatBw==
X-Received: by 2002:a05:620a:480c:b0:914:e3dd:17ea with SMTP id
 af79cd13be357-91f25f9351dmr455483585a.12.1781775554874; 
 Thu, 18 Jun 2026 02:39:14 -0700 (PDT)
X-Received: by 2002:a05:620a:480c:b0:914:e3dd:17ea with SMTP id
 af79cd13be357-91f25f9351dmr455477885a.12.1781775554151; 
 Thu, 18 Jun 2026 02:39:14 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49234daafc7sm114457865e9.10.2026.06.18.02.39.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 02:39:13 -0700 (PDT)
Message-ID: <f67389ae-4b0e-46f5-a122-d83464f192f4@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 11:39:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/13] device-core: use atomic_set on .realized property
Content-Language: en-US
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20201006123904.610658-1-mlevitsk@redhat.com>
 <20201006123904.610658-10-mlevitsk@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20201006123904.610658-10-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4OSBTYWx0ZWRfX6ZMJxc4t5E9k
 lAVdhw1haEJiLDBhAUD7psDcMXpfJpkP0iDnQo9aK9V54eBxMXJVNHOnv1m023/I2I+szbd4XPq
 qBZJsGKrZPja49i0ofdDchIf2LXD24bcloDc3oNj7/RQtxV+IgPZ/vBRBfPlJzsCrFyY1lXYdEj
 jgy6zF94TRNaUk+hfMBcR6bOrDn8OmbBPLniUh4uXItMARV9hkmbgSol89cXn9drNVS+6VyIV6m
 N+Z735OVYyA2Wdic6j+cyoOn+PxiZxyN3QR7iB0roVUEVZFs9Ik1SGZ4Fc7B5PAnXVMsqiaadKl
 GKHnET8Cd+4a6TBbmbrjz2XeFDngcByoS+3YdsB8fAuD0Vm4y113jFaV3MKsOOxy8hk1AmNhlbX
 zvDVPsC4AUq2y2LBcbIVsDMf3E05UK92cyV3PS/JzTMwo4iYlE4stc9T+50ccAQcUTB/9m3YMTe
 0Qk/DVi02pyUVvxrNEQ==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a33bcc3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=32-H8ij_xs7o3GReVWsA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DA_wE6bmocxMLhImwgprgUUvOLh0wrHw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4OSBTYWx0ZWRfX3WyJ7frrngd4
 EPGNHEkRIYELE2kIZSWm5QocrHkWC4O0O7n1rPEfoVJsaorPGs1uaEr7F3VLB1OWpEli23kRnEy
 1vXqhm3LdSWAkVRalscbqAGbMZi1Vtw=
X-Proofpoint-GUID: DA_wE6bmocxMLhImwgprgUUvOLh0wrHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180089
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

Hi,

Old patch committed as a23151e8cc8 (Oct 2020).
I'm revisiting it in the context of dynamic heterogeneous machines.

On 6/10/20 14:39, Maxim Levitsky wrote:
> Some code might race with placement of new devices on a bus.

So IIUC at least 2 vCPUs plug distinct devices on the same bus,
and the problem is the bus slot assigned for the device. What is
deciding the free slot, the guest code or QEMU?

> We currently first place a (unrealized) device on the bus
> and then realize it.

Sound like ill design. Maybe resulting from the unclear definition
on what "realized" means. "Guest visible"? "Wired on some bus"?

Something I tried to clarify once (now outdated):
https://lore.kernel.org/qemu-devel/20240209123226.32576-1-philmd@linaro.org/

A vCPU thread shouldn't poke at QOM/QDev internals. When it accesses
a device (to check "is it out of reset?"), this is already existing
realized.

Actually, when the guest asks to assign the device to the bus, the
device is already existing (from guest PoV), so must be realized.

> As a workaround, users that scan the child device list, can
> check the realized property to see if it is safe to access such a device.
> Use an atomic write here too to aid with this.

I'd appreciate to be pointed at real use case we fixed here, to
better figure what could be reworked on the QBus / QDev layer in
order to not depend anymore on this workaround.

> A separate discussion is what to do with devices that are unrealized:
> It looks like for this case we only call the hotplug handler's unplug
> callback and its up to it to unrealize the device.

Likely the hotplugging path is what needs to be improved (I'm seeing
a similar problem with vCPU hotplug).

Thanks,

Phil.

> An atomic operation doesn't cause harm for this code path though.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-Id: <20200913160259.32145-6-mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/core/qdev.c         | 19 ++++++++++++++++++-
>   include/hw/qdev-core.h |  2 ++
>   2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 59e5e710b7..fc4daa36fa 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -946,7 +946,25 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>               }
>          }
>   
> +       qatomic_store_release(&dev->realized, value);
> +
>       } else if (!value && dev->realized) {
> +
> +        /*
> +         * Change the value so that any concurrent users are aware
> +         * that the device is going to be unrealized
> +         *
> +         * TODO: change .realized property to enum that states
> +         * each phase of the device realization/unrealization
> +         */
> +
> +        qatomic_set(&dev->realized, value);
> +        /*
> +         * Ensure that concurrent users see this update prior to
> +         * any other changes done by unrealize.
> +         */
> +        smp_wmb();
> +
>           QLIST_FOREACH(bus, &dev->child_bus, sibling) {
>               qbus_unrealize(bus);
>           }
> @@ -961,7 +979,6 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>       }
>   
>       assert(local_err == NULL);
> -    dev->realized = value;
>       return;
>   
>   child_realize_fail:
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 2c6307e3ed..868973319e 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -163,6 +163,8 @@ struct NamedClockList {
>   /**
>    * DeviceState:
>    * @realized: Indicates whether the device has been fully constructed.
> + *            When accessed outsize big qemu lock, must be accessed with
> + *            atomic_load_acquire()
>    * @reset: ResettableState for the device; handled by Resettable interface.
>    *
>    * This structure should not be accessed directly.  We declare it here


