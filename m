Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2591C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 00:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYx8L-00033l-O0; Tue, 30 Jul 2024 20:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+9b7d078e8d5cad6c9dc8+7647+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1sYx8I-00032P-V3
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 20:23:59 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+9b7d078e8d5cad6c9dc8+7647+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1sYx8G-0003CB-T3
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 20:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=MCfZzu/Zb167LDSknfh0f5ldOCFmlwtCFytjWOKDDNw=; b=PEZus8OqLbndzuECY5Wt4+8fLp
 c8onVwIfykgg3hPSzCVDiU+gt+bA1agBxbUjlnQ4SkUjd9lHI0tTTLiFS+yXx1bSLm1MrXNVzB9m6
 xqt1TooVxG/9+bvEg8D/ZRnMmYhZdtMnv/07OX0Ovd7Zf9+c60DFkYqq253MzOBw2wkudR2BCvQbq
 InfDayzhWE+oaSm3vnxEjP61oAWMtnH2RStgMb56uE1tU3hC+6Uly3WN+nyBVDKO3dEieknfodyeE
 F7JRTPgi/KZOAn0TAHJh6A6lFYz9zV1UOZ/wkqhJd1LaeuTekqk1GKgnUlS0fV2wUWotnPD0+8x/q
 JCdMonuA==;
Received: from [2001:8b0:10b:5:2578:de2e:8ea7:a187] (helo=[IPv6:::1])
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1sYx88-000000056RW-1N9Y; Wed, 31 Jul 2024 00:23:48 +0000
Date: Wed, 31 Jul 2024 01:23:49 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Subject: Re: [PATCH v2] hw/acpi: Add vmclock device
User-Agent: K-9 Mail for Android
In-Reply-To: <20240730164434-mutt-send-email-mst@kernel.org>
References: <bc85aba60523e0d63e760d5143c5cb57688779d1.camel@infradead.org>
 <20240730135143-mutt-send-email-mst@kernel.org>
 <546A904C-FEEB-4365-B7AA-CA4E3D03300C@infradead.org>
 <20240730164434-mutt-send-email-mst@kernel.org>
Message-ID: <9811E311-F599-4B2E-A3C2-5233D6F2D485@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+9b7d078e8d5cad6c9dc8+7647+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 30 July 2024 21:45:53 BST, "Michael S=2E Tsirkin" <mst@redhat=2Ecom> wro=
te:
>On Tue, Jul 30, 2024 at 08:04:17PM +0100, David Woodhouse wrote:
>> On 30 July 2024 18:53:18 BST, "Michael S=2E Tsirkin" <mst@redhat=2Ecom>=
 wrote:
>> >We don't want to manually sync headers with Linux=2E
>>=20
>> Indeed=2E I was briefly tempted to fake it, but figured it might get lo=
st if we subsequently do run the script to automatically merge from Linux, =
before the guest driver is merged there=2E
>>=20
>> >I think Linux abi should live under uapi=2E When it is there, we can u=
se
>> >=2E/scripts/update-linux-headers=2Esh machinery to import it=2E
>>=20
>> This isn't just Linux ABI=2E It's intended as hypervisor to guest ABI t=
oo=2E In the fullness of time I'm hoping it'll actually be a virtio header=
=2E In the meantime, best not to overthink it=2E It's fine in hw/acpi along=
side the device itself for now, I think=2E
>
>This is exactly the same as e=2Eg=2E virtio=2E We use Linux as a source o=
f truth, it's
>easier to share with other hypervisors this way=2E And UAPI and hyperviso=
r
>ABI requirements wrt stability are mostly the same=2E It works=2E

Perfect=2E So as and when the header is in its final form in Linux, it can=
 be part of the automated import and we'll use that version=2E At that poin=
t we can drop the one that's sitting alongside the device itself in hw/acpi=
/=2E


