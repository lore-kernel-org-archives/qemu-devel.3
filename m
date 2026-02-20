Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F37DC561F8
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 14:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtRRc-0000Pd-0H; Fri, 20 Feb 2026 09:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vtRRb-0000PT-4Z
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 09:25:23 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vtRRZ-0001Bv-8o
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 09:25:22 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4376acce52eso1341218f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 06:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771597519; x=1772202319; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6YlgjuOGW4UzBJ+jHtiJMHi57JxqJyvj2iK9OCm3SnM=;
 b=FNJb+yJGYqibw3qINLi/Wap2qKRWjL2hPFyTchhddw/AnEd5a3qx1a1PuwFXcnit8p
 cutdihpzewP29U8XSRXHBvziDZdmE76GDTFHeAsdkMS0JRZiuLSmVADa+aQef0b7VxpV
 gZafSxutZifOU+Yn+5kex7QXCH+/oDOIdpQb43Z2TYNMJk5h7Oc+vEjT6DFL55zmRKon
 abfXjjRzBjA3qGL8MDNXM4EjHV9duq8qVVITsSwyrWhYUUu8hVlhLTBpwpKsZt5iB9qP
 9uKDgqpBhRIBxyPPWiQdsnYYUjBYZoccb2NUT7T8dms44+qf90oERvZpHGWPlRKVzmlM
 eaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771597519; x=1772202319;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6YlgjuOGW4UzBJ+jHtiJMHi57JxqJyvj2iK9OCm3SnM=;
 b=LnRnBpKurexqk86NcBGrW9uGvBUp1OLg4tTREKy9YO2L7Qz2YK3q4GhvLgBD1Mhe2z
 CoLc1hDHAyDBiGlDZ8+7nAOqE2EmdSv7gUcLWLtxnTxMmXYj4Gdh4UXV438aKmItuhxl
 WktLF+kr6JvH8+5wpq7KXreT26cIiG5fW7RlF0C/wFM8tNfMA2eTOKxlgcrz38H686bz
 BoQtFEjTKzuYBBE9lUahjrHH+vdAFL1G5IDFJxl7Q9AM/lqJGYpfmiYyoMikFP5W/3pH
 zZmt4aJMl1qr1Me02WThysHjDEhmhD9pLAKMGxX4O9o55QedymTo752rWL5nX7BWp334
 hfrg==
X-Gm-Message-State: AOJu0YzFoOYZd6Ljyi/NPcknK0MRsNDJf5ocW5q7XqUHVrdCqkr5NtQ0
 Y57JykI2d65SqZXLocc8YO6hMKJdKKQ7+g0YjqVcbTHsu0QpWNw0+ZOmgUfKYZC5cn4vqX2/Iox
 tOeJ2
X-Gm-Gg: AZuq6aJ55CZxY23ieO8OTGL8Y/88AOa3GUe30vi39u3SAAe/U1XBj+z/1JNh/FvSoZp
 kXiI0g6izPMJ6UN3XkCmN+hf0T1sOJns4/krm7Pj9A2+obzkEcpZGBj6aIc3qC5weOCiNEHfDzr
 JumTwhcOPBHHYLCE0lCnooLPA2Ba8G7k8NcFR+wa8VM3b5jf7KUco5uoA4KwQFIP2KLCngJOkfI
 1x2m0Xr9x4e6v+Ol78Dyg9BqTT0AVh6wZAx55OehkkqXR1Aoci70uM4OEWxbE/tVycKrFkd1PAT
 TLk9s6BwmVTDsx+l544TVsC358FON+njiOovlK9GsTG0tR3Q+Jb4YH2BycLvRjhQ69f+2XZG6r6
 p4gTbPJWtuYDqInViTXo8/BegcYFiJX+r3tDYqRMby5ploEu9NDtqSN4LcOrl81enGaUgk+aNRq
 0erejR7qtaTpwLaA+53YYMvPkBoA==
X-Received: by 2002:a05:6000:2382:b0:436:cea:6165 with SMTP id
 ffacd0b85a97d-4396f153ademr177300f8f.6.1771597518753; 
 Fri, 20 Feb 2026 06:25:18 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:619e:ecab:73a5:1815])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abcda5sm61165005f8f.19.2026.02.20.06.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 06:25:18 -0800 (PST)
Date: Fri, 20 Feb 2026 14:25:17 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org
Subject: Record/replay thread determinism
Message-ID: <aZhuzUi4P0-mB-FH@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It looks like we have a solution to the RCU patch which was causing problems with the func-alpha-replay test (see 20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp).
While this was going on I spent a bit of time investigating repeatability in record/replay and I think there may be broader problems with record & replay.

While running the func-alpha-replay test we have two threads reading or writing the replay event log; the "main" thread running qemu_main_loop and the "RR" (round robin) thread running rr_cpu_thread_fn. Both of these use replay_mutex_lock() and bql_lock() to synchronize some actions. There's a third thread running RCU maintenance which also uses bql_lock(), but not replay_mutex_lock().

replay_mutex_lock() has some extra logic to improve fairness of locking. This means that the first caller of replay_mutex_lock() should obtain the lock first. However, so far as I can see, this doesn't make the scheduling of the Main and RR threads deterministic.
I have observed times when neither of those threads holds the lock, and as such, there's no way to predict which will call replay_mutex_lock() first. This means the ordering of events during either recording or replay is not deterministic.

It is possible to alter the lock function such that the two threads will run in lockstep; see https://gitlab.com/jmacarthur/qemu-jmac-development/-/commits/jmac/replay-tick-tock for a rough demonstration. Adding this significantly reduced timeouts on func-alpha-replay; I can also see that the replay recordings are much more consistent from one recording to the next; typically diverging around the 380000th event, rather than the 20th event without this hack.
This is not a good fix since it slows QEMU down significantly and may be prone to deadlocks, but I think this demonstrates that the current system is not perfect.

Do you agree with my analysis above? Is there something I've missed which is meant to deterministically schedule these two threads?

Jim MacArthur

