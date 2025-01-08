Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB556E7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 15:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVXtl-0001wU-AT; Wed, 08 Jan 2025 10:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tVXtZ-0001tm-Hd
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:22:57 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tVXtW-0005EW-0i
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:22:56 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso760857866b.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 07:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736349765; x=1736954565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJmR62pnrdLuNnhPrdsP22t6rwya1eZq5Y0KF8WPy34=;
 b=RMqcd1y3sbFasRI954HCC9fuUooI6/cylKK/i+ol5E7+uAtqhxgr7b64SejJx2SNjg
 zeCcJyLxmf4KXNKldTzZ6BBpYd0NttG/djLET/Ua2REisoatAUmyeKuJJsqv0KExFBBm
 6sw44VR46/SDK6JpsmpbvImuEiPQf/BkkUON9k8LtrJMSZNlu9yoM7DVBuwIpxk6rXyp
 RfTF7h3kOI/iRx6Pt0TfXpFCSFm31qOySzI7JuefWAKNdKQ1Mk5r46oacvu8pDiSSXgM
 olw65ZVsPI6cvdH99wQUgBMTvQLgANdz6jv91lmwqEvkhSxoyXVBrdbD5rJn21xz1cZ7
 x/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736349765; x=1736954565;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJmR62pnrdLuNnhPrdsP22t6rwya1eZq5Y0KF8WPy34=;
 b=CP7Si/EatR5lTN3NUZrprCGyNM+AI5s9zovgM+F23OEOCEffdhHz1Ikv8M9mtclQ3r
 bgGtW9JAGHbOhWjwr7y6847fS/7Aa0IKF8H9HzaztgkCMZ1/vgb0LLpdQWfKTkF5xvIR
 xKPsJtyCRPexnFEwePVyldD7+R2rpFHZbeygLRmPhYt86EG85IMOj7GeudcSYjF1AcaA
 J+auOsFRaFzQdXEbC8vRtLqTAi1WSfSy9IOGlzEQ3cKVPLiXLbF1ok6tH9w/Pdup45pL
 unZlQM7KLSLObu/BaxeXkpi/2R8zKjcZ9PZyK0OGyYTD7AEdCMBriyY4dnUUTOY9r22c
 fJXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHDTf4bbiMY1TsQGerd1o9GvF2tfIBhSznvr6BFca4y0TDCw7rYSx2ArXwchFR92fVcny2z9/Rse6N@nongnu.org
X-Gm-Message-State: AOJu0YwLUqgkS3S3Ig3XGojIk5rSm2UnXHTRwOFmnJLL3VWwvn3tSy90
 w/fsdjt4kykRG57YLon0ONb08rwm/2dkUKnlp1a7wUqSH+Fa9kmW
X-Gm-Gg: ASbGncuocCJvkSUZ0NWYkKjBX4/U2CSaoSMLXaVMQRRnDGd45F/dRPdXmJesV/oEgSN
 JrgOvfWhhp7wSOaqVrzkiucOw8H6PzOnPNwztBVdl5O7zLPvPgw230cHvNuCPH4r9jeIRKrnaz8
 YX4dUVeywW9O6P1+LM75bttx5LnaaMRHZVpLzrIwPm6bNLeqwsjRPU4nqQXeXLvqZTl604Bl1WS
 Q4DRIiNPJm2A1DWMr8biFRl4TUOvPm7a1415VJVhYGqNmiY0id1DRHr+CI7FAqns08r8SViWCd1
 OXKOGBvdd94Lx2zybcF4u7NCC/M=
X-Google-Smtp-Source: AGHT+IGxnz0ggv12CJVSXb4mZXihATLTBqRi9YZEA4tyjY+iAJhP74blbpMO7fTiv/XdSv2ITjrPOg==
X-Received: by 2002:a17:907:6d23:b0:aae:a087:f972 with SMTP id
 a640c23a62f3a-ab2ab16b1d6mr231978966b.11.1736349765311; 
 Wed, 08 Jan 2025 07:22:45 -0800 (PST)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f014572sm2487281366b.151.2025.01.08.07.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 07:22:44 -0800 (PST)
Date: Wed, 08 Jan 2025 14:23:43 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
CC: Thomas Huth <thuth@redhat.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/i386/pc=3A_Fix_level_inte?=
 =?US-ASCII?Q?rrupt_sharing_for_Xen_event_channel_GSI?=
In-Reply-To: <a7484289fdffd85431bc6b255a59b894bc3e2d6a.camel@infradead.org>
References: <e592f9127f2d9919e6ccb76a0afb38c5d725d8ec.camel@infradead.org>
 <20250107110718-mutt-send-email-mst@kernel.org>
 <8b2690f2c9532468fd5029d319737904b58acec2.camel@infradead.org>
 <E60B2E8D-23B5-43E2-8DC5-FDBA30EB40EF@gmail.com>
 <a7484289fdffd85431bc6b255a59b894bc3e2d6a.camel@infradead.org>
Message-ID: <3BC1A243-5481-4902-81B6-80135577847D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 8=2E Januar 2025 11:26:57 UTC schrieb David Woodhouse <dwmw2@infradead=
=2Eorg>:
>On Wed, 2025-01-08 at 09:45 +0000, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 7=2E Januar 2025 16:20:28 UTC schrieb David Woodhouse
>> <dwmw2@infradead=2Eorg>:
>> > On Tue, 2025-01-07 at 11:07 -0500, Michael S=2E Tsirkin wrote:
>> > > On Thu, Dec 19, 2024 at 05:24:11PM +0100, David Woodhouse wrote:
>> > > > From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>> > > >=20
>> > > > The system GSIs are not designed for sharing=2E One device might
>> > > > assert a
>> > > > shared interrupt with qemu_set_irq() and another might deassert
>> > > > it, and
>> > > > the level from the first device is lost=2E
>> > > >=20
>> > > > This could be solved by using a multiplexer which functions as
>> > > > an OR
>> > > > gate, much like the PCI code already implements for
>> > > > pci_set_irq() for
>> > > > muxing the INTx lines=2E
>>=20
>> Just curious: Why not use that aporoach? Could
>> <https://lore=2Ekernel=2Eorg/qemu-devel/20250108092538=2E11474-5-shente=
y@gm
>> ail=2Ecom/>
>>  help?
>
>That looks very similar to hw/core/or-irq=2Ec which rth pointed out to
>me=2E Is there a reason for both of them existing?

Thanks for pointing out its existence! I totally expected it to exist unde=
r hw/core/, next to split-irq=2E But it resides under hw/, next to irq=2Ec=
=2E=2E=2E

>
>It would be theoretically possible to rework the x86 GSI handling to
>use such a thing, yes=2E
>
>It would be a large yak-shaving task which exceeds the time I currently
>have available for a bug fix, but I don't *always* let that stop me=2E
>
>More to the point though, I *still* wouldn't like the outcome=2E I still
>want us to have a 'resample' callback when the interrupt is
>acknowledged in the interrupt controller, to see if any of the inputs
>still want the line to be asserted=2E
>
>That's the only way to handle it efficiently for VFIO INTx and for the
>Xen GSI callback anyway=2E

Good to know=2E Thanks!

Best regards,
Bernhard

