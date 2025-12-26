Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B16E8FDA2
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 15:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ9Ny-0004y2-0U; Fri, 26 Dec 2025 10:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vZ9Nf-0004xD-CH
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 10:05:27 -0500
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vZ9Nb-00016f-2K
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 10:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1766761518; x=1767366318; i=laurent@vivier.eu;
 bh=XCXnTU/Dvb19r9bDphqLGy0IzauimpOeqGGiVbBKh7g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=EVm8LhzBlAakde24kZPJ9EjABGowuMKvpEXB67fDIpR977tDz+qhbg6C7KPX319J
 H55ixU3xhzBxVsBipIDzEx1CVu2TYV+8nKE0FYLxsWWh9oOY5+qVSr1gmTw+Ge4k2
 t8BMdzLkW/26OGoR9ZmBb4yif9vc4LPdsjIdnvDkPZnutNfKcRI+VaXeAnRDMOJDh
 s2pUzJtBy0uwahAcaqMEaWLMxGPZ4tMNfeHzipjhnHVNvARMkQskQsZJicTths+TD
 uQSVXqux6Ew1HBMaL0pljUMrdkcTj8lFuVZNgvOIrTEoNH50ml/xQTS4BsSIdU4cx
 o/5YmwGWeF+AklOgUw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MhWx1-1wCM9N14ZH-00dsz9; Fri, 26 Dec 2025 16:05:18 +0100
Message-ID: <c7803952-1929-4553-89af-7d9e79922434@vivier.eu>
Date: Fri, 26 Dec 2025 16:05:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: allow null `pathname` for statx()/fstatat()
To: =?UTF-8?Q?Jean-Christian_C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>, qemu-devel@nongnu.org
References: <20251225153932.1906919-1-jean.christian.cirstea@gmail.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20251225153932.1906919-1-jean.christian.cirstea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WwMNWDb7R1gDQt0TvIXLRrp9bzXWV7ZZZG1ilr4fxBbC7scF+cE
 V0N1qV5JmLxGHiqDx5/ftfiBtP9xeO4q2ZJBA0fdiKWFqH6oucSyKhG46qBf3jhtVacVDiL
 vLXAnzulMKCUZbfjZzMBezqw4qxmsk+qIXDAZjNjGVY1KnoIeFRxc83fpuac954cwI0NPY1
 n9CuqqQwABCDmcjAm67yQ==
UI-OutboundReport: notjunk:1;M01:P0:194c8O2BqKs=;5YP+i4CfjFiv/CbbOLOD8AITABa
 4P4y+FX2k1rgiUGq5kEQGG9OSsXE43vd2p0k4cRQW38MaOpLui71pXcQ0VVLcRE8m+nn3JpBS
 R2aCSxlCz/xLP1FgjCDuLlmqLW4sWB2NLbOLW1mcv3GUzTzjQze02a0lMUACjVzwdAnz/OfIf
 hqD3d7SifMXVIgnBacbP2rtKI2Wl7mByRoj6KpwmZ2Vkcsn+dpYPZcgrhOeW+iXSBhXPPWMOK
 fI/D34dsbDXgrp3eHoVrEoNUdMog9TklIK7iyH/zPW1Zg4LOG845gPrUt0VophtENdFJnz+Hs
 +2Q/KER9MNudlTTzCuGOsUU/DeVTFRMfM/ZhaQ5kXz+hRbqmKewDTb0VRiV6sHWkcDpA3zXHX
 sajE3gPNZEzhflITOVpbX6Wac+akLaevyD2XzNRvCL+hP7tuXX39yRXlZpgfrjftQImUPaMnO
 FU9XRRqrmJzEaF7qcB9qAxXzceFJJMua+BxMFapO6PyGw6iIOsb6MmoTlURyapDhM/7EjXMJX
 W2ksQj8WG1KoescgcY8+Y5BslWhYTJQAWSwAcBbzP+CNXIZGj3M5Be+n3x3JdyZVYW4Y91sVs
 CNZUjqnbolPC+Qjte9VBKXRM6P3DPamhcNbAIo2zVr+5lvdjYN1cZVr9LIX2dpEI9E/T+QxdA
 zofSgMG3//7hRPQjFp7Stt+SWYtlfCMacmvmEKzCzZWOWql59e/EgMfvVFn8Im4pOQbOa7waZ
 LWgE31bYQMxJQtGSZyo8Z/0Qbvlu4gePGtt7IOSMMRdDf3JQFHqdzA8Csu97EWabwAFJV7CYi
 JKGZzDeqb5zXjfSS25k5/OdFbAF/J9lDYLLjuy/mTSRUDWJbM5EJwIVrUmFOjnlGPT18YT9mP
 BIiT64s2MP5JQh29cTPYCPdUlDddOo1X6IScD2VVmccQmcACVAkFJPdOq/jVUQureLuADs8N/
 3PuuaLylSkClktKjGoB8XJXis/k/DMrAhPf4ojIUfv0QZGTVKlr4pB8CUXeXeEISUybHawEqk
 NCDbKFU+AYrpyyNlKRL0BbObc1YOjMelopfplNxiqKSl8i3CMFVW4Vwvb6oF9blz7P+ptvIIA
 BtwID8K/doWy2cq5nGmYS4VG0vjmuLNjpXS7Wp/7+fMEuUicynE/fxb9erS1eDvS9K/x9rZK/
 GL0PDZTpcJkqo8rO2ppBzYOeHGWY6vWQluiIkusu2HOPJnWPwCqYbxCUCO5ZAhjyD4vDWaf95
 IjYu4OLhwDZ4v16vURQmtb37OwA5RtNghOOEhoOUpKJdcGfEWaeOgymYuop7fIQoHpsnFVIzx
 24l3B00+ZnInbBZO0mldPozEbq2kBwfdEe2oJZLzW+PdQGcLBIeyOU7oE66/KjORWj1xfrfjS
 ZWoe3Rd1p0gnVXsbBwTaGGj6lE2sEmMHY+VZit8VdrSTCpIv2XgF8TPNC5pBb1sR90EqSICcf
 sPWw6kgMKriuyLtk5y9lSfMePoHLZhDs+dOwAxaIcHfZc2P9hQKsR8qMJdNsshs/0lVOYfj+p
 TtM3jtleDeRqoZlfewMA0UNK2Mn0A8IcAs0qJc9tMYbGmd0LsjjSfLfr4jST/98i1NXcL92IL
 2oFGo9gTHEYsvNxzAeZ5nQI2uaT3HqaHVmFfKW+aUvNoNttqDeBAmQNcQS1IKhQ9E4zUZvbpy
 JaXYR0Ju9piEkb91oFQ76LAtGvd+DLeJzJjAsV444Ohnsmh8CU63ACC/KAWMloRv3+2KmDfbH
 fWzPBG6dQQV+dnNrmAMCinU3qSz80LcIkCIAoioWjG1Qoq8w8yJ/PMGw=
Received-SPF: pass client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Le 25/12/2025 =C3=A0 16:39, Jean-Christian C=C3=8ERSTEA a =C3=A9crit=C2=A0=
:
> Since Linux 6.11, statx() and fstatat() syscalls accept a null `pathname=
`.
>=20
> Before this patch, qemu-*-linux-user failed with EFAULT when `pathname` =
was
> specified as NULL, even for Linux kernel hosts > 6.10. This patch fixes =
this
> issue by checking whether `arg2` is 0. If so, don't return EFAULT, but i=
nstead
> perform the appropiate syscall and let the host's kernel handle null `pa=
thname`.
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

