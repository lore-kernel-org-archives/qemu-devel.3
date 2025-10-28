Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CD7CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhVH-0000Ua-BX; Tue, 28 Oct 2025 07:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDhVF-0000UC-1L
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:04:37 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDhVA-0007vk-V5
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:04:36 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-78356c816fdso60153217b3.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761649469; x=1762254269; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tWHUIaJvjld25LMD4JJfVo5vsIQnSzo8LIAk/CeYi6k=;
 b=BsGsomSoiUzTQexpAyQzemNrzuRMKlZWyRRJROkPD642AL7cCVBWHx529AhUiqVcAg
 xMV3+cbHXX5nfqvLAqFPwMSFt8PSBPWFvyqJFGdhMGq+abkXpK9wrDhIMBQ9JzSHG/+U
 aF2bA4M5WUY4ocoS6Bt+6Aqar3O+vVQ3jwJOEkpYDQxzNnboKe2G4/N0YGj+yMdbLimt
 dgpSrzM7xJpkXs03Q33ShpEwvbKwlNCvTLK8pSW+6wje2lLrqJvfkvFjLs/pKHKuv8Ba
 zrlutbC0WLtVW9B/zXXL4YTSoaSvrKoO/g3FHOE0x/oH7+QTdoRqAP2GcPV3cH36gsyE
 +yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761649469; x=1762254269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tWHUIaJvjld25LMD4JJfVo5vsIQnSzo8LIAk/CeYi6k=;
 b=dCQpDFIGh7mypz97l45z086w6Ao11VmDJmcFtjx1FcPYlekBomMaUC4vk5CHSnAYQK
 RUdyUHs6kWhMQCH0PjDPLEKESEmBK+KZrGQAW4wFLAkd9xU9x4Oj2ZQAq3n1qELKEUVR
 lZKNLzvcZvDgr3xm0p97PI7B9xLKdJGBH79S4+g4mto53jU5fRCQae2YkVbDzPQ0mRDv
 mA53iEErbbPuPmr+KiVaL1RMOUagFtm6P81U+pSF0QT6tpTjxUrsSmOaBfAuksJ5wv+S
 S5sml8o+kwEAGjxzwqHdR19itoi+sU/GK+R55jbE7YhTqfIeEsHs7VWAAC3FFDuUfZ8X
 YzYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL+z1Sy7iG2pd3Qa9pIXlHADQc1dk6GjBjZE9VWqvqnRnsaEV6Lmtqtj00aIWgd3XCjhD9gUAjnW21@nongnu.org
X-Gm-Message-State: AOJu0YwO9L6WcDzD4kxGkIv87UmZFfULhCXQ1k9wcKZReDY89t151fCQ
 oE/MsggHXdDdKnTQS50bVQ0q/GM9A58fWvYYRkQwG2w8nubqbsLrWa7Z3AAenTMhdOIPgOh/ZgS
 nUPnEdfy27tZfHxCMY0O/kfxMx/I7YIMSYN4D94eRRDtmZLsigpbJ
X-Gm-Gg: ASbGncueR81rQKsj0rA/AZgDo5izdhtZbbv1vjWOrxzI9kv8E3H/NK/BISzUaTaELt+
 8qQE+zUTsfvScnzCKI2vrdpG1Qjxia99wpZj8WSQMnup8bW4Fu9ookME+y5kq6EE10D+0lolspj
 W0Nw8E2+iaQHkpLWx9ShcHk5Edgmx3GYCb3QHUevTJdvnH3VQB5iiUHJPXQkPYnp8wGLzY+Qmpf
 4cONihV9U6ZJR0HZ3KDj+VPDzaHOKErrIq0W+lFj0FrJ4JJHsJ6QEr8H/vTFw==
X-Google-Smtp-Source: AGHT+IHSux5VKcf7/PJatrLoeJk7LGBxEAJwvF+XwdKSnMVUr5jJjWw8SXiBxVGXuNfYyl8G9JUmfLB5D/Pwytyt8tE=
X-Received: by 2002:a05:690c:3512:b0:784:8b82:98d2 with SMTP id
 00721157ae682-786180124dbmr27912867b3.70.1761649469122; Tue, 28 Oct 2025
 04:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20251022101420.36059-1-armbru@redhat.com>
 <20251022101420.36059-3-armbru@redhat.com>
 <58177628-7349-4450-a4c0-58bd44b39586@redhat.com>
 <87qzuniadg.fsf@pond.sub.org>
In-Reply-To: <87qzuniadg.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 11:04:17 +0000
X-Gm-Features: AWmQ_bknrb22uhaqGW666LhbHoh0235SAUjCf5QmzkeQyhln77B0SIylrmic1vA
Message-ID: <CAFEAcA9bpZAKgRpU=38-eMiSY=4dKdT8uQNFW0Uuk9y_Dya_0A@mail.gmail.com>
Subject: Re: [PATCH 2/3] qdev: Fix "info qtree" to show links
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, 
 berrange@redhat.com, eduardo@habkost.net, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 28 Oct 2025 at 10:34, Markus Armbruster <armbru@redhat.com> wrote:
> The problem: PCI addresses are integers in C and in QOM.  Makes sense.
> But "info qtree" has always displayed PCI addresses in the form DEV.FN,
> which also makes sense.
>
> The pre-QOM solution: qdev property method .get() returns the integer,
> .print() formats it for humans.  "info qtree" used the latter.
>
> Aside: "format for humans" may well be more widely applicable, if we
> care.

Relatedly, there are various places where we define a "string" QOM
property and then format that into an underlying enum (though
it is also nice not to have the enum values / representation
not be public facing ABI)...

-- PMM

