Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EC9C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 16:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwOsh-0005Zu-Ke; Mon, 15 Apr 2024 12:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rwOsg-0005Zl-3Z
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 12:08:30 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rwOsd-00072q-Sl
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 12:08:29 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-78d723c0dc5so316936285a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1713197305; x=1713802105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ai4M5l/9Eood3VScV5m5i3ihGF8DJeatzhBfUaTHOMU=;
 b=UhmHy/sC5Rkt9McXZ8BKEobLPpCwK1lnCCZW5/Xmnu814i4RWXkCnoWzOWBt9Tp7U7
 3DwqpjtsB9F8DrAhR3g+DrVrymbiinTOfHDRrZGTUDk5kaaQf9nFpN2BkjPANM/S/2/z
 kDePHQ0tCdopDhZTDXRUWC9LkJyN02g11yrtcXhAN7COV3Y5xg3c3ltUUQ0J+dDrsOtS
 yUl2hPdD54Q7dIdsoI7+/QOBqTnBb4EX/I+bUAxmfUjZ9AISt4eau1VOX3KaGMBaW2YN
 hWdPx3HYnxhphuPCHXYCGFyTTDHoSpgYJOTFYFQGmVDODxMFj76wiLkaegbqXFtZ3tBF
 pDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713197305; x=1713802105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ai4M5l/9Eood3VScV5m5i3ihGF8DJeatzhBfUaTHOMU=;
 b=XUzhX8OXwy9UilAhCGhz16rTOArCG730I3yq1rUYrrkz5c524++blaCblNTAre0+Vr
 oiftLVVqpHcNkQR6eiQ4+Po8ifVS9BkGJGMuNo2cgBYeKaydfxWQ+R/zxkvreGjHjyv7
 xORT8JP/TePOOQRs0I31fjT+7H6m0IE2zH3rawsLWo2EOaOW93FuAlMf4bUIgJw13eMw
 DlHOdqUdyVLc3XOizRkF99i8yqIa1TBovyDX7UE7+/KTMtzmJZTyu0nTnMF5BBfeZ3nT
 cj7FclNKwryQ8GHup2IG8izuc47IukTqWp6uJSa+CD6nEgPBbC4Rs32hHH6iy4xTe1rB
 9G7w==
X-Gm-Message-State: AOJu0YygMCyvR+760DYpLFs0Pko9vudZXKGNKPwP4YX6h8SqpV5nxADk
 0GY3R4yQgFiDAYgMixgJSkcVtqRUH0hH3FgDr7Uv2Zx1deArjg7wf+kQZEREUgIPgbA+t3GKouV
 sjx43D1CJEYz9yeqCtI4Br7yxglhlqzVQkOG7aCu8L1pQvNELkxKJpugzviaqM5mUKAUVwVEryY
 N3+T4w/TRwcGU0D8Al7TcpbgQQONOT
X-Google-Smtp-Source: AGHT+IEfMX+nDMxJR86t4j4W3hJC1Fo2kIOvRn2pOD+4J6a8RPvCATpYY/ckxp5JsAktiH95CLKF5w==
X-Received: by 2002:a05:620a:4ad3:b0:78e:bf95:fba6 with SMTP id
 sq19-20020a05620a4ad300b0078ebf95fba6mr12747684qkn.60.1713197305338; 
 Mon, 15 Apr 2024 09:08:25 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a05620a21c700b0078d72553055sm6491341qka.11.2024.04.15.09.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 09:08:24 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	dave@treblig.org
Subject: Add 'info pg' command to monitor
Date: Mon, 15 Apr 2024 12:08:16 -0400
Message-Id: <20240415160818.2316599-1-porter@cs.unc.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x72f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all,

I am a CS professor (and, newly, a second-time contributor). I have
been using qemu in my courses for over a decade, especially a course
that asks students to write major pieces of an OS kernel from starter
code.

I have some patches, originally from Austin Clements at MIT, that I
have found useful over the years and that may be useful to others.  It
would also be nice not to have to build a custom qemu each semester.  I
have cleared upstreaming these with Austin, the original author.

This patch set adds an 'info pg' command to the monitor, which prints
a nicer view of the page tables.  A project in my graduate OS course
involves implementing x86 page table support, and my students have
found this helpful for debugging.

Thank you in advance for your time,
Don Porter



