Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8D6F53D78
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2BJa-0000Am-Hx; Mon, 16 Mar 2026 13:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1w2BJI-00009t-A1; Mon, 16 Mar 2026 13:00:57 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1w2BJD-00028R-K5; Mon, 16 Mar 2026 13:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773680443; x=1774285243; i=deller@gmx.de;
 bh=weXdtGXuX3l7zQhleAu59wO6y0QsDKw9JUGSNDNjYyk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=o0Ce/oNQ0r8qpfmHntXsgt4DpbqPDJDK6tw7XYcee4sMnPAN4co6vlWTOb4qkYN1
 5YgmM+G2PAnZE5JjkOpCHXjdAWPMlpURPEcMXAseGh4U8MCERWSNL9Z6vNKMDdQem
 j43iZmDxWKrEReCvq+YGTI7cvpVRO+ZNv+2kV9BMDU6Ad7BhsjPw6dxRg5bkMelTu
 U2mha3WC04YdAcrQSk6pYpnx4dMTxbJyKPKpTOil9rzb1OPJpjNuPPRtL3jd+P5x8
 Xu5j7WLkwfkyCeIVVYeLaajh9yZBwL6Nf3Yw2MbcWcf36zc17ZvveXOmLBhYc2nRc
 dai4n3aOpbaW79TmSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpNo-1vTfZJ2qW2-00iYDG; Mon, 16
 Mar 2026 18:00:43 +0100
Message-ID: <0864102b-f32d-41a1-b19a-7eb9b237b368@gmx.de>
Date: Mon, 16 Mar 2026 18:00:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Linux user for v11 patches
To: Michael Tokarev <mjt@tls.msk.ru>, Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org
Cc: Razvan Ghiorghe <razvanghiorghe16@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable <qemu-stable@nongnu.org>
References: <20260313183009.34221-1-deller@kernel.org>
 <66022765-b7b8-4f46-a90a-43dc473a16fd@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <66022765-b7b8-4f46-a90a-43dc473a16fd@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aMQKpHqPUT8wdzSjPa5+aA7s+6kfYl6Ja/HwO7B4G3C4b30Y4PN
 LfuDlUuDYmjB3O20TeHBSMIe7KLn/9HuRerXkzCjQAxl7HVcB0rkS88m5oD+FwyprmfFZ9Y
 d9F4mKKNl7Bg7BWRweeQBJAQcOpZhBGLYvtprL1zs74VVoOW144u+8X+fS9G1Uf/wuPVfTU
 uzrk2vq6oanATAmsKHiwg==
UI-OutboundReport: notjunk:1;M01:P0:WxcL+Hfzm+U=;CA7K2pIwERpeIjmiK5nmpKuCQvV
 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
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On 3/16/26 14:43, Michael Tokarev wrote:
> On 13.03.2026 21:30, Helge Deller wrote:
>=20
>> Razvan Ghiorghe (2):
>> =C2=A0=C2=A0 linux-user: Fix zero_bss for RX PT_LOAD segments
>> =C2=A0=C2=A0 linux-user: fix mremap with old_size=3D0 for shared mappin=
gs
>=20
> This looks like qemu-stable material, is it not?

Yes.

Thanks!
Helge

