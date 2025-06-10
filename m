Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F91C61DB2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 21:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP6Fk-0002ip-Sp; Tue, 10 Jun 2025 17:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uP6Fh-0002iV-Bb
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:11:25 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uP6Ff-0007Sm-HC
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:11:25 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ad89333d603so1031821966b.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749589881; x=1750194681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=oVx3wDJ8sl+RfkrE0E81kythuCLhR7r6OvWiIKgGcPg=;
 b=mWmmh4NTPAGIdHj8MwLYTAn3mpaD78x1rqBXprBxUhc4Imh2TpQSwNgJn1DkROgqbP
 hS5GfIWeQPlPsqHRuw6tFyi3dLdR8L9pw9R6aWWOBGcg53eG2MIBaHz7H7aWSzv5HqPl
 /xgknwiEqOe1uHkz7EOsYUWeB8/PPG7Bnp5ldFauTGIsAGc0e7fQy7SxKNVOMVD1zyGr
 BabvG8+f/nqkIwXmFBnZTkF8nvJYj4pyGLH6eiMmA4NTJf1Jw0N7i4zYAjMA7W8xG0zs
 NRcd3b1dlYM25vMj2RFA9Do1KGGTxOe8xFVpN1zyuXptOnOTbx3yZ8w3TJyGOOfE2PMi
 aIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749589881; x=1750194681;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVx3wDJ8sl+RfkrE0E81kythuCLhR7r6OvWiIKgGcPg=;
 b=WVxTHNoVSFEiKlvrhwqPMpggQCqCrjLXrj2fwi9FBd1c6fXL4ns9D88u6LFu6VVr9L
 dJZSbAVC9RelZz/9N54Yz+rKBPGlWd1YZddjrth9B68LcDKo6Xm9uEwXRvzzaon+cqdx
 LyUxHYljMTYl99OtRdQ7rUqyiYSB5FXEPTXeFXeZKkS4VFzsq/SBR/wKqZYGGKpsPRmI
 tMjz7iPS9oauLFvNQhMUeJhcNsLzokNIQEpAeFabrooXWxpOJYN5Ulf/adBDrJHu3B3K
 eDJAPSrqx9+ILITQxDBdGpTSHXAIjMjUGyxgmfFcOqfQZPvYIQbjEH4Rhu7E1NNR4mnc
 bjow==
X-Gm-Message-State: AOJu0YwDfngJq1xQp7M5LjoOlYLubQmrQGqxPjDXnK1EjT2Mu9Dv2SqY
 dqTsHWP1i/u2FaIgtkKakJWMOcx3ih4Yvlw92CV6x7NQGkDc2o9mzFOBq+RzpQ==
X-Gm-Gg: ASbGncvKJ1o9AsQ8NnM56hha8h4BeZM75VNyGbbJQE33VRlanRJMMvHdCK5ohDGz1S/
 Cx+sE1Z8HFJ+qQ+gi8w1VXEY/O3l2CO4EOsMAeZ8pcjQ639mnMXX0AvLyz8QyASlXbW/b55Yc+v
 WzgvGE4IYPyIufLY2odJiBRhMUXoKaB0AHl5HZaGpiV5wzVIlIAMGnDDMrOouuiVVCE1Vd0Xpw4
 ygafnz++yEYEFi9/2C3ygkUJYdFya3+uD9je+3zEAJhR/7j/SjBz88LBbXrqn+JpuhA+sx61miX
 EGSDZcfniOz8YVAD/LZn7kNazniahQ30NgNDgPJ0kfagI87HtlgTjc6mPy4dZhQ5iOiAWHUDL+e
 CCeOAhRf2meme75VMGl+xxjKMx/ZqFvBkaI3/Y/0=
X-Google-Smtp-Source: AGHT+IFQJgRdN6Bzt9DD1pw2rY+r7tvxvwyHMpb+POm32PaLYGn21FZuTwZa90wgjxzZNfTGC8wrRw==
X-Received: by 2002:a17:907:1b02:b0:ade:865f:481 with SMTP id
 a640c23a62f3a-ade893d47b1mr93260266b.12.1749589880966; 
 Tue, 10 Jun 2025 14:11:20 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-183-237-205.77.183.pool.telefonica.de.
 [77.183.237.205]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1d754180sm784734466b.9.2025.06.10.14.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 14:11:20 -0700 (PDT)
Date: Tue, 10 Jun 2025 21:11:17 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, PJ Singh <psingh.cubic@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_Embed_QEMU_terminal_into_GUI_applica?=
 =?US-ASCII?Q?tion_=28Cubic_-_Custom_Ubuntu_ISO_Creator=29?=
In-Reply-To: <CAPUuJsMOHWQW7bb9_S0Ofj-t840A3mMg+nD57hceASktkbSGhg@mail.gmail.com>
References: <CAPUuJsMOHWQW7bb9_S0Ofj-t840A3mMg+nD57hceASktkbSGhg@mail.gmail.com>
Message-ID: <765AA206-A2EB-4AD7-A13C-F875FEC73697@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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



Am 9=2E Juni 2025 17:22:32 UTC schrieb PJ Singh <psingh=2Ecubic@gmail=2Eco=
m>:
>Hello Everyone,
>
>I want to embed a QEMU window directly in my GUI application=2E Are Pytho=
n
>APIs available to embed QEMU into a GNOME GUI application?
>
>I am the developer of Cubic (Custom Ubuntu ISO Creator), a tool which
>allows users to customize Ubuntu and Debian based Live ISOs=2E
>
>Screenshots & information=2E=2E=2E
>https://github=2Ecom/PJ-Singh-001/Cubic/wiki
>
>Source code=2E=2E=2E
>https://launchpad=2Enet/cubic
>
>There is a terminal window (
>https://github=2Ecom/PJ-Singh-001/Cubic/wiki/Terminal-Page) in Cubic that
>allows users to make their customizations=2E However, this is a chroot
>environment=2E I want to replace this with a command-line emulator, so us=
ers
>can make more advanced changes that require services (such as snapd) to b=
e
>running=2E
>
>The terminal in Cubic currently uses the Vte=2EPty class (
>https://lazka=2Egithub=2Eio/pgi-docs/Vte-2=2E91/classes/Pty=2Ehtml)=2E My=
 plan is to
>replace this chroot terminal with a command-line environment emulator
>running the Live environment of the OS being customized=2E
>
>Is something similar to Pte=2EVte available from QEMU?
>
>Would some kind person point me in the right direction? I would also very
>much appreciate some tips or guidance from the community to help accelera=
te
>my learning process to achieve the above goals=2E

QEMU allows for redirecting the guest's serial port to stdout by passing `=
-serial stdio`=2E Does this help? Note that the serial console might not be=
 on the first serial port=2E

Best regards,
Bernhard

>
>Thank You,
>PJ

