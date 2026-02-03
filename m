Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA826E8305B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAzd-0004yR-PA; Tue, 03 Feb 2026 02:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vnAza-0004xx-IF
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:38:35 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vnAzY-0001Vj-Ub
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:38:34 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so4684034f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 23:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770104310; x=1770709110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aoR34Lxj55P9GoMIMRXHtCPvUVK478AT/2FfieLxB20=;
 b=T+jmIJ/eOcUyt1hEXXA46n9OjG+zaCq75+MUUKDWmCYylEqOdi9z1lepyhI48pjVBP
 6YLVAX74gD94SOrZO6UkVjEjx+HYk1v99vPXYDdVEVYFhwwXpt6zP8+cRU3FTd3qO4hk
 SNJmeP9ifUeGYl4FNsJ11vruMgudRd97oCn2Dl7kiUL1btVexMIaqweoRFveZxBQX+UB
 5GvjXeyt8dP86qgjTi3JzQ3mtWx87y5CavnivDNukCRThQ9mCLYgzRmRPeHcrTrl+fk8
 6nd3PycRVJpRNWDuPpNS9gXddoBtiEuY88WuLTuiVZCNItJ5e7Z+74kfLaX4ha/V3Gk1
 3A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770104310; x=1770709110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoR34Lxj55P9GoMIMRXHtCPvUVK478AT/2FfieLxB20=;
 b=KTUvO10puxsBck9OCWDvqXXyhwpBJpAULhXfEluRqgaP+Q6sXAt7Gy2kRRLoXe2n3m
 VvyCgeb2r1jYqQNVsUx/NV+qfcQTzvi58r+C/7RIu6Jvui2TYGW6WF5GoEJuJRi4B8fo
 sE2U9MgrPF4IAu+hTMY3QG/oL85Ioqcn8TW8yJfFQzK2nE6XkANVCVNhGQtUXvJ/xpvS
 77sVo8CZnLwxBndmeAEcV18KTxucTtLHVHkNd4dl1gaDY3/DxPjCJ/7B277+Er+6hHjB
 BmIvbR8CtWhCPvr+n0Ja/uE7fhtfa4oP2gGlmC2T3EkOFwt/kPGAgHRiYyYzE/WiKhik
 vRGA==
X-Gm-Message-State: AOJu0Yy3hBddTPBsUVnHWujC33aJx6cYWItMrfHh1BRfcBxQ8Mre+sI7
 0vYQ9c6DKB75svwPms9Omd/TJWwAdKZoDftHQB70zFSJWrhbvZspMGV/wV7uPA==
X-Gm-Gg: AZuq6aL4iW3wwD1vy6zuxgkOeynnfECMX9MPwlqLGFuODPhi2qUR0Z9n0kVPxPhUOpi
 iwstrxU5QyVzPDBtHw1VlfGcgGPenOCtY+6RavDjwX+pl4W1mRCBMMHiBOaNKHDr8Q9poEvKuPD
 z6GOxDkA078yOljLZSJDHqhntjk3P+2xJ9VeFoZASDOtC+ecVs+VyPy/xivTEP9FqfGiMSqzPLE
 2K2qvO92D1/uOaFFC1zuZbX9U8cJLDf1GkkQ3GsVo5Fpa5Xsg/IbiEPgAMLO/E9hM7LjQPPlY8p
 jdJA7rIh9Gs13R/4emiAdxpz7kZ2h582qhNnyubOxowT1JNDvJuYUXsq7eaW+xyyE/1ea1Bw4dT
 bGqf/qtYR5KVYL0XqxUactzdvm10geTL9rmUI72Kzca7WaspRq17LwbMjCO0yIDjrui8byCupAa
 THYrBuUefJPsRZlwg5DSu4j0QQPrRj
X-Received: by 2002:a05:6000:2889:b0:435:e54c:985d with SMTP id
 ffacd0b85a97d-435f3abc26cmr22177251f8f.44.1770104310330; 
 Mon, 02 Feb 2026 23:38:30 -0800 (PST)
Received: from localhost.localdomain ([92.180.8.65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436143d81desm1684077f8f.42.2026.02.02.23.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 23:38:29 -0800 (PST)
From: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	richard.henderson@linaro.org
Subject: [PATCH] tests/tcg/x86_64: Add tests for zero_bss() with RX PT_LOAD
 segments
Date: Tue,  3 Feb 2026 09:36:55 +0200
Message-ID: <20260203073740.19913-1-razvanghiorghe16@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=razvanghiorghe16@gmail.com; helo=mail-wr1-x430.google.com
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

Here are the test cases for the zero_bss fix, as Richard requested.

I've included two tests that trigger the bug:
- test-zerobss-1.c: minimal case that just validates the loader handles it
- test-zerobss-2.c: actually reads from .bss to verify it's properly zeroed

I also tested a third case where the .bss is file-backed in the R_X segment,
but that one fails with EINVAL at mmap() time (before reaching zero_bss).
That's expected behavior (kernel blocks it) so I didn't include it
as a test. I mentioned it in the first commit message though.

Thanks,
Razvan


