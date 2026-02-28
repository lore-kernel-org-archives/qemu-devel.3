Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD89EFEE4EE
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 19:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwQFU-0007qU-RJ; Sat, 28 Feb 2026 14:45:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vwQFO-0007le-ES
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 14:45:06 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vwQFM-0007V0-V7
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 14:45:06 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so22036905e9.2
 for <qemu-devel@nongnu.org>; Sat, 28 Feb 2026 11:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772307902; x=1772912702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCDCPKpDydctMlkq8XV/cFwpgNBWiiTo/ZqsGOY186w=;
 b=HVLq8leGiJcLH1Dy9yWOciMtkGE6tbKvi2202YZo/obMDa1x/D0bZgY+ZBmeRGP4Hy
 d/C5V5c4o+dHUzutWaT9//HwF+Ch2sJziEymePa7sGQxx7J3FMIo/+EHppvzNmejcqX2
 0a5549Vltnl+i35Qzx5AJwdJ3zadFQUQI5cNH0kNhl8yYV8LMWUP6V521a5H492K6r/d
 DQlqjwDeUA1e3STE236Blherp5usWL7Tb2ZWqc5YI+NhJceXccNXM8pitiT/GmIltG20
 ss7U9WwUghieCIoAUZFoHTHUh3zJqWtmcpGuf9/fYV/TyjZ5dUzf8EP0gCZdcfK2nHsF
 MxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772307902; x=1772912702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vCDCPKpDydctMlkq8XV/cFwpgNBWiiTo/ZqsGOY186w=;
 b=azvLRDAVewORyKd3oXZApoy9MXhkTytaAcs8uje2BO/KkHd/u5nTeA2EhkFhh3Md9+
 C6DjYDlbBkKe29VlFldNg6oMmdHxwuqAEKU1R3T/mEu4W805tY12R7tn2jXtKatzyYsC
 X51VyVtRdaPsdQK7LDQCxz0lUxkGcgeI6BxBNr7E4UhnKm9TkWO6PD9AhE7BFG43ydpl
 QPNwKf7a3KmycFMIRzsJ9IDQ+H8CXIdNcp2rjfOz+xm++PFcUB2WBL9eYlGsL5RDlp9r
 k1XkEM23R22jY4gfE1L1IeuLQddOur2RHE5r0JqgSrxuCFmqF7siJoqdyuY/Han2UBed
 /WvA==
X-Gm-Message-State: AOJu0YxTq5hhh+wUC6nBE4ipsINZCvMzGFiVqIXjvN+PcQ0HMIZm7xol
 YOeisXRW4iIB6bjTAVEzlSHal30pKGmv7PvWoKTamm9Hs7kRNOFfe6yetwfUZibH
X-Gm-Gg: ATEYQzyTyFcqOt9b8h4mUTfDh+0wyq+7L2BZGJhHg/AmFhuxbHEgdZHVMPJ8IhDAyoJ
 H0deQlMLN1Trb/3FzxFRaYQaAPrD+FNdlJFgx7TTvP/SMM+GuBia1jltZLnOJFUBLxmuGKB96nS
 4cC2dS98uZ9v9MkNn31TXOhQ9un/bH5eVxvsQhXIjlHisYgRpWj24yF421bHvVErx2bBTUy+9YS
 Exb8you54bbmgSCbH3ALou5tfT1Ec1EhWpt33WY/wvWHDW911OkgPtoyeLIcB9M02g+Mmbplxdb
 nD9CsX9LxJDfEseMo3LLZfC4znVmkyEGvWwJ33vzPPHu8NeoN7ZWnLwXewBbMVJ7E+gxy9Pg9Su
 UHdqNAMX9kIBrbUT/kXlx9SYeWjI+zlsR7QofoOYWY3SnY1MSGbzDGtFMQUiNU0DFBDUibo8v0r
 wIVlFDO+exoF4isiSTT2rmyCvJYNNCAgQoY1p8zGk=
X-Received: by 2002:a05:600c:4e16:b0:47e:e414:b915 with SMTP id
 5b1f17b1804b1-483c9bb6564mr115048465e9.2.1772307901877; 
 Sat, 28 Feb 2026 11:45:01 -0800 (PST)
Received: from tuf-gaming ([191.101.31.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f3124sm298665995e9.1.2026.02.28.11.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 11:45:00 -0800 (PST)
From: =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	jean-christian.cirstea@tuta.com
Subject: [PING] [PATCH v2] linux-user/strace: fix printing of file offsets
Date: Sat, 28 Feb 2026 21:44:50 +0200
Message-ID: <20260228194450.211977-1-jean.christian.cirstea@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226173521.1957025-1-jean.christian.cirstea@gmail.com>
References: <20251226173521.1957025-1-jean.christian.cirstea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL=0.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Any outstanding issues?

