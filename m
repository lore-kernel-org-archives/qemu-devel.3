Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E13C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 11:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueBAM-0007AZ-V2; Tue, 22 Jul 2025 07:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=A8BM=2D=kaod.org=clg@ozlabs.org>)
 id 1ueBAK-00075U-4i; Tue, 22 Jul 2025 07:28:12 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=A8BM=2D=kaod.org=clg@ozlabs.org>)
 id 1ueBAF-0001Ln-Q4; Tue, 22 Jul 2025 07:28:11 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4bmZgk1V1Dz4x21;
 Tue, 22 Jul 2025 21:25:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4bmZgd2QMlz4wd0;
 Tue, 22 Jul 2025 21:25:16 +1000 (AEST)
Message-ID: <c35953cd-93ae-4ded-a5f0-466b8873f6d6@kaod.org>
Date: Tue, 22 Jul 2025 13:27:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v4 4/5] hw/misc/aspeed_otp: Add 'drive' property to
 support block backend
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com
References: <20250708055810.2868680-1-kane_chen@aspeedtech.com>
 <20250708055810.2868680-5-kane_chen@aspeedtech.com>
 <3da6275e-84d4-4911-8df1-6ed35bf63c07@kaod.org>
 <874iv4wmdv.fsf@draig.linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <874iv4wmdv.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=A8BM=2D=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.158, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URI_OPTOUT_3LD=1 autolearn=ham autolearn_force=no
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

On 7/22/25 12:27, Alex Bennée wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> On 7/8/25 07:57, Kane Chen wrote:
>>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>> This patch introduces a 'drive' property to the Aspeed OTP device,
>>> allowing it to be backed by a block device. Users can now preload
>>> OTP data via QEMU CLI using a block backend.
>>> Example usage:
>>>     ./qemu-system-arm \
>>>       -blockdev driver=file,filename=otpmem.img,node-name=otp \
>>>       -global aspeed-otp.drive=otp \
>>>       ...
>>> If the drive is provided, its content will be loaded as the initial
>>> OTP state.
>>> Otherwise, an internal memory buffer will be used.
>>> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Erm where is this email getting tagged as SPAM? The headers seem to
> indicate its clear:
> 
>    X-Spam_score_int: -39
>    X-Spam_score: -4.0
>    X-Spam_bar: ----
>    X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
>     HEADER_FROM_DIFFERENT_DOMAINS=0.157, RCVD_IN_DNSWL_MED=-2.3,
>     SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
>    X-Spam_action: no action
>    X-BeenThere: qemu-arm@nongnu.org
>    X-Mailman-Version: 2.1.29

I guess it's my provider (OVH). See below what I received.

C.



X-Mozilla-Status: 0001
X-Mozilla-Status2: 00000000
Received: from DAG8EX1.mxp5.local (172.16.2.71) by DAG8EX2.mxp5.local
  (172.16.2.72) with Microsoft SMTP Server (version=TLS1_2,
  cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44 via Mailbox
  Transport; Tue, 8 Jul 2025 07:58:23 +0200
Received: from DAG9EX2.mxp5.local (172.16.2.82) by DAG8EX1.mxp5.local
  (172.16.2.71) with Microsoft SMTP Server (version=TLS1_2,
  cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 8 Jul
  2025 07:58:23 +0200
Received: from output47.mail.ovh.net (164.132.34.47) by mxplan5.mail.ovh.net
  (172.16.2.82) with Microsoft SMTP Server (version=TLS1_2,
  cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44 via Frontend
  Transport; Tue, 8 Jul 2025 07:58:23 +0200
Received: from vr27.mail.ovh.net (unknown [10.101.8.27])
	by out47.mail.ovh.net (Postfix) with ESMTP id 4bbr4v1fkDz1K9FR
	for <clg@kaod.org>; Tue,  8 Jul 2025 05:58:23 +0000 (UTC)
Received: from in79.mail.ovh.net (unknown [10.101.4.79])
	by vr27.mail.ovh.net (Postfix) with ESMTP id 4bbr4t0F45zFpd7
	for <clg@kaod.org>; Tue,  8 Jul 2025 05:58:22 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	by in79.mail.ovh.net (Postfix) with ESMTPS id 4bbr4s4RcFz6dtBC
	for <clg@kaod.org>; Tue,  8 Jul 2025 05:58:21 +0000 (UTC)
Authentication-Results: mx.mail.ovh.net;
     arc=none (no signatures found);
     dkim=none (no signatures found);
     dmarc=pass policy.published-domain-policy=quarantine policy.applied-disposition=none policy.evaluated-disposition=none (p=quarantine,d=none,d.eval=none) policy.policy-from=p header.from=aspeedtech.com;
     spf=pass smtp.mailfrom=kane_chen@aspeedtech.com smtp.helo=TWMBX01.aspeed.com;
     x-tls=pass smtp.version=TLSv1.2 smtp.cipher=ECDHE-RSA-AES256-GCM-SHA384 smtp.bits=256
Received-SPF: Fail (DAG8EX1.mxp5.local: domain of kane_chen@aspeedtech.com
  does not designate 164.132.34.47 as permitted sender)
  receiver=DAG8EX1.mxp5.local; client-ip=164.132.34.47;
  helo=output47.mail.ovh.net;
Received-SPF: pass
     (aspeedtech.com: 211.20.114.72 is authorized to use 'kane_chen@aspeedtech.com' in 'mfrom' identity (mechanism 'ip4:211.20.114.72' matched))
     receiver=in79.mail.ovh.net;
     identity=mailfrom;
     envelope-from="kane_chen@aspeedtech.com";
     helo=TWMBX01.aspeed.com;
     client-ip=211.20.114.72
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
  (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
  cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 8 Jul
  2025 13:58:10 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
  (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
  Transport; Tue, 8 Jul 2025 13:58:10 +0800
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
	<peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
	<leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
  list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
	<qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [SPAM] [PATCH v4 0/5] ASPEED OTP QEMU model: block backend, machine alias, SoC integration
Date: Tue, 8 Jul 2025 13:57:52 +0800
Message-ID: <20250708055810.2868680-1-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-OVH-Remote: 211.20.114.72 (mail.aspeedtech.com)
X-Ovh-Tracer-Id: 12933493708818734458
X-VR-SPAMSTATE: SPAM
X-VR-SPAMSCORE: 200
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkffoggfgtgesthekredtredttdenucfhrhhomhepmfgrnhgvucevhhgvnhcuoehkrghnvggptghhvghnsegrshhpvggvughtvggthhdrtghomheqnecuggftrfgrthhtvghrnhepgeeggfdvuddtgfegkefhudetjefftdefkefhhedtkeekffegveehgfeiheevvefhnecukfhppedvuddurddvtddruddugedrjedvnecuufhprghmkfhppedvuddurddvtddruddugedrjedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdduuddrvddtrdduudegrdejvddphhgvlhhopehtfihmsgigtddurdgrshhpvggvugdrtghomhdpmhgrihhlfhhrohhmpehkrghnvggptghhvghnsegrshhpvggvughtvggthhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegtlhhgsehkrghougdrohhrghdpoffvtefjohhsthepvhhrvdejmgdpughkihhmpehnohhnvggmpdhsphhfpehprghsshgmpdgumhgrrhgtpehprghsshgmpdhrvghvkffrpehmrghilhdrrghsphgvvgguthgvtghhrdgtohhmmgdpghgvohfkrfepvfgh
X-Ovh-Spam-Status: SPAM
X-Ovh-Spam-Reason: vr: SPAM; dkim: disabled; spf: disabled
X-Ovh-Message-Type: SPAM
X-Ovh-Exchange-Junk: True
X-Spam-Tag: YES
Return-Path: kane_chen@aspeedtech.com
X-MS-Exchange-Organization-Network-Message-Id: 126a28f3-a563-4c49-b5da-08ddbde472e1
X-MS-Exchange-Organization-PRD: aspeedtech.com
X-MS-Exchange-Organization-SenderIdResult: Fail
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-ABP-GUID: bd2a0b77-ce4f-4d81-a151-b15427a5e809
X-Ovh-Tracer-GUID: 51d3ce0b-f2d1-4f5a-a08a-a00eb1ad14da
X-MS-Exchange-Organization-SCL: 9
X-MS-Exchange-Organization-AuthSource: DAG9EX2.mxp5.local
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Transport-EndToEndLatency: 00:00:00.5736284
X-MS-Exchange-Processed-By-BccFoldering: 15.01.2507.044
MIME-Version: 1.0

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

