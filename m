Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7D2606A6A9
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 04:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JRgn4m7O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUcqH-0006KP-4M; Fri, 20 Nov 2026 23:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjuran@gmail.com>) id 1xUcqF-0006K1-BG
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 23:36:47 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jjuran@gmail.com>) id 1xUcqD-0004zd-TZ
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 23:36:47 -0500
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-921375f52b8so15423316d6.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 20:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795235804; x=1795840604; darn=nongnu.org;
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :content-type:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3s9CnNBEt4aTMyhfQQSmddO6Wtu9Ue2/Czz4UyvCfH4=;
 b=JRgn4m7OJIS3OJKhHXus/zYPdTG3uqwtXbbRktV2+MfwnaWIekbQyRe+XnQpHsS61V
 QBAR+C82m80TFi4KJxJsn9dP9xV6DQLZn31wbD2Q7SCw96nigpH1gSW8rBLrI50ooofM
 2ZoCdvZS52wIyjBHfGGFE909uTA1Sjl/KzCRfarwG9oYJC5CyQ/ub3NgRAOwiN8KBVON
 xl9CLm2R/FaGsRbz4XLb6h6CCFYvZr9sgMDGBhxJTtgi/j/IMByJg7LCB976jgaVN3dt
 BC5GHZljXCprlGQt0urNjreZW/XZLMNjE3lX5AtUCiB5UVEtSBO4Ppi/NQus1GM/rVit
 60hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795235804; x=1795840604;
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :content-type:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3s9CnNBEt4aTMyhfQQSmddO6Wtu9Ue2/Czz4UyvCfH4=;
 b=EgHpG9bYdNds53xNdHa66o9HD13gMq9fLkSeHZGnpgQ2eL3VjONVuUm1yE5fwuw1nO
 C940LLeNapP5VlAHAjyr2EfgIH1AtHesA0QDTXUpCeGb8GsYZ73JAZOjjmfn6YQdxAUc
 ISCM1QOOkyaqeUwyseqXzDnp3ETVBoHSQYdLnJltu9BKKUMDURG9sATIXEb0B1CmDtbW
 CZ0f4JyAHVKM3YuMRvfE/7p9y2IWTJM14lpqAjjue+u5/Wadtqwn2X1/VBQrFmi7YIFt
 b8cmKTQNJ77GedEb+h1IuADjVYepCn75JD0tXM7IDj6q+nXs4Qdbo4O1ILGy8MpUcDWJ
 guGQ==
X-Gm-Message-State: APuU4Z/hQ6bJD+kSEz43blOw7eP91l9lDPDKxrn9hMtGxSQy2jZ2TRpC
 f4xc6wyow+tzomjgIN+BQUKrxegSBkIfGmawufV5GcH6fDqnTr45ZZCcqZIYTw==
X-Gm-Gg: AZFdTZeLhnzIY+Gf45UXrQ3uWxf8J2bnOUqIVlryIKIbwPJ05Mw4Jp2Si1e8Cbz89oY
 6jCNJhBXglIn0vsDkKj6LQYdfVtOngC4zr3tteAcIY0ZL8pCxfWDqQm6HG9QpOQWPosoaaOE/Gj
 9M4PVgONbnn5XZNDdmBr7UA7g66E8ArzZl0UC9JbsiU1+Y+UdbMzseYzJrixZnSt7qti3VrUdIB
 wZjTSGHOjZ0sQKXvFdNbv8V+vXYf3EWwtdRFvyy41LjRWlvuT7phWy0otYMgaSTV952NQORUINP
 7Fc6Yjn0KV9lRCACESmMMWPmvIlsWGgrOScGaW74hTY5CVaHkk1UYixFsjbtoZFTzEQ/ViBjWPE
 O46BS7Q5t+jQ3KQ3DP4SEF+rn0Qik32SuFuXn+0GyA1dHBfZLoGu5lscoA+DFfdHzIw7Z7su4GM
 XyqJfYf46bOmBE4hcPMGSs9jtWzvMVZre7Qmtee4c6rHN6F7/ySynsxbcVDYgB/H2B1dcP89VZQ
 n7O3qEqxTFdM1duLFRLx8+K/EXHY1rpaknJWuG1qypC7gAFEIY8dnm2tzFgX3gi9ZFrEP1w6A3z
 O0X9U9zdyuHH8o0v8HXfS9Sfa7f8N8juqrVS/XzyI2R4s0Q+qrY=
X-Received: by 2002:ad4:4ea5:0:b0:91f:191d:f7be with SMTP id
 6a1803df08f44-92134ba1fa0mr85653726d6.52.1795235804058; 
 Fri, 20 Nov 2026 20:36:44 -0800 (PST)
Received: from smtpclient.apple ([2601:152:4003:30d0:7c6b:7e8c:e125:6e3a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134796288sm43821746d6.6.2026.11.20.20.36.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Nov 2026 20:36:43 -0800 (PST)
From: Josh Juran <jjuran@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: WMGSO Fall concert
Message-Id: <6163B1A0-4E32-4318-93DD-71BCA8595A4A@gmail.com>
Date: Fri, 20 Nov 2026 23:36:39 -0500
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3654.120.0.1.15)
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=jjuran@gmail.com; helo=mail-qv1-xf29.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://givebutter.com/WMGSOFA26

No solos this time.  Not for lack of trying, though!

Josh


