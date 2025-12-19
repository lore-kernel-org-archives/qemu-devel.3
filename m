Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECECD7495A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 06:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWTuR-0004Gk-Fl; Fri, 19 Dec 2025 01:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajaygargnsit@gmail.com>)
 id 1vWTuQ-0004Gc-0N
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 01:24:14 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajaygargnsit@gmail.com>)
 id 1vWTuO-0007er-HK
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 01:24:13 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-59583505988so1997105e87.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 22:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766125450; x=1766730250; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAWQOPHI+WBur9sUSKJakJodjiC8otpU2/f3VX456fU=;
 b=aP+4IlMoR6dLckU9s1EIIJ9IL/N4kkpaEijpnrKsUUujjTF8cArRuxHg71wX3JfXRy
 kWCl9Gmz1P8QbZNvZ5gtiHjAbd2VV0US85DIqvlwYDGa3DGqBC/1DU7GOOIRJh7LSzt1
 gcO4tE42GnoUAezaWvzwLeKheIEhlGF+0Zk4PjmeSuBNHARviPc74kuxOgq7rE01O9NE
 JmvCZ9vAPipTQ0AuoQMoRXihW9ofK+f64inR68SQ0V2Ade615mg5kVoc7oCLgwYiMQoM
 Ck3PcbFHQPPo0hpUrd/yltpqU6P0BpUXT1u2ngfYfEXGnhfaKbUoVDCCVIiilIoPLpuF
 Ah4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766125450; x=1766730250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XAWQOPHI+WBur9sUSKJakJodjiC8otpU2/f3VX456fU=;
 b=KQAfXFPjBpwW9a+YNjel5pRYHb2P8nVcfSvPm7mWhZtlS326EaSAsISiSBoROtuPvC
 W27iuZAF0GN7QcNgQinMBKwgIqEr+tiY8Y60Ou+oYjYvCZxHsmpAIFJ5qsny+92FErz0
 3C+pE+8NFSgMcgyS4d9gCAOM9QKDiGvqjKtkwv4V3bm6tVFKw6w+yomvKX5qiv9A9aXc
 yjUs8hu891p27NvjY2nRiSZBZrGxi6Xl9WYX6FPLiXwJUcDdBYDBxONwEDnOCqZL5VUF
 fKZTBqPgyFI8MsZv3s01ryciteHX7TOYaiqdBrP0iS+MInqq/rRsdLAhGXQXbpYh4Kae
 pnGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9pjyu3F5IJLO7a8KqmdgRczT0USccpOyq+MzUkdcE7O4Yr1Cm/AdSmSElt0wyMo3fiKlBI3/N+lOX@nongnu.org
X-Gm-Message-State: AOJu0YxwZOw+CF1K4RBHz8TxwEzO6WmEVCfkSVRfJaCADwVzTa69YdC5
 TnkyEadK8texFrkMlh5pL5sle1kegFcpbQDD82S3esysmXT+7Y3UtGQSVJJc7N5mG450rrrx5ok
 6oeqo8c8xjPAP67PkRqgVxC4+jVgPmHI=
X-Gm-Gg: AY/fxX5RVaKr4wi3eOXJJBPQtJn1gP6MEq4odPh97unKNsBX6e51oUex5fNO1DtoRYa
 bZbXQriF8Qu+fpuq1hiMlNlwAAHuN/a66+bbk/rU7bi2ACio5f3R05KkVTlyEdkhEyN44/Oi4Ju
 u8XqKbUmX3+05kdOW3TpCa1MXw7zuIAnl4Eyfrm3t2cA/wyE/vDmBmeE3fjU4wiv7ZwLvm41qLj
 kj/BCnMReRSFLAkvqKeLtCQL3HYjJLjlxTwQHyAE06akHqKD1fu7Y86y+Bk5xNa6OYAgyjxjQ==
X-Google-Smtp-Source: AGHT+IG39OQjwLBbQlGXdvI2kB58X2CZX464R4UmGvJTXolSZNqYm3iCf7S8/7Js0XD64zjpGJhfemP/i60fFr7ibO4=
X-Received: by 2002:a05:6512:2256:b0:598:e2a1:acda with SMTP id
 2adb3069b0e04-59a124ebdf6mr1891409e87.10.1766125449509; Thu, 18 Dec 2025
 22:24:09 -0800 (PST)
MIME-Version: 1.0
References: <CAHP4M8Uy7HLiKjnMCdNG+QG+0cizN82c_G87AuzDL6qDCBG5vg@mail.gmail.com>
 <20251215045203.13d96d09.alex@shazbot.org>
 <CAHP4M8WeHz-3VbzKb_54C5UuWW-jtqvE=X37CSssUa5gti41GQ@mail.gmail.com>
In-Reply-To: <CAHP4M8WeHz-3VbzKb_54C5UuWW-jtqvE=X37CSssUa5gti41GQ@mail.gmail.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Fri, 19 Dec 2025 11:53:56 +0530
X-Gm-Features: AQt7F2q1nf4Dstbm1IzyittrsqPG3RefuBbQcL9mL7jcHlLZu1idSosVvvP5p2s
Message-ID: <CAHP4M8X=e+dP-T_if5eA=gccdbxkkObYvcrwA3qUBONKWW3W_w@mail.gmail.com>
Subject: Re: A lingering doubt on PCI-MMIO region of PCI-passthrough-device
To: Alex Williamson <alex@shazbot.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=ajaygargnsit@gmail.com; helo=mail-lf1-x133.google.com
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

Hi Alex.
Kindly help if the steps listed in the previous email are correct.

(Have added qemu mailing-list too, as it might be a qemu thing too as
virtual-pci is in picture).

On Mon, Dec 15, 2025 at 9:20=E2=80=AFAM Ajay Garg <ajaygargnsit@gmail.com> =
wrote:
>
> Thanks Alex.
>
> So does something like the following happen :
>
> i)
> During bootup, guest starts pci-enumeration as usual.
>
> ii)
> Upon discovering the "passthrough-device", guest carves the physical
> MMIO regions (as usual) in the guest's physical-address-space, and
> starts-to/attempts to program the BARs with the
> guest-physical-base-addresses carved out.
>
> iii)
> These attempts to program the BARs (lying in the
> "passthrough-device"'s config-space), are intercepted by the
> hypervisor instead (causing a VM-exit in the interim).
>
> iv)
> The hypervisor uses the above info to update the EPT, to ensure GPA =3D>
> HPA conversions go fine when the guest tries to access the PCI-MMIO
> regions later (once gurst is fully booted up). Also, the hypervisor
> marks the operation as success (without "really" re-programming the
> BARs).
>
> v)
> The VM-entry is called, and the guest resumes with the "impression"
> that the BARs have been "programmed by guest".
>
> Is the above sequencing correct at a bird's view level?
>
>
> Once again, many thanks for the help !
>
> Thanks and Regards,
> Ajay

