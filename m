Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7B9CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWbn-0001UJ-6p; Thu, 28 May 2026 05:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1wSWbh-0001Tp-Lf; Thu, 28 May 2026 05:00:49 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1wSWbe-0001z6-Mz; Thu, 28 May 2026 05:00:49 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4gR0nS3DR1z51TgV;
 Thu, 28 May 2026 17:00:28 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
 by mse-fl1.zte.com.cn with SMTP id 64S90EEX074792;
 Thu, 28 May 2026 17:00:14 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp04[null]) by mapi (Zmail) with MAPI id mid32;
 Thu, 28 May 2026 17:00:16 +0800 (CST)
X-Zmail-TransId: 2afb6a1804206e1-319cb
X-Mailer: Zmail v1.0
Message-ID: <20260528170016710iuXYBAVqiW8d2DhKsiic_@zte.com.cn>
In-Reply-To: <20260323093424896RwSN27DExqvdZg7fGf-Ry@zte.com.cn>
References: 20260319110005712RbJuYoQlyLGr39EPL4uH4@zte.com.cn,
 CAAhSdy1YMw1qDP9VSpi2YpXoNURaJb8pTngNFcNCCqNRiXiezA@mail.gmail.com,
 20260323093424896RwSN27DExqvdZg7fGf-Ry@zte.com.cn
Date: Thu, 28 May 2026 17:00:16 +0800 (CST)
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <anup@brainfault.org>
Cc: <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <pbonzini@redhat.com>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <sunilvl@ventanamicro.com>, <qemu-riscv@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NiBSRVNFTkQgMC80XSBody9yaXNjdi92aXJ0OiBBZGQgYWNwaSBnZWQgYW5kIHBvd2VyZG93biBzdXBwb3J0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 64S90EEX074792
X-TLS: YES
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 28 May 2026 17:00:28 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A18042C.000/4gR0nS3DR1z51TgV
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, CTE_8BIT_MISMATCH=1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi Anup,

>>>
>>> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>>>
>>> Add acpi ged and powerdown support for riscv
>>>
>>> Changes in v6:
>>> - Removed unnecessary condition when build ged aml
>>> - Link to v5: https://lore.kernel.org/qemu-devel/20260204182041057hohVHgmaAJborE1DrghXH@zte.com.cn/
>>>
>>> Changes in v5:
>>> - Added a new patch to allow DSDT acpi table changes
>>> - Split a new patch to support ACPI GED
>>> - Introduced a condition for calling acpi_send_event
>>> - Link to v4: https://lore.kernel.org/qemu-devel/2025111309270952219AjKpVEnbJXB7fcGTE4g@zte.com.cn/
>>>
>>> Changes in v4:
>>> - Added modifies of DSDT blob in another patch
>>> - Link to v3: https://lore.kernel.org/qemu-riscv/20250723113739751COZ5PkRzx6aXEuKzsHhm_@zte.com.cn/
>>>
>>> Changes in v3:
>>> - Added missing param to virt_is_acpi_enabled
>>> - Fixed failure of bios-tables-test
>>> - Link to v2: https://lore.kernel.org/qemu-riscv/202506201130099861lTkD839Hh6oko8Jo2W2H@zte.com.cn/
>>>
>>> Changes in v2:
>>> - Unwrappered acpi_dsdt_add_ged function
>>> - Modified base address of VIRT_ACPI_GED
>>> - Added conditions for function calls
>>> - Adjusted code formatting
>>> - Link to v1: https://lore.kernel.org/qemu-riscv/202506191556260735QxWC8sxRwFURYEvlD24y@zte.com.cn/
>>>
>>> Xuemei Liu (4):
>>> tests/acpi: virt: allow DSDT acpi table changes
>>> hw/riscv/virt: Add acpi ged support
>>> hw/riscv/virt: add system_powerdown hmp command support
>>> tests/acpi: Add acpi ged and power button in DSDT for RISC-V
>>>
>>> hw/riscv/Kconfig | 1 +
>>> hw/riscv/virt-acpi-build.c | 8 +++++++
>>> hw/riscv/virt.c | 37 ++++++++++++++++++++++++++++++
>>> include/hw/riscv/virt.h | 4 ++++
>>> tests/data/acpi/riscv64/virt/DSDT | Bin 3538 -> 3681 bytes
>>> 5 files changed, 50 insertions(+)
>>>
>>
>>The problem with supporting system_powerdown HPM command
>>using ARM-style VIRT_ACPI_GED MMIO device is that it only
>>works with ACPI and does not work with DeviceTree.
>>
>>We have the system_powerdown HPM command support working
>>for both DeviceTree and ACPI using RPMI SystemMSI service group.
>>The corresponding OpenSBI and Linux drivers for RPMI SystemMSI
>>service group are already available upstream. Only QEMU RPMI
>>support is pending to be upstreamed.
>>
>>The RPMI v1.0 (ratified) specification defines System MSI service
>>groups using which QEMU can send system events as MSIs. These
>>system events include poweroff request, reboot request, CPU hotplug
>>events and much more.
>>
>>For QEMU RPMI implementation using libRPMI, refer to
>>the dev-upstream branch at https://github.com/ventanamicro/qemu.git
>>
>>Regards,
>>Anup
>
>Thank you very much for the detailed and insightful explanation.
>
>Best regards,
>Jessica

Sorry to bother you again.

Thank you very much for sharing the detailed information about RPMI
SystemMSI and the dev-upstream branch. I was wondering – do you have
a rough timeline for when the QEMU RPMI support is planned to be
upstreamed?

Best regards,
Jessica

