Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB5EC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 16:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrgr8-0007WE-IJ; Tue, 02 Apr 2024 12:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1rrgr7-0007Vu-55
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:19:25 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1rrgr4-0001GG-N0
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:19:24 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ead4093f85so5028392b3a.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712074760; x=1712679560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=InYo9PAAOd0Pj20IAYdsmIvs0/QKgDoxDhVffjGcwT8=;
 b=h7SogejsKmDJ3CQHPAg4rvHqVsTdXnl+0E16IBZiq2cNIgVsXnYLylSkWmQezqp2Ud
 fNI7ZPZ25dJ+rpwREEicxyjrgyyS/vAcwnnlEvzWaF0nAdXUtaUtLpYWRrfeGah9N1l3
 1Wn/0ojYgwnYvDbjwhHJ6fAqJBjVQs0f6AsO4cJzOJyYpof89Gu2M7/VWI//+QKOxaLt
 WvH3P4CWOJobdwX9IIeeB16OR89VYZeufUiIJ2CCgmRz94z6Q8jWbjlkxb08dC6HS3XB
 jMLVxn0yuOpz1dEBc9let8O/sy85Hzu/ix3fxRHV7zJHfU3Q9cxVutvYA3OWmEtQeyII
 V0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712074760; x=1712679560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=InYo9PAAOd0Pj20IAYdsmIvs0/QKgDoxDhVffjGcwT8=;
 b=WNiBcX93KcmWN2F8Heze97LIHojsHDLPkvSKQpkmp27qJR7iT4P0O2ANLm8PKhiHH+
 4cqXZebnh+ba7CmNayNkkFN9o+8h6NX1qp/SWd9zHXanN1iATiyfaExLI6cfNpDkUePi
 dnVwJsf5rtTn2hKcXSptENkfYCx0n75eTZGqQkK/zj/cm6G4RJKONuG53BUfOhGE1glQ
 tZrM+MNQ79ADCeAIYXJOHgi5bZ3L1iJfzg4fCt0ejsqFPfEXORePFm763BjmgreruVBG
 0bjcgu/6UYOjbV73b42XE2FoiurkbYTI59rNG5n00EgCrvMqqenlQpfk/UU7zFgTyItt
 B+Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZIDTcLhRQ/zIMBlY7kKJOmUEGIJIjAR6ulb5faqTGLDZo7e+qWxbA4ndneRU25/Bc5mN6Nz3W/PrN9mu58I38MxIaZvY=
X-Gm-Message-State: AOJu0Yxwb/VXz0DidIWYS2Nv1R7BTHpCFJPJKeZRmBgmNQPzsIsxUiai
 eSp1OzzH3y80XljA8UboZAO3sLWlV+RTBLnSdXW0PisG4lNTVZHb
X-Google-Smtp-Source: AGHT+IFlTZ4xaO+E3F1pLG+lWtNEwdKLdDwSqXvt1WQOUv2HWb4MaDchwFYYO9BuORcF/SHNTkIOOw==
X-Received: by 2002:a05:6a00:3d12:b0:6ea:ed70:46b4 with SMTP id
 lo18-20020a056a003d1200b006eaed7046b4mr13930216pfb.29.1712074760175; 
 Tue, 02 Apr 2024 09:19:20 -0700 (PDT)
Received: from localhost.localdomain (c-24-7-119-110.hsd1.ca.comcast.net.
 [24.7.119.110]) by smtp.gmail.com with ESMTPSA id
 q23-20020a62ae17000000b006e623639a80sm10337795pff.19.2024.04.02.09.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 09:19:19 -0700 (PDT)
From: Justinien Bouron <justinien.bouron@gmail.com>
To: justinien.bouron@gmail.com
Cc: armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, kraxel@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] input-linux: Add option to not grab a device upon
 guest startup
Date: Tue,  2 Apr 2024 09:18:04 -0700
Message-ID: <20240402161804.547255-1-justinien.bouron@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322034311.2980970-1-justinien.bouron@gmail.com>
References: <20240322034311.2980970-1-justinien.bouron@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=justinien.bouron@gmail.com; helo=mail-pf1-x42d.google.com
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

Just a ping to make sure this patch hasn't been lost in the noise.
The relevant patchew page is
https://patchew.org/QEMU/20240322034311.2980970-1-justinien.bouron@gmail.com/.

Any chance to get this merged before the next release?

Regards,
Justinien

