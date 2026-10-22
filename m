Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652B6606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bUQ+J/+Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnUB-0007Dd-Lc; Thu, 22 Oct 2026 03:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3BL_ZagoKCkc12jwun7sq3pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--stanleyjhu.bounces.google.com>)
 id 1xJnU9-0007DD-Ff
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:45:13 -0400
Received: from mail-pf1-x447.google.com ([2607:f8b0:4864:20::447])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3BL_ZagoKCkc12jwun7sq3pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--stanleyjhu.bounces.google.com>)
 id 1xJnU7-0002FB-KB
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:45:13 -0400
Received: by mail-pf1-x447.google.com with SMTP id
 d2e1a72fcca58-8a06750c74fso1276627b3a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792655109; x=1793259909; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h9LtJhiuV20L7P+cqCFAj/nXEKIPKKWWjKIXKSHW2KQ=;
 b=bUQ+J/+ZN3lH9N6hyntR8WLMvv9LXnEgbw7rS+bCYUeEYolptvbVD/q8xu6Qv2FciB
 TeWZXl4vHdXPmDh7whX8hSTMpLtinEczZrcuDVvhBnqoonOinTDZQFYWzXyJbKuWTBUU
 g/B4lox/JzIe4PkpPrPuE0R1OEohjF7lt1/npfpHHtgOxYeOF+KxihwLSY2QioI7QUzB
 JxpXilqeWm+Wx0KE8DMh7Fkzz0Moiewu2OPkwWUHhT7zanvbZCPMV6dntA49qbG1Y7bX
 d0IzlxBjfYQfF7UuDh0GJoy9zqTuDXkvIqzC4Dywe1fRmfZtrHiJkFQaAID+Zls1lMdG
 WnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655109; x=1793259909;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h9LtJhiuV20L7P+cqCFAj/nXEKIPKKWWjKIXKSHW2KQ=;
 b=sFGG71tGqakO4gAA4vUaZgtU8PbFo4IPmnjbax4Nbm4OeOzQ4s/Ke3s+jtJ1K0QToo
 xhLyYnNhRCKDdUAuLZA11quqw4O0pknb+jndW4Fx8ebYR4VyQBJ1hMlQg7YDIO0pAcKs
 J5fGgLYJjpIgBlfjG6Cus7e552WbgCSy03CjmWQbKcl3e6z7+LG2NhWFXXY7O+Lg3sfJ
 6WEjvY3HGY93s+GqA1PIs9gq8H7XJkoioYi4P5q88dYuz8tmO9ZI7UidMYju16bHRxEb
 3Zlmtm/O1TVu9oJa7k7ZyyEOViPRQWtjAm8y0UAYboZ9P9ea8yiB+6cT0iV91JzqR70E
 sjDg==
X-Gm-Message-State: AFq9FYJZ2VM34E7PBZlMJ9ZAzw5q9bu9TlzSc/EWYYD6W6pcdylDFrn9
 SXMzrTsSarxLaPB3a9GAkj8WLjzZlhKrb8480EBYbIpzerZUsS4oDQQTEcT80jBeglMsr3lJ8Ve
 fbhkqhZcvgImlmRR6MNlu9g==
X-Received: from pghu21.prod.google.com ([2002:a63:ef15:0:b0:cc7:a4b2:4040])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:2d4b:b0:3e1:6010:fb16 with SMTP id
 adf61e73a8af0-3e287e13339mr2826039637.23.1792655108614; 
 Thu, 22 Oct 2026 00:45:08 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:45:06 +0800
In-Reply-To: <179256249332.381710.14668490787591510124.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261015060827.341298-1-stanleyjhu@google.com>
 <20261015060827.341298-3-stanleyjhu@google.com>
 <179256249332.381710.14668490787591510124.b4-review@b4>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022074506.2290451-1-stanleyjhu@google.com>
Subject: Re: [PATCH 2/8] hw/ufs: Handle task management requests for
 fault-injected held requests
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::447;
 envelope-from=3BL_ZagoKCkc12jwun7sq3pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x447.google.com
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 15:01:33 +0900, Jeuk Kim wrote:
> Is it intentional that in-transition reports successful completion
> without executing the SCSI command or transferring any data?
> 
> If this is intended for fault injection, could you briefly mention it
> in the commit message or the mode description?

Yes, this is intentional for fault injection to simulate a command that
completed in the grace period before the task management request ran.

I added this clarification to the commit message and code comment in v2.

