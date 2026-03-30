Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B111061B24
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 22:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7L7e-0007ns-Gs; Mon, 30 Mar 2026 18:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w7L7V-0007e2-54
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 18:30:06 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w7L7T-0008KF-53
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 18:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774909794; x=1775514594; i=deller@gmx.de;
 bh=UzpMNLX3pXM69vS+C0AHmNzQHlg0gVBSZnwF8s3rCa0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JEgHVBVNh5lOMjnmPzdJljhty4tmMo2XVqCvwtH80e2vlv6Q/NwAYizZEKVvfV1K
 ysCUwoCA6OmFXIsR89KuDhCdhI6UyX9ZhRyzmHwuY7qElnQBJ0subwLVjeLduz7Iq
 6LSThOcxYjxELk1d0XQxiuIx97nR6rHItmu1upU24b+Sb/nCO4VoLSQOc1okvGFnf
 BEtpVxhtLGD4hhRc4c84EJhDE13MOhuGcXgP2nq10/f9jIxbke7btTiSLXthL4JcW
 KloCqLE6iJ7Ficu2LUgGFDCAMTUyhviQnqc542UzTPrUDymemdA+BtqTcPm90zuOB
 V5Xv45ZvnCaRKkLBew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1wDcdd0nE3-000oIr; Tue, 31
 Mar 2026 00:29:54 +0200
Message-ID: <5b6b67e4-6a2c-454c-b30a-0692496b640c@gmx.de>
Date: Tue, 31 Mar 2026 00:29:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] hw/pci-host/astro: Add GMMIO mapping
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260330211859.19317-1-deller@kernel.org>
 <20260330211859.19317-8-deller@kernel.org>
 <9aaf1736-c355-4ba6-b6cb-6bdd03930eb2@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <9aaf1736-c355-4ba6-b6cb-6bdd03930eb2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vWgGlKYcGfwYGLuyf+iHVawRMnBtKYYDrkSm1h3gc6i7X5jYZ/0
 9jf1ieJdw5t67oBEqGaD5jwJf0199K8H8RMdJT/lK96G9aiorYuOqrkdzrKcvNMBVuXl3vk
 eT5aRMXMLfP4q3g2BBoq3tpB8+P+wuNEQV68uPYIIq/C/NgbZFrLBPogAIuRFWfQf4AJtNJ
 gR7hXN1GYxcXlaOvy9cCg==
UI-OutboundReport: notjunk:1;M01:P0:QY6vp7qX0G0=;BjfJYX4ZvqjlA/9wIKPlp+20yte
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/30/26 23:56, Philippe Mathieu-Daud=C3=A9 wrote:
> On 30/3/26 23:18, Helge Deller wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Implement the GMMIO mapping.
>=20
> As this point in the release process, this is a bit out of scope IMHO.

Well, no...
SeaBIOS has to initialize GMMIO at the same time and report
it along with LMMIO and IOS to the operating system.

Helge

>=20
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 hw/pci-host/astro.c | 71 +++++++++++++++++++++++++++++++++++++++=
+++++-
>> =C2=A0 1 file changed, 70 insertions(+), 1 deletion(-)
>=20


