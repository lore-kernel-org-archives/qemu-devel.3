Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400F3E6ADE7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 20:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXmhf-0008PT-Dd; Mon, 22 Dec 2025 15:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXmhb-0008LW-QV
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 15:40:24 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXmha-0007h5-94
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 15:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766436015; x=1767040815; i=deller@gmx.de;
 bh=T08o/uz8tw7JLJk2XMTYM6gIRORJTc2dpR6KzQocsKE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=uiaK6gW4+DZEWwHLqgGVnleAEjcnQ/zEvcR8alBNYYx+VXKtTY0RImarRm48gU9+
 Cs0XRVd1DNxMpH6yNR4FKp0u4jftfggifXpuQ3gXibbeza2a+z40FX/mZEhEQ98oM
 X9Rmz8Xm94FrTenWdruwDKkSQ/L/MERgrkWhpRm/P4jvXFJ0FsuHVhzVHzMgFQDfC
 92sP1nisKl3WNaQ+0/wFz0DANOnq+OIqSAkn6ExjkllwykC+ZnzbW5dkjOOnUonfy
 N2d1CXAHzLnCBwOxVNM4fEp07C/DEgelgBUaaRCQB7Y4WEIOhV8Mw7Pjqsml2melV
 wAzhxhSF0sXbF2zYjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.229]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzhnN-1vtSQA2gwj-00zTuD; Mon, 22
 Dec 2025 21:40:15 +0100
Message-ID: <80f6b708-e490-4218-ba92-db92c81dc15a@gmx.de>
Date: Mon, 22 Dec 2025 21:40:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] scsi:ncr710: Fix DSA register
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 qemu-devel@nongnu.org, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
 <20251221142317.266293-10-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251221142317.266293-10-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3B2JuPMEWGxvYEf0TVabQBXNfFMSOagYG91O5ZJ3AXxVOj8W6YR
 49mVJDwMlMVQhJZ46xXdpjG7vGVK6X2TpfO0PSSP4B6IrmRyMTK6E/ceLPLwN1/5pD4emd2
 AYydCnOBHG9o+nBQBrKynvq5xs98gssRdLhgsLxXb7G43iAq6NZ5+d7S/60oqNv3gXAZVsW
 vtukD7c3g/Dpw48TV9Wfw==
UI-OutboundReport: notjunk:1;M01:P0:WJIr8BIqmxM=;W0lu8/utAbndjW8kJqDCsenVwuL
 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
 mxqjaJtAAkzEXbMxzpNcVl+hFHD0d
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/21/25 15:23, Soumyajyotii Ssarkar wrote:
> Implement byte wise write handling for DSA register instead of using
> the macro, as NetBSD driver accesses it byte by byte
>=20
> Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>

Tested-by: Helge Deller <deller@gmx.de>

