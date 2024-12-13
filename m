Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAEAE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 20:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMCH8-0003n1-2S; Fri, 13 Dec 2024 15:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tMCH6-0003ms-HS
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 15:28:36 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tMCH3-0001wt-8U
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 15:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734121709; x=1734726509; i=deller@gmx.de;
 bh=PQzY+ADsuMNQW8QqoooEgWKZ0jUh+qEtMeKTEdG+fUM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=R9DlyJFV3UANScBQSklg2zMleXUUXtBCBoll7FHvPuLQ/8TTq5oYrfA8cNlXZtc5
 bJhS4w7POjShEWhZEaCIUX3JqrdVtLgLrEBcljpYDWyAH4aYg5TqYXJ2DkGwGs+1+
 1Jqxc9nRpvU7jIOZwF7+AiEtAHSLVslc9KKTE0DdDVfA43JGVQ3uVPztu4pwOf73T
 zCMRRv6B6hTgYy9sDykEiLHNdkaBJqvevwOI30AJxqn/URLaOCdP+OVQ3EbkXfVhT
 8FJNHCwHWY4NZvZcST35w4H3zx5I/j6y8sK7BlQNOE22o0N6EAOI8El7kj3zupvI9
 6+rnTTz6erd6hDcaBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.155]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zFZ-1tiyHW1EBP-00xOQx; Fri, 13
 Dec 2024 21:28:29 +0100
Message-ID: <f190aa52-d62b-4a7f-915a-001adc9f075b@gmx.de>
Date: Fri, 13 Dec 2024 21:28:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] linux-user: Add support for various missing netlink
 sockopt entries
To: deller@kernel.org, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <20241129143901.11291-1-deller@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241129143901.11291-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B9OMtDZxNXxSGDko0fd9J5t0TUfjh6rC+p/n89yHYEiP0V3p146
 GWaCXigW/pzqRHCQm6MJlplVWFi5kfyBFie7bR3UCRLWZ7d6N9Fr3/+1M30Ckr7R3gOaHdr
 DlLUROIxIokDg50zC60MHoLY+eaYwQ13Yml1iwaTHuEXSXFg/iKmZ6//YJt0QJ2NRyw5VVZ
 RK1MVFYWJi5pfIL2B3G9w==
UI-OutboundReport: notjunk:1;M01:P0:SBpn7nuzSCQ=;1ft0sY7SG6hPyQRcPAEX/ri71Y9
 BxxQQ/tbDlCklG5kt6dPbCLwl2j2EMoVnmIG76qZCrURoFtYQvG4hbaOjIeqffYZWZi3paWMD
 iM30mg/Uvh6u7IG2NMHp4Z0FxTXANDG6KYUAd9g3soTlt0GVOWZ18X7nYqllhIWCGsUbJiy1n
 grMNCCVlM2onIQnDgK0LdQ0k1a6oN2J6I8+RA/bakjyJxnhxRyDwNk2dEjaPYizGtrhqNgFHn
 1QdakO2o6AGyMMgg5MRk0xy98ObrZIo2iEQcfvhFYC15Br8r1D/HpgzJDc3ar/Arkj33oNQdN
 8HtoIR+xeEKzTxSIcfzbvLyJSKBFv+ys7FcTNDHFc1SZdn3yKM96KrCvS9hE6JPdsRM6PHSC2
 NeVOjOTGs8Lz9ypNGbCD5gz5mI3UzlfYw+mgKR2POX/2cdBO+sNQOW3u71+4aDFYOFdSJ0jeI
 yUXoQEgdXLCAVETeys4nu4IabCxGFlrvn6ZNSi/FZGZrnEdzrJDdwHqn5U/4cs6vS3jh+2SCn
 dkSF70x0AYcEzTLNN4+E775JADLstT0Lf+xe4dMHVh8Ey1sKMuzx/KoXXOUpW64ySR6UhjLB+
 EBmDdtGY4J9+9q6v0B28rb21fKyhGrslLHJQTmkuab+zj+GHm6WQmSagiEN6mvLwFYUUvlG6J
 QgNCnaGZiYTR/Xw6RJofahUlNLjJIVz3UE8HtiY6Hwt+aB9JdGvyMA6lk+ABvIvNyTuEQ6rL/
 lp6bj9p6NA6tBHwwc7uthKCY0Qtmb4T0VF32ak3ZyRf7lfHOho/p4WY/RV7Wl6ED4AcJ9tPZl
 ZcQYq+0CUcyjFmTOICElF1qEUyfkQ702CVOyI3CHH6Sfv36EX9NyPN7DELIEJxtJ0T3P/Myvo
 AlGF8c7RFsah7Rv2Oh/AurqvMD9pIbPG3qbZqBkrzvBmq+LqxLncB+Ld9jceDeTALNkS9u+qk
 p+V68FbH07nfRxM7gnWFMZ73cNbCnDr+5Tt/xZWu8+84ItOlqdDfdEL8lAcSqNrMsLHyoupuF
 FnZJku27wacONNBa5s/L101/K2bdMP4XqofSTzBU/aRWFx0dR7nDFgkM0ltH0HaJnUCcb4II7
 tW6tDZyfGwIDypT/xZJAmkebaCAosw
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

ping for review...

On 11/29/24 15:38, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
>
> This patchset adds various missing sockopt calls, so that qemu linux-use=
r
> is able to successfully build the debian gupnp package in a chroot.
>
> Tested with a 32-bit big-endian hppa linux-user chroot running on a phyi=
scal
> x86-64 little-endian host.
>
> This fixes debian's bug report:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1044651
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> Helge Deller (6):
>    linux-user: netlink: Add missing IFA_PROTO to
>      host_to_target_data_addr_rtattr()
>    linux-user: Use unique error messages for cmsg parsing
>    linux-user: netlink: Add IP_PKTINFO cmsg parsing
>    linux-user: netlink: Add emulation of IP_MULTICAST_IF
>    linux-user: netlink: add netlink neighbour emulation
>    linux-user: netlink: Add missing QEMU_IFLA entries
>
>   linux-user/fd-trans.c | 137 +++++++++++++++++++++++++++++++++++++++++-
>   linux-user/syscall.c  |  29 +++++++--
>   2 files changed, 161 insertions(+), 5 deletions(-)
>


