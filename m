Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685A8CF0423
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 21:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syHeG-0005XY-42; Tue, 08 Oct 2024 17:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1syHeE-0005XP-PY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:21:38 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1syHeD-0000eu-Cb
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:21:38 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-50ab6eabc32so1817648e0c.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 14:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728422496; x=1729027296; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NlZCCezkoH2ul+oS+0d3dwnkJQWAGa4Q1kpveU48H1g=;
 b=iEOqIuPY1E4Bt0TF/ErzhDOwI3q9ym9wgu7QY3tSYtjKFB2TKLvCOq+oWy8unx1akA
 b/uBwzOIRFrCYFKy+bi9ELrLQDYmFCdS4ZMrdgmggVHXSZbtYnRQnknklVfAW8CcL4Sv
 Bd7VHjibzbFmljdougqfg4SoIXvvo/D79h1ng7Xv9+cCwYM5T0PhlBmAimZIH+3NuMyS
 TXJNOo1F5Amkb8GMkni/lyNKO+nFuSZdvlm5N7ETvqiFMyPzRs5KtZ2TaJx/2qFKbL0g
 2DiLXYSzFwZhV2GbhsckY2sKJu6g8LOGUfxSmKajtAHRefVax/PkhXFhxEve86cOFrwK
 y8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728422496; x=1729027296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NlZCCezkoH2ul+oS+0d3dwnkJQWAGa4Q1kpveU48H1g=;
 b=qIx1siETKqJkldRpVh4EHcjVFkTCPThFl3V2HCEHrqLV6Uu0kYCIG79iJh6AsBVwn2
 AXB5I5VcG+U8TbXX0qYPbDsyNI6olGi9ODzHekz6vq60V+0EGTUenzFAGbWwwnms0Wcl
 MMk3qfQsTzvOyAOPbc/sTK2+QT7lD5OMRiwJG3Qu+2AepgMy4gEIXlJ1oxFfp+jNRxIx
 Zn3dCvbvoywzaiSKhHanl2g6rQ3dOWKs/SBEo193FPRNh5Gr6hTwr6ij8g+SoXjP7zK7
 JuoqRE5lZXZ6jqSEAB2hpDRvWtRqIT2sNrGd8Q4ZOaqHUxC+5t2zJR9xdMRHwFnpF70/
 +BrA==
X-Gm-Message-State: AOJu0Yy8mizRohAWckhJrH0HHdN6JyrIOcnuUaxq5mLQRFXLHUPXzwsQ
 niCBUrBzoRweDBnX47Xs7K97rxF04UhncQbW6AqM4z2R8OYCBp8JRWqoHGbZZ2hq4UlywWNAWbp
 wifa8NybPnnBRDVOV6NMkYkl7SnI=
X-Google-Smtp-Source: AGHT+IFlPpTQuEd2RIm03EPdngP5C7bTPOOIRyDuiVZOC9orc52fZhsZ4Jx7PkPt86CBm5436BmBLm/O2D0yUo57S94=
X-Received: by 2002:a05:6122:2025:b0:4f5:1787:18aa with SMTP id
 71dfb90a1353d-50cf024f27fmr351330e0c.0.1728422496188; Tue, 08 Oct 2024
 14:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240922094441.23802-1-dorjoychy111@gmail.com>
 <20241001091436-mutt-send-email-mst@kernel.org>
 <CAFfO_h78jFc1w93VXYLjsK89kXMjbJ782Eo77O2XGzQLRxvX+w@mail.gmail.com>
In-Reply-To: <CAFfO_h78jFc1w93VXYLjsK89kXMjbJ782Eo77O2XGzQLRxvX+w@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 9 Oct 2024 03:21:33 +0600
Message-ID: <CAFfO_h60pWyyfsa6kcTCWyySW0s8aoj-ZtAaO0sUxs3of5wjcw@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] AWS Nitro Enclave emulation support
To: "Michael S. Tsirkin" <mst@redhat.com>, graf@amazon.com
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, stefanha@redhat.com, 
 pbonzini@redhat.com, slp@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, berrange@redhat.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Thanks for reviewing. I have now submitted a v8.
https://lore.kernel.org/qemu-devel/20241008211727.49088-1-dorjoychy111@gmail.com/T/#t

Regards,
Dorjoy

