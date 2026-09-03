Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D220C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AhA-0005NF-8l; Thu, 03 Sep 2026 12:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2Ah8-0005Mr-NO
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:53:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2Ah5-0008FC-IJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:53:46 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G31Ka280697
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 16:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Wboi+wIVgRTG+iXNf2DFSP1guucIb+O7csq25SczvkI=; b=WuMZQJFCnJ/yu/Hw
 rB3XvdBeazZ8sWcKuqJnuMQvLs3oCT6BOzVijd7gQRKov9WoRUAT04SV/6h+ZQZc
 gfgfnvMFQC/YXZbsSbzL5hbPlG2gToWhIJQ8xMX5wQ2B5lscwtv0EaANCRmoTQFb
 ReUW+FKqh01ZSWWuR3NIPT6wAPyddyJichItjPZEvkAPxrV3oxF48CkC2ntVnUUw
 lzDZ9MNZYTo8RIOcDrQVtkS7bO8TUbHrrGZBLKeM8gqxBqHGDsfYV9fZx6Y/NhnH
 oDsaKRnJa93RNi/61ZDED300yBF/9Q9sXCYst5BE+KL1+PU3QMnpJx/2+GDxRcP+
 NdoPag==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf0gjubff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 16:53:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39af92138f9so57715a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788454414; x=1789059214; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wboi+wIVgRTG+iXNf2DFSP1guucIb+O7csq25SczvkI=;
 b=D11ctO1eSfg2omVp7GFVFKYQ67COhkfate8/4WnzL7G8U0HWZLK0dsMaZyZvMRR3Er
 Z5YfYefdW7BlYYVhfq4BG3zKk6vLNHULCKABXllBA421bbRX6UAU7R/9XvjFGoJHVRlW
 2mTAZGBLBNxAgb95oAav4/sl5bi2nvS8JkOhltcoSVfm4gUysfVg9mxTyYzfMmqxAtth
 qj9F/unWkLMJr7tL6xeJesAKBlhEjDQfqXyfVE9uuqpfdyb+T1l/CE15eNu6+GM5ocIu
 WWhrQ4My795gZVO5Sd5Cp9o7cR3fLMhLluHtGbW+UZqdVgtqh0XfPEK6F2o9x/sd93MG
 /wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788454414; x=1789059214;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wboi+wIVgRTG+iXNf2DFSP1guucIb+O7csq25SczvkI=;
 b=oDqJZD0gTkd2+brscNc7g5CxZ6E4/lACMcJm63fsW2+LoF0f/CViwA6pGnbCbTfA16
 UHlKyfKlPidfwIrIyApTG9ge911gE1lCt6n8NM5IrmIt/RDs9hAhDlIRlKnUd3zj1gPY
 MhIXuvFI4S0MeeYoFXGiCTMoiVceZ9B/JGLxoJDVyFkyxPNPGg8rDd79Ueo0F+aR2ZdY
 /cLn7zXceTo9+9aOqbobYaElZVaP+z+CZ3oVtrrIyX/8mZ/xaCNnl57hVVpVHOOI/2Eq
 Fp71jFsZpf6WzL4fgBMl9EVCKTd84gfXVFoPK+cH28EWv4w2/qtRKsZV1lr9xb2FXs32
 KDAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0eAoRIXOAhCkBSnrCNvghsQP0EATEIWSNpmTiv+RDmhDVkUltTxbpK/vcV9Pt2UUQJVIB4+1PA3Xl@nongnu.org
X-Gm-Message-State: AFuF++mrr5Hp+yV1gZ6GxeMNzCXWlma9HxgRkPApobcPCzFMaDyDI6Zl
 xNG3RpUlMp3S8dFwvk9BNTwHhmtEuRiC+A8bXyOGP9Z/g1QrQalyyYe54XdptDDvv6Vek5zhZ+T
 foGdi/oti6LaAvNrk+3nl/Ux6idOZ8TcQ0wOCRou/XjgFX6H5qzZzX3PvJQ==
X-Gm-Gg: AYBFou1NWjthll2vzbZYh7Ka5Cxwmu1KDZ1nUYCKqHAz9cTJggxc5ngCqNshq36wy1V
 UjuJ7sPEZJpB5VWhMPxQ2FVDP503hAbKI5Yl+FQcXi5hcW5MSJhSlbilLjBO32d3UgL1sLafaDr
 nFCqr+wSc1Adzpe4i2VXSJo90XPeMZsXIwrP0wpwoH4CUIHCf3Ir1hjvRYKG7dRyVazK00q/AlP
 RYu7ZJDBEs/VhXE7fNK2/G8vqpPUlBXio8b+MZWuNevUoepPt1CHLAnjJxgd6x99/LNC3uE2dLq
 qb8hga5h/fg8Nh8eHrvrLpFwR8hnyy3OMYN+hxjbViljWgKO1D5dtADawlS2IZLm7vPpVKzh9HY
 aKOELcHKMefmb9QDGRer1Cm2Q/pVU0Nq8uzzovlxR7OmO3x50hPQHgJpYiq8HtnqU0D1k
X-Received: by 2002:a17:90b:4b04:b0:396:4ce0:6400 with SMTP id
 98e67ed59e1d1-39b07f33963mr8662303a91.2.1788454414382; 
 Thu, 03 Sep 2026 09:53:34 -0700 (PDT)
X-Received: by 2002:a17:90b:4b04:b0:396:4ce0:6400 with SMTP id
 98e67ed59e1d1-39b07f33963mr8662261a91.2.1788454413752; 
 Thu, 03 Sep 2026 09:53:33 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-143243908a9sm525004c88.9.2026.09.03.09.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 09:53:32 -0700 (PDT)
Message-ID: <33b35d50-d726-4234-8a47-2aaf177d4c5e@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 09:53:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] target-info: remove machine_typename
To: luoyonggang@gmail.com
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <8a68284e-7947-4766-a42a-6dca3e1a4e01@oss.qualcomm.com>
 <CAE2XoE_zkdFEFLp_eaKbX0ftROPJXxGQvv81z6CQrdjx2k5Y8g@mail.gmail.com>
 <44d0f561-e713-420a-a648-c7199b20425a@oss.qualcomm.com>
 <CAE2XoE866Oi_LKi=U10HdOB4TZwgni7R28foJsv203KavhdRtQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE866Oi_LKi=U10HdOB4TZwgni7R28foJsv203KavhdRtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0NyBTYWx0ZWRfX33MUCMb9IDO8
 4r+y3vBBv1MTaDVPTcT04MZHtJXkmiAMi05lzkysbbmN8p1Y1OXUSJyABQB7pMBwJERjpA1rESi
 C7W5y2kpbkegxb56+q593qdPfHVEB922pe5Pu/nIjqBE53NMc79ZA2wXqDme0FZTSepn8txrjM8
 jeT7j89vGhp8xuJ1RXeQLj+QZZ/vGSVyEmoEJWO40WXFWSfit1RCKkNDt+9GNCtkN42A8ZY6Iu1
 fP046b5m+baIocrDS35LKHPuq9sExv4BqhsI371IzOXR0McE/4wEB5H08q7xb+6lUB0HboAcs+Q
 ePBHnuOar7ptKa8a/Y9Z97ydpzLonI1HyL2TfGidmWTxpDt5Mcy/wcJWbWoBszG65zY+pV5Rga9
 5L8a8u29NTbcHAoo5T2Pl2Zt2VQ08X6EQ0KIUQJ/vE+dNvbVKeXkV8CYTFeXjPuKythhxoDGahf
 7FXLs5oI9gZWRfwYPMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0NyBTYWx0ZWRfXzKdXMlwnRWWo
 pDcIgftWot15rkRzlYU82FvkwdWIj+5+HGNpWS18oAS9PVpnqVlwF6PKFVSrcnxAAxCPxhBU/UN
 HgPHpG/Xgb1zz1/D1DyVim/MHVsX5v0=
X-Proofpoint-GUID: qg6GFsE4kZ6jr8CvEScirq89Vp-fkR8W
X-Proofpoint-ORIG-GUID: qg6GFsE4kZ6jr8CvEScirq89Vp-fkR8W
X-Authority-Analysis: v=2.4 cv=LZ4MLDfi c=1 sm=1 tr=0 ts=6a99a614 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=GaQpPoNlAAAA:8 a=uIo69F_qTj7Wrr0vOowA:9 a=lqcHg5cX4UMA:10
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030147
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

On 9/3/2026 9:42 AM, Yonggang Luo wrote:
> 
> 
> On Fri, Sep 4, 2026 at 12:28 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>>
>> On 9/3/2026 3:33 AM, Yonggang Luo wrote:
>> >
>> >
>> >>
>> >> > Pierrick Bouvier (14):
>> >> >    qom/object: add is_available callback to TypeInfo
>> >>
>> >
>> > Patches for is_available callback to TypeInfo, it's can be merged latter
>> >
>>
>> It's needed because files in patch 2 already depend on existing
>> filtering mechanism to distinguish between arm and aarch64.
>> We found other places where such filter could be used to specify target
>> related types within a single C file, thus allowing to remove #ifdef
>> TARGET_X easily.
>>
>> > The reason is for the following command to execute:
>> >
>> > we need add target_info_select and pass TargetInfo to is_available
>> >
>> > - Move target_info() into qom/object.c. Default to SYS_EMU_TARGET_NONE
>> >   until a real target is selected.
>> > - Add target_info_select(); it may be called only once with a non-NULL
>> >   TargetInfo that is not SYS_EMU_TARGET_NONE.
>> > - Invoke TypeInfo.is_available after select, passing target_info().
>> > - Change target_* helpers to take const TargetInfo *.
>>
>> We can wait to have a need for this. As long as there is no
>> heterogeneous support, it's safe to assume there is a single target
>> active globally.
> 
> 
> Because we would have more and more usage of target_* , that's why I
> would suggest merge it as early as possible. I means directly usage of
> these functions.
> Not use is_avaible, for example:
> 
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -420,7 +420,7 @@ static void aspeed_soc_ast2700_init(Object *obj)
>      }
>  
>      for (i = 0; i < sc->num_cpus; i++) {
> -        if (qtest_enabled() && !target_aarch64()) {
> +        if (qtest_enabled() && !target_aarch64(target_info())) {
>              /*
>               * Introspection qtest just want to create this object
>               * without realizing it. ARM_CPU_TYPE_NAME("cortex-a35")
> @@ -703,7 +703,7 @@ static void aspeed_soc_ast2700_realize(DeviceState
> *dev, Error **errp)
>      qemu_irq irq;
>      int uart;
>  
> -    if (qtest_enabled() && !target_aarch64()) {
> +    if (qtest_enabled() && !target_aarch64(target_info())) {
>          g_assert_not_reached();
>      }
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0871a35e11f..dbdf55dfea9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -4132,7 +4132,7 @@ static GPtrArray *virt_get_valid_cpu_types(const
> MachineState *ms)
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max-v8")));
>      }
> -    if (tcg_enabled() && target_aarch64()) {
> +    if (tcg_enabled() && target_aarch64(target_info())) {
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a35")));
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a55")));
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a72")));
> @@ -4144,7 +4144,7 @@ static GPtrArray *virt_get_valid_cpu_types(const
> MachineState *ms)
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max-v9")));
>      }
> -    if (target_aarch64()) {
> +    if (target_aarch64(target_info())) {
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
>          if (kvm_enabled() || hvf_enabled() || whpx_enabled()) {
> diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
> index 88d01960a01..2a924cab4f7 100644
> --- a/hw/nitro/machine.c
> +++ b/hw/nitro/machine.c
> @@ -97,7 +97,7 @@ static char *build_eif(const char *kernel_data, gsize
> kernel_size,
>      hdr = (EifHeader) {
>          .magic = EIF_MAGIC,
>          .version = cpu_to_be16(4),
> -        .flags = cpu_to_be16(target_aarch64() ? EIF_HDR_ARCH_ARM64 : 0),
> +        .flags = cpu_to_be16(target_aarch64(target_info()) ?
> EIF_HDR_ARCH_ARM64 : 0),
>      };
>  
>      g_byte_array_append(buf, (const uint8_t *)&hdr, sizeof(hdr));
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c15f2b9f084..26003f2b4df 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2888,7 +2888,7 @@ void pci_qdev_property_add_specifics(DeviceClass *dc)
>      ObjectClass *oc = OBJECT_CLASS(dc);
>  
>      /* The loadparm property is only supported on s390x */
> -    if (target_s390x()) {
> +    if (target_s390x(target_info())) {
>          object_class_property_add_str(oc, "loadparm",
>                                        pci_qdev_property_get_loadparm,
>                                        pci_qdev_property_set_loadparm);
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index a42f7d8e77d..31170e87a33 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -3190,7 +3190,7 @@ static void
> scsi_property_add_specifics(DeviceClass *dc)
>      ObjectClass *oc = OBJECT_CLASS(dc);
>  
>      /* The loadparm property is only supported on s390x */
> -    if (target_s390x()) {
> +    if (target_s390x(target_info())) {
>          object_class_property_add_str(oc, "loadparm",
>                                        scsi_property_get_loadparm,
>                                        scsi_property_set_loadparm);
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index a06cbf3c646..3d747b470cc 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -54,7 +54,7 @@ bool vfio_load_config_after_iter(VFIODevice *vbasedev)
>       * See commit d329f5032e17 ("vfio: Move the saving of the config
> space to
>       * the right place in VFIO migration").
>       */
> -    return target_base_arm();
> +    return target_base_arm(target_info());
>  }
>  
>  /* type safety */
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 2881cec72d9..3383af64859 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2631,7 +2631,7 @@ static int vhost_user_backend_init(struct
> vhost_dev *dev, void *opaque,
>                  return -EINVAL;
>              }
>  
> -            const uint64_t vhost_user_max_ram_slots = target_base_ppc() ?
> +            const uint64_t vhost_user_max_ram_slots =
> target_base_ppc(target_info()) ?
>                  SPAPR_MAX_RAM_SLOTS : VHOST_USER_MAX_RAM_SLOTS;
>              u->user->memory_slots = MIN(ram_slots,
> vhost_user_max_ram_slots);
>          }
> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-
> impl.h
> index cf42aabbc8b..61404baa4b5 100644
> --- a/include/qemu/target-info-impl.h
> 
> 
> any way, we can wait the following pull to be merged first
> 
> [PULL 00/51] Misc HW/accel patches for 2026-09-03
> https://patchew.org/QEMU/20260903103936.62355-1-philmd@oss.qualcomm.com/
> <https://patchew.org/QEMU/20260903103936.62355-1-philmd@oss.qualcomm.com/>
> 
> 
> and a better way to deal with it would be appreciated.
> 
> I also have patches for riscv needs this.
>

As I mentioned in our private discussion, we understood that some
members of our community don't see the need to introduce the
single-binary in its current form. We take note about this, and decided
to not upstream it. As a consequence, it's not needed to filter *all*
the types, like what previous series were trying to do.

It does not mean we stop working on this topic, simply that we'll keep
this binary downstream until we have heterogeneous emulation ready.

That said, feel free to iterate and send a series on your own. I don't
see any possibility of change in existing opinions, so be prepared to
swim against the tide.

Also, I'll be off next week, so don't be surprised if you don't see any
answer from me.

> 
> 
> --
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo

Regards,
Pierrick

