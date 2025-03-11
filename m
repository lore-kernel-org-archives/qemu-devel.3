Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53907C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 22:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts87u-00071d-3w; Tue, 11 Mar 2025 18:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts87r-00070z-Tj
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 18:31:03 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts87l-0006qi-TM
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 18:31:03 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6dcd4f1aaccso87424176d6.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 15:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741732255; x=1742337055; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUPRe/61C9OzKVIJGC/o/QsV9f6fu7RfKa8NRhw/Nn0=;
 b=Ccfwj63+LlIuAk3JVE3SVPD3/fQfuu7hQTNlsW+2pyw786am9YP5p1Fgof4giVEfcY
 5rlkWhyvOeFls9WaKd5ujbVwTkHa1EMEDPJzb/SjJNgTap2y6vS2DcWs6sHez3MzH1S2
 TvY/2cMjuDKK2ChuFYTgVeXMDIL5bkGtsi199Pb8GFzn9dk4e+OW6BTCQe+an+2gvy1y
 b+WZmas0n5BSn2/7Fd3r3P6RlpchEaXo+GXTZMCmav1oKeivA9h5oppORH6ksN+LMDLY
 E/LOnx8LOC8FbyyWwgTZQLSj/YVTlFJxZkeB6hEfFOfQynXySEXOJOnYeZ3dmoh8n0sO
 WlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741732255; x=1742337055;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUPRe/61C9OzKVIJGC/o/QsV9f6fu7RfKa8NRhw/Nn0=;
 b=AXD/s1APsu3cDU/btpVw/VINnF/RxbFSVMCEacgREC3W9QB3KuKXsKKEbIwTouUeK4
 IFObZ2Qh3Xaz2WrRyNYp8bIaNvEZHJu+S97Wf5W8Uwa3lbiIqtKdT1BLlcBxYOp20yMx
 fX+BWYow98yjQifQpYQlRsmCTlrBhOtWjmBPMfxBbBcSzy9gPfj6u8CyM4dXVZuOyRUh
 ScYgYrxOv+0q7/05RCtQIhJWQXoZQaGbBrTUNekLnciH3gYq+7Pglg9tOVwBZzFDgA8y
 6tJuQ97LSneowx/kkxiTz+nioQzsJiLFAtSBo74xIpL0q1ZwyTRWTOTuLfvPiMSGGX7m
 P5gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4MqmcQABhXF1oV/JjXsOk7h/KR7zzSvYDiL4vZwySZTKbH7HF0VEXyKVRPY29lrVCSRPxsPoZR01u@nongnu.org
X-Gm-Message-State: AOJu0Ywedja0bDLLHIF3T5vrVeSoleQFaLS98ak5xn14P2hNOYS+Lrwp
 pvaFMspbw4lpqsRb5It5uBTe3v52b01+LjeFYTwwayXZ1ksemTSC
X-Gm-Gg: ASbGncv2/H70pe2mztYI7whz8oGddVzAANvvnvd6Ui/b4qRrcfy+Jy/07N/ElKuy3OP
 wrnF4iE6lmjMkz4oAs3zfzExWUx7WgzA/E9jPxwAtCe5v7iW5QHvg/MjhwDd9cVPNqjOj9QOtDy
 gO/4D2n58WZoH1GwqmphxK4pkHjKy2HRbTyIxyEMiRSuM2U7kXpjc5sWCvATIxf0RqO/XvA3jJm
 i9cWO+0303DYboKDuOeo3SX3UavXK5C6aqZur394mQGl2rzvMqfGtw6Jby1keH7HELkqzEU7jOR
 U1MLeSQ33P5p1MpDliFpaxs7NGu6Stk7tN2yMNGZTlSCpK2gmpo1zGB/KCuoVTY=
X-Google-Smtp-Source: AGHT+IELZ2ItYxQpAk6I+xeL8z7Q4gGMIxAwRst49iesZHF+jQ/Tv5B4o9NeTGvNV3QlNF+vJ4/q2A==
X-Received: by 2002:a05:6214:dcf:b0:6e8:f60b:9396 with SMTP id
 6a1803df08f44-6e9006aced4mr252413636d6.29.1741732255532; 
 Tue, 11 Mar 2025 15:30:55 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:a832:3b35:d71f:4119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f71709aesm76559246d6.116.2025.03.11.15.30.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Mar 2025 15:30:54 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-24-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-24-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 23/38] target/hexagon: Add implicit attributes to sysemu
 macros
Date: Tue, 11 Mar 2025 17:30:53 -0500
Message-ID: <009501db92d5$40aa17e0$c1fe47a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgIXBMNutPIx58A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250311-4, 3/11/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 23/38] target/hexagon: Add implicit attributes to sysemu
> macros
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_common.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/target/hexagon/hex_common.py
> b/target/hexagon/hex_common.py index 1e94e1fef5..7b5bb2cd46 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -128,8 +128,13 @@ def calculate_attribs():
>      add_qemu_macro_attrib("fTRAP", "A_IMPLICIT_READS_PC")
>      add_qemu_macro_attrib("fSET_OVERFLOW",
> "A_IMPLICIT_WRITES_USR")
>      add_qemu_macro_attrib("fSET_LPCFG", "A_IMPLICIT_WRITES_USR")
> +    add_qemu_macro_attrib("fLOAD_LOCKED", "A_LLSC")
> +    add_qemu_macro_attrib("fSTORE_LOCKED", "A_LLSC")

I don't see a use of A_LLSC.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


> +    add_qemu_macro_attrib("fCLEAR_RTE_EX", "A_IMPLICIT_WRITES_SSR")
>      add_qemu_macro_attrib("fLOAD", "A_SCALAR_LOAD")
>      add_qemu_macro_attrib("fSTORE", "A_SCALAR_STORE")
> +    add_qemu_macro_attrib("fSET_K0_LOCK", "A_IMPLICIT_READS_PC")
> +    add_qemu_macro_attrib("fSET_TLB_LOCK", "A_IMPLICIT_READS_PC")
>      add_qemu_macro_attrib('fLSBNEW0', 'A_IMPLICIT_READS_P0')
>      add_qemu_macro_attrib('fLSBNEW0NOT', 'A_IMPLICIT_READS_P0')
>      add_qemu_macro_attrib('fREAD_P0', 'A_IMPLICIT_READS_P0')
> --
> 2.34.1



