Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7455CC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5eJ-0003Wp-Rh; Mon, 04 Mar 2024 05:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rh5eG-0003WZ-H0
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:34:20 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rh5eD-0002MR-3k
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:34:18 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412e784060cso1752115e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 02:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709548455; x=1710153255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ofq/jPCi2HYH2e2H03yzoUa8fKZ8YrDUZOe3cB/Sm50=;
 b=lHJv+mg2ZiQv3XmtCatO36W3wvj2V+AXLLmo89jyGnaIWuB7r6DrCv2smBZHTjT0fs
 MqI5jvP5+K/cPCh+DcOkgSwTzJvsQz13cW8jlGUMBMlA6jSDwsrlckRWNrbTqAdrSoO+
 QCVBfLE6vl17srZ87A7onmE7+JELSzWw83fcraPo0QaFZ4TWD5FO8Ie0BILUiRV7R1mS
 M1nSpUrhj9bcmfeoNRSMHop4DoPAQhsEJahm8+xiWkzlyo9dHVGCVcZJl7WaB99s06S3
 pz9E3ywuZvp2UkgSqe3rWzLrZn11a1TFVO31doUhnCPIt9k+481ZcspP10ZC23QjE1iq
 Gb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709548455; x=1710153255;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ofq/jPCi2HYH2e2H03yzoUa8fKZ8YrDUZOe3cB/Sm50=;
 b=OacmeXL/zyu8YDWd/t3hJ/+sfuV777bN8iomvgQtnIeD29AwsxEjy/sMqof4tUVzt/
 UTdGppcEo7SCyx0SYeZrRhlgAmkbVA2kqLDEJzIrVpEEZjkX0KnIfZdqMWoFGGnzOiyf
 6zX9+8L+HqKOIiXuarfM9C4s56AoJmigBrPSEwz0PpqtCx3QCkjxt+HsuF8EjbAGWzJh
 4yzeIZ3UfnVuopk8WXBTtxV0RA/pa1y9IlAsLkLX2tZoG3Lo3A4S+1/uzgj5IqPj0mJG
 FpBolMx89IgVipDYi6iVxTWhl5kKzw169gnwKIn9l2fbrhv3nUpprkOV4tuVjR6lq/YR
 EkeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY2XS9y5C8e90pYGuHkEIBG5DOQWtgYBm11xBe4DaMEjeU1/lAELo6m1gL/Z49Lbaqa2kuNh73/urzxHYMyOYixguA5mc=
X-Gm-Message-State: AOJu0YzKOhCMma0jNuo/8kkb9z9u9LVGOpnqZhRxlfx4Tq9Rkc44YrqD
 kYji8OSArGm4xMQ6sY7ffEjufyO/nmr6ogEkZuRRkJvPFdGe1+OVa/F8UEEv0Xw=
X-Google-Smtp-Source: AGHT+IHXOjsdAogkq5lOsQPszea2cOVw1airWLtA7jDNua8v46vted4kDNfS6E7fMU+ZvpyiN3P0dw==
X-Received: by 2002:adf:e9ca:0:b0:33e:1bc2:c392 with SMTP id
 l10-20020adfe9ca000000b0033e1bc2c392mr8889429wrn.16.1709548454737; 
 Mon, 04 Mar 2024 02:34:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 cr14-20020a05600004ee00b0033dd06e628asm11843621wrb.27.2024.03.04.02.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 02:34:14 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CC1C55F7B1;
 Mon,  4 Mar 2024 10:34:13 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sven Schnelle <svens@stackframe.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [PATCH v3 01/12] util/log: convert debug_regions to GList
In-Reply-To: <20240301174609.1964379-2-svens@stackframe.org> (Sven Schnelle's
 message of "Fri, 1 Mar 2024 18:45:58 +0100")
References: <20240301174609.1964379-1-svens@stackframe.org>
 <20240301174609.1964379-2-svens@stackframe.org>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Mon, 04 Mar 2024 10:34:13 +0000
Message-ID: <87jzmiz3oa.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Sven Schnelle <svens@stackframe.org> writes:

> In preparation of making the parsing part of qemu_set_dfilter_ranges()
> available to other users, convert it to return a GList, so the result
> can be used with other functions taking a GList of struct Range.

Why do we need to convert it to a Glist? When I originally wrote the
dfilter code I deliberately chose GArray over GList to avoid bouncing
across cache lines during the tight loop that is checking ranges. It's
not like we can't pass GArray's to plugins as well?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

