Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89683C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 00:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpymO-0000dA-52; Wed, 05 Mar 2025 19:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WufIZwwKCpE8vw32zDEz0v819916z.x97Bz7F-yzGz689818F.9C1@flex--nabihestefan.bounces.google.com>)
 id 1tpymM-0000Wu-5U
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:07:58 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WufIZwwKCpE8vw32zDEz0v819916z.x97Bz7F-yzGz689818F.9C1@flex--nabihestefan.bounces.google.com>)
 id 1tpymK-00070y-Kv
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:07:57 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2fe8c5dbdb0so208540a91.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 16:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741219674; x=1741824474; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=st91ok7oCwEuiRJr0/PqKM4jVdbffw88qRzAq3mg9TA=;
 b=Zp6pUDMEI9g1PyZ9Nx7vPL5hkHwLEqUdGrI52P+4jL/J5lJQ/BEIXZTBn0gDP7lzLr
 K79A1ko/eskgDLq+xI6xuCDjY6ot5wy7p2ymFkZJkFLhDR9wOjhATR4x+5vKksJYdnC1
 bcX5XJDrluYZTKMTo+223zIIz8XBizzk9IjkUVo426D+fXrE2TaiDQwGE8jVnDlQX1mT
 k6gcbyb6aRQ7/aG2FgNkYqyDx2dLw93VBSK2hD4mjFqZLNEnorZN70BVwrXN8v1xPTbN
 xAcsaJIFyCUCIkwY5Dra2/xQH7ye25gLDNv/az7DGf+MDfBMt71aA8Gh4Uu//XPXgVki
 aJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741219674; x=1741824474;
 h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=st91ok7oCwEuiRJr0/PqKM4jVdbffw88qRzAq3mg9TA=;
 b=B1ehCqIipZWaOG8N0VcRbxbCcOszNpTBkeQ5qMEcBwOxPjqLukauJRhkajuPwqPydH
 l+9ZMWAktjCEU57d6npyNMlUr7n5a+XsUUntk5KHQBgAxYq4INu4/HCBrLwTEv5Pg/5A
 HN9/n9/ICLx5UB58O5pxIP/jnxfkmcMkia2rZl3fOtccoJeCyLub+Z+j8eiT8wbcydzo
 K5WPG6r/ph6//9YAXCGxR7XaoeRa4JRQk5WauvvimiTXpV8Se9JQ3nV4Y4UpYOgVi8D2
 rCD7yQSjzTD8UdxMNfRqPK5G0gQ2jsLmlEMkLLeT7gBKZOPd4Z8b6TxkWw5aD0AsbsUn
 bzQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVorjG24iy4OWcUNJSYjjBq5rDI5oI+mc/Aa1RI2TvPY09swL9VPRLiGQDTp/iFeJkynW972hFL2syY@nongnu.org
X-Gm-Message-State: AOJu0YxASUljcPhy0/AsqC8uybltjyI/Jfr9Q26byZKWL+eLunbDm7oj
 +qXKc3F6rd1BihLGKYNaKGu/iATHzzb8YQrnCiPWEhnaBSHtSK3MzTHm0IVEKLo9xNlsgBRUbgg
 1ks1MEoYo55S8p/jOrl/2pPLYOA==
X-Google-Smtp-Source: AGHT+IEc7+JlNlFHRRcg+2ZfRyofKvZ4wNRPXh4tQQaIEHoWu2o2PgqM5n0Pm/Wy+SifTbNd3N0dKEhVEiq1Y6E6h0g=
X-Received: from pgc14.prod.google.com ([2002:a05:6a02:2f8e:b0:ad5:4c03:2b16])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1506:b0:1ee:650b:ac22 with SMTP id
 adf61e73a8af0-1f349570daamr10278575637.40.1741219674089; 
 Wed, 05 Mar 2025 16:07:54 -0800 (PST)
Date: Thu,  6 Mar 2025 00:07:49 +0000
In-Reply-To: <20250304064710.2128993-6-jamin_lin@aspeedtech.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306000749.2097023-1-nabihestefan@google.com>
Subject: Re: [v5, 5/6] hw/arm/aspeed_ast27x0.c Separate HW Strap Registers for
 SCU and SCUIO
To: jamin_lin@aspeedtech.com
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3WufIZwwKCpE8vw32zDEz0v819916z.x97Bz7F-yzGz689818F.9C1@flex--nabihestefan.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Reply-to:  Nabih Estefan <nabihestefan@google.com>
From:  Nabih Estefan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> There is one hw-strap1 register in the SCU (CPU DIE) and another hw-strap1
> register in the SCUIO (IO DIE). The values of these two registers should not be
> the same. To reuse the current design of hw-strap, hw-strap1 is assigned to the
> SCU and sets the value in the SCU hw-strap1 register, while hw-strap2 is
> assigned to the SCUIO and sets the value in the SCUIO hw-strap1 register.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Tested-by: Nabih Estefan <nabihestefan@google.com>

Thanks,
Nabih

> ---
>  hw/arm/aspeed_ast27x0.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index a48f47b74e..92487bf229 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -333,14 +333,21 @@ static void aspeed_soc_ast2700_init(Object *obj)
>                           sc->silicon_rev);
>      object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
>                                "hw-strap1");
> -    object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu),
> -                              "hw-strap2");
>      object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
>                                "hw-prot-key");
>  
>      object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUIO);
>      qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",
>                           sc->silicon_rev);
> +    /*
> +     * There is one hw-strap1 register in the SCU (CPU DIE) and another
> +     * hw-strap1 register in the SCUIO (IO DIE). To reuse the current design
> +     * of hw-strap, hw-strap1 is assigned to the SCU and sets the value in the
> +     * SCU hw-strap1 register, while hw-strap2 is assigned to the SCUIO and
> +     * sets the value in the SCUIO hw-strap1 register.
> +     */
> +    object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scuio),
> +                                  "hw-strap1");
>  
>      snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
>      object_initialize_child(obj, "fmc", &s->fmc, typename);
> 

