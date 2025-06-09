Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF577C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 14:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOduY-00044W-CZ; Mon, 09 Jun 2025 10:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOduS-00041L-Es
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:55:36 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOduP-0001gk-Pf
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:55:35 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-748435ce7cdso1208646b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749480927; x=1750085727; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D1BFXjumDn37ixRzn3Ccw8SgCrvC5WjM5z9Sv8VE95M=;
 b=Imx8zvQa1bl7YpI78ZwWjGLs9B3NLHxHMdETKQokwnlRnO0GP5oqciR5uqw3NJYNSp
 f4fgTA06CAoalzpLFK/6/MHf4srrhaI9X8EAreyTIH7bNxN0Ob1ca0EvkZJOXnlJtxXB
 1qnGwpstD9tSroB+pjxqDgkhUXMJuTailk/i5K4MDkCAv0MoWEryIRiSK2IICm9EaAFG
 pmnizBf+a4EWHj/VYAIgkW2UXknSKGzKMgjNs9dhtOUtlnivE1yf/74FyvreKKgrLkG7
 QU/4av6JnM3AKgFifqhDSXYCIGBIkV46Q2nS8gVFym+0QIHvZ0jCzqKg8MOOHt5wadwP
 gaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749480927; x=1750085727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D1BFXjumDn37ixRzn3Ccw8SgCrvC5WjM5z9Sv8VE95M=;
 b=b1DvhRFyNrqwE1VIIiwJUAWzhi9LcT7+OU/LmhA1gQsfQjcUsKlsxCa1RJNQIu86sR
 uF8sds26IuQk17mXbaOdyxDO9I8SAmYd8w0WWpfIbVhF+D2MGy1oSCPVQsowj/QaOYIJ
 fa/lxFisgIsUX3Al4DJObmQOnov2wREWLn/ua85xdgdBzTanKJ+r/x3e0hyWNJHo794n
 R3cYwusSIIcKlZU45TnY8BUcMSY/BERouE1Qa56kK/TaZ0sWqdy03H5Zp4LkTxzKBJpp
 cj0G5zhpUTdB3Zw+TGkUsfACvBIUXbmBUyAtfmpLtCzJTSsDYpaMAozNsTo8QLXR62fK
 jkKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5rMp6uoh/gG/DhULYlTxOt+FfFnp0x9YHf7dpHE5ZOfPeru0y+QckIv+icY8ZjfRszE1JKxFDnbOk@nongnu.org
X-Gm-Message-State: AOJu0YzsGGdUF8bWIz8H7qSmvcPczfvDqakNutmnvoMY1R9fKpMRuFmm
 xqAT2MhijrAw/rzB5X3o3PnMZ2VuVuHIlevKCZvhYvmWeTEQTG+aD0LBXJRCk49OfIP4UCCmjN1
 +raIdlZCPANx3iPCDm/USteNTuu8RrsE=
X-Gm-Gg: ASbGncuNHivKIxXMvRJ4os7n2PIb85cCnKr4wQ6K5ZTlEVtqItKfDUJKCIVZbaO88JC
 DVaSheZ4nXgSjzLPb5W5tGsdIHZd+qYr72TxzyhVIjSpbmGIhM/5aWGp/9eCRy2n+6QAysSTMss
 G7zKTrLAQjNi/vCcHumbpUV/rKJIrz+nU=
X-Google-Smtp-Source: AGHT+IGG+GzFGvAtTUjns/qMtuW1ynolpEHEfVg0+FQuPo8Q0TccbdALk45srB2lyKSuRga0Bo+F8UWtLMsrvosgWlE=
X-Received: by 2002:a05:6a00:3ccb:b0:736:73ad:365b with SMTP id
 d2e1a72fcca58-74827e9ca9dmr15791964b3a.14.1749480927302; Mon, 09 Jun 2025
 07:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250608230819.3382527-1-rowanbhart@gmail.com>
 <20250608230819.3382527-4-rowanbhart@gmail.com>
 <20250609135636.22368-1-neither@nut.email>
In-Reply-To: <20250609135636.22368-1-neither@nut.email>
From: Rowan Hart <rowanbhart@gmail.com>
Date: Mon, 9 Jun 2025 07:55:18 -0700
X-Gm-Features: AX0GCFtqAaW11JGn0opG8JbHdrSemVJp7_V5ylEl3IOtyRWjWXwhIqbgOHqN1bQ
Message-ID: <CAE5MsNZG2S2s=bqJ_kAj=p65_mNf7s0UTpAN1vt75iwm2+YD8A@mail.gmail.com>
Subject: Re: [PATCH v9 3/9] plugins: Add enforcement of QEMU_PLUGIN_CB flags
 in register R/W callbacks
To: Julian Ganz <neither@nut.email>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000369a40063724c540"
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000369a40063724c540
Content-Type: text/plain; charset="UTF-8"

>
> However, it should be safe at least for a subset of those callbacks and

I believe there are very valid use-cases for allowing such usage. For
> example, we are currently working on a plugin API exposing traps. In
> those callbacks, users may want to peek at some registers such as
> "ecause" and "tval" (on RISC-V). We certainly will want to do so for the
> use-case we are pushing that API for.
>
> We could add a QEMU_PLUGIN_CB flag parameter to the respective
> registration functions. But since they are not run from translated
> blocks but _outside_ that context, I feel they would just clutter the
> API without introducing any real benefit. That is, if there is no valid
> safety or correctness concern that I'm not aware of.


This makes sense, I think we could just set QEMU_PLUGIN_CB_RW_REGS for
these callbacks if they're always called in a state where the stated
requirements are met (I think they are). This would avoid breaking
compatibility while maintaining the functionality. Same as you, I looked
around and it seems like the vcpu_(init|idle|exit) locations are definitely
okay, I'll check into the tb_trans callback, I'm not entirely sure about it.

--000000000000369a40063724c540
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote gmail_quote_container"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">However, it should be safe at least for a subse=
t of those callbacks and</blockquote><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
I believe there are very valid use-cases for allowing such usage. For<br>
example, we are currently working on a plugin API exposing traps. In<br>
those callbacks, users may want to peek at some registers such as<br>
&quot;ecause&quot; and &quot;tval&quot; (on RISC-V). We certainly will want=
 to do so for the<br>
use-case we are pushing that API for.<br>
<br>
We could add a QEMU_PLUGIN_CB flag parameter to the respective<br>
registration functions. But since they are not run from translated<br>
blocks but _outside_ that context, I feel they would just clutter the<br>
API without introducing any real benefit. That is, if there is no valid<br>
safety or correctness concern that I&#39;m not aware of.</blockquote></div>=
</div><div dir=3D"auto"><div style=3D"color:rgb(80,0,80);font-size:12.8px" =
dir=3D"auto"><div dir=3D"auto"><br></div></div><div dir=3D"auto" style=3D"f=
ont-size:12.8px">This makes sense, I think we could just set QEMU_PLUGIN_CB=
_RW_REGS for these callbacks if they&#39;re always called in a state where =
the stated requirements=C2=A0are met (I think they are). This would avoid b=
reaking compatibility while maintaining the functionality. Same as you, I l=
ooked around and it seems like the vcpu_(init|idle|exit) locations are defi=
nitely okay, I&#39;ll check into the tb_trans callback, I&#39;m not entirel=
y sure about it.</div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
</blockquote></div></div></div>

--000000000000369a40063724c540--

