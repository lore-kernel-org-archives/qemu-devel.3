Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B15CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDoXA-0000ds-Sz; Mon, 05 Oct 2026 15:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xDoX2-0000dT-HK; Mon, 05 Oct 2026 15:39:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xDoX0-000150-88; Mon, 05 Oct 2026 15:39:27 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HZVKO1131254; Mon, 5 Oct 2026 19:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mEEDpG
 9IkwYeeQegEUT8fqkA4UZzsQ9uIq5Fg5O388g=; b=ePEWvADiyfzwEt+ItFzWdP
 6mb2S193KVf1almczYQ1NBgy4Kx6Pmj5688FPzJBxSynQyJyPRxFv3DmB3FaYIqX
 0/lFYvGNwG42+Ykl0CWfGTNnmoIZpT/H/kAFcsamKeMe1tY4D5pFZazVw58i/3RO
 BAOsu5lAZJGf87EeUx7clmN9L7jzHuSfOXmMrmdklHKoik3rgCXPk/xti8+7dYMd
 9UJJAl2onvrMKNTGrgJp9CVBUQdEJFBViLJFlYRWBoR9iSziHxE64fwl5R5n40UV
 m8MTNYD3x70Wox7+uWkC2sIaFBVumHDU2aBwJq/cdlGlxhdUIHUw73OtM+vvTG4Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jks1p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 19:39:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HbVhC3231089; Mon, 5 Oct 2026 19:39:21 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvq04g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 19:39:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695JdKRa9306704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 19:39:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06B6658043;
 Mon,  5 Oct 2026 19:39:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE45058053;
 Mon,  5 Oct 2026 19:39:18 +0000 (GMT)
Received: from [9.61.15.56] (unknown [9.61.15.56])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 19:39:18 +0000 (GMT)
Message-ID: <59791e4a-ac5a-434f-b938-b7f3d154d3dc@linux.ibm.com>
Date: Mon, 5 Oct 2026 15:39:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 15/16] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260930145255.140164-1-kshk@linux.ibm.com>
 <20260930145255.140164-16-kshk@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260930145255.140164-16-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tL31HjKzvCKd9khV0PcDPUjmsjaMG7Lu
X-Proofpoint-GUID: tL31HjKzvCKd9khV0PcDPUjmsjaMG7Lu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NyBTYWx0ZWRfX4nx5dshW/Cpo
 mthKiMATEQDGUB8uN/SWMsuVDux5W3GBQCgFZ0DE93R70v6hyApGQgd7FbQbQFRbfjZLJdhWCOd
 BRAD0ki6PG2Hg6zEiksM3GW/e0oPJBY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NyBTYWx0ZWRfX9NpZjH+LnxQF
 mEE+aGbMrsulknTt3iog7W/Y58hxb6KFc/4WlTd4Kv+koSRqBVq2BrbkMTJdcPyvHx/Q2IY90Ld
 baaAhy82y16a1sIEFnrIICw6O0oQPmV/LnWy+BW/enKpguJlRds2BmyZ1pf25AE88Df7zOdGKH8
 pSD4VQ2C7I9V7IxEccyf30fizXuzmK8Vr1lbdFI8c3oVELWlinv2CDndzsaasuT/KNJ8M0q3IxM
 uVVIb+Mivw3nujG4nFBKoltYMQb6MgfjwgsYzlUh81EBuyfP5qyn5sPzkZz4VEBCz9PresiOj/k
 xTd19WsHaFUdDDIZADZUBcqijh4MUaxC0yfXg3a9tmPqVulQUCAosUwfXJcV5Sfv1sXKPT3gAwW
 dactweqGiGb5PVOpEW/NswDMbx4vKlU4FPpkq4Up3666VchCIbNF0bgxsW7DKvSx8g8RNL4hTN5
 jSCisF2Y8xnj1Z/p/PA==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac3fcea cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=8Xgp8btWZVU1dCH4KUkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050077
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


> +/* Return a unique bus "path" for zpci device */
> +static char *s390_pci_bus_get_dev_path(DeviceState *dev)
> +{
> +    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
> +    return g_strdup_printf("uid-%04x", pbdev->uid);
> +}
> +
> +static void s390_pcibus_class_init(ObjectClass *oc, const void *data)
> +{
> +    BusClass *bc = BUS_CLASS(oc);
> +    bc->get_dev_path = s390_pci_bus_get_dev_path;
> +}
> +
>  static const TypeInfo s390_pcibus_info = {
>      .name = TYPE_S390_PCI_BUS,
>      .parent = TYPE_BUS,
>      .instance_size = sizeof(S390PCIBus),
> +    /*
> +     * Implement get_dev_path() to provide each zpci device with a unique
> +     * stable UID-based bus "path". The "path" is used as part of idstr in the
> +     * migration stream, making idstr unique and instance_id always 0.
> +     * For migration to succeed, (idstr+instance_id) must match those generated
> +     * during QEMU start. Without unique idstr, QEMU will generate variable
> +     * instance_id to distinguish devices, and that instance_id can change
> +     * if a device is unplugged and plugged back, preventing migration.
> +     */
> +    .class_init = s390_pcibus_class_init,

This patch is already pretty big.  I wonder if adding
s390_pci_bus_get_dev_path + setting get_dev_path could be its own patch
prior to this one - up to you.

[...]

> +static bool s390_pci_device_post_load_errp(void *opaque, int version_id,
> +                                           Error **errp)
> +{
> +    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(opaque);
> +
> +    /*
> +     * Guard against the scenario that s390_pcihost_plug() of the target PCI
> +     * device succeeded in the source QEMU, but failed on this destination
> +     * QEMU, before migration state load. In this case we'll find !pbdev->pdev
> +     * but the pbdev->state != ZPCI_FS_RESERVED as just loaded from the stream.
> +     * Such value combination is invalid and migration should fail.
> +     */
> +    if (pbdev->state != ZPCI_FS_RESERVED && !pbdev->pdev) {
> +        error_setg(errp, "zpci device uid 0x%x state %d has no PCI device",
> +                   pbdev->uid, pbdev->state);
> +        return false;
> +    }
> +
> +    pbdev->zpci_fn.fid = pbdev->fid;
> +    pbdev->zpci_fn.uid = pbdev->uid;
> +
> +    /*
> +     * Now that pbdev->idx has been loaded, use it to place pbdev back into
> +     * the table. This may replace a different not-yet-state-loaded pbdev,
> +     * but pre_load() handles this case.
> +     */
> +    g_hash_table_replace(s390_get_phb()->zpci_table, &pbdev->idx, pbdev);
> +
> +    /*
> +     * Regenerate IOMMU state, including IOTLB contents and QEMU memory regions.
> +     */
> +    if (pbdev->iommu_enabled) {
> +        if (!pbdev->iommu) {
> +            error_setg(errp, "iommu is NULL");
> +            return false;
> +        }
> +        if (!s390_pci_ioat_validate(pbdev, pbdev->pba, pbdev->pal,
> +                                    pbdev->g_iota, errp)) {
> +            if (*errp) {
> +                error_prepend(errp,
> +                              "invalid pba, pal or g_iota in migration stream: ");
> +            } else {
> +                error_setg(errp,
> +                           "invalid pba, pal or g_iota in migration stream");
> +            }
> +            return false;
> +        }
> +        if (s390_pci_is_translation_enabled(pbdev->g_iota)) {
> +            s390_pci_iommu_enable(pbdev);
> +            s390_pci_ioat_replay(pbdev);
> +        } else {
> +            /* TODO: unreachable until vfio passthrough migration is enabled */
> +            s390_pci_iommu_direct_map_enable(pbdev);

I would further clarify that this is because rtr_avail is always set to
false for emulated devices today.

Also, besides vfio migration, it could also be reachable if were to ever
allow rtr_avail for emulated devices.

But I wonder: if we can never reach this code today, should this then be
a g_assert_not_reached() and improve the comment above to indicate that
if/when either emulated devices are allowed to set rtr_avail or
migration of VFIO devices are added, this path needs to be updated to
call s390_pci_iommu_direct_map_enable(pbdev)?

If/when either of those things happen in the future it would already
need to be on a machine-version boundary whether this call were in-place
or not.  And then we don't worry about devices driving this codepath
that should not be able to do so.

[...]

>  struct S390pciState {
>      PCIHostState parent_obj;
>      uint32_t next_idx;
> @@ -386,11 +390,14 @@ struct S390pciState {
>      S390PCIBus *bus;
>      GHashTable *iommu_table;
>      GHashTable *zpci_table;
> -    QTAILQ_HEAD(, SeiContainer) pending_sei;
> +    SeiContainerList pending_sei;
> +    /* Only used temporarily between migration pre_load and post_load. */
> +    SeiContainerList pending_sei_stash;

Hrm, I don't love that -- but I can't think of a better solution either.

I guess if we find anything else that needs this kind of treatment in
the future we should create a single object chained off of S390pciState
to hold all of them vs adding more of these to S390pciState.

Thanks,
Matt

