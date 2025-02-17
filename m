Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664D9C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk43l-0006kn-To; Mon, 17 Feb 2025 11:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tk43k-0006kX-8o; Mon, 17 Feb 2025 11:33:28 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tk43i-0006gW-DG; Mon, 17 Feb 2025 11:33:27 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaec111762bso1053063366b.2; 
 Mon, 17 Feb 2025 08:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739810004; x=1740414804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prUa2diEnEeJXeNZX3iDb7yAW70/AEkniWxY+/HiH/Q=;
 b=GkaGlOR3sU4mdxJRPMg+BOS8VrVV37RyULJz4TOopohWIvnXlM2/UnHqKb2A9+5WFU
 HO1Qn3p0bxls5rgxXVQNe3gqhwduqPImiyHB2IhUZvxoX4m+5swT+KkmAmKuL0WrPWJn
 uDFupt9YV9vwTa3JcG6eEw/5sMMpa9eTpTcKOYaM8XW1OWfI9fO1RP7qax/EsueMe8Ux
 C8mzvWNAlZnV/r6+sTl6JVu1EtfLf4ldsmIS4Aa4hl7NagFfazbzWwv+x0aPmiW96+ZA
 eTp9mg6PcEcc5mPwBDlmIA9PUoSeE2Png9v7jxIjN+5PCSdc78hvQEkdNjodORylPF14
 kH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739810004; x=1740414804;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prUa2diEnEeJXeNZX3iDb7yAW70/AEkniWxY+/HiH/Q=;
 b=ixYUD0JG3JCVIpgJ9VqgIaAsi4E5dHh9k96xTs7/1PQ6gAY8NlRoi2q2KINQ1YijaK
 kB3fVSJpDCBeopinXSwjl7zBhOzAIWkiYixz/DCHwRCQQ69pddzEC70UFwe/9mDKH7Ne
 dDUNQGt5ie63ytWZTI3uradQ3RY6PPdjIFnNaYOvZU529OQMoZRe9wOMOofSPPfcU70k
 1aw0pKNavGIwKtrg4mzlsG+Lwvn6CjbYJ1/H3oaPlHmlfbtiLD0A+Nu0MQinNFVicvQj
 qOA+HU14nbhWgY8fDhLqY2dPPhSehQUNiSOyWH/UicfFgZ0EzMnbDFyJzflhgboCH78T
 XRQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX84Ie+w72uxJbiCPOtEP0YK6E/FBPnD54iXE/Ie9c5zZviR+VU96xs9OrZNvQa7h6DmwMZ8eQDiw==@nongnu.org
X-Gm-Message-State: AOJu0Yzh/AZhiXzW51yy8tZli69RlOCpvPSbKXPT+s1UVTt/H4QKAVor
 UIJl/vd6WznLxKXHEBkxkNzuiMq+eO/mBbuDZrvQe0CjTDU2PCvZ
X-Gm-Gg: ASbGncs9+EDSr7Supb14ea5SJMpm3Vmuqku3dQDbAKjhwZRC39Br30dJzMCGLh6jMLh
 YHushTuyADvU7D7f+/1HGyncbUqHfGrbu4uFeMWD1gpePRUrdTFAl3SpBSci5Rg4LNpAwfy9LQN
 qz08aFDkQkjBoUTOUu1OLrDnDeH/8ty5RtQVm+sRuisgVrz1jJZt0PYrUQUD9g9fU7iI8WpvroD
 iTFsigXmFHY3T2zbrNdOt4Rz92Tgttm7fb3AFOaW+LVb02iflYGxw/OS4l+vzm5eh46Njrs3y2P
 Kpfa/pzKEJc=
X-Google-Smtp-Source: AGHT+IFaxPcAm2kU0HK7u4IttnSmA3ucoMw53Ax8ExITUjjIm831RDTQr7WQ0/E9hyk0WiJLyPScNQ==
X-Received: by 2002:a17:907:2da7:b0:ab7:eff8:f92e with SMTP id
 a640c23a62f3a-abb70d36233mr975119666b.21.1739810003841; 
 Mon, 17 Feb 2025 08:33:23 -0800 (PST)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb9f3a695dsm185382866b.2.2025.02.17.08.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 08:33:23 -0800 (PST)
Date: Mon, 17 Feb 2025 16:33:20 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 08/18] hw/arm/fsl-imx8mp: Add PCIe support
In-Reply-To: <CAFEAcA8Ravyh4_iVXvmHzQzXa=gOTu8+-OPNLRLVB78if8i4Ww@mail.gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-9-shentey@gmail.com>
 <CAFEAcA8Ravyh4_iVXvmHzQzXa=gOTu8+-OPNLRLVB78if8i4Ww@mail.gmail.com>
Message-ID: <A84E9FE5-390E-42C4-8DCE-8C796D21E7C0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
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



Am 17=2E Februar 2025 13:40:48 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>> Linux checks for the PLLs in the PHY to be locked, so implement a model
>> emulating that=2E
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>
>> +static const VMStateDescription fsl_imx8m_pcie_phy_vmstate =3D {
>> +    =2Ename =3D "fsl-imx8m-pcie-phy",
>> +    =2Eversion_id =3D 1,
>> +    =2Eminimum_version_id =3D 1,
>> +    =2Efields =3D (const VMStateField[]) {
>> +        VMSTATE_UINT8_ARRAY(data, FslImx8mPciePhyState,
>> +                            ARRAY_SIZE(((FslImx8mPciePhyState *)NULL)-=
>data)),
>
>Use a defined constant for the number of array elements, please=2E
>We don't do this thing with ARRAY_SIZE of a cast NULL pointer
>anywhere else in the codebase=2E

Ack -- will change to a named constant=2E I think I took inspiration from =
<https://gitlab=2Ecom/qemu-project/qemu/-/blob/v9=2E2=2E1/hw/scsi/vmw_pvscs=
i=2Ec?ref_type=3Dtags#L1276>

>
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void fsl_imx8m_pcie_phy_class_init(ObjectClass *klass, void *da=
ta)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->realize =3D fsl_imx8m_pcie_phy_realize;
>> +    dc->vmsd =3D &fsl_imx8m_pcie_phy_vmstate;
>> +}
>
>This is missing the reset method=2E

Indeed=2E I'll add it=2E

Thanks for the review,
Bernhard

>
>thanks
>-- PMM

