Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4980E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 20:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWiOv-0000Uq-Uz; Sat, 11 Jan 2025 15:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patonyolandi@gmail.com>)
 id 1tWhI9-00016x-Aj
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 14:37:05 -0500
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <patonyolandi@gmail.com>)
 id 1tWhI7-0004bh-Rh
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 14:37:05 -0500
Received: by mail-yb1-xb42.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so5274909276.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jan 2025 11:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736624222; x=1737229022; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eeVasXYtfmMZiipClpZ/HBYLshyHN20QkO8kBmS0/kE=;
 b=jmeee9lYkZvVjUib0SDuzBlkeFJ4s36ZG3N7XTW4gjr8BGb3chAd6cjBwS6KjouPCj
 hPNZfcNwCS85cbNfNM8/yIZUzgj/3j+fb08pYUNWXydH0/4UzkfNN8okO9Lmz92gYKRk
 v7vWtNq09E2VhSpDvkpxht1GjmAsnMtAJzYXtM3M/g9XouriOUBCzcfmW3mVBs7+aFVp
 GBg/WgD3VL6N7rcPTnIJtr2MQDczXTPIZObLOA5vaLxtMcbuZLwHlcoxp2tXg2n5Z59e
 tODuloH7XHFUa3ZIBmT57zqmug3Z0xCP8DT5pmHy+yH+nNIU3DQGMPEXiU2ASMLxU2Me
 EVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736624222; x=1737229022;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eeVasXYtfmMZiipClpZ/HBYLshyHN20QkO8kBmS0/kE=;
 b=SgJjW4HLxpn84ZBcRhayNje/B8rNVIgscVCmyMYt9wphs/0LhCucbJ/kgkiCMr3NLs
 gwnQN+VIzQWfQ9YPniXUsmyeNpH3vd89lhSWXh8Jen9p0JVP5xw2gIZrtEy1qukYlUD3
 GOPl6CJRTUVWSi6H/a01vUBWTmzPzysbz3VwChOuY+zUdt1tIGJHjS+ErIEqOnCYTLNn
 DQu1UeC7y8W2reWlwFosI+juYt0RWLRjJjLCU/unj4/s5h7Faaelp1CEqv98VAlkDk5b
 fO1yH449VototePFApSK3WE8XeAfCWItZKCsPscHrjkEVFSpi2kgGxdoCTA5M1jCw4aG
 FsCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhLKn/ghynNBbxMziNaUWVvM5YBbQ18LZ8rgD1SGgvZrlcXMwdnD8jy+e1kpO3IAmy5Hl9AsBFeM6e@nongnu.org
X-Gm-Message-State: AOJu0Yy3Eh1fuAo783Avi/CG7/irAiW+W0zgyDY0ByNH8A2H+GQrxwlc
 o/q7KRqAaxUOdRJt/DKtFE1YiwJNnzXB9bbHIqNQBy1SU7AO3n2X8bopyfAHOUsmGRNkrLKrzTu
 gL5Xd1jG3P/6j7EFDWrMbhelNTdw=
X-Gm-Gg: ASbGncuazlsKC/gFhlC+aFWuVBsiSa6gDaWTzXVtzNfU/XzrCBM4tOqL0twB8awuBzw
 W94X/or7QFoSqrUxVcQgglfQVfClULvT2JfEMroQ=
X-Google-Smtp-Source: AGHT+IGpBBuLRo+6ajEzNaopLe1aOslw1mzYAS5EcyLGTFfOu2U7nhGAtuxQ0xhBa08hTAkiL6YinZcCYRRF1q5D9oM=
X-Received: by 2002:a05:690c:4486:b0:6ef:910d:7847 with SMTP id
 00721157ae682-6f531238b00mr130643717b3.24.1736624222241; Sat, 11 Jan 2025
 11:37:02 -0800 (PST)
MIME-Version: 1.0
From: Yolandi Paton <patonyolandi@gmail.com>
Date: Sat, 11 Jan 2025 19:57:33 +0200
X-Gm-Features: AbW1kvY7hK_ADr6gDoQnBQ4yLKPGo5zC8zsfQ2cdbMofNzMrK0XhWgtjOtagB-k
Message-ID: <CALiQh+DB8ZREJi1iZrvrCTb0kJUS0KznW1y-34xnUKcM76i7=w@mail.gmail.com>
Subject: Re: [PULL 12/25] migration/block: Make late-block-active the default
To: farosas@suse.de
Cc: peterx@redhat.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e00a7b062b7355ea"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=patonyolandi@gmail.com; helo=mail-yb1-xb42.google.com
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, EMPTY_MESSAGE=2.32,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, PYZOR_CHECK=1.392,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 Jan 2025 15:48:08 -0500
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

--000000000000e00a7b062b7355ea
Content-Type: text/plain; charset="UTF-8"



--000000000000e00a7b062b7355ea
Content-Type: text/html; charset="UTF-8"

<div dir="auto"></div>

--000000000000e00a7b062b7355ea--

