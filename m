Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C077C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 00:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAIRO-0008GG-I7; Thu, 23 May 2024 20:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAIRG-0008Ep-8k; Thu, 23 May 2024 20:05:38 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAIRE-0000qL-1v; Thu, 23 May 2024 20:05:37 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-65b4d0a7391so3481867a12.2; 
 Thu, 23 May 2024 17:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716509133; x=1717113933; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZlpFsB4GX2xB0Mmw0BUihwjnuGkctZdR8IDA+3wSXIE=;
 b=iuuqOzIfzk5TO/+0dy0nL/7A8//pJepUjVE8EbS0kHoH6s6UNEQzZEDJNGO/3Ee6N8
 AOmBMTHD+x8aG7Fk+PoEqUMnIf1YVmcjX0cZd0+C4NAD3ny+snkJsBjJFrUbYoz1mQsd
 1cgGxVH895vjKxJITc/XsUHJZ014YgR06k8Ej1fPU+T4dpek56BmhwlDPFak33GkfwYU
 G0Gm8ewmnH0iLCyz+tm1SHgzJf2gZZwKck81n5NgYNb9XlWe/E+vgYN8ju1pISQhqOXD
 +OhC0+UfsIU1mOosD1/7QbPq4KOULvm66THkWFwrMFUofylCOS9DLwOhv/yemM0QA6Ty
 ieEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716509133; x=1717113933;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZlpFsB4GX2xB0Mmw0BUihwjnuGkctZdR8IDA+3wSXIE=;
 b=oSHDIWDyi05AOzoJdggVCGxPbLqXnC6vaj5dPYc7jff0dkQb06qJAb3GOEpoHdgl0m
 4dTkehJ48NaP1ziIaYe/LqfqXCv4qeXxalBG49UeR4y3CJbpc4A2MEbAG281fJoELTRm
 wIxoHXLUUFpeQUubzBqQD6MvR6gU8B8E1Hj41bBF0AyF55sqnQ5ypJzRSLSzDqvPiiFK
 IpXwVPaaj9afLMG6l0TfyKN6MMr9rWDZMqvap/Y4ymzFNZtCF3cAo5b/TMXn+Zgw8bXP
 vmdQRB8igmJ7Pb2Cc8Hkg4YkezgmmayizejiBDbSOyTKqKztCknr6U+OK9DI009zkPf2
 bwbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAsLUoDO9JoOu5iE2sHBc7kbFQ38hQoK6aRhicUU7Vi3GVibECq/wokh/YJSyHnISQXFFUGHfVgaHYwh/2xzyJ5EsHN35JhvGU3zmJ/VfzpfXijMmy9MTIO0VNgiGrkoRXLGD1l1fNWI7EHWB9+hS5Vg==
X-Gm-Message-State: AOJu0YzQGmojvN2JniB8d86xVLHUV/XhElZ3jtonVM0TwHkF4BBsbhib
 fHrvnO7x5EWw2eb4OrbkKgm9UakEX8F0fSgw2D88vE2hnWGHT/vDDnYtLA==
X-Google-Smtp-Source: AGHT+IESpLN4FmFJ90odmMmyH/5hOStLCeWkZUB1SY02TUBt19hpQxVtwbZmJuwqnWehRR1q6Ur1gQ==
X-Received: by 2002:a17:902:d482:b0:1f2:ff28:c751 with SMTP id
 d9443c01a7336-1f4497df4demr9117135ad.47.1716509133402; 
 Thu, 23 May 2024 17:05:33 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c7b53bcsm1593495ad.90.2024.05.23.17.05.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 17:05:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 May 2024 10:05:27 +1000
Message-Id: <D1HFPB97OMKO.1ALCD8QC6OJ4P@gmail.com>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, <qemu-s390x@nongnu.org>,
 <qemu-ppc@nongnu.org>
Subject: Re: [PATCH] tests/qtest/migration-test: Run some basic tests on
 s390x and ppc64 with TCG, too
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>, "Peter Xu" <peterx@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240522091255.417263-1-thuth@redhat.com>
In-Reply-To: <20240522091255.417263-1-thuth@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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

On Wed May 22, 2024 at 7:12 PM AEST, Thomas Huth wrote:
> On s390x, we recently had a regression that broke migration / savevm
> (see commit bebe9603fc ("hw/intc/s390_flic: Fix crash that occurs when
> saving the machine state"). The problem was merged without being noticed
> since we currently do not run any migration / savevm related tests on
> x86 hosts.
> While we currently cannot run all migration tests for the s390x target
> on x86 hosts yet (due to some unresolved issues with TCG), we can at
> least run some of the non-live tests to avoid such problems in the future=
.
> Thus enable the "analyze-script" and the "bad_dest" tests before checking
> for KVM on s390x or ppc64 (this also fixes the problem that the
> "analyze-script" test was not run on s390x at all anymore since it got
> disabled again by accident in a previous refactoring of the code).

ppc64 is working for me, can it be enabled fully, or is it still
breaking somewhere? FWIW I have a patch to change it from using
open-firmware commands to a boot file which speeds it up.

Would be nice to get to the bottom of the s390x problem too :(

Thanks,
Nick

