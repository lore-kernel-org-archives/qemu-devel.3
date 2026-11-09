Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC860A2610
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=csclub.uwaterloo.ca header.i=@csclub.uwaterloo.ca header.a=rsa-sha256 header.s=202502r header.b=Apu0Egyd;
	dkim=pass header.d=csclub.uwaterloo.ca header.i=@csclub.uwaterloo.ca header.a=ed25519-sha256 header.s=202502e header.b=5Fpv4STR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQY0k-0008Q4-2f; Mon, 09 Nov 2026 17:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7661c7e87=s23adhik@csclub.uwaterloo.ca>)
 id 1xQY0h-0008O4-8Z; Mon, 09 Nov 2026 17:38:43 -0500
Received: from esa.hc503-62.ca.iphmx.com ([216.71.135.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7661c7e87=s23adhik@csclub.uwaterloo.ca>)
 id 1xQY0e-0004WU-Q7; Mon, 09 Nov 2026 17:38:43 -0500
X-CSE-ConnectionGUID: jnHZffddTmOU5X+sjCExYQ==
X-CSE-MsgGUID: p0C/pRDITLKNxswA+6MPjQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AC0g91mrqipZjfB4cETcj7kTmUcIjUk/TwnvcH0q?=
 =?us-ascii?q?fNDtZC6aXYnKAyZoxxg=3D=3D?=
X-Talos-MUID: 9a23:Qr2IMAoACu91x6HH0J0ezyk6H4Bw2YiPNGQut4UdpODHawlIOQ7I2Q==
Received: from smtp.uwaterloo.ca ([129.97.208.46])
 by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 17:38:44 -0500
Received: from connsmtp1.connect.uwaterloo.ca (172.16.137.90) by
 connsmtp2.connect.uwaterloo.ca (172.16.137.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 9 Nov 2026 17:38:21 -0500
Received: from mail.csclub.uwaterloo.ca (129.97.134.52) by smtp.uwaterloo.ca
 (172.16.137.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 17:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csclub.uwaterloo.ca;
 s=202502r; t=1794263900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HRNB/qbSpVQ4fVl7VxylbrKtPen22FO3wQnYnVKZH3A=;
 b=Apu0EgydtwvpZwebAnd2yTsuAns8ljN0jlHbCQIb/FgFVx7ZCKXS6FlEcxYzYQHuI53fkM
 IFKxkI4AUwGcdiarJk7qRQbHygzJ/7ISkWih1Mi3QIqs9Hqx+/MKpPuCOS8c1Xt+zeBrEZ
 lvmpr10C464rEeizUOJHE7NIPlLi1v73icw2XJjc9PQ6LFE8bhgZeT+0mbfuLyqQST0AN7
 G+iJHLmHIuda1UA9aY7pMic4tG2wgPyZjz2R2RFbTsQ5g1Ok5rqnOkQWFq8TAF0m2dC/b9
 QjH69dK8HnTTbDxo5FVJo0SkKNGjr4yZ7lVODLJZGhTZ09d7rW524oZyK8k4IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=csclub.uwaterloo.ca;
 s=202502e; t=1794263900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HRNB/qbSpVQ4fVl7VxylbrKtPen22FO3wQnYnVKZH3A=;
 b=5Fpv4STRZpHBABAmyek7webghPF+jiROLgJQTNBlTD5cWQNR8buLSfbUHUx3y+HoZUco+6
 vn9Dfrf7aCdBHmDg==
Message-ID: <7aa2bd16-d450-4169-a458-0d2e821dea78@csclub.uwaterloo.ca>
Date: Mon, 9 Nov 2026 17:38:19 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bcm2838: Add GIC-400 timer interupt connections
To: Jayesh Agarwal <agarwaljayesh03@gmail.com>
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <3cca4eb3-09d1-4467-81fd-27a5bfe19a3e@csclub.uwaterloo.ca>
 <20261109114944.21801-1-agarwaljayesh03@gmail.com>
From: Sourojeet Adhikari <s23adhik@csclub.uwaterloo.ca>
Content-Language: en-US
In-Reply-To: <20261109114944.21801-1-agarwaljayesh03@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.71.135.51;
 envelope-from=prvs=7661c7e87=s23adhik@csclub.uwaterloo.ca;
 helo=esa.hc503-62.ca.iphmx.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jayesh,

I think I've been a bit swamped with work. So I probably won't be able to work
on this for a while...

Feel free to take a crack at it!

Let us know if you need any help!

-- Sourojeet

On 2026-11-09 06:49, Jayesh Agarwal wrote:
> Hi Sourojeet, Peter,
>
> There has not been any follow up since March 2025. I would like to pick
> it up using the TYPE_SPLIT_IRQ approach that Peter described, as done
> for I2C in commit fb3e0557. Your work will be credited. However, if you
> are still working on it, I will step back.
>
> Thanks,
> Jayesh Agarwal

