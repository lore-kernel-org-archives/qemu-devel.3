Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9ACD3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 13:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSxif-0000eA-0q; Tue, 09 Dec 2025 08:25:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1vSxie-0000dx-02; Tue, 09 Dec 2025 08:25:32 -0500
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1vSxib-0004e5-Rf; Tue, 09 Dec 2025 08:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1765286708; x=1765891508; i=laurent@vivier.eu;
 bh=yHnwzxbKlGx0GXOjLNaYpIY9URjBWpMGxPSeSy1oIWQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=0o14E4FW2cMIzJsDOq9AJC2D/BUFBUk2JScsvlPqkZ28QVfUHabjqO4sbiNYlVIa
 oWLGdmzMEdlWA15aAwD0bxFZ1eTYpH5rsJuk7wsSX3kMASQG4/j5DJgKTnatlepxY
 Ipv68AE8AKqfPcfw9FbbaAZw8GeDCptJU6L0fX3g/rqBli1X6V1aEUnTuFjH5UAHZ
 AsWsstIpD3IX6Bs1Zdu61Uj/LuWGQ2ZqWTRExMH8eUa11STK5D8TtJBeO25qtLIge
 yxYf7VDS+A/jFvpeF/a+vkY+/17ym1GoxGxcN2hhA1u2jpLUEXSxaJtjHeXNMf9J8
 0AcVQhN6zVVy9UETiw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N5G1T-1wCVg90hXx-010EeW; Tue, 09 Dec 2025 14:25:08 +0100
Message-ID: <f8c3e5e9-18e4-4b57-976a-3abf0af99c62@vivier.eu>
Date: Tue, 9 Dec 2025 14:25:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2] Fix typo in documentation
To: Stefan Weil <sw@weilnetz.de>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20251209125759.764296-1-sw@weilnetz.de>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20251209125759.764296-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qze/zKPLUajLAxTCCWpyfglmGySvq27jK6sJGEUxhJaIA5/wSRm
 i7jvt3XOZwmoVuXShIRplSGKReI0Nk12tqIw2zKzHoXBFOM/VBvJjApFczuVqN93vb2IM4d
 n2PJyK2bp65Zpdg/xMZ9BkpHeyDzFGfDgTwWDfZGYpsIvCNBZAYXzzcY81kbBJmSLmYcGDY
 kkDcPdki/W/CMwBpuWDQw==
UI-OutboundReport: notjunk:1;M01:P0:gAnJU17/IOc=;tel3w+RygfFDaXqCzIh0eYJFy+N
 x9gEw5AWpTuO3tu3sufncBBeRvFAdLyRre7+yNZ9Mr3wYGZCGufTX2xXZ2/QvNsd2FnkmpkY6
 XbWd1kvmAWtnL6rwQEpxuxk78k6LOYDtRGlCuG6HueR0DnuYKDmggMQ6DnsiWk1fMXPWdtk4U
 PZyoxX60wjwI/fmaPsUAy1KYM95WW4YKMeabHqYI2c38UmyvoPzvtbS6QfNjpIG+S680DOfJN
 iqBT6mwyjQhUiA6awWAjPB7Zm7EuBRx9T97QNLtsD34lI1BVrl43ZSi/RlTokGIeZ8eNts5cQ
 9gymmriSiCVxIQrd5f3k7rnl//mT/cY12jM+zc/4KmzNlORxMGsRLx3C3GL8lmwhM9sWs3Yec
 VfK+EYowbgmw8Wvovk2FOXNpYqUu0gBOE0sAZjhr5Uj2puD22fuf0wsktwMqypIAqLJO4VVU3
 E0pkd5B6Z2QlkjhWql8EKlNrrwDCz4fYxpyco5NaEKmh0kSCgnqRvHnMSH6rbB53DI8OXunRa
 mpYsAIlRUC/4yeTBWr+M3Ylx5lybG4+dAk+Hvzpt5D/c/ozBeUoAPFD14O7WLW69rOKF16XPM
 j3xPkq+KjYOxdb3taAU/rgxBnENtLGK28EHukZ8rLrsXKyi4+KSMdw0EQAFSBHjGJ2MlWIT1m
 zz61PmoeEKv+sW1OyOsf9WLyp8fiHY7UjpTsIWYH7OSYxWxEDO9hE0ccfk586lGJo8LrGC2DC
 SC87JNGoowZi7Qldl6Lp+m6BIQnqL6FwzT5QIWkwt2Ir7iLYQTeg2pfr0zJ6ohmF42lvtdEHy
 MJZshISnFOV2+fxVF5dEepQyaIJ8Sey5HYbPaPZk+6vQr7ES1Q0SyJJyXqEHuZ57IqsWjv5oa
 vxgx8P+ERO9l5AaEcyo5h4Djy3AxsbWqtFBj3Fd9JZWJwnnsTI/Oy22Ah8dEczD/Ls1iAj+wb
 xpt5uVIF4orgZYSQ+2XvGiO2sOhKwCMLqpWLvZPM8MFZ9i2kwZueaNs7Zg5UCtL8KsT1XfWgS
 SFwIJ9GO9/FAQOU/6p47r0NpGeBVIUSwCz20UjBdLLzHR3g1jH948tajXWyRHHjP0+B7gfSiU
 2rujJx4D9GWb7r/EbxPpOrTPqQZ5qZpCeMri/zWci8H04VKd92Z6shKa5xix8sz6Gn13e6BOs
 CHgc7PIzYM/unybtu3z9UAYf+Ouox5pZxOHn8xhGfbTHi//7GK7077ewfHzdUpvCGeyzYJHAT
 tSLbsDAns2fYBirEGdxYlq4A1U96jZYEWcLByF9dYmK2qHNe+1SZnFVHiOmg2dVHnV7qbVOPe
 ZOezCGTPa+ChL2d/JjtzKmo8nX5tiVIzLSgN4HDoT/p/affgHUH7PUpwqkk+Qzh8MziHAHtHr
 +Jc8RPfv2BC/RKRw4EPEpw/QUNjwaajCzBoPcLzKg0ssurDAg+Bd83r0l8Q5SEbEIpdD0fZOO
 eupEtlxcBC8dNk26ANocvTlrp0CrLCeA604eBBib4WOpr8Oi20Y8m9mUeiOcfrKcqGdWxxB+7
 nBzeTz4WSyFCwLI1lXiJmWUO6skpW/NrJ2oJTiLycOAnODqW3BzOfEmjvl+gGzz9oPKsO1dp2
 Abl2Nhma3//WBywv1QsA9sEqzj0V54U6RUizolS94vXlo4vYLBJL7LcYq2kqkxvO+jxgrZ8/l
 X5W8LrC0h8JlyL4qvIO0kMJdQ4aktM+5AhaKhRftzSrq1xEzCegudfRlElI22yhobDkLtFhiy
 qNgAa4piT+HqVVYtXFXAolSN1a2qscdxTAIb2XIUaqm3hqiGhzpWcPUE=
Received-SPF: pass client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Le 09/12/2025 =C3=A0 13:57, Stefan Weil via a =C3=A9crit=C2=A0:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>   include/hw/pci/pci.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 6bccb25ac2..b72e484500 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -751,7 +751,7 @@ int pci_iommu_register_iotlb_notifier(PCIDevice *dev=
, uint32_t pasid,
>  =20
>   /**
>    * pci_iommu_unregister_iotlb_notifier: unregister a notifier that has=
 been
> - * registerd with pci_iommu_register_iotlb_notifier.
> + * registered with pci_iommu_register_iotlb_notifier.
>    *
>    * Returns 0 on success, or a negative errno otherwise.
>    *
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

