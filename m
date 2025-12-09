Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE242D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 08:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vStTD-0007Li-3x; Tue, 09 Dec 2025 03:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vStT9-0007LR-SR; Tue, 09 Dec 2025 03:53:15 -0500
Received: from 3.mo552.mail-out.ovh.net ([178.33.254.192])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vStT7-0002sP-Vr; Tue, 09 Dec 2025 03:53:15 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.161])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dQXfM1Xlbz6MmZ;
 Tue,  9 Dec 2025 08:52:11 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 9 Dec
 2025 09:51:45 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001c3464de2-6b72-4a74-885c-9bb8a3c06806,
 913B1D19E2E265D49699B36B6A33E6F0AA87D788) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <c20c67df-6099-4a59-bb5f-dff6d925aa2a@kaod.org>
Date: Tue, 9 Dec 2025 09:51:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/18] hw/arm/aspeed: Model AST1700 I3C block as
 unimplemented device
To: Nabih Estefan <nabihestefan@google.com>, Kane Chen
 <kane_chen@aspeedtech.com>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 <troy_lee@aspeedtech.com>, Joe Komlodi <komlodi@google.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <20251208074436.1871180-19-kane_chen@aspeedtech.com>
 <CA+QoejU-hpaBce7KoOA0PXBz+DVT1-ZvoyY=mgDPnZLbdZwdHQ@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CA+QoejU-hpaBce7KoOA0PXBz+DVT1-ZvoyY=mgDPnZLbdZwdHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: bf3cf653-bb0d-43a4-b4be-70332bb5568b
X-Ovh-Tracer-Id: 16366643998422633464
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTERmBLlDgyQLntvD9mon368kNGvi8sfim49QYGcJ7LheX8l+QSncD6ziLSN7+DdcMwKFFl+cesLFH2xyZOlxXHTUJ6lMTbgNQS1oP0ILXEF8SRTrDZGjWOY9UMQRiSfFOKHACZa0xNRyIpsJvfmAQ8anl66uu2S3rqvKV8J7tE//ySVr3bqdYO7PZ9kIW1l9Jm6VnwSWHLvF/39CyFTdQVWyZ6ucvZJhPgEPSIYeM4pGKh3tX2Q83Fuz64tPcorn3lfLDyzs+B4pOwNdqtQowz5Clu4PQBlkHXgbexVvmSM0ScnbZ/0rFeEvHQsF13eL2UiSP0MiBu9kNg1+o8HML9sbgAQgkQikBOOH9RPdeIMOF7GgEjgWzhxjZoR24u/RWUnJYsl3h6kHCqyRIrGtsJSEWxqk/iICxJAP2bOW/V5tm+xkQaQSaJr2uzTsy6JZkWP/yMLFC6B+x/72vHiaU0iWswnLmIhv1tdVTKBGg8VGWXv5Z1RLF/jHYWG7WzVAsXBKAdQrTra8cix35l/qiG8BpFyCyAnpBQ5yJ2osQdwDa3STEpAoL8368d3gk+FwcIrZwKU3RWqcLLjyFiCI6C7K7T7p1j4tZixTP5eMD3sFFV19+OcU36+SiFKbcey1hYLvjArMSi3sNop4vRVBgeK0y98TLeYTMMY4fiq5w6yCA
DKIM-Signature: a=rsa-sha256; bh=yXIqOsiFkOLxa1W5SawZk7UPLZvYY20HT6CkyF9u0kE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1765270344; v=1;
 b=ur7mnhNiDdiFI19HAivQJu5j7MMOcpM4tCN6a9zLcXPfJu6wIyxZz/mYCg5w+Kwep/GmXPxQ
 /nlVYuQEG6dJzqudgvqKnjW4cecl3SIrSd75bZotvQU2hPLGZo0gd4jH9qkGHokzmvvroDrc4od
 la5xTygAmMHtLthvrvjKc5NhiE3knoApnF7PDM48RI6lXCRyu7TiFDrK6LGdP/yHcIqdqKBW5hY
 vuxBaIQIm5uGvRoOlswlTunrgTOUZbKwkdEiejhQDotwAGs5SVjZ6xMo0QXSQCX3Fgo8/P3y2SG
 A44zTtIRSkNSgpdtGyfMhkGjSdUUSnTIt2FsalRknFizw==
Received-SPF: pass client-ip=178.33.254.192; envelope-from=clg@kaod.org;
 helo=3.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/8/25 19:23, Nabih Estefan wrote:
> On Sun, Dec 7, 2025 at 11:47 PM Kane Chen via <qemu-devel@nongnu.org> wrote:
>>
>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>
>> AST1700 exposes more I3C buses than the current dummy I3C model
>> provides. When Linux probes the I3C devices on AST1700 this mismatch
>> can trigger a kernel panic. Model the I3C block as an unimplemented
>> device to make the missing functionality explicit and avoid unexpected
>> side effects.
>>
>> This wires up the I3C interrupt lines for the IO expanders and adds the
>> corresponding device entries for the AST1700 model.
>>
>> No functional I3C emulation is provided yet; this only prevents crashes and
>> documents the missing piece.
> 
> Would you be able to help review Joe Komlodi's I3C support patchset
> (link below)?
> I think it probably fills in this gap.

yes. I have been keeping Joe's series in my tree for a while now.
It looks saneand it would be great if someone could dedicate
some time to the review.

Can we make this a target for QEMU 11.0 ?

Thanks,

C.

