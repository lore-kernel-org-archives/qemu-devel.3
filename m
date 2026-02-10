Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6644AEA3F0D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 06:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vphgf-0003Rs-HV; Tue, 10 Feb 2026 01:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1vphgb-0003LK-I5
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 01:57:27 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1vphgZ-0004I1-WD
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 01:57:25 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-65939428896so7737236a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 22:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770706640; x=1771311440; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jBnF+yjCrGzOnhapfjfz8f76FPsQdLZcZppIdhgv6Kg=;
 b=jBSsPXxbcN+C1HJ91l7+oiGqamaSu+eBfAFEzYP8f/EtSPbyiQbHUh6+r2VJui2pcM
 F5uKy7ph/Yj+FRxApsIiDLausmLRF2svF9DLgOslLW0g2UGjUxlgsnIJrXk31AkKR4/W
 cKmMPTB1+BvzXlR8azf1s52FwlqLY3fX1bPVum7fpNJw2AONP0u4Is6+yBLokdR1uvbD
 18nZ+0jIVQQmZR6FQ1oif6D1P+G59hUv8UhCA7kSjRgq5H1sot3dfva9fa9mlxlbiBgH
 KLMVinJxzdfpNtyU6QWqagm3O9JnnOIleZZffALsJvmllvidy9L+B6kV9P6qd/XjOivx
 qYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770706640; x=1771311440;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jBnF+yjCrGzOnhapfjfz8f76FPsQdLZcZppIdhgv6Kg=;
 b=vT0CS9m0luoLnEbwv/twVRDr44yGThrPdOsBlBs+N2pG0rwkBcf48ckg3BoH4xt7N+
 jiFpSNF8kNeIDHvtnfhi1saca20yiM+RLq1O18fx5zvbKliPBuElE3q9cjQS9uD45PAQ
 ZJO1jyStvvOicwNVwWHAmAs7knXOWEUkJQlIXthsdaFQHOJhsfksNH7z6b5tTjRDMnwU
 /Mr0jeOPB3Dl/5mjwRf4VhR8JphOXnxoNYiHjK4xZpYHeatcbxPjiBcnTV7nz3/MnB3M
 TXOlwUGh5+ehnsLg4hYuibvlKLKn5uJdOH/C2Rp65J7g+5WaVSJl2CzTAjCP/ELZ9Bmn
 6XMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/XTlrNLObyBuxLFl6BDp0Umz1HRyjxO6yIXeQ3ozFUt8ByvDEXQICiO+yFrDjKNlA+yWvA6a9eXto@nongnu.org
X-Gm-Message-State: AOJu0Yyl/vHAaLZJVHR+G6uoQCxr7cEdDPZ/eo39v7MCccenf4Xd7HEc
 lqLmcJOVLZpugLNcYhWZSQAhEMiJ3LaTpEuNmL/0inTX2Vwy2KXHgLJW
X-Gm-Gg: AZuq6aIGXO95KwnfmZY9aEntkqt3Cz83C73DoRIyMfmoiO1Sgv//cUkjpE/kc0myCFN
 tpDsriDuo/6049rHv8Mo+STUN0/fTXFGOs8uyOsG2CiyOT0zw5VXYTOwpUt4daAAJFH9t1lGUMJ
 z0z7FGWubTX+/raRpgy+hdbZUwhkYnHS+eUwOctwtYiPMi/jjWPw87E8C5BNAk3CdY39IMh6rrF
 pitx/gCz+DmQr5ZoY3yUXQKom9SCaZoWRhL0Bhnxxtl0kV0s/FHJ6eb6MXXkPe7dKjetL6c5Bfv
 xquDKb6xHh8FzaomiQ877oY1Fu8USYaWTNr8xK1vNo3w55F/xco1ZHRlU5egPDPEe5VG5liFmjD
 W3WPMTPVdboVWqWa4mlqal5qQWlQeh/rwEmcJfpRtmjKdN6RT+mvTgNVIrLYAXFL34cYGggkANM
 63ssFNbSi5UiBgmrEMGNjQlt8wkNvwB9y43kugLTPvl1uaV0JQJwnGiLUXAYNhyWc4l9Oi4K6Lk
 DgOO5ET0mj+NhIswLINno7Zl/Ub4Y2BCMpGk5RUFuaPnqo4M130eO6cnCSIA+QcKKEnRvY/1VSZ
 gc+ttHSpD9SsEywOtJwoc5CoKTWaU1cJclfcEhjWX1qoJsCMVQm2JlWhAUaoHQ==
X-Received: by 2002:a05:6402:46cd:b0:65a:1978:59f9 with SMTP id
 4fb4d7f45d1cf-65a19785c6emr118022a12.14.1770706640311; 
 Mon, 09 Feb 2026 22:57:20 -0800 (PST)
Received: from ?IPv6:2001:1c0f:81f:8e00:561f:8baa:54e2:9aa0?
 (2001-1c0f-081f-8e00-561f-8baa-54e2-9aa0.cable.dynamic.v6.ziggo.nl.
 [2001:1c0f:81f:8e00:561f:8baa:54e2:9aa0])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65983eaa57bsm3714159a12.5.2026.02.09.22.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 22:57:19 -0800 (PST)
Message-ID: <098b8b01f48b4ed4624a86f6ec2db539cf8632aa.camel@gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Implement frame number overflow event
From: Howard Spoelstra <hsp.cat7@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org
Date: Tue, 10 Feb 2026 07:57:18 +0100
In-Reply-To: <20260209001836.5413F5969F2@zero.eik.bme.hu>
References: <20260209001836.5413F5969F2@zero.eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=hsp.cat7@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 2026-02-09 at 01:18 +0100, BALATON Zoltan wrote:
> According to specification 6.5.6 FrameNumberOverflow Event when bit
> 15
> of frame count changes (either from 1 to 0 or 0 to 1) a
> FrameNumberOverflow interrupt should be generated.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> =C2=A0hw/usb/hcd-ohci.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index c7e9c71903..f8da16bc8f 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -1246,6 +1246,9 @@ static void ohci_frame_boundary(void *opaque)
> =C2=A0=C2=A0=C2=A0=C2=A0 hcca.frame =3D cpu_to_le16(ohci->frame_number);
> =C2=A0=C2=A0=C2=A0=C2=A0 /* When the HC updates frame number, set pad to =
0. Ref OHCI Spec
> 4.4.1*/
> =C2=A0=C2=A0=C2=A0=C2=A0 hcca.pad =3D 0;
> +=C2=A0=C2=A0=C2=A0 if (ohci->frame_number =3D=3D 0x8000 || ohci->frame_n=
umber =3D=3D 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ohci_set_interrupt(ohci, OHCI=
_INTR_FNO);
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 if (ohci->done_count =3D=3D 0 && !(ohci->intr_st=
atus &
> OHCI_INTR_WD)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ohci->done) {


While this looks enough to assure the audio stream is stable in e.g.
Mac OS 9, Mac OS X seems to require an additional patch regarding page-
crossing (spec 4.3.2.3.1): The start_addr > end_addr check is invalid
when BP0 and BE are on different pages with BP0 at a higher physical
address. So move the check inside the same-page branch.


diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index c7e9c71903..a1b2c3d4e5 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -710,16 +710,15 @@ static int ohci_service_iso_td(OHCIState *ohci,
struct ohci_ed *ed)
         end_addr =3D next_offset;
     }
=20
-    if (start_addr > end_addr) {
-        trace_usb_ohci_iso_td_bad_cc_overrun(start_addr, end_addr);
-        return 1;
-    }
-
-    if ((start_addr & OHCI_PAGE_MASK) !=3D (end_addr & OHCI_PAGE_MASK))
{
+    if ((start_addr & OHCI_PAGE_MASK) =3D=3D (end_addr & OHCI_PAGE_MASK))
{
+        if (start_addr > end_addr) {
+            trace_usb_ohci_iso_td_bad_cc_overrun(start_addr,
end_addr);
+            return 1;
+        }
+        len =3D end_addr - start_addr + 1;
+    } else {
         len =3D (end_addr & OHCI_OFFSET_MASK) + 0x1001
             - (start_addr & OHCI_OFFSET_MASK);
-    } else {
-        len =3D end_addr - start_addr + 1;
     }
     if (len > sizeof(buf)) {
         len =3D sizeof(buf);


