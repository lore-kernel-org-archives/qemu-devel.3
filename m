Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7F6C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV1h-0001QM-6B; Tue, 05 Mar 2024 08:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rnn59437@gmail.com>)
 id 1rhV1g-0001Q6-2o
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:40:12 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rnn59437@gmail.com>)
 id 1rhV1e-0003Qt-Hp
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:40:11 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-21fa6e04835so1986652fac.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709646008; x=1710250808; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jfXBgX12vBlUxglU1EMWyCrl4xOTD0jRCm3hsT3Txfc=;
 b=GqsyZQHzUouYVUYyNe3YJtrxpLlb4dA9WOrXk9lsuzJKAOqJ/lyAziL2MUlZ84pvl1
 npGOJerEgU8TNRTdQeZ5NpCJ8JtIvPP0Dl1AH405OHvfdVl8wQm3Pmz/8BZ532dCykqc
 pFDig6oWaCJZO2/s+rhWBkvB1ndqseqHSVbfS3Yz/hcFnir81CCzx2prf2GWsmTQFC3n
 Bg3smgFV/177OIEWtYPo6Bn5lp8aS847iqfy0xW4Tykdh91qgwxtn+l0VEWDeXxrYuf6
 dgRZJtIkC/R+hWSRH3D6awkKxprmv/R+EMp3aT3QaoCEdEETE7PFdBHN3DUD0TytYIqp
 Z41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646008; x=1710250808;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jfXBgX12vBlUxglU1EMWyCrl4xOTD0jRCm3hsT3Txfc=;
 b=Zoj/7W51gJ2v0Gi5Dxp9vfdxUAiVODA7dOazhm0rL4pUhdBl/LuPxDF2zgXJXNwFl6
 y4/R5yBV13gXodCaK3tzCspAzSZbiTOWZ8OJBqvibuu+9VKPEiO6I5vB3u7gKOP1i2Rg
 Ck7ssh9nsnp+zmlU67dw+NhMLQ2/YGC/+SmG31LfnJMDjE4VFFVclPI8Rhizd0SRPhH1
 mS6Pn5m2LbwEmQBUAydNfPzhlvrzB6qWyxX5JOnDUsFJNoXZhG4vECxomFO9fCJSBxiB
 PmifooeTzHsYa40sclzfuJIvWfQRuwjM1gInnd4OI+tbOzazfupIIqFM0bqTPaL0cdAa
 a9EQ==
X-Gm-Message-State: AOJu0YyRiQYI/YUTI2C+9j6CMiQbc+QZkkFKAfsnNaUx79SZzr8rugRd
 boXwWiRCgUYAKXpqs5WodwMr094WXummlMvywtMaud09VG13sUPtzVLkewasZB3JnmqyInJrfOM
 kfLKynNERGL4t/1WzCTWptsA+Wyn6bstIm0mp7DBm
X-Google-Smtp-Source: AGHT+IFuSgHCbA4I/SAtsZeaGzjng2DAaX8byEXSMrbltipKC0axjpXQVklxMYNjDDNgLc9FY30U13Jdd+591GUOTbU=
X-Received: by 2002:a05:6870:e2d1:b0:21f:9ce8:462e with SMTP id
 w17-20020a056870e2d100b0021f9ce8462emr1592532oad.55.1709646008098; Tue, 05
 Mar 2024 05:40:08 -0800 (PST)
MIME-Version: 1.0
From: RR NN <rnn59437@gmail.com>
Date: Tue, 5 Mar 2024 17:09:56 +0330
Message-ID: <CAK4oD7BPCf5o-OR8WThb3QGJbrJnYpHipjKv-hY9rkWNOSAHjA@mail.gmail.com>
Subject: ARM hypervisors
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000125a30612e9fb78"
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=rnn59437@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000000125a30612e9fb78
Content-Type: text/plain; charset="UTF-8"

Hello
ARM hypervisors (pKVM, Gunyah) can run x86 OSs?

--0000000000000125a30612e9fb78
Content-Type: text/html; charset="UTF-8"

<div dir="auto">Hello<div dir="auto">ARM hypervisors (pKVM, Gunyah) can run x86 OSs?</div></div>

--0000000000000125a30612e9fb78--

