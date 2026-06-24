Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58240CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPWJ-0002ru-Gv; Wed, 24 Jun 2026 11:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcPWH-0002rB-Sw
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:28:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcPWF-0005Cs-VS
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:28:05 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEfTxv3441283
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 15:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +CcllFIADbnJ7iDFpRkcqYANUuInZfS8zsUDMA93rBU=; b=LNFivBBU4NFQKmwA
 00pVJYg1mhjpeOgZHoLizsKpWA1gnDJsYCSokw/CXnWZ3N/VXtpVBNq1YUfXjpYe
 jVN/WfCvZmeXi98Og07L++oCc3xflVg1yiNwQuSVlKrrAvZoXIt/FDp1/uH8Xfp3
 TZu+3ivjKU6pkuczW7/vecvbvOm8S5slFSxv3TioAhMtbiWzQBq0fHtmkF0/MVpx
 +WX3lMkZGlVbJxuIhqa8oJS9vtkX17rlogYQ8XVKO7VZBvJFPdiU3FYQAVUPe9px
 nqjKrsCFZSYRpegQVbDvB4070JHdtCigufytxJBMCwsY4RLmAxsWQEey48+BSPIw
 zEhVWw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0apq1vdx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 15:28:02 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5bbd01d56ecso249565e0c.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782314881; x=1782919681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+CcllFIADbnJ7iDFpRkcqYANUuInZfS8zsUDMA93rBU=;
 b=ir1hZDnM54IFUkmB+SHXttMSGYZpmBhYhYdx7Itfl7Ku1GXFuv8K3kMHSk0DdHIDw1
 co4WjnBN+4ezFRikdhOpJrm4ZZBpmwLO4VRoEA8toTIANIB9E/QSJKxW2paZSrhySLIB
 B1KiQFgQstlli+SMXWwEcrxn95HQz/MaJW6sdU+k9cZ/jEv2uhfOZgaRH6yxmdSrhgkz
 71YEcsVw7T/Os1uqQmJCMOBElGHiTcM+fhzR3fE4l4aIu/qfDAno/Iji5fIU6ywpHbVi
 Z/C+xf1K1tSVUoo6XowOd5WG34217Hj/OijHL5nHVc5/QYCqhlFs2FvqdAsFvU+bpkbF
 woVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782314881; x=1782919681;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+CcllFIADbnJ7iDFpRkcqYANUuInZfS8zsUDMA93rBU=;
 b=fcDsB7NZIpRKrNz3qXxmPTamtg71Qb+HB4qLwxBzJFUbIl0QZ2dTYON7QGJJsRB/V+
 WI48y8bLt4dazk1bg1bsKAf6YBA1EFGWQ+t/myBt1z5jmuBDeiPag0ddAujeJGxIA8Pr
 dJU0Pm7rEDElYtr6Chue+LKrvU7KXc/0zVpr7l4mCnygIBUcNXlcGD9xrN7TjEurCtvA
 jnyZmlSkguqQbBW8oMMi8KT30BhBs9LHq4rR9SAKvDWuVATKVkJTT28H6rG3dSxwVVpC
 UqaZl2UEDiZ1p8ncAWYMesIVSF7RdqjOxet+R221z/nPzEa/miBi9LO1R0MwA2kboxfF
 IzCw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVtpPL/kHg41USHofrQToE+Xp7PFme1I5x875ibO/x4BBrrfZvvHv5y6gMSNWJlbY13/Pw0G7547UD@nongnu.org
X-Gm-Message-State: AOJu0YzTSzKtIPcIR5dQc9d/mGAFYlCfpvrRX+bsNHUQ9E/TILf26oZn
 Wyjo+MI2CopJnEdOPxwRgw1K3whc+bSbJ0fKMthjkSSXrjZgm4QU4eks0Ym6WhiP61BO/WRtj9y
 5GisAEsc5w4RV1Zka6d7lzuywfw3TRRrswfvBLWhx6prLAfiR+qNcL3D4zw==
X-Gm-Gg: AfdE7cknMdDneiV3d6troLEuxSdXQIsyzGrfoMKH9hqJn10j/buXPaj9BpMjmuF/sd2
 39KnoUYC5eCkgIcI+/KjIQxxYLR2FPPIn1orsKJGDConcJANFIcfJY4l/jmnfK6ypn9DB3zA1gd
 k8QoueEgUc6kdMAD1ufCxVnAsBNGanog6vDGnllbRhcuoZ9XxBdQcHfEtYYarvBRALQORXxbYMx
 gwF9778A4s4JkTQXlKsUvK5UDIRB3W7Gn6dVMcFN/7nfDEe6sMSxbWRM0rTwygZ03zJN4D62CxW
 kb+iHJNJipvbEGSuSde7xQ83xeRG99lg3pHul/C9FiEzV9nqvWl/UzJt/V49LHbWOgYdc+SuXjV
 +3Wu7RPRUCbhEzaKu5tx5l1timDiYRKgULuou30vwBmXisVnbE3dpxnS5xix9kw==
X-Received: by 2002:a05:6102:4412:b0:6d4:ba3e:bf97 with SMTP id
 ada2fe7eead31-72b649460bamr11327419137.4.1782314881358; 
 Wed, 24 Jun 2026 08:28:01 -0700 (PDT)
X-Received: by 2002:a05:6102:4412:b0:6d4:ba3e:bf97 with SMTP id
 ada2fe7eead31-72b649460bamr11327402137.4.1782314880845; 
 Wed, 24 Jun 2026 08:28:00 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926401a2dasm356905e9.2.2026.06.24.08.27.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 08:28:00 -0700 (PDT)
Message-ID: <fac41663-74bb-4c42-b084-b75ef08c26e7@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 17:27:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] hw/misc/vmlaunchupdate: Introduce hypervisor
 fw-cfg interface support
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: Alex Graf <graf@amazon.com>, qemu-devel@nongnu.org
References: <20260624055339.46862-1-anisinha@redhat.com>
 <20260624055339.46862-5-anisinha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260624055339.46862-5-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEyOSBTYWx0ZWRfX4Hus8/P6TpC2
 igq/usmpI2C56pfh2AsHjWbOTcnzechjknWDJqDxT5iZXUiq7MaC2jvosq3gv0pHDR0flrmSJ7c
 Gx2K4j7ukAMVLePJ+2Z83XvFc7XdEFY=
X-Proofpoint-GUID: r1TehrHvogP729LvFK81E1rm-oq-oGlC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEyOSBTYWx0ZWRfX5w4JJ84tJOMp
 Ok5Nw4bQwHil/+TUHI4uHK/+FNd7uHzf9vtVlfC7XA8FXFiZ29CSaPJhB+GJh6KnIt6Ve+xQJRU
 f/HSRA0tZmXgle7kozcOkMvZ9RcF90n9l/KVPC6APhG6CcRL5LsBk2sZTjRBtSlvZkmXaxwpIZc
 O0M7paTqJ8e35cSOGDYwmbqNoZZ1bafDWyM1Lh/SVcROdS+SyvN/1j5oNbPI2ZadSeGj45SJbLD
 5qagofQQ546M0Nr539MNpEtcEx3AmzM6fozA0Fg8EH4L4240PnugfdczAEI3SiyLj3aDfrSLjs1
 juPNySrh4MUeKTKrz3+E4sVIkQZF5z355oERMzLAlRtjsmP+OGuKf9l4vU5v0Vtho96ihc0+fZr
 C/tVxiTxYLbM9BYlGSMQpfN/EimGpQ==
X-Authority-Analysis: v=2.4 cv=NpbhtcdJ c=1 sm=1 tr=0 ts=6a3bf782 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=vggBfdFIAAAA:8 a=20KFwNOVAAAA:8 a=ichw21_qVSj6RiBJHn4A:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: r1TehrHvogP729LvFK81E1rm-oq-oGlC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240129
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

On 24/6/26 07:53, Ani Sinha wrote:
> VM launch update is a mechanism where the virtual machines can use IGVM
> file bundle to boot into a trusted execution environment without
> having to depend on a untrusted party to provide the IGVM bundle or firmware
> image. This is particularly useful for confidential virtual machines that
> are deployed in the cloud where the tenant and the cloud provider are two
> different entities. In this scenario, virtual machines can bring their own
> trusted IGVM file containing a trusted firmware image
> bundled as a part of their filesystem and then use this hypervisor interface
> to update to a trusted and deterministic boot state.
> This also allows the guests to have a consistent measurements on the firmware
> image.
> 
> Currently, this mechanism only works if the VM was started with IGVM in the
> first place.
> 
> This change introduces support for the fw-cfg based hypervisor interface
> and the corresponding device.The change also includes the
> specification document for this interface. The interface is made generic
> enough so that guests are free to use their own ABI to pass required
> information between initial and trusted execution contexts (where they are
> running their own trusted boot state) without the hypervisor getting
> involved in between.
> 
> Currently, this device is only supported for x86 machines. Presence of
> IGVM host libraries is also required for parsing IGVM files. Hence, the device
> cannot be initialized for other machine types or hosts where IGVM support
> is not present. Trying to initialize it for arm for example will lead to failure:
> 
> $ ./qemu-system-arm -device vm-launch-update -machine virt
> qemu-system-arm: -device vmfwupdate: This machine does not support vm-launch-update device
> 
> Functional and qtests will be added in a subsequent patch.
> 
> CC: Alex Graf <graf@amazon.com>
> CC: Gerd Hoffman <kraxel@redhat.com>
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   hw/misc/meson.build              |   3 +
>   hw/misc/trace-events             |   5 +
>   hw/misc/vmlaunchupdate.c         | 236 +++++++++++++++++++++++++++++++
>   include/hw/misc/vmlaunchupdate.h |  85 +++++++++++
>   include/system/igvm.h            |   2 +
>   5 files changed, 331 insertions(+)
>   create mode 100644 hw/misc/vmlaunchupdate.c
>   create mode 100644 include/hw/misc/vmlaunchupdate.h


> diff --git a/include/hw/misc/vmlaunchupdate.h b/include/hw/misc/vmlaunchupdate.h
> new file mode 100644
> index 0000000000..1d13f4b176
> --- /dev/null
> +++ b/include/hw/misc/vmlaunchupdate.h
> @@ -0,0 +1,85 @@
> +/*
> + * Guest driven VM launch state update device via IGVM.
> + * For details and specification, please look at docs/specs/vmlaunchupdate.rst.
> + *
> + * Copyright (C) 2026 Red Hat, Inc.
> + *
> + * Authors: Ani Sinha <anisinha@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +#ifndef VMLAUNCHUPDATE_H
> +#define VMLAUNCHUPDATE_H
> +
> +#include "hw/core/qdev.h"
> +#include "qom/object.h"
> +#include "qemu/units.h"
> +#include "system/igvm-cfg.h"
> +
> +#define TYPE_VMLAUNCHUPDATE "vm-launch-update"
> +
> +/* fw-cfg file definition */
> +#define FILE_VMLAUNCHUPDATE "etc/vmlaunchupdate"
> +
> +/* version */
> +#define VM_LAUNCHUPDATE_VERSION 0x01
> +
> +/* format bits, used by both 'capabilities' and 'control'  */
> +
> +/* igvm */
> +#define VM_LAUNCHUPDATE_FORMAT_IGVM           (1ULL << 32)
> +
> +/* 'control' field bits  */
> +
> +/* disable vmlaunchupdate interface */
> +#define VM_LAUNCHUPDATE_CTL_DISABLE            (1 << 0)
> +
> +typedef struct {
> +    /* api version */
> +    uint16_t version;
> +
> +    /* VMM capabilities, read-only. */
> +    uint64_t capabilities;
> +    /* control bits, see VMFWUPDATE_CTL_* */
> +    uint64_t control;
> +
> +    /*
> +     * address and size of the IGVM image.  Will be cleared when
> +     * the write completes successfully and IGVM file is correctly parsed.
> +     */
> +    uint64_t fw_image_addr;
> +    uint32_t fw_image_size;
> +
> +    /*
> +     * address + size of opaque blob.  The guest can use this to pass on
> +     * information, for example which memory region the linux kernel has been
> +     * loaded to.  writable, will be kept intact on firmware update.
> +     */
> +    uint64_t opaque_addr;
> +    uint64_t opaque_size;
> +
> +} VMLaunchUpdate;
> +
> +typedef struct VMLaunchUpdateState {
> +    DeviceState parent_obj;
> +    VMLaunchUpdate launch_update;
> +    ResettableState reset_state;
> +} VMLaunchUpdateState;
> +
> +
> +typedef struct VMLaunchUpdateStateClass {
> +    ObjectClass parent_class;
> +} VMLaunchUpdateStateClass;
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(VMLaunchUpdateState, VMLAUNCHUPDATE);
> +
> +/* returns NULL unless there is exactly one device */
> +static inline VMLaunchUpdateState *vm_launchupdate_find(void)
> +{
> +    Object *o = object_resolve_path_type("", TYPE_VMLAUNCHUPDATE, NULL);
> +
> +    return o ? VMLAUNCHUPDATE(o) : NULL;
> +}

Is this inline really justified?

> +
> +#endif


