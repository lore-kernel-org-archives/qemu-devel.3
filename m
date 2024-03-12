Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A249C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 05:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjuG4-0007kI-No; Tue, 12 Mar 2024 01:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjuFp-0007jj-79; Tue, 12 Mar 2024 01:00:45 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjuFl-00006I-RU; Tue, 12 Mar 2024 01:00:44 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e56787e691so4069466b3a.0; 
 Mon, 11 Mar 2024 22:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710219635; x=1710824435; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LE3qelXEvIBZTwy861HMsGltqDCoKADsEHL8U3k2b4=;
 b=h02/jedQFDAvxuFE9iGAppEr8G3kPt1ZHKaayu3cGRXjy1v7y1N1QYlNBSaoruV+Hz
 7rQKuSn6Lz2x/DOsDB/I3/CMGXE3lKflfcqJ6aWu6ZhnmixX+IKelw33lXCwj/Tt4eNG
 y7rSdnSoJUg2hFrMjucB3vR948A33/GXeefCEhcz5KemJKlWLPHv0kGviOpJaOt9LSWc
 9a/DyY+/LAv+matngITI+Y+9wqFQWhwszFLjvur77K4szC2B+l/nGO50Q6Al8WW2Mg8m
 HDLgDCYtqVrnzYpn8MnMqanisBMVIIksWDUuyjFavsaxp4iR7HdIQEX3qGiP4k6K3OnV
 cNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710219635; x=1710824435;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2LE3qelXEvIBZTwy861HMsGltqDCoKADsEHL8U3k2b4=;
 b=pdCy2PtMjACZp08dLgB2nv0MRgU5n80sGFS4ePpNsKh6m2zrGi/s8niZTfYgKxF8Yu
 BBdQo/jgVkzHSYurPdRyNla656EZFFVoj632vWerf0sJLnUToJouVrwv/pHYZGyHGESe
 Z5JNnm4sQghPxrkPo1oIzWNNWmkgvnfVMrlSOqgwgkbMrIeqldxkWHa+TZGUmvPntR4D
 1i5xZwaE1+JiYdBb99aaJgdyvhq2u/i6E+8MjeV+51++jtYK4YEPWsGLIoJ+7Cobxjuo
 HeU+lXTeuS8VSBvKq9ne4h9sXdm72xX90Sg/PFBDCgp5mSXjijv/hFT9v0xw4v2ms4G3
 1mMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4m5qQCjZgiUZSHt+R+12Ei8DKbs1rpboiMYZ4PyzFpw60yRZtXnMZgB3lK/YXn19ut1X1cwIcm8mad2pBv7h6OG9SEbvPZ+SZC+dmCw73ILISaqD4CzPYC38=
X-Gm-Message-State: AOJu0YyjNOU2CeBkvBjRzuHIZPjIuC16d9GNo6inCwZfN6KqjqKWGkoC
 3uWJli4gASA1cyfbnipk7T9oCfYlZkQc7BILsmOMFPKAU8vefr/CqiTxy54JHmA=
X-Google-Smtp-Source: AGHT+IFN+BXKH1OZ1ErtE2ySA/Zwgf49hwkZ+fXjXiOVh96raTvGiNcFQwjYMb2MiipTen6Zt+tXmg==
X-Received: by 2002:a05:6a20:548c:b0:1a1:879e:9b33 with SMTP id
 i12-20020a056a20548c00b001a1879e9b33mr9720669pzk.13.1710219634646; 
 Mon, 11 Mar 2024 22:00:34 -0700 (PDT)
Received: from localhost ([1.146.55.44]) by smtp.gmail.com with ESMTPSA id
 v66-20020a626145000000b006e6450ccac5sm5431279pfb.126.2024.03.11.22.00.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 22:00:34 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 15:00:27 +1000
Message-Id: <CZRI9EL3X0N1.3FAKS9QW4G9CW@wheely>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Thomas Huth" <thuth@redhat.com>, "Harsh Prateek
 Bora" <harshpb@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2] spapr: Tag pseries-2.1 - 2.11 machines as deprecated
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20231214181723.1520854-1-clg@kaod.org>
 <f3e1fefc-0df3-4339-8373-7648597a78d0@linaro.org>
 <Ze9T64dA2H-LlePV@redhat.com>
In-Reply-To: <Ze9T64dA2H-LlePV@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue Mar 12, 2024 at 4:56 AM AEST, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Mar 11, 2024 at 06:46:53PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi,
> >=20
> > On 14/12/23 19:17, C=C3=A9dric Le Goater wrote:
> > > pseries machines before version 2.11 have undergone many changes to
> > > correct issues, mostly regarding migration compatibility. This is
> > > obfuscating the code uselessly and makes maintenance more difficult.
> > > Remove them and only keep the last version of the 2.x series, 2.12,
> > > still in use by old distros.
> >=20
> > By the time we get to QEMU v9.2, will pseries-2.12 still be used
> > by old distros? (which ones btw?)
>
> That's the wrong question really.
>
> Machine types are there to facilitate live migration, and by
> extension also handle save/restore to disk.
>
> So the question is more which distros are likely to ship
> new QEMU 9.2, and also still need the ability to incoming
> migrate from an older version of their distro where 2.12
> (or a downstream equiv) was a fully supported machine type.

From Cedric's list, they are ~2018 vintage. I don't know if
there is upstream policy on this, but 2025 seems reasonable
to remove support for live migration from then.

Thanks,
Nick

