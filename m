Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358B9D358CF
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 07:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlM7H-0000N1-PP; Thu, 29 Jan 2026 02:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vlM7C-0000Hm-CB
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 02:06:54 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vlM77-0001LP-9W
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 02:06:52 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.198])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4f1qv66RpCz5vsf;
 Thu, 29 Jan 2026 07:06:42 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 29 Jan
 2026 08:06:42 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S00454ce5fc0-e23c-4988-9851-4e0417ae6c8d,
 2C6FA5329B41B2F3C96DA03D509BFF70E1BB15D6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <c8046224-ebfa-43fd-b8cb-525af4ebee82@kaod.org>
Date: Thu, 29 Jan 2026 08:06:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] hw/pci-host/aspeed_pcie: Drop AST2600 RC_H
 root-bus remap and bus-nr property
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260127032348.2238527-1-jamin_lin@aspeedtech.com>
 <20260127032348.2238527-4-jamin_lin@aspeedtech.com>
 <a31bf0d7-6143-439b-b347-3d1cce81be9d@kaod.org>
 <TYPPR06MB8206EB053D7CCF7DC44749C8FC9EA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB8206EB053D7CCF7DC44749C8FC9EA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 49ca0530-5e4f-4dba-a4a0-4c0b79a9d81a
X-Ovh-Tracer-Id: 504966108883159986
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGr3gB7XfQqAaIee9gJ+xR7QlhM0Q8BC+N3x4/UcPF++eXJYHqUfuTIx2IK0x5R86Fg8XV0WtxH6617HdryIDkLEOlC9uvzL03Fxkt7zIrzuzDkzKQvaZ2AuvJdzbGuQ91Jk3VUB1+5CIdAL4S/RWT8XhlYCs6IuFFr8G2okvFeqDA+1hLc4Mhfyx/BKTdGoKJkQIifhvL5knbBZaGzsNESOgnkX3dtm43n9BBfem00QLcRkD2jkc2YdXMrZCAJ6PSoTI0khf5OQmziApbvmIxy8jnwcQxtYHwAXbGS2o0pdPE0Pc/bneivd4vn3i8zux51QL6RQmMgL2mNbW68VLgVsvR3wznWbjYKWIPGSsQEvvv2Uc7f1zxLAqa35TJDgFCy2e31pLDdYguyJE6uuIgBPtEU2r/qjbcDPpJThNUa9Bwthn5HGXwphkD8dTTaHplT3FouxXCiN/3vTwJl4mtEoyzMgQ7Ii3CeBjB4VSqhclp3KPqim6EDbpTdvj5wSoboQPkUt/KJ/8Dh9SuYzyzaIHrcYVnlOkjEMl4vvTbZ1ttuCx/lpEQpNCJOqCy8xNPEITe5Um3LNY8lMwR3E0xLi8+yB/otC9lHI4VQMhIFE3A/8cSJH51OnX9CdPxgE9mhRcbtVUN6uVuL4pOCnMJ2I32btLsIrhHN/C1TMEoKjQ
DKIM-Signature: a=rsa-sha256; bh=J6ngfsp1zngPIGZUFgb++6u/neu6w2Zeq3zVjk8yj4A=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1769670404; v=1;
 b=PgdNyItHQi1eOJ7yG3vGq5XDh4Z4SN1SdCG2Y49RV8ntXUQI3HYloK40n9VUnE3E3+7MxadY
 Ra9RWxhnsHukrUU4koZTq0rX+fEoS773cQT1CEpI2INRQjnm937u7oqnuU7RNYq/S5K611oKNT8
 Qj9jTSJsMHJkZf60TurQwPg9mU1VLHgg506Yq6Ee/VH3usB3vgISLlmE/OIjHrIHfFbcM9/4ux1
 S+XdzzPACxhCcgMXPD9bZKptNiy3gW2TyCYJecJsN6gKS3dVbQGIG2d2rFHWsSL/bpSHg/59B8M
 vOHsQtrjHlb+2eslOcHXigDlFn5d7XalhRCFmxk0DzCgQ==
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 1/29/26 03:10, Jamin Lin wrote:
> Hi Cédric
> 
>> Subject: Re: [PATCH v1 3/7] hw/pci-host/aspeed_pcie: Drop AST2600 RC_H
>> root-bus remap and bus-nr property
>>
>> On 1/27/26 04:23, Jamin Lin via qemu development wrote:
>>> The original AST2600 PCIe design supported both RC_L and RC_H, using
>>> root bus number 0 for RC_L and 0x80 for RC_H. In that model, the root
>>> port appeared as
>>> 80:08.0 and QEMU carried a "bus-nr" property plus a config-space bus
>>> remap to translate bus 0x80 to bus 0x00 for PCI enumeration.
>>>
>>> Linux mainline has since dropped RC_L support and updated the RC_H
>>> root bus
>>
>> Was PCI support for the Aspeed SoC merged in mainline  ?
>>
> 
> The ASPEED PCIe RC driver has been applied to the PCIe subtree in the next branch.
> Please refer to the following links for details.
> The change will be merged into the Linux mainline soon.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=next
> https://lore.kernel.org/linux-pci/20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com/T/#eb13673b4787528d636afa40791ae43d38bd1152a
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=next&id=51aa64d4c19f0f00fd50cafd37cc2328675053ab
Great ! nice work.

Thanks,

C.



