Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE07EC3DA64
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 02:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sancu-0001EY-8h; Sun, 04 Aug 2024 22:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sancs-0001DN-Jo
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 22:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sancn-000369-9A
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 22:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722825543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EnZnwhzWFV90Ef6Ft5q0I90YDDzVLQdcPZFMWYMdEiA=;
 b=T7L35SN5pMyzFPmgYqxfeVAABYIcnGSazPaAoAk1hNhfuOlqVKQXPAe2p67LdtPDhM4pWS
 Gx4mS5kPrNsDe3+OHAuICgOYYNkO5z6Zk7fjJ7MPuuPMudW1fHDNEVMYaK/seTR5W7ZshT
 Lu1h15ZaJsU0Pi1hVtJiZuI95l3kT6w=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-JaqKx0_mOOinx-LZ4HmWzA-1; Sun, 04 Aug 2024 22:39:01 -0400
X-MC-Unique: JaqKx0_mOOinx-LZ4HmWzA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7acb08471b1so5834808a12.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 19:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722825540; x=1723430340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnZnwhzWFV90Ef6Ft5q0I90YDDzVLQdcPZFMWYMdEiA=;
 b=peIhzFxl3qWJUVkQUe+V6tDFRiP/0B8v//HmkPA5o4o1z4eOnKxBUsdcTE057sgEEI
 IYyhy3n9gQPo1NvtKz3CGQ6/oAvnQgKwvWqtQ1zQph8nbHEdSDzLbOp/KSJ23SlEfQOP
 jsB0u070zKZdbOhaUxI4a/CZH0exJBL8PW+OIfYCTuSQrCXHsESW9bDgpwiTyzkl/iu0
 pw0W54OKN/i6Q/d/ItIEdEG8yvDaS0hM/O1MMZjjoUIokLZlNc0oHCk28/G0OTjfVog6
 zwCuX1FF2n2gmzrVkiHjaZ4Duac+oXPwZcjBpJUMxG9oWi/Ku7Tm5gs0UOiFESUy1Vft
 rTDw==
X-Gm-Message-State: AOJu0YyJe8LbCFwe4x3wEiQjV/DsM+9mx8GDDMJVrXTzfaPZtSCeBaA1
 dGRjZpR27qcyvK+1d/S8s30HobJZTJ7XdJkdet49+t2MYZPhncp/HURwBiEZgw3T+BCucr3tx0/
 FsU31AlhnqhcFPRhiz/DwpS2+cKhMmXuMILNS/4iByVbkv5odqqTzsgeyWwr8oDyseJcKLW9ruR
 hC4Y4qxRVsz/i7rfuJth3fGp1GHz8=
X-Received: by 2002:a05:6a20:914b:b0:1c0:ec87:d737 with SMTP id
 adf61e73a8af0-1c699581641mr10688476637.23.1722825540293; 
 Sun, 04 Aug 2024 19:39:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSZZMWRQeKvgq94dKmWACQbix5PFcK360HraCaDcQegu+HFiMW3ZpE5fKkKX7LzJonsTF77H3/iU+GbCaENuE=
X-Received: by 2002:a05:6a20:914b:b0:1c0:ec87:d737 with SMTP id
 adf61e73a8af0-1c699581641mr10688455637.23.1722825539723; Sun, 04 Aug 2024
 19:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240802031929.44060-1-jasowang@redhat.com>
 <01fe2ff5-d630-4608-9ae1-cce62f290594@linaro.org>
In-Reply-To: <01fe2ff5-d630-4608-9ae1-cce62f290594@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Aug 2024 10:38:48 +0800
Message-ID: <CACGkMEtFHxRdxh6ZLJM=C5qok_Xjd5btqHUYpbQQhrqa9+BKJA@mail.gmail.com>
Subject: Re: [PULL 0/8] Net patches
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Richard:

On Fri, Aug 2, 2024 at 5:48=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/2/24 13:19, Jason Wang wrote:
> > The following changes since commit 31669121a01a14732f57c49400bc239cf9fd=
505f:
> >
> >    Merge tag 'pull-target-arm-20240801' ofhttps://git.linaro.org/people=
/pmaydell/qemu-arm into staging (2024-08-02 08:18:37 +1000)
> >
> > are available in the Git repository at:
> >
> >    https://github.com/jasowang/qemu.git tags/net-pull-request
> >
> > for you to fetch changes up to 64f75f57f9d2c8c12ac6d9355fa5d3a2af5879ca=
:
> >
> >    net: Reinstate '-net nic, model=3Dhelp' output as documented in man =
page (2024-08-02 11:09:52 +0800)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>

I guess it means it has been merged :) ?

Thanks

> r~
>


