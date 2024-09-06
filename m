Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC38CE7AA6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 02:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smORA-00008f-J1; Thu, 05 Sep 2024 22:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1smOR8-00007C-Fa
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 22:10:58 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1smOR7-0006gR-2e
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 22:10:58 -0400
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-2d885019558so1152253a91.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 19:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725588655; x=1726193455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdttng87aOx6hVC2CDCLNwOV2U9raQfp/qgIUeUQRfI=;
 b=ThlRg3XdPjDC36z6XJyeoZ8AFRxdHRK9jIRJ/bviQLjKxeStmc1hAaRGveX0Fgul/5
 tPjQZtuNMfUGn4ATJtn6EoQx8J249oNkfFeaGwNVufhVidb7CprWeCeXiRCiNniALU7W
 QgbFsDmI3r0PzcgGXFDeptas/pcyAeXokszWlyTQ2fC1XiuYuu8Nc5l9dGWKP0LKViPO
 P4QtD3gDpIt1td86ctCQHPdCA22Ym5rLaZ7o228nx7GCsfxM0yDHzgZ421ypAfOkQZbT
 685IXscWf53CcwehZtQcnpPTjGf8QA3dv2ahd/3SC8vclCvZT729JsYkWaLe5q52Bfgf
 iJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725588655; x=1726193455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wdttng87aOx6hVC2CDCLNwOV2U9raQfp/qgIUeUQRfI=;
 b=oLsECmV4d1xlDJBRSqP2C9bfTUodgRuloM38TvMEn6aYlIkEvDcNCfuDxCZKC8NEEN
 rtbYKCM4fApg5r2ddiHp2auFh7ZG7/JB/qf4zBkVXDowbeR/AXtQ7qS+kpid5vHQQSLy
 WlPg3b/AOME08HrreYQJOhyMobhaxOntF2fPO/xPE0Daz9U8GZGHZIoBHbsYtNkwwT8y
 6iswwVl0DdgkArPEvyn60c2qmiIXZ2VMM2tOHR6pKlcKt49hmSRCH8S/HXPGcwfhOXws
 CFa/D7sW8GH7AdAI9JK6VAeWBwiiAIPAEo70irRpIp6nlSCA2Q7teWMC4B7OYcSDlISS
 OmSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ4C22QWomM3mKqzjFKTBSGk+ueZYsldZtingrO+d6ye4caDJHqKi8G8niN15N0PDYRd8ZsTSKmHiL@nongnu.org
X-Gm-Message-State: AOJu0YyIZU6oFYGCIFTLAObq6tWJVdA/RzmuoaNz/VfG36QgvIYDHj/2
 e1cQseDdPqryrBTkbebiecZlJsP3To7q6kYE5am6UXURO2GbYM6y9E0s86apz38=
X-Google-Smtp-Source: AGHT+IGSVEF35xmkU999wH6HQrrBHvxfvI8kj9YWbIc7ToqE6MMdDTeuiOd4ue7CCsR5Dv/sUJO4Gg==
X-Received: by 2002:a17:90b:274b:b0:2da:936c:e5ad with SMTP id
 98e67ed59e1d1-2dad5194281mr1515028a91.33.1725588655122; 
 Thu, 05 Sep 2024 19:10:55 -0700 (PDT)
Received: from localhost.localdomain ([39.144.190.92])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc12a1d9sm251888a91.54.2024.09.05.19.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 19:10:54 -0700 (PDT)
From: luzhixing12345 <luzhixing12345@gmail.com>
To: luzhixing12345@gmail.com
Cc: mst@redhat.com,
	qemu-devel@nongnu.org,
	sgarzare@redhat.com
Subject: Re: [PATCH v2] docs: fix vhost-user protocol doc
Date: Fri,  6 Sep 2024 10:10:45 +0800
Message-Id: <20240906021045.20018-1-luzhixing12345@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805145703.24425-1-luzhixing12345@gmail.com>
References: <20240805145703.24425-1-luzhixing12345@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=luzhixing12345@gmail.com; helo=mail-pj1-x1042.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi, can someone help review this patch?

Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>

