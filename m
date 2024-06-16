Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79182C27C53
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 17:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sItrk-0007QL-Sq; Sun, 16 Jun 2024 13:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sItri-0007Q1-Uq
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 13:40:31 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sItrh-0003Ic-Hj
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 13:40:30 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f61742a024so235905ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718559627; x=1719164427; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0n6XAgnJ7mZlOywuxRe6f376MrReiGAXgHbdBLCpKQ0=;
 b=ylFz9wBvNrxG1lGyQ4F+k5YaxAPjFQTIfhVf8VC/rDKXRqGn1Y4rLyZANFiefCzhnJ
 NLyDWHpnp1G8FHGB5G1HFrnFrO1uCG8VR1RvkCCnmBYXxe4IGDmLZrp7gl+1P8M5CNEz
 k71sT0SaD+bqppaUfVPe1lDEDX4hD7lODngp4FieJfdniOWgSZOMBIXzPULX9KCu+UOF
 TKIWv5Fka+2hMuH+UC+AcEtnCZB8y4zcODW63DlWZPTqH8g+CZtJbRqMaOffAjJhZJgo
 JA6nyl7As3N9/ePyCgLy9dEAl3+SUvrCV9RP3Kx/zXaoT9AhS1OBSquhlD9bD3y4r9km
 E/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718559627; x=1719164427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0n6XAgnJ7mZlOywuxRe6f376MrReiGAXgHbdBLCpKQ0=;
 b=Fco1zDALSBm/1KkrblPB/cCSwXSLWU0Ey7O3tba6/X5pX6wldOi7RexSyAsEdXRBWj
 GoMm4YgncCPpeMdjyP0eB/ZUFibItRU1OC1EE7XV/vwH1jDAEIiMGYgJ+szd1LaFJETN
 dCLPBRfLz/xL75wIj1bBp9N/iDBHgJqf2DPwnX8+YPjaoD6CFKzYPqxdmwcW12TvKrd2
 a2pRhzqRB6J177Nf3ByVmgIuVxJx5pYRCVGtfBi/zyQtCv3NvkYB9eZlL/OAdryMoQ3G
 BhPG3o/2E7zraua5MV4IccbtbwKxe8KpKdMiMzO6qfwJbvOJSAzTED9Kn/2pWieTeWMk
 D7BQ==
X-Gm-Message-State: AOJu0YwYppZLO16ZLO/VXmgw4N3QTTyTeXjt0yaBLeTFI5mYAi4m2XdG
 bCwZ5Uv7fjNzPm/WY3wvkW9AhTM5CsTXPyc/HbXapulRvbZkmuv2QgZquS5dLvWZskljp4jD35T
 dITxagrY057MjvJsAaJ8E94pOuP0j0Y7ahb5e
X-Google-Smtp-Source: AGHT+IGkrid0Jbv7EUMwisjRSvJmag5VGk/yXERrcblQ10k7h5/8An33VegILBp/yLgaZTjq7J1XqvgwWMu9aCB+RdI=
X-Received: by 2002:a17:902:6ac4:b0:1f6:3a2e:f6c6 with SMTP id
 d9443c01a7336-1f8757b32b8mr2750545ad.21.1718559626617; Sun, 16 Jun 2024
 10:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240614192938.1690188-1-rkir@google.com>
 <e486aaee-9c2d-4bfa-adaa-d36b6ca64435@linaro.org>
In-Reply-To: <e486aaee-9c2d-4bfa-adaa-d36b6ca64435@linaro.org>
From: Roman Kiryanov <rkir@google.com>
Date: Sun, 16 Jun 2024 10:40:15 -0700
Message-ID: <CAOGAQeoSnVpy6Xhxb+pmHwwfjYsEqC8d-QhSt=Y_c7wsZMSN4w@mail.gmail.com>
Subject: Re: [PATCH] Make TARGET_PAGE_MASK typed as target_ulong
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, jansene@google.com, JP Cottin <jpcottin@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=rkir@google.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Richard,

thank you for looking into this.

> No, this will cause failures, because we need this value to sign-extend to when the
> context includes {u}int64_t, and target_ulong is uint32_t.

I did not expect this, good catch. I see QEMU uses size_t as the
return type in qemu_target_page_size which returns TARGET_PAGE_SIZE.
Maybe use size_t for TARGET_PAGE_MASK everywhere (including
qemu_target_page_mask) as well?

> What options are you using, because this warning should not be generated with -fwrapv.

Good point, I think we missed this option.

Regards,
Roman.

