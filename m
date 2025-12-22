Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D5FE6ADC5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 20:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXmh9-0007zR-P7; Mon, 22 Dec 2025 15:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXmgs-0007xL-KY
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 15:39:39 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXmgq-0007RV-9T
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 15:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766435974; x=1767040774; i=deller@gmx.de;
 bh=wkfnTwMgxPltHi2RBnGUhEBlrApBYajQ4RW3oTyPrYc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=erWoio0azvrf0ARWG5xbdAUAPKgepUKTgqJP3dYtQrm7Da6YjUtR/SeOJ5CBTUi5
 aTUQ6OeZkWoXxVXreR9OYIXVAHyubW11wXWEWadZd0axEkdM/VZ5qmRrhfwtMpvzN
 QBDvEeONM+nD0ys3lmEXun95sl7J0arAOFE9IEjkEagGjxDypRWFvnPX84BS8jfbq
 Km9z6Mt/rpszv3S32k3OKoccYwfa6N8HPmJylqiJ99TzR7bq/a5zBCnd5LAAAkEga
 LE/NVg1IoYygwiWELqbk41FdWU/mET2j4zXZfLOXMLjt10jXyfx2qCvrcQ/cmOxOU
 bImnfDG3/WXOYj/yMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.229]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWzfl-1vQxEF33Mn-00UHvS; Mon, 22
 Dec 2025 21:39:34 +0100
Message-ID: <316c1b8b-e560-43e0-b977-1573148b7f88@gmx.de>
Date: Mon, 22 Dec 2025 21:39:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] scsi:ncr53c710: Add LUN scanning
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 qemu-devel@nongnu.org, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
 <20251221142317.266293-8-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251221142317.266293-8-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NbIi+Vh9DIzQ6pA5urlq2OTPeyqYdqYzHyxwRwxZxlyh/Te1hPd
 pvDoHHMRLDjuVkOwNLQPEo558V2isQ/LN23V5VSb5y7NoCcY5Eba8fVbGwkKgn1CN92+lwx
 VUZGrwHfGsX38suyMTz//TLoLlLlgqZFbi0Ecf/q+QZhVRsnyQTMIze8fXJ8KuOcMJOrf/H
 WxrNJorRMmfqJNuo7sPRg==
UI-OutboundReport: notjunk:1;M01:P0:D/ZCXTczw8w=;fHvO/z0mri09sNyi5cfacAUXmt5
 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
 fzyjorikzHuoedg6QbDZDPj/DA=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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
> Add multi-lun support by scanning all 8 luns when ANT bit is set
>=20
> Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>

Tested-by: Helge Deller <deller@gmx.de>

