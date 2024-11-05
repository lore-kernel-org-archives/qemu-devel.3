Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18848D31761
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8MFN-0000TJ-KH; Tue, 05 Nov 2024 11:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1t8MFH-0000Rx-VJ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:17:32 -0500
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1t8MFG-00016H-1F
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:17:31 -0500
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a4c303206eso19526805ab.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 08:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730823449; x=1731428249; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xLLt1Jyc86/pewM+/+X/wk6Jx38dM+YYRY/cirKrEac=;
 b=UWEIMLL9QJYootVTiEaBcopQiTJchCvOARNeYKeSmcj2Ws3b5FBAwWbN9hWhW81i/N
 soSUj+hh3tXHTSJKxbpsUbrBaQbFz73Xaz9fYea2GMEvRjMZrqJzBSmLIWZNfE/Bj/qr
 morBm6vX5A+VG82uTCjTEBig1pt45gU0VzuWrsboS3KEBC005BYU6UxJbYtCp0ybdcTo
 l4twXku4EOuHLEY5go66A1Yne0YL49aywJJ94Mo8yv2y7oNRc75Yw8lI3wIQWzJdLAfZ
 4VrsGThC+oBW1F0RYupPDVrIrhyPw17FNfie4EhQQRhbGYF3Q1Yj4SqwmnV4SYkZJBBV
 g55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730823449; x=1731428249;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xLLt1Jyc86/pewM+/+X/wk6Jx38dM+YYRY/cirKrEac=;
 b=KNwO40t0rQDZ3VWBhUn4C+E95VOCVQ1NAHtdQl/Z6thWY9mBqGXtu5UR0t4eUlLPJ3
 I7/fJni/kqu/WQHhQEEL0ZMgcCSVyJBu+Zzamk30FB9lFj9/xqcLnRngD/jhMuSNHBai
 4btG8FThGMkMjL+z5ln4DmSarvsgxrolNx42tpsiQmyNc9w3TIjU5UX8PJDVmBgCwnmz
 3XedJbXF4NePLCfubhZf6n3BWN1gFsgawsqv+lNsZBQbG92lxI7ZEvkcpcuVDpwXxqwX
 07YJUHA86c60dU6L4Q6E22/VJX2mtnH0e9dLPitfnz5JbeSkZLu+5GTdZ92MIZEq2i9k
 vk1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt12FrYtl9lTMp8jUsVU7Dh4v2RxWcrG462i4pzqDTYwDpSuX94l71jI82nQMMOiZBzxgsvOeUNoPp@nongnu.org
X-Gm-Message-State: AOJu0Yz1DPI4/70VvbqAHVGPlxct0M1jkB8IERygk69Q+y9/qO2uEz2C
 YjxuGIDzk9EG89lj8O9TUjpYpaHxLrdkoGZMoIkQag/PZVoROE8z
X-Google-Smtp-Source: AGHT+IHIZ69IVriJjDy0Kv8qx+A9xoY0n69GrgMDTrBKg4x0nTX/6H0rpdyGEoUc4EvfiV4GDC8BOw==
X-Received: by 2002:a05:6e02:1d11:b0:3a0:8c5f:90d8 with SMTP id
 e9e14a558f8ab-3a6b02b4c3bmr162209225ab.6.1730823448643; 
 Tue, 05 Nov 2024 08:17:28 -0800 (PST)
Received: from DESKTOPUU50BPD ([2601:281:800:5d0:44e1:855c:55b:f969])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de049a4566sm2472530173.150.2024.11.05.08.17.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Nov 2024 08:17:28 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <quic_bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: <bcain@quicinc.com>, <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <ale@rev.ng>, <anjo@rev.ng>
References: <20241104174904.61180-1-ltaylorsimpson@gmail.com>
 <36e0fc16-b207-4c9b-9832-038fe97a55b6@quicinc.com>
In-Reply-To: <36e0fc16-b207-4c9b-9832-038fe97a55b6@quicinc.com>
Subject: RE: [PATCH] Hexagon (target/hexagon) Remove HEX_DEBUG/HEX_DEBUG_LOG
Date: Tue, 5 Nov 2024 09:17:26 -0700
Message-ID: <059401db2f9e$3518fd50$9f4af7f0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIIU1+f+J6GnzxuNS2JyCooCdRcsgGqN6OpskFCa0A=
X-Antivirus: Norton (VPS 241104-0, 11/3/2024), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12b.google.com
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
> From: Brian Cain <quic_bcain@quicinc.com>
> Sent: Monday, November 4, 2024 3:52 PM
> To: Taylor Simpson <ltaylorsimpson@gmail.com>; qemu-devel@nongnu.org
> Cc: bcain@quicinc.com; quic_mathbern@quicinc.com;
> sidneym@quicinc.com; quic_mliebel@quicinc.com;
> richard.henderson@linaro.org; philmd@linaro.org; ale@rev.ng; =
anjo@rev.ng
> Subject: Re: [PATCH] Hexagon (target/hexagon) Remove
> HEX_DEBUG/HEX_DEBUG_LOG
>=20
>=20
> On 11/4/2024 11:49 AM, Taylor Simpson wrote:
> > All Hexagon debugging is now done with QEMU mechanisms (e.g., -d
> > in_asm) or with a connected debugger (lldb).
> >
> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > ---
> >   target/hexagon/cpu.h       |   8 +--
> >   target/hexagon/helper.h    |   5 +-
> >   target/hexagon/internal.h  |  13 +----
> >   target/hexagon/translate.h |   2 -
> >   target/hexagon/genptr.c    |   9 +--
> >   target/hexagon/op_helper.c | 112 =
-------------------------------------
> >   target/hexagon/translate.c |  66 ----------------------
> >   target/hexagon/README      |   9 ---
> >   8 files changed, 4 insertions(+), 220 deletions(-)
> >
> > diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
> > 764f3c38cc..bb7d83b53e 100644
> > --- a/target/hexagon/cpu.h
> > +++ b/target/hexagon/cpu.h
> > @@ -1,5 +1,5 @@
> >   /*
> > - *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All =
Rights
> Reserved.
> > + *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All =
Rights
> Reserved.
> >    *
>=20
> You should not modify the QuIC copyright dates.  But you can add your =
own
> copyright to these files for this change, if you like.

I'll undo the QuIC copyright changes, but I hardly think removing code =
warrants adding my own copyright.

Thanks,
Taylor



