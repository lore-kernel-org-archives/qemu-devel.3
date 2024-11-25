Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481EED58D53
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFaAU-0005ld-PA; Mon, 25 Nov 2024 09:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFaAR-0005kt-Ps
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:34:24 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFaAP-0002XP-9s
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:34:23 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f75c56f16aso51451701fa.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732545258; x=1733150058; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L13NRCkyqi0c2bLphchlHQO/5yzR5oeo9xAOVXdqqPk=;
 b=o2YWXFBOjm/IBxrBDpLz27I/HSV5n07zPvr/3do3IHoZcGUXHIX/0tHbqfniJ0Byf2
 6MGeWdY2DWjeFU14wUbgjIm9w7YZFuSxKT0/+VOegn2GE9JLuCuiJ5as1Ly/Nl6fDDRX
 z0n1b21GesHIEkiOpgKI2dTrwPzaoAiZpgHu4AXkfsO1jMd6eRzkdmId4J7ZZu2HslHn
 POUhbxlZz862oL8sRnMizUb3/xWMN9qpUcsKuto1KJXd0PJU8KM1fNnHE4KPwzj14ICd
 R8wF/eVKrO09w+ozLWnRnHuqVsHvPhhYyQmSzyRv0l4z8P7dnQqZhea6GoI4+XfK3bb7
 M5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732545258; x=1733150058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L13NRCkyqi0c2bLphchlHQO/5yzR5oeo9xAOVXdqqPk=;
 b=Ve1gl/Rt08nouOw/JmMgDlX9npcMmu5myX7DjQFx+MfZf6OG0RL9BCpqobbvgwsLfk
 GwNS+XWxAE9YH4F0v6oQzrCxAW1O9Bt2dW7L1xlZZLfDGfazYXXfn54xXYxibRCu1kLH
 j/P6xCSFB2JrEoJIuVxx78HrwKRXa4RJvldyk4N799bZZvHxGWHsa51FLoDB6v5WQjSe
 Ea5t0hktfFRst5eMZL8R+m9ZXbe0gDe1QbtIaOCsh4YbeW5BrVuDo2HIYWSHLXX6ytMm
 RJpj2T7DlLgeL24MAMQfCefULk3aWZg4Nq6VlUTu5e5G5oPvGb0yKOPfc3ALkBhX0YBp
 GuBQ==
X-Gm-Message-State: AOJu0YyVKMgTd8aPFTFvzFQi6WsNX/kLcPAQsOFnslWBhYwg6g9d4xSA
 H8gOXGzHQxJd3YWRGIn+fU4xlXQ/Pwto5RyCGAby+1jk4TGlwTN36B79ZH9kTthsCxYcgR24BPo
 l0BHejRKJGy1IpT2TzWHRv4wBJp5jDHdxX2f+/g==
X-Gm-Gg: ASbGncs7BLCE46tpb2ohm3f/4Hyi3PSX68yXfnBO4pVqvU2t+8JvyIq3HHLtzfr/MJm
 ljeKeJV8EYnwVUsop3ItTy5M/kKMXwbG9
X-Google-Smtp-Source: AGHT+IHRMdsrcynQ/wjLs4B6s4qayygZf+l418D7YqV74ot4oS3qMfFBiiYjxSyU1TgsMR9ye/mDPsqvzWFC1zTD4MM=
X-Received: by 2002:a2e:a551:0:b0:2f6:6074:db71 with SMTP id
 38308e7fff4ca-2ffa712ce91mr63772451fa.17.1732545258234; Mon, 25 Nov 2024
 06:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20241125140535.4526-1-philmd@linaro.org>
 <20241125140535.4526-4-philmd@linaro.org>
In-Reply-To: <20241125140535.4526-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2024 14:34:07 +0000
Message-ID: <CAFEAcA9hW6yBt9w3+2RDBovP1pNreBcvW4N7-6Kq_Gohvtv4eg@mail.gmail.com>
Subject: Re: [PATCH-for-10.0 3/8] hw/pci-host/gpex: Allow machines to set
 PCI_BUS_IO_ADDR0_ALLOWED flag
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Thomas Huth <thuth@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Mon, 25 Nov 2024 at 14:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Expose the "allow-io-addr0-accesses" property so machines
> using a GPEX host bridge can set this flag on the bus.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/pci-host/gpex.h | 1 +
>  hw/pci-host/gpex.c         | 6 ++++++
>  2 files changed, 7 insertions(+)

Given the way the gpex controller handles its MMIO regions,
I rather suspect that none of its users really need to set
"no address 0 accesses", though of course this is a behaviour
change for some machines so would need testing.

-- PMM

