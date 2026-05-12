Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D05DCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 16:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpYd-0004wO-8A; Tue, 12 May 2026 12:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wMpYC-0004lW-Jn
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:01:55 -0400
Received: from 10.mo533.mail-out.ovh.net ([46.105.72.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wMpY9-0001F0-LM
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:01:40 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [51.68.80.175])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gFLtk03cSz613s;
 Tue, 12 May 2026 16:01:33 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Tue, 12 May 2026 16:01:33 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.168.184])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gFLtj4f8jz5w9Y; Tue, 12 May 2026 16:01:33 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id EBEC11B43591;
 Tue, 12 May 2026 16:01:31 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001e58bd7d4-4e0a-45dd-8ed6-0a240e2513bd,
 39874C6F3F9F68F15966500C6FBBDB0B53A96BD7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <90c17098-c8d9-41a4-b988-8657fe84926d@kaod.org>
Date: Tue, 12 May 2026 18:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] ast2600: yosemite4 initial support
To: Alexander Hansen <alexander.hansen@9elements.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, titusr@google.com
References: <20260505154410.230969-1-alexander.hansen@9elements.com>
 <20260505154410.230969-5-alexander.hansen@9elements.com>
 <78ded35c-18d9-4469-a20d-6974646e4557@kaod.org>
 <1fec82cd-33ff-4cbf-9f8b-c14a5cf622a5@9elements.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <1fec82cd-33ff-4cbf-9f8b-c14a5cf622a5@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 5682698307035966475
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFrXGij6xEoILIO68TlpBxfC7cigd34mIYVX0KTo1/WZe8Fx6tpnAXwfgi9FukATrze8jEEE5BXNF6GxPENDX6D+sTsVI6qTvLu3oD9QX3ZArPj1666YYDkFHCteU03NxdxY4/PwBGSjNhcSFwLYwb53uNyf05SmSI96L5tdStmHQ7D50d3qyu5NCUqi/DC5VIjy8Y03St7J3H+wPhJIv3I3PBtB6b0CdOKJJPynWNT9hMBQtMD1PiJRL7mGFZvh3+9TnDdhOsQvJ6qOBVuIGcNnocxaVbM+hztmrQFgfVTzT9kcsCfssSF7JH+pauLQt1wcG6KNaYw0XaG5QAghe9pt66PTkpaZB1xn0yELGpCZ+3k0zrifCwyyGhSQylhecBtnvChbu9iOPBbZedZ6O8TPCrRkpC/xKPwqwzb/33vatMthX4nddHG70RavPfrGKLsaFvEsxj5Uu4bGB9bJvCIQ3iFr8D5doXeHYFMocsNQboCZupot/JyhnP1FIrfBfyo/lIJEmQ4pTiu6AVZHtScRxBrS7d+yKRBXl1Hc4c63Ga585OcjXH7X96KnipfnhTFzxIh/0twEecqwekbyMmMqetYJmi9yP0XyD0F/QmVBsCZF3i7htDnFSCmQbx5sg9dzNjXGlvChNY4IltzpVdlsBqPNP3qbg3KnNf5Mysy2g
DKIM-Signature: a=rsa-sha256; bh=WP3qwgeatGs7hK9isQtYQzJvr9o01yFxZwkD9rc4G68=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1778601694; v=1;
 b=KWvshc1hSeUnhheFy4QrwmqwJHo77zouv2S+xtX0KTFBQak88BS5GPWmPpBwochaSGXZIhyk
 wpc32oJdMm1fkWZY+aZ7g/tJnN5ewMReQaphkK0wtMo2tgKdp93PLJ17RaFTd0y1WdwFivyRIhx
 c/FMisVTTNR6bMT8mp+RejDz10EEzko7bRd33iA4Ou6U35OIdFBoGnRGawcnI09RaToUAghjPdT
 eVPMdOi2vRdRSHk+sVJSBVowWYN6FpUBEMo7JQD6hki7+py3F45vZNdbW1Mt6xhMVrk4k+H5NHy
 2OTjAwBACtAJ7eGmUUKjI6IqX4iI0zs039aoq6c0XQW4g==
Received-SPF: pass client-ip=46.105.72.194; envelope-from=clg@kaod.org;
 helo=10.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Hello,

On 5/12/26 12:39, Alexander Hansen wrote:
> Hi Cedric,
> 
> thanks for your ongoing review :)

yeah. It takes a few respins.

> I sent v5, summary of changes:

I see a v3.

What's below would have been great in a cover letter ;)

> - I CCd you and Titus on all the patches now.
> - removed the backticks (markdown syntax) from my patches. I was used to this workflow since some other projects use commit linters which get tripped up by log outputs.
> - restructured the series as you suggested (board, then functional test, then sensors)
> - removed some unused includes on the machine file
> - removed some unnecessary variables from the machine file
> - linked to your github tree for the fw image for the functional test, since the image is now available there
> - added new section for each sensor to the functional test with some command sequences and expected outputs
> - added new entries in MAINTAINERS file for Titus for the individual sensors. Your maintenance of the fby4 seems to already be covered by existing regex.
> 
> Let me know in case there is extra tests i should write for the sensors other than the functional test.
> 
> I saw the tests/qtest/tmp105-test.c , would that be helpful for the new sensors as well to write a test like that?

It is always useful to have, especially for covering corner cases
in the model that are harder to exercise when running a full OS
image. Some MMIO sequences are much easier to test in qtest than
by building custom firmware for them. It really depends on the
complexity and criticality of the model.

Thanks,

C.


