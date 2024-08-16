Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645C8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 21:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf4Yh-0005Vg-6T; Fri, 16 Aug 2024 17:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sf4Yf-0005No-1K
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 17:32:29 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sf4YX-0000Xg-Tj
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 17:32:28 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39d26a8f9dbso5326465ab.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723843940; x=1724448740; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ywAl+DfJiQVp1+6HyV0YRi+VIkZot69GPtIV0XSlNQ4=;
 b=fqMNbkVWjA0lSlWHQCQ6S4UawWiuCPj9KIhXAyC72AxXSCGp4SRjAvBhlxF39xbxOa
 m3JxAvS4Dh1L0kvI+cipQt3d6P0eXNmt7OxTlVU0j35xxEDiTITVjMRV6hASUCFlbYSm
 NGs0agmbOxVE+ZFv/WhiVWFX4zMPQ2LHEd7rovBrOujPVLpfyZRNH4ZzVSWje4ghqaxy
 sfQ559pmTTmWU3sm6ggYNp8J7RGOottTKuUUl6vFp7vs5Wh+kJmOcwSRMKVgq9ECgecQ
 +sgaWXLfHMStPyGOLzNDJ4uPRdDjWsNzya9UFuaGUh6Nh9TUJkQr2XK6jDUllHClX6DM
 BAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723843940; x=1724448740;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ywAl+DfJiQVp1+6HyV0YRi+VIkZot69GPtIV0XSlNQ4=;
 b=e4TGNpDeZlX2O5dLwQgyCUELk450GcldECQL3rw8tIkefHgkMSWkdgl93TjRoduEeH
 3OGhLyAqbbUhkYqrbn3UsyWkxY+/Gq3de7ezzrbAw+NA9zuGUzYh486ly+tq1H5voFzy
 PeM9HOJ7pjojAKWhmRA0kbZH/9177pIsSLFI0VAvcjUSRs8FWy6YiyrlpEwwAfMhoW3y
 PmdN169M/tne/swr6QZNpt8NEZgJtm8Y2st+KZcjha0yLkqTuwsWNLKGRy4vRS43lTpX
 GgKto8R+aIk1gMybxvqrIvBTVboLlxkVesobnL+KIv58EiUCRdaHaEsKf66V/9gOCxme
 BZiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUylgTP1tT7d0WObPXY+mK3n0wrzaRZH13/vdVa8XBUQWk4NTBSHPEEIhPI1sSqu5jbnf6CjyDE+Mid@nongnu.org
X-Gm-Message-State: AOJu0YwuKQ2b3xtvKNVWOWPYSQwQH5cLL1emlpoy46fDLUPbounKLVk9
 qndahMkfWrtTI040B+KIx4ZcdbKwb3/t47RT4BBZ8fVc+mJkTnmcOcVONw==
X-Google-Smtp-Source: AGHT+IEGV9kV3gdrhnl1xE4xnvsL5kBf7hewAv2qMnt2zosd412S9qsFfmWwlTZG7DbIVFWH9arTEw==
X-Received: by 2002:a05:6e02:1d8e:b0:39b:4ec2:c5c1 with SMTP id
 e9e14a558f8ab-39d26d5faffmr50317945ab.18.1723843940459; 
 Fri, 16 Aug 2024 14:32:20 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:81c0:8166:7e5b:29b6:51cb])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ec0305esm16013455ab.29.2024.08.16.14.32.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Aug 2024 14:32:20 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>
References: <20240816190620.1418311-1-bcain@quicinc.com>
 <20240816190620.1418311-3-bcain@quicinc.com>
In-Reply-To: <20240816190620.1418311-3-bcain@quicinc.com>
Subject: RE: [PATCH 3/3] target/hexagon: add enums for event, cause
Date: Fri, 16 Aug 2024 15:32:19 -0600
Message-ID: <019c01daf023$c629f110$527dd330$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHkSSDsbHa0lsPsUwH6PIsqcGtF+gLPBuBasgE8+dA=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <bcain@quicinc.com>
> Sent: Friday, August 16, 2024 1:06 PM
> To: qemu-devel@nongnu.org
> Cc: bcain@quicinc.com; quic_mathbern@quicinc.com;
> sidneym@quicinc.com; quic_mliebel@quicinc.com;
> ltaylorsimpson@gmail.com
> Subject: [PATCH 3/3] target/hexagon: add enums for event, cause
> 
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>  target/hexagon/cpu_bits.h | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



