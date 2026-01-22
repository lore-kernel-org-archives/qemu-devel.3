Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353A8C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 07:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vipA2-0007Fr-Mu; Thu, 22 Jan 2026 02:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1vip9k-00072m-NJ
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 02:31:06 -0500
Received: from mail-yw1-x1144.google.com ([2607:f8b0:4864:20::1144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1vip9j-0006EN-9j
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 02:31:04 -0500
Received: by mail-yw1-x1144.google.com with SMTP id
 00721157ae682-7942fca0da6so1551107b3.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 23:31:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769067061; cv=none;
 d=google.com; s=arc-20240605;
 b=cCCthF9rOU+eCWRyT7PTsQAqU1NgISkFW05OKoIq6nlwO1gdeFpkZ5tPXvajo0TZri
 V9dR7pFtYWWIgbid6mh/g9AZH1r+O2AcLESij+cEo3HLcA+tm6QuUTQibFjN7RgCynBv
 AHG2JA728pK944JAxuf9UmeFpDWEwo7UsfP74ZVyCav9XsOxA9g38tg5wyn6AJJMSYCo
 jyeVruL0Y8T8MBBCn9wGC+Gxyxthq2bBuCkNViuGu9lx25SM++AW9gRBaYQ/qe94b027
 eF7f3gPYfHRDYhQDcrJTT9qUti1wIui/aq7Vd+zc0jdz9qU2pnWo3eMBp3T2cgsKTUNk
 LqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=a/Co3iGoUUxM7ioDE6arN8d9PU1TVsFqWSwNgjnMlmY=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=DWBgXlY5BmzT++o7B/YlgAinKnN3k9HGbZ1MmP8H3eturoYfIj7ksydbPKoSOFSFTV
 rNzkhSPrzIevbbm9iC9vegA5OQ4gv4R05NN1SblxJCCyQhB3G6X3ET4xuLUvuk+s5jxh
 kn3GG1uDgIf1fo/R5KPnv2RB3bmPSaP+zzNP4QcaBKx5vFxtu5lF3zzTu/OHgOVpNLUL
 WZegyZgHJ6l7xtNCVpOTtj/ImtM5tnRIZXJ97IvNArYzfVbN7ZqWTtWmehsPwl8UeqiE
 M9yGyzB+sna/yO4WXjpWMePUV8/fNdhxbfVGfpTtzotVALcBU//zKePYOz2Ygwpdb3M+
 LrCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769067061; x=1769671861; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=a/Co3iGoUUxM7ioDE6arN8d9PU1TVsFqWSwNgjnMlmY=;
 b=bA5zgxFdrumpEzHP9Xgpc7hAdwaDDocMbR5qeffz7265jaP0vfqc01b73rC+1qISTZ
 OVbkUiN6uUYOi+1d7OTN04CKVCcF1fE/5/T5x3cocTlAzzev+ng9l6b0C21Udjz04pW0
 0fEPKNtFTBNMOWxbfjeykPuFirK6O/aLA/teOaTsd+DN8LFVA9OaMplhSiSQKmHhz/1x
 gmzHByKVfJDlk4zzXC9F/S6ffe7ngkUO5+Xd4SJIzgt2Dlw+kWNwMRV5onSXdFKgB9Mi
 J1PEHHVcKNK4zjRPLM7AZU3ovH2NYbIS9s8gzlW3mnN428M91mhUmMuaFDNlOHRsvaJa
 PaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769067061; x=1769671861;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a/Co3iGoUUxM7ioDE6arN8d9PU1TVsFqWSwNgjnMlmY=;
 b=SvoPK21cwhaooePj1GcXZoooicaPLhIY66hnvxGcju104GdA7ASXh7SBgRfQO6Tieb
 zi9eDDm7Pb2oonWW2qQ49N/KaBcAXtW+JIWhyT1XOmFTDlImJjfqYH2z+JnivtGfh6t5
 4AIje5eLYMIE9teFyQsY6kMHBi43nHYVwt2AsQcjp1YRWnQ6yShcIVqRb4E9j9olX0RM
 1At5LteakEZucA6awdUQbexChIommF1U5OYohmh8PXTuSU1ScVTmkKQZqtEb9DfQZYyq
 OpIN8WgmpCoaZrtKvqmfLNmY62bPwEqvRNHds9gF8QKnHf/qoTN0Osz9vRgMKXtq6ijn
 K5Kg==
X-Gm-Message-State: AOJu0YxYcf/T8Hc6w+H3FrTPAuK4DpIjYsM6tTUSM/zcR2osBrcfHGDu
 UjA3rCcTctqnFhpJjPO458yG7lVQzK1/bv6WqssAiGhZq8D4SOsGLmM9UBB6odM3pPm8ar9Cdo0
 Bgayh5ua9+no6uTYZ9mXTCt6U1+X5b3Rs4G2d
X-Gm-Gg: AZuq6aJtBMXjUqLc5Rv0192tN6Dimfjt01dTDstYCBx1wGw9Q/XEnrwczeUgEHPtcQg
 w9SEPytlnJCfV5N4nX91CGOscnwbPfJUlE7rHmL7Q+tu+deuI97KmbtCTDtrL7rbFSPSI+2z6iW
 SI5b/HAbW/QLvlmCd3K5Vm+whpzYANXUwBbbIQncySwSrdtoMDjzgvhqA5DeYPS6xd3/AB8FaqB
 BIPMgb8VtDqQn2g/86xBc38dZXWasgbgp+OiG4rvdiyKBRr8MCOiOkDoouzFmi5KDtD8+c=
X-Received: by 2002:a05:690c:c4f9:b0:794:10c3:11c4 with SMTP id
 00721157ae682-79410c31ef5mr63077557b3.33.1769067061372; Wed, 21 Jan 2026
 23:31:01 -0800 (PST)
MIME-Version: 1.0
From: Yodel Eldar <yodel.eldar@gmail.com>
Date: Thu, 22 Jan 2026 01:30:50 -0600
X-Gm-Features: AZwV_QhMnpqfHGpqs3irNbLlygIlkFX7aBkMx031rScXNan6DFETpM7bsP3s8n4
Message-ID: <CAHhgW4UH=_65pZJEACBXh7J0XN1SH1HFS_e_FCN8Zm2sKa1sww@mail.gmail.com>
Subject: Wiki Account Request
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1144;
 envelope-from=yodel.eldar@gmail.com; helo=mail-yw1-x1144.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

Can an existing wiki user please create an account for me?

username: yodel

Thanks,
Yodel

