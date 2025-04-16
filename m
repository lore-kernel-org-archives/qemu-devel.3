Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DB3C369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 23:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5CAl-0003P4-6K; Wed, 16 Apr 2025 19:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u5CAi-0003Ie-Sn
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 19:28:00 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u5CAh-0008Gz-05
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 19:28:00 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3d5e68418b5so1828495ab.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 16:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744846077; x=1745450877; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=B2Wp8g934lMbQ3AHhKii0nz2qHUM+Ly+Xnh/n0i3Wd0=;
 b=DaFdELciwIbH+f+Oo564FQwuGxGNhtqgqgTNVuSUNiQw7QIB0FajY7SxxWAuLazg0G
 vCSx+RynVu8Apgs1iXQ0FpFSprRzYTRkbS1AanAy2oNEnKAj2zXJopWSFN6NyrDPKHXW
 X7Aj900KU9dr8A+u5/C9nELAaH0YFrZEfI/cLLv1QCMHYXZ5KAXb5M15qIVQKoOFUiuc
 PpDfM3jC8A6teLdT0y5JLghYZPQtfDCCTBWsEuUrQexqjFBAGkbQzVWyDYTo9YFsed6n
 FvmvicWHDh1BQlMO46GC4OM3BKazjwjmAjY3+rMQ7qjYadgx92xuo+u6Bwld2NQvGcWy
 jkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744846077; x=1745450877;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B2Wp8g934lMbQ3AHhKii0nz2qHUM+Ly+Xnh/n0i3Wd0=;
 b=HXr/PWpW+DdBVn74idbMnKObX6SZm/JiJwM4mo4POUwrwqVnoCZBoCAvC+ehhnEfXA
 PmZAJQkQGlPIaYfSHKCNa6iTJZbXs3KtGgJgqhbMeJfB3dIF/fD+cbHzLV8HmetMUl8w
 aVGmgH1dQNVfH3uHccHR8vdJGJNzARymLkISkppXKeRBkKuF5cSWbGdVj+L5nDMvhx89
 cBHvSNXnh8E9vjCo2DUr7cZSzBrHuW+U+qsNhLHVK5Y+dqp/x1sUWKMvOv+jcJ2HZIhl
 BMW6ZnxWhoDW/7uhPSQWH/YbcTcKRgzf6WdYg2YaTaWNkZpGkQ2EU5HCZ3IoQY+p4G40
 8FHg==
X-Gm-Message-State: AOJu0Yxv6r9Rl9b8A/MBFXsDRBKjS2OO64mUSjVIwfvOXiYT5jjBpXsp
 INWxXZ1goLE/C50UPC5xVJWaoB8xhVC+c7UBB+RVNzrXmaj16zrF
X-Gm-Gg: ASbGncuJNZI2KT0n3QDZWE5xww/7+gt/CBNQGpeejpfEx2nkASuG1Cz4sbHOJcadwJX
 belOcFd7K+BpsYg5ahCDSlDfteoEo+jAZUQGLAkXwxoK1wnweZ9sCOOGrzKcl7YXQPWGeiikPOo
 +eQJ3J4vwNHk4rmVQvB+oHyRrAeMm4HEUHUyokjixd51B53wshdG+pok9il4QG2QulD6pF32rIU
 RyZI1a5bPXDWyDP8e2ZSE077v+3zKthew84KxrJuPq30sST6zK41HaCx8+odjuwUdYuWITnC3c8
 6HFoKEAEUSUtwGw3iWyWR/gmx3VxE5hLAXgC8geaou+le9hNWvt+JLfb+qPWEOyf2ts08xA17Wc
 =
X-Google-Smtp-Source: AGHT+IGiTCDKfYrWAuZP+P/lOrq97nsLhs9ntOE5sAi5TTYkqeX/TDBp59OZdLYysTDdHegPN46Yxg==
X-Received: by 2002:a05:6e02:1d84:b0:3d5:eb14:9c85 with SMTP id
 e9e14a558f8ab-3d815b10ce6mr33640295ab.6.1744846077376; 
 Wed, 16 Apr 2025 16:27:57 -0700 (PDT)
Received: from DESKTOPUU50BPD (c-67-190-160-7.hsd1.co.comcast.net.
 [67.190.160.7]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f673e84f0fsm1604881173.91.2025.04.16.16.27.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Apr 2025 16:27:56 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
 "'Matheus Tavares Bernardino'" <matheus.bernardino@oss.qualcomm.com>
Cc: <qemu-devel@nongnu.org>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <ale@rev.ng>, <anjo@rev.ng>,
 <marco.liebel@oss.qualcomm.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>
References: <058801dbad61_68ff5b00_3afe1100_@gmail.com>
 <20250414180939.3575845-1-matheus.bernardino@oss.qualcomm.com>
 <05df01dbad80$17e73890$47b5a9b0$@gmail.com>
 <b8f2eb78-1cc6-4d82-8597-6d994a6a6f66@oss.qualcomm.com>
In-Reply-To: <b8f2eb78-1cc6-4d82-8597-6d994a6a6f66@oss.qualcomm.com>
Subject: RE: [PATCH v3 5/5] target/hexagon: Remove unreachable
Date: Wed, 16 Apr 2025 17:27:53 -0600
Message-ID: <07bc01dbaf27$2f1c49d0$8d54dd70$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQENfVRWeNfVsGY4Eunk52BzijBbDgFBXIfsAUgg7kgCPoaJ+LUdEzng
Content-Language: en-us
X-Antivirus: Norton (VPS 250416-4, 4/16/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x134.google.com
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
> Sent: Wednesday, April 16, 2025 4:22 PM
> To: ltaylorsimpson@gmail.com; 'Matheus Tavares Bernardino'
> <matheus.bernardino@oss.qualcomm.com>
> Cc: qemu-devel@nongnu.org; richard.henderson@linaro.org;
> philmd@linaro.org; ale@rev.ng; anjo@rev.ng;
> marco.liebel@oss.qualcomm.com; alex.bennee@linaro.org;
> quic_mburton@quicinc.com; sidneym@quicinc.com
> Subject: Re: [PATCH v3 5/5] target/hexagon: Remove unreachable
> 
> 
> On 4/14/2025 3:59 PM, ltaylorsimpson@gmail.com wrote:
> >
> >> -----Original Message-----
> >> From: Matheus Tavares Bernardino
> >> <matheus.bernardino@oss.qualcomm.com>
> >> Sent: Monday, April 14, 2025 12:10 PM
> >> To: ltaylorsimpson@gmail.com
> >> Cc: brian.cain@oss.qualcomm.com; qemu-devel@nongnu.org;
> >> richard.henderson@linaro.org; philmd@linaro.org;
> >> matheus.bernardino@oss.qualcomm.com; ale@rev.ng; anjo@rev.ng;
> >> marco.liebel@oss.qualcomm.com; alex.bennee@linaro.org;
> >> quic_mburton@quicinc.com; sidneym@quicinc.com
> >> Subject: RE: [PATCH v3 5/5] target/hexagon: Remove unreachable
> >>
> >> On Mon, 14 Apr 2025 11:19:38 -0600 <ltaylorsimpson@gmail.com> wrote:
> >>>> -----Original Message-----
> >>>> From: Brian Cain <brian.cain@oss.qualcomm.com>
> >>>> Sent: Monday, April 7, 2025 1:27 PM
> >>>> To: qemu-devel@nongnu.org
> >>>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> >>>> philmd@linaro.org; matheus.bernardino@oss.qualcomm.com;
> >> ale@rev.ng;
> >>>> anjo@rev.ng; marco.liebel@oss.qualcomm.com;
> >>>> ltaylorsimpson@gmail.com; alex.bennee@linaro.org;
> >>>> quic_mburton@quicinc.com; sidneym@quicinc.com
> >>>> Subject: [PATCH v3 5/5] target/hexagon: Remove unreachable
> >>>>
> >>>> We should raise an exception in the event that we encounter a
> >>>> packet that can't be correctly decoded, not fault.
> >>>>
> >>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >>>> ---
> >>>>   target/hexagon/decode.c | 6 +++++-
> >>>>   1 file changed, 5 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
> >>>> index b5ece60450..1db7f1950f 100644
> >>>> --- a/target/hexagon/decode.c
> >>>> +++ b/target/hexagon/decode.c
> >>>> @@ -489,7 +489,6 @@ decode_insns(DisasContext *ctx, Insn *insn,
> >>>> uint32_t
> >>>> encoding)
> >>>>               insn->iclass = iclass_bits(encoding);
> >>>>               return 1;
> >>>>           }
> >>>> -        g_assert_not_reached();
> >>>>       } else {
> >>>>           uint32_t iclass = get_duplex_iclass(encoding);
> >>>>           unsigned int slot0_subinsn = get_slot0_subinsn(encoding);
> >>>> @@ -512,6
> >>>> +511,11 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t
> >>>> +encoding)
> >>>>           }
> >>>>           g_assert_not_reached();
> >>> Why leave this one rather than raising an exception?
> >> Good point. I think this one should be removed as well. We have
> >> removed it downstream already.
> 
> 
> Taylor, is it satisfactory to include that update in a subsequent patch
> series?  Or should this one replace the second unreachable too?

If you just remove that line, it will fall through to the "return 1" below.


> >>
> >>>>       }
> >>>> +    /*
> >>>> +     * invalid/unrecognized opcode; return 1 and let gen_insn() raise
> > an
> >>>> +     * exception when it sees this empty insn.
> >>>> +     */
> >>>> +    return 1;
> >>> You should set insn->generate to NULL if you want to guarantee that
> >>> gen_insn will raise an exception.
> >> The caller already memset's it to 0 before passing `insn` down.
> >>
> >>> Do you have a test case for this?
> >> We do have a softmmu test for this downstream. Maybe we can adjust it
> for
> >> user-mode and upstream it with this patch.
> > Take a look at tests/tcg/hexagon/invalid-slots.c to see how to do this in
> > linux-user mode.  You'll also need to modify Makefile.target in that
> > directory.
> 
> 
> Matheus provided a linux-user test offline.  I'll include it in an
> updated patch.
> 
> 
> >
> > HTH,
> > Taylor
> >
> >


