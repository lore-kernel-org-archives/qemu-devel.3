Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CA3C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 00:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taOav-0003ju-Fc; Tue, 21 Jan 2025 19:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1taOak-0003im-32
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 19:27:34 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1taOah-0003ow-Mz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 19:27:33 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28a4fccso9793797a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 16:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737505649; x=1738110449; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hhkUE57H+JeZlesuzbtWmr62Fdr8ur0t4mgxlHXfY9s=;
 b=FDwVQtK7yq1GFZeRYNLGbXRlxGUDoZ8zMCho0iOEqD+Rmwk/zW8w58ua1mcirZix9S
 ldyAhVRE9cu3/n/44UDkfS7YtESKk2ACV9Wi2rILCPiigLRjz+tq8wllpkqrCP+tUmyQ
 Bm2IL0yH63I+LVpSr6BJcuczXNX8m1IVntTIp4DNVfrTAKqhlsGodzOo2MwJI3nT5Q7H
 s8P9hv8+5co0dQ/CscYVOKzblKZy+1QjARDHik6qwKJbUWisloKM5jKwt/XfZV9TRv+C
 mmd4Vp1nOwZ/MsgCmogJxItD9oFQ2MO+4pg+zNEGKyPvsKQaPIrXroHRjjUFlezQYK1Z
 t5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737505649; x=1738110449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hhkUE57H+JeZlesuzbtWmr62Fdr8ur0t4mgxlHXfY9s=;
 b=bzUD+uEAxm2EnImWSFeHmHznbdyiMUoXbkqleNUUvqE1GyK1UAtD2/d8N7mnIw6Tpm
 c0NQ7WqFyt2G4FvkXSTldgUc6U5GBPL1Z8KD1l0lSmyZrpbEIsdIlx/7aW0C+Rd/GL6w
 TOVCaIbnDXJr8mt4EXhFRhiwYduQ4Z75IT+YiPkT55kgI/krD6+olLXm0Gj5aplqavfK
 bnV6XQ6DbIb5nPzgj4uHtzCV4aGaKvHmaY7VgjQnlVQsqdniGmk0H23Zby/J+OPVrhRr
 JFiQtz0IotC1bjdPqHigE+RnrKL/D3zLpBMbOKwtiS/1X2yC10N2PHjdVcGF12tILYX2
 iDcw==
X-Gm-Message-State: AOJu0Yxu0sfSRtCJJ/oUNRp2G1KsDt2NvOC0cczXOP0db+fRWBfCgmBm
 oVzN9FqSS8aakuk2HU2PIppNkTOlxDg12MrZ7u9Ygw9cfEnd13s2FV3AcQdUj5mfoMUiz9FxNDi
 JumLryKoQvnHnQBzqDXmVKGPTa+E=
X-Gm-Gg: ASbGncuoeKnEWB31k6SEawKW3j0dmXNxQW8pvtrMD64wE8tn7YIuVObVbgN8Xvc0hjs
 Weh8URRHBJ9Li5vhvhCGrNci+brR1HB4V27ElrTLibGGUpc82wg==
X-Google-Smtp-Source: AGHT+IEogVlmfuWq6Wxs+PB6xopy7TFGEQo8OFQxCS4OViugkru4Uwsght16cus6I5yj0Vn39znQG2egRZIRxodNcco=
X-Received: by 2002:a05:6402:dd6:b0:5db:e7eb:1b3a with SMTP id
 4fb4d7f45d1cf-5dbe7eb1d88mr2451439a12.10.1737505649352; Tue, 21 Jan 2025
 16:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20250121105613.1286672-1-thuth@redhat.com>
In-Reply-To: <20250121105613.1286672-1-thuth@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 21 Jan 2025 19:27:17 -0500
X-Gm-Features: AbW1kvZHjtU9yTwh7mzET_w24IWRMu1bik9oPeLSmoGI4Rsmha-jtkda7poAK90
Message-ID: <CAJSP0QXSckBRdx_K4Sg92D9uyZ7jrF_Owry9WhmKOt6B_jF9Uw@mail.gmail.com>
Subject: Re: [PULL 0/9] s390x and test patches 2025-01-21
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
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

Hi Thomas,
Please take a look at these CI failures:
https://gitlab.com/qemu-project/qemu/-/jobs/8913471007
https://gitlab.com/qemu-project/qemu/-/jobs/8913471508
https://gitlab.com/qemu-project/qemu/-/jobs/8913472011

Thanks,
Stefan

