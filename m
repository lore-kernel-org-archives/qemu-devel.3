Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92642C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHPM8-0005ef-AG; Tue, 20 May 2025 11:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uHPM3-0005eD-Dp
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:58:11 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uHPM0-0004RD-PK
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:58:11 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70cca430085so27283957b3.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747756687; x=1748361487; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zq/GEVJhhDgOVQYKrZa039iqFHl3+Fylcx95s374NQk=;
 b=PO3jxe30quBHo0k5BwFkkuffwGjitGT7cwSK9SOAHKi/lBSbqNPxzc32Akml2pueVe
 hoXeAByHTJ2Tk6sOEvsWDsjz6ocEr4/Blews1u6jzyPFyU93z7pAZNhwDSg5JGkYZFop
 gSlJdRye9HTlQtYXWA1iCTyOC++ucsSRZdhg/NrBFKMSjf6Vr5s8OFtMzy0qLcOtA5Ue
 MyBDWt3wgqwFbXckqzoEJoZwC73rICPkbbEvqLtwK2MmRoPbbx7rkZuAlPtBRrEcyexi
 vueXN8/Ij1xF9U9Sv3bfPWlDWYhMJREfFErHNPQAMEZuK9S72vpTfNDlUox2L6wLg3x+
 kuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747756687; x=1748361487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zq/GEVJhhDgOVQYKrZa039iqFHl3+Fylcx95s374NQk=;
 b=GsSlMSCmbfSq5DBusl381ZH/x4MXXiV5EgMDkyXizgWAFzbzAGHrOSMOzUtU0QB9BO
 Uk4XaS1Y/b4PU+vAojV1tdjMbqLMq/YhtNKMdxMmXTLOJZf81b0qjwbZXh2zvMTvfm87
 EprtGePOZYER4x2ohbxOxxET5oNfQEBDQLnmTNIeCetUHYCj3ZFp0Za8YXKpTQgCqlch
 ghapHXay7iLsL4eSecGAcVmDBhmtWT9Tj3nyEOTbJbkUPZrYis6TEXdn+Z7JVgzVGk+D
 eOhK3egndvd70DcbkOr86OIKTiVZ5k8uymdy4lj+tn/nH/9kvUYymhgvlaJ+x+nZ+Ew7
 byTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs0Tnli1j3GNRqa2XwjTSbnzbii3V5dx20EZCwBM8C9+oAmqq7+gyBqfwV+Fnj3WEmXALvKyl441IH@nongnu.org
X-Gm-Message-State: AOJu0YzjCdCPql7SeQtpcgTRDLFBFd3i6nGk9C41t9cT2vCxay9+LRAh
 X/0/6j/e9XyCDSuq8F8fg6IWpHgJydY5Fk73vDdzIZlgc5AkX6UaTPXgA5zOk6E+Tcc4Lw3QEET
 Pmipoundhb97Yai4DTowPbbAIXJikw7H2XuUumTCVMA==
X-Gm-Gg: ASbGnctrpsVlRPw955TNkDW4zzThKRI5n376CJDPA4Usrn7ibDl1bHCT7bXLZ5/c0BT
 E2Z91dImZzijy0iMhZssuKXls3h17UnOd+JkIUhoMmoEnTdykCp1cXo4F1Vi7v45Ugfy/gagOKL
 j4oSagABn7BLEhyVxliT8pLyqUMzMdtnDyFA==
X-Google-Smtp-Source: AGHT+IHgq2qpX/TKV0lQVJIt395ndFq9Sm2qq4ctb47b0K302eCK4QAEgKKL1C8Jzb2GqD8ubrjmYRDaVMp3Qbvm1gQ=
X-Received: by 2002:a05:690c:6c02:b0:702:d85:5347 with SMTP id
 00721157ae682-70cab109857mr221045177b3.36.1747756686992; Tue, 20 May 2025
 08:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250520152750.2542612-1-zhao1.liu@intel.com>
 <20250520152750.2542612-5-zhao1.liu@intel.com>
In-Reply-To: <20250520152750.2542612-5-zhao1.liu@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 May 2025 16:57:54 +0100
X-Gm-Features: AX0GCFtmTkT8uefvGoOGOfVedfpMhoQWrVuKYA_aa0BwK7pxY3kcMsQ8MruaeNI
Message-ID: <CAFEAcA9y-WRTGo5um1iwNi5FJOwuayeNLiOw88s=1vssqncRSQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] rust: Fix Zhao's email address
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Tue, 20 May 2025 at 16:09, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> No one could find Zhao Liu via zhai1.liu@intel.com.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

