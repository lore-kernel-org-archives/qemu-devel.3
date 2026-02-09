Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0AEEF0719
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLKH-0007Qr-6g; Mon, 09 Feb 2026 02:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vpLKB-0007Pp-O2
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:04:47 -0500
Received: from 6.mo552.mail-out.ovh.net ([188.165.49.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vpLK8-00068K-Kg
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:04:47 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.72])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4f8bKh5GPwz5vxB;
 Mon,  9 Feb 2026 07:04:40 +0000 (UTC)
Received: from kaod.org (37.59.142.114) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 9 Feb
 2026 08:04:39 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S008b9ba8ef7-8c7b-4d92-9e4f-e0e82dcb4f82,
 ECF38C093296ADD45142D325C9F6EF635D78D8A6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <c2a1b965-2329-4e5d-b0f0-7542ff5df1fc@kaod.org>
Date: Mon, 9 Feb 2026 08:04:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/20] i3c: aspeed: Add I3C support
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
 <53224b36-db6a-4790-8abc-d6aa79b95358@kaod.org>
 <TYPPR06MB8206F2D0EAF733D287BB87D7FC65A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB8206F2D0EAF733D287BB87D7FC65A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.114]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: f0790815-5d41-4689-afc6-b4ce2921f568
X-Ovh-Tracer-Id: 9730026995602262846
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEO+pPWCQJqLgvonL+hWNfzmJvrn9hlqzWksLT4R6nacWNai2M4fKmVUOqM6dcO+3qDug2SQs2r8v5B2qj6o3HzYw78v0BIaVK0aQSZIFACeuq0CzjAxPEHIzZHRQ4n7xBRfJ7VSdot3KXWrhzOBxOVuT434UJhyYv/ofgFVwwQCW6lTJgPlrbEkQ5MnpdS4afmZb6cLhauTh62dzQ1Da276dfcXuxXRCI2lo/ELtGfY7EqXyucJP9px5RibyA1UYYB7mqWzGmZsnyDiWKKjquEMDSOW5XCjFtuc7kxqW4dNdQY6a8iugb0s4S93swCGOVD6VvMIAR68q23aufAE6p4YHvctzDv1w3XAGvV2B742Vmw5Bs3EbpxIcCehxDUJnDLlJr2gOSESw2gegOwR2rTSra3ASxboY5lUxuorkpuWC2Gyt8g1AytJgyYoCMkKqlfUWpQYOAFpAoAZgA4eJrd6KnMRNAa01C2s9dQn9vxO8xqzytXFnF8Q0nDZJiBz2QpuLSpIIb/12EwS/v0dnGCYZYRUYm90Zw6u42ZM//Fc6Ovo88F2M2psNfBgLVQ7p/GShYFObJOet1P/eci8kY8OnJFbYiWHibAbdHx7oz0mu9mpQAQCPxgBpD0mN+rxPcvhwqNDtCo1C5YNCiYrZdSjE5ue5BH9FjAsxTCrIEJ1w
DKIM-Signature: a=rsa-sha256; bh=mdI5nbyV9jIdyPEl6xmUfVmy4mDn9Z2cesIeUhUmVzk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770620680; v=1;
 b=lDzFQw3Kw+EozO9usGyBSmfjFUtlfmLdiegehWYzJkV/KBoPK3iQoSrfOzGXZZ3e6M5Q+HI9
 r7ODaApC6ChQRNUKMKY9OzZXRK2E314GQ7yAduLFS1KQbR4MLm5JOGMMbR7zEs9MBXWi6Qc3f7d
 64LDj3yZUpxxaL6yLFh28o1Wg4GO5ReMTpZ6uodW/0dVOYwIgsN2Brj8wYwIWWAejrCbr/ROZ3f
 4cthbZ/UqB1UYte74fRlWthGi/vZrGBr+npbT+ROYnHLB+YA2kheNL96CmiLfVxLGNC65rRvTnM
 Yb2Z7Y2HFzwNJnRjCLedxiWshK1heVrcUsCIJC1s56jfg==
Received-SPF: pass client-ip=188.165.49.222; envelope-from=clg@kaod.org;
 helo=6.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2/9/26 04:17, Jamin Lin wrote:
> Hi Cédric,
> 
>> Subject: Re: [PATCH v3 00/20] i3c: aspeed: Add I3C support
>>
>> On 2/6/26 04:19, Jamin Lin wrote:
>>> v1:
>>>     The initial patch series was based on work by Joe Komlodi
>> <komlodi@google.com>.
>>>
>>>     This series adds I3C bus support to QEMU and adds more functionality to
>> the
>>>     Aspeed I3C controller.
>>>
>>>     This implementation is a basic implementation that introduces IBIs
>>>     (including hot-join), CCCs, and SDR data transfer. As-is, it doesn't support
>>>     multi-controller buses or HDR transfers.
>>>
>>>     First we add the I3C bus and controller model. With that added we
>> extend
>>>     the functionality of the Aspeed I3C controller so it can do transfers
>>>     and handle IBIs.
>>>
>>>     Next, we add a mock I3C target. It's intended to be a very simple target
>>>     just to verify that I3C is working on the guest. Internally, we've used it
>>>     on Linux to verify that i3C devices can be probed and can send/receive
>> data
>>>     and IBIs.
>>>     This target is sort of like an EEPROM, and it can also send IBIs upon
>>>     reception of a user-defined magic number.
>>>
>>>     Lastly we add  hotplugging support. The hotplugging doesn't do
>> anything too
>>>     complicated, it just adds the device attempting to hotplug to the bus. It
>>>     is the device's responsibility to hot-join and go through the DAA process
>>>     to participate on the bus.
>>>
>>> v2:
>>>     Jamin Lin <jamin_lin@aspeedtech.com> has taken ownership of the I3C
>> patch
>>>     series for upstream submission.
>>>
>>>     Changes in this version include:
>>>
>>>     1. Added I3C functional tests.
>>>     2. Updated patch 4 to refine register field definitions.
>>>     3. Updated patch 7 to correct read-only register field masks.
>>>
>>> v3:
>>>     1. Add Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>
>> Sob is still missing.
> 
> Thanks for pointing this out.
> I checked patches 1 - 20 of this patch series, and they all include:
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> https://patchwork.kernel.org/project/qemu-devel/list/?series=1051408
> 
> Do you mean that the Signed-off-by is missing from the cover letter?
> Could you please let me know where the Signed-off-by should be added?

I was confused with the previous series ... Sorry for the noise.

If you resend, please add your Sob at the end.

Thanks,

C.


