Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B309DCD041F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 22:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vctSY-0003kg-QY; Mon, 05 Jan 2026 17:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vctSJ-0003eT-Nw
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 17:53:51 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vctSI-00080R-2s
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 17:53:43 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a4deso2513305e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 14:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767653620; x=1768258420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B20Jgw4DvutlnNx46WbeJAQjofMEWMs8ePQQcYM2s3w=;
 b=jIq0YUbmSew3xqJanPv1z8+pHVfs7AUPoxYyaLeCDZ/Qo1lW7Lq0MUqkyIb1xLHJRj
 EMPmD4FCOup6iMgZoJkCwSsIKkVNAHtuC34FvdkYh761GIAZZT3Vr9zGTXeESF2yPP2q
 8ENe0yHS+nAOAC2b9vlJRn+MOEgWzl5sFvQjYYyQ9yM3NXglBTy4oUPzWivvtSIsG8sV
 uTdqOGKhvW5bBojGGRfHiBcnr+hv8J4SpVQiv4YV7ILdrk1cCPR4ycI/Rd2b420ef9Xf
 1Hi4IelAlLKV0dfPpR5JMbQNUmc28cUauMdc6gkkYTV9dztQs7S1/Z/T1RKRY7MJRx9u
 fUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767653620; x=1768258420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B20Jgw4DvutlnNx46WbeJAQjofMEWMs8ePQQcYM2s3w=;
 b=bprzB7OQtk7NSiqR+yOZ/cVeqwpn0BvRj+9EMi2KZ+2zW5JiKrGtTIGJSx/xtGl5Ge
 wNuSdDoH660TVyqnEKqbl6kZTMIiKtuRU/hbEu4NmR+fbCxZKwSu/uxpug7W+aZXnbrm
 yekWYd0ooZp1AD655bd3r/+Pu7GFfxBTm5teduopzA+jN0dunILuaKcuOrLeIZNqlqCQ
 OUHCGhDF7/G64WOMhODEMf2cAZxP08tMCy7EgF3bq0tKB9XLPzJTV7YTknbIckQCJf3C
 jQBGwMAQpwGPRcxHRiOE/WP5nxxsgW8+9gstpDXi55KZDtsFCgS6fpHtmi/5DwMb+GS5
 yKcw==
X-Gm-Message-State: AOJu0Yw9qEEho4n/ojw2UPIukDuUXiBdLSKkaFcGGJA6Bu3iqba0j51k
 v0gUMrHNCcY1/aRgQ44DzRDKkgisSR0DcWRgXqu0yjxy1KOxRVSXDJripQdKWBzb
X-Gm-Gg: AY/fxX7hqMRfHdhua1pnGLEEUj4TpDvjNPp4CQp2HlFG9bEYNkbxpPooVdJGyzZdhL2
 FWdBd/VVK08x8pWD8vISdf+R+yqFBW8Fn0tTa9YnrBRU4HSnhpHK245MEf9gURuJqtqp9h2jRYS
 GbMQ0LOHIbmAbT+xMbSUFjxX+71EzKDXs5jDJkpCz+/HjW2R2JCOufb85zd1NkQqVV40Db0xsMd
 QpDx0OgQHW56WqGFm38cguUdn2sDyBiIr+QnZELTJDyNTMcYLfDbEBWL22it/vNpKmYhZRATL3q
 76FbDYWvIjgMvTk9RzujmP6sQi8HQevwvKsarCj2gHXBHjxMgjmjq5TuHXgz5Xo9GQsKzpP1fdv
 vR5MhJuxepdB1Pcrgu05NKln2y7LIOiPUWTy1KWv3rcTjv0DO+HFUr7KSxNElC9kribxS/iRI5C
 eehVArMd/3ExCanjzS8mmwrJJjPjg=
X-Google-Smtp-Source: AGHT+IF0p3wNtAsE0cSNd1r6XlrQlJn6TuN4GEGudqOECOOdDh+2Sv4XmnR4e9H/gDkuOPeg0YMyUw==
X-Received: by 2002:a05:600c:154c:b0:477:a3d1:aafb with SMTP id
 5b1f17b1804b1-47d7f0a1906mr10241675e9.29.1767653619457; 
 Mon, 05 Jan 2026 14:53:39 -0800 (PST)
Received: from tuf-gaming ([92.204.188.253]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7fb5b246sm3091255e9.18.2026.01.05.14.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 14:53:39 -0800 (PST)
From: =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: Re: [PATCH] linux-user/strace: fix printing of file offsets
Date: Tue,  6 Jan 2026 00:52:24 +0200
Message-ID: <20260105225224.2626651-1-jean.christian.cirstea@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <7f76c078-0a39-4d2c-94d3-04075f9fb85c@gmx.de>
References: <7f76c078-0a39-4d2c-94d3-04075f9fb85c@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wm1-x32f.google.com
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

Hello,

It looks like you have reviewed the old version of the patch. The new version is
available at this
[address](https://lists.gnu.org/archive/html/qemu-devel/2025-12/msg03197.html).

> Did you test it on little- and big-endian machines?

Just on little-endian. I don't have any physical big-endian machine.

