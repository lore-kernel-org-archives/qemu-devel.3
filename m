Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BCBFC6160
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 19:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc76q-0002B4-Cf; Sat, 03 Jan 2026 14:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc76o-0002Ar-Vh
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 14:16:18 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc76m-0001Jq-KV
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 14:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767467774; x=1768072574; i=deller@gmx.de;
 bh=B0RBJI72EEQfGh3xgtirnz/+TojMYavob6MN+HRrYAg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Tjss72z2o+VAHWjE0yfwrp2kGJ3rpBvtoVGLVE1eHiBFwNfQCe4CBM+UtsOGwfTm
 5nT8xltbXnIaYMxAZxDNyM8RL3bE+soRFjdT1k6Lu6q+d2kQWdT+deSsITpIFxoEp
 Mw+BeZGGhZFz/nF4wS1Mrm75xbjejsbea9TCM00fLHi15fhMO6JoqJ9CQOoWRf+Ok
 H7YHCaBGXKGcBLaMBuNIzZXcvBNKR0/iii64uBOAEh+ZUJXiyKPXaffic2y1y9JkV
 R/bScgZ7Aa8IWx29nsFFHZe0q9eg0BjMZgr24dvsvPJbe5nY/Vzrw/gkj4zJZuw9W
 JV5qobu5bY/LgUDVJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.116]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUosT-1vSw8q3sq9-00WRon; Sat, 03
 Jan 2026 20:16:14 +0100
Message-ID: <7f76c078-0a39-4d2c-94d3-04075f9fb85c@gmx.de>
Date: Sat, 3 Jan 2026 20:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/strace: fix printing of file offsets
To: =?UTF-8?Q?Jean-Christian_C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20251225183644.1919184-1-jean.christian.cirstea@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251225183644.1919184-1-jean.christian.cirstea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xQsMBoxtx5JRBazzCpJcx+YRFpc2YZz/Sdq2VxZ3wPaMbeSppOL
 l3hg6TLGwMWE6urpzTaJh+fRoNnMaLqwFUGHB2eUqeiNSRbJpkUySb6gVQQ83XXxmr3MeT/
 eMqdqd9UdPk0+oZUCkc1Z9nL/v8nBNDq0feMwp/IvLTiT2yW9xlsEPtduiSSOHM97KWrMK8
 U4uGf4XZS1cD3RnF9RzyQ==
UI-OutboundReport: notjunk:1;M01:P0:u347mGb6UHw=;hwISlYPfegCnb0sk57YpXcOcxAl
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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

On 12/25/25 19:36, Jean-Christian C=C3=8ERSTEA wrote:
> Previously, 64-bit file offsets (loff_t) were printed using `print_raw_p=
aram()`
> function, which led to silent truncation of the upper part. This commit =
fixes
> this issue by adding two helper functions:
>=20
> 1. print_file_offset32(): prints 32-bit file offsets (off_t)
> 2. print_file_offset64(): prints 64-bit file offsets (loff_t)
>=20
> *NOTE*: checkpatch.pl gives the following errors:
>=20
> ```
> ERROR: externs should be avoided in .c files
> #30: FILE: linux-user/strace.c:88:
> +UNUSED void print_file_offset32(abi_long offset, int);
>=20
> ERROR: storage class should be at the beginning of the declaration
> #31: FILE: linux-user/strace.c:89:
> +UNUSED static void print_file_offset64(abi_long low, abi_long high, int=
);
> ```
>=20
> The errors are may be removed if `UNUSED` and `static` are switched. Sho=
uld this
> patch fix this and swap all `UNUSED`s and `static`s?

I'd ignore the checkpatch warning for your patch.
If a switch is done (and wanted), please send it later in a seperate patch=
.
 =20
> Signed-off-by: Jean-Christian C=C3=8ERSTEA <jean.christian.cirstea@gmail=
.com>
> ---
>   linux-user/strace.c | 38 ++++++++++++++++++++++++++++----------
>   1 file changed, 28 insertions(+), 10 deletions(-)
>=20
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 758c5d32b6..f790cab4da 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -85,6 +85,8 @@ UNUSED static void print_enums(const struct enums *, a=
bi_long, int);
>   UNUSED static void print_at_dirfd(abi_long, int);
>   UNUSED static void print_file_mode(abi_long, int);
>   UNUSED static void print_open_flags(abi_long, int);
> +UNUSED void print_file_offset32(abi_long offset, int);

^ shouldn't it be static too?

> +UNUSED static void print_file_offset64(abi_long low, abi_long high, int=
);

I think it's wrong to have "low" and "high" here.
This very much depends if this is on big-endian or little-endian machines.
See definition of target_offset64() in linux-user/user-internals.h.
There it's called word0 and word1, which is probably better.

Overall your patch seems ok.
Did you test it on little- and big-endian machines?

Helge

