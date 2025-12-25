Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A607BE7AD45
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 10:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYitE-00081A-4R; Thu, 25 Dec 2025 05:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vYitD-00080x-5A
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 05:48:15 -0500
Received: from mout.kundenserver.de ([212.227.126.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vYitB-00082j-9j
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 05:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1766659689; x=1767264489; i=laurent@vivier.eu;
 bh=X6oDH0+I8x0l2Kz52vuijDR11tVUUPDTM3WDUjcFS70=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ccfi80DVIGlICmbBI9ZABoLR6mbAP8ALBmPSTTV5ATTO/itdPkcVVQUiRD4XrzpN
 i5V9tZss5/miMd1+r4kvXi1ioQb07ahUiXeiImERSb4Jb2jm3M+aqxOdoVxzO27W9
 HFE4w0koqDPURzcaH8773MFJ0AwU7t+bybRwmlih79NmxHYTk2FF9yYesnZMTprH7
 jMrX2kzmimksFdVPqdp8BkeBKgRb39afVcPr9SZXSk8x92+ALGh6WFyXdrJXwLn9P
 z2r1yd+jegOjAkzmiHqfY/rVzq1147py4/ZDds9aHV8EBB6Mu3JM/2sQsbuLS0Ak3
 lp/xMRfcITNGODT+Dw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MxmBi-1vsABb2Jhu-0147Xf; Thu, 25 Dec 2025 11:48:09 +0100
Message-ID: <6891a229-4c12-40a4-9ca7-0b41e3f438f5@vivier.eu>
Date: Thu, 25 Dec 2025 11:48:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] linux-user: allow null `pathname` for
 statx()/fstatat()
To: =?UTF-8?Q?Jean-Christian_C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>, qemu-devel@nongnu.org
References: <20251223172548.1847032-1-jean.christian.cirstea@gmail.com>
 <20251223172548.1847032-2-jean.christian.cirstea@gmail.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20251223172548.1847032-2-jean.christian.cirstea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KoBln+acBJfJchAclbyuA2nXWAI1WMIvOHMdwwPyGC9/4xtI4B6
 5keJivNVxc++YujwK97g66g4ZY7X58Dpi1Yaia2Aod8U5aYObDChiKRdW8T/fUszPuicGWL
 Uxs0T22ICpIekdmZg1Mnn2bixqgP33VRp3txxjgLNOxDRbvNGyPxK7RjZmSToa/aI6Or8vS
 BjC8Yuw14HUoYTiUYe9/Q==
UI-OutboundReport: notjunk:1;M01:P0:5RqNjDxOE1U=;Qy+zbKlBpZ6PJReoInqCIx7U98z
 CZ4g5cbE6toCOJCvYkpcdnt5hcg4iWk+gjNHhTmfzCQZWSHA/mmdhHx+ko1MKOMPN6ZeMjp8b
 7B+VrDodLG1+eTySI2OnS36dKsiIIp51tfh5D6HtqHYg8nthz+K8CrQNcc1cP7CNm5fk5QODF
 hcNEav3nnJVyJm5qNUszBzjCEHeqflmtZeguhsQX6+Hr9M4RcG1HXQFjGzlkTK4Ykgmytv3wN
 TBd7O2ZFwZ4bssL2iOoi+n2t2V6lfc8EpNSJPn7RigpPgwkvdVuPQ0N6N/eE0yVad2pc0BcCT
 yNrVBdNIuv2NVN1gudbrSScB9cMU6zdA/PN6PWvtttONukspIa5ZBzumKCTqDDplyUqbLm3EV
 kqQAJ2kGVDmWgaFByAxZ/0ygVTLwMzXP0lCa1qmJZL+r958mkGiP2QiIvcXefPtyd589PXs+7
 typbCxtfZQKAJcYqRGnHdGTi2/a+20UrZI4gKALgyT3kSZ/feoqAazJhwpUoEr7KTawbswVEN
 Y4/oefpo3iFtnxD+LHtFn2VpgYk0Abn2ZJO8jzpsJ6HMPjU/69V9TI6/voK+h/AqkuSNO7jjn
 Z+GMGiKU0rk4qxJYmDjFN58b8jplZ/RcdxijCUs0uqvKwjSpWZlGladicQI69NG2n8hCMCQQF
 quk+Vdlw2tEMUhu9xcz6vk/E9ly7/KT7jGxHzW3glhS3QFif+Wdp71RPp2husZ7qz56IkBYCm
 VvkcG6YZyXIBdRPesZVrhdkJ5R/5nPfv/2CIMYLkOuT/+S2wR4j9yESC9LL/s4VR/9QeOrn62
 5DAZxctOMMBEilOaB8NH3EI/NzwA3Mr0OH675xo1k42kX7aHnVCNeJW4YFc+PMrzgQ21gEpkK
 VUpNTVFrUHJ+k/M9eXGiY92Y+L5F3+YLJttG9IseDHHcajt1WVMMGLu5ZprDgbKVYWbFpGCFu
 ps2PUDUMbkPUl7TWdHbeVdXpOOB0OTIyCs6We8hoNlvLKBGxOrP+t6CCtQgOB/odl8869ltY6
 hv/JIaD04v2QpnJQ0WvBZaoJ3S5msdTXOwQaOplefVHKdZBJjJuJ1naRnNFUHRMJURfO8hvvx
 NUEZBTx/b+9fRnEz9/e8hB2Igdr2896Z//vfs3QGbmZyv+oAxw6KyHFbYWTNjZ7AVWww5Qp9V
 LpdQKax/UC3uYXfR5FihLi9W2KaT38OF+BLKhJJZ5zZlA8CARczgfJ0cT+VUVxPl4Px7ZCtMu
 KVnZ6ZNRqrAdmPy1PKBZEOfgxETsDTsqAYyL8ntAXS79PDX3JkPVFDE7ePqzp/dWoVBzUtyxn
 0i9hvcVKDzjxXjRCRDclkeQkwIal2NRQ5uylZbFN3Zw5G3Icnsr6rAac8VRbrpfh/2SPtcvtt
 SzjeuXAXhXa+QeJUEHBWi0yoszJHCepKZLgZ/yRhRd9+7M2MKRdKODRFp/HZB+dNoZj64h/X2
 TYhuxYeLxgukiAChDL8BWwzntvx1xZnBy7yt8ZFx9KsgEX3qUZ7uVO2rLO0WF7zNeUeOrDG5P
 2fHmvWZlfqnjPWYefbCmsz4V14o2Lcs2bM0csGmrAS6OfAnFnS9ZzCXkRq3H0mABqRgIc+Mqb
 vDQouX+9x96wzSo50IG64Xb7kg7I3WylhCCPnxvdY8p/R19iKqVZg76+nxyvv98yhc8WauErM
 bFyjOw5nreLqn83ZPOnpGVuW4XWVwzbTVcHNGtoIJWUBOy9/XP/JJLj/9WfZPHwLR7DzzeZFg
 8LOdnzd1r1XLfnk+9L1GugsmnKGBdNam73QBwdi8zSL3Qq8c1dOdoyBvJoqQ0XkHYHUj3A9Of
 azI5
Received-SPF: pass client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Le 23/12/2025 =C3=A0 18:25, Jean-Christian C=C3=8ERSTEA a =C3=A9crit=C2=A0=
:
> Since Linux 6.11, the path argument may be NULL.

Put there the message from the cover letter. You don't need a cover letter=
 with a 1 patch series and=20
the cover letter doesn't appear in the log.yes

>=20
> Signed-off-by: Jean-Christian C=C3=8ERSTEA <jean.christian.cirstea@gmail=
.com>
> ---
>   linux-user/syscall.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 2060e561a2..e1b61f6dc5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12142,7 +12142,8 @@ static abi_long do_syscall1(CPUArchState *cpu_en=
v, int num, abi_long arg1,
>               int flags =3D arg3;
>  =20
>               p =3D lock_user_string(arg2);
> -            if (p =3D=3D NULL) {
> +            /* Since Linux 6.11, the path argument may be NULL */
> +            if (arg2 !=3D 0 && p =3D=3D NULL) {
>                   return -TARGET_EFAULT;
>               }
>   #if defined(__NR_statx)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



