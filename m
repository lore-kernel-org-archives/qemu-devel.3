Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3D606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 06:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xROTz-0006zH-PW; Thu, 12 Nov 2026 01:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xROTs-0006wS-9e; Thu, 12 Nov 2026 01:40:22 -0500
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xROTn-0007Gf-98; Thu, 12 Nov 2026 01:40:19 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQ9jr6gt4z5B0qP;
 Thu, 12 Nov 2026 14:40:00 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
 by mse-fl1.zte.com.cn with SMTP id 6AC6dcke018003;
 Thu, 12 Nov 2026 14:39:38 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Thu, 12 Nov 2026 14:39:40 +0800
X-Zmail-TransId: 3e816af55f2502c-8d4f6
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: tanchi25@mails.ucas.ac.cn
Cc: alistair.francis@wdc.com, chao.liu@processmission.com, cohuck@redhat.com, 
 daniel.barboza@oss.qualcomm.com, gong.shuai@sanechips.com.cn,
 liwei1518@gmail.com, mst@redhat.com, palmer@dabbelt.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 wu.fei9@sanechips.com.cn, zhao.qingye@sanechips.com.cn,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [RFC PATCH v2 10/14] hw/riscv/riscv-iommu-accel: Add
 set/unset_iommu_device callback
Date: Thu, 12 Nov 2026 14:39:38 +0800
Message-ID: <20261112063938.273354-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111143849.13090-1-tanchi25@mails.ucas.ac.cn>
References: <20261111143849.13090-1-tanchi25@mails.ucas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 6AC6dcke018003
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 12 Nov 2026 14:40:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF55F40.001/4jQ9jr6gt4z5B0qP
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tan Chi,

Thanks for the review.

> Hi Shuai and Fei,
> 
> On 10/29/2026 1:47 PM, Gong Shuai wrote:
> > +    if (s->accel_state->viommu) {
> > +        goto done;
> > +    }
> >
> > +    if (!riscv_iommu_accel_alloc_viommu(s, idev, errp)) {
> > +        error_append_hint(errp, "Unable to alloc vIOMMU: idev devid 0x%x: ",
> > +                          idev->devid);
> > +        return false;
> > +    }
> 
> And in riscv_iommu_accel_alloc_viommu():
> 
> > +    /* Attach a HWPT based on ddtp.iommu_mode value */
> > +    hwpt_id = riscv_iommu_accel_ddtp_hwpt(s, accel);
> > +    if (!host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID, hwpt_id,
> > +                                               errp)) {
> > +        goto free_bypass_hwpt;
> > +    }
> 
> It looks like only the first VFIO device is attached to the abort/bypass
> HWPT. Subsequent devices in different IOMMU groups may remain attached
> to their original Stage-2 parent HWPT, potentially allowing DMA even
> when DDTP.Mode is OFF.

Your analysis is correct. A later device takes the "goto done"
path and stays on its S2 parent. A device in that state can still
DMA with GPA -> HPA translation while DDTP.Mode is Off, which the
spec says must abort.

The RFC design and our testing were based on a single-device
model, so this never showed up. We only started exercising
multiple groups/devices recently, while reproducing the kernel
issue you pointed out [1]. Before any DMA is issued, the guest
IOMMU driver programs DDTP and sends an IODIR.INVAL_DDT, and
each device's domain attach sends a per-device one. QEMU
handles both by re-fetching the guest DC and attaching the
matching nested HWPT, so by the time the DMA starts the window
is already closed. That explains why the test passes; it just
does not cover the window you found. Still, the gap is real
and needs to be fixed.

> 
> Maybe we can follow ARM SMMUv3 and reattach all VFIO devices to the
> appropriate abort/bypass HWPT during reset.

Thanks for the suggestion, I'll try that in the next version.

[1] https://lore.kernel.org/linux-riscv/20261105144944.10193-1-tanchi25@mails.ucas.ac.cn/

Thanks,
Shuai

> 
> Thanks,
> Tan Chi
> 

