Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2C0C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 18:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s43XQ-0003Nv-Te; Mon, 06 May 2024 14:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s43XO-0003HQ-IE
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:58:10 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s43XN-0004yJ-3H
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:58:10 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5aa362cc2ccso1547489eaf.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715021887; x=1715626687; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Waa/3QqtGDLTGCVQMC1IzaXr3Qpxi263kxmAGkc6qHc=;
 b=a/fVV3kZZ09elhI3qQRRXSNJxyqxAzOouSHKl6/Ge0zZoIW0LTdHwgp3Ev3gCttN5N
 gUn1BF8W3TymfJCd3K8/TWofyR6B8Ulx9QS/hRFge86oZU44UVWYqDacmpHkmdUJQZ4C
 kWap3ONLOmSuHnGZXrrWCNAKUj2YE85mJw8pEiZv3JhFMY+26j2L+4LRJ+St2EWVc9ap
 fDSCaquxU0K0JntWMsex85XrOUNnr/BEmgiJCKl8sbvlaJix/XGIoesxwIrheaRTl92/
 Hi1Ml99VkQ7wCTpl4SG0uDN/B7YsB8S7vOmN+TLrCqL0QcDzfWjssNH2mrYBzCo8Wpqm
 /OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715021887; x=1715626687;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Waa/3QqtGDLTGCVQMC1IzaXr3Qpxi263kxmAGkc6qHc=;
 b=CBJLTasR3pLYnMLCj1tfMc/2GhTrTiAA+NX6srfNygu+4qgK3Enbq6RXA23fOselLq
 kA9YmH5r57QptTL5C1xK0JtYb8mOsIRaaOWiEIAmijiXeXYrNWki/Qpm4IANEEepxm4n
 9icE8/vAnnYnhEJlR74ZSFMKhuXDHkzs3MewT2r/I2N97jForJMUMdDFA2qnQFS3nvuI
 YqKD5MsmjFDRI25MrPMTsilDJZQUIZSaAwLQGOPYLS1neqcl8rZcSUbPOk/sRXRnAoYV
 OiIIqKl8gmGw7Y7rtIAUVU/Lgv93iyzEs27vP01Ud4m2Vs1yroSmRIEpelCK8cI3E7jq
 VtCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbXQDu5J21Fxgy2PSpb3QS2gjuFbT0qO+8D/D9I7iyaPvcfRByT6q70TBA5Hs7uikqTwIN6hrBtgLwl5XK0IzI2Gsgw4o=
X-Gm-Message-State: AOJu0YyUHhdEswWVRrB2YX+n3pFn2Pit8PiFeY39d3m6H+j7TwV0Loi2
 SKdeLovHYjQK2X3EiN1eoDDTAJTeoxfVtiPGE364i+3HfsR+xpoh
X-Google-Smtp-Source: AGHT+IEKg1nc8o8wb8i/XP3fEE6opJKvO7iMOKv/rbsgVrNwIQz6ZlyjvlmsSypgEEdsiOcXV9Svqg==
X-Received: by 2002:a4a:ad41:0:b0:5af:c4b3:969a with SMTP id
 s1-20020a4aad41000000b005afc4b3969amr10674911oon.6.1715021887299; 
 Mon, 06 May 2024 11:58:07 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:8080:1f00:9c00:b108:eb17:4557:755d])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a4ae849000000b005a4c3d44cadsm2067993oom.38.2024.05.06.11.58.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 May 2024 11:58:06 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Anton Johansson'" <anjo@rev.ng>,
	<qemu-devel@nongnu.org>
Cc: <ale@rev.ng>,
	<bcain@quicinc.com>
References: <20240506183117.32268-1-anjo@rev.ng>
 <20240506183117.32268-3-anjo@rev.ng>
In-Reply-To: <20240506183117.32268-3-anjo@rev.ng>
Subject: RE: [PATCH 2/4] target/hexagon: idef-parser remove undefined functions
Date: Mon, 6 May 2024 13:58:06 -0500
Message-ID: <068101da9fe7$5493b900$fdbb2b00$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJLdJdU/DG86JVEEIa8gVqwbMNhjgHtYVb/sJl2PtA=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo1-xc2b.google.com
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



> -----Original Message-----
> From: Anton Johansson <anjo@rev.ng>
> Sent: Monday, May 6, 2024 1:31 PM
> To: qemu-devel@nongnu.org
> Cc: ale@rev.ng; ltaylorsimpson@gmail.com; bcain@quicinc.com
> Subject: [PATCH 2/4] target/hexagon: idef-parser remove undefined
> functions
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/hexagon/idef-parser/parser-helpers.h | 13 -------------
>  1 file changed, 13 deletions(-)

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


