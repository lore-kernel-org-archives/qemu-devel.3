Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DECD1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 15:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSzMX-0005eP-Ar; Tue, 09 Dec 2025 10:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vSzMM-0005dG-07
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 10:10:41 -0500
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vSzMK-0005HW-5U
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 10:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1765293034; x=1765897834; i=laurent@vivier.eu;
 bh=cqQOYOxCscWjbDWwEL4MyoeLurpmeTEsYMWnA1PWuOk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=JCJZswuxd7RreGrFB11+rEBSCDDFrtA6+s2/mkeT21KLcARuoB5uBpwIolW7NX4w
 26fgEU7hDMFyBU8YIrpLeY3xM1ycRCpBFLXFh+LfsoOy6G7kY6351jerXKozC3Qx7
 r6Qect124tB6OTjx7WzTDEe3637T+dRN9yWik2DV/tZGcl8NlMJfhf1jt7enOW3AL
 l4SWnIkceKfTGmER+9okM+zQ0HlE3kyPwDMB57UnJL3BoXQALHq5+yKj4wkQo6wgo
 Q22MprZQNZGut4oF16ebNuLmDytbOWo7XS3ldgbfNTWfTv1qIHmwndOgFK6THxkhi
 6fSzswSlP2cilTSVfQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MA844-1vIUh13Qeg-00CLbf; Tue, 09 Dec 2025 16:10:33 +0100
Message-ID: <e8b4738b-cc55-4441-a72a-3f022f5b96ef@vivier.eu>
Date: Tue, 9 Dec 2025 16:10:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] log: Fix result of strstr to 'const char *'
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20251209150346.650473-1-clg@redhat.com>
Content-Language: fr
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20251209150346.650473-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8HP/WcqcjlD1kUHkFLrLnxSxpv0cTBwHcJuCG8zf9KnopYw9xtj
 oIs7ZiHyAtXUC2IvT2GB/4OLpSPaWkBAsPkHh22WLtNqhny6s1gZwcQPpU5DDfyiq5GVetY
 Ssh7mF1/ThHZ9tKvRmrrteTbtpDhoGM5nqLMCkn/zobDv9HXkq3zaq/cV9MToZffJ0UpSCP
 DxjhPWtWA+9IUej9QxxDg==
UI-OutboundReport: notjunk:1;M01:P0:dkeRAVV0IXg=;I6AvKEHhOL9mO6utJRiZ0V8Z+6L
 l66WnVnD05JOUTEEVXu60gYDz9e4GIfD694r4gITJxM0UQAvESTOWUFXM9fTu6OBwmb8N3c8R
 lG6R5Aa5KOeHIck5nGL/S4n0Vd1b0DZaY1kiDGuZtmqDUF2ZoLCBZuECGBKm/duItL37HWvo7
 /pBcFQwWeoiE87wV++Mo78ENjAyhCWIx/X179U6TtVSqlpnGUmZk9VqDVRipNr1N13wqIMkX9
 qeBp3ui3lo5Gah+2Z3YsVJBsgoXGA/xG89m707KRe0wX8B7cTNXTxlzOjmVALITCS1SbCAlEU
 vXd3Z+7rCFxF4mYhOc6TyStqT7GWv2riEyTxK1rFRNKQmafdus3B/P+Wtgw+0GFc9B0clz6Gh
 iDyz69NLImyFQfPRDqlddId0POE4UagRRzaZNoXdg54iZpBKkWKEyVgE2WoOp3LVe9nk+rIa+
 N8mytz0WE2nhcsaTkvAw8bYEJpA3si6PgIi9Vo3cICrJAGt/YLl5cP47a36aOrPM2M/fVvgVV
 z1wTL7QY/AhnG0pr6DkSLX4q6KTXUDL7FEHQseoSEfHZK1fKOUfX9oQawNg1MP819WMvP014Z
 fiv7SGcEJCmhuGlu0HjLdz+vHAcm+j27YgokdsG5W2E1ed7MD3Gl5fhbThE/JI2pfJrW5pw9k
 QuVFJiPfGFViRAODAU5FIdJnlugkOcxjiD20uBUmTwR0C56gZpH5vxu0Ve8yYlqmY1mF+qKDp
 yZuox+6UepsSyHhDtkzw2jE9PaFc6C/1cxo52QNZhBZxnSRSZ3FFKSuoBUa8Oic0CUhq8FxBG
 8oS3dX+8FMptERHd5PgKIUB0WvML8xsiLAWi5XBz8ZB8QQtrFlhrjtIakJSyca6AIkpR/RNqf
 aYVVaFpM/YPTllGLCRfJwXROzUSmkW0Ah36ffV5CHftCcAwzQ+gSd/5iHuVYq1WcZRuSCPIXq
 bFQrx16wrzvvkafYH6ee9Z5+EIxTc48yPWEBJgQQJIrDp3zi61QHpDB4nUHIcV78GgeF4OFi+
 CnQfcuOCuaV4JxbfJygvzOwSgQKjHrnNCrJxEBmK2UW3C0CMg/W63T/Eo1tIL73iFKufiKpHy
 dUOfQ1vSKzHO0v9PIuEIk6dGN1gfW7jmAHqHCa8d5iHeFURiYQUo3EnrT1oRn9R03ntDgb6++
 4yP6Al0uCa8643pzoyVXKVxRyNIISfTb4DW9luIJ0HknFzQr/838G6GPH7DvDsJy8jetxaaMC
 eA1GzMM2z/FqF4AIZt6/n6n3NzdycBCvpGE55LHu6phuuB1O5uoAfvT8MVzVSshz+WmBcyJwr
 XDBcn2YONLT5hxXVMXWRy/rEk8ZVJ1KL5wr2Zg3pTcnqmeOkTv+acxvHOne6T6HaimX8pCWKL
 DIf5sdoL68EWKQGrGZgT3KOKKUCGqpU9yQZkZKQmVnIIzv4sx+LjT1TjDzkoibck/mrY1vH+Y
 D2gCGeHl2WKOlIOGpsveIkU3d+/oqZg5Xk3qzYbtOW3ZnUZsyxmLuW/i0SGS0Bm/LzSQjmume
 FmReEHTazpvxcKgsEpNCnBfuy5gaYVGYTvnMXZJe1D19zArdIbgMdbtl5Bdtpsqy57NzePifg
 K/l1f4vR1eZMwEVCudCcTZLKhKkaMmvCTIjnViZuWxonfQLqtDM5qevKDTXwTulVLkux4Kqyq
 lnTFlkXRSZNLxTbRpRGVm1YpsLCnvYj9RzA7OlQVeLU1JQ2x1/A5MPD/NTV6TnWBcMj0WmnFB
 hXAvEk+mmSIK3NlTHGDow/pUSwYSYjd+1qEaeN/8LscM9AD7Mr6x+PM+Ql3b9iFzlsj/HnfRM
 SBqL
Received-SPF: pass client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/9/25 16:03, C=C3=A9dric Le Goater wrote:
> Assigning the result of strstr() to a 'char *' is unsafe since
> strstr() returns a pointer into the original string which is a
> read-only 'const char *' string. Newer compilers now complain when the
> result of strstr() is not a 'const char *' :
>=20
> ../util/log.c:208:24: error: initialization discards 'const' qualifier f=
rom pointer target type [-Werror=3Ddiscarded-qualifiers]
>   208 |         char *pidstr =3D strstr(filename, "%");
>       |                        ^~~~~~
>=20
> Fix that.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  util/log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/util/log.c b/util/log.c
> index 41f78ce86b2522b8b7072c8b76d8e18603142db6..c44d66b5ce78338cf1b2cd26=
b7503cb94d4570cb 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -203,7 +203,7 @@ static ValidFilenameTemplateResult
>  valid_filename_template(const char *filename, bool per_thread, Error **=
errp)
>  {
>      if (filename) {
> -        char *pidstr =3D strstr(filename, "%");
> +        const char *pidstr =3D strstr(filename, "%");
> =20
>          if (pidstr) {
>              /* We only accept one %d, no other format strings */

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

