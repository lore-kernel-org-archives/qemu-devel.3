Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F66C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbgq-00014O-IS; Tue, 01 Apr 2025 09:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzbgd-0000yo-Iz
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:29:54 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzbga-0004Y1-8D
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:29:50 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-227d6b530d8so100004235ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743514187; x=1744118987; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoNMMfSSUKhpI6pB0JgIIhYjik2yHZOiDZC7hnbJbH8=;
 b=AGrsqe7pLAFjFr8rcXjZgCj8oZD6yUM7YmYLgD+TS2PVjB6haVESD2dpVyOgTGUYE/
 HsjGR/RYUPsEMBYFk5NgyMxvwegIuOOc23DGGefwnfUs2p7w//bcjr6MhQKw+41v/A/x
 o9rMtjHVqVn97y3KAoz1MIt0mQAO4YdmUJfNZcU8sQRVrGx7x64Gx/zjOpBWTGkkaKXW
 xnnJSS4hy6oLbt601IssiaHBzG0m2myPC3U3lBk/vHOQN6Gmb04SK4KfR/AmQjBxCXJC
 gF9w7MkDZ+KG1+GD1Pz9Pp/e+HKG6h0QW3eZgZKGGcccEiFQGkWwLrlORxwtf/vQZQUq
 KQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743514187; x=1744118987;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qoNMMfSSUKhpI6pB0JgIIhYjik2yHZOiDZC7hnbJbH8=;
 b=AMONxFpqaOkBCE3bz7vatbMB5PB7IccAPC/RPtifpIk9y18ym/n+dNixw+JLf+x4cY
 BEcylqZwJQZ4TJr+GkDhCe2xOCFDKfM4yHLUlFVlWCmyUCEa1NN6y+YIzZ2XDiQZRicN
 duUCb8ToDJUGBqqmhhMlpvGCOMGYwOxP/q06Zv9EhqhhSfzhQXFs6ECAhYKOdNb/UXtJ
 i8o1BUS19THxNOhlUODB72JPwrwcaUQhq0uYNkvUdxbV9aywDS4/ONnUrjBTOlBYLfFO
 ZI8M0Wov8JezCyaRY422MIDwrEioLa3cnQdTKe5esaMDdP+mPVmga387FZVSPvZGGcMU
 7FkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYbIgze5iE/NJlHGZGNYaR9kAjF1f3SqS/S4etb2H9+5rIqcC1dleRbKxgs72HXmzkzlo3GibwOyW2@nongnu.org
X-Gm-Message-State: AOJu0Yy3MQEgxkn23a4VDehrLJDZU64M9jep2ApgTrtRKkqbVNMUFf8R
 l4rBkdtrjikvVBAs3TM6hm5iaXYha9Fz95Jr1PX0LkdMhxaeDdnF
X-Gm-Gg: ASbGncvi85ZRVaHUY9iamD7JnyMcaj8la3FK4xCQPxwuH6ytwIbc7TlaMTmVq1OcGj0
 zm9hMl7U+UwOeBvR60FnYizrM5AMKvNGLXoB5nFDL2BA6AOnNQS1cMYr38HGGIr5OMx7p5m30+d
 4N3N8v4Bh6AnSSudhZhI+oT0jPjxYWq3r4G1X6std22eRqkdZr77d+cEH1DLJlb6FhLP8+p/EpX
 906jWT0wTqvv239ZvadCvDWfiiVIjUOnlQIx4T8D1kXiWOfgEWJKRgHa708K5jASXB0qmEZdtSc
 CTmafRISsOa3F1B5lo9Hd6r3BM2SBQqsYzAmZdw=
X-Google-Smtp-Source: AGHT+IE3TFwBHo6aIvS1/FAPnG/jouNRMBrH3rN3fwhx1tK9kxY/dFjmFblqeURcqp3WdQvWf4Csug==
X-Received: by 2002:a17:902:e88f:b0:221:78a1:27fb with SMTP id
 d9443c01a7336-2295be31744mr46817655ad.11.1743514186642; 
 Tue, 01 Apr 2025 06:29:46 -0700 (PDT)
Received: from localhost ([203.185.207.94]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1dd292sm87902575ad.185.2025.04.01.06.29.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 06:29:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Apr 2025 23:29:42 +1000
Message-Id: <D8VC722J57KG.1HJIR72IRFBPL@gmail.com>
Cc: "Corey Minyard" <minyard@acm.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/5] ipmi: add fwinfo to pci ipmi devices
From: "Nicholas Piggin" <npiggin@gmail.com>
To: <corey@minyard.net>
X-Mailer: aerc 0.19.0
References: <20250401114412.676636-1-npiggin@gmail.com>
 <20250401114412.676636-3-npiggin@gmail.com>
 <Z-vljw1_-im7VR-l@mail.minyard.net>
In-Reply-To: <Z-vljw1_-im7VR-l@mail.minyard.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

On Tue Apr 1, 2025 at 11:09 PM AEST, Corey Minyard wrote:
> On Tue, Apr 01, 2025 at 09:44:09PM +1000, Nicholas Piggin wrote:
>> This requires some adjustments to callers to avoid possible behaviour
>> changes for PCI devices.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  include/hw/ipmi/ipmi.h     |  5 +++++
>>  hw/acpi/ipmi.c             |  2 +-
>>  hw/ipmi/isa_ipmi_bt.c      |  1 +
>>  hw/ipmi/isa_ipmi_kcs.c     |  1 +
>>  hw/ipmi/pci_ipmi_bt.c      | 12 ++++++++++++
>>  hw/ipmi/pci_ipmi_kcs.c     | 11 +++++++++++
>>  hw/smbios/smbios_type_38.c |  6 +++++-
>>  7 files changed, 36 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
>> index 77a7213ed93..71c4efac8cd 100644
>> --- a/include/hw/ipmi/ipmi.h
>> +++ b/include/hw/ipmi/ipmi.h
>> @@ -90,6 +90,11 @@ typedef struct IPMIFwInfo {
>>      } memspace;
>> =20
>>      int interrupt_number;
>> +    enum {
>> +        IPMI_NO_IRQ =3D 0,
>> +        IPMI_ISA_IRQ,
>> +        IPMI_PCI_IRQ,
>> +    } irq;
>
> In addition to Phillippe's comment, can you name this "irq_source" to
> make it clear what it is?

Sure.

I wonder now looking at fwinfo if I should put protocol in there
too instead of in the class.

Thanks,
Nick

