Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B226DE9B24E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqpx-0006pU-9n; Tue, 24 Feb 2026 06:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuqpl-0006oX-H3
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:44:11 -0500
Received: from ci-2006k-snip4-10.eps.apple.com ([57.103.90.240]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuqpf-00088c-Kx
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:44:06 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-5 (Postfix) with ESMTPS id
 DDAE31801C85; Tue, 24 Feb 2026 11:43:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771933433; x=1774525433;
 bh=I74WFe0a39el0W7exC7sc0DsqzHSb9eS8/6udEF99dw=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Y349pDvh7cjT+CMSxpPOIA7FHiLW6rYJw+jYjlWJtDUchFdnW4A5hXKxreWZUfuuMk+ZaGHTRxGxkUqVaPUrW9yx1k4fTCKmnYmn6qDbYln6Y/Ri0tDg7SLsKzBVhLoNKp+oSEyQ9iPZFxkHyf1CFhytmJY2HQjiwvaFKXBhGXzk4n71UW2nlAbgIPIjCzi/2mD8V91Lcsn1ol98osRFQtNKd3ZboLVy44ko7XZkuLbhjXIHemZ+OoFVrDeGLL26tCGzHvXWCzOwDTholLf0Lp+Rszqq4zoSsat59OZPjo6p8Ins+V0+SKjutm6XCtvJ9GF3a6sG1giLDdxrHHfyvw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-5 (Postfix) with ESMTPSA id
 D37C51801CA0; Tue, 24 Feb 2026 11:43:50 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] hw/char/pl011: Only log "data written to disabled UART"
 once
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260210101702.3980804-1-peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 12:43:39 +0100
Cc: qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A61BF954-CA4F-4AEC-ADE4-8A0F3D9DD9A3@unpredictable.fr>
References: <20260210101702.3980804-1-peter.maydell@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-ORIG-GUID: 9RxqdpJv9YPHBnp2XZ2ZzXDUyuFemZth
X-Authority-Info-Out: v=2.4 cv=PtGergM3 c=1 sm=1 tr=0 ts=699d8ef8
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=Lh8VGjV_zy5MGINQgmkA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 9RxqdpJv9YPHBnp2XZ2ZzXDUyuFemZth
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA5NCBTYWx0ZWRfX3zPFc5BqSXl0
 FlchBAoFOpCJDCrmqGcbK7OGDcSPhDIzFrRCK4gVRrm5HJupge+rY8dUygoe3iz8iBAxWTaMHyq
 FR/8vO+1zas0vzXIxSGJBkZ/zjSMRBNclFoTKOOjwhT2RFpPeWKJESxHEmMl8m6aal8eo5QqaXd
 vQlzQL57a5JznfFXhh3rSKn0M/kel4A3FuCu860/soCWa3QBUllzdEpgSebcDwCUeX2SeoAL7sL
 n42W3mEIHM9BdCXjbYn+cvVqbWNZysuOkGqryo2pq43VGqv+DWhABG3IulAmBJvDlFWWj0YP5ey
 9yWZJfAtWdX2anb+MLpJpFLz3AjYbd0qCddTVQDxu2RO1YzB88HJSdxy/6FkF0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1030 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602240094
X-JNJ: AAAAAAABUCtXGRrC8XavP1wG15kqVWbhoJ+deO6jaEZFlX7Zzy67Q319wTb2JQBAMqpNaEqVMqISHhSxpl/m56Tb8Uw3qY64qHCvRbj/eO7CDI2C5TZOzO0D9q53/KfMxVGpzv9BXRjbX1xJOyd5s8yGk8Pai78jL+FEoeWmfjw8KDoRJLebq7WJfR2WrwHlTOSGyux8Tw21pQnq+O08L4gLVn7BkAjl06ctwcvy0XZtenpinupEHlfSaJT0MCJh5wyRDGv7NIsHghnt1hl3/lM6o4zLxDjarWfDnig6JlcmPFS5Ngzcj7dA0TcPrw7yPv7OnwSB2k47/0CvvGM+EosAKDyRDNq0Wuz+GlxcLHXqlc6vL+5z9wNVvPKXU4p83VtFMJWERPLr0T6JsBaoTEyMcvRRtIEuKM7d7aTfT/dYn9MuhQ3uQMlcZBX7qgu2Cj9EO2Xx0WIfAfVtS30O5UetFp/CU2lTxfO0kNs+k/gxxwUUWD4AyTaarHlq/Gt1jm6Z838pnFmE9oZ0qUvQx25LeWPy44vU1+CAgjWF4zJxppPrzoe3cjbkxCPmKxy7syxXYFeDRtFT5+sPsveTONS1/VueDVrcG1uFDc840i6e72cHbmY=
Received-SPF: pass client-ip=57.103.90.240;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 10. Feb 2026, at 11:17, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> We log a GUEST_ERROR message "PL011 data written to disabled UART" if
> the guest writes data to the TX FIFO when it has not set the enable
> bit in the UART.  The idea is to note that the guest has done
> something dubious but let it work anyway.  However, since we print
> this message for every output character, it floods the logs when
> running a guest that does this.
>=20
> Keep a note of whether we've printed the log message or not, so we
> only output it once.  If the guest actively disables the UART, we
> re-arm the log message.
>=20
> Notably, the Linux kernel does not bother to enable the UART if it is
> used for earlycon, relying on the firmware having already done that.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> The log messages here were getting in my way trying to debug something
> else, but I didn't want to just delete them completely.
>=20
> hw/char/pl011.c         | 24 ++++++++++++++++++++++--
> include/hw/char/pl011.h |  1 +
> 2 files changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index b2ca68e3e8..cb12c3e224 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -227,10 +227,25 @@ static void pl011_loopback_tx(PL011State *s, =
uint32_t value)
> static void pl011_write_txdata(PL011State *s, uint8_t data)
> {
>     if (!(s->cr & CR_UARTEN)) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "PL011 data written to disabled UART\n");
> +        /*
> +         * Only log this message once, not every time the guest =
outputs:
> +         * otherwise we would flood the logs with this message, =
making
> +         * harder to debug guests. (Some very popular guests like =
Linux
> +         * don't actively enable the UART.)
> +         */
> +        if (!s->logged_disabled_uart) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "PL011 data written to disabled UART\n");
> +            s->logged_disabled_uart =3D true;
> +        }
>     }
>     if (!(s->cr & CR_TXE)) {
> +        /*
> +         * We don't bother with the only-log-once machinery for this =
check
> +         * because TXE is enabled by default from PL011 reset, so =
there
> +         * isn't likely to be existing in-the-wild guest code that =
trips
> +         * over this one.
> +         */
>         qemu_log_mask(LOG_GUEST_ERROR,
>                       "PL011 data written to disabled TX UART\n");
>     }
> @@ -457,6 +472,10 @@ static void pl011_write(void *opaque, hwaddr =
offset,
>         break;
>     case 12: /* UARTCR */
>         /* ??? Need to implement the enable bit.  */
> +        if ((s->cr ^ value) & CR_UARTEN) {
> +            /* Re-arm the log warning when the guest toggles UARTEN =
*/
> +            s->logged_disabled_uart =3D false;
> +        }
>         s->cr =3D value;
>         pl011_loopback_mdmctrl(s);
>         break;
> @@ -665,6 +684,7 @@ static void pl011_reset(DeviceState *dev)
>     s->ifl =3D 0x12;
>     s->cr =3D 0x300;
>     s->flags =3D 0;
> +    s->logged_disabled_uart =3D false;
>     pl011_reset_rx_fifo(s);
>     pl011_reset_tx_fifo(s);
> }
> diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
> index ff735b5234..5695787650 100644
> --- a/include/hw/char/pl011.h
> +++ b/include/hw/char/pl011.h
> @@ -51,6 +51,7 @@ struct PL011State {
>     qemu_irq irq[6];
>     Clock *clk;
>     bool migrate_clk;
> +    bool logged_disabled_uart;
>     const unsigned char *id;
>     /*
>      * Since some users embed this struct directly, we must
> --=20
> 2.43.0
>=20
>=20


