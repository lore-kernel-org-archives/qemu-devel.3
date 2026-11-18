Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDEC606A331
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JrZ+SVHy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTkrr-00054D-06; Wed, 18 Nov 2026 13:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xTkro-00053t-7F
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 13:58:48 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xTkrm-0007TL-Go
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 13:58:47 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso1193256f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795028324; x=1795633124; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OZCH2QJjicQ9khKl2pIaRDMnb2uv3waK5lzNG8XRMuE=;
 b=JrZ+SVHyPvZigNYRgiYACP5/JqgJnwYjZwggG8MKDhhGDjzLJclzWX7fN/t780Pikw
 POp5NpqYrvOJXuN9aze9ISIZMqwNjDG0oeuo9mMvufvQ+S99G3zLS7nfRCry0tFs+jOJ
 8QelaTgVo3j5O3sO2/tdhAHpWe+omGV59KPbEVGIzt3HPf3uRFW15kO8926jCH7N5eSl
 8tNNYiwXy3RDC6ZYa02JQZPcgfVVO+vfpR+eSXmcTSotFwWMNFao1JhVA3kSS1u+OoTt
 yMGO/fvvi7V87ik2KY/DdHBYG3UpTLR9UN8/nf8i3uNBT87ZGTx7lkknx0wjsDIDfaas
 POMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795028324; x=1795633124;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OZCH2QJjicQ9khKl2pIaRDMnb2uv3waK5lzNG8XRMuE=;
 b=IzYCZyPm3cOckzmKMiyI+wBlslzgbcFK+JR/dPzP85Qf52/GAmIAs15/chvugBZ/Gn
 mNEYzbfDCVT6IVRO4jTnt4szFw0U9HadnCVZnur0Xqcru7LYSjUreqcUOTOdTMsoEyFj
 vqzGGCNUY0DPBn9FRhEqAaNzz2+M2Xw59gi7ez3eg828yxzd4DqyUAh/B4MiA0wxoFEn
 nEbQ0vf84f4g2UB3tPRPyCBwEFmLRYjcxvQNoLCARnwX8PZokFYA9+tJkM658/VQrEUH
 mXqpTVEyCgGsd3IrDRaySetczfITQcGTpstr5fcKI7W4UhvIn73quLRpFvEZTxWS3CXm
 hkNQ==
X-Gm-Message-State: APuU4Z8dtXyYrF5JyAQtfbllH9nrkmcrDE0NGnT7M0JWlETHwn5Twlqw
 pkoSvsJSRSZrQZDTSX8yF1bYTj2cfvjVdKDXQQS1G3tc6vxi4ja12qbX31dP2g==
X-Gm-Gg: AZFdTZc6wRknpFSujSuZl5J6zJYVg79YSczOgmRqSf/TGVN5oF/q4fh2fsq8SdqF6iV
 1zD33hX0QvtRBzDPSs8xZUDmQAbEycYOeAOjo0KxNbM1SXSp2xGvF5x3Zm+0X/M/kQLaZdNbOE6
 cQ4qmSgxy7Txx+4LjlBxLYaDC4A4wAtzN1QM2EDhD5t98n3Bx4y0pieaZM5NgrLah+0Idp6pczl
 YEea6Mf6g5gXqkxNspib6Yv7zNTmRVXHeAx33Xn7ssuJJvBFUZJXoWSV1NnvhuC4JT8HJb9B2Ce
 S3EWroLzmz3kdEr7hh1Wz0Q2NcySn9+q6h9TLnyKcxmNyJvnhOI6daVyI+sSP4qVdCGS3ArQud9
 SIKPt1XUpaKgVDbYZmTDLfp7cHQuDEs1yQeRoR4HjLm+gtXZjLQydMV+3pbPsRdFsf9GpuVYKqt
 Axophge3d/838Z0tqwArfEoJW7htPHt7P80TL504IrsMmsiNUlGZ6w7oSdBMir1nRYP/TgOBj0p
 WuMopViPd8MGo10HuA/7sYOMFRlDUIvc0Png3vyyqWaNZpulbJpf3vdC2IJoMz05Nlt7mZnfcdH
 j7KiA54/L1i/Hslo5GPRyO8AncynkuGBcQ==
X-Received: by 2002:a5d:5f48:0:b0:48b:a4b:5a2c with SMTP id
 ffacd0b85a97d-4a696cfde99mr7321103f8f.3.1795028323484; 
 Wed, 18 Nov 2026 10:58:43 -0800 (PST)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65693389dsm5814833f8f.48.2026.11.18.10.58.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 10:58:43 -0800 (PST)
Date: Wed, 18 Nov 2026 18:58:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
CC: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_Who_should_be_allowed_to_unrealize_a_device?=
 =?US-ASCII?Q?=2C_and_what_can_you_still_do_with_it_afterwards=3F?=
In-Reply-To: <CAFEAcA9BnWRnyMp4rswY1dxA4b5FQpQhK3YsGYGPXzwa-5YfGA@mail.gmail.com>
References: <CAFEAcA9Ob8CsaufaAZ6jUhrKkxSfCkcig3ciG5LK_WCNCi14NA@mail.gmail.com>
 <de8cfd7a-9c43-44ac-baba-c8f892749dc4@eik.bme.hu>
 <CAFEAcA9BnWRnyMp4rswY1dxA4b5FQpQhK3YsGYGPXzwa-5YfGA@mail.gmail.com>
Message-ID: <64F81A8F-4EC2-4147-B254-089A2D956264@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 14=2E November 2026 10:37:09 UTC schrieb Peter Maydell <peter=2Emaydell=
@linaro=2Eorg>:
>On Fri, 13 Nov 2026 at 20:07, BALATON Zoltan <balaton@eik=2Ebme=2Ehu> wro=
te:
>>
>> On Fri, 13 Nov 2026, Peter Maydell wrote:
>> > We give QOM objects a reference count=2E This means that if you are
>> > going to try to use one, you can take a ref to it, and then you're
>> > guaranteed that it won't disappear while you're working with it=2E
>> >
>> > For QDEV devices, we add the "realize" and "unrealize" steps to
>> > the lifecycle=2E There is no "reference count for having a realized
>> > device"=2E So what do we intend here?
>> >
>> > (1) We could say that if you have a reference to the device then you
>> > can assume it's not going to be unrealized under your feet, and have
>> > very careful rules about who can unrealize a device and when=2E
>> >
>> > (2) We could say that if you have a reference to the device then it
>> > might be unrealized, but it won't be deinitialized, and you can assum=
e
>> > that all the API calls you might make on it will in some sense still
>> > work, and at any rate at least won't try to access memory that's been
>> > freed or crash=2E
>>
>> I have no idea but (2) seems to be impossible to achieve without likely
>> also patching all devices one by one that don't expect this now=2E So I
>> think requiring that a device should only be unrealized if the caller o=
f
>> unrealize has the only reference to it would make sense=2E This is at l=
east
>> easy to check but may not be easy to ensure in every case but, failing
>> that may only leave a leaked device at worst but not break things=2E So=
 I'd
>> vote (1)=2E
>
>The good news about (2) is that the only devices that can be
>unrealized is the ones that can be hot-unplugged, which is
>"PCI devices and a handful of others", so we wouldn't have to look
>at literally every device=2E But I agree that if we can figure out a
>viable rule for when you're allowed to unrealize then that would
>probably be less work to implement=2E
>
>One thing I'm not sure about is what unrealize is actually for=2E
>Is there ever anything that a device needs to do in unrealize that
>it could not postpone to deinit?

I think this question boils down to what the difference between init() and=
 realize() is=2E deinit() and unrealize() should be their respective duals,=
 i=2Ee=2E undo what has been done there=2E

Best regards,
Bernhard

