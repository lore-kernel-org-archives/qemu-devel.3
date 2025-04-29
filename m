Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABD7C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9la9-0002Cj-Qe; Tue, 29 Apr 2025 10:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u9la2-0001kF-6f
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:05:03 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u9lZz-0005eC-Eu
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:05:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39ee651e419so3148095f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745935498; x=1746540298; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yTRJcztr788Tp3EvhH7sp7iab6GaQ3Jwx+0m9lrgSSY=;
 b=Sd0C6RBO/gNwlNda5Y4+C3CqV3A1ceCRS1tL8AAi+drBYzDhawpMun3bI8j8wIZdMV
 SjsIt7Z3EmDFBb3MMVTMIl/0b5gfELAVnjOv+ZEiXzbd59j8U3yxpoUgUmXS1CtCbUxt
 j9MMSQIeVdvGNuksxS8eNdFtFUZKG79vJcn7DRewymtFfQY0Y5XIsyQ2F7+ZuTtDpf7G
 aLP2NDD5T0dWCmwSzroMcy7BBbIj/OjDnhrZDjKwOoDdoV3nsDSkwnRTjJXw4jJEpdHn
 29RT+3UP6v+fStq0Se3k5rYxHLjHHkYtPm9ajT2SLZd4Xg5ryMlSMbU3Vfg++W8aSE7I
 gV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935498; x=1746540298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yTRJcztr788Tp3EvhH7sp7iab6GaQ3Jwx+0m9lrgSSY=;
 b=aao2Sq7lI9MiklmVwP434Nzk6BlcG1Hrn/Nu8do084eqHo5tVOa27Kmsrwleb/cJ01
 nHJ2s9hGTGs+nf0gVJhY62qyUXqQGLH/2SqoosSIg4mp1RQ2AoByGUl6SR6PRY36my4t
 8/QkISVObnAqqDovfYEfEJaoZnbfrrYZr1OFitJLLQDvfs2vbV8atwZaq0SPEL7anz/z
 yhRqsmX6X1MQMP2Pj/OkpEBeX+mBuKdkg99Rx3+unjnxx+V6sflaEXKBQ4w+v7Z8tXux
 AYIBDYvFEq4EaJ4HkkkwruuAEmWA1L7KUhmTBZbCkMIcdq8u/eID/BwKQylvbj/lf96Z
 UnPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn6UR3NWROTXKCBBOGyZQAtJgWNxfhqoVE8/sk7w/I4GAnNDN7jtW+irHzdzKef0iY0ZflB6CjR4bq@nongnu.org
X-Gm-Message-State: AOJu0Yyd5DSWqmgdUVU0rfLxCsqlXdVDaProqYoqRj7lfEqMJco7hF7R
 iId3VCo60m54Wy8XFUYv+keCuUXoTBo1YCHiGo4ihenAe2kcuTJnm6Dv03jjm3wExYTZTFyMvJG
 RvqeBMlhmrRtV5V5hMHbhqm/gXf9ANHxd
X-Gm-Gg: ASbGncsorvxOEu9SJ/oS3UVweg1fJkyEDtvuW6kL0AdSWTX569xhcStXqZJ/24VrYmD
 W7sjmv4JLRtOE7pEsoFpNqO2woNyyI0SPYktpb06ZSXFZ2ZVKCWHhPO1eYglybpg3JZ7c20yz5T
 coJWuSY6bk9crxcD2FfIsz
X-Google-Smtp-Source: AGHT+IF8M6KGsFOS5f+rPYRc86PmZO49kTcH51QcNaRzsJJeI8T2h2zDwJD13OvIZhh363PLmO/JH5PEW3ubY9qZobg=
X-Received: by 2002:a05:6000:2c5:b0:391:3988:1c97 with SMTP id
 ffacd0b85a97d-3a08a351817mr2425515f8f.17.1745935497346; Tue, 29 Apr 2025
 07:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250428040313.413822-1-maobibo@loongson.cn>
In-Reply-To: <20250428040313.413822-1-maobibo@loongson.cn>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 29 Apr 2025 10:04:44 -0400
X-Gm-Features: ATxdqUGhfrV6TN6WBNtPSaFeD0i55MimYzxYdXvAHQukYz6oJgaJWe75YiHaUCc
Message-ID: <CAJSP0QXKPt16JARrVNKKzfOFO1f3TYqpS5TSYMKD43q2mQhYRQ@mail.gmail.com>
Subject: Re: [PULL 0/8] loongarch-to-apply queue
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x430.google.com
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

Please take a look at the following CI failure:

Fail: The memory reads and writes count does not match.
Expected Reads: 114688, Actual Reads: 0
Expected Writes: 63488, Actual Writes: 32768
make[1]: *** [Makefile:202: run-plugin-memory-with-libmem.so] Error 1

https://gitlab.com/qemu-project/qemu/-/jobs/9865233699#L4223

Thanks!

Stefan

