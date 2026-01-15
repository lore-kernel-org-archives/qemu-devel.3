Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AADD41173
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLjq-00016I-48; Thu, 15 Jan 2026 06:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vgLjX-0000yx-S3
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:41:49 -0500
Received: from 10.mo552.mail-out.ovh.net ([87.98.187.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vgLjV-0007BV-6X
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:41:47 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.222])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dsLfq6FDCz5wr9;
 Thu, 15 Jan 2026 11:41:39 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 15 Jan
 2026 12:41:39 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R00399c69f9d-e96c-46ae-ae68-a61b87072c40,
 730BEF4863DC82B2970748FB5926F4A3C98AA806) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <aa50c2e6-8068-4eba-ba30-95e5c6412baa@kaod.org>
Date: Thu, 15 Jan 2026 12:41:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: migrate aspeed_rainier image
To: Peter Maydell <peter.maydell@linaro.org>
CC: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>
References: <20260113135941.3361163-1-alex.bennee@linaro.org>
 <770e5e68-f8a9-4321-821a-aa0930db0d95@kaod.org>
 <CAFEAcA9dz5BPdpB+2wukcJ=jgGCwkCTa7Y=FA4s+qzymg7gHRg@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CAFEAcA9dz5BPdpB+2wukcJ=jgGCwkCTa7Y=FA4s+qzymg7gHRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 1cc244d0-39e0-4805-b797-75ad2cc30a1c
X-Ovh-Tracer-Id: 15164464370461149999
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFnBAwFBvZ4XvCdK6IE0vQxTBMT6IFnVgcQrNZL0wRkQstRU44D1VoDv7Tdf+msoBudrk/ayMFcnp8h/WD9+vWjSOIAHGV7HOoMWrJvEWlZ95USfeLrOg39t9U1hNQBVcZjnOVz8828a8ySgER2v4fQulVJA5PpZN+bJSxDHEOwum5XhhvWR5uOeeP8QQ/MwhebIWpO23w/ZKZfrNSjtGEGvzyb9iR5fRvtx4De5tqi7ist/OTvJjZh9tobXPnMDBZXPuhfVjQBIqAYGrmC/vAL1IsCXx9zqVVXNkLkh/rshsE1aq3EzJdDcEBaAv/WPUXaeBzQ5wCXBkjK6ZKuKed5bPjREJxwkQE80jcUpbrhTCAZYgwt15YV8n1dbMbJ1PacasLzKRkSDjyIJILv0gSoXjLLDgDkpGUPU9hEi4gv1Wu0Tu5L+lfzr9ZxlUeP93VsKxVwTfPMRg+voz2rZK1U5UY/JFYswFct8TVKPpZ2ymQru1XYy8rrtJ2tfNXEeugcCY12WN5G09IPBQckU0PWbwxifDrfoffxvbDs2QyDpG3tefZSI5WkKGbAO8lZRd1OJgrq69DkoH0w2rff7rALzGVjbckBO9h8insTbnBUIH83VbV8rTFUU1zLZziRB3Wh9lSTnk4GMMAsjcJGAQrl+iyx3ypHqB0ui9WXqiVjnA
DKIM-Signature: a=rsa-sha256; bh=vWcvE3alVxjnHODyzGP6/PEw+G2R/3D3n1br6hLPo8U=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768477301; v=1;
 b=Dh3NGT4Y/FLo5hc3jWt1kDLfTPmLejdQAvxZBnAjyZBDK6IaD4OSnc908jXyTNzg1zUZBTRE
 obh1rRIBgAMfR4llqEM6hbdJRzrc4w0bNnqRwsvOdhAfLSn3ExscGVI7X4SLTW57XHTPshePxxU
 tXtqXnBdKxHaCYDaq3Am1zRFL8Q3rlqL5FlQazQekf8pMRM4MhF8DcJELw1fPEp1zLOeM1W2d8P
 b157z0VWg1Bu/UUSqEKH+pbnU9i9Q1HyIKXggocQNKYZ4FSBfVuzaRBRCmIaTFKeDP3tf1Ew9iu
 AAMBgAC20EzVin/r4dPI4YlYt2izv3PCdp+ixqDDSua6g==
Received-SPF: pass client-ip=87.98.187.244; envelope-from=clg@kaod.org;
 helo=10.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/15/26 11:44, Peter Maydell wrote:
> On Tue, 13 Jan 2026 at 16:19, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 1/13/26 14:59, Alex Bennée wrote:
>>> Cedric has a host for the file which allows us to keep the name.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Cédric Le Goater <clg@kaod.org>
>>>
>>> ---
>>> v2
>>>     - host at kaod instead to keep filename
>>> ---
>>>    tests/functional/arm/test_aspeed_rainier.py | 6 ++----
>>>    1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Applied to target-arm.next, thanks.

OK. I am dropping it from aspeed-next.

> I've added a cc:stable tag since the old URL will be going
> away shortly.
Thanks.

C.

