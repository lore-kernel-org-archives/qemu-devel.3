Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDE1C25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 20:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s99Eg-0004i8-8k; Mon, 20 May 2024 16:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s99Ee-0004hn-7L
 for qemu-devel@nongnu.org; Mon, 20 May 2024 16:03:52 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s99Eb-0003VD-ME
 for qemu-devel@nongnu.org; Mon, 20 May 2024 16:03:51 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6f0e190e5adso909886a34.3
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 13:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716235428; x=1716840228; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QeonIHl41pbpO88qpxcL2TpRI+bv5ojjJ+JgKiLSilo=;
 b=JHY0CWxsHQlIzdFiFf8v436S7lYKTIYxBGrr7N8gVgAY77MRAwhhJjkICkUueKKfJE
 aFStm7NWQ07pyt68UIJrIsL/+QyfY8GRSya7i6Qgqnw/+rMWqdIKxGdO+qcPRj6rEZnz
 sZWF6oRs3niZEoohUMk8PY0POe1h9rQQ/dZVM1b9aeTyxjuG4blghNXOVd9HWc8MWkcj
 7PJeEK1VUc8wOl55OG3WXrIYxvxD0B27RNj4CorbUGc09owdvmI1oBVJR8ClsXvl7G51
 PIEhyb0V+Hft6cgzNnkgWZUuC8CK2paqqn3MlLVPKzfIGGicWSEqBdz0J6hLPwIPxXdG
 0LoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716235428; x=1716840228;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QeonIHl41pbpO88qpxcL2TpRI+bv5ojjJ+JgKiLSilo=;
 b=vXfTYnxLeZvCB//pYCeRuwynVxX3D8TcrSVMw8N8vCBQVYLp+U6kciPwFlmkyit2B1
 ZylCtImgXnX7eTyf5m1GWa3ZCX7TsBmZ0oCuO+8Y8OkkhR8yCiwoONz/XktIEQDm9sMO
 pmSsPyF3Jw01X2G1VQBM97rkOOsdM1Mdu1ZFSNVZmLVCi6UuczS2CKAOuWDFF0LH16AC
 vt1egERipV1iK1LtZCiv+3fuINDYMJHZdb34/BdsXvp2R8EeCQKyy0VCVlUW49ZwklJu
 cMCyg1oiL3aeXKy45mmlRju6YMvPp61zXmlO+T/6rRAiig/GulI6Kvrmi/nNlIFIVBpl
 CkLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgZNkWt9Fc+CkrcXKBnVu7hWI5BgPOtjn5p/pZPOYT0E1CYKGfLyAabj2zmmb8yElAQta33xG2C9TJ7BB5eDlfzvlptdQ=
X-Gm-Message-State: AOJu0Yz0eZWYvQ5WUZBsfIVWy8hZ8xR8Pmd1JXGgqDCqXFRkOuneUxYX
 m3bMmJrsPnEhiSlQKgedF1F9Cnu2/qTU46GLKrBZTSSxKscHc4Gq
X-Google-Smtp-Source: AGHT+IH4C1hpxsI1jK7TPQnYKZdvaWrd3x3sOgwxId1SUFj5Dk7PAwAd6uEQ40AMMuTix/eCBQqbNw==
X-Received: by 2002:a05:6830:1202:b0:6f0:e575:1b14 with SMTP id
 46e09a7af769-6f0e92b29a3mr31652860a34.28.1716235428264; 
 Mon, 20 May 2024 13:03:48 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:8080:1f00:9c00:2639:f689:1715:fc7b])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5b26dec43bdsm5122169eaf.45.2024.05.20.13.03.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 May 2024 13:03:47 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Anton Johansson'" <anjo@rev.ng>,
	<qemu-devel@nongnu.org>
Cc: <ale@rev.ng>,
	<bcain@quicinc.com>
References: <20240510145244.5615-1-anjo@rev.ng>
 <20240510145244.5615-5-anjo@rev.ng>
In-Reply-To: <20240510145244.5615-5-anjo@rev.ng>
Subject: RE: [PATCH v2 4/4] target/hexagon: idef-parser simplify predicate init
Date: Mon, 20 May 2024 15:03:47 -0500
Message-ID: <02ac01daaaf0$d3b0e730$7b12b590$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIiYfSnFKSEhNVC54cr1TbptsX+PAD0PgxbsQl7nVA=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x32e.google.com
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



> -----Original Message-----
> From: Anton Johansson <anjo@rev.ng>
> Sent: Friday, May 10, 2024 9:53 AM
> To: qemu-devel@nongnu.org
> Cc: ale@rev.ng; ltaylorsimpson@gmail.com; bcain@quicinc.com
> Subject: [PATCH v2 4/4] target/hexagon: idef-parser simplify predicate
init
> 
> Only predicate instruction arguments need to be initialized by
idef-parser.
> This commit removes registers from the init_list and simplifies
> gen_inst_init_args() slightly.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



