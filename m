Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59231C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzWGt-0006Qc-Qv; Thu, 27 Aug 2026 05:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wzWGs-0006QK-8N
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:19:42 -0400
Received: from ci-2004k-snip6-2.eps.apple.com ([2a01:b747:3005:204::69]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wzWGq-0006mQ-Cc
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:19:42 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-10 (Postfix) with ESMTPS id
 35B9518001B5; Thu, 27 Aug 2026 09:19:34 +0000 (UTC)
X-ICL-RepId: 01a04284-8097-78c6-a7ac-3d2f8a758246
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDjIOOwEsdigCXQhIBS8aX3M1C1VyWw9TH0B6TABedVMARng+ci1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1787822377; x=1790414377;
 bh=s674QyVjykg0dTS93sHYgtmBGVy1ShykZfbXJzlc5tQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Bu+6fLXv2UYEgZ9848rSvFGSUtv3zKGH6lpA56PqCverCYTR0nVxb81DQ/YpkuLnYxZozUPZa631BDZ0hluMtF02qrWnRGymuXZIFINWW4NddvGhGUDBEjkiLLpweG0gB/9LqMqbyKYCkYGa5qxtLytjRX/o6J8vkf53g3h1ib3xr0LuiuwDjS/7OBjJv2W0YHWrJzHlbzf2KUUiaBFuE1EGnrlMwgp84x4H3836JMbMZqgccGm68z20P9NezrNOBB0uSPrWjkTkHp96u0P6/8KNhkLz+JwHDGnCu4/Pu+oFmj6+GLGufqOeRRME9VDbeB9vM/3bvmZXOwM2ew0DXQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-10 (Postfix) with ESMTPSA id
 9688A1800127; Thu, 27 Aug 2026 09:19:33 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH] Update to a cleaner build path on macOS 27.
 ParavirtualizationGraphics.framework API has changed significantly.
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260826203700.39057-1-dude@angrygoose.dev>
Date: Thu, 27 Aug 2026 11:19:21 +0200
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, philmd@mailo.com, pierrick.bouvier@oss.qualcomm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7C2AAC0-106B-4AE2-A688-0C433B826AFA@unpredictable.fr>
References: <20260826203700.39057-1-dude@angrygoose.dev>
To: DB Holder <dude@angrygoose.dev>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Authority-Info-Out: v=2.4 cv=Ft8IPmrq c=1 sm=1 tr=0 ts=6a900127
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Eu1XywiOcv-WUTJC:21 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Y4BSF4L1CW0vQ5KvyfYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: r-HmzCq2raBRov7T_nsP6rp3F4ddw_VP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3NyBTYWx0ZWRfX5UG1WkNYjm/1
 lW8YF9sIwU7M/sxi5YvlmIUX40SHY3DswrnCeDPtFiEeUtGBnTlGUWP8AEYLC8tyV+18Hu6imb3
 6Kk1jQFxUS/cDXh4zmYD0DEuguj2mE7Ry3ihTNBvII/1sxLraSTn7hbfv3IXM0ka8izGrMzD4zD
 CsS/Wo92ig20q4XT3h61mvypkbmlfBxGwhnC++7zcAGrugkBeoOG73OnO7aUBhnzVc+rHpkmqXj
 4FItoL3VKfO735Ps1ai/tF3jAoqhjjosSeI8Pu+7OwGAnQisw0NtRE7iNoE5a39XWCSR+t9vpvW
 QRNL9iF0WHjDOsXGsCrylo6XeSFOy54ZV600n78XPN5/gySuw0A2/IYn2KtlgU=
X-Proofpoint-GUID: r-HmzCq2raBRov7T_nsP6rp3F4ddw_VP
X-JNJ: AAAAAAABBqJELNeldeQACbBgqgQABpTxiglKCT5NTJfBOi0VVYnW5jvLLeoHrvFZ9/Okk87Kd5XUcoRsBpDJDVR9DH12kfoPAcTcaVe7TU8LejWbtybyUzXWUERqaMnrFQPAbkDDSnKfYMDgOltZ3T5g8ApzT7vI7WEyEEiepxdQLTXsmmwVDAcMG1YTdlazmtHnBqzAr8qn/+CvCmJZLLCv1CvEa6st/aX2j515bgktHUul3+/eyLiNyam3k5EdJa1v79DJpvnVwYrV9z+e1VmYdnBYy+DaZrRVPlL+gwkkSh3S7j6SBXcEPnGlWNIgkBMxs7O2BRD8IIG6xzpAdeMSCS4t4uJ93kfX+jWZCwZEI67WCcI8W+WCV6tlX0QUXwiWaG+j+WmxjHJx6wbOTCguWHJUv9Cnl94Ydw9AuCGxxY/tQHfd9AD5pqlDwEdKVVHZBKRpX5njjMMW9D/DwrkK4U2TUqoG3ijWFwktYvLKB8+QulnO+M7X1rSP4cS/69LnhyevGDK1iRsEkUn1DO9SUacKuVGxfyafIrm3TcEvTiZOZGzG0gK3lINoQ9eYA8y5QJJxloX3CaTY7pVKS3Jb9+KMlZrH1lneg/8ZSRr20aKdmmiPAmKdDzRgPS3D/wi7ayqH75ZRnrsGQApFTw7W+ssdVubZQg1slpDlUvgFLDPySfto7GQzEz3HdTxtisvYUhnrP45byfueXKayjvYPqvEMTjC+uKCc4AwfA/YyvBRbA9lqC7vdXa371zJHjxBg/d1cTaJAn6L5YD86BuwLiGnJtdELtILLHVEn4foAgExyx38Zh3ZuCh3hEywXekJp3h7G9Hwp6TF5Io8AKctZp75PvVcdYhXX2699Cr/iyd+YYrsPQxxjQF4sXHAqbzkKbj/ffaB7VF9mMYN+pLU24NCqAbv4PS7wtbiPjHqpHJaXURQJjYgNmbrD4PuOMECchUTBg8APKLqju5l4KSXypoquXCF
 LZ9UcchO3mgvyzbX4pWi2+1sssWuVDliJsV3WzGPzPLvdJKFCqer+vzdkQeKSOgtXkPl54bh27sjpSy+aRaxE4Ns9Q2RxmduOaEXJvfVFEZ/cIPd8b2/nTbVGlacGZxXFJvSDeOhASieOLVC+JMSHTX7k1W9N3vV+ku69AbnhLWO1UxZiWC/nYx3EnTGRm992LyWZM/92JSiuMfdfMJRvnkowrT1qArx4ezpApd/xlzj3OJqIltWtgZ+TA2fjgm4H8RtEJHAuiuqh9/XbFCGmzNQPQVOmuSmZ9ybRcXyj76xw6D/RZV+Rmouq+TAxtgZLM2qC6qO/Y2Om9vsszko/zSceMYlYWSsCKh1wiM3TNCvGRlm3X696hUrp0J4OLCDFaA39FtBexoMXjCnrWoCf/tCtvrbk5QwXGWGDqvugCSRX46NUIZWG+KmgqZPh6gic+6Z0EM0lCBGPbCHxFCv9KtE5G/Q7Q10LT8RyVag9U83kWVBhmXnGFMvNbjw4iGVFM6YUM4NBCu/KW3Q5Ds5//Cv6mLbvgHNFMub38QBtWvs=
Received-SPF: pass client-ip=2a01:b747:3005:204::69;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 26. Aug 2026, at 22:37, DB Holder <dude@angrygoose.dev> wrote:
>=20
>=20
> API marked obsolete in xcrun --show-sdk-path + =
/System/Library/Frameworks/ParavirtualizedGraphics.framework/Headers/PGDev=
ice.h
>=20
> Signed-off-by: DB Holder <dude@angrygoose.dev>
> ---
> meson.build | 8 ++++++++
> 1 file changed, 8 insertions(+)
>=20
> diff --git a/meson.build b/meson.build
> index 6dcfdceb50..a6b11cb009 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -852,6 +852,14 @@ elif host_os =3D=3D 'darwin'
>   host_dsosuf =3D '.dylib'
>   pvg =3D dependency('appleframeworks', modules: =
['ParavirtualizedGraphics', 'Metal'],
>                    required: get_option('pvg'))
> +  if pvg.found() and not objc.has_type('PGTask_t',
> +                          prefix: '#import =
<ParavirtualizedGraphics/ParavirtualizedGraphics.h>',
> +                          dependencies: pvg)
> +    if get_option('pvg').enabled()
> +      error('ParavirtualizedGraphics framework found, but the API =
lacks PGTask_t')
> +    endif
> +    pvg =3D not_found
> +  endif

Hi,

There's a newer path (RFC already sent since a while) that works on =
macOS 27.
The older path already had the IOSurface mapper side gone since macOS =
15.4 so this
is not exactly new. It=E2=80=99s just marked as deprecated now since =
x86_64 macOS support is
formally gone.


> elif host_os =3D=3D 'sunos'
>   socket =3D [cc.find_library('socket'),
>             cc.find_library('nsl'),
> --=20
> 2.54.0 (Apple Git-157)
>=20
>=20
>=20
>=20


