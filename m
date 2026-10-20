Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CBC60A2613
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YTT3sVhM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ6oB-0007Np-3L; Tue, 20 Oct 2026 06:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ6nz-0007N9-49
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:10:54 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ6nx-0001UA-CY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:10:50 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8aea7b7ca0cso22466987b3.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792491047; cv=none;
 d=google.com; s=arc-20260327;
 b=jMhzFNge9qQT6p+9ULVGggKVrz2H/2WEyWDKruLBK6ZS9Sfa+bvu62r4NZ5NkgQmxc
 EVJtCQOJ0x2J9sSmqjUDbWgJBbPtV8slxIQc6Txon8CPZXmC8kYIXaEdAh7jKMnVtMz7
 QuNgb6DHd5W4n8R6E8VAQyY4QeGIyr/fIWW2okLUflhzV8yKqnHceF7dDQ4XFAoobwAa
 N4XR725C4ZPgot5GH/e69gYiqvYvziQ4xCOvgVOwx3Lq1mPtsHmaUIUl9jn13/nFQePC
 Oqk6HJkulK+JtIaZtKoQEGZA9n4YCPDhcXviH4xZtpaWxEdljWUBly1PBEVVW+0EbN4+
 Vexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XedVSjkTPy5bjNGoI+CW31BMOMIfe61DP3t5o5HQigY=;
 fh=tQZ+xTFL6XoKLY7Au6qVwff0MT6PcYmZNEh9dneINIQ=;
 b=GYFH1kH4gc7MTIR+4Bj0JVpfAOGT2VuJCo7YsSPccCcYK+k3AyO/TUNYADVG7gMsbf
 6Z0N93nr5YPgJQmNFhlwQAuMfJ4wSfEEPR9S23maaQNnfc7HVh2kHYHNHAOPWTyTn8v3
 mhIl6eCSRHkJJ+q1tAZ5jYgTSOvLv24hJgxQfITrvubnNZMwuv5RTuhGDjX4W/eZzJbs
 LoNLooqdSoXl2RrOUgTiGMyjh+S+uIm598HGt4Z9uqobAVrdh3jYwhS9qczn9SnS/r5j
 n89yk2uNprmX1ZKMgjyFJ2LedQMQep5kcGEa7pkm+0V9+ulxwkZtIkTvyy41L7FtAwRC
 kTOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792491047; x=1793095847; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XedVSjkTPy5bjNGoI+CW31BMOMIfe61DP3t5o5HQigY=;
 b=YTT3sVhMFRtGIc+DFa2w4XeWESW/Cds/FUZiZgDUWswuOzFznP6rJtuHfkih8TPC9z
 Ab/Kqj+JQxJfhVayytvX0axP52UnBlIDXHVy77q7heG7xxAtubQlD2CK8COpW2P/Q7W7
 HfmAyxkN5J8mB0TrvYhyiHagVMdK75yJaEWUBji4jsBJjGn+BnpkBBO4fElflVLtknmC
 +LNMGhL63d0tnLq1qdkLUS7JI72Qocy+E01K+xCiayvFCBAO9g8XOEvx3AeiQM3mPjqn
 +Y8GFqPEdaO+9QK5RtqZa/bZDAK7REqGuWIX6Yjftgc6M3b2jFKhBtgO1NcMxPRDOyVu
 hGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792491047; x=1793095847;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XedVSjkTPy5bjNGoI+CW31BMOMIfe61DP3t5o5HQigY=;
 b=p1zb362JvONvMxnljgfcgytydEmnkeVzt87PLcFVejxBVKBmzQb8LcocW8umcLQeyv
 aEU3XtuOFylE9xFflRFgHZomTChnSGecuytFHKIcGirVN3zWOiHz6yyiSaRZwgjaTC2Y
 cbITNXcGkaskuLa9PLWf1OcsA5upQAv5C4msc8rAn67OhK0wRpDQ3gOWjRvENge45kYD
 38UwMr2BJurNrUMxwk3TlhXBOPkxZpxqZhI6AWyEuIQ3aa8qMzD7EU5EyzjMQFWh4Uik
 PQI5t8ing5VfiN78zTp77KDc6bQET1KI7ZGCfz6oGK9Qy8LxsEqSdCRL8ZAsm8vsWq7D
 bOxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByF74w1feVSieJmlHgX8KFgOT98/ou7rBmzXvmmIq87mtqWSfWq9GPJnLqx+SgULV7lUUF2MGyPzTBT@nongnu.org
X-Gm-Message-State: AFq9FYKVdp7JUGupiaqe4B6S3VTLlX3aC68Bs+3Sm0H/YKv5tuRojhkh
 85S5e1kEUvg1KeuetXIZOByPGlK3fTuVaB2x3UdcFib4cRrtrQ+i/EMPuJbNj1HkRtzpoXA4wXO
 ofZ4ZFidpVrqPnOjexTykrROi1sNI65fH2BFtr7P1sg==
X-Gm-Gg: AYBFou1O/Oq2YTSShZytZptN6OYIhlSSkNdlkXCc7hhsYuAgB1AXbvuCcEai/jIjLua
 rv1fHNlJZq1ArT3EeRY3PHRmUpLMRNWXPpQGb48fHFMb41bMIzmwHd3B06Z+fgnMftX4lsXYgzJ
 GznqnTI/47IdUUrV5USm+HFW/WwyglzdfMLCowG1Ug8UB/r5osEk8fzSsYNcgiO5oEmWv8iNDUy
 LItIPtSJmffRvhTVUYoacetKQv9uPd/TfIYk5w7/RoD8kRT3rTKlEgYYxg7XUhTWHdQLCL2vhxc
 UiE8nwMiszP2JO8qGSEXCNUuSIIUHIPgbIYcTJTIwyyD1VwVCMSi0G2tC4z0Z0BzizteJftTQMR
 q6kI9SY3HVg+45+pvS/xiJdoysLh6VqTXXYdzDpI=
X-Received: by 2002:a05:690c:fd4:b0:8a6:1205:12e8 with SMTP id
 00721157ae682-8b0f219f587mr40737057b3.44.1792491047373; Tue, 20 Oct 2026
 03:10:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20250929165230.797471-1-clg@redhat.com>
 <20250929165230.797471-17-clg@redhat.com>
 <CAFEAcA8OKABUH8S_F4HrWLKDC9XYqWGxD5_xMAPOPmc614u4UA@mail.gmail.com>
 <de908487-9d6b-48bf-b2ae-3b645d0bec36@oss.qualcomm.com>
In-Reply-To: <de908487-9d6b-48bf-b2ae-3b645d0bec36@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2026 11:10:36 +0100
X-Gm-Features: AclHuK887vqIPhEhWN7aYM8cZ_jyHtcgzZXHJS3A-txkdNIvR5Tqs3ygF4QCyIE
Message-ID: <CAFEAcA-dpL07+04immSxFyYvPon4coYeAijNw6NqEHikXuH82Q@mail.gmail.com>
Subject: Re: [PULL 16/32] hw/pci-host/aspeed: Add AST2600 PCIe config space
 and host bridge
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-s390x@nongnu.org, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Marcelo Manzo <marcelomanzo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 at 02:05, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 2026-10-17 17:44, Peter Maydell wrote:
> > On Mon, 29 Sept 2025 at 17:54, C=C3=A9dric Le Goater <clg@redhat.com> w=
rote:
> >>
> >> From: Jamin Lin <jamin_lin@aspeedtech.com>
> >>
> >> Introduce PCIe config and host bridge model for the AST2600 platform.
> >
> >> +static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void =
*data)
> >> +{
> >> +    PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);
> >> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> +
> >> +    dc->desc =3D "ASPEED PCIe RC";
> >> +    dc->realize =3D aspeed_pcie_rc_realize;
> >> +    dc->fw_name =3D "pci";
> >> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> >> +
> >> +    hc->root_bus_path =3D aspeed_pcie_rc_root_bus_path;
> >> +    device_class_set_props(dc, aspeed_pcie_rc_props);
> >> +
> >> +    msi_nonbroken =3D true;
> >
> > This sets the msi_nonbroken global in the class init, which
> > is run for every type compiled into QEMU at startup. That means
> > it's effectively forcing it to 'true' for every machine type,
> > whether it's aspeed or not.
>
> TYPE_S390_PCI_HOST_BRIDGE seems to do that since 2015 in commit
> 8cba80c3a0 ("s390: Add PCI bus support"); why isn't it an issue there?

It is in principle, but doesn't cause a problem in practice
because s390 only has one machine type, so there is no situation
where you're trying to run some other machine that shouldn't have
msi_nonbroken set to true that was compiled into the same binary.
We should fix the s390 case too.

thanks
-- PMM

