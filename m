Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1817FCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6yNB-0006OA-E6; Thu, 09 Oct 2025 17:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1v6yN8-0006KG-LA
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:40:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1v6yN7-0007mc-44
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:40:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so8126585e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 14:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760046023; x=1760650823; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KIedvRvkdfgpVczyOpQn5aD1L96u7vfR8ZBE51wDnA=;
 b=H5zhTJ6NItiQSsHGB6fasjHlE+UQf46df2uvjoEZs77yhm7VabbK9zVPBfdqRG1VEd
 BQ43EuxruzXyKFVI4m5vp/9JXX/w8b3SQdfXBwrEoqT+liIci+2RyPwYpM0FEhxz9ZZS
 JI224n92EWByWHD+OvOknuHOVBTBdPB0lEdNGe9lkXZV5hXiTBGoZH8MnETER060E/vt
 IRxmWSW3Oo2emdfw9EmeuGrLyarJ+N3mH+x39yK/Kpn4ejS1SXynlpasAQNTKWQdG+p9
 QEjhjQRvU9P1fFBTuKW6dwLuF/V4ehMYPxUW1Qgw2NltNcIVTTc78SfxiA/xF5DRobCg
 jVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760046023; x=1760650823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KIedvRvkdfgpVczyOpQn5aD1L96u7vfR8ZBE51wDnA=;
 b=bpfvzl01d9ATZwrfo4GaA/DfoBwc6aqDFmeszZymSYOa26KfCaVI/V9xIJHfeb14mp
 fjDRr+Bc8Z7/Yvsp6f9J4+9WMjX8E0nVRI3FnJlW/CAWSommxW70yruxgNDamRKZ/WFL
 Y/B/MF7cO+DM0aaT5z7EuPQbJd5suwtAoaIUxazlzM4I1YpvutdnHcPaBWcMdJAGoBdV
 4IQysdJlAo7ymgeRaKKkqav8eVbfv0yxHjLCzkyt1iYf3hHN+xU6EvH7o2u+c6cpMSIC
 rFWwgMftWnvy/vPhR0vY+EFhazM4FJ2WD/ghbgsV88y6y06mSnT1DcsDA9mbKRZDUhR0
 XCYg==
X-Gm-Message-State: AOJu0Yx45uI0IkiTWinxSkCtt3P3KvGCDQh5UnVe9e9MkjZgqKGTdESy
 QsqvpCq/UsJKQZODfcLDowoWPTkm4cL2QkW7tBdVffzjSzGvLWIkne+Cb9WzTs9aL1fj0qfGFOI
 ncL0D4Dpi05mB/yU5u+8ElIlPcsT5N1w=
X-Gm-Gg: ASbGncsfTlwLJ9UTwy372GQuYNJqUm2x0jDrhbUsx69w1wb2JLeVT+U4tcwc8ygWCsi
 6KROc+f1oCpvmySjCBPZTkfvLCszIg56o7V+igr/tlQYF3yi2p4jEaK9I8dvicnzr8rWW8NZs0H
 oweRKbT5S+29KmcYfj41AMpaYaY5wp0TGEe/t80Jj6epuWkvO7d/VuYLT+nw+lNJH8cvrPbDege
 50wM0BDdQJE6E/1U57lvyP2zMaccjYTxxPeHmFj3L+HYj5fCKXAHtG5RFTPACs=
X-Google-Smtp-Source: AGHT+IF5MuSiS/JUmCPkAzVJLPXz+5FkKiKuYWshQxdZNtVIl2yQqBzDwgOYtnEO/BdZefanr3ATHG3ZKvotV5HTYNw=
X-Received: by 2002:a05:6000:2303:b0:3df:c5e3:55f8 with SMTP id
 ffacd0b85a97d-4266e7dfbeemr5417892f8f.54.1760046023329; Thu, 09 Oct 2025
 14:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
 <20251009195943.438454-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20251009195943.438454-5-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 9 Oct 2025 15:40:11 -0600
X-Gm-Features: AS18NWA2sKVG7_2Cun4Kweoa7nCOuFOohuZnhPBHCqyUNVeKHxIsbFRcsmToVKA
Message-ID: <CAATN3NrsWN_PPHx2Qxn-QEH-Ov0CDxTUERdScPLi-M8nRNtr8w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] tests/tcg/hexagon: Add cs{0,1} coverage
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, 
 marco.liebel@oss.qualcomm.com, alex.bennee@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-wm1-x334.google.com
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

On Thu, Oct 9, 2025 at 1:59=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
>
> Cover cs0,1 register corruption in the signal_context test case.
>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/signal_context.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>

Did you see my previous feedback on this?

