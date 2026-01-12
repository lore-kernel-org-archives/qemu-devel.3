Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4596AD26D97
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfF0P-00015x-Gf; Mon, 12 Jan 2026 05:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vfF0A-0000zo-ML
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:18:25 -0500
Received: from qs-2001i-snip4-1.eps.apple.com ([57.103.87.84]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vfF05-0007lw-Hp
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:18:22 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-2 (Postfix) with ESMTPS id
 8119118000AA; Mon, 12 Jan 2026 10:18:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=abB225qvJ9BB1OiVaUt+EK2bMAyAMeH3O+UWphfh+R8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=P6ngTp9yenF6MhaOfMvuTg/mmCNWckAMahcrkN+bf51PY1/LNuGW9TeDtgCXe1XX8BezcZ9pFbMQuKg++PQL1Z0AhWykHQT7cNIcTGyn3kUTMZhcGj/FY+mKrAmRUJH7LQ+NirRF6YpGvlATAgvhu1M0d8J1GWGWGSEFftV/IdPuqZheC03GfPXbevKdWmjs3FqAzdK4wKeHgSFoo8t6Q83nnJPXuX0PqThbm5bzFNURFPBs54Dp8YEP+fqMW4KwyAWF7+f+QRm/ViMCLUc0M0ZEj50vo7srKVXSptR6uoAPD/4tDBGz/xAR+zaydJLEPqYUTfU/8JqX3QxF+mSDdA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-2 (Postfix) with ESMTPSA id
 E10C7180037A; Mon, 12 Jan 2026 10:18:05 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v7 17/36] hw/arm/virt: Set msi-gpa property
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CH3PR12MB7548B4E80C4660147906DC6CAB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
Date: Mon, 12 Jan 2026 11:17:54 +0100
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8ACCC1BD-8696-4A02-A295-269713AB0614@unpredictable.fr>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-18-skolothumtho@nvidia.com>
 <526B3AB7-B0D4-4104-AF8F-012ED34EC990@unpredictable.fr>
 <CH3PR12MB7548B4E80C4660147906DC6CAB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4MSBTYWx0ZWRfXxR9qgiX/EBri
 U8vKXz/1/DLjBphOnvlMT3GI9SXOG0f+Wa78Ph5STc52Mo/mH9vizH1KG4x/ptH6fQeTi0QCBFT
 LPjcwTc9C3f8B+W/xyZaTo48bBN7spEJMF21TIYLo79kQjHsBVpTetgrIy/0RDUl82LZOjtnrYA
 lvvmJNsW1iqnPSGiVplRz0QxJDc2vO0TI7IS+kCW8DW4nJ1GvC/hMhiD+MtgAyS4Mpag+FiDs3O
 kyFlPQGeBvbqf5hr3ps3h+2iSyTrVcEsNJRt1LxpNksgFrROcbTuc216u4vMBYNhhzCSk7ccr2e
 L+BsqFUw1K9BTUoNgUO
X-Authority-Info: v=2.4 cv=UaRciaSN c=1 sm=1 tr=0 ts=6964ca61
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ikd4Dj_1AAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8
 a=KKAkSRfTAAAA:8 a=r1p2_3pzAAAA:8 a=1XWaLZrsAAAA:8 a=BTeA3XvPAAAA:8
 a=i0EeH86SAAAA:8 a=QyXUC8HyAAAA:8 a=4zc8lD1vxPkO9fQSZE0A:9 a=CjuIK1q_8ugA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=tafbbOV3vt1XuEhzTjGK:22
X-Proofpoint-GUID: ipSFBVxGSKgnWtR0ZdgiWpN2TsqFazMd
X-Proofpoint-ORIG-GUID: ipSFBVxGSKgnWtR0ZdgiWpN2TsqFazMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601120081
X-JNJ: AAAAAAABqZi9kLafIcQGLm2ARDfnbADd1TJlokO0g/Ejr50nTx1vAIyTPaKY5yMJcSfkScCjEzF8zlllZb3je/hNAhH1B95gVpEw1Mn2HT7YTn77ukyZXiYO/0PmZ3rQVFgV956xnRID9EZpy4zhX/iijv17GL5U1T10twxyvUByMaLe2YjqWSPlbgGbjDMpUzOwXXIh3lp7/+i3Pzm2ZtOvVOlQhT696kd1iVpWoZToAB9SZL/eYGyqinqtrzCthQi+iTbdGdb/qxy30UwcdD5MPoILmylgby0dcL0d7dUAme8dAt7JFIhcynj2hO5B8TBV42LhiNaZlAf33BTfxb8ijTJyvE4PTsAI10Ic3pxw5tZ1jsQOBUKDXXXWlwW3C7JItHWkG7ZtBoRS6wb9QObpUKHbvuqGaffqavAoX/MlftJoOKepeIIW75OCt4nizWOxiDvBv7JLINJEXcRjNjJ/Z98CA32Le8VuEt3ycirtrw6TCVsrcFVhv7b6oRjBc91812PCFpx9d/vF9Q/HlWGZ31f3Zfmwp4BOKHexzFeVcj1CxOSg5pBzCB74ZU9q4dag/FacfoZa8gIWJ3J7++CbhLcW+dLQBogDkUx3B5PYqLOyWfuuUIIJ3Ph+R3QebpffH0wFhVWqXfnxEa2b5szdw3a3tU6TbDkeDuv/weVwoaASZxY5/YohfyCIEMgNt74iK+EYl3fkER9Vh5pdIMv30ORH778YUmIAxeqJ7OsG8a4RfgC8rdl12LpSn6J6+GFzrtiLofFPimCt1vzzfXTSLesheXGJNLGKeog/fgtcOI6zjO2ngvxjSvdQmWfbXiIbvxBzreyH
Received-SPF: pass client-ip=57.103.87.84;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



> On 12. Jan 2026, at 10:45, Shameer Kolothum <skolothumtho@nvidia.com> =
wrote:
>=20
>=20
>=20
>> -----Original Message-----
>> From: Mohamed Mediouni <mohamed@unpredictable.fr>
>> Sent: 11 January 2026 21:44
>> To: Shameer Kolothum <skolothumtho@nvidia.com>
>> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
>> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
>> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
>> ddutile@redhat.com; berrange@redhat.com; clg@redhat.com;
>> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
>> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; =
yi.l.liu@intel.com;
>> Krishnakant Jaju <kjaju@nvidia.com>
>> Subject: Re: [PATCH v7 17/36] hw/arm/virt: Set msi-gpa property
>>=20
>> External email: Use caution opening links or attachments
>>=20
>>=20
>>> On 11. Jan 2026, at 20:53, Shameer Kolothum =
<skolothumtho@nvidia.com>
>> wrote:
>>>=20
>>> Set the MSI doorbell GPA property for accelerated SMMUv3 devices for =
use
>>> by KVM MSI setup. Also, since any meaningful use of vfio-pci devices =
with
>>> an accelerated SMMUv3 requires both KVM and a kernel irqchip, ensure
>>> those are specified when accel=3Don is selected.
>>>=20
>>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>> hw/arm/virt.c | 20 ++++++++++++++++++++
>>> 1 file changed, 20 insertions(+)
>>>=20
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index 9d0568a7d5..08feadf0a8 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -3052,6 +3052,26 @@ static void
>> virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>>            /* The new SMMUv3 device is specific to the PCI bus */
>>>            object_property_set_bool(OBJECT(dev), "smmu_per_bus", =
true,
>> NULL);
>>>        }
>>> +        if (object_property_find(OBJECT(dev), "accel") &&
>>> +            object_property_get_bool(OBJECT(dev), "accel", =
&error_abort)) {
>>> +            hwaddr db_start;
>>> +
>>> +            if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
>>> +                error_setg(errp, "SMMUv3 accel=3Don requires KVM =
with "
>>> +                           "kernel-irqchip=3Don support");
>>> +                    return;
>>> +            }
>>> +
>>> +            if (vms->msi_controller =3D=3D VIRT_MSI_CTRL_ITS) {
>>> +                /* GITS_TRANSLATER page + offset */
>>> +                db_start =3D base_memmap[VIRT_GIC_ITS].base + =
0x10000 + 0x40;
>>> +            } else {
>>> +                /* MSI_SETSPI_NS page + offset */
>>> +                db_start =3D base_memmap[VIRT_GIC_V2M].base + 0x40;
>>> +            }
>> Hello,
>>=20
>> Currently (but soon no longer the case for virt-11.0+), its=3Doff =
means no MSI
>> controller at all instead of
>> GICv3 + GICv2m.
>>=20
>> Would an else if with an error returned if no MSI controller is =
enabled be
>> adequate?
>=20
> The MSI doorbell setup here is only required for MSI translation =
cases.
> When ITS is off (and no MSI controller is present), passthrough =
devices
> cannot use MSI/MSI-X, so no MSI translation is required. Is that =
right?
>=20
> If so,  skipping the doorbell setup is expected and correct, and =
returning
> an error would unnecessarily reject a valid configuration.
Hello,

Could it be better then to have an else if for the GICv2m case and a =
separate=20
else with setting db_start to 0 or something instead of an invalid =
(because not=20
present device) address to make things clearer?

Thank you,
-Mohamed=20
> Thanks,
> Shameer
>=20


