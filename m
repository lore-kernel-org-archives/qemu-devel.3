Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40682E9B250
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 10:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vupdf-00007i-JM; Tue, 24 Feb 2026 05:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vupdc-00006t-Qh
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:27:33 -0500
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vupda-00088W-Iy
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:27:32 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.53])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4fKv6j2D0pz5vyn;
 Tue, 24 Feb 2026 10:27:25 +0000 (UTC)
Received: from kaod.org (37.59.142.105) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 24 Feb
 2026 11:27:24 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0063f80f0b1-2256-4232-9a4a-ac245f3fb189,
 F9A4566923F578D8C63E1C019A32813E693EEB39) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <c4f300ec-7281-4bc2-b60d-752447e76f75@kaod.org>
Date: Tue, 24 Feb 2026 11:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/21] i3c: aspeed: Add I3C support
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
 <b6ad55df-e6ef-443b-a075-ab6959cefd46@kaod.org>
 <TYPPR06MB82061ECF268DE4C88A7641B4FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <7c6d421b-413a-4908-8e02-a9ccec4e42e5@kaod.org>
 <TYPPR06MB8206BD446615A0062DC0A462FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB820647A351FA8D23BA10BA71FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB820647A351FA8D23BA10BA71FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG12EX2.mxp5.local (172.16.2.122) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 829cf16d-2619-41e9-bde9-04e4bf1a2a0b
X-Ovh-Tracer-Id: 9010858431307025284
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFFnqGJs+eunl5M/Uz4dAYn20bVs/hOpS4kIB6FHn+MrU90a/I8RwPX5Kq0lUM7b+/9goqaeQqMaZYJbRV5kfeDTidgA70jVL/b/b0KOR4xCFkLAMYRiT1FkzLM57gwu2dGkJQuv25wfu93CrN6jhnY0qIKZX5cnK2puZrFWsATf+g0CtVSXVUJHyA8SEloOgmhzSzVFdRinamAhTdmryuX+p8PJE4C+o3CXP8XOYrkOFPbejkQSBikS/0PTwWMWdo50PysSkMXgtr7b9YexL9rh/S663YUkLltjJG1gTEqj7QRbdqrL7yFoQip/L7XzRMat9Inh5MxIJTIsoTp5bkAsNsBsA0NG307lJ0Upz3fsio3NIvA/MdSvMXHTGekvwkqzGJiNDGn8u33pDuk8vJQps35IgRhCqRSXOXG6JRDXW9YdvLzgLyt8y4OBYp0kEJZP4QvAoy2bKMwkDX2kBqa7i0QrE0GxD+N7yWhGv52A6aws2cBFfZCPfsx5OWB/tcAio3GVhUg8n8wJaie5KU7UCHZu/je6wbz7A/PSDVT8YkxmTIjzXgkgkzkyCgDIXfdXm82J8/7ULpha9B9gbt+2hwVBq62AOKVKgoE8ua4pd8rvpvdL7hGcuzS7R52yrIO/65Dpl5o8RsrucG3C+5jYqIm/c4F/GxoPGTnSWxr4w
DKIM-Signature: a=rsa-sha256; bh=SaWhkJu4RwwE+DYFgKFTk/SELqKu93oXrjUWkD05lXA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1771928846; v=1;
 b=JcUQRY420ZgLkTdQMHcHC038QlI74B54yHbfLlU+Z/Gbk74G0g2lOTcoW49f1XRJyfmUXFZb
 lFLP9tTHVZzssVUnOQxhaNHKRoURCmxzaGzLgFe+bz0WG+XSyrQPfMNhxwATVy8OsrBmHtSjPfi
 Vlo3ydsMu+ggLutpzBDqzwFcUH0qKchWEVB8D2cggt4l3RaoIJwP0b3fBxfOHlaWt50qinn0K8Z
 +ky52w5jHmSqomZ2v2nMyFbPZ6KeVSSIeJvTPkuk450YKN3C3/wyMv/ZtFUToBWRgdR916q75M6
 oe+LXAq28qUiuc68z1nBOqYYLyUnXcsNmM/0cQrguN1VA==
Received-SPF: pass client-ip=188.165.42.229; envelope-from=clg@kaod.org;
 helo=4.mo548.mail-out.ovh.net
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/24/26 10:58, Jamin Lin wrote:
> Hi Cédric,
> 
>>>>> Who will be the maintainers and reviewers ?
>>>>>
>>>>
>>>> I will add myself (Jamin Lin <jamin_lin@aspeedtech.com>) and Joe
>>>> Komlodi (<komlodi@google.com>) as Maintainers and Nabih Estefan
>>> <nabihestefan@google.com> as a Reviewer for I3C in the MAINTAINERS
>>> file in v6.
>>>
>>> OK. I can be the sponsor then
>>>
>>>> Would anyone from the QEMU community be willing to serve as a
>>> Maintainer or Reviewer for I3C?
>>>
>>> As I3C is currently only available for Aspeed machines, please add me
>>> as a Maintainer. I will handle the pull requests.
>>>
> Could you please let me know which email address you would prefer to have listed in the MAINTAINERS file?
> 1. clg@kaod.org

Please use the kaod.org email.

Thanks,

C.



> 2. clg@redhat.com
> 
> Thanks,
> Jamin
> 
>>> Thanks,
>>>
>>> C.
>>
>> Okay, will resend v7


