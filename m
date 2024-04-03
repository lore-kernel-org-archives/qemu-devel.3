Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32328C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 05:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrtcU-0001Gl-OF; Wed, 03 Apr 2024 01:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1rrtcT-0001GO-4m
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 01:57:09 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1rrtcR-00012P-9c
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 01:57:08 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e6ee9e3cffso456957b3a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 22:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712123826; x=1712728626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=che7CbvKo9DjSqc/GhcX7+6YfmwHehQlINCx1kSw3yM=;
 b=CbwxOXnivLzAVWr7wZ/Bzfg/Ff+I5AX2tpEpvQKQ5kob0SFQbkxkeer3uJlTBegPon
 JKR/cUx9V4fahexycQ38CJme04PR4h2WNfaz78foNBZDlTeBTYhotBA6WIgfPvU1B8vx
 bKQ6gw6Fy/QqUjujzz6RMyAsxQA9YfLSqgxNZS/HZef+e74UchGmaSI49PgxFYae1TZe
 ba7VHFjRze+UPS8sO6+6R98vvwoSKMxokqcvUxH17Zv6uzKHhMYZ39jt2s7k/+Xun6uS
 r9PPABjo9kyirI2XKMHSCE+EMjxqG6a+vvn6YJpbSXH8Pdx6tKXrduJMxFstqBBoqbax
 v/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712123826; x=1712728626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=che7CbvKo9DjSqc/GhcX7+6YfmwHehQlINCx1kSw3yM=;
 b=MFRGj+Ck7Bjo/ystwxzxLRsOa0QqVnMfDaG51X2EjeLTR6gtRwfGK5J/YI+38MMus3
 HO+BacyN3DLCSO/ow4JDUn46yrayzxZqLTq1fTD+qTOuZEiD/i83YnaJ+4teMB0EOuno
 N6bQopQmk+/dYNvbuw+VER7yez1jrMExJf02bw8TQ7KO6ekgNmvetdwfKChXy9lWAk1c
 ax9UMmS6GLRbujKisFo6Ako60Ojv9ZjplpLVAbnWY9JmhCG6s9uVy/rnsFHRRI2A/Vde
 d6P6j0QjcNWt30AgfOV/fqvrG1d6etsqkPHHv/xqrXvXVrip8y5/mkG7bDjoORyYVBrG
 IKpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0NRG7OAAhDIMBnUoXZk8mlLDPzQylM8ypDCmnI4ygzMvGqTAn8iU9rjkrtKKVV15hw6tNzsGNwnb7HPA0pfn5G7VcP2g=
X-Gm-Message-State: AOJu0YwMpxW096LBSe6uVZTaTUb35/kUWDa0gUVCEuUhmwAcLYJx3OI2
 eTLnwYEOKjzYtFpAkVv/VMt4HJMXO3PJOmJkKmUtTViGMf0uRkIY
X-Google-Smtp-Source: AGHT+IGEE5HslAzbZnWwkV71JU5ir+NMwdLuNzo+1vz8SwmdA2nJH7LNvQRqYogB5UDnqoquZqL5mw==
X-Received: by 2002:a05:6a20:7f9a:b0:1a7:17a:9ac1 with SMTP id
 d26-20020a056a207f9a00b001a7017a9ac1mr2151515pzj.1.1712123825757; 
 Tue, 02 Apr 2024 22:57:05 -0700 (PDT)
Received: from localhost.localdomain (c-24-7-119-110.hsd1.ca.comcast.net.
 [24.7.119.110]) by smtp.gmail.com with ESMTPSA id
 r24-20020a63e518000000b005bdbe9a597fsm10741572pgh.57.2024.04.02.22.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 22:57:05 -0700 (PDT)
From: Justinien Bouron <justinien.bouron@gmail.com>
To: armbru@redhat.com
Cc: berrange@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 justinien.bouron@gmail.com, kraxel@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] input-linux: Add option to not grab a device upon
 guest startup
Date: Tue,  2 Apr 2024 22:55:50 -0700
Message-ID: <20240403055550.893195-1-justinien.bouron@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <87bk6rnhca.fsf@pond.sub.org>
References: <87bk6rnhca.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=justinien.bouron@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Missed one little thing: the doc comment needs a (since 9.1).
Thanks for the input, I just submitted a v3 with the missing "(since 9.1)":
https://patchew.org/QEMU/20240403055002.890760-1-justinien.bouron@gmail.com/

Regards,
Justinien Bouron

