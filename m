Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEF1D6D232
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 15:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWGG4-0002m7-BS; Thu, 18 Dec 2025 10:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vWGFu-0002ie-4X
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:49:30 -0500
Received: from 3.mo552.mail-out.ovh.net ([178.33.254.192])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vWGFr-0005pZ-IP
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:49:29 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.44])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dXFTV0M2Wz5yRb;
 Thu, 18 Dec 2025 15:49:18 +0000 (UTC)
Received: from kaod.org (37.59.142.112) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 18 Dec
 2025 16:49:17 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S006953bb45c-39ee-4bc3-994c-7d64fa0d7615,
 34212891AAEE040389AFAF6F36D407BF0C31F3D8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <aee35a8c-10d0-4ba7-b036-83f1ce7d8262@kaod.org>
Date: Thu, 18 Dec 2025 16:49:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] hw/arm/aspeed: catalina: add eeproms images
To: Patrick Williams <patrick@stwcx.xyz>, <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, <qemu-arm@nongnu.org>
References: <20251217-catalina-eeproms-v1-0-dc7b276efd57@stwcx.xyz>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251217-catalina-eeproms-v1-0-dc7b276efd57@stwcx.xyz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.112]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 46690f1c-9504-4abc-948f-587d22575b61
X-Ovh-Tracer-Id: 2485142572179884847
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEUlDROTSC9cnoGqY2ZdI5NZuFtSCHCUApPFCCVIlDJCADGS9MPc09r40wmY5mxfXK+sJCOGH9dddTwHWPIhfsTsM66wrGRext+H3tXMGwcpVGBIhh0mOtVxEdhouEbrtdoqlZx72ECLdprLeCqhNBRZHXTBOlNacBtinCUSA+ulgWMgsPp6jWQFz3s6RiNCJ7iLVJQYyDBQZvSuJZQWamf+0JOoHruMUpmthtd8HtqNprfDEcFVxWU+tm7T8xa2BDlcJ/s8sPDbT2R+jJNMwBNB8KVWfr/C2yKzfFdpUU3CP4RFOIbd1211wIFpKHLwVqmOx5Z85aqrVrcfEM5X3l4BsHmBvpwfDepYR8iCxFUFy+4jInf6cZtVe0m0Ng+jHoOtVdUz7BkRkYQ58BaFkeFX7YK1W3nLv19Z6iCzKgaS81/Fa3+RL0LbbQPX2L57G7OY/F+tSbutG2feNDoK0aQaKQ/9EedmCcuPMUvqWNKy1dfYA1pUmBmdNoG+adaRdEI3/W6bJJuOLFR+2ZbGIp+2hnfxHCT/SN0U2PxZKoi1ko3XqNz2b2qYKgU27SgW4K/Kk7+782NMO8DjST3Dh37AESBFrn6tMh8cfETne/wv8mNYI43foszoObrv0M3IOhQMZE+J+DgdRIrXkppZE4RO53r3BQ3IOHuOaGim8OApA
DKIM-Signature: a=rsa-sha256; bh=dutOzo4efz6vPri/QDtT2QxA7LGa9yFJ1hJJH8PA3ck=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1766072960; v=1;
 b=TlaiVqCif3ZRwBN1JOIn7T5TJSvzyt/bHS4x3L+4tOULOBN98Esj58ILIa7lvLQCmhrJgK7D
 LrwdoQ+ca0YXNryE/ON4Cf5zlmk8kP7Z7dFy0Px7eC42ALSwXvqKSCAmQaZiITp+zcpkhaaMRQu
 1CJSQinsgq+m3Q/d5hMP0R/tHVQqGd/kU6JhmFrnP5Z+1wJS9dNWXIIKLFKaH4zW916vqxRAdba
 rXngY6ZtFYbLK+n59C0OfkJp6S4OFeELnHtM/dDzpYSb8+Vglgq2a4nnk2EbrdKlqIe6vekWw1L
 GphAlS5ZCrBFSyjDSRX1ys67EP60Mkumxy05ZuJL2aa3g==
Received-SPF: pass client-ip=178.33.254.192; envelope-from=clg@kaod.org;
 helo=3.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/17/25 20:11, Patrick Williams wrote:
> Since Catalina is a server, made up of a number of FRUs, there are
> a number of EEPROMs that would contain IPMI-format FRU data.  On
> OpenBMC, these EEPROMs are parsed by `entity-manager` to determine
> which devices are physically present in the server (and which variants
> of those devices).
> 
> Add EEPROM images for every FRU in the Catalina server.  There is a
> utility `frugen` which can take a JSON representation of the IPMI
> fields and generate a binary image from that.  Use this to create
> sanitized EEPROM images for every FRU and add the rom-init calls to
> the appropriate locations in the Catalina model.  I left the JSON
> source as comments along-side each EEPROM image so they can be updated
> or recreated as necessary.
> 
> Tested by loading the latest version of OpenBMC's Catalina image and
> confirming the FRUs are detected appropriately by entity-manager.
> 
> ```
> root@catalina:~# busctl tree xyz.openbmc_project.EntityManager | grep "board/[^/]*$"
>            |- /xyz/openbmc_project/inventory/system/board/BMC_Storage_Module
>            |- /xyz/openbmc_project/inventory/system/board/Catalina_FIO
>            |- /xyz/openbmc_project/inventory/system/board/Catalina_HDD_Carrier
>            |- /xyz/openbmc_project/inventory/system/board/Catalina_HDD_NVMe
>            |- /xyz/openbmc_project/inventory/system/board/Catalina_OSFP_Carrier
>            |- /xyz/openbmc_project/inventory/system/board/Catalina_PDB
>            |- /xyz/openbmc_project/inventory/system/board/Catalina_SCM
>            |- /xyz/openbmc_project/inventory/system/board/NVIDIA_Cable_Cartridge_0
>            |- /xyz/openbmc_project/inventory/system/board/NVIDIA_Cable_Cartridge_2
>            |- /xyz/openbmc_project/inventory/system/board/NVIDIA_GB200_0
>            |- /xyz/openbmc_project/inventory/system/board/NVIDIA_GB200_1
>            |- /xyz/openbmc_project/inventory/system/board/NVIDIA_GB200_IO_Board_29
>            |- /xyz/openbmc_project/inventory/system/board/NVIDIA_GB200_IO_Board_41
>            |- /xyz/openbmc_project/inventory/system/board/NVIDIA_HMC
>            |- /xyz/openbmc_project/inventory/system/board/OCP_CX7_NIC_10
>            `- /xyz/openbmc_project/inventory/system/board/OCP_CX7_NIC_15
> ```
> 
> This result matches the expected results when running the image on a
> physical Catalina device.
> 
> Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
> ---
> Patrick Williams (11):
>        hw/arm/aspeed: catalina: add BSM FRU EEPROM
>        hw/arm/aspeed: catalina: add DC-SCM FRU EEPROM
>        hw/arm/aspeed: catalina: add PDB FRU EEPROM
>        hw/arm/aspeed: catalina: add OSFP FRU EEPROM
>        hw/arm/aspeed: catalina: add FIO FRU EEPROM
>        hw/arm/aspeed: catalina: add HDD FRU EEPROM
>        hw/arm/aspeed: catalina: add GB200 FRU EEPROM
>        hw/arm/aspeed: catalina: add GB200-IO FRU EEPROM
>        hw/arm/aspeed: catalina: add HMC FRU EEPROM
>        hw/arm/aspeed: catalina: add NIC FRU EEPROM
>        hw/arm/aspeed: catalina: add Cable Cartridge FRU EEPROM
> 
>   hw/arm/aspeed_ast2600_catalina.c | 473 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 457 insertions(+), 16 deletions(-)
> ---
> base-commit: 7154e4df40468012fccb6687ecd2b288c56a4a2d
> change-id: 20251217-catalina-eeproms-255d80036991
> 
> Best regards,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

