Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E04CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 07:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm7MW-0006ps-Bv; Thu, 05 Sep 2024 03:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sm7MS-0006mm-I3
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 03:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sm7MP-0005OF-ST
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 03:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725523016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=SNCgVIf/9lUPaD7KQzFOuXNOBtZHUzmV0SDzRSJvmdNTyVPdhCvpnaxC/VZgAzfJnJCr4r
 sBiuxrxZVyQ1+dmooZDHCchINfIQ46100zjmnlO08BbTrSL2aLZGtO/vKuE/FClPyjJZUw
 1ZOWjt/G7UtsMvG6Mv1kYegiA/d9awU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-CMHxy9b7OtycVVRF-8qUvQ-1; Thu, 05 Sep 2024 03:56:55 -0400
X-MC-Unique: CMHxy9b7OtycVVRF-8qUvQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42bb6f0f35cso3785815e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 00:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725523013; x=1726127813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=VdZGWkussRT1BdMZznYw8BLC91DZa+l17mtbgHkA8DTO18mTEEPBgEKa/fcoPyXZHE
 HlL4ivxfkhCLpah4FyPPVpOvSBDOd4eS0+QM3Rd2S4Yjl6JUi3xkUpNvhMMnYDohThwY
 ZFbwfe+Cz9NlnCdWG4ZXsORXzTXG3xCRN3bmgP3L9sLVe4zKXwdFMAtmc+xZ4dkZTs/5
 gu6o229Q7r9yQlcEvJddIyHag+IB2u5ZneXmx7E7wGWh020Pa7o6qWls/p3S5foyHTPp
 kWpD2wL+BNXjfL89XhsGro4IQKiK3RqeB/rf6zBx4ldSvdQ72MxVRbOAZxHYki0RpG25
 u7HA==
X-Gm-Message-State: AOJu0YxNdHyE1OzadA+hmArqueqhFhsVoaojwZTuhNU3FnryBA8WmSlp
 46Nlv/8zYuJUHw6Mg8Jbz/fWq/mwX5KReOfV0UdScDLf/7smB/1jvreD8M7kSG5+Cg9rJnZzhY2
 nG14wWWt4eoMeMpJJ3tQDaOHLT2x5Q4HTwMAG2Jczq+hpnp/0gl5+kkeotMjJ0bM=
X-Received: by 2002:a05:600c:5494:b0:426:5dd0:a1e4 with SMTP id
 5b1f17b1804b1-42bbb20568fmr138179925e9.8.1725523013304; 
 Thu, 05 Sep 2024 00:56:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELGBKJM1/R9ulzra6QghihjDQerm/gNbTsa1rhsy4kWWgB5n0N+EpiDoC0Wf0QpmsbOmOheg==
X-Received: by 2002:a05:600c:5494:b0:426:5dd0:a1e4 with SMTP id
 5b1f17b1804b1-42bbb20568fmr138179765e9.8.1725523012771; 
 Thu, 05 Sep 2024 00:56:52 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df7c5bsm225133905e9.23.2024.09.05.00.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 00:56:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>,
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Stafford Horne <shorne@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Joel Stanley <joel@jms.id.au>, Troy Lee <leetroy@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-riscv@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Tyrone Ting <kfting@nuvoton.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Sergio Lopez <slp@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jia Liu <proljc@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2 0/3] Serial device cleanup
Date: Thu,  5 Sep 2024 09:56:44 +0200
Message-ID: <20240905075644.350538-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905073832.16222-1-shentey@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Queued, thanks.

Paolo


