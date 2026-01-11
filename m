Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F44AD25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 21:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3EC-0007qX-Jq; Sun, 11 Jan 2026 16:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vf3EB-0007pm-4g
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:44:03 -0500
Received: from p-east2-cluster3-host10-snip4-7.eps.apple.com ([57.103.77.148]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vf3E9-0000i3-6g
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:44:02 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-5 (Postfix) with ESMTPS id
 D268818000A0; Sun, 11 Jan 2026 21:43:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=rcV0qxySQmhYiXqEdaNW5NLH6cMSDMa8IAtnH9SZBj0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=ABnRDHWRbKet69P27/5VML8FEhdlvoT7hq6eM9aVavQ53JQ5Po87GF2nmH9AWJnr2dcVAXRQBRDDwr2r/M/wpsLTfx9osf7MjboB5TJ5066S09SmrmmpeVmykml+4AdrdQw0OCSIELZpRwAUOZmyd5qMm+5tJXeG81bx8z4UAt4HeNR2f6nolK14AGHBH5gFebDCAwVV6tUbdRugol4ZoftqQe8WNNCLq17dr5OoujRXC8avfTYDDk3uXRlR5YEdbdG7O9MmCNtkuHzDA+e/FqZsYoGUeG15N0lHjElp4MOrb00BGf1ahB+CSTtJy0u7Cv58kLjaFC/DtW8Y5sMOwQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-5 (Postfix) with ESMTPSA id
 518741800111; Sun, 11 Jan 2026 21:43:49 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v7 17/36] hw/arm/virt: Set msi-gpa property
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260111195508.106943-18-skolothumtho@nvidia.com>
Date: Sun, 11 Jan 2026 22:43:37 +0100
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, clg@redhat.com, alex@shazbot.org,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <526B3AB7-B0D4-4104-AF8F-012ED34EC990@unpredictable.fr>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-18-skolothumtho@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-GUID: fe-W5KpKPNRIPx4GfEU7NIwyJB1--SBA
X-Proofpoint-ORIG-GUID: fe-W5KpKPNRIPx4GfEU7NIwyJB1--SBA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTExMDIwMCBTYWx0ZWRfX6TZnHQHYuo58
 Rg450e9TWFS+HXdZecqVxyAKBPXtsuqE7Wshm6majC3TTnt1X7ObWJ1lmQJHLlXse0iyze2iJzZ
 iWY2YeJ8HirmO4nOcyESr9W5z0eClMUgbI/Q057Yh83DGdUyh3WoNKwgPVNZzVh+Cj3zUlybrgk
 nm32XMSfOmr+iTtbIPIaxIfPXqdqzytGX3Ta0Ssv63PQjioSsJwMMBI87UzgJElYbFWhlilw7z3
 VRDRcJwgQI+noMpvFOmb4jbgnSgZZmaB5wIQRVJ+oQ2Bc9dsB8ipJVGjXOQfKPLhzf9N3ULMjey
 NCukQBbl7aWLVtn1/Kk
X-Authority-Info: v=2.4 cv=QoRTHFyd c=1 sm=1 tr=0 ts=6964199b
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ikd4Dj_1AAAA:8 a=CVcQco4xPi_mWXQEgksA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-11_08,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 clxscore=1030 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601110200
X-JNJ: AAAAAAABsfI3K8Fku3NvqCAKESoT1rHQGW+KRyYbsFzVh/VCW1KRXWpCXLo2Qn/5vlorZTeoUFr1Q0uh95JZjpdvf3ke8F6JhXka3S9S3Gw07dd9zQd5Uo0Wno6eiiGZjd+w9s8zBfJ5EnE6PYf0y35SDdYuSW5uslNezOqh46pohxP1/m68cF0EahjG2/Z9mhLDcrjkVRY0LzPx1KYF7shGkZkLxrpKz+PoODYkc6B/hlz1haZqSrltEiqembha0NQJuHWFksX/a35KiWt3kPGXI5zeRngymjPuSH3eFptnXsw1BEz9h7MS5GY6o0qP+RjR5UNkQIPBlhv8hDK51+q+elnMRtpAiLOz9tabGJOPukeRUFEAXIYIfkvjAF0as8PdMCsEmyFttRHIJAcDGPMboAp7IoLTmHhCJ2ZtrQFP9I6PnQ5iNpTijDp3UwFQkizl0emDcktA6lE+BXOawHOD0+bFpRFQ+0wqMt6ob0+SWr8DzQEvc9jze8sFxaYCyvNOkKMnIlyn9cPUW5ywPnevaloiS4vPOb+AixggTJu7BqVzRyKcMy8ZGlD9xzIFJydevkXnYvxWS6zbXjVbO8+Z9KrNmB7p46fiUCQMMfQGJADzW/4z+3In/LLDFJ5tFxdnN6MmHdRTuT3hDd/eyRHcEyuFiWzvzpHpOBVLNNaYL3p4ZYaX30ondUUdPn/gRT0uLT79sAz3Kr7FxSCuUpJZ+VEo5dqbp26lvCKACxX1+sxlEwHtQxcNkizRSgDzOvYhDmY2LWcFiS/3csGRGVZymTMBdXAPTmEbVXpEehWC6Ve+DSTi0Zp3L38VDt8dqpr9s5F6TlQ9/Zc=
Received-SPF: pass client-ip=57.103.77.148;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 11. Jan 2026, at 20:53, Shameer Kolothum <skolothumtho@nvidia.com> =
wrote:
>=20
> Set the MSI doorbell GPA property for accelerated SMMUv3 devices for =
use
> by KVM MSI setup. Also, since any meaningful use of vfio-pci devices =
with
> an accelerated SMMUv3 requires both KVM and a kernel irqchip, ensure
> those are specified when accel=3Don is selected.
>=20
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
> hw/arm/virt.c | 20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9d0568a7d5..08feadf0a8 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3052,6 +3052,26 @@ static void =
virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>             /* The new SMMUv3 device is specific to the PCI bus */
>             object_property_set_bool(OBJECT(dev), "smmu_per_bus", =
true, NULL);
>         }
> +        if (object_property_find(OBJECT(dev), "accel") &&
> +            object_property_get_bool(OBJECT(dev), "accel", =
&error_abort)) {
> +            hwaddr db_start;
> +
> +            if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
> +                error_setg(errp, "SMMUv3 accel=3Don requires KVM with =
"
> +                           "kernel-irqchip=3Don support");
> +                    return;
> +            }
> +
> +            if (vms->msi_controller =3D=3D VIRT_MSI_CTRL_ITS) {
> +                /* GITS_TRANSLATER page + offset */
> +                db_start =3D base_memmap[VIRT_GIC_ITS].base + 0x10000 =
+ 0x40;
> +            } else {
> +                /* MSI_SETSPI_NS page + offset */
> +                db_start =3D base_memmap[VIRT_GIC_V2M].base + 0x40;
> +            }
Hello,

Currently (but soon no longer the case for virt-11.0+), its=3Doff means =
no MSI controller at all instead of
GICv3 + GICv2m.=20

Would an else if with an error returned if no MSI controller is enabled =
be adequate?

> +            object_property_set_uint(OBJECT(dev), "msi-gpa", =
db_start,
> +                                     &error_abort);
> +        }
>     }
> }
>=20
> --=20
> 2.43.0
>=20
>=20


