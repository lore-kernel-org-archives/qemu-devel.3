Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A7DCE7A91
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 20:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smIhb-00019l-Ns; Thu, 05 Sep 2024 16:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1smIha-00013e-2C
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 16:03:34 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1smIhY-0006Pm-JH
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 16:03:33 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-70b3b62025dso909188a34.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725566610; x=1726171410; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NGkpL/czPzBcu9ySxRanKk4oPs0W8T4ssovN5dZMqXA=;
 b=aw2kOxaOgIgA7iAYcTPve4Fn1A0XJcpmf/FPp1hXVal1PWiQCCnbb9YB1tTggzmOCk
 ISlAJV4Gaar2VRgQZzFhBLvs3uaBkgIVZRzYVMNigcYcNuL97+VSYj/RW4CByB+bAGUv
 ERr4nE3aoEaqVXMsy7pNfI0ZTuihaQrxLOOQQZaAmDo51u8xLh6KFYWXWtlk/2pBDP1V
 a3AQiVsInQCBVk2JuRIFSamHLYL5wJ6RmHaoJeZh83lXrpQlcd8IcTVt+YfoYQ4i/HSD
 5ujEK3gifwmObiwA4DBa7ECLo5+aODoDDN7k7F/LunrQJgU2vio+xyZ53BlfHRC0mF+t
 54Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725566610; x=1726171410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NGkpL/czPzBcu9ySxRanKk4oPs0W8T4ssovN5dZMqXA=;
 b=Fl3SgFuUriVk9Vj3RxmESF+V/lhphhFt3Lf9cN0ylK/1S3aTgXAiYW+oezUBAj4oEy
 vi50n394uFtNvZjauzSFIsPPvLufgAcYa5hZcOjZOqvW7UwgOBZeqxh/lh+MVk2ZRnVH
 FUQTmjhmqVt+UE2IADw0Rahy4LpsaonT/dZQCeFw5FIukgDTkAOa86fOkZixI34Z7WVa
 YhzLw0C9XJqN5x7R/JqYU55p4psz0Y/rsuC6PBBUAjPQVNBqnHFS6/6OXxarOXxDPGOd
 IfCd29sWJacjEYGy/N7Lo7jRM1g3aV3wTCJC4oLP0vOsQJ6TATTEYc510uvxGGU1GX14
 pktw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsRhukUYcBCHxzfSd4GfZBeSo9R+/QCvbxxyyd6rwztVBSvYVgR3IlTyInTeK51vomTrlGbh9KRgl2@nongnu.org
X-Gm-Message-State: AOJu0YyZa8kDWKBcnQOE91osizw4Q34kAXKqpc9Vfta3O3odlJXJiC9i
 O8+twsM7LHKo0bQSyLb3xMbu/uIKRPVy4fnHflJmkEbKz2SYLyegoAIo2/KM/gSA9JMMCSMEidj
 BbOQeB7qw+ZGzOwk5uCXtiDeuhjo=
X-Google-Smtp-Source: AGHT+IGU2cF9g9kGO+YoZ3QchgPiOnpiPcYEVUubpaA6vn8pLyremauJSKEkNStLc6Qg5HAekwVGkrs5jlhZyb0w68c=
X-Received: by 2002:a05:6808:1590:b0:3d9:e1d1:157e with SMTP id
 5614622812f47-3e029f20b5fmr470610b6e.35.1725566610477; Thu, 05 Sep 2024
 13:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
In-Reply-To: <20240822150849.21759-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Fri, 6 Sep 2024 02:03:25 +0600
Message-ID: <CAFfO_h7Kd-5uy96VeuLdD4S6gqbDDthSLdXrfxx4Hj4u6Fq8Ng@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] AWS Nitro Enclave emulation support
To: graf@amazon.com, berrange@redhat.com, mst@redhat.com
Cc: agraf@csgraf.de, qemu-devel@nongnu.org, stefanha@redhat.com, 
 pbonzini@redhat.com, slp@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Thanks for reviewing. I have now posted a v6
https://lists.gnu.org/archive/html/qemu-devel/2024-09/msg00823.html

Regards,
Dorjoy

