Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0B7C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPaq-0001ME-SK; Tue, 05 Mar 2024 02:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1rhPao-0001Kt-M1
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:52:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1rhPam-0000Wf-Jl
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709625121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1zomC6hXSgpdL0j9prQ0ItnAurFMbxehZKYTeFha5p8=;
 b=EkvwISU15k+nIeEYtpch6JFqmbnZSYMY3nyBZMl9ujWT+V0mv+Qmog2bcTdNLyz0PHadE2
 yOsN6IAeSb8wRF4FXaD0zm9BIY1PJXaLz/9CJzto0T1xxLvsz5X2r//w4zkjP46LKgEsoN
 cWLC2SFySq6C1pyM3tfsJkWRIXIZFrc=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-iVpPxRXRMU2xAGgKK10Y1Q-1; Tue, 05 Mar 2024 02:50:41 -0500
X-MC-Unique: iVpPxRXRMU2xAGgKK10Y1Q-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7db36de2f09so1391640241.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709625040; x=1710229840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1zomC6hXSgpdL0j9prQ0ItnAurFMbxehZKYTeFha5p8=;
 b=LipGCWlpkwfJUgosjp+1EyZiSGAK4Vf1lTxctXogm2sDvq6RqOlRFHOO/FgEAlet6P
 aIdUsUZJHthkzAoqxhw2jwRp3QBdUW9m2996vJnrAxeUpKtVYaEVuiN8oAUBOUg5+nk2
 FCHqYSNHIBwdP34fZ4yP2s1ngGwpGV0hlpO3AtWnl4NcTM+J1Mt7X+KIo+DizaWzgqYQ
 vzFd78eWv0I4/8oLfiQy5itxM1CIIsZilkUrQ9Uw43i4jdeVPY8Ps52jsxbvtExXZevg
 J9KWcYt4hLuGvgSo47s0FqeLZgs+M957pEfJ6FCCLv2feKfmSqaBwPipmQJ/aMTYxJpA
 SSHw==
X-Gm-Message-State: AOJu0YxW8x7XLZ3T/MFjXvClbm/g3t9SSYhcCP/x9mwlfnuiHVyGVfks
 lWfclt46FIGT/DqJ5bXA48hODBCgCMNiwS11IFR+9TGvmeGqup0bq+qnMPDqyQOwHRVXDAxbs5s
 wBU0/w0jBDSxuk9wabPsNArfzBMuJToTUYgSUL59Tjw4HjlSU2CThTOsCD0vtrCRsQJU/W/swpn
 uBxt9gMwKVMfwMI2PwJcK2SIW57DNIU8nrVT3blw==
X-Received: by 2002:a05:6122:4e8c:b0:4c0:9ec7:b324 with SMTP id
 gf12-20020a0561224e8c00b004c09ec7b324mr915147vkb.0.1709625040192; 
 Mon, 04 Mar 2024 23:50:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3ASzqLlDYoDg5i2qhv/oTFsYbd3iSsDR2ll//quYmrh7bJed3qtLac32bGhyVEUBHgo6TuuKA96WUDmHD6ec=
X-Received: by 2002:a05:6122:4e8c:b0:4c0:9ec7:b324 with SMTP id
 gf12-20020a0561224e8c00b004c09ec7b324mr915134vkb.0.1709625039942; Mon, 04 Mar
 2024 23:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20240304134532.28506-1-kkostiuk@redhat.com>
 <20240304134532.28506-4-kkostiuk@redhat.com>
In-Reply-To: <20240304134532.28506-4-kkostiuk@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Tue, 5 Mar 2024 09:50:28 +0200
Message-ID: <CAGoVJZxgrZK0YptbeKdvu-+VFQFTaP+yvbUgDJFpoqR4B27_EQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] qga-win: Add support of Windows Server 2025 in
 get-osinfo command
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Dehan Meng <demeng@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Mar 4, 2024 at 3:45=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redhat.=
com> wrote:
>
> From: Dehan Meng <demeng@redhat.com>
>
> Add support of Windows Server 2025 in get-osinfo command
>
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> Message-ID: <20240222152835.72095-4-philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/commands-win32.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index a830f1494e..d1cf1a87db 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2153,6 +2153,7 @@ static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_=
MATRIX[] =3D {
>      {14393, "Microsoft Windows Server 2016",    "2016"},
>      {17763, "Microsoft Windows Server 2019",    "2019"},
>      {20344, "Microsoft Windows Server 2022",    "2022"},
> +    {26040, "MIcrosoft Windows Server 2025",    "2025"},
>      { }
>  };
>
> --
> 2.44.0
>

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>


