Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C85AD0E6EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNtvz-0007ST-Ju; Tue, 25 Nov 2025 09:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vNtum-00079U-Vg
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:21:14 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vNtul-0002Gg-Em
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:21:08 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5957f617ff0so5925976e87.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 06:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764080465; x=1764685265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VCTjN+oAF+PEJbCxlljV/jyTYmlyeb5nVk9MUocf+xU=;
 b=VLIA97g4lIPRtGPirgVHb70JRcw1TpmMFXG4gmr5xkIMLjJKzBjk7stCKQzvZ/I1Y2
 r8plu/8UENyA+FL8ILw5eX4risqbK7xAQdq9dH0xKmTXtTI8+y9kOVa8whG4r912L26y
 w4oBLcSwQig2JvE3I6z7e+yAHb/mmffXoA8QptFV/OSItdWfcyyqtjBC2iv4Wylt/TqC
 1dgTzsBAHrypjjQ7DLzFkIyEtgwR+H7uiFnt2YYMdIYCohVjwfp12sKe2/dtSR++7pZA
 27hmAQPC+V5Fv5MzriHR0hsx4pRDH/dppceGYSktuDBfxM9OAUuTQeBeVGnULU+M2JDu
 XR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764080465; x=1764685265;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VCTjN+oAF+PEJbCxlljV/jyTYmlyeb5nVk9MUocf+xU=;
 b=EYlJvuXO9tkPlc0ERJafRuawJlg9M8U5KNg1yCeNJPHGtOy0+rNSxkFgjJOfv3bOrb
 7GqpkexuEIOhDsWjOBu9sPfhAExgD+ukpIkDB0J1SSwC06aSnhgUE+lavqtxzSdLGmzN
 Cymf5kXq3CbonNxud/xxRLLK3Nj4t6aN+heKNY2++CWX+Jr+h2NQ34o/4iIqfkN+6Sm/
 qYErgOOwLzSg1vgE4Hlsv8kwe6GkmeGMkJtZN+Gj0M0MfPLymuGh2sMYtmPjNcH5lHZv
 cGhm5N1Q7F51OYX2EFSBZUvK7OTfAoNYrU2TH8Q/PP5j2BHy2ZdGc/NuJykeuFb6h/H7
 iCWA==
X-Gm-Message-State: AOJu0YzV3UbR/RcUYoSLaZi961t2Q4pN9JtqpRbyN+YYioPNKgjjlR/j
 4d/KO75ojxd0tAXEx1C18wapUvEHkGZN3wb1v7CZ5aj3oXqdrB45VG2mDJMGcw==
X-Gm-Gg: ASbGncuTnBH2dkG+49seOQIgMMlMZcKwVj6j911mZoxz952hj562Oi0xavdlATSgpAz
 efidKpcYdJFl9wIZkfuoy6AD1LA2p9fVorRJniAFPrglXyLGbMHpwX5q2pcVDibVg54c2kquA0a
 x2UOpZwjQtwhxsaGsb2kmY6x6Q/mJ0wWOgsAERGA9PMqOgYKVWCjrArJncO/EAmxfJSIhZ03tM8
 2EmCQuFr6XhrTC9SE3xPbsGc4U9W5SI/ALZArFEpqdqhhyu/tBBOFGBeObB1sp6HyKVxuv8Aazj
 9PJ1uxQfKwjDCd/HjHALqOkTWch89V+HBq9+ndHMhhfGfI9pkJRHcwPfkzrTp7lztUIWQpXatxI
 oqnowG28LEzSkkjHwWE+OR1TIaPxwZHMYdVnDC7OuGFvgc5K/x19FrP2PQOQvijIb47Ax8YGT2K
 Ra9kb9BQUTYYtJLA8dzwqJjQ==
X-Google-Smtp-Source: AGHT+IG9Y6DpZatEc4vkS32eH8wFlEYF9xXnJDtYSlfK5cyFSdi1ECPuchR6OxHQXIMk/OcGrkHJUQ==
X-Received: by 2002:a05:6512:15a1:b0:595:7cb8:3eb2 with SMTP id
 2adb3069b0e04-596a3ebd0a3mr5835800e87.14.1764080464523; 
 Tue, 25 Nov 2025 06:21:04 -0800 (PST)
Received: from [192.168.88.252] ([82.215.83.93])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5969dbd27e6sm5120539e87.101.2025.11.25.06.21.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 06:21:04 -0800 (PST)
Message-ID: <c9461c73-fbda-4963-b96c-3fd4b2d6ce41@gmail.com>
Date: Tue, 25 Nov 2025 19:21:00 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] 9pfs: local: read native symlinks when
 security-model=mapped
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
References: <3c35955d-a57e-4203-81c5-395146e23f83@gmail.com>
 <20251125150444.5deb5195@bahia>
Content-Language: en-US
From: Andrey Erokhin <language.lawyer@gmail.com>
In-Reply-To: <20251125150444.5deb5195@bahia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=language.lawyer@gmail.com; helo=mail-lf1-x12d.google.com
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

>> +    native_symlink:;
> 
> Still has the terminating but unneeded semicolon

I think I've addressed this in the v1 thread, with links to the C11 draft grammar.
Can repeat in plain English: a label shall be followed by a statement. (No, declaration is not a statement)

