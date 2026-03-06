Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2FDF01821
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vySmJ-0005iT-Qe; Fri, 06 Mar 2026 05:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vySmH-0005iD-44
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:51:29 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vySmF-0008F3-Al
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772794284; x=1773399084; i=deller@gmx.de;
 bh=X29NPps80v6y2LKnT2t7Gga3cJD0C6A6wzXoosV/4rA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=as+8sGKz5YcpyH2a0Pg3Di3Ne0oUArGbrwUwfQnoGI1CKiuUvvWrouwU9tt+rNp+
 mt8s1r0ljGs0hgegbvI5O5voypXI9CxO87l2MXC5mDdXnSQ1faxDUr7HdPJWin6dn
 ZTH/JEaCTXLzSmyTKW2wMrrJw2p9226G8tLJwEoNqkQ2CDi6whps5fUhNnR6w6OiB
 7HXRVRP7dDnDm0EEj0twR5JBGxyKWXJAEKttlm48xp9VpIsah6r/qa41yygsV7RMV
 Uv6VcJd0AKn1f59sMo2XMxkkm2wmsMjkQ4OVu2E0Lm80p1kp0HJQsI7KwNc7NXbKW
 WDjqikZaxwYO2+7/AQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My32L-1vjohv0nTL-014XBK; Fri, 06
 Mar 2026 11:51:24 +0100
Message-ID: <2d7da6f4-7fe0-4cd0-9048-b36108dbd298@gmx.de>
Date: Fri, 6 Mar 2026 11:51:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Check if RESOLVE_CACHED flag is defined
 before using it
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20260212095449.683135-1-frank.chang@sifive.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260212095449.683135-1-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kTslA+imshXH836r2eidnOyN5qovVXfQ2Cs4FyisjwcpG6devG0
 /DnUMzP2t5v6rBTxX2dT4egwo7VngGnIzGHpFpa6xYyHdt6zLRxwULT3bJ0Ftic2Clq679l
 aI441iZJW0zaXw6d3cCzz7VEEm1LkpFeiMxa3gsLzOJkbc2dfWNgxTWG+j/4Z0I2Rawfrfk
 xGYq3jmFcEf61c7+nvfDA==
UI-OutboundReport: notjunk:1;M01:P0:OqNQ9BPWB/4=;OnJn6on/6X8FPsWjHAUOnWesxcj
 f0hha5YrTcn45Qphi8XkZO5qDSNzPo7/u2iK9cgHw111LR00Ai0iDgb/DMS5lApdlK7smTFXK
 NMg+kMEJTKhL6ennet1zP6whQ0eG0FGd6hGfJvOuo0XSn9d8s6+vMSUMH2/NPPFzjFjAdkvPe
 D+fNaHvGvXp69gde5DiJNg+J+lo+VbrNvmonPFjOFWr3ajJkRUmBw8xChCQagpkWQfa9z5jgV
 PZ8JTkKVe1ZohBlk9woi7Ixo0cLYWOzcYRiJY89MASe0mtSUVsknOMeEoM9PD5Qn2l6ZoN7h3
 0fWnd7qcJ2y+Tr5WRALbieqsAdNDp6CF75f0rXXcTPYj+9IH+mpPgc6n3UDcbnbHJQX0d4Ktb
 wB/zwQr1RWdRGF3tWGFHsHGhkPaCtYODfrVqi4mMiQ1gdKkqrbyoeFAVOEViG85V/afo1vJS6
 uddg7AXxarl08E0Fv2aagUF/tvlaGjj+YCO0SRr5Pnf2Q8mRceGFhno35uXtfA4wyRi7DNX42
 B2iQvE5xu8Bassp+P+imAI3r6Xmffr8iwz35LNDFLRW5ANoQLSw0zWOkAUXB3zPLPYtxKcWsY
 gRmZnjR0yKvypTW8BFz5FM3gqqLWIUU84Y8WyAY9o9J8pmoQEhAtHqVx1a6KxXuL5GUZJHAuY
 I31Bz0Eu+roW3gArpcQF7OuiE618mvQURCmV+tfsMtKA2LGeSfrdRHp76aAFhLreMEj+9PPwp
 33pM56cpxY9aZoLU7UDx/py1KrIUDD25xvpLoXAQWhY3JtK08NpNIo3y9eQijmbQOrTOySKI3
 jPjCkX78DwUSonaYu4g9zGhGFW8PEyyt6O4KvEQc8p4eLYPFnZ9t4/+8rxZRBPLfPE0RcpynB
 xTTnlf93TMRIRymAy32YA6rXe/A2JKoyr6/e8n21Rf3X6lz1Ur3bsatcq6x8tC4pFXJWd+nbx
 tutp93/6IiLIHPJQdeCHJhizIQzbzmtsS0j3SPmgcBiP1CXtsTqT9eDfeMNOR7CJYiaXjvvtk
 N6XWnuAz5qQycnhECE2T37hJiZ4Vb6t7PMXCoz7PzOFOZcUCe8UqHGRPFBwlBXUDp7cw2B+dj
 VDn4b68HzWh1NoE/1Dv+hd7mlHBnBecqxmOJ13WiR1t5dVgGSp8yEzHrh4ycaAletFnubZF8X
 2+QpiC1hyxmwnZG0+RbR/OwOtqihyn9h1gjT9/O9qrWLNpMg8hNIDu1XB2biUSiFszQh30Un2
 3/scKYAm3hnISgwfTbL+IQX0Fjl1HgSxjdeuqlusgLBCSJHnsAr9EuvI/it3hOttCdVofRUrO
 KSSN12RN6rE7rKUlkaZQnlaLewcZqzNBiuaeR9t6taNukUomJ+jHsNPPIbBVpEVkvGBgSxbCJ
 atA8iddUPQs0je1SaX9aNB9ZWzeX4Vh/+IP7OQx+E65mYCBSh/Z0Ji5bRRf7cs08iqi7oYs8N
 boJf9xpVx2IEwmWsXPte2vkAl8dHsowF1yJGJkoA4KyEXXwNy+ahmyBfqe4PnD6LzQYyQIizI
 SpKLPtBiLMhbYdlD4jsl0jVhI579o1UwRhM5GTVnnTlPMk7j9XQD5vNqZ56PFoqff6M4u+0lI
 gVbcSfiPTKRQmbBOGsiD6rcX9UhbpMsLkXal4IMEUcNAIXv7L2w+n3hALncwBrosFoc474oe5
 9ON9T0M5TI1xAc3q94L+AI/cN/AM2vScXwI4jAUeOqQwvoLhrGDwFN6QdUlqx44OD8ymdLJHO
 XnveS1TW9ZivFRqgZhl9a2zUF0hTKH7G5hiOfFrr6CSP6Bx7LfAmOSkDZuKs4m4RV3w0GTJ45
 Bn7vczkF1C09StX6y70FcfoI7gQz97aq0+Q+Gd0AH6gsMKSXdZoR+s5fudNkb6ibUsmx1lxXF
 mOg4YrZvixwysc6DPwTvziisB9BEQdKJmhA3axmr1KhxDI8hkTYablg4K3az4Z0ZpN+WOlBib
 gjDvCTTQaj1Ik7mdQMi5BVJi+meAGMxCTaTmNeReoKpzb7jjcMypDmkwUjAGKBA8A2bofabxH
 tYcntJcUcBXH0H6MTplXk94lZWXQ+GtbVMdlBmAq2Hoj5OuofFSK25dKUYswYfEnHbbo3hnoc
 4OHb+808Wdvr08EZSCEQA6a+2woom1xK7YQBkzmTPrprOXOdCxantgGnLXYKNxzCSbgCBjCzF
 6CECNHal+Y3Slom3yHSZqSM1tb3WbQ+0tdGBfLGI/+HfEJaWXxmN3diHXQH5WS3vFhXRNTDiq
 lN+wl5EkDiKlNIe88IXKJZdvlgu9eQNGbSXdft4i+t7EInstgV57/Y+LJ5US0T0lCbUf0qFGH
 BhPpDPiR/SZousKPmF3AZZ0pvWtvuHJ1QBdcL1ZqbojKmo3fQExOY2d7g7dlrQJ8EWdcSt9et
 7glarHafhjUZ+SLlNgFxkoPjD6R77SH4GdxTZ+YWuhHxFN3ws3heu7BdyhwEYq/Y5QxnM19ld
 3eNeTOK1Ve5tdezl7wP9oCHivw80EHxHIleyRKy9br3bf5+SJrQZw0En3QEnjNNv65kUzSY/4
 K4tGT4ZsnSKxQhttUut8xqicCD3vHQIeqXTCXd2PMS6p972QFpauJdpFcRLUUle+jgXfSw63y
 UzWzw/gJtDwKDI+70ytMAoHuZxNFjkkxzPFv07+rXMkEvOmoCeozIbSgWg45RHjZT/6DoeRU5
 UCSxPBLph/IMh93c1hEwIVkgvar1Hc+pcXlk5drHS/GoxHNju7fD9JmE2K9ThxwoPhtCgucPv
 T6ygiuWFO8j0I+vdNg+L/vhZ1NlOeISe22mC1F1R6vdDvvF06EfSpk+2DZSXMIR+JfKegDLVu
 LJN/1dkCDNxPxsNmc5RxP6JYSyCRBKnuwAhOdbYZ+0nkYeQalIgsJotcyYcFpvdvAvdjZMN4T
 tRZxUH+PDK0zbzNCgIl5/B25RYtnIjtDAw4HhLunaOhgk/MK/cEO3ICo6WJZtEbqj9Ddn88F/
 e76AlSvxf8k2sx2s7rc/HbW9dJ0ykYt2Ww1wQEtqbc2McQy6GFGBRTiM9kBy1SkWZ5ZZbQWuf
 qo87YmMklF5UdWM96A5TuetGUpjbT2KoLjHJ30hoBqrr1l1k7eaXWwX/jA4qiZbjIqQOnvoz8
 QM5udBbcRUEwjojeXLhT6Gu0FJYHs3B14uwnwAGMqTajMlPwXEv5FgMJJGLWRZ6WwuFYuToVR
 q9+ZRKddZY12RLAtM7mgkvi8sDUT5Dv7DtZR/efdECWTHeyqTQaAgGTY0yZUx9IM7EjvBz6Cb
 38++r94Awx6VZu2h8JduPkcnhnLEO5x+b2I2fbApHxlhdWtm8lYyOMIeSBJrkZTVgLSlr/XDa
 m61CdwwI885coPdkVtJS5XpLlpXoVPPUCFAYYW8r5wkHJTmq8jOYnWFDE6FD8cIvyc12QVdIh
 VTYL7uHCsgzXQ4fNuZdumN1S9mnkt/fNpfxeOWPfLkg8ZLPMEKxoFrisZ28H003P91U5CMe2i
 xQEfDjS41KNMMvpZxHY5q5Rn/VT3rZJFmZEREMkKBx5E9In7OHkx8CNSaEeG+X8rFH1SM9vaU
 oKIKazEndBmZfZuPFiZpL/ey0g2hRkCRy3InCB5FW8sK+huAgXH5Z2GThKMPkHJLIuOAkCg9/
 VxYa5l8RnV1wTtxyGbqa9OhFoRJ4OkxxIr2C58lEHDxRHl2zPBxEhZZVzKjs6YO+Yr5+Glaqp
 SdVx/BxSs3pdQw3tLO82Fjo/PpEoNwRl+Jck/usaGqZnO5TjDudFW0e0OR9mW+qSAfAsxz82r
 H8eI9d2u/twH5x7F55iK1vKIPAI2yGvgETT7w3j9S8G0w4WGtPlZrB86gYBjL7cFKy3kHhMas
 TgAsetnh39F39gYZZVUhdSvLSX6BU8l2igRy9iSej0oRcxYctKCtEjXtNy4XcTHfHqY2OsR6S
 pWsU/ME0t/0QjFjzOzqzyMXtzBTjM8eaklgtmbkX8Rwp7Mmxt+l6o60WJMRkBsoqRaII68V+d
 HIO05YJwh9QY2ofhJd8i17GeeWh+5GrocIudUUptjAxJLwx4Y85ni6FcISdxdKtlPxG8YhLC6
 AGws2SldrhvrnhMzeaHFF162Wi1kr6AkCNOlbv4SjvnuEw9D2g4aak6mbD1ggs5AJ6YVQRaCq
 BbCLsI0YTIhc55U9zSzYopZXfHW26M+ABAOc2azgW/xf+qpg1oZhqLROirinab3OwBuhxt7B8
 9OneXzpnRcJ+TOqM1dQMmzNuw7S8I2RmFH1LfcJxxvkG/vTy+J6zJ5XqHQ89u9XLn8kT5OdLh
 UeCkrbc90TzE1BrGcdj2Z+C/uhV+FM6bOCcl+JE5L0/LRy8OTPBVWRYbqeBmyYw2KXBbfrM03
 UC7FVinK9rOqIY6nvNBHQLAtlRnnkbEkwWZfDl0PAUvelaNmIEBbNYZ0hN7tX9AEXi77Ww/xl
 dq3xpG/ePsiE8NYZeUjOyOt6VraY/7zb0GNZ6lqZidIprzqJ5BHvo11Zg6EFXN3l+YbVqxSP6
 KcHMgQsS25qndd4+1IN7X1nvLiqLpQbBxxOFhRYQxrQpFm93oc2uujj0rnq8JWCkAYMagKvss
 gUn237HIox3Te3jMtoz3eRUX3mrhReLTm//BXMOOAapZ398emO30GoMQ6JiN91okqKWWtOBhA
 ZHbJMdhMLIIBpwSYc08TsFbwzbHxYnkmoG5avgjZe9uBuKxPMSCyyf7quAvQHiKTw7j8dBMEp
 yn/TlikHEJ9yQsqLV+Qhz1D7GAz2ACh9B6jVxSAMAm0cf/UcJCqIDjRhSp8U0T5Kb8l0Y0gEM
 Um+y4tRgFW92CSNH9SeUOFRWcng7R976chwLG6o61ilt+Whu2I9pJgC1WpS+OzOKWe33+SgIQ
 rUMKH/zw2WMOtzE4BBb7dsBpSZ6hf3q+FZsrZdIbsm21BwSfi0ttwVFVd58+kEFWaC7OrpsYT
 1MDm/Af4q17Ojj2o9onVpbYD79raAxhzavCZkKWghV9I+xLHiBQjYsP1zuI/YGaf8MOgJCR/N
 rZ690FQl8+pV5KuutQlyr92TkyRuXF9tmHNvbgnLZB1vNc0EYlMBl1t9KmBXX3lt+YBrYqBKj
 wJFxOlyTNYWGyUsAzL/5LxRWdEqR40JA2X8c2bB67N86nXZQWe/DZXtde0NA9Bqxy3WAUywd7
 H3j7duKEgFyzNWDM6DzdJcEK0d1tjfEW7UCewoIspGpXCedNC8RybyZK0KcoLJZiGDg2Ufk7j
 fGqGUfBnWme2q8huMcmS2tl85I1MA+o4a7y5sJrwsR3+wQHGqtLoiUBWwblT1XSkFR/F0oz2M
 WDetv62pzeLtyv35hux5Yrytpm2wkJAE2HtB/ksNxA==
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/12/26 10:54, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
>=20
> openat2.h was introduced in Linux kernel 5.6. However, RESOLVE_CACHED
> flag was only added in kernel 5.12 and later. Therefore, we need to chec=
k
> if RESOLVE_CACHED flag is defined before using it.

Is there any documentation which states what the "minimum"
required kernel for building qemu is? If we require any kernel >5.12
anyway, then this patch isn't needed.

Otherwise it's of course correct, so:
Reviewed-by: Helge Deller <deller@gmx.de>

Helge

 =20
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>   linux-user/strace.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 758c5d32b6c..a903b414fd2 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1125,7 +1125,9 @@ UNUSED static const struct flags openat2_resolve_f=
lags[] =3D {
>       FLAG_GENERIC(RESOLVE_NO_SYMLINKS),
>       FLAG_GENERIC(RESOLVE_BENEATH),
>       FLAG_GENERIC(RESOLVE_IN_ROOT),
> +#ifdef RESOLVE_CACHED
>       FLAG_GENERIC(RESOLVE_CACHED),
> +#endif
>   #endif
>       FLAG_END,
>   };


