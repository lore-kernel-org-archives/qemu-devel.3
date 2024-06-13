Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163C6C27C53
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 02:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHaW8-0004wb-Ii; Wed, 12 Jun 2024 22:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sHaW7-0004wC-BF
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 22:48:47 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sHaW5-0004VZ-CU
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 22:48:47 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7ea0b5e0977so21459239f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 19:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718246924; x=1718851724; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5eGyMd1/SJaL4TQhGw3ov1yYwoLJ/pk1+G5PtSWlTSM=;
 b=jS73rbA4Ps9LmIcwhWMTwmeQkdAEz5iHC7b+jXdzgwdIXXI1KqfkerGztTROCD7W6w
 hRxH+EoxNnahhjEw1D/WltM4YN9X3ynk+PmQwu3vFWBwkT8BN9s7AMKsrdU/KMoQX0lT
 vosfn+1qFOcICpfMNJjJUul/03j4TvC3Xq4uoaa7py4KdSFEiu4Gi2w3AUd1kCqm9bI6
 GEkZvp0A8HjJlACxd6gyMOc7z6CuxUCReSK9+QMQJR4Acxt//31SJQZqB49N/mw8nu2w
 ZkoKY9J1fBEx+/U2syPRtqspFIY2WY43BcNsjMXwqCpuuD++0iFoS55c1Yy0XRTHV4I5
 q5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718246924; x=1718851724;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5eGyMd1/SJaL4TQhGw3ov1yYwoLJ/pk1+G5PtSWlTSM=;
 b=JLV7QH2eYi5I31dxNcydni/pGy3xkIbGl3pGwDLxVKtlBAQ4rQT2YorkIDvy/NwksM
 CCxxe6W0mm1vnr1Y66AWvRQmuqFHPOfnwcYgdY9CaA+mgvm32R4djISZP0piQYVdv8Jz
 2ANZPV69IHA0N6ed/tAInJorbbevKkqzu5oeho7wcRyeQ2mLdbM9ZK0v4oGuKRhq/VB2
 E6oDLc243dpaXn7ocTuS8gPjQooaT3IazyvOVsF70hTv//J7Pqir6PsI58J/lmwxpXYQ
 Od8BGmuUMw1EMCcDraLiRKPniYsqZLvKz/QDoyRjDJh01Peu8lqC1cUGqJqT67BGOl1f
 gyIA==
X-Gm-Message-State: AOJu0YyL8/69ppMGIs/2U57EAVPDyQRBA+tUTSvkSgk9wg1kbC6YApfO
 7fnl8Qq7aIaaUgaQmEtQ8usSkyxLYNRVyiyYMFP3hYZOOcsLalM0UvUud0P2
X-Google-Smtp-Source: AGHT+IGwYEuoc0bsSafW9R+8CluCfrDH9S0zdXF5BFLkXhgHr+xqnp68tICkPcKmimm6LqMPtT+bPg==
X-Received: by 2002:a05:6602:2c88:b0:7eb:2c80:5329 with SMTP id
 ca18e2360f4ac-7ebcd0bb49bmr458011439f.7.1718246923896; 
 Wed, 12 Jun 2024 19:48:43 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:81c0:582b:6312:c6b:a6f0])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b956a409b7sm111762173.154.2024.06.12.19.48.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2024 19:48:43 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Matheus Tavares Bernardino'" <quic_mathbern@quicinc.com>
Cc: <qemu-devel@nongnu.org>, <bcain@quicinc.com>, <tedwood@quicinc.com>,
 <alex.bennee@linaro.org>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <ale@rev.ng>, <anjo@rev.ng>
References: <20240612164239.90276-1-ltaylorsimpson@gmail.com>
 <20240612183008.4123155-1-quic_mathbern@quicinc.com>
In-Reply-To: <20240612183008.4123155-1-quic_mathbern@quicinc.com>
Subject: RE: [PATCH] Hexagon: lldb read/write predicate registers p0/p1/p2/p3
Date: Wed, 12 Jun 2024 20:48:42 -0600
Message-ID: <066c01dabd3c$343be980$9cb3bc80$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHMHiXUmCnzvbCFbV64tIsn2swJnwIEBIVEsdIVtQA=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd36.google.com
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
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Sent: Wednesday, June 12, 2024 12:30 PM
> To: ltaylorsimpson@gmail.com
> Cc: qemu-devel@nongnu.org; bcain@quicinc.com; tedwood@quicinc.com;
> alex.bennee@linaro.org; quic_mathbern@quicinc.com;
> sidneym@quicinc.com; quic_mliebel@quicinc.com;
> richard.henderson@linaro.org; philmd@linaro.org; ale@rev.ng; anjo@rev.ng
> Subject: Re: [PATCH] Hexagon: lldb read/write predicate registers
> p0/p1/p2/p3
> 
> On Wed, 12 Jun 2024 10:42:39 -0600 Taylor Simpson
> <ltaylorsimpson@gmail.com> wrote:
> >
> > diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c index
> > 502c6987f0..e67e627fc9 100644
> > --- a/target/hexagon/gdbstub.c
> > +++ b/target/hexagon/gdbstub.c
> > @@ -56,6 +64,15 @@ int hexagon_gdb_write_register(CPUState *cs,
> uint8_t *mem_buf, int n)
> >          return sizeof(target_ulong);
> >      }
> >
> > +    n -= TOTAL_PER_THREAD_REGS;
> > +
> > +    if (n < NUM_PREGS) {
> > +        env->pred[n] = ldtul_p(mem_buf);
> > +        return sizeof(uint8_t);
> 
> I wonder, shouldn't this be sizeof(target_ulong) since we wrote a
> target_ulong?

Good question.

From the architecture point of view, predicates are 8 bits (Section 2.2.5 of
the v73 Hexagon PRM).  However, we model them in QEMU as target_ulong
because TCG variables must be either 32 bits or 64 bits.  There isn't an
option for 8 bits.  Whenever we write to a predicate, do "and" with 0xff
first to ensure there are only 8 bits written (see gen_log_pred_write in
target/hexagon/genptr.c).

I did some more digging and here is what I found:
- Since we have bitsize="8" in hexagon-core.xml, lldb will reject any
attempt to write something larger.
  (lldb) reg write p1 0x1ff
  error: Failed to write register 'p1' with value '0x1ff': value 0x1ff is
too large to fit in a 1 byte unsigned integer value
- For the lldb "reg write" command, the return value from
hexagon_gdb_write_register isn't used.
- The only place the return value is used is in handle_write_all_regs.  This
function is called in response to a "G" packet from the debugger.  I don't
know if/when lldb uses this packet, but it seems like it would count on it
being 8 bits since that's what is in hexagon-core.xml.

Ted <tedwood@quicinc.com>, when would lldb generate a "G" packet, and what
assumptions will it make about the size of predicate registers?

Thanks,
Taylor




