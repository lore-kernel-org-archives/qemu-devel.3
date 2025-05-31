Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A53AC5AE59
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 18:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLQXl-0002gh-8u; Sat, 31 May 2025 14:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uLQXj-0002gR-PQ
 for qemu-devel@nongnu.org; Sat, 31 May 2025 14:02:51 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uLQXh-0000iJ-Uw
 for qemu-devel@nongnu.org; Sat, 31 May 2025 14:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748714556; x=1749319356; i=deller@gmx.de;
 bh=Ae8htu31oOuuCSHRccSrnXLvnChRJBJjnTlT0faUNeA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ugW+AvMjU9qhUhEDVKMV3X2TLYAQ5351vJChtha8eA8dioLNY6YchaUFUnsdDM8a
 xZh69XdeeLM1WfixXOgldhl+cVdAzOtb/JSxbjs+fQUrCDTEGQSNRDBGneItzM+wH
 A63EM/3sDSwKMP/S8fUs5NsGbQ79HFtew7sm6n1In2MqK1lCGwQumMdLExPqAhXz7
 ssiO7bp+Vc/U92lWLXi0oKkFNpQXZ1IWeiAI9NAqtDFsEVtV6UvcnZ8g8Hst+d3BZ
 uCDLXd8T/DCjOFyiqICBu54zKeBF+7TYAeWgj5TWk1zitkrLbRbhDXr6dHQ3Bpgm9
 DlcgQlr5N1VrEWk2QA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.171]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzyya-1v8SU62FZm-00yxPG; Sat, 31
 May 2025 20:02:36 +0200
Message-ID: <23ddd4e7-dd4c-4386-aa17-a95bf9066e34@gmx.de>
Date: Sat, 31 May 2025 20:02:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pc-bios: ensure installed ROMs don't have execute
 permissions
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Cole Robinson <crobinso@redhat.com>
References: <20250530152118.65030-1-berrange@redhat.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250530152118.65030-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:08fDFFffNr4mHvDKtfD2yopT3g3DNO5+0fk2qLof7dU7CAKr9G0
 Ji+R0bSHXmnp1zkLafFVlmL0R+8VbnSN1M1X/Dn969u/JBBS10EcZmJ/lofI/yydOKAjeTS
 fhDO5NV9HbPot3yfmeSIv/NxCo2mS4SLO0i1mMOT93vSRCZ0aSXNKRgnt2+6uR2UPTJuCJ3
 yXKgcbxccdO0eVHzeZ3SA==
UI-OutboundReport: notjunk:1;M01:P0:/gOMAe993rE=;Sh0w8smtp2Un9zJ5eMYRb+7kTS3
 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
 +kicu//rrmi4I5jl
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 5/30/25 17:21, Daniel P. Berrang=C3=A9 wrote:
> We have been inconsistent about whether ROMS stored in git have
> execute permission set, and by default meson will preserve source
> file permissions when installing files. This has caused periodic
> problems in RPM packaging as executable binary files get analysed
> by various tools/linters, which can trip up on the ROMs.
>=20
> Tell meson explicitly that all the ROMs should be without execute
> permission when installed.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

> ---
>   pc-bios/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index 79bb2e1800..3c41620044 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -88,7 +88,7 @@ blobs =3D [
>   ]
>  =20
>   if get_option('install_blobs')
> -  install_data(blobs, install_dir: qemu_datadir)
> +  install_data(blobs, install_dir: qemu_datadir, install_mode: 'rw-r--r=
=2D-')
>   endif
>  =20
>   subdir('descriptors')


