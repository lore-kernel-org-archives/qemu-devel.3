Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759A6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 01:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdJzF-0005t2-Vl; Sun, 11 Aug 2024 21:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sdJzE-0005r8-IF; Sun, 11 Aug 2024 21:36:40 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sdJzD-0002DA-5F; Sun, 11 Aug 2024 21:36:40 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7a1be7b7bb5so2773103a12.0; 
 Sun, 11 Aug 2024 18:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723426596; x=1724031396; darn=nongnu.org;
 h=content-disposition:content-transfer-encoding:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifcR1ka3vOqg6/0AbJi89a+iRNbKWhS9OIR/CPFP8IA=;
 b=L+bHKwyHkYmUaq8U0Ki41wvbn+7qDWBaPzjUrPooD81lbBlsZESCQ/3BAkab+qYsA7
 RZcDs8yWKp6SErPMGcP69GKgt0pNUP/h5oWwTbJ5QNYSmjQ4P/47ctqCQPbJC97gAtfx
 rbtZFBitdSBkceb0sXurgoUYIdZeXiG+zc+TLGEVI22I5EFInsEP1UM66K5toxt52fhZ
 C4O5K8F1FFg7zxAnLIHKuLVQdzpq+uLxjRx8agaDUKXHG01Cbqffg6b68e+YfMQmvrLi
 8/CMwXWALesyMLGjU7E/d8jbNg2UNI4sSEyYcMKBZWZAkiHUF1u4cOD3tVX11ET5J9IU
 xgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723426596; x=1724031396;
 h=content-disposition:content-transfer-encoding:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ifcR1ka3vOqg6/0AbJi89a+iRNbKWhS9OIR/CPFP8IA=;
 b=LxQdTfN3SChVUJIfl5CvCcXq3GffT5b20rQdYxHD/DxTMUExn83EXuzZOHUkgTWu/i
 naCnok/46QgO3jYh5+iuBfeEevFT+xun04Fu254VLfBQtJuhfZlnj2Mi14FGJngNK/Gb
 DXi1hFP8FHv+BT9kq+S9/edUm2BaqiFB4YkS8xCUhjk8CIG1G/iEQigTdpWlphbvWmSa
 S2+fGW3y62gU6pL/0zdfYF2OqG6ow5oCH9p0FTyTkjoYB63j/REKrFY/FAPpO4WUZ1HL
 In41QAKiXJXctzMlbj3ZvceXtwT+YTTI8VMpP4tnj6ejx7xZx6wkYGFZF4v40E+nnBF6
 E0Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDtVoXqIF4iVcht7sjqvPylx7UWi1rcpmB/Yrr58iEPcgjMXdWLpGsPBN5QZDnUUDmFFjrT7iRGzXzQTiCu0vTVb6nCYcXyZ+i8jcr56amcP3BnFW1+X94CX9Vl5Q=
X-Gm-Message-State: AOJu0YwoQ86MYoxzWhuDoGplKM7DDoaQnQINiBwIuS8f55OutxdZIdaN
 6rtkESsWdD2D3zrIl2mgMztEdyRLiAWfnz5217K6+5JIqP/LNeoExwbr1Hzv462tT4sb
X-Google-Smtp-Source: AGHT+IEU2f38eAVUDSlYokOLc7xP7w/VEnxSXpcfJqCG5747auGfc8chsM5odpaupduDkMjk/fdnnA==
X-Received: by 2002:a17:90a:348f:b0:2c9:8650:404 with SMTP id
 98e67ed59e1d1-2d1e80565f6mr9061355a91.30.1723426596275; 
 Sun, 11 Aug 2024 18:36:36 -0700 (PDT)
Received: from amjad-pc ([192.228.221.130]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1fce30aa3sm3686409a91.9.2024.08.11.18.36.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 11 Aug 2024 18:36:35 -0700 (PDT)
Date: Mon, 12 Aug 2024 09:36:32 +0800
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: "=?utf-8?Q?qemu-devel=40nongnu.org?=" <qemu-devel@nongnu.org>, Hanna
 Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?Q?open_list=3Avvfat?= <qemu-block@nongnu.org>, qemu-stable
 <qemu-stable@nongnu.org>
Message-ID: <090A3ED9-F3F3-4DF3-AC49-F43A3DDC1EC6@getmailspring.com>
In-Reply-To: <d5b1de9e-2e70-448b-9f8d-57af6f643bf3@tls.msk.ru>
References: <d5b1de9e-2e70-448b-9f8d-57af6f643bf3@tls.msk.ru>
Subject: Re: [PATCH v5 0/5] vvfat: Fix write bugs for large files and
 add iotests
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On Aug 11 2024, at 10:45 pm, Michael Tokarev <mjt@tls.msk.ru> wrote:

> The question here is whenever I should include whole series
> (5 patches) or just one?  I picked up all 5 for now.

Yeah, we should include all of them (at least the first 4 are required
for the actual fixes), the last one is unit test for these fixes.

Thanks,
Amjad

