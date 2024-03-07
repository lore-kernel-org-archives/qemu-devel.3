Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1D3C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCVv-0004LU-3S; Thu, 07 Mar 2024 07:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1riCVl-0004JR-DL
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:06:09 -0500
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1riCVV-0005NP-36
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:06:09 -0500
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1709813141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=On8HB8y1tTMJab2j+fd5XKn/1OC8xVc0eTzEZSkIC8Y=;
 b=OXQWrvobi+jc9Pa4cd6hCRd0Y3a+7dkitJ223zmGQxbS/wR7NHPSM0f3lqwYYePtMNTNb0
 PjrxXSOR0vhJ0yZef6nzFxEeHweH8qRfKn3NrGIH5mAhoh3qJNpm33CxvKQ9siyEMpTuGN
 OvJDmLemdndz/dYFzhdQb67S4++Sl0vMzPYG6WRfYc9h29iWTVJZq1b3isF6KASJhdIkt7
 j72w4QrXaRKaxbG8ROGd7NMjl2qQFr2OCdCXEN52B47KLZawqv/UijaSltaWR2YSvgpzRF
 8TDyGT2D+PH70kfsGGQ8NMs2/7kklOYuIoDp4ZINz/T54l20Swmqhe0Hl276mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1709813141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=On8HB8y1tTMJab2j+fd5XKn/1OC8xVc0eTzEZSkIC8Y=;
 b=HlZ78iZcDuPaeV/LiGqDqLkTEzSv6ZU7ei0gev0PT+Oaao+7qrDgxuYv3WM1zFiMa3yyLK
 2UfuzvgpjrAwS9Cw==
Date: Thu, 07 Mar 2024 13:05:34 +0100
Subject: [PATCH v2 1/5] docs/interop/firmware.json: Align examples
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240307-qapi-firmware-json-v2-1-3b29eabb9b9a@linutronix.de>
References: <20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de>
In-Reply-To: <20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709813140; l=11093;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=GMe7kp9V6sMusbYpESY64Sjm/vPnPDkcVXvAuqt/pIQ=;
 b=asNTfEWpUp2kFJBfzwgzwaLT8ElrJOW5XcqIUa0jy3SJN5ANHX42Sku8/ZLIiGE4ocbDxUh9t
 eEKuhMsHlTfDCIovN0yknHWMCszgsMee1Cj4ncllDipWtb38RDuAB8z
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=193.142.43.55; envelope-from=t-8ch@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The QAPI generator now validates the alignment and rejects this file.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/interop/firmware.json | 384 ++++++++++++++++++++++-----------------------
 1 file changed, 192 insertions(+), 192 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index cc8f86918681..a024f1b9bf3f 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -435,203 +435,203 @@
 #
 # Examples:
 #
-# {
-#     "description": "SeaBIOS",
-#     "interface-types": [
-#         "bios"
-#     ],
-#     "mapping": {
-#         "device": "memory",
-#         "filename": "/usr/share/seabios/bios-256k.bin"
-#     },
-#     "targets": [
-#         {
-#             "architecture": "i386",
-#             "machines": [
-#                 "pc-i440fx-*",
-#                 "pc-q35-*"
-#             ]
+#     {
+#         "description": "SeaBIOS",
+#         "interface-types": [
+#             "bios"
+#         ],
+#         "mapping": {
+#             "device": "memory",
+#             "filename": "/usr/share/seabios/bios-256k.bin"
 #         },
-#         {
-#             "architecture": "x86_64",
-#             "machines": [
-#                 "pc-i440fx-*",
-#                 "pc-q35-*"
-#             ]
-#         }
-#     ],
-#     "features": [
-#         "acpi-s3",
-#         "acpi-s4"
-#     ],
-#     "tags": [
-#         "CONFIG_BOOTSPLASH=n",
-#         "CONFIG_ROM_SIZE=256",
-#         "CONFIG_USE_SMM=n"
-#     ]
-# }
-#
-# {
-#     "description": "OVMF with SB+SMM, empty varstore",
-#     "interface-types": [
-#         "uefi"
-#     ],
-#     "mapping": {
-#         "device": "flash",
-#         "executable": {
-#             "filename": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
-#             "format": "raw"
+#         "targets": [
+#             {
+#                 "architecture": "i386",
+#                 "machines": [
+#                     "pc-i440fx-*",
+#                     "pc-q35-*"
+#                 ]
+#             },
+#             {
+#                 "architecture": "x86_64",
+#                 "machines": [
+#                     "pc-i440fx-*",
+#                     "pc-q35-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
+#             "acpi-s3",
+#             "acpi-s4"
+#         ],
+#         "tags": [
+#             "CONFIG_BOOTSPLASH=n",
+#             "CONFIG_ROM_SIZE=256",
+#             "CONFIG_USE_SMM=n"
+#         ]
+#     }
+#
+#     {
+#         "description": "OVMF with SB+SMM, empty varstore",
+#         "interface-types": [
+#             "uefi"
+#         ],
+#         "mapping": {
+#             "device": "flash",
+#             "executable": {
+#                 "filename": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
+#                 "format": "raw"
+#             },
+#             "nvram-template": {
+#                 "filename": "/usr/share/OVMF/OVMF_VARS.fd",
+#                 "format": "raw"
+#             }
 #         },
-#         "nvram-template": {
-#             "filename": "/usr/share/OVMF/OVMF_VARS.fd",
-#             "format": "raw"
-#         }
-#     },
-#     "targets": [
-#         {
-#             "architecture": "x86_64",
-#             "machines": [
-#                 "pc-q35-*"
-#             ]
-#         }
-#     ],
-#     "features": [
-#         "acpi-s3",
-#         "amd-sev",
-#         "requires-smm",
-#         "secure-boot",
-#         "verbose-dynamic"
-#     ],
-#     "tags": [
-#         "-a IA32",
-#         "-a X64",
-#         "-p OvmfPkg/OvmfPkgIa32X64.dsc",
-#         "-t GCC48",
-#         "-b DEBUG",
-#         "-D SMM_REQUIRE",
-#         "-D SECURE_BOOT_ENABLE",
-#         "-D FD_SIZE_4MB"
-#     ]
-# }
-#
-# {
-#     "description": "OVMF with SB+SMM, SB enabled, MS certs enrolled",
-#     "interface-types": [
-#         "uefi"
-#     ],
-#     "mapping": {
-#         "device": "flash",
-#         "executable": {
-#             "filename": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
-#             "format": "raw"
+#         "targets": [
+#             {
+#                 "architecture": "x86_64",
+#                 "machines": [
+#                     "pc-q35-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
+#             "acpi-s3",
+#             "amd-sev",
+#             "requires-smm",
+#             "secure-boot",
+#             "verbose-dynamic"
+#         ],
+#         "tags": [
+#             "-a IA32",
+#             "-a X64",
+#             "-p OvmfPkg/OvmfPkgIa32X64.dsc",
+#             "-t GCC48",
+#             "-b DEBUG",
+#             "-D SMM_REQUIRE",
+#             "-D SECURE_BOOT_ENABLE",
+#             "-D FD_SIZE_4MB"
+#         ]
+#     }
+#
+#     {
+#         "description": "OVMF with SB+SMM, SB enabled, MS certs enrolled",
+#         "interface-types": [
+#             "uefi"
+#         ],
+#         "mapping": {
+#             "device": "flash",
+#             "executable": {
+#                 "filename": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
+#                 "format": "raw"
+#             },
+#             "nvram-template": {
+#                 "filename": "/usr/share/OVMF/OVMF_VARS.secboot.fd",
+#                 "format": "raw"
+#             }
 #         },
-#         "nvram-template": {
-#             "filename": "/usr/share/OVMF/OVMF_VARS.secboot.fd",
-#             "format": "raw"
-#         }
-#     },
-#     "targets": [
-#         {
-#             "architecture": "x86_64",
-#             "machines": [
-#                 "pc-q35-*"
-#             ]
-#         }
-#     ],
-#     "features": [
-#         "acpi-s3",
-#         "amd-sev",
-#         "enrolled-keys",
-#         "requires-smm",
-#         "secure-boot",
-#         "verbose-dynamic"
-#     ],
-#     "tags": [
-#         "-a IA32",
-#         "-a X64",
-#         "-p OvmfPkg/OvmfPkgIa32X64.dsc",
-#         "-t GCC48",
-#         "-b DEBUG",
-#         "-D SMM_REQUIRE",
-#         "-D SECURE_BOOT_ENABLE",
-#         "-D FD_SIZE_4MB"
-#     ]
-# }
-#
-# {
-#     "description": "OVMF with SEV-ES support",
-#     "interface-types": [
-#         "uefi"
-#     ],
-#     "mapping": {
-#         "device": "flash",
-#         "executable": {
-#             "filename": "/usr/share/OVMF/OVMF_CODE.fd",
-#             "format": "raw"
+#         "targets": [
+#             {
+#                 "architecture": "x86_64",
+#                 "machines": [
+#                     "pc-q35-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
+#             "acpi-s3",
+#             "amd-sev",
+#             "enrolled-keys",
+#             "requires-smm",
+#             "secure-boot",
+#             "verbose-dynamic"
+#         ],
+#         "tags": [
+#             "-a IA32",
+#             "-a X64",
+#             "-p OvmfPkg/OvmfPkgIa32X64.dsc",
+#             "-t GCC48",
+#             "-b DEBUG",
+#             "-D SMM_REQUIRE",
+#             "-D SECURE_BOOT_ENABLE",
+#             "-D FD_SIZE_4MB"
+#         ]
+#     }
+#
+#     {
+#         "description": "OVMF with SEV-ES support",
+#         "interface-types": [
+#             "uefi"
+#         ],
+#         "mapping": {
+#             "device": "flash",
+#             "executable": {
+#                 "filename": "/usr/share/OVMF/OVMF_CODE.fd",
+#                 "format": "raw"
+#             },
+#             "nvram-template": {
+#                 "filename": "/usr/share/OVMF/OVMF_VARS.fd",
+#                 "format": "raw"
+#             }
 #         },
-#         "nvram-template": {
-#             "filename": "/usr/share/OVMF/OVMF_VARS.fd",
-#             "format": "raw"
-#         }
-#     },
-#     "targets": [
-#         {
-#             "architecture": "x86_64",
-#             "machines": [
-#                 "pc-q35-*"
-#             ]
-#         }
-#     ],
-#     "features": [
-#         "acpi-s3",
-#         "amd-sev",
-#         "amd-sev-es",
-#         "verbose-dynamic"
-#     ],
-#     "tags": [
-#         "-a X64",
-#         "-p OvmfPkg/OvmfPkgX64.dsc",
-#         "-t GCC48",
-#         "-b DEBUG",
-#         "-D FD_SIZE_4MB"
-#     ]
-# }
-#
-# {
-#     "description": "UEFI firmware for ARM64 virtual machines",
-#     "interface-types": [
-#         "uefi"
-#     ],
-#     "mapping": {
-#         "device": "flash",
-#         "executable": {
-#             "filename": "/usr/share/AAVMF/AAVMF_CODE.fd",
-#             "format": "raw"
+#         "targets": [
+#             {
+#                 "architecture": "x86_64",
+#                 "machines": [
+#                     "pc-q35-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
+#             "acpi-s3",
+#             "amd-sev",
+#             "amd-sev-es",
+#             "verbose-dynamic"
+#         ],
+#         "tags": [
+#             "-a X64",
+#             "-p OvmfPkg/OvmfPkgX64.dsc",
+#             "-t GCC48",
+#             "-b DEBUG",
+#             "-D FD_SIZE_4MB"
+#         ]
+#     }
+#
+#     {
+#         "description": "UEFI firmware for ARM64 virtual machines",
+#         "interface-types": [
+#             "uefi"
+#         ],
+#         "mapping": {
+#             "device": "flash",
+#             "executable": {
+#                 "filename": "/usr/share/AAVMF/AAVMF_CODE.fd",
+#                 "format": "raw"
+#             },
+#             "nvram-template": {
+#                 "filename": "/usr/share/AAVMF/AAVMF_VARS.fd",
+#                 "format": "raw"
+#             }
 #         },
-#         "nvram-template": {
-#             "filename": "/usr/share/AAVMF/AAVMF_VARS.fd",
-#             "format": "raw"
-#         }
-#     },
-#     "targets": [
-#         {
-#             "architecture": "aarch64",
-#             "machines": [
-#                 "virt-*"
-#             ]
-#         }
-#     ],
-#     "features": [
-#
-#     ],
-#     "tags": [
-#         "-a AARCH64",
-#         "-p ArmVirtPkg/ArmVirtQemu.dsc",
-#         "-t GCC48",
-#         "-b DEBUG",
-#         "-D DEBUG_PRINT_ERROR_LEVEL=0x80000000"
-#     ]
-# }
+#         "targets": [
+#             {
+#                 "architecture": "aarch64",
+#                 "machines": [
+#                     "virt-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
+#
+#         ],
+#         "tags": [
+#             "-a AARCH64",
+#             "-p ArmVirtPkg/ArmVirtQemu.dsc",
+#             "-t GCC48",
+#             "-b DEBUG",
+#             "-D DEBUG_PRINT_ERROR_LEVEL=0x80000000"
+#         ]
+#     }
 ##
 { 'struct' : 'Firmware',
   'data'   : { 'description'     : 'str',

-- 
2.44.0


