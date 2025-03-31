Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1810EC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzKyF-0007Yy-VU; Mon, 31 Mar 2025 15:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tzKyE-0007Yl-Mt
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:38:55 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tzKyC-0001f9-U8
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:38:54 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-227a8cdd241so5658555ad.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743449928; x=1744054728; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y+iRYX/xQalMboqQgAbV2dXOcQ1A27wFDzT4V4vO6Vg=;
 b=AqIltYBoEqEdd1zQLRALR5rB9KKTRwbmvDA8fpzoDE84NNUaIXacXf1/2j1zN1UPvE
 ky2EVpnsb9owxuJQ6YCKLkHHK0k9WV0+crdmQ7lwkvG29akIn8BAbtrJWiPEoRs5HY03
 Ia+T9bD74+PNHMxIdw1D3FYyDLtj7oQfW9QCpdzwKnid/jhi73GCPL/aOOtAh+14ig8E
 yV4bMmSXwBc5qsy7ItRgI8yu77kKv7/S45xZyjh3mVQygEJkZO9d3nagQWlWvffSUCpt
 4b5pEdjl8Uz6GdnXI6CbTXgEoqAmqYe6arnTeL7Iwgk8dAu2HXLla4ak/BM9X7BwHDvn
 91kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743449928; x=1744054728;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+iRYX/xQalMboqQgAbV2dXOcQ1A27wFDzT4V4vO6Vg=;
 b=Ehr6HNdGc7nLs+LfcnuZphckQncQJe0xk//Z43iAU825YdInP43cOhBOaulS38XAOy
 7ZuoF01UXtHMVS35xfyZZry8ZvwMJVf3hwuwQxnwgab5xTCrMpBbErSkdgDcxqPizuU+
 mS8JOJCKqqwLyncsZdq9aVk92dChdE/Z/5lWEp5wZgNplaoMFTM0jYpxeWAqTTW+r+6T
 XHDMKZKyZFUTjLzPzgY9R/Zx+F/xgA/y8C3COiDjD2NeqpUAxBgnb/4fxyPhdKhqDcXs
 0WSFwaAHl6RY+bzcfV/JeOeLXXVNUwEqBtfl8vTNXlnD/b++sstx0yYCFPEmob0qLYQA
 /1Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoNpLw8pvy9Mnt43Y4JdkwNuTc1XSJW+++4HKJNrgow/Db4AT0eoLbXPxwFxGD8bnpqaf3jEsEnDC6@nongnu.org
X-Gm-Message-State: AOJu0YxILLb/1fzBlgM+l4ycdpRYqqJ0PEMXW6oJPHIVRbgdJB8cWyVa
 RNTEfgC9shXGwxcjIEwEsyaKhRnsWStDAppKwQnrJSQYAV3o9SJq
X-Gm-Gg: ASbGncsGnDhc8QpNXqPebVd74M+6+09FvFiEHKIbte4eD/v3IFEiQwT4488A/gffFyd
 XJiCM2b8VtCWGE9giIpmtvHPTOpRwVMLi9AzDYYgiqmUs1j9aYJvx+J+p+hR8HAGZWjaCLCewn1
 OMcT5y7jgC2afrg4jep+z7lq5SstrfFdCEAD+zDmMsmSN+HYeGRMMFglvZEJmOOIeLi9v6Ne2zE
 6E/CDv6kIMqppDtmoNuAMPrTXPqUDoW+5ZAesjuHUjSCAmAAM3Dw8wsznPE3WTf5N6krIfdYOR5
 NOqxVDVE+5+EY2wkmNGqzSVZUpRiuyA/WDxCJiQ9XBwBw8EbhFwic3GtRq0XrUb9OJvN4EU=
X-Google-Smtp-Source: AGHT+IFwubbp+TUYm6LnGYSydAKGp+TxnqDtCNA8OFUZSc/zaXMKhfdTyYAENma4WqGllcOIM9jtHw==
X-Received: by 2002:a17:902:f54c:b0:224:1ec0:8a1a with SMTP id
 d9443c01a7336-2292fa09394mr124859875ad.51.1743449928273; 
 Mon, 31 Mar 2025 12:38:48 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eec6fb2sm73360115ad.26.2025.03.31.12.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 12:38:47 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 31 Mar 2025 19:38:45 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/9] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Message-ID: <Z-rvRZUTUpT2Kv-S@deb-101020-bm01.eng.stellus.in>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-3-anisa.su887@gmail.com>
 <20250318155624.00006410@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318155624.00006410@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Mar 18, 2025 at 03:56:24PM +0000, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 16:31:29 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > --- a/hw/cxl/i2c_mctp_cxl.c
> > +++ b/hw/cxl/i2c_mctp_cxl.c
> > @@ -46,6 +46,9 @@
> >  /* Implementation choice - may make this configurable */
> >  #define MCTP_CXL_MAILBOX_BYTES 512
> >  
> > +/* Supported FMAPI Cmds */
> > +#define FMAPI_CMD_MAX_OPCODE 0x57
> > +
> >  typedef struct CXLMCTPMessage {
> >      /*
> >       * DSP0236 (MCTP Base) Integrity Check + Message Type
> > @@ -200,7 +203,8 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
> >          if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
> >                msg->command_set < 0x51) &&
> >              !(msg->message_type == MCTP_MT_CXL_FMAPI &&
> > -              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
> > +              msg->command_set >= 0x51 &&
> > +              msg->command_set < FMAPI_CMD_MAX_OPCODE)) {
> 
> Hmm. There is a visibility problem here we should address but probably not
> by introducing a new define.  Maybe we should move the enum from
> cxl-mailbox-utils.c in a precursor patch.
> 
> Jonathan
Thanks for the feedback and review Jonathan.

According to the comment above this condition, "Any command forming part
of the CXL FM-API command set... is valid only with the CXL Fabric
Manager API over MCTP binding (DSP0234)."

From my understanding, this check is to ensure that any message
sent from the FM API command set (0x51 - 0x59) has the MCTP_MT_CXL_FMAPI
binding and all other commands (opcode < 0x51) are are sent with the
MCTP_MT_CXL_TYPE3 binding.

Although I see from r3.2 Table 8-230 CXL Defined FM API Command Opcodes
that commands from sets 0x57-0x59 are prohibited from being implemented
in the MCTP CCI, would it be more correct to change the condition for
FMAPI commands  to msg->command_set < 0x59? Then if/when commands from sets
0x57-0x59 are implemented, if they are implemented according to the spec, they
should not be added to the FM MCTP CCI.

Please correct my understanding if this is incorrect.

Regarding the visibility problem, I intend to move the enum defining all the
opcodes in cxl-mailbox.utils.c to cxl-mailbox.h and including cxl-mailbox.h
in i2c_mctp_cxl.c

Let me know if that is what you intended.

Other than that, I have removed the extraneous TO-DO's from the other
patches and plan to send out v2 with relevant corrections soon.
Hopefully that makes the remaining patches easier for you to review.

Thanks,
Anisa

 
> 
> 
> >              buf->rc = CXL_MBOX_UNSUPPORTED;
> >              st24_le_p(buf->pl_length, len_out);
> >              s->len = s->pos;
> 

