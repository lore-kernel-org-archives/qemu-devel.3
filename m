Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8F7D3B7E8
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 11:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSZ8I-0007W3-JO; Mon, 08 Dec 2025 06:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1vSZ8F-0007VJ-6n; Mon, 08 Dec 2025 06:10:19 -0500
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1vSZ8C-0006ni-VX; Mon, 08 Dec 2025 06:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1765192205; x=1765797005; i=laurent@vivier.eu;
 bh=3ZYk1PxAi4ZGCsg0hoODXKyqMgaOOWn/kDu1Z0dqpMs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=oaU6rwg9jk830cVedZTrqTbrBD+i4J6kPNlio65oTrSssoP9EvCAsBlOcvjTklIl
 g3mIxGcUHp4NKMs1zLjD7+HMAJPURpf9KIyDj8AnMIMtHedGcnKz4v3EvIhvJPy1K
 DgNaUsyru0cUW+i/j2g4eiIFTPzibhXkPPbXRURC4oTGXFExOKVTmyhfzqNwnIleh
 Me5QdPU2eDXzl/mshJbQINMoNMUw/yCwW1NSVxZu+6dRpyqr32SMbIVqlNNuYDKYj
 0e+65hS1TydbiQf8WXZy8IYk9A5KhTi3Lv9C/BfgjIe7m1ELVKscXMtmBHtSdy0Em
 Koofg7S2x+8Y4ZyOIQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mnq8Y-1vq23b12iI-00lhCc; Mon, 08 Dec 2025 12:10:05 +0100
Message-ID: <a961c501-d6e6-4567-8e35-9ddaf6356dcd@vivier.eu>
Date: Mon, 8 Dec 2025 12:10:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] tests/qemu-iotests: Fix check for existing file in
 _require_disk_usage()
To: Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 qemu-trivial@nongnu.org
References: <20251208075320.35682-1-thuth@redhat.com>
Content-Language: fr
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20251208075320.35682-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jKhlqREaYzyZHqa0X2CAM621Bc2E1zAfHJC0TUo4NZBYGz8Z7lF
 La+KuOXUjmxee6NJypn2XIXBz02sAVwLYvLz81UXKDS5EYSka35f/RQuYeIqIR6KiyjI/ih
 e39bADefTjajJT264NpQZ1t7CGP7bF+ZSnESyFi4X/wnG8j7Z5wsbLFOcjQAhYcZqPs7HY5
 JEqUVQRpJR2Z3WNRiNbPg==
UI-OutboundReport: notjunk:1;M01:P0:QT3zAtWEoco=;ro1MyN6RwF7OFoa8ZjLf7vI6+oq
 PeoQx/pKaKg2C7YcdVYHC8NLTRyVsH/gHmzebBXFJZB8wAzBd+X1kV0h2QUWeAfb+OoFack40
 KdPTxKDpqRAdfdc3kA18yt5cu0PY1nSHG+/r7xXsGbGlcHXkgC8taTINpyJfDACw1XKuHV0HN
 rVfW5nK6ncmUxsqJCs6aGO3xVjfChTYKaZpIihXxIW97SpMrWuZm7XuKoQr+EFzWVOlhxmraL
 Np8ki7/5UeYqBeBfnHtO63h5Zvi3gwxhgmlrIVpC4KBpQKBJiSuSa+IYhHZLipKNFpkkh2Esi
 OZfIpYg+jIiO9j9FBX3R6JW9YYdwbI7zfpi0V38EXpOuByuRFy6PmCakT/taKGEnaJ/ggRv0Y
 kyFjKeJEeH+myHosqxWTPSLB3c/rS1X+o+bg2aAREfks9M+k8Sr9otv5G4wD9xYPf8qjXFQqi
 BAz0n1KnugGm0uyHq2BiLzaZpegbvCuMx6CAkA3qX7n5RaQBPpUrs+DG45EJcQOHJmTuUtml4
 XMq3mzJPHmu1TVwVIRPpLl0oHOpeqIVSsggGfOWIt3/JYwHvld1sbQkO7PXwFrhPyMaTPcXpH
 sNZ/Asiqb+zu/458ihTW0jGZ6LKX+61+NrhQpmxbMlsDFNBDu4o2EFWnNsvT2A5iO5hblXNTp
 KprzLZNipYbn0YjIk/gOvXn5CtN9QOdm4N3PYzpi8hZDHhl6S35I3R2Feo9EY5iAIRK2MiMsX
 aJlD8Dy5BZkVVNIppIRN7v62LFWafb3k0R2/QrU86o/cHHd8w0mQ5aiS3MXbatL2/PxGdhsbr
 IzZaypz7jeGwMWapgD7uQTZ7iT5XMufQm6VMcJCbWxoXfV3fXzrLBLvL2Ssra3U2BW5u/Rm08
 QeZFbAvt38860JRYimwa5egKj+8QFsoR2VJDsmU9QoWlfivTjC1WFVtVwKrgML8xYmv03dISh
 ENYptdZIsTMjfgYZv2erIP+LmdfkaBpvD0zhPFvNTSHEGP9tpr49tzeS7d1pDKvkpanz5D4ud
 pNHTwGSli8WGrnJ1QOSGl556OHEok1YWBzwIKueXV2L+sJqKl8YblC40QkHCAsnCvuXr72YqS
 QK2LdOIonByHW3/5KjHn1EREMXsWzDfxDa/qutf7836dI9hmg9pl9INWIV0SYyvSb3nratDyA
 i/VFhkovUyP1WFLPqGSP1pEHShcaq1VlsRkywG18YWnoKPjNYMcjPJacWMKtlBQAQmlypCy0z
 IZTo36ZsgnQ2BZzwhBtz7wcG5z0Hh4NQ6FGWXEBk22Ky+41+VcZqjE3A02inSIyNTjyUCFXdE
 KJvLvn7NPgffD0mm+LES42CsDAicjF5Fl7Ev+7xVJor4dBxi9neiOa14ygbp2lUNkGwUBkP3o
 YhUyteS4qJspzaPBkYyXK6J7D2YmIDWULu5W5LC7qQMdpMDJ5+CL3cJwiHf4LU7/DS7Okfhd+
 aWX9VjqJLrLacQ+1EjjpTJYoG5qmCCXxhGFqCtXo4nuxm3pU9jHhkQrGUcfeBqHV6xYcdTezm
 fpzXjgu503zxPNsp1SI5emQwd/8omuxCssPWIqBLFhdEetlpPv438qzwm+A4qRDGAvaqqsZOj
 fthBDSv+W9P3RIetHYDTEUk8BKaFopo5hZhJmiE65KQN8j9c+94jzGfU1/+8GqPYukbgIeFG0
 r6lPngzihAobMwM7Hlxpm0xEmbHGwL9+v+fl8eHBle7f9hMDsUzbAZHcoeN5EO+3quzcs2mro
 tsLUDfS+/SkQTtWOgeIS3qTKNYDc5gDuNQq8CTVCmdSYbC6y99QrbqNg=
Received-SPF: pass client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon,  8 Dec 2025 08:53:20 +0100 Thomas Huth <thuth@redhat.com> wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> Looks like the "$" has been forgotten here to get the contents of
> the FILENAME variable.
>
> Fixes: c49dda7254d ("iotests: Filter out ZFS in several tests")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/common.rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 10d83d8361b..c0f8f0f8dfa 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -1008,7 +1008,7 @@ _require_disk_usage()
>      else
>          FILENAME=3D"$TEST_IMG_FILE"
>      fi
> -    if [ -e "FILENAME" ]; then
> +    if [ -e "$FILENAME" ]; then
>          echo "unwilling to overwrite existing file"
>          exit 1
>      fi
> --=20
> 2.52.0

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks!

