Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AB1C44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wko4c-0002gy-EH; Fri, 17 Jul 2026 15:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wko4b-0002gi-2i; Fri, 17 Jul 2026 15:18:13 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wko4Z-00007U-9t; Fri, 17 Jul 2026 15:18:12 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0D4747A00E2;
 Fri, 17 Jul 2026 15:18:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 15:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1784315887; x=1784402287; bh=KDWSutytkYTOX/3yfpT2fncRSPeVkUD5
 8lR4+vc+7qk=; b=lQgIgjLsHMsWSYTzit/HfmdsRMWDwAvXA7bMCIeM5/qxoeuc
 EISYb/hQ62t1GTfPG3xlmQJpJ962PA6qSgJh/TKErdyNliAJFbagiN39IEhPfmgH
 VR4ldeSXwH8mYLRgyRNYni1Ucd0WgMnPBrWmZIsYN0hmLkX3rXXN/Qp/1dBC/weR
 kU4ryNH7EYcUT7F+yBFl4lvXpJD1eCCZYVemRZNxZHSnVsNGUU9QT3xQYcQR6Arw
 hnB2FZ548ISYlk3emOkR6xzyt9dCMsAMzNIgnlHkCg1FsFF+JVT5bsjnjynVj9mR
 h1r0nx2cJj8YvlBpMwttVguE0KMZWVVdJhGs8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784315887; x=
 1784402287; bh=KDWSutytkYTOX/3yfpT2fncRSPeVkUD58lR4+vc+7qk=; b=Y
 tvh5pFG/TkPrrhLrupJCu0LdVeOL+c1Kaw9K5L9TuL1xZP/jfX8DEMhL62LngF2d
 CqAsWcemWj+fXghYAFRjIGEKG/IVr4XhXnln/roMoTvMfB/8IgMsDNLOSgksJ+3i
 Y2xNZfEpyh8etuV9NBvOj34KZVEz/xgJ8HSdY/zJhHAsBxCq0lSavV+wL64oOqXZ
 yuEKp1KChqJdARfYjjoTcRJXtwMbqfEchQ1xXQEHm9nE5BXKaykvli2zmvoQbX4A
 aUpEX4GqSeMfofezWvN2Yt2nxcoDB82myYJCof19ffSldZ/P42FuF5HHmHd2O+7c
 PhW6mHNZFjkw7ySU09Heg==
X-ME-Sender: <xms:739aaqNRKyDTzKfE7EM70R716fcYRA4VJn5Lo3hkfw9A5ecoS2fEng>
 <xme:739aav_0PJ3Bpi44sp_Zsxp9KJisZZO4ULA8p_CE68oRDs39JdWbqKemrkfrGNFYb
 jnSUP7ZEdcC0wNeFSd0lQn80CGMYu_zqKXtLbhjkmjMURN-aXJtp58>
X-ME-Received: <xmr:739aamR4DyJPJUVKGsLUUaqyaLtFDNYG9HVk4ure_KYJYXijlEblMrRCR1E>
X-ME-Proxy-Cause: dmFkZTFd0M5eStzdHn/xbjWjpMj7WVrbRGH9lWT/3jdSiVSVKTp79ietBkMA5HXwDZMNUi
 +rN9owJQKW36YYyVCEMPgohM9TxQk3pdF2uXHK0HGfVp6/5Z4zXTI2IV+Z73Ny8Uax9VgH
 cS/YAN0ClMfsmVg5AwjIJFhm27EdU0+VqOy/bKW8cJI8HLMsfP+3GjWY1QPEsKBsY6zW4j
 BPnkxkamO+QILWwYrhSmw3Ojkwp2NDD5bt+UOyZh+NHgEuuJpsnbdqt3ihkWJ04TM8qIiY
 HzJlce0Mag08tYliI/1fXV1JDtgOGMY903KsQW0jIKlajxPDXBWqDCn+uyATGTNlRRQFmJ
 wyOmLNMZJEh53MqVnomHPZzHQoJAfXbFz+uP1M1CiUM1kDZzdM982J85UkD0uWADIJPpf9
 mwpYBCCOkRC7RbV5f7tjC1BizkoIM9oZ8L8gGUfNZHeOuLlSpVtZB8bh1pLVfrokQeIXMR
 VSSg+cFwOQZPOwlbitdNL0Hu3wHV6WBuQhjN/hyIPEDnFDm2bkk7t/PgabwKDsNvTA3SMd
 BfywWQ5b1oHR1kBuS5EUoqCR843LFUz7Ra9frdj3AEXkuFqDWPIktl/MH79EWO05TEd54u
 y2g/3vGukiH4d5/Lsz5uIIGAzZHC9/9apCKaeN5OyGOsGW0VdcvPAtEfIIXA
X-ME-Proxy: <xmx:739aapkoEPQUDhBHnIJw_yl9pEHoB7XXYbzE7AxT-bpwDLIfCAT-tg>
 <xmx:739aauT0pzcuN-spybOiH8qyTwXvaCLSyFGl7h4O2ZCgha9cZFb9zg>
 <xmx:739aavNqTmEJV-ZNpNaNcpZkEo2JsCoqVX_Gcnw57HjgCvPD8nRKMg>
 <xmx:739aavXuaLwcHWfPaPeu1rWpVzxpPDidiKRyBT9EiKoQMxv5g-FEwQ>
 <xmx:739aakWRMMWPgg87dhGcJZ289e6BMMsfjZ7_V8PTmFREalunJwhTfrmK>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 15:18:07 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 5637d179;
 Fri, 17 Jul 2026 19:18:06 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 15:18:06 -0400
Message-Id: <DK136Y1D12S6.1M8YVJ7NZ85UG@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>,
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Subject: Re: [PATCH v3 0/7] ati-vga: CCE engine setup and PIO packet processing
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260606195216.2524314-1-chad@jablonski.xyz>
 <019e542e-0a9d-84cd-593f-357a38b8f9aa@eik.bme.hu>
In-Reply-To: <019e542e-0a9d-84cd-593f-357a38b8f9aa@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b7-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

>
> Sorry, I did not have time to review this but AFAIU this is more of an RF=
C=20
> now as it does not work with any drivers yet so you'll follow up with mor=
e=20
> patches anyway.
>

Thanks for taking another look at this. You're right, this should have been=
 an
RFC.

>
> I was wondering if anything wants to read the microcode. If not we could=
=20
> just ignore the writes and not store the data and just log when something=
=20
> tried to read. (Or just do nothing for it as uniplemented register=20
> accesses are already logged.) Or are you aware something that needs the=
=20
> read registers?
>

I haven't run into anything that reads the microcode. I ended up
removing all of this.

>
> So far we handled these differences within the same function with if on=
=20
> model. The differences added by this series does not seem large enough to=
=20
> not fit in an if to keep the single functions but if we go with separate=
=20
> functions instead then maybe the existing ifs should also be removed and=
=20
> split into the model specific functions with the common one named=20
> ati_common_reg_* then? The current series only converts new registers so=
=20
> I'd either use ifs with the single handler function or convert everything=
=20
> to stay consistent.
>

After building on this I have to agree with you. It turned out to
be much easier to deal with keeping the differences local to a single
register handler for now.

I'm abandoning this series for a simpler approach that just implements
the CP engine (bus mastering) for the r100 end-to-end for the Linux
radeon driver (UMS). Sending that series shortly.

