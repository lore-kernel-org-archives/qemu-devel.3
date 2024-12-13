Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754B2E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBKi-0002JA-1J; Fri, 13 Dec 2024 14:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1tMBKN-0001vo-P9
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:28:03 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1tMBKH-0002Yx-Dz
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:27:53 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2155c25e9a4so15755ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734118066; x=1734722866; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n8y6uFm+wmDEuGdgtXjvxyoO93l7Tq9E2jG+Cuw/+z8=;
 b=WGeq1JSzEd0zsngc2iN2QQTa/s1/VbbY9E7coJtcSlH88ojUTxJFWFnCm8E801pK9d
 TBQOtWion5uXxoWze0CAXV7+h+AGEa8gIBmjceZuKqemR5xwOQZVRJ6Idd7Hhcy3IPEr
 0ymxIOoesFxotZIkhb0NvleWwD2bpczbwcyk8bCrAJt2nSXUXi8MtyVIIoY5paFeJ/y/
 kZqwUxk/QmYl/cfSZZtF5WBNVCemN8QJrK+3wkNHEYa7DNCYcHHXfvXLmATRASXZRSgR
 sWBo4krup/VsDdaiVCD2xzdytl551PUYwyg41Dy4kKWdjoUZaGa/B7xDTpMBO5NML4wC
 7ajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734118066; x=1734722866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n8y6uFm+wmDEuGdgtXjvxyoO93l7Tq9E2jG+Cuw/+z8=;
 b=auOrfkp0qAKH7nhWVb4ePoVNK8QV7I5L+jCATkBbV+IshvQqiN6WWtyuTciN+PjZUf
 ATo/irOXZWDCbT+8yKRAiMQYAWb5jWvacjXBIuf5klJn/KTAYAZBYWwMB4x/EJlQyP63
 pF1+qxO00x8Sgj6iEKuDC/AAFeauzCFSuz0AiyJ3uIIDupKiy03ZRugHekeysfdJLOzu
 DH4+kCNq7K/EvXFdGxKiQRuahitw4ille5xby5l+BY/gaWMKW7zXKQiEWndTtCfQ3bwc
 gHg1nn79xFrJNu72FZZjKfRKuBDpUlOgmp062l5CoMPzEUUW/8cNo/kzeKA5QwbJX+kl
 5NpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJk0VW9M4A+v1YCcKiIq7DSTXBZ5tbOGUTbSKfj3UGZ1EedqbrpoECjuYn1oSHMdyqMasZ6FLBxtNk@nongnu.org
X-Gm-Message-State: AOJu0Yxr0oVrXRVTnxyrDt69HL8H+9F5ulr9EVO/XHUCah+Ngu2qexGN
 mAvl/LieAMMLStHoTjSqTXxoeGiJA/oyoRoV5jQy496upwyInPmRpoFVn8utkapNLjBxD8kjiUB
 wPSsj0WjRFdDeqCtZnveisFcpqNXT7ipS70LR
X-Gm-Gg: ASbGnctQXcMcfw5n/9S2+Ed7E8wGp16zX9p4LSrk2/agwX0xF5DywUp/WoF6suntlkW
 LRrS3356nE2Ulfm+Ghr+8lgEHG+5uT6fQlk1T41SQqS3fE6jYfKv5gE2ko5qM1eY0Ea9g
X-Google-Smtp-Source: AGHT+IFaaf6SHCamj0lIAzIcB33qAgkUq7/qo2KRWtzeMjKPGqKuh4UR42bM+jY1YH8R4A0RiH9pVAfsBjS1pFcWILo=
X-Received: by 2002:a05:6e02:178b:b0:3a7:a468:69df with SMTP id
 e9e14a558f8ab-3b2792913a8mr186155ab.3.1734117650559; Fri, 13 Dec 2024
 11:20:50 -0800 (PST)
MIME-Version: 1.0
References: <20241213002602.4181289-1-nabihestefan@google.com>
 <f03adc63-5167-4982-90e6-70b65f0c90cc@redhat.com> <87y10jctbd.fsf@suse.de>
In-Reply-To: <87y10jctbd.fsf@suse.de>
From: Nabih Estefan <nabihestefan@google.com>
Date: Fri, 13 Dec 2024 11:20:39 -0800
Message-ID: <CA+QoejUUQK5L2LOgDPdK=kBgWgQQcvSMzXJ1zAiuwmoNwroPxg@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest/sse-timer-test: Add watchdog reset to
 sse-timer test
To: Fabiano Rosas <farosas@suse.de>
Cc: Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, lvivier@redhat.com, pbonzini@redhat.com, 
 roqueh@google.com, venture@google.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=nabihestefan@google.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From what I can tell this is the same issue Thomas was looking at yes.

I saw the failure on the master branch at the v9.2.0 tag (ae35f033) and just
re-tested it against (83aaec1d) and still see it. I haven't seen it be an
intermittent failure, it has failed 100% of the time that I have tested it when
targeting arm-softmmu.

However, you are right that with Phillippe's series on top of my change the
bug is somehow re-introduced. Not sure what the protocol is here since
neither patch has landed

