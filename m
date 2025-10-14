Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6581ECCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 17:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ijP-0000RR-Qh; Tue, 14 Oct 2025 13:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan@islenet.com>) id 1v8gB2-0004kt-6b
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:39:02 -0400
Received: from lin1.islenet.com ([2600:3c03:e000:2e3::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan@islenet.com>) id 1v8gAv-0000Ta-P7
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:38:59 -0400
Received: from localhost (localhost [IPv6:::1])
 by lin1.islenet.com (Postfix) with ESMTP id 0D9CBF587E
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 10:38:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=islenet.com; h=
 mime-version:user-agent:content-transfer-encoding:content-type
 :content-type:references:in-reply-to:date:date:from:from:subject
 :subject:message-id:received:received; s=default; t=1760452726;
 x=1761316727; bh=vdbUDl7UbxlgbDCkGWGOC8k5rQkr5MDU/yFLZqabLys=; b=
 g46JU7Yz8MFBQIzIoLlZWJ1nQUgVekLXblxqlYNNd1SDQPcDf+U+UrpbHPeZG6CQ
 OucQO8vkrDU+1zzVy/wDfmc3SAE72SWCaiglnGo5aqgwXxjg7+k6FehAQpoqcf7U
 yxVP8ngbulVSCMZmvNhlBPQ/kcZjAZ/JqvnBnlo/RDFvBaoJesdXl6oPq4/HGWep
 /n3l5+C8bPIKIeHm1n8ZwC/Bwgg6N6eERk+6fo7DiJJvIXQWuobbEDYLlBeCvvZz
 XmIBLTj0WnUWpJAwofZzEbccWNu+9136fwn9Dp0z9GB+8b/JreCJ9moi1r96GnvZ
 7WZ5Na1qRV/JI3FFcDFlNA==
X-Virus-Scanned: amavis at islenet.com
Received: from lin1.islenet.com ([IPv6:::1])
 by localhost (lin1.islenet.com [IPv6:::1]) (amavis, port 10026) with LMTP
 id LUrFXBjZRne9 for <qemu-devel@nongnu.org>;
 Tue, 14 Oct 2025 10:38:46 -0400 (EDT)
Received: from venus.islenet.com (unknown [IPv6:2601:985:300:a441::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lin1.islenet.com (Postfix) with ESMTPSA id BF544F5870
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 10:38:46 -0400 (EDT)
Message-ID: <049abab6fcd8a07dc32afd6c914e7dc920bc68ce.camel@islenet.com>
Subject: Re: DOS 6.22 with LIM 4.0 Expanded Memory
From: "Daniel L. Srebnick" <dan@islenet.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 Oct 2025 10:38:46 -0400
In-Reply-To: <69de1286-0750-47d1-bac6-26512a339018@linaro.org>
References: <ebb4d277d49d53e55d9c0d56375df29981631c3e.camel@islenet.com>
 <69de1286-0750-47d1-bac6-26512a339018@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2600:3c03:e000:2e3::1;
 envelope-from=dan@islenet.com; helo=lin1.islenet.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 14 Oct 2025 13:22:38 -0400
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

On Wed, 2025-10-01 at 23:42 -0300, Gustavo Romero wrote:
>=20
> A command line to start the VM would be better than the XML file,
> IMHO.
>=20

qemu-system-i386 MS-DOS_6.22.qcow2 -machine pc-i440fx-9.2

Assuming that the qcow2 files has an MS-DOS 6.22 image.

In config.sys, you'd need a line like:

device=3Dc:\dos\emm386.exe ram=20




