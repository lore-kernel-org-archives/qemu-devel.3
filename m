Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D93DC25B7A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 19:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s998z-00031Z-Fi; Mon, 20 May 2024 15:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s998x-00031P-Uq
 for qemu-devel@nongnu.org; Mon, 20 May 2024 15:57:59 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s998w-0002QM-3I
 for qemu-devel@nongnu.org; Mon, 20 May 2024 15:57:59 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2450441dd16so1753901fac.2
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 12:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716235076; x=1716839876; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=u3MoiWSajpCQZgpF1irSweYPyE9+tVq6G4DJ8nNQK4s=;
 b=T0V+ou84FNaw2QKBePdtcf6NYY14zorOSDvTinZZfkVRmpo/RzbsqbNFOLcFnoT/9H
 0WcG+bb2LORV58DzGBLFRq+CVP/h2zQkOAly33gjEa3+nvepnOp/W29oifR88d5Eonyl
 gdFElnMnA2sSTVryekjEUumRlOHFL8VpmE939BKbQTPpDmBCFyQlNuvPCChkY8N2t0pQ
 lM00XYzM9L21sJbbYFV0+cXg6vulB1+vGwYVtkVynnjCRvEE5iRN9ZXbkebvNmMPoBHZ
 uOnNRpus5q5Uftl4GHpVknNTiJS+Lo4kyAGRoGDacBGeSh1gR16aehe53axaflfg2R9E
 lYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716235076; x=1716839876;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u3MoiWSajpCQZgpF1irSweYPyE9+tVq6G4DJ8nNQK4s=;
 b=DolY9+TwTyOCDNltFUVm+0PnJqDw2yQqVztHFkcZ5JGyVBPlAosUgbptSxY4gd4dk6
 qGeqgTP81K7LPHIpilQXe99pXDkDHgDUmIviuvRsUR5JiJLdho3mtXZzQKAB5GibY4JU
 2NoMIXpekrN+I2VOqnoi0HYf+vy8EYoNR3rgftn34g0Qhx7PmaACp8+exMlSQegK44Km
 FcNCaeTNEcAbZwJRSRV3Q2UHLB+vmrSosd9nauxk+mElccDTfRjdAEZwwqK6TXr0L6V4
 DTOEG6J0wygqfPMaQrcsCE6y9NfJo/jZNzzPFmdviw4M2T9KskRmNah+VFHdabqozqBJ
 t5tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwinRc11n6Aq5a/I1ziNr7CqrPl0RK5IGtGxqnwludPDQSr2q2D9RR9hOVsZ8b59YETWsIwxQjhPVtNKgy+QkZ0y/P978=
X-Gm-Message-State: AOJu0YxTagoFNryLD5/3qcIdhFjMfrYkbHQQpM2UobFFwTzeRUFB/J+L
 DzLQ17MarOpNI0iv8B702fiGhn6EruZQsasAc20SGnEBywdabZbLIyzblMG800c=
X-Google-Smtp-Source: AGHT+IE1gr1f6VYKEPgIihj380V8eT+P+C0rRDY/ozKcqHKRGquCSUhuPa/yklkfu8+t0vHwnLjNsQ==
X-Received: by 2002:a05:6871:3a13:b0:248:e3f3:665e with SMTP id
 586e51a60fabf-248e3f36733mr8247426fac.57.1716235076163; 
 Mon, 20 May 2024 12:57:56 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:8080:1f00:9c00:2639:f689:1715:fc7b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-24547f8e949sm2284676fac.25.2024.05.20.12.57.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 May 2024 12:57:55 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Matheus Tavares Bernardino'" <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
Cc: <sidneym@quicinc.com>, <bcain@quicinc.com>, <richard.henderson@linaro.org>,
 <ale@rev.ng>, <anjo@rev.ng>
References: <f548dc1c240819c724245e887f29f918441e9125.1716220379.git.quic_mathbern@quicinc.com>
In-Reply-To: <f548dc1c240819c724245e887f29f918441e9125.1716220379.git.quic_mathbern@quicinc.com>
Subject: RE: [PATCH] Hexagon: fix HVX store new
Date: Mon, 20 May 2024 14:57:54 -0500
Message-ID: <029b01daaaf0$01eaf7e0$05c0e7a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJpUE6OPp3PM6qH2Jh5Vp7GW357i7CDPzEg
Content-Language: en-us
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oa1-x34.google.com
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
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Sent: Monday, May 20, 2024 10:53 AM
> To: qemu-devel@nongnu.org
> Cc: ltaylorsimpson@gmail.com; sidneym@quicinc.com; bcain@quicinc.com;
> richard.henderson@linaro.org; ale@rev.ng; anjo@rev.ng
> Subject: [PATCH] Hexagon: fix HVX store new
> 
> At 09a7e7db0f (Hexagon (target/hexagon) Remove uses of
> op_regs_generated.h.inc, 2024-03-06), we've changed the logic of
> check_new_value() to use the new pre-calculated
> packet->insn[...].dest_idx instead of calculating the index on the fly
> using opcode_reginfo[...]. The dest_idx index is calculated roughly like
the
> following:
> 
>     for reg in iset[tag]["syntax"]:
>         if reg.is_written():
>             dest_idx = regno
>             break
> 
> Thus, we take the first register that is writtable. Before that, however,
we
> also used to follow an alphabetical order on the register
> type: 'd', 'e', 'x', and 'y'. No longer following that makes us select the
wrong
> register index and the HVX store new instruction does not update the
> memory like expected.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



