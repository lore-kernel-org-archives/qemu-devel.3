Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073FC606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Eku5XKVc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ8t9-00077Z-Rh; Tue, 20 Oct 2026 08:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Zl3XagoKCtsPQ7KIBVGERDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--stanleyjhu.bounces.google.com>)
 id 1xJ8t4-00076u-7F
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:24:16 -0400
Received: from mail-pf1-x446.google.com ([2607:f8b0:4864:20::446])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Zl3XagoKCtsPQ7KIBVGERDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--stanleyjhu.bounces.google.com>)
 id 1xJ8t0-0003wL-Eb
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:24:11 -0400
Received: by mail-pf1-x446.google.com with SMTP id
 d2e1a72fcca58-89fb6a45c48so2707778b3a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792499046; x=1793103846; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jIEy5cT5mmkkVcGKdpbeH8K331ZFV/0IWVEdNWVBdcc=;
 b=Eku5XKVcTXZmcC1vcEa6SSNM29rkx9wkII3nHs4k7L7p7PdlBnp0Ul8J1KDbXfs9YD
 viUUaKYh1z2y/zInyM97U1OZRs9qCglBeRgyIWAgdKHDuE8ESnNyu+Ne/723qNNSaPt+
 q0uisZwbwAlDe6cewZnWWQKmdjTQrfBAqpbFxIHI4SKLQNpm07b+Y2sa9CPzqjwgIKUP
 ILsApVo3VaiuGqFzCc49M4ioiokvm4BTeaSHm2/CX8gVoxWL6siUZwS/l02ZUJ8Rtyok
 Sldn8WuwlSUhifGuvkEcVWAvx8ylFZrR1NN2xs8DTZYHQf9gBgXDbnxl04W36fAsqaq8
 lfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792499046; x=1793103846;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jIEy5cT5mmkkVcGKdpbeH8K331ZFV/0IWVEdNWVBdcc=;
 b=vYFjClTLEciAxGiyXmxA3plzsmxSB8tBCG1UWoBnYIUlF437A2TuEVOlGNx60imt6v
 D0R4NIAsUsRBtaJthTedaF/4lfgMXqVp27zP2pNVdlA2aA7eBoP6HJxxT5eoasg4F+vX
 fs+0PUvs9uCLXo29PQzGO3F/dY/Bkuo4mrnzf6qMYLIk4kotV/l4gI5rcfzhfyobm4Er
 zPaLS7ILQp7hYf9l8e7k1kqDNJ6XNs4srPRr6X4gyY2hj8GgTmLaKBQDKiYUMDcJ2sfg
 WlhDQTJuBIevS0De3XtBer5V863DfOmWzyogIkp57KmkYg8cbTvTvzBFL4NptwLBTUKY
 /a8w==
X-Gm-Message-State: AFq9FYKebkmT2+h+xYep0R6Qcjd+Q25t286yI3GM1/wwv0Q/1B1o5QsJ
 yNBP1DkoXFYhRElZ+FboKixZD7c0xr/KZCp+BEhqUxea6DmBaHiagdnKuL2sHvKxljFzsVAsNXC
 B2dzc7FkSfq5/Tk9y+TNAcdVZ1FDwg7+GXyP9QOvCWvfBFUb8w5B0eCQseE8KuVlnnmTJvQcy8S
 zsx8Mt7+NcWp/OG+z0u7b8qE7L6VwygHvMmaWNbBO9NHKZ9k7BGSeO7JRy
X-Received: from pfnp16.prod.google.com ([2002:aa7:8610:0:b0:89f:ee93:28a6])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a803:b0:89a:19ae:10e7 with SMTP id
 d2e1a72fcca58-8a04ce2e2dfmr8649944b3a.42.1792499046102; 
 Tue, 20 Oct 2026 05:24:06 -0700 (PDT)
Date: Tue, 20 Oct 2026 20:24:03 +0800
In-Reply-To: <20261020001920epcms2p4004ef6eaae9fd389e5fc91c104caf2c2@epcms2p4>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
 <20261020001920epcms2p4004ef6eaae9fd389e5fc91c104caf2c2@epcms2p4>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020122404.1107182-1-stanleyjhu@google.com>
Subject: Re: [PATCH v3 3/6] hw/ufs: Check the PRDT size against the transfer
 length of the CDB
From: Stanley Jhu <stanleyjhu@google.com>
To: qemu-devel@nongnu.org, Daejun Park <daejun7.park@samsung.com>
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, farosas@suse.de, lvivier@redhat.com, 
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com, 
 qemu-block@nongnu.org, pierrick.bouvier@oss.qualcomm.com, 
 Keoseong Park <keosung.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::446;
 envelope-from=3Zl3XagoKCtsPQ7KIBVGERDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x446.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Stanley Jhu <stanleyjhu@google.com>

