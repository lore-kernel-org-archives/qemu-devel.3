Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BA5C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 21:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmKyV-00083r-Ls; Mon, 18 Mar 2024 17:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmKyS-000838-AW
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmKyQ-0008D0-0c
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710799008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kyrs8DQKm3mB5tvpT9KIQIKSyXwZlM215EY1DJThRxM=;
 b=D7bkFqVhhWC8lQhgEy7KrSCNtuVgAlFhMQsFLn3GqLF/mShjF5kxEQ3Cb0cQEjn6hG8PlZ
 V4uqd3/vdekE8apVVupcwH/uVYTW+i7VRBBj1ArByJXwb816rFfZCQL0uqYiZKcrMHOED+
 IhbVmch86ZerE+6apmCaLEIEDE6dSVE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-FQXoN0-YN-mL9Uh2AVGVWA-1; Mon, 18 Mar 2024 17:56:45 -0400
X-MC-Unique: FQXoN0-YN-mL9Uh2AVGVWA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-56b8c7b5086so406163a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 14:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710799003; x=1711403803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kyrs8DQKm3mB5tvpT9KIQIKSyXwZlM215EY1DJThRxM=;
 b=dA+P7VXKAGsOexyd8GwQA7Vo9NLU01b1Zx242sa1BTt1ssUB6vNF1CIivaI5phNL7a
 VdF1OEsCMi09+Ua9iGXwQLjJjXlUoJ10zASzUwpiwKPfD79j2aaqQ9gItOUROKcMpU7E
 ePsFDzxQ0HQ1gtoBOteflP/VVUCf3cM+6F6PFSDgU1/YiK4Mrqf7X7Cw72EwYNoTGbwo
 Q9Z+69kO8tkAvJ9d5HwunB21RU8wOFOKqDFDBoDR7oD+P6dVPWkZ6cwUI3dPAIOEHoza
 2tKUPggYQjQ2Mr0T2PvDqGIo6kzrwvF1xU8pa2ztDaaTnjjNAEAX73/YKMnGym1QYhts
 B3Lw==
X-Gm-Message-State: AOJu0YyOjUiU/x9J/xJIEp6hGDr7+o55QkWzdzXHOWNdmGfv8XDg/GYg
 jYir/277jUZ8iYQl2GA64jBJ14Kto0E4YQefxplUxZ0O8dMvubeuIE7AfWhwi//qt5xDQYmY2S4
 fMqMhVDmEAZrHRwWSs4OOqu6hUlWhEBrTG/Zi2BonQqmvIKjGGcwN7hW7Pfx2CgcAzjbq1TXkY0
 Vh++DdAG7LsYLdh9u0NEAlD+ESoCHY/sk4BQCh
X-Received: by 2002:a05:6402:5409:b0:56a:fbe9:80a4 with SMTP id
 ev9-20020a056402540900b0056afbe980a4mr1468245edb.1.1710799003106; 
 Mon, 18 Mar 2024 14:56:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMili55tenXxfre8Uvci2WhUS3mi7plKSV4pJR8JduNyMciAIAFL6edQVgAGJb6vKm6vjklg==
X-Received: by 2002:a05:6402:5409:b0:56a:fbe9:80a4 with SMTP id
 ev9-20020a056402540900b0056afbe980a4mr1468238edb.1.1710799002694; 
 Mon, 18 Mar 2024 14:56:42 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a509346000000b0056b924663ecsm163291eda.59.2024.03.18.14.56.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 14:56:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] avoid assertion failure when trying confidential guests
 without KVM
Date: Mon, 18 Mar 2024 22:56:39 +0100
Message-ID: <20240318215641.978308-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When using confidential guests and forgetting the accelerator, the result
is not very nice:

    $ qemu-system-x86_64 -object sev-guest,id=sev0,policy=0x5,id=sev0,cbitpos=51,reduced-phys-bits=1 -M confidential-guest-support=sev0
    qemu-system-x86_64: ../softmmu/vl.c:2619: qemu_machine_creation_done: Assertion `machine->cgs->ready' failed.

Assume that the lack of initialization is due to missing code in the
accelerator to look at current_machine->cgs, and report a nicer
error error.

Paolo Bonzini (2):
  vl: convert qemu_machine_creation_done() to Error **
  vl: do not assert if sev-guest is used together with TCG

 system/vl.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

-- 
2.44.0


