Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F282FC5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 12:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsJPY-0007DF-Ou; Fri, 07 Aug 2026 08:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1wsG9D-0005fY-6N
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 04:41:47 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1wsG9B-00072M-Hw
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 04:41:46 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso3099194a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786092104; x=1786696904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LpcWn2SuFvxiyMeM56VEofkzDXfNTJQ0BrCuZovQqJE=;
 b=myApGYQ5ft3Scd8ng+fE2xd5h9WX0soq6C/SnpM3dxkhAQVRNX+T931bpoAznlCWT9
 eUXa5ty4OssjiNo8/sN1kIQFsrqDk5rTj0CRyb/AOyz6cz57B2FBvp87NMeSCxim9JUg
 MjpkgH5Tk43r3/5cpIMkgSSuhGCRDMFMfq0wBOf03Drg5k+n2qgsQ+QQzMLkaentTA6G
 ksJT4dI9W3JbUFoyXzi+OS6KGFMzREv0iQzs2qjre+IhDy0IPPwmyM2nRHuQF5W+nOrw
 KNXrQe+e0rBQCs9uc+yyHOggEGjlISFcFSp4Om6H3vB59EgihTNnzcFU4TFmEAvF3mII
 SWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786092104; x=1786696904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LpcWn2SuFvxiyMeM56VEofkzDXfNTJQ0BrCuZovQqJE=;
 b=pmV9EpD7NntCHT3TFV6p3WNmKl1obzztsQiQNQBJzObTz5aVALOhm0uYl2mFzIOcqb
 z1nz+74vzWM8zKdJzPZAjQ9cEI9kfxpcxm9Etw4ck7RtGjc4wUn0GzbSNf5l7eufQmEZ
 5mF5mVa8+1A7rjbNS/JtlvCeOuMUg/M43dDmq0fwro5USFcCucri+gq4rZ6N39kYDt4g
 TrLTjURr4rQC1mspj18dmJvKRX6r8hTxaXg1LjuoAuPk+wKwBhsIhgS4rEq4zwNTDry+
 /cJGdZK2fd3ZdBXMOmEfSJ9Dkvb319FV87YEmqy9Oa6aWI9c9JLoyx0Meos/z62veI2q
 6B5g==
X-Gm-Message-State: AOJu0YzisU3J2LbOFXPbwYqaEw3ZdNIPl3tCfN0z/KzgAR0bL6qDu2da
 3nG3gJQ3thF4lDl9zVB3RWtfNa42rIKVuTVOD3GpzBwBnaUZNTwDVWQXo2aLCwML
X-Gm-Gg: AR+sD12BVFfU67mjkTlmqsTS6wdvSnFTkZAJdp67yQGWOFkOw/dasb2xBleHwwlCmxS
 AQa8kBPQOwudwlqdhfBF0ZpXl5px2MAuSDw0cJP6LqV1N4RLx7Q2tVOLFsYyrpRP67N2mM68Gdu
 iDHW4mOY0WJptON/ED+mZsljszNehm9JZndCyjEQyWsKhVc1cuh6Np3nGJQ4OIhPA8gfEc1eEPf
 VrwT/pGrwTz7zR0CwJUt6p08t2U+Xl/B+J+QW+NHnIANf7o2MxNcta4c1R+RQqJMDJB4dv/TNO3
 9YRbiJg/N/1K8iljcVds/Iy4U+jVMyJ3PvoQso2lau+4SyCGQXEmQZ7rM/MQu+mzG7pgDaL3Ngc
 NXG7m/Aq0wpCJFLl4Qn5TmGQahl4s6hCWJbXzNzZF122nQryDTLiQVvrQEFC6oSVx+6nnoWG1m9
 vvXV3S6a/8KcnJJlpO1+1c6Yp3u6VThMcHAvg39R4BtD4HTBwWFY2WUIRc071zxpEG
X-Received: by 2002:a17:90b:52c4:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-392620e70b5mr2597624a91.10.1786092103523; 
 Fri, 07 Aug 2026 01:41:43 -0700 (PDT)
Received: from colazcyASUSlaptop ([2a09:bac1:76a0:3d0::26b:61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925fc6dfcdsm1594357a91.4.2026.08.07.01.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 01:41:42 -0700 (PDT)
From: Chengyang Zhu <colazcyg@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	Chengyang Zhu <colazcyg@gmail.com>
Subject: [PATCH RFC 0/1] an extensible SetUIInfo2 design
Date: Fri,  7 Aug 2026 16:40:49 +0800
Message-ID: <20260807084050.526109-1-colazcyg@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=colazcyg@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 07 Aug 2026 08:10:51 -0400
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

Currently, the `SetUIInfo` method cannot set a refresh rate.
Simply adding a refresh_rate argument would break the method signature.

This RFC adds the `SetUIInfo2` method and `QemuUIInfoTypes` property.
  * `SetUIInfo2` takes a dictionary,
    allowing partial updates and adding more keys in the future.
  * `QemuUIInfoTypes` exposes the schema of `SetUIInfo2`'s argument.

This patch is a proof-of-concept and it needs further discussion on:
  * public API design (the name and the signature)
  * partial update behavior (only updating the recognized fields)
  * error handling (ignore the wrong keys or return an error?)

Test results:
  * qemu:qtest-x86_64/dbus-display-test passed
  * qemu:qtest-x86_64/dbus-vmstate-test passed
  * qemu:qtest-x86_64/dbus-vnc-test SKIP
  * manually created a virtual machine
    and successfully set its refresh rate and resolution via `SetUIInfo2`

Chengyang Zhu (1):
  ui/dbus: add extensible SetUIInfo2 method

 ui/dbus-console.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++
 ui/dbus-display1.xml | 17 ++++++++++++++
 2 files changed, 73 insertions(+)

-- 
2.55.0


