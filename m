Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D47C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 20:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1two1w-0004kE-W0; Mon, 24 Mar 2025 16:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1two1v-0004jh-Mc
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:04:15 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1two1t-0001KN-Kg
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:04:15 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-474f0c1e1c6so74340021cf.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742846652; x=1743451452; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UhkNGNAQQYhDVbfhnh8m8+HNqP6+GbyYMYmJyzTVhtE=;
 b=VLQPoDbLfIWJGV7eiBQ+mc3U1vkn67wI+MpGnAyuykgdq9E+sgyiY6HXqm5ZpIuP6g
 gaV/DVlxtXxQAQeV0KIPkA6M/Ne8dYgmFuMqEhJtGpezd4Ga97v7731qp0+pZsxrJEh6
 ookBboV+al1LKgNrpO1Z5S0VNm74w9wASo5sPjFGl0jvJMafxtebINs0hxuHWjWuNuPm
 cWwikLpD7WDeDmIT7kefMS9pUdinrPy92MhU3rsMpbKuWOGXQ6239D0a8aAKCk5bvFMK
 ayk3BEGUA0n5VpMk7+tjKUvRNljNiuJAz5n6yexYDl1WKgVdAMHDz0fwfFS1DnTCey1G
 laTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742846652; x=1743451452;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UhkNGNAQQYhDVbfhnh8m8+HNqP6+GbyYMYmJyzTVhtE=;
 b=dWcV1yjdK1hKBSUQf4m/q4RxAa1RxpECvgFH71rkjFPBZqbZTa4/u1Gd7uwh0J5h0Y
 j41O0QclF13skGkSg6ybll4WtnAVuUneo751+VAVktBmByPt06ZBOS5JxoPTlhRpXWTc
 A7vrAsCwEsqFqnko7M8/NO+EpSv2ToEU/8Cv78q5H+wz/Evdrwzu8nFdmMc6jMNV8B6g
 hRml+oQtNCRBprsZSsTybql2WuNG9rGtyd+/WVpTocWpPa+Vda6xfWUcO9GaU0RplIbG
 MEstUAu3xc0ZRjRoFoVoNmBMEfLafDkVX+eEWUesSKp82bN15uY/pzfJNw6uYHHpmIbv
 Cy4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsmURx5GoplXqn8+/aGhH9HjYDms1aZ/zkvcD9rAHJ1ZXkAsWQnHKTccCIK8ePn+odB8iTywauk4c2@nongnu.org
X-Gm-Message-State: AOJu0YyQmIkYSZ17J5BHoYKzsQJPGOahSF48QYLZ4ewvbF4ASzLTeL4p
 uiyd18J1pYH9zG99A9zKbTssayMpkrOvJrzh/7/Z7EArA1JeT6np
X-Gm-Gg: ASbGncuPfVGrLe21HebOGm6Z3PtNEphl2047u+nV5Zkzu2C2bhncbWzPlCcNDKtdJ/G
 OVRyBwAhYzKM5r/6sFFUDpcTiW97nwP86iBBLHGKJNRjHGtcm7wYTlhYtwtSHRcFoyR1NxpkgHm
 hSUhXONJZaKI04KJi9A8AGDM/9D0lna+bA+tkf8QJXcXkOzoBUOi/zAHRKmlxXKuydOcZYlHaBn
 g/Xehsx09JXYcMAxJ6f1ezWwaeMnynPRZuDQBfWhUVgxaBKQ71MbzlKxjN/SKaqR5hjdgc3/jpb
 2RZpNEsHM1TjnlMFM57OOdClDBVOISQWVCjMn+qy09cvwky0BelQ76ZGhiI39YJJ+cq0FaVkUQ=
 =
X-Google-Smtp-Source: AGHT+IEZhc9c2FTxYAXfmQDN3rYcdc9OskrsxBI0rMpooEsl29tzS2P6e+rBlGYKNDC8HFkxLJ5RGQ==
X-Received: by 2002:a05:622a:5514:b0:476:ad9d:d4f0 with SMTP id
 d75a77b69052e-4771de64135mr234939001cf.48.1742846652380; 
 Mon, 24 Mar 2025 13:04:12 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:319a:7f6b:e6fe:90fa])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4772b0837a5sm36426801cf.20.2025.03.24.13.04.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Mar 2025 13:04:11 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-6-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301172045.1295412-6-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 5/8] hw/hexagon: Modify "Standalone" symbols
Date: Mon, 24 Mar 2025 15:04:10 -0500
Message-ID: <04c001db9cf7$e92039a0$bb60ace0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQBnRK9gH0BRY5vrCSddsvIJtQ/qNAFvQpN4tl/roHA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250324-4, 3/24/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x832.google.com
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
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Saturday, March 1, 2025 11:21 AM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 5/8] hw/hexagon: Modify "Standalone" symbols
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> These symbols are used by Hexagon Standalone OS to indicate whether the
> program should halt and wait for interrupts at startup.  For QEMU, we want
> these programs to just continue crt0 startup through to the user program's
> main().
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



