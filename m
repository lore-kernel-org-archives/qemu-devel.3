Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17E1D2C556
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3FJo-00055G-A4; Tue, 22 Oct 2024 09:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3FJm-00054m-Rd
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:53:02 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3FJk-0002AK-TT
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:53:02 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c9709c9b0cso7437079a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729605179; x=1730209979; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uSklaj1Iow3OC/fgWLoyafNoKV4KALgVR05ccdjFQ5Y=;
 b=elEe//BIYje8MW23o3obiesNpeODQYSBnw53RGkK68z/z6hhVep6rQFGL3QbldakJV
 dikfnu25/BPBQLzCTQC1oaI/YQQsKWQ9WKgwHdLoYQCY11nfAaqAm05Z6Hd7oJAts7Wk
 sr99ckkfGZEXzM6coa2+R8/olPJoeT0unUYiWMLMMK2LAzeoaXCwIolOuO6cjWUYbPBk
 mB0iqRgOdZ/lz05V+mWSuWsFBRTGI9UItuG6Q3km40QW4luaZgZIs2xiVhQpNiGQCDol
 XsAX8Vvrzc4+/Sqsk+Trl9SHN6XRT/XasqNzR6DHqTX1F8ySs6qSQMEOXutqr/P0reSR
 GMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729605179; x=1730209979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uSklaj1Iow3OC/fgWLoyafNoKV4KALgVR05ccdjFQ5Y=;
 b=Fw/RLMAj2hb3d30j35OkqK/4tvbBPUYAJ7uJuqqAK5GWID4ckV5DdRx87vTbx4xD4Z
 X05OcX9vO3ouGir4Pjuht77mKp09PyaT8Nm1VSEoJmhKTdXZPJG1h0ZF6a+TQHgcCOev
 FL7a5WjgjhxigeC3YKgDCPP41D5KTO4wbqKhga7wYaoWb8vhxvAxpse0p+Q4sLimA13Y
 eiI3dZM2b1uurIl1uimFMtcmawlTkIS9GZD5zryybXBExOQn5Q6uzo7fsGDvHUKMIvX4
 90ntUAKRioPUMtgemBfURwgjM7ZfKame8WP/YYOYMK4NO6eAWZUQDC6+9rNmQsTXKSGW
 DJhg==
X-Gm-Message-State: AOJu0YzePcby7nv3aEq692Mm2J6F/qS2ZuDisD3p8NChgHx5ryp+JhBs
 pilKsnkmlFHsGPhkNUQxLokUPVcM2p/cDFNtpwRQh0Gu5FmhPTgSZ9El7tH+FFOfJCcEUTCuoXj
 xlT/6ldWsj7NKqeBlSzvfR7Hf/qdHUvyfRLU3Gw==
X-Google-Smtp-Source: AGHT+IE5idqcDxn3wPR9rUM7wB07gzbhBWxNVeTb6QnYbSe3NEms4jgZVc6CzAlgkUpwqfNlfo1Al3BdpWyeSBwHypc=
X-Received: by 2002:a05:6402:210d:b0:5cb:78b8:7056 with SMTP id
 4fb4d7f45d1cf-5cb78b87ad7mr2740671a12.33.1729605178869; Tue, 22 Oct 2024
 06:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241021073957.1851500-1-edgar.iglesias@gmail.com>
In-Reply-To: <20241021073957.1851500-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2024 14:52:47 +0100
Message-ID: <CAFEAcA_M2HsgKM2idG4030JTZWEUFfm_2Ae980zyh0DGhe-p=Q@mail.gmail.com>
Subject: Re: [PULL v1 0/1] Xen Queue
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 21 Oct 2024 at 08:40, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
> The following changes since commit f1dd640896ee2b50cb34328f2568aad324702954:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-18 10:42:56 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/xen-queue-2024-10-21.for-upstream
>
> for you to fetch changes up to 676a68fd4850924db73548c9cb20ea484709708c:
>
>   hw/xen: Avoid use of uninitialized bufioreq_evtchn (2024-10-21 07:53:21 +0200)
>
> ----------------------------------------------------------------
> Edgars Xen queue.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

