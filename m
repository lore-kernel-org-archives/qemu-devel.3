Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A84BD715D1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 08:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjZ2p-0007Fh-Of; Sat, 24 Jan 2026 03:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vjZ2Q-0007C6-Dj
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 03:30:35 -0500
Received: from qs-2002a-snip4-11.eps.apple.com ([57.103.87.141]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vjZ2M-0007Kr-D1
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 03:30:34 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-2 (Postfix) with ESMTPS id
 7B2CD1800132; Sat, 24 Jan 2026 08:30:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769243425; x=1771835425;
 bh=RU3EschEw2y05CQxvlizLjQlXjdny1kHlbgcsZ+U/7M=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=ZjBfTy/K1UJ4ZZBa+3gZqdhfCOR9X4CEJY1XSug0reTPfBWo6FfGhmzNfmEzvie9D5RNGzCKgz+EpmihavH0dNhBKemK4cdmiEI725W7hlBauolULEWPY/fJmmRbpiLQY2M+gpwnr8dsSqaL8/STnp7UJVeljgJeIGvbzKO9UXGZJ/ajERqOhs/GnWfOGdJE/NxR/Au5qKq5ZMZkSka3T2vhFwiAC4/8zrXNiPHb08/1r9oXEayoIvQbXMc9vJNyBorAxg0Z0oshLyyyxKXhxnu8DeSYeNWTXTlADSDp6vOwXRLMW5reqDUOVmWvmVoDRqFTMkQ9jFjbWbKltTwrLg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-2 (Postfix) with ESMTPSA id
 565931800135; Sat, 24 Jan 2026 08:30:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <98527CD8-C7D2-4FEA-A712-97D883DEA813@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_66A135F8-13F5-4619-8FC8-25579CDEA637"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] hw/net/rtl8139: Fix integer overflow in
 rtl8139_write_buffer
Date: Sat, 24 Jan 2026 09:30:10 +0100
In-Reply-To: <20260124033346.BB51747D39A@orions-MacBook-Air.local>
Cc: qemu-devel@nongnu.org
To: orionhubble@163.com
References: <20260124033346.BB51747D39A@orions-MacBook-Air.local>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDA2NiBTYWx0ZWRfX5qea30fDVmFQ
 HZmE+8lMsXXaR8wyZmwcXmE6Bw1B7MQfxhLbDTmd19xZV58ho24RKaudOX8Ia+PDG6KXQ3emmPe
 lF4R41NqE4BJC9e0zbm5SQwzaP6jvEYoEQhaSJatFSbjBsi2qkA+BKRL2ayLIQ1pGK6aQ5VNjkL
 Kb0eZ7guGj57V3tLLPpny8yWraks4Josp+ISpPgByuCSXh4Mb2J9VDRTUvNEHONNnXqMhPHTwVb
 aA1m1Q6SnzghCd184YKSd/pTNSVX8BNmSyou3KFMFeRT7UCZI37Hn/ZbixSPh0rioAoOs/mrpis
 dmSQeFeP0CrFXZV+Ynd
X-Authority-Info-Out: v=2.4 cv=V+twEOni c=1 sm=1 tr=0 ts=6974831f
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ID6ng7r3AAAA:8 a=Byx-y9mGAAAA:8 a=qVTLh8Hsynezn_weCSYA:9 a=QEXdDO2ut3YA:10
 a=nSfbbpwR4aUA:10 a=-DIfVzMjGzgA:10 a=htsAsoZ8843lw72gLSkA:9
 a=Uem1gYLYoksxKCZt:21 a=_W_S_7VecoQA:10 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-ORIG-GUID: hIQkZc8w56CxA_kG_RxfMsvf-emZL9C-
X-Proofpoint-GUID: hIQkZc8w56CxA_kG_RxfMsvf-emZL9C-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-24_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 clxscore=1030 adultscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601240066
X-JNJ: AAAAAAABjVrqHQhmtRcxDBl9DI983VyFSEBtLwQDqu4HV2VvYHGKMGJIiXv8IELJr9lQcuNtM2kntVubjZGuuOcQYhgF+9oiWAJRlH4LIKAYS0t8cHXQE5lyjueOBpbugMBDKvmRxYsJ6EnePQ/Vxu7euKwDDAHhfHTYXE+1nX3PSeNyPx0ilQdzna6P8qiVJ19Q5gQR65wWqStdZG4mAzywzDQUpxd7TAlwzB4zHy9wSdrvyljCuanFD65Tb+MzG92AQZZUdASngRO7Jl3AQNa4gb9qO5yg8XgaFM5oZm0Tq2PBjRjoDUV6jb7LjCT4/J8xULSN+UVOAZ2Tt1Y6xWf8h/sC5g5gnD5cY/ztT5mhf/4Zx5vRP+xDD0ArluIt2NiwYujzm0NUKQ7EIcXbY1O0rk2rHMIYfs/7o+2ksdtWfr/Ku1yHv9wFKRakCW9OG2fTV4rsBb1yoIQMilWPjhHH1VJ0gYLFxq9LM1ffq7P3s5rGJ7jmywU1wzR8/80MTS1AxqDm7DMq28WF98rM9Si4BgnrnEpLrDssbaHniM91qgLStK/2OCcEEMHKkVpTtYLIRvSkzIZj7oIPCzA6dHzy1R5rH86Cz+a+dYg1Rn6Ekar1DH7bmwX85XVAmqCdH6MRbBuFoMnlM3AiwaltcXK9NB49iijl
Received-SPF: pass client-ip=57.103.87.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--Apple-Mail=_66A135F8-13F5-4619-8FC8-25579CDEA637
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 24. Jan 2026, at 04:33, orion cai <orion@orions-MacBook-Air.local> =
wrote:
>=20
> =46rom d1781652dc7039b2ac92fa80695091b97dbf1918 Mon Sep 17 00:00:00 =
2001
> From: orion cai <orion@orions-MacBook-Air.local>
> Date: Sat, 24 Jan 2026 11:19:17 +0800
> Subject: [PATCH] hw/net/rtl8139: Fix integer overflow in =
rtl8139_write_buffer
>=20
> Fix integer overflow vulnerability in rtl8139_write_buffer() that =
could allow
> a malicious guest to bypass DMA bounds checks and write to arbitrary =
memory
> locations.
>=20
> The vulnerability occurs when:
> - RxBufAddr is near UINT_MAX (e.g., 0xFFFF0000)
> - size is a moderate value (e.g., 0x20000)
> - The addition RxBufAddr + size overflows and wraps to a small value
> - This bypasses the bounds check (s->RxBufAddr + size > =
s->RxBufferSize)
>=20
> Fix uses subtraction instead of addition for the bounds check and =
applies
> modulo to each term individually before computing the wrapped position =
to
> prevent overflow in all code paths.
>=20
> Signed-off-by: orionhubble@163.com

Hi,

Your Git client is misconfigured and didn=E2=80=99t send with a proper =
email address.

And your Signed-off-by isn=E2=80=99t in the proper format, see =
https://www.qemu.org/docs/master/devel/code-provenance.html

Thank you,
-Mohamed
> ---
> hw/net/rtl8139.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 9fd00574d2..41b8407acc 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -745,9 +745,16 @@ static void rtl8139_write_buffer(RTL8139State *s, =
const void *buf, int size)
> {
>     PCIDevice *d =3D PCI_DEVICE(s);
>=20
> -    if (s->RxBufAddr + size > s->RxBufferSize)
> +    if (size < 0 || s->RxBufAddr > s->RxBufferSize - (uint32_t)size)
>     {
> -        int wrapped =3D MOD2(s->RxBufAddr + size, s->RxBufferSize);
> +        /* Calculate wrapped position safely without overflow.
> +         * Use modulo on each term to prevent overflow.
> +         * RxBufferSize is always a power of 2, so MOD2 is safe. */
> +        int wrapped =3D MOD2((uint32_t)s->RxBufAddr, s->RxBufferSize) =
+
> +                    MOD2((uint32_t)size, s->RxBufferSize);
> +        if (wrapped >=3D s->RxBufferSize) {
> +            wrapped -=3D s->RxBufferSize;
> +        }
>=20
>         /* write packet data */
>         if (wrapped && !(s->RxBufferSize < 65536 && =
rtl8139_RxWrap(s)))
> --=20
> 2.50.1 (Apple Git-155)
>=20
>=20


--Apple-Mail=_66A135F8-13F5-4619-8FC8-25579CDEA637
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 24. Jan 2026, at 04:33, orion cai =
&lt;orion@orions-MacBook-Air.local&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>=46rom =
d1781652dc7039b2ac92fa80695091b97dbf1918 Mon Sep 17 00:00:00 =
2001<br>From: orion cai &lt;orion@orions-MacBook-Air.local&gt;<br>Date: =
Sat, 24 Jan 2026 11:19:17 +0800<br>Subject: [PATCH] hw/net/rtl8139: Fix =
integer overflow in rtl8139_write_buffer<br><br>Fix integer overflow =
vulnerability in rtl8139_write_buffer() that could allow<br>a malicious =
guest to bypass DMA bounds checks and write to arbitrary =
memory<br>locations.<br><br>The vulnerability occurs when:<br>- =
RxBufAddr is near UINT_MAX (e.g., 0xFFFF0000)<br>- size is a moderate =
value (e.g., 0x20000)<br>- The addition RxBufAddr + size overflows and =
wraps to a small value<br>- This bypasses the bounds check =
(s-&gt;RxBufAddr + size &gt; s-&gt;RxBufferSize)<br><br>Fix uses =
subtraction instead of addition for the bounds check and =
applies<br>modulo to each term individually before computing the wrapped =
position to<br>prevent overflow in all code paths.<br><br>Signed-off-by: =
orionhubble@163.com<br></div></div></blockquote><div><br></div>Hi,</div><d=
iv><br></div><div>Your Git client is misconfigured and didn=E2=80=99t =
send with a proper email address.</div><div><br></div><div>And your =
Signed-off-by isn=E2=80=99t in the proper format, see&nbsp;<a =
href=3D"https://www.qemu.org/docs/master/devel/code-provenance.html">https=
://www.qemu.org/docs/master/devel/code-provenance.html</a></div><div><br><=
/div><div>Thank you,</div><div>-Mohamed<br><blockquote =
type=3D"cite"><div><div>---<br> hw/net/rtl8139.c | 11 +++++++++--<br> 1 =
file changed, 9 insertions(+), 2 deletions(-)<br><br>diff --git =
a/hw/net/rtl8139.c b/hw/net/rtl8139.c<br>index 9fd00574d2..41b8407acc =
100644<br>--- a/hw/net/rtl8139.c<br>+++ b/hw/net/rtl8139.c<br>@@ -745,9 =
+745,16 @@ static void rtl8139_write_buffer(RTL8139State *s, const void =
*buf, int size)<br> {<br> &nbsp;&nbsp;&nbsp;&nbsp;PCIDevice *d =3D =
PCI_DEVICE(s);<br><br>- &nbsp;&nbsp;&nbsp;if (s-&gt;RxBufAddr + size =
&gt; s-&gt;RxBufferSize)<br>+ &nbsp;&nbsp;&nbsp;if (size &lt; 0 || =
s-&gt;RxBufAddr &gt; s-&gt;RxBufferSize - (uint32_t)size)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;{<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int wrapped =3D =
MOD2(s-&gt;RxBufAddr + size, s-&gt;RxBufferSize);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Calculate wrapped position =
safely without overflow.<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* Use modulo on each =
term to prevent overflow.<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* RxBufferSize is always =
a power of 2, so MOD2 is safe. */<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int wrapped =3D =
MOD2((uint32_t)s-&gt;RxBufAddr, s-&gt;RxBufferSize) +<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MOD2((uint32_t)size, =
s-&gt;RxBufferSize);<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(wrapped &gt;=3D s-&gt;RxBufferSize) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;wrapped =
-=3D s-&gt;RxBufferSize;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* write packet data =
*/<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (wrapped =
&amp;&amp; !(s-&gt;RxBufferSize &lt; 65536 &amp;&amp; =
rtl8139_RxWrap(s)))<br>-- <br>2.50.1 (Apple =
Git-155)<br><br><br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_66A135F8-13F5-4619-8FC8-25579CDEA637--

